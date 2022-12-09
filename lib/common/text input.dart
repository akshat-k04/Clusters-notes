import 'package:flutter/material.dart';

import 'common_helper.dart';

class TxtInput extends StatelessWidget {
  TextEditingController? controller;

  TextInputType inputType = TextInputType.name;
  String hintName = 'user';

  bool notVisi = false;

  TxtInput({
    super.key,
    required this.hintName,
    required this.controller,
    required this.inputType,
    required this.notVisi,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 0.0),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: inputType,
        obscureText: notVisi,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter $hintName';
          }
          if (hintName == 'Email Address' && !validateEmail(value)) {
            return 'Please Enter Valid Email';
          }
          if (hintName == 'Phone' && !validatePhone(value)) {
            return 'Please Enter Valid phone number';
          }
          return null;
        },

        decoration: InputDecoration(

          focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(

              color: Colors.black,
            )
          ),
          border:    const OutlineInputBorder(

            borderRadius: BorderRadius.all(
              Radius.circular(5.0),
            ),

          ),




          hintText: 'Enter your $hintName',
          hintStyle: const TextStyle(
            color: Colors.black38,
          ),
          filled: true,
          fillColor: const Color(0xFFF1F1F1),
        ),

      ),
    );
  }
}
