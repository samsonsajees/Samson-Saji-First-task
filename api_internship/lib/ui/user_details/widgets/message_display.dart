import 'package:flutter/material.dart';

class MessageDisplay extends StatelessWidget {
  final String message;
  final bool isError;

  const MessageDisplay({
    super.key,
    required this.message,
    this.isError = false,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      message,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 16,
        color: isError ? Colors.red : Colors.grey.shade700,
      ),
    );
  }
}