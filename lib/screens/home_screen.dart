import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/list_detail.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/button.dart';
import 'package:haytek/widgets/datepicker.dart';
import 'package:haytek/widgets/line_charts.dart';
import 'package:haytek/widgets/list_field.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  List<String> animal_list;
  HomePage({Key? key, required this.animal_list}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Milk> _items = [];

  late DateTime startDate;
  late DateTime finishDate;
  String dropdownValue = "Hepsi";

  setDropdownValue(value) => setState(() => dropdownValue = value);
  getDropdownValue() => dropdownValue;
  _startDate(value) => setState(() => startDate = value);
  _finishDate(value) => setState(() => finishDate = value);

  @override
  void initState() {
    widget.animal_list.insert(0, "Hepsi");
    super.initState();
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - 7);
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
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DatePicker(date: _startDate, showDate: startDate),
              DatePicker(date: _finishDate, showDate: finishDate),
              ListField(
                  animal_list: widget.animal_list,
                  setDropdownValue: setDropdownValue,
                  getDropdownValue: getDropdownValue),
            ],
          ),
          SizedBox(height: 20),
          LineChartPage(items: _items),
          MyButton(func: press, text: "Listele")

          // Expanded(
          //   child: Text(_items.toString()),
          // ),
        ],
      ),
    );
  }

  void press() {
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => SecondRoute(
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
          items.add(Milk(
              dateTime: e[
                  "transaction_date"], //DateTime.parse(e["transaction_date"]),
              milk_quantity: double.parse(e["milk_quantity"]),
              conductivity: double.parse(e["conductivity"])));
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
