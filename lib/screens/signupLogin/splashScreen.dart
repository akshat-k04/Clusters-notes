import 'package:clusters/models/notemodel.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../After_login/home screen.dart';
import 'Login_pg.dart';

class Splash extends StatefulWidget{
  const Splash({super.key});

  @override


  @override
  State<StatefulWidget> createState() {
    return Stte();
  }

}

class Stte extends State<Splash>{
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    nevigate();
  }

  nevigate()async{
    await Future.delayed(const Duration(milliseconds: 1500));
    SharedPreferences sp = await SharedPreferences.getInstance();
    String? number = sp.getString('username') ;
    if(number!= null){
      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => HomePg(phone: number,)),
              (Route<dynamic> route) => false);
    }
    else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>LoginPg()));
    }
  }
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Image(
          image: AssetImage('assets/images/whitelogo.png'),
          width: 200.0,
          height: 200.0,
        ),
      ),
    );
  }

}