import 'package:flutter/material.dart';
import 'package:vend/constants.dart';
import 'package:vend/screens/Login/components/text_field_container.dart';

class CustomInputFiled extends StatelessWidget {
  final String hintText;
  final Color color;
  final ValueChanged<String> onChanged;
  const CustomInputFiled(
      {Key? key,
      required this.hintText,
      this.color = kPrimaryLighterColor,
      required this.onChanged})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 5),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          filled: true,
          fillColor: color,
          hintText: hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
        ),
      ),
    );
  }
}
