import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haytek/entities/data.dart';
import 'package:haytek/entities/milk.dart';
import 'package:haytek/widgets/hydrationpool.dart';
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
  int dayNum = 180;
  @override
  void initState() {
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - dayNum);
  }

  final _formPass = GlobalKey<FormState>();
  final _formUser = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    bool passflag;
    bool userflag;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            background(context),
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
                            child: Form(
                              key: _formUser,
                              child: TextFormField(
                                controller: username,
                                obscureText: false,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Lütfen bir kullanıcı adınızı giriniz';
                                  } else if (value.length < 4) {
                                    return "Kullanıcı adı en az 6 karakter olmalıdır";
                                  } else if (value.length > 15) {
                                    return "Kullanıcı adı 15 karakterden uzun olmamalıdır";
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    hintText: "Kullanıcı Adı",
                                    prefixIcon: Icon(Icons.mail_outline),
                                    border: InputBorder.none,
                                    fillColor: Color(0xfff3f3f4),
                                    filled: true),
                              ),
                            )),
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Form(
                            key: _formPass,
                            child: TextFormField(
                              controller: password,
                              obscureText: isHidden,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Lütfen bir parolanızı giriniz';
                                } else if (value.length < 4) {
                                  return "Şifre en az 6 karakter olmalıdır";
                                } else if (value.length > 15) {
                                  return "Şifre 15 karakterden uzun olmamalıdır";
                                }
                                return null;
                              },
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
                          ),
                        )
                      ],
                    ),
                    SizedBox(height: 20),
                    GestureDetector(
                      onTap: () => {
                        passflag = false,
                        userflag = false,
                        if (_formPass.currentState!.validate())
                          {
                            passflag = true,
                          }
                        else
                          {print("_formPass.currentState true")},
                        if (_formUser.currentState!.validate())
                          {
                            userflag = true,
                          }
                        else
                          {print("_formUser.currentState true")},
                        if (passflag && userflag)
                          {
                            login(
                                username: username.text,
                                password: password.text),
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Giriş Yapılıyor')),
                            ),
                          }
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
    var url = Uri.parse("http://proje.yusufboran.com/mail/login.php");

    var bytes1 = utf8.encode(password); // data being hashed
    var hash_pass = sha256.convert(bytes1); // Hashing Process
    print("Digest as hex string: $hash_pass");

    var data = {
      'username': username.toString(),
      'password': hash_pass.toString(),
    };

    var response = await http.post(url, body: data);
    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);

      if (datauser.toString() == "true") {
        print("login successfull");
        lastDay();
        animalListQuery();
        query();
      } else
        print("password is wrong");
    } else {
      print('A network error occurred : login');
    }
  }

  void animalListQuery() async {
    var url = Uri.parse("http://proje.yusufboran.com/mail/animal-list.php");
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
      print('A network error occurred : animalListQuery');
    }
  }

  void lastDay() async {
    var url = Uri.parse("http://proje.yusufboran.com/mail/last-day-data.php");
    final response = await http.get(url);
    if (response.statusCode == 200) {
      var datauser = json.decode(response.body);
      lastDayValue = datauser;
    } else {
      print('A network error occurred : lastDay');
    }
  }

  void query() async {
    List<Milk> items = [];
    var url = Uri.parse("http://proje.yusufboran.com/mail/query.php");
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
      print('A network error occurred : login screen query');
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
