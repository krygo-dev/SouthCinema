import 'package:flutter/material.dart';

class SCTextField extends StatelessWidget {
  const SCTextField({
    super.key,
    required this.controller,
    required this.hint,
    required this.keyboardType,
    required this.obscure,
    required this.isEnabled,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool obscure;
  final bool isEnabled;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: Theme.of(context).textTheme.labelLarge,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        disabledBorder: InputBorder.none,
      ),
      keyboardType: keyboardType,
      showCursor: true,
      obscureText: obscure,
      enabled: isEnabled,
      textAlign: TextAlign.center,
      textAlignVertical: TextAlignVertical.center,
    );
  }
}