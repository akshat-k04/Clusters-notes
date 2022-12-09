import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/common_helper.dart';
import '../../common/text input.dart';
import 'Login_pg.dart';

class Security extends StatefulWidget {
  var phn = 'aa';
  var nme = 'aa';
  var dbirth = 'aa';
  var mal = 'aa';
  var pass = 'aa';

  Security(
      {super.key,
      required this.phn,
      required this.nme,
      required this.dbirth,
      required this.mal,
      required this.pass});

  @override
  State<StatefulWidget> createState() {
    return Securityquest(
        uPhone: phn, udob: dbirth, uemail: mal, uname: nme, upass: pass);
  }
}

class Securityquest extends State<Security> {
  var uPhone = 'aa';
  var uname = 'aa';
  var udob = 'aa';
  var uemail = 'aa';
  var upass = 'aa';
  final _formKey = GlobalKey<FormState>();
  var isChcked = false;
  bool isLoading = false ;
  Securityquest(
      {required this.uPhone,
      required this.uname,
      required this.udob,
      required this.uemail,
      required this.upass});

  final _answer = TextEditingController();

  addans() async {
    setState(() {
      isLoading = true ;
    });
    DatabaseReference testRef = FirebaseDatabase.instance.ref();
    final setUserData = testRef.child(uPhone);
    setUserData.set({
      'name': uname,
      'dob': udob,
      'phone': uPhone,
      'email': uemail,
      'password': upass,
      'security': _answer.text
    }).catchError(
        (error) => alertDialog(context, 'please mail us this error:- $error'));

    Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const LoginPg()),
        (Route<dynamic> route) => false);
    alertDialog(context, 'you have successfully signed up');
    setState(() {
      isLoading = false ;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: const SystemUiOverlayStyle(
        statusBarColor: Colors.white,
        systemNavigationBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark
    ),

      child:Form(
      key: _formKey,
      child: Scaffold(
        backgroundColor: const Color(0xFFFFFFFF),
        body: SingleChildScrollView(
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 130.0,
                ),
                const Image(
                  image: AssetImage('assets/images/whitelogo.png'),
                  width: 150.0,
                  height: 150.0,
                ),
                const SizedBox(height: 40.0),
                const Text(
                  'Q.who is your favourite teacher?                   ',
                  style: TextStyle(fontSize: 18.0),
                ),
                const SizedBox(height: 10.0),
                TxtInput(
                    hintName: 'answer here ',
                    controller: _answer,
                    notVisi: false,
                    inputType: TextInputType.name),
                const SizedBox(height: 10.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _formKey.currentState?.save();
                      if (isChcked == true) {
                        addans();
                      } else {
                        alertDialog(context,
                            'please click the check box to proceed further');
                      }
                    }
                  },
                  style: const ButtonStyle(
                    fixedSize: MaterialStatePropertyAll(Size(343, 45)),
                    backgroundColor: MaterialStatePropertyAll(Colors.black),
                  ),
                  child:isLoading? const SizedBox(
                    width: 30 ,
                    height: 30,
                    child: CircularProgressIndicator(backgroundColor: Colors.black,color: Colors.white,strokeWidth: 3,),
                  ): const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 17.0,
                    ),
                  ),
                ),
                const SizedBox(height: 280.0),
                Row(
                  children: [
                    const SizedBox(width: 5.0),
                    Checkbox(
                      value: isChcked,
                      onChanged: (bool? value) {
                        setState(() {
                          isChcked = value!;
                        });
                      },
                    ),
                    SizedBox(
                      width: 310.0,
                      height: 50.0,
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(color: Colors.black38)),
                        child: SingleChildScrollView(
                         
                          child: Column(
                            children: const [
                              Center(
                                child: Text('NOTE'),
                              ),
                              Text(
                                  'If you forget both password and security question\'s answer then for the recovery of password you have to varify your details that you enteredon the previous page.'),
                              Text(
                                  'Hence,we request you to please enter correct information'),
                              Text(
                                  'If you mistakenly provide the wrong information then you can go back now and re-correct it.'),
                              Text(
                                  'By clicking the check box we assume that you entered the correct information')
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10.0,),
                const Divider(color: Colors.black,),
                const SizedBox(height: 10.0,),
                 const Text('Support :- kakshat35@gmail.com',)
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }
}
