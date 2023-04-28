import 'package:flutter/material.dart';

class SCTextButton extends StatelessWidget {
  const SCTextButton({
    super.key,
    required this.buttonLabel,
    required this.onPressed,
  });

  final String buttonLabel;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: ButtonStyle(
          backgroundColor: MaterialStatePropertyAll<Color>(
            Theme.of(context).colorScheme.onSurface,
          ),
          shape: MaterialStatePropertyAll<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              )),
          fixedSize: const MaterialStatePropertyAll<Size>(
            Size(107, 34),
          )),
      child: Text(
        buttonLabel,
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}