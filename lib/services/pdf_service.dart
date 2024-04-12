import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class PdfService {
  Future<Uint8List> generatePdf(String billName,
      List<Map<String, dynamic>> tableValues, String dimension) async {


    final pdf = pw.Document();
    num totalArea = 0;

    List<pw.Widget> pageWidgets = [];
    final logo =
    (await rootBundle.load("images/logo.png")).buffer.asUint8List();
    final logoArea = pw.Container(
        height: 60,
        decoration: pw.BoxDecoration(border: pw.Border.all()),
        padding: const pw.EdgeInsets.all(2),
        child: pw.Row(
          crossAxisAlignment: pw.CrossAxisAlignment.center,
          children: [
            pw.Container(
                padding: const pw.EdgeInsets.only(right: 2),
                decoration: const pw.BoxDecoration(
                    border: pw.Border(right: pw.BorderSide())),
                child: pw.Image(pw.MemoryImage(logo))),
            pw.Expanded(
                child: pw.Container(
                    padding: const pw.EdgeInsets.all(10),
                    child: pw.Column(
                      children: [
                        pw.Expanded(
                            child: pw.Text("Saraswati Enterprises",
                                style: pw.TextStyle(
                                    fontSize: 18,
                                    fontWeight: pw.FontWeight.bold))),
                        pw.SizedBox(height: 20),
                        pw.Expanded(
                            child: pw.Text(
                                "Address: Plot no. P-13, SUPA MIDC, Tal. Parner, Dist. Ahmednagar, Pincode: 414301",
                                style: const pw.TextStyle(fontSize: 8))),
                        pw.SizedBox(height: 5),
                        pw.Expanded(
                            child: pw.Text(
                                "Mob: 9763572001 | Email: amol.2013.at@gmail.com",
                                style: const pw.TextStyle(fontSize: 8))),
                      ],
                    ))),
          ],
        ));
    final title = pw.Container(
        decoration: const pw.BoxDecoration(
            border: pw.Border(
                right: pw.BorderSide(),
                left: pw.BorderSide(),
                bottom: pw.BorderSide())),
        child: pw.Center(
            child: pw.Text("SLIDING WINDOW CALCULATOR",
                style: pw.TextStyle(
                    fontSize: 11, fontWeight: pw.FontWeight.bold))));
    final title2 = pw.Container(
        decoration: pw.BoxDecoration(
          border: pw.Border.all(),
        ),
        child: pw.Row(
          mainAxisAlignment: pw.MainAxisAlignment.spaceAround,
          children: [
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text("Customer Name: $billName",
                        style: pw.TextStyle(
                            fontSize: 10, fontWeight: pw.FontWeight.bold)))),
            pw.Padding(
                padding: const pw.EdgeInsets.all(2),
                child: pw.Expanded(
                    child: pw.Text(
                        "Date: ${DateTime.now().day}/${DateTime.now().month}/${DateTime.now().year}",
                        style: const pw.TextStyle(fontSize: 10)))),
          ],
        ));

    pw.Padding blankCell() {
      return pw.Padding(padding: const pw.EdgeInsets.all(2));
    }

    pw.Padding textCell(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(child: pw.Text(text, style: const pw.TextStyle(fontSize: 10))));
    }

    pw.Padding textCellBold(String text) {
      return pw.Padding(
          padding: const pw.EdgeInsets.all(2),
          child: pw.Center(
              child: pw.Text(text,
                  style: pw.TextStyle(fontWeight: pw.FontWeight.bold))));
    }

    pw.Table tableHeader() {
      return pw.Table(
        columnWidths: const {
          0: pw.FixedColumnWidth(25.0),
          1: pw.FixedColumnWidth(65.0),
          2: pw.FixedColumnWidth(90.0),
          3: pw.FixedColumnWidth(90.0),
          4: pw.FixedColumnWidth(45.0),
          5: pw.FixedColumnWidth(45.0),
          6: pw.FixedColumnWidth(45.0),
          7: pw.FixedColumnWidth(90.0),
          8: pw.FixedColumnWidth(50.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              textCellBold("Sr"),
              textCellBold("Label"),
              textCellBold("Act Size"),
              textCellBold("Chr Size"),
              textCellBold("Hndl"),
              textCellBold("Inter-"),
              textCellBold("Top"),
              textCellBold("Glass"),
              textCellBold("Area"),
            ],
          ),
        ],
      );
    }

    pw.Table table() {
      List<pw.TableRow> rows = [];
      String checkWhole(double value){
        var decimals = value.toString().split('.')[1];
        if(decimals.length<=3){
          return value.toString();
        }
        else{
          return value.toStringAsFixed(3);
        }
      }
      for (var value in tableValues) {
        totalArea += value["area"];
        rows.add(pw.TableRow(
          children: [
            textCell(value["sr"].toString()),
            textCell(value["label"].toString()),
            textCell(checkWhole(value["actL"])),
            textCell(checkWhole(value["actH"])),
            textCell(value["chrL"].toString()),
            textCell(value["chrH"].toString()),
            textCell(checkWhole(value["handle"])),
            textCell(checkWhole(value["interlock"])),
            textCell(checkWhole(value["tBearing"])),
            textCell(checkWhole(value["glassL"])),
            textCell(checkWhole(value["glassH"])),
            textCell(checkWhole(value["area"])),
          ],
        ));
      }
      return pw.Table(
        columnWidths: {
          0: const pw.FixedColumnWidth(25.0),
          1: const pw.FixedColumnWidth(65.0),
          2: const pw.FixedColumnWidth(45.0),
          3: const pw.FixedColumnWidth(45.0),
          4: const pw.FixedColumnWidth(45.0),
          5: const pw.FixedColumnWidth(45.0),
          6: const pw.FixedColumnWidth(45.0),
          7: const pw.FixedColumnWidth(45.0),
          8: const pw.FixedColumnWidth(45.0),
          9: const pw.FixedColumnWidth(45.0),
          10: const pw.FixedColumnWidth(45.0),
          11: const pw.FixedColumnWidth(50.0),
        },
        border: pw.TableBorder.all(),
        children: [
          pw.TableRow(
            children: [
              blankCell(),
              blankCell(),
              textCellBold("L"),
              textCellBold("H"),
              textCellBold("L"),
              textCellBold("H"),
              blankCell(),
              textCellBold("Lock"),
              textCellBold("B."),
              textCellBold("L"),
              textCellBold("H"),
              textCellBold("SQFt."),
            ],
          ),
          ...rows,
          pw.TableRow(children: [
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            blankCell(),
            textCellBold("TTL"),
            textCellBold(checkWhole(totalArea.toDouble())),
          ]),
        ],
      );
    }
    pageWidgets.add(logoArea);
    pageWidgets.add(title);
    pageWidgets.add(title2);
    pageWidgets.add(tableHeader());
    pageWidgets.add(table());

    pdf.addPage(pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(48),
        build: (pw.Context content) {
          return pageWidgets;
        }));

    return pdf.save();
  }
}
