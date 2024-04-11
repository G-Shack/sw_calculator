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
  List<Map<String, dynamic>> tableValues = [
    {'label':"", 'actL':0.0, 'actH':0.0}
  ];

  String dimension = "";

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
      tableValues.add({'label':"", 'actL':0.0, 'actH':0.0});
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
        tableValues.removeLast();
    });
  }

  void showTotal() {
    num totalQty = tableValues.length+1;
    num totalArea = 0;
    for (var total in tableValues) {
      totalArea += total['actL'];
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
            ...List<TableRow>.generate(tableValues.length, (index){
              String label = index<tableValues.length?tableValues[index]['label']:"";
              double actL = index<tableValues.length?tableValues[index]['actL']:0.0;
              double actH = index<tableValues.length?tableValues[index]['actH']:0.0;
              double chrL=0;
              double chrH=0;
              String getChargeL(){
                double chargeL = (6 - (actL % 6));
                if (chargeL == 6) {
                  chargeL = 0;
                }
                chrL = actL+chargeL;
                return checkWhole(chrL);
              }
              String getChargeH(){
                double chargeH = (6 - (actH % 6));
                if (chargeH == 6) {
                  chargeH = 0;
                }
                chrH = actH+chargeH;
                return checkWhole(chrH);
              }
              String getHandle(){
                double handle = dimension=="inch"?actH-1.375:actH-34.925;
                return checkWhole(handle);
              }
              String getTBearing(){
                double tBearing =dimension=="inch"? (actL-6.25)/2:(actL-158.75)/2;
                return checkWhole(tBearing);
              }
              String getGlassL(){
                double glassL = dimension=="inch"?((actL-6.25)/2) + 0.625:((actL-158.75)/2)+15.875;
                return checkWhole(glassL);
              }
              String getGlassH(){
                double glassH = dimension=="inch"?actH-3.875:actH-98.425;
                return checkWhole(glassH);
              }
              String getArea(){
                double divideValue = dimension=="inch"?144:92903.04;
                double area = ((chrL * chrH ) / divideValue);
                return checkWhole(area);
              }
                return TableRow(
                  children: [
                    TableCell(child: Text((index + 1).toString())),
                    TableCell(child: TextFormField(
                      initialValue: label,
                      keyboardType: TextInputType.text,
                      onChanged: (newValue){
                        setState(() {
                          context.read<TableValuesProvider>().changeTableValues(tableValues);
                          if (index < tableValues.length) {
                            tableValues[index]['label'] = newValue;
                          } else {
                            tableValues.add({'label': newValue});
                          }
                        });
                      },
                    )),
                    TableCell(child: TextFormField(
                      initialValue: actL.toString(),
                      keyboardType: TextInputType.datetime,
                      onChanged: (newValue){
                        setState(() {
                          context.read<TableValuesProvider>().changeTableValues(tableValues);
                          if (index < tableValues.length) {
                            tableValues[index]['actL'] = onSubmit(newValue);
                          } else {
                            tableValues.add({'actL':onSubmit(newValue)});
                          }
                        });
                      },
                    )),
                    TableCell(child: TextFormField(
                      initialValue: actH.toString(),
                      keyboardType: TextInputType.datetime,
                      onChanged: (newValue){
                        setState(() {
                          context.read<TableValuesProvider>().changeTableValues(tableValues);
                          if (index < tableValues.length) {
                            tableValues[index]['actH'] = onSubmit(newValue);
                          } else {
                            tableValues.add({'actH': onSubmit(newValue)});
                          }
                        });
                      },
                    )),
                    TableCell(child: Text(getChargeL())),
                    TableCell(child: Text(getChargeH())),
                    TableCell(child: Text(getHandle())),
                    TableCell(child: Text(getHandle())),
                    TableCell(child: Text(getTBearing())),
                    TableCell(child: Text(getGlassL())),
                    TableCell(child: Text(getGlassH())),
                    TableCell(child: Text(getArea())),
                  ],
                );
            }),
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
