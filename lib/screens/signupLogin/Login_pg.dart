import 'package:clusters/screens/signupLogin/forgot_password.dart';
import 'package:clusters/screens/signupLogin/signup_page.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/common_helper.dart';
import '../../common/text input.dart';
import '../After_login/home screen.dart';

class LoginPg extends StatefulWidget {
  const LoginPg({super.key});

  @override
  State<StatefulWidget> createState() {
    return LoginScreen();
  }
}

class LoginScreen extends State<LoginPg> {
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false ;









  void process() {





    String uphone = _phone.text;
    String upassword = _password.text;

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true ;
      });
      _database.child('$uphone/password').onValue.listen((event) {
        final Object? dbPassword = event.snapshot.value;

        if (dbPassword == upassword) {
          alertDialog(context, 'login successfully');
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => HomePg(phone: uphone,)),
                  (Route<dynamic> route) => false);
        } else {
          setState(() {
            isLoading = false ;
          });
          alertDialog(context, 'please enter correct password');
        }
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 109.0,
                ),
                const Image(
                  image: AssetImage('assets/images/whitelogo.png'),
                  width: 200.0,
                  height: 200.0,
                ),
                const SizedBox(height: 50.0),
                TxtInput(
                  controller: _phone,
                  hintName: "phone number",
                  inputType: TextInputType.number,
                  notVisi: false,
                ),
                const SizedBox(height: 3.0),
                TxtInput(
                  controller: _password,
                  hintName: "password",
                  inputType: TextInputType.visiblePassword,
                  notVisi: true,
                ),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    process();
                  },
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(341, 45)),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child:  isLoading? const SizedBox(
                    width: 30 ,
                    height: 30,
                    child: CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,strokeWidth: 3,),
                  ):const Text(
                    'login',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),


                
                
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const Forget()));
                  },
                  child: const Text(
                    'forgot password?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
                const Divider(
                  color: Colors.black,
                  indent: 28.0,
                  endIndent: 28.0,
                ),
                const SizedBox(
                  height: 190.0,
                ),
                const Divider(
                  color: Colors.black,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SignUpPage()));
                  },
                  child: const Text(
                    'Don\'t have an account?',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
