import 'package:flutter/material.dart';

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



