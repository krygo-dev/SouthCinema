import 'package:flutter/material.dart';
import 'package:south_cinema/core/widgets/sc_text_button.dart';

class SCResultContainer extends StatelessWidget {
  final String text;
  final String buttonLabel;
  final VoidCallback onPressed;

  const SCResultContainer({
    super.key,
    required this.text,
    required this.buttonLabel,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          text,
          style: Theme.of(context).textTheme.labelMedium,
        ),
        const SizedBox(height: 16),
        SCTextButton(
          buttonLabel: buttonLabel,
          onPressed: onPressed,
        ),
      ],
    );
  }
}