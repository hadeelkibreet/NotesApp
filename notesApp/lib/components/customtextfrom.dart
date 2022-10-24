import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class CustTextFormSign extends StatelessWidget {
  const CustTextFormSign({
    super.key,
    required this.text,
    required this.fixIcon,
    required this.valid,
    required this.type,
    required this.mycontroller,
  });

  final String text;
  final IconData fixIcon;
  final String? Function(String?) valid;
  final TextInputType type;
  final TextEditingController mycontroller;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: TextFormField(
        validator: valid,
        controller: mycontroller,
        keyboardType: type,
        decoration: InputDecoration(
          labelText: text,
          border: OutlineInputBorder(),
          prefixIcon: Icon(fixIcon),
        ),
      ),
      // child: Form(
      //   key: formKey,
      //   child: TextFormField(
      //     decoration: InputDecoration(
      //       label: color,
      //       contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
      //       // hintText: hint,
      //       border: OutlineInputBorder(
      //           borderSide: BorderSide(
      //             color: Colors.black,
      //             width: 1,
      //           ),
      //           borderRadius: BorderRadius.all(Radius.circular(10))),
      //     ),
      //   ),
      // ),
    );
  }
}
