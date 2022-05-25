import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:haytek/entities/data.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/list_screen.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/gauge.dart';
import 'package:haytek/widgets/line_charts.dart';
import 'package:haytek/widgets/my_button.dart';

class HomePage extends StatefulWidget {
  List<MilkQuantity> milkQuantity;
  List<MilkConductivity> milkConductivity;
  List<TrendValue> topTrendQuantity = [];
  List<TrendValue> topTrendConductivity = [];
  List<TrendValue> bottomTrendQuantity = [];
  List<TrendValue> bottomTrendConductivity = [];
  List<Data> high_yield = [];
  List<Data> low_yield = [];
  List<Data> anomaly_list = [];

  var lastDayValue;
  HomePage(
      {required this.milkQuantity,
      required this.milkConductivity,
      required this.topTrendQuantity,
      required this.topTrendConductivity,
      required this.bottomTrendQuantity,
      required this.bottomTrendConductivity,
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
        title: Text(
          "Haytek Süt Takip",
          style: Theme.of(context).appBarTheme.titleTextStyle,
        ),
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
          SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Text("data"),
                IconWidget(
                    widget.lastDayValue["last_day_average"]["milk_quantity"]
                        .substring(0, 5),
                    "ortalama süt.(lt)",
                    "milk"),
                IconWidget(
                    widget.lastDayValue["last_day_average"]["conductivity"]
                        .substring(0, 4),
                    "Ortalama iletkenlik(sg)",
                    "conductivity"),
              ],
            ),
          ),
          SizedBox(
            height: 16,
          ),
          Container(
            color: Colors.white,
            child: Column(
              children: [
                Text("data"),
                IconWidget(
                    widget.lastDayValue["last_highest_data"]["milk_quantity"],
                    "Hayvan iletkenlik(sg)",
                    "best-animal-milk"),
                IconWidget(
                    widget.lastDayValue["last_highest_data"]["conductivity"],
                    "En Verimili hayvan(lt)",
                    "best-animal-conductivity"),
              ],
            ),
          ),
          LineChartPage(
              items: widget.milkQuantity,
              bottomTrend: widget.bottomTrendQuantity,
              topTrend: widget.topTrendQuantity,
              title: "Son 30 Günü Süt Ortalaması"),
          LineChartPage(
              items: widget.milkConductivity,
              bottomTrend: widget.bottomTrendConductivity,
              topTrend: widget.topTrendConductivity,
              title: "Son 30 Günü Süt İletkenlik Ortalaması"),
          SizedBox(
            height: 24,
          ),
          myButton(
              func: press,
              text: "Anomali Görülen Hayvanlar",
              items: widget.anomaly_list,
              context: context),
          myButton(
              func: press,
              text: "Yüksek Verimli Hayvanlar",
              items: widget.high_yield,
              context: context),
          myButton(
              func: press,
              text: "Düşük Verimli Hayvanlar",
              items: widget.low_yield,
              context: context),
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

  Widget IconWidget(value, text, icon) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.asset(
          'assets/icons/$icon.png',
          width: 70,
          height: 50,
        ),
        Text(
          value,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        Gauge(value)
      ],
    );
  }
}
