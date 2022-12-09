import 'package:clusters/screens/signupLogin/type_pass.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/common_helper.dart';
import '../../common/text input.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<StatefulWidget> createState() {
    return ForgetPassword();
  }
}

class ForgetPassword extends State<Forget> {
  final _phone = TextEditingController();
  final _answer = TextEditingController();
  final DatabaseReference _database = FirebaseDatabase.instance.ref();
  final _formKey = GlobalKey<FormState>();
  bool isLoading = false ;
  void initState() {
    super.initState();
  }

  void process() {
    String uphone = _phone.text;
    String uanswer = _answer.text;
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true ;
      });
      _database
          .child('$uphone/security')
          .onValue
          .listen((event) {
        final Object? dbanswer = event.snapshot.value;

        if (dbanswer == uanswer) {
          alertDialog(context, 'credentials are correct');
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (_) =>
                      type(
                        num: uphone,
                      )));
          setState(() {
            isLoading = false ;
          });
        } else {
          setState(() {
            isLoading = false ;
          });
          alertDialog(context, 'please enter the correct credentials');
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
            child: Center(
              child: Column(
                children: [
                  const SizedBox(
                    height: 162.5,
                  ),
                  const Text(
                    'Find your account',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 20.0,
                  ),
                  const Text(
                    'Enter your number linked to your account.',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  const SizedBox(
                    height: 60.0,
                  ),
                  TxtInput(
                    controller: _phone,
                    hintName: "phone number",
                    inputType: TextInputType.number,
                    notVisi: false,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  const Text(
                    'Q.who is your favourite school teacher?                            ',
                    style: TextStyle(color: Colors.grey),
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TxtInput(
                    controller: _answer,
                    hintName: "answer",
                    inputType: TextInputType.name,
                    notVisi: false,
                  ),
                  const SizedBox(
                    height: 8.0,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      process();
                    },
                    style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(341, 45)),
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child: isLoading? const SizedBox(
                      width: 30 ,
                      height: 30,
                      child: CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,strokeWidth: 3,),
                    ): const Text(
                      'Submit',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
