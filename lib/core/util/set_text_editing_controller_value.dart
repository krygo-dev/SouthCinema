import 'package:flutter/cupertino.dart';

void setTextEditingControllerValue(TextEditingController controller, String newValue) {
  controller.value = TextEditingValue(
      text: newValue,
      selection: TextSelection.fromPosition(
        TextPosition(offset: newValue.length),
      )
  );
}