import 'package:flutter/material.dart';
import 'package:haytek/screens/login_screen.dart';
import 'package:haytek/widgets/datepicker.dart';
import 'package:haytek/widgets/search_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List _items = [];

// Fetch content from the json file
  // Future<void> readJson() async {
  //   final String response = await rootBundle.loadString('assets/data.json');
  //   final data = await json.decode(response);
  //   setState(() {
  //     _items = data["items"];
  //   });
  // }
  String search_text = "";
  _search_text(value) => setState(() => search_text = value);

  late DateTime startDate;
  late DateTime finishDate;
  _startDate(value) => setState(() => startDate = value);
  _finishDate(value) => setState(() => finishDate = value);

  @override
  void initState() {
    super.initState();

    final now = DateTime.now();
    finishDate = now;
    startDate = DateTime(now.year, now.month, now.day - 7);
  }

  @override
  Widget build(BuildContext context) {
    String dropdownValue = 'One';
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
            //MainAxisAlignment.center
            children: [
              DatePicker(date: _startDate, showDate: startDate),
              DatePicker(date: _finishDate, showDate: finishDate),
            ],
          ),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: AutocompleteBasicExample(
              search_text: _search_text,
            ),
          ),
          Text(search_text)
          // Expanded(
          //   child: LineChartPage(_items),
          // ),
        ],
      ),
    );
  }
}
