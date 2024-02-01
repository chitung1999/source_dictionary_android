import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Function(bool) onClick;

  const CustomButton({Key? key, required this.onClick}) : super(key: key);

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool _isEng = true;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        style: ElevatedButton.styleFrom(backgroundColor: Colors.white),
        onPressed: () {
          setState(() {_isEng = !_isEng;});
          widget.onClick(_isEng);
        },
        child: Text((_isEng ? 'EN' : 'VN'))
    );
  }
}