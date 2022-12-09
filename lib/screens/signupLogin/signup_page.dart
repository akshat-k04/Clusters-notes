import 'package:clusters/common/text%20input.dart';
import 'package:clusters/screens/signupLogin/Login_pg.dart';
import 'package:clusters/screens/signupLogin/security.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../common/common_helper.dart';



class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUp();
  }
}






class SignUp extends State<SignUpPage> {


    final _name = TextEditingController();
    final _dob = TextEditingController();
    final _phone = TextEditingController();
    final _email = TextEditingController();
    final _password = TextEditingController();
    final _confirmPass = TextEditingController();
    final _formKey = GlobalKey<FormState>();

    bool isLoading = false ;
    bool chk = false ; // we use this chk to not show the alert dialog after successfully compleation of account





    @override
  void initState(){
      super.initState();

    }



  signUpProcess() async {
    String uName = _name.text;
    String uDob = _dob.text;
    String uPhone = _phone.text;
    String uEmail = _email.text;
    String uPass  = _password.text;
    String ucPass = _confirmPass.text;


    if (_formKey.currentState!.validate()) {

      setState(() {
        isLoading = true ;
      });

      if (uPass != ucPass) {
        alertDialog(context, 'Password Mismatch');
      }
      else if (uDob[2] != '/' || uDob[5] != '/') {
        alertDialog(context, 'please enter the date in correct format');
      }
      else {
        _formKey.currentState?.save();

        DatabaseReference testRef = FirebaseDatabase.instance.ref();
        testRef.child('$uPhone/phone').onValue.listen((event){
          final Object? dbPhone  = event.snapshot.value ;
          if(dbPhone== uPhone){
            setState(() {
              isLoading = false ;
            });
            if(chk == false){
              alertDialog(context, 'this phone number is already used');
            }

          }
          else{
            chk = true ;
            Navigator.push(
                context,
                MaterialPageRoute(builder: (_) =>Security(phn: uPhone,nme: uName,dbirth: uDob,mal: uEmail,pass: ucPass,),)
            );
            setState(() {
              isLoading = false ;
            });

          }
        });
      }
    }
  }





  @override
  Widget build(BuildContext context) {
      return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark
      ),

        child:Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [


                  const SizedBox(
                    height: 203.0,
                  ),


                  const Text(
                    "Sign Up",
                    style: TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  const SizedBox(height: 40.0),


                  TxtInput(
                      hintName: 'name',
                      controller: _name,
                      notVisi: false,
                      inputType: TextInputType.name),

                  const SizedBox(height: 3.0),

                  TxtInput(
                      hintName: 'DOB e.g. 04/10/2003',
                      controller: _dob,
                      notVisi: false,
                      inputType: TextInputType.datetime),
                  const SizedBox(height: 3.0),


                  TxtInput(
                      hintName: 'Phone',
                      controller: _phone,
                      notVisi: false,
                      inputType: TextInputType.number),


                  const SizedBox(height: 3.0),


                  TxtInput(
                      hintName: 'Email Address',
                      controller: _email,
                      notVisi: false,
                      inputType: TextInputType.emailAddress),
                  const SizedBox(height: 3.0),


                  TxtInput(
                      hintName: 'Password',
                      controller: _password,
                      notVisi: true,
                      inputType: TextInputType.visiblePassword),


                  const SizedBox(height: 3.0),


                  TxtInput(
                      hintName: 'Password again',
                      controller: _confirmPass,
                      notVisi: true,
                      inputType: TextInputType.name),


                  const SizedBox(height: 10.0),


                  ElevatedButton(
                    onPressed: () {
                      signUpProcess();
                    },
                    style: const ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(341, 45)),
                      backgroundColor: MaterialStatePropertyAll(Colors.black),
                    ),
                    child:isLoading? const SizedBox(
                      width: 30 ,
                      height: 30,
                      child: CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,strokeWidth: 3,),
                    ): const Text(
                      'Next',
                      style: TextStyle(
                        fontSize: 17.0,
                      ),
                    ),
                  ),


                  const SizedBox(height: 75.0),
                  const Divider(color: Colors.black,),

                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPg()),
                              (Route<dynamic> route) => false);
                    },

                    child: const Text(
                      'Already have an account?',
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
        ),
      );
    }
  }


