import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  final List<String> products;
  const SecondRoute({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text('${products[index]}'),
          );
        },
      ),
    );
  }
}
