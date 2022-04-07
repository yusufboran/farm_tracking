import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/list_screen.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/expansion.dart';
import 'package:haytek/widgets/line_charts.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Milk> _items = [];
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];

  late DateTime startDate;
  late DateTime finishDate;
  String dropdownValue = "Hepsi";

  setDropdownValue(value) => setState(() => dropdownValue = value);
  getDropdownValue() => dropdownValue;
  _startDate(value) => setState(() => startDate = value);
  _finishDate(value) => setState(() => finishDate = value);

  int number_of_days = 30;
  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - number_of_days);
    query();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Haytek süt takip"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            ),
          ),
        ],
      ),
      body: ListView(
        children: [
          SizedBox(height: 20),
          LineChartPage(
            items: milkQuantity,
            text: "Son $number_of_days Günün Süt Verileri",
          ),
          LineChartPage(
            items: milkConductivity,
            text: "Son $number_of_days Günün İletkenlik Verileri",
          ),
          MyExpansion(),

          // Expanded(
          //   child: Text(_items.toString()),
          // ),
        ],
      ),
    );
  }

  void open() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ListScreen(
                products: List<String>.generate(500, (i) => "Product List: $i"),
              )),
    );
  }

  void query() async {
    List<Milk> items = [];
    var url = Uri.parse("http://10.220.62.48/mail/query.php");
    var data = {
      'start_date': startDate.toString(),
      'finish_date': finishDate.toString(),
      'animal_id':
          dropdownValue == "Hepsi" ? "Hepsi" : dropdownValue.toString(),
    };

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      print(datauser);
      datauser.forEach(
        (e) {
          milkQuantity.add(MilkQuantity(
              dateTime: e["transaction_date"],
              varible: double.parse(e["milk_quantity"])));
          milkConductivity.add(MilkConductivity(
              dateTime: e["transaction_date"],
              varible: double.parse(e["conductivity"])));
        },
      );
      setState(() {
        _items = items;
      });
    } else {
      print('A network error occurred : home screen query');
    }
  }
}
