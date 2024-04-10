import 'package:flutter/material.dart';

class SetRatesTxtField extends StatelessWidget {
  final String name1;
  final String name2;
  final TextEditingController controller1;
  final TextEditingController controller2;

  const SetRatesTxtField(
      {super.key,
      required this.controller1,
      required this.controller2,
      required this.name1,
      required this.name2});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller1,
                decoration: InputDecoration(
                    labelText: name1, border: const OutlineInputBorder()),
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.datetime,
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: TextField(
                controller: controller2,
                decoration: InputDecoration(
                    labelText: name2, border: const OutlineInputBorder()),
                style: const TextStyle(fontSize: 14),
                keyboardType: TextInputType.datetime,
              ),
            ),
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
