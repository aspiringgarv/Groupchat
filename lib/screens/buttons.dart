import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  final Color m;
  final void Function() onpressed;
  final String text;
  RoundedButton({required this.m,required this.onpressed,required this.text});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: m,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
         onPressed: onpressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            '$text',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    )
    ;
  }
}