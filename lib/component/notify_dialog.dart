import 'package:flutter/material.dart';
import 'text_button_app.dart';

class NotifyDialog extends StatefulWidget {
  const NotifyDialog({Key? key, required this.isSuccess,  required this.message}) : super(key: key);
  final bool isSuccess;
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
              widget.isSuccess ? 'Success!' : 'Error!',
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: widget.isSuccess ? Colors.lightGreen : Colors.red),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 5),
            Text(
              widget.message,
              style: const TextStyle(fontSize: 15, color: Colors.black),
              textAlign: TextAlign.center
            ),
            const SizedBox(height: 30),
            Container(
              width: 150,
              child: ElevatedButton(
                  onPressed: () {Navigator.of(context).pop();;},
                  child: Text('OK', style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.blueGrey)
              ),
            )
          ]
        )
      ),
    ));
  }
}