import 'package:flutter/material.dart';

class NotifyDialog extends StatefulWidget {
  const NotifyDialog({Key? key, required this.message}) : super(key: key);
  final String message;

  @override
  _NotifyDialogState createState() => _NotifyDialogState();
}

class _NotifyDialogState extends State<NotifyDialog> {

  @override
  Widget build(BuildContext context) {
    return Dialog( child: Container(
      padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
      child: IntrinsicHeight(
        child: Column(
          children: [
            Text(
              widget.message,
              style: const TextStyle(fontSize: 20, color: Colors.blueGrey),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom( backgroundColor: Colors.blueAccent),
              child: const Text('OK', style: TextStyle(color: Colors.black)),
            )
          ]
        )
      ),
    ));
  }
}