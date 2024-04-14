import 'package:flutter/material.dart';

import 'dimensions_page.dart';


class StartPage extends StatefulWidget {
  const StartPage({super.key});

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  TextEditingController billName = TextEditingController();
  String selectedUnit = "inch";
  Color mmText = Colors.white;
  Color inchText = const Color(0xFF090d23);
  Color inchButton = Colors.amberAccent;
  Color mmButton = const Color(0xFF090d23);

  void setUnit(String unit) {
    if (unit == "inch") {
      selectedUnit = "inch";
      mmText = Colors.white;
      inchText = const Color(0xFF090d23);
      inchButton = Colors.amberAccent;
      mmButton = const Color(0xFF090d23);
    } else {
      selectedUnit = "mm";
      mmText = const Color(0xFF090d23);
      inchText = Colors.white;
      inchButton = const Color(0xFF090d23);
      mmButton = Colors.amberAccent;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sliding Window Calculator"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          reverse: true,
          child: Center(
            child: Column(
              children: [
                ClipRRect(borderRadius: BorderRadius.circular(24), child: Image.asset('gifs/window.gif',
                    width: (MediaQuery.of(context).size.width)-50)),
                const SizedBox(
                  height: 40,
                ),
                const Text(
                  "Select Unit",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 25),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setUnit("inch");
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 90,
                        decoration: BoxDecoration(
                          color: inchButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "inch",
                            style: TextStyle(
                                color: inchText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          setUnit("mm");
                        });
                      },
                      child: Container(
                        height: 45,
                        width: 90,
                        decoration: BoxDecoration(
                          color: mmButton,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Center(
                          child: Text(
                            "mm",
                            style: TextStyle(
                                color: mmText,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Bill',
                      textAlign: TextAlign.center,
                      style:
                      TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(width: 25),
                    SizedBox(
                      width: 200,
                      child: TextField(
                        controller: billName,
                        decoration: const InputDecoration(
                          hintText: "Enter customer name",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  onPressed: () {
                    if (selectedUnit == "inch" && billName.text != "") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DimensionsPage(
                                dimension: selectedUnit,
                                billName: billName.text,
                              )));
                    } else if (selectedUnit == "mm" && billName.text != "") {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DimensionsPage(
                                dimension: selectedUnit,
                                billName: billName.text,
                              )));
                    } else {
                      var emptySnack = const SnackBar(
                        content: Text(
                          'Customer name is empty!',
                        ),
                        behavior: SnackBarBehavior.floating,
                        duration: Duration(seconds: 1, milliseconds: 500),
                      );
                      ScaffoldMessenger.of(context).showSnackBar(emptySnack);
                      FocusManager.instance.primaryFocus?.unfocus();
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xDDEB1555)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: 8.0, bottom: 8.0),
                      child: Text(
                        "PROCEED",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 30,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 12)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
