import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

import '../provider/table_values_provider.dart';
import 'custom_table_cell.dart';
import 'dimension_button.dart';


class TableHeader extends StatefulWidget {
  final String dimension;
  const TableHeader({super.key, required this.dimension});

  @override
  State<TableHeader> createState() => _TableHeaderState();
}

class _TableHeaderState extends State<TableHeader> {
  final border = TableBorder.all(color: Colors.white);
  List<Map<String, dynamic>> tableValues = [];
  List<TableRow> rows = [];

  TextEditingController labelCtrl = TextEditingController();
  TextEditingController actLCtrl = TextEditingController();
  TextEditingController actHCtrl = TextEditingController();

  String dimension = "";
  String label = "";
  double chargeL = 0;
  double chargeH = 0;
  int sr = 0;
  double area = 0;
  double actL = 0;
  double actH = 0;
  double chrL = 0;
  double chrH = 0;
  double handle =0;
  double interlock =0;
  double tBearing =0;
  double glassL = 0;
  double glassH =0;
  double divideVal = 0;


  double onSubmit(String text) {
    String fraction = text;
    double decimal = 0;

    if (fraction.contains('/')) {
      List<String> parts = fraction.split(' ');
      if (parts.length == 2) {
        int whole = int.tryParse(parts[0]) ?? 0;
        List<String> fracParts = parts[1].split('/');
        if (fracParts.length == 2) {
          int numerator = int.tryParse(fracParts[0]) ?? 0;
          int denominator = int.tryParse(fracParts[1]) ?? 1;
          decimal = whole + numerator / denominator;
        }
      }
      return decimal;
    } else {
      decimal = double.tryParse(fraction) ?? 0.0;
      return decimal;
    }
  }

  void addRow() {
    setState(() {
      context.read<TableValuesProvider>().changeTableValues(tableValues);
      actL = onSubmit(actLCtrl.text);
      actH = onSubmit(actHCtrl.text);
      label = labelCtrl.text;
      chargeL = (6 - (actL % 6));
      chargeH = (6 - (actH % 6));
      if (chargeL == 6) {
        chargeL = 0;
      }
      if (chargeH == 6) {
        chargeH = 0;
      }
      sr++;
      chrL = actL + chargeL;
      chrH = actH + chargeH;
      if (dimension == 'inch') {
        handle = actH-1.375;
        interlock = actH-1.375;
        tBearing = (actL-6.25)/2;
        glassL = tBearing + 0.625;
        glassH = actH-3.875;
        divideVal = 144;
      } else {
        handle = actH-34.925;
        interlock = actH-34.925;
        tBearing = (actL-158.75)/2;
        glassL = tBearing + 15.875;
        glassH = actH-98.425;
        divideVal = 92903.04;
      }



      area = ((chrL * chrH ) / divideVal);
      tableValues.add({
        'sr': sr,
        'label':label,
        'actL': actL,
        'actH': actH,
        'chrL': chrL,
        'chrH': chrH,
        'handle':handle,
        'interlock':interlock,
        'tBearing':tBearing,
        'glassL':glassL,
        'glassH':glassH,
        'area': area,
      });
      rows.add(TableRow(
        children: [
          CustomTableCell(text: '$sr'),
          CustomTableCell(text: label),
          CustomTableCell(text: checkWhole(actL)),
          CustomTableCell(text: checkWhole(actH)),
          CustomTableCell(text: '$chrL'),
          CustomTableCell(text: '$chrH'),
          CustomTableCell(text: checkWhole(handle)),
          CustomTableCell(text: checkWhole(interlock)),
          CustomTableCell(text: checkWhole(tBearing)),
          CustomTableCell(text: checkWhole(glassL)),
          CustomTableCell(text: checkWhole(glassH)),
          CustomTableCell(text: checkWhole(area)),
        ],
      ));
    });
  }

  String checkWhole(double value){
    var decimals = value.toString().split('.')[1];
    if(decimals.length<=3){
      return value.toString();
    }
    else{
      return value.toStringAsFixed(3);
    }
  }

