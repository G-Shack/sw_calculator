// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:sw_calculator/pages/start_page.dart';
// import 'package:sw_calculator/provider/table_values_provider.dart';
//
//
// void main() {
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         ChangeNotifierProvider(create: (context) => TableValuesProvider())
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//             colorScheme: const ColorScheme.dark(
//                 background: Color(0xFF090d23),
//                 primary: Colors.pinkAccent,
//                 surface: Color(0xFF090d23))),
//         home: const StartPage(),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rod Cutting Optimizer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _stockController = TextEditingController();
  final TextEditingController _ordersController = TextEditingController();
  String _result = '';

  Future<void> _optimize() async {
    final stock = jsonDecode(_stockController.text);
    final orders = jsonDecode(_ordersController.text);

    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/optimize?grinding_margin=2'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode({
        "stock_rods": stock,
        "orders": orders,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        _result = 'Solution: ${data["solution"]}\nTotal Waste: ${data["total_waste"]}';
      });
    } else {
      setState(() {
        _result = 'Error: ${response.body}';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rod Cutting Optimizer'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _stockController,
              decoration: InputDecoration(
                labelText: 'Stock Rods (JSON format)',
              ),
            ),
            TextField(
              controller: _ordersController,
              decoration: InputDecoration(
                labelText: 'Orders (JSON format)',
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _optimize,
              child: Text('Optimize'),
            ),
            SizedBox(height: 20),
            Text(_result),
          ],
        ),
      ),
    );
  }
}
