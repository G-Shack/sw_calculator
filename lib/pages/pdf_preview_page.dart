import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:printing/printing.dart';

class PdfPreviewPage extends StatelessWidget {
  final Uint8List bill;
  final String billName;
  const PdfPreviewPage({super.key, required this.bill, required this.billName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PDF Preview'),
      ),
      body: PdfPreview(
        build: (context) => bill,
        pdfFileName: "$billName.pdf",
      ),
    );
  }
}
