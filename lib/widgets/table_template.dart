import 'package:flutter/material.dart';

import 'custom_table_cell.dart';


class TableTemplate extends StatelessWidget {
  final String dimension;
  const TableTemplate({super.key, required this.dimension});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    getColumnWidth() {
      if (screenWidth < 450) {
        double multiFactor = 565 / screenWidth;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(64.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(84.0 * multiFactor),
          4: FixedColumnWidth(45.0 * multiFactor),
          5: FixedColumnWidth(45.0 * multiFactor),
          6: FixedColumnWidth(45.0 * multiFactor),
          7: FixedColumnWidth(84.0 * multiFactor),
          8: FixedColumnWidth(52.0 * multiFactor),
        };
      } else {
        double multiFactor = screenWidth / 565;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(64.0 * multiFactor),
          2: FixedColumnWidth(84.0 * multiFactor),
          3: FixedColumnWidth(84.0 * multiFactor),
          4: FixedColumnWidth(45.0 * multiFactor),
          5: FixedColumnWidth(45.0 * multiFactor),
          6: FixedColumnWidth(45.0 * multiFactor),
          7: FixedColumnWidth(84.0 * multiFactor),
          8: FixedColumnWidth(52.0 * multiFactor),
        };
      }
    }

    return Table(
      columnWidths: getColumnWidth(),
      border: const TableBorder(verticalInside: BorderSide(color: Colors.white), left: BorderSide(color: Colors.white), right: BorderSide(color: Colors.white), top: BorderSide(color: Colors.white)),
      children: const [
        TableRow(
          children: [
            CustomTableHeader(text: 'Sr.'),
            CustomTableHeader(text: 'Label'),
            CustomTableHeader(text: 'Act Size'),
            CustomTableHeader(text: 'Chr Size'),
            CustomTableHeader(text: 'Handle'),
            CustomTableHeader(text: 'Inter-'),
            CustomTableHeader(text: 'Top'),
            CustomTableHeader(text: 'Glass'),
            CustomTableHeader(text: 'Area'),
          ],
        ),
      ],
    );
  }
}
