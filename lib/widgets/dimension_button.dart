import 'package:flutter/material.dart';

class DimensionButton extends StatelessWidget {
  final String btnTxt;
  final void Function()? fun;
  const DimensionButton({super.key, required this.btnTxt, required this.fun});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: MaterialStatePropertyAll(Colors.amberAccent),
            foregroundColor: MaterialStatePropertyAll(Colors.black),
            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))))),
        onPressed: () {
          fun!();
        },
        child: Text(btnTxt));
  }
}
