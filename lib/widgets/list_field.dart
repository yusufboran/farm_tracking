import 'package:flutter/material.dart';

class ListField extends StatefulWidget {
  String dropdownValue;
  List<String> animal_list;
  ListField({required this.animal_list, required this.dropdownValue});

  @override
  State<ListField> createState() => _ListFieldState();
}

class _ListFieldState extends State<ListField> {
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: widget.dropdownValue,
      icon: const Icon(Icons.arrow_drop_down),
      elevation: 16,
      style: const TextStyle(color: Color(0xff2c2772)),
      underline: Container(
        height: 2,
        color: Color(0xff2c2772),
      ),
      onChanged: (String? newValue) {
        setState(() {
          widget.dropdownValue = newValue!;
          print(widget.dropdownValue);
        });
      },
      items: widget.animal_list.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}
