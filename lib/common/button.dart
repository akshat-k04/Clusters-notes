import 'package:flutter/material.dart';

class ButtonInput extends StatelessWidget{


   ButtonInput({super.key,
     required this.text ,

   });

  String text='user' ;



  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: (){
        },
      style:  const ButtonStyle(
        fixedSize:  MaterialStatePropertyAll(Size(340, 40)),
         backgroundColor: MaterialStatePropertyAll(Colors.orange) ,
      ),
        child: Text(
            text,
          style: const TextStyle(
            fontSize: 17.0,
          ),
        ),
    );
  }



}
