import 'package:flutter/material.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/background.dart';
import 'package:haytek/widgets/my_button.dart';
import 'package:http/http.dart' as http;

class ForgotPasswordScreen extends StatefulWidget {
  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  TextEditingController username = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: MediaQuery.of(context).size.height * .08,
              right: MediaQuery.of(context).size.width * .87,
              child: Container(
                child: IconButton(
                  icon: Icon(
                    Icons.keyboard_backspace,
                    color: Theme.of(context).colorScheme.primary,
                    size: 36,
                  ),
                  onPressed: () => Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LoginScreen(),
                    ),
                  ),
                ),
              ),
            ),
            background(context),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 40),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .15),
                    Image.asset(
                      'assets/padlock.png',
                      width: 200,
                      height: 200,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Container(
                            margin: EdgeInsets.symmetric(vertical: 20),
                            child: TextField(
                              controller: username,
                              decoration: InputDecoration(
                                  hintText: "Kullanıcı Adı",
                                  prefixIcon: Icon(Icons.mail_outline),
                                  border: InputBorder.none,
                                  fillColor: Color(0xffe9e9e9),
                                  filled: true),
                            )),
                      ],
                    ),
                    SizedBox(height: 20),
                    myButton(
                        func: press,
                        text: "Şifreyi Yenile",
                        items: null,
                        context: context),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void press(items, text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Awesome Snackbar!'),
        action: SnackBarAction(
          label: 'Action',
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            );
          },
        ),
      ),
    );
  }
}
