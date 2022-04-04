import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/login_screen.dart';
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
      body: Column(
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
          GestureDetector(
            onTap: () => {
              query(),
            },
            child: Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 60),
              padding: EdgeInsets.symmetric(vertical: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(5)),
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      color: Color.fromRGBO(238, 238, 238, 1),
                      offset: Offset(2, 4),
                      blurRadius: 5,
                      spreadRadius: 2)
                ],
                color: Color(0xff2c2772),
              ),
              child: Text(
                'Ara',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),
          LineChartPage(items: _items),
          Expanded(
            child: Text(_items.toString()),
          ),
        ],
      ),
    );
  }

  void query() async {
    List<Milk> items = [];
    var url = Uri.parse("http://10.220.62.48/mail/query.php");
    var data = {
      'start_date': startDate.toString(),
      'finish_date': finishDate.toString(),
      // 'animal_id':
      //     dropdownValue == "Hepsi" ? "Hepsi" : dropdownValue.toString(),
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
        print(items);
      });
    } else {
      print('A network error occurred');
    }
  }
}
