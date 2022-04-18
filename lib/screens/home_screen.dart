import 'package:flutter/material.dart';
import 'package:haytek/entities/data.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/list_screen.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/line_charts.dart';
import 'package:haytek/widgets/my_button.dart';

class HomePage extends StatefulWidget {
  List<MilkQuantity> milkQuantity;
  List<MilkConductivity> milkConductivity;
  List<Data> high_yield = [];
  List<Data> low_yield = [];
  List<Data> anomaly_list = [];
  var lastDayValue;
  HomePage(
      {required this.milkQuantity,
      required this.milkConductivity,
      required this.high_yield,
      required this.lastDayValue,
      required this.low_yield,
      required this.anomaly_list});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              onPressed: () => exitPopup()),
        ],
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.only(top: 16),
            child: Column(
              children: [
                Text("Son Günün Süt Ortalaması : " +
                    widget.lastDayValue["last_day_average"]["milk_quantity"]
                        .substring(0, 5)),
                Text("Son Günün En Çok Süt Veren Hayvan : " +
                    widget.lastDayValue["last_highest_data"]["milk_quantity"]),
                Text("Son Günün İletkenlik Ortalaması : " +
                    widget.lastDayValue["last_day_average"]["conductivity"]
                        .substring(0, 4)),
                Text("Son Günün En Çok Süt Veren Hayvan iletkenlik : " +
                    widget.lastDayValue["last_highest_data"]["conductivity"]),
              ],
            ),
          ),
          SizedBox(height: 20),
          LineChartPage(
              items: widget.milkQuantity, title: "Son 30 Günü Süt Ortalaması"),
          LineChartPage(
              items: widget.milkConductivity,
              title: "Son 30 Günü Süt İletkenlik Ortalaması"),
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

  exitPopup() {
    showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: Text('Çıkış Yap'),
        content: Text('Çıkış yapmak istediğinize emin misiniz?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('İptal Et'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ),
              );
            },
            child: const Text('Evet'),
          ),
        ],
      ),
    );
  }
}
