import 'package:flutter/material.dart';

class LoginError extends StatelessWidget {
  final String message;

  const LoginError({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Error'),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            Navigator.of(context).pop(); // Go back to the previous page
          },
          child: Text('OK'),
        ),
      ],
    );
  }
}