  void deleteRow() {
    setState(() {
      context.read<TableValuesProvider>().changeTableValues(tableValues);
      if (sr > 0) {
        sr--;
        tableValues.removeLast();
        rows.removeLast();
      }
    });
  }

  void showTotal() {
    num totalQty = sr;
    num totalArea = 0;
    for (var total in tableValues) {
      totalArea += total['area'];
    }
    String strTotalArea = totalArea.toStringAsFixed(2);
    Alert(
      context: context,
      title: 'Calculated!',
      desc:
      'Net Quantity: $totalQty\nNet Area: $strTotalArea',
      style: const AlertStyle(
        backgroundColor: Color(0x35EB1555),
        descStyle: TextStyle(color: Colors.white),
        titleStyle: TextStyle(color: Colors.white),
        isButtonVisible: false,
      ),
    ).show();
  }

  @override
  void initState() {
    dimension = widget.dimension;
    super.initState();
  }

  @override
  void dispose() {
    actLCtrl.dispose();
    actHCtrl.dispose();
    labelCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    getColumnWidth() {
      if (screenWidth < 450) {
        double multiFactor = 565 / screenWidth;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(64.0 * multiFactor),
          2: FixedColumnWidth(42.0 * multiFactor),
          3: FixedColumnWidth(42.0 * multiFactor),
          4: FixedColumnWidth(42.0 * multiFactor),
          5: FixedColumnWidth(42.0 * multiFactor),
          6: FixedColumnWidth(45.0 * multiFactor),
          7: FixedColumnWidth(45.0 * multiFactor),
          8: FixedColumnWidth(45.0 * multiFactor),
          9: FixedColumnWidth(42.0 * multiFactor),
          10: FixedColumnWidth(42.0 * multiFactor),
          11: FixedColumnWidth(52.0 * multiFactor),
        };
      } else {
        double multiFactor = screenWidth / 565;
        return {
          0: FixedColumnWidth(27.0 * multiFactor),
          1: FixedColumnWidth(64.0 * multiFactor),
          2: FixedColumnWidth(42.0 * multiFactor),
          3: FixedColumnWidth(42.0 * multiFactor),
          4: FixedColumnWidth(42.0 * multiFactor),
          5: FixedColumnWidth(42.0 * multiFactor),
          6: FixedColumnWidth(45.0 * multiFactor),
          7: FixedColumnWidth(45.0 * multiFactor),
          8: FixedColumnWidth(45.0 * multiFactor),
          9: FixedColumnWidth(42.0 * multiFactor),
          10: FixedColumnWidth(42.0 * multiFactor),
          11: FixedColumnWidth(52.0 * multiFactor),
        };
      }
    }

    return Column(
      children: [
        Table(
          columnWidths: getColumnWidth(),
          border: border,
          children: [
            const TableRow(
              children: [
                CustomTableHeader(text: ''),
                CustomTableHeader(text: ''),
                CustomTableHeader(text: 'L'),
                CustomTableHeader(text: 'H'),
                CustomTableHeader(text: 'L'),
                CustomTableHeader(text: 'H'),
                CustomTableHeader(text: ''),
                CustomTableHeader(text: 'Lock'),
                CustomTableHeader(text: 'Bearing'),
                CustomTableHeader(text: 'L'),
                CustomTableHeader(text: 'H'),
                CustomTableHeader(text: 'SQFt.'),
              ],
            ),
            ...rows,
          ],
        ),
        Table(
          columnWidths: getColumnWidth(),
          border: border,
          children: [
            TableRow(
              children: [
                const TableCell(child: SizedBox()),
                CellTxtFieldTxt(controller: labelCtrl),
                CellTxtField(controller: actLCtrl),
                CellTxtField(controller: actHCtrl),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
                const TableCell(child: SizedBox()),
              ],
            ),
          ],
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            DimensionButton(btnTxt: 'Add Row', fun: addRow),
            const SizedBox(width: 10),
            DimensionButton(btnTxt: 'Del Row', fun: deleteRow),
            const SizedBox(width: 10),
            DimensionButton(btnTxt: 'Show TTL', fun: showTotal),
          ],
        ),
      ],
    );
  }
}
