import 'package:flutter/material.dart';

class CustomTextFormSign extends StatelessWidget {
  final String hint;
  final String? Function(String?) valid;
  final TextEditingController mycontroller;
  const CustomTextFormSign(
      {super.key,
      required this.hint,
      required this.mycontroller,
      required this.valid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.symmetric(
            vertical: 8,
            horizontal: 10,
          ),
          hintText: hint,
          border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black,
              width: 1,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}
