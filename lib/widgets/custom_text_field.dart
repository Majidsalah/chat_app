import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  CustomTextField(
      {super.key,
      required this.hint,
      this.onChange,
      this.validation,
      this.isPassword = false,
    
    });
  final String hint;

  Function(String)? onChange;
  
  bool isPassword = false;
  String? Function(String?)? validation;
 
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: isPassword,
      style: const TextStyle(color: Colors.white),
      validator: validation,
      onChanged: onChange,
      decoration: InputDecoration(
      
        errorStyle: const TextStyle(color: Colors.white),
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(8)),
      ),
    );
  }
}
