import 'package:fire_base/utils/extensions.dart';
import 'package:flutter/material.dart';

class DialogWidget extends StatelessWidget {
  const DialogWidget({super.key, required this.content, this.isSuccessDialog = true, required this.onTapOK});

  final String content;
  final bool isSuccessDialog;
  final Function onTapOK;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      icon: isSuccessDialog
          ? const Icon(
              Icons.check_circle,
              color: Colors.green,
              size: 45,
            )
          : const Icon(
              Icons.error,
              color: Colors.red,
              size: 45,
            ),
      content: Text(
        content,
        textAlign: TextAlign.center,
      ),
      actions: [
        MaterialButton(
          onPressed: () {
            onTapOK();
          },
          child: const Text("OK"),
        )
      ],
    );
  }
}
