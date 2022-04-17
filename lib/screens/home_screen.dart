import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:haytek/entities/data.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/list_screen.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/line_charts.dart';
import 'package:haytek/widgets/my_button.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  List<Data> high_yield = [];
  List<Data> low_yield = [];
  List<Data> anomaly_list = [];
  HomePage(
      {Key? key,
      required this.high_yield,
      required this.low_yield,
      required this.anomaly_list})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];

  late DateTime startDate;
  late DateTime finishDate;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - 30);
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
              Icons.exit_to_app,
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
          LineChartPage(items: milkQuantity, title: "Süt Miktarı"),
          LineChartPage(items: milkConductivity, title: "Süt İletkenlik"),

          MyButton(
            func: press,
            text: "Yüksek Verimli Hayvanlar",
            items: widget.high_yield,
          ),

          MyButton(
            func: press,
            text: "Düşük Verimli Hayvanlar",
            items: widget.low_yield,
          ),
          MyButton(
            func: press,
            text: "Anomali Görülen Hayvanlar",
            items: widget.anomaly_list,
          ),

          // Expanded(
          //   child: Text(_items.toString()),
          // ),
        ],
      ),
    );
  }

  void press(items, text) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ListScreen(items: items, text: text),
      ),
    );
  }

  void query() async {
    List<Milk> items = [];
    var url = Uri.parse("http://192.168.111.128/mail/query.php");
    var data = {
      'start_date': startDate.toString(),
      'finish_date': finishDate.toString(),
    };

    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
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
    } else {
      print('A network error occurred : home screen query');
    }
  }
}
