import 'package:flutter/material.dart';

class AllChat extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return StateChat() ;
  }

}

class StateChat extends State<AllChat>{
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children:   [
          Container(
            child: Text('hello'),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.cyan)
            ),
          )
        ],
      ),
    );
  }

}