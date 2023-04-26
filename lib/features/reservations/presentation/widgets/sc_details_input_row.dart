import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SCDetailsInputRow extends StatelessWidget {
  const SCDetailsInputRow({
    super.key,
    required this.label,
    required this.controller,
    required this.keyboardType,
    this.formatters,
    this.textFieldWidth = 150,
  });

  final String label;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final List<TextInputFormatter>? formatters;
  final double textFieldWidth;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
        ),
        Container(
          width: textFieldWidth,
          height: 16,
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.background,
            borderRadius: BorderRadius.circular(2),
          ),
          child: TextField(
            controller: controller,
            showCursor: true,
            textAlign: TextAlign.center,
            textAlignVertical: TextAlignVertical.center,
            cursorHeight: 14,
            decoration: const InputDecoration(
              border: InputBorder.none,
            ),
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w500,
            ),
            keyboardType: keyboardType,
            inputFormatters: formatters ?? [],
          ),
        ),
      ],
    );
  }
}