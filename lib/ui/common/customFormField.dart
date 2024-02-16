import 'dart:ffi';

import 'package:flutter/material.dart';
typedef  Validator = String?Function(String?) ;
class customFormField extends StatelessWidget {
  String label ;
  TextInputType keyboardType ;
  bool secure ;
  Validator? validator;
  TextEditingController? controller ;
 customFormField({required this.label,this.keyboardType=TextInputType.text,this.secure=false
 ,this.validator,this.controller});


  @override
  Widget build(BuildContext context) {
    return TextFormField(
decoration: InputDecoration(
 labelText: label,
),
      keyboardType: keyboardType,
      obscureText: secure,
      validator: validator,
      controller: controller ,
    );
  }
}
