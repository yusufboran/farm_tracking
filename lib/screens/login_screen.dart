import 'dart:convert';
import 'dart:math';
import 'package:crypt/crypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:haytek/screens/home_screen.dart';
import 'package:haytek/widgets/custom_clipper.dart';
import 'package:http/http.dart' as http;

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  late List<String> animal_list_items = [];
  bool isHidden = true;
  togglePasswordVisibility() => setState(() => isHidden = !isHidden);

  @override
  void initState() {
    animal_list_query();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: Container(
                  child: Transform.rotate(
                angle: -pi / 3.5,
                child: ClipPath(
                  clipper: ClipPainter(),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.9,
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.white,
                          Color(0xff14279B),
                        ],
                      ),
                    ),
                  ),
                ),
              )),
            ),
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
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                HomePage(animal_list: animal_list_items),
                          ),
                        ),
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
                        onPressed: () {},
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
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomePage(animal_list: animal_list_items),
          ),
        );
      } else
        print("password is wrong");
    } else {
      print('A network error occurred');
    }
  }

  void animal_list_query() async {
    animal_list_items = [];
    var url = Uri.parse("http://10.220.62.48/mail/query.php");
    var data = {'farm_id': "1"};
    var response = await http.post(url, body: data);

    if (response.statusCode == 200) {
      List datauser = json.decode(response.body);

      setState(() {
        datauser.forEach((e) {
          animal_list_items.add(e["animal_id"].toString());
        });
      });
    } else {
      print('A network error occurred : (query)');
    }
  }
}
