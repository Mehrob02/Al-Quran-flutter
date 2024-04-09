import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
 // final String? text;
  final Widget? preffixIcon;
  final String? Function(String?)? onChanged;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMsg;
  const MyTextField({
   super.key,
    required this.controller,
    required this.hintText,
   required this.obscureText,
   required this.keyboardType,
    this.suffixIcon,
  //  this.text,
    this.onTap,
    this.preffixIcon,
    this.onChanged,
    this.validator,
    this.focusNode, 
    this.errorMsg,
  });
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      obscureText: obscureText,
      focusNode: focusNode,

      onTap: onTap,
      textInputAction: TextInputAction.next,
      keyboardType: keyboardType,
      onChanged: onChanged,
      decoration: InputDecoration(
suffixIcon: suffixIcon,
prefixIcon: preffixIcon,
enabledBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(10),
  borderSide: const BorderSide(color: Colors.transparent)
),
focusedBorder: OutlineInputBorder(
  borderRadius: BorderRadius.circular(20),
  borderSide: const BorderSide(color: Colors.transparent)
),
fillColor: Colors.grey.shade200,
filled: true,
hintText: hintText,
//labelText: text,
hintStyle: TextStyle(color: Colors.grey[500]),
errorText: errorMsg,
      )
    );
  }
  
}