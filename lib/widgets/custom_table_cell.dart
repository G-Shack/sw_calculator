import 'package:flutter/material.dart';

class CustomTableCell extends StatelessWidget {
  final String text;
  const CustomTableCell({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Center(child: Text(text)),
    );
  }
}

class CustomTableHeader extends StatelessWidget {
  final String text;
  const CustomTableHeader({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Center(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold),)),
      ),
    );
  }
}

class CellTxtField extends StatelessWidget {
  final TextEditingController controller;
  const CellTxtField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.datetime,
        ),
      ),
    );
  }
}

class CellTxtFieldTxt extends StatelessWidget {
  final TextEditingController controller;
  const CellTxtFieldTxt({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TableCell(
      child: Padding(
        padding: const EdgeInsets.only(left: 6, right: 6, bottom: 6),
        child: TextField(
          controller: controller,
          keyboardType: TextInputType.text,
        ),
      ),
    );
  }
}


