import 'package:flutter/material.dart';

class ListScreen extends StatelessWidget {
  final List<String> products;
  const ListScreen({Key? key, required this.products}) : super(key: key);

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
