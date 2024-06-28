import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {
  CustomElevatedButton({super.key, required this.buttonName, this.onTap});
  final String buttonName;
  VoidCallback? onTap;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 48,
        width: double.infinity,
        child: ElevatedButton(
          onPressed: onTap,
          style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
          child: Text(
            buttonName,
            style: const TextStyle(
                color: Color(0xff284461),
                fontWeight: FontWeight.bold,
                fontSize: 18),
          ),
          
        ));
  }
}
