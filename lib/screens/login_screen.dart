import 'dart:convert';
import 'dart:ffi';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haytek/entities/data.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/screens/forgot_password.dart';
import 'package:haytek/screens/home_screen.dart';
import 'package:haytek/widgets/background.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  List<MilkQuantity> milkQuantity = [];
  List<MilkConductivity> milkConductivity = [];
  List<TrendValue> topTrendQuantity = [];
  List<TrendValue> topTrendConductivity = [];
  List<TrendValue> bottomTrendQuantity = [];
  List<TrendValue> bottomTrendConductivity = [];

  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  bool isHidden = true;
  togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  List<Data> high_yield = [];
  List<Data> low_yield = [];
  List<Data> anomaly_list = [];
  var lastDayValue;
  late DateTime startDate;
  late DateTime finishDate;
  int dayNum = 30;
  @override
  void initState() {
    lastDay();
    animalListQuery();
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - dayNum);
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Background(),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    Image.asset('assets/haytek_logo_dark_blue.png'),
                    SizedBox(height: 60),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 10),
                            child: TextField(
                              controller: username,
                              obscureText: false,
                              decoration: InputDecoration(
                                  hintText: "Kullanıcı Adı",
                                  prefixIcon: Icon(Icons.mail_outline),
                                  border: InputBorder.none,
                                  fillColor: Color(0xfff3f3f4),
                                  filled: true),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: TextField(
                            controller: password,
                            obscureText: isHidden,
                            decoration: InputDecoration(
                                hintText: "Parola",
                                prefixIcon: Icon(Icons.lock),
                                suffixIcon: IconButton(
                                  splashColor: Colors.transparent,
                                  icon: isHidden
                                      ? Icon(Icons.visibility_off)
                                      : Icon(Icons.visibility),
                                  onPressed: togglePasswordVisibility,
                                ),
                                border: InputBorder.none,
                                fillColor: Color(0xfff3f3f4),
                                filled: true),
                            onEditingComplete: () =>
                                TextInput.finishAutofillContext(),
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => {
                        query()
                        // login(username: username, password: password),
                      },
                      child: Container(
                        width: MediaQuery.of(context).size.width,
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
                          'Giriş',
                          style: TextStyle(fontSize: 20, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ForgotPasswordScreen(),
                            ),
                          );
                        },
                        child: Text('Şifremi Unuttum',
                            style: TextStyle(
                                fontSize: 14, fontWeight: FontWeight.w500)),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void login({required username, required password}) async {
    var url = Uri.parse("http://10.220.62.48/mail/query.php");
    var data = {'username': username.text};
    var pass_hash =
        Crypt.sha256(password.text, salt: 'abcdefghijklmnop').toString();
    final response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      print(pass_hash);

      print(datauser[0]["password"]);

      if (pass_hash == datauser[0]["password"]) {
      } else
        print("password is wrong");
    } else {
      print('A network error occurred : login');
    }
  }

  void animalListQuery() async {
    var url = Uri.parse("http://10.220.62.48/mail/animal-list.php");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);

      datauser["high_yield"].forEach(
        (e) {
          high_yield.add(Data(
              dateTime: e["transaction_date"],
              conductivity: double.parse(e["conductivity"]),
              milk_quantity: double.parse(e["milk_quantity"]),
              movement: e["movement"] != null ? int.parse(e["movement"]) : 0,
              animalId: e["animal_id"]));
        },
      );

      datauser["low_yield"].forEach(
        (e) {
          low_yield.add(Data(
              dateTime: e["transaction_date"],
              conductivity: double.parse(e["conductivity"]),
              milk_quantity: double.parse(e["milk_quantity"]),
              movement: e["movement"] != null ? int.parse(e["movement"]) : 0,
              animalId: e["animal_id"]));
        },
      );

      datauser["anomaly_list"].forEach(
        (e) {
          anomaly_list.add(
            Data(
                dateTime: e["transaction_date"],
                conductivity: double.parse(e["conductivity"]),
                milk_quantity: double.parse(e["milk_quantity"]),
                movement: e["movement"] != null ? int.parse(e["movement"]) : 0,
                animalId: e["animal_id"]),
          );
        },
      );
    } else {
      print('A network error occurred : login');
    }
  }

  void lastDay() async {
    var url = Uri.parse("http://10.220.62.48/mail/last-day-data.php");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      lastDayValue = datauser;
    } else {
      print('A network error occurred : login');
    }
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
      datauser["data"].forEach(
        (e) {
          milkQuantity.add(MilkQuantity(
              dateTime: e["transaction_date"],
              varible: double.parse(e["milk_quantity"])));
          milkConductivity.add(MilkConductivity(
              dateTime: e["transaction_date"],
              varible: double.parse(e["conductivity"])));
        },
      );

      datauser["trend"]["trend_milk"]["bottom_trend"].forEach(
        (e) {
          bottomTrendQuantity.add(
              TrendValue(dateTime: e["transaction_date"], varible: e["value"]));
        },
      );
      datauser["trend"]["trend_milk"]["top_trend"].forEach(
        (e) {
          topTrendQuantity.add(
              TrendValue(dateTime: e["transaction_date"], varible: e["value"]));
        },
      );

      datauser["trend"]["trend_conductivity"]["bottom_trend"].forEach(
        (e) {
          bottomTrendConductivity.add(
              TrendValue(dateTime: e["transaction_date"], varible: e["value"]));
        },
      );

      datauser["trend"]["trend_conductivity"]["top_trend"].forEach(
        (e) {
          topTrendConductivity.add(
              TrendValue(dateTime: e["transaction_date"], varible: e["value"]));
        },
      );
    } else {
      print('A network error occurred : home screen query');
    }
    openScren();
  }

  openScren() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => HomePage(
            bottomTrendConductivity: bottomTrendConductivity,
            bottomTrendQuantity: bottomTrendQuantity,
            topTrendConductivity: topTrendConductivity,
            topTrendQuantity: topTrendQuantity,
            milkConductivity: milkConductivity,
            milkQuantity: milkQuantity,
            anomaly_list: anomaly_list,
            high_yield: high_yield,
            low_yield: low_yield,
            lastDayValue: lastDayValue),
      ),
    );
  }
}
