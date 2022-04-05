import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  var func;
  String text;
  MyButton({Key? key, required this.func, required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {
        func(),
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
          text,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }
}
