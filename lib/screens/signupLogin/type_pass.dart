import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../common/common_helper.dart';
import '../../common/text input.dart';
import 'Login_pg.dart';

class type extends StatefulWidget {
  type({
    required this.num,
  });
  var num = '0';
  @override
  State<StatefulWidget> createState() {
    return pass(number: num);
  }
}



class pass extends State<type> {
  pass({
    required this.number,
  });

  var number = '0';
  final _newPass = TextEditingController();
  final _newPassAgain = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool isLoading = false ;


  @override
  void process() async {
    String upass = _newPass.text;
    String ucpass = _newPassAgain.text;

    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoading = true ;
      });
      if (upass != ucpass) {
        setState(() {
          isLoading = false ;
        });
        alertDialog(context, 'password not match');
      } else {
        DatabaseReference testRef = FirebaseDatabase.instance.ref();
        final setUserData = testRef.child(number);
        setUserData.update({
          'password': upass,
        }).catchError((error) =>
            alertDialog(context, 'please mail us this error:- $error'));
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => const LoginPg()),
            (Route<dynamic> route) => false);
        alertDialog(context, 'you have successfully changed the password');
        setState(() {
          isLoading = true ;
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
                    height: 250.0,
                  ),
                  const Text(
                    'Create a new password',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.0,
                    ),
                  ),
                  const Divider(
                    color: Colors.black,
                    indent: 60.0,
                    endIndent: 60.0,
                  ),
                  const SizedBox(
                    height: 30.0,
                  ),
                  TxtInput(
                    controller: _newPass,
                    hintName: "new password",
                    inputType: TextInputType.visiblePassword,
                    notVisi: true,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  TxtInput(
                    controller: _newPassAgain,
                    hintName: "password again",
                    inputType: TextInputType.visiblePassword,
                    notVisi: true,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      process();
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
