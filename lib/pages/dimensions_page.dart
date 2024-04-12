import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sw_calculator/pages/pdf_preview_page.dart';

import '../provider/table_values_provider.dart';
import '../services/pdf_service.dart';
import '../widgets/table_header.dart';
import '../widgets/table_template.dart';


class DimensionsPage extends StatelessWidget {
  final String billName;
  final String dimension;
  DimensionsPage({super.key, required this.dimension, required this.billName});
  final PdfService pdfService = PdfService();
  @override
  Widget build(BuildContext context) {
    return Consumer<TableValuesProvider>(builder: (context, provider, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Dimension ($dimension)'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Customer Name: $billName',
                      style: const TextStyle(fontSize: 18)),
                  const SizedBox(height: 10),
                  TableTemplate(dimension: dimension),
                  TableHeader(dimension: dimension),
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            var tableValues = provider.tableValues;
            final bill =
                await pdfService.generatePdf(billName, tableValues, dimension);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => PdfPreviewPage(
                  bill: bill,
                  billName: billName,
                ),
              ),
            );
          },
          child: const Icon(Icons.save),
        ),
      );
    });
  }
}
