import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

Future<void> showErrorDialog(
  BuildContext context, {
  required String alertTitle,
  required String alertMessage,
}) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(alertTitle),
        titleTextStyle: Theme.of(context).textTheme.labelLarge!.copyWith(
              color: Theme.of(context).colorScheme.secondary,
            ),
        content: Text(alertMessage),
        contentTextStyle: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.primary,
            ),
        actions: [
          Container(
            height: 35,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onSurface,
              borderRadius: const BorderRadius.all(Radius.circular(10)),
            ),
            child: TextButton(
              onPressed: () => context.pop(),
              child: const Text('Ok'),
            ),
          ),
        ],
        actionsAlignment: MainAxisAlignment.center,
        backgroundColor: Theme.of(context).colorScheme.background,
      );
    },
  );
}
