import 'package:flutter/material.dart';

bool checkIfTextFieldsEmpty(List<TextEditingController> controllers) {
  bool isEmpty = false;

  for (var controller in controllers) {
    isEmpty = controller.value.text.isEmpty;

    if (isEmpty) return isEmpty;
  }

  return isEmpty;
}