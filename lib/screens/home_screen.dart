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
  var lastDayValue;
  HomePage(
      {required this.high_yield,
      required this.lastDayValue,
      required this.low_yield,
      required this.anomaly_list});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];

  late DateTime startDate;
  late DateTime finishDate;

  int dayNum = 30;
  @override
  void initState() {
    super.initState();
    print(widget.lastDayValue["last_day_average"]["milk_quantity"]);
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - dayNum);
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
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Text("Son Günün Süt Ortalaması : " +
                    widget.lastDayValue["last_day_average"]["milk_quantity"]),
                Text("Son Günün En Çok Süt Veren Hayvan : " +
                    widget.lastDayValue["last_highest_data"]["milk_quantity"]),
                Text("Son Günün İletkenlik Ortalaması : " +
                    widget.lastDayValue["last_day_average"]["conductivity"]),
                Text("Son Günün En Çok Süt Veren Hayvan iletkenlik : " +
                    widget.lastDayValue["last_highest_data"]["conductivity"]),
              ],
            ),
          ),
          SizedBox(height: 20),
          LineChartPage(
              items: milkQuantity, title: "Son $dayNum Günü Süt Ortalaması"),
          LineChartPage(
              items: milkConductivity,
              title: "Son $dayNum Günü Süt İletkenlik Ortalaması"),
          MyButton(
              func: press,
              text: "Yüksek Verimli Hayvanlar",
              items: widget.high_yield),
          MyButton(
              func: press,
              text: "Düşük Verimli Hayvanlar",
              items: widget.low_yield),
          MyButton(
              func: press,
              text: "Anomali Görülen Hayvanlar",
              items: widget.anomaly_list),
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
    var url = Uri.parse("http://10.220.62.48/mail/query.php");
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
