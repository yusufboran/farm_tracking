import 'package:flutter/material.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/datepicker.dart';
import 'package:haytek/widgets/list_field.dart';

class HomePage extends StatefulWidget {
  List<String> animal_list;
  HomePage({Key? key, required this.animal_list}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

  late DateTime startDate;
  late DateTime finishDate;
  _startDate(value) => setState(() => startDate = value);
  _finishDate(value) => setState(() => finishDate = value);

  @override
  void initState() {
    widget.animal_list.insert(0, "Hepsi");
    super.initState();
    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - 7);
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'Hepsi';
    return Scaffold(
      appBar: AppBar(
        title: Text("Haytek süt takip"),
        actions: [
          IconButton(
            icon: Icon(
              Icons.more_vert,
            ),
            onPressed: () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              DatePicker(date: _startDate, showDate: startDate),
              DatePicker(date: _finishDate, showDate: finishDate),
              ListField(
                  animal_list: widget.animal_list,
                  dropdownValue: dropdownValue),
            ],
          ),

          // Expanded(
          //   child: LineChartPage(_items),
          // ),
        ],
      ),
    );
  }
}
