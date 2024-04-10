import 'package:flutter/material.dart';

class TableValuesProvider extends ChangeNotifier {
  List<Map<String, dynamic>> tableValues = [];

  void changeTableValues(List<Map<String, dynamic>> newTableValues) {
    tableValues = newTableValues;
    notifyListeners();
  }
}
