import 'package:flutter/material.dart';

class DatePicker extends StatefulWidget {
  @override
  State<DatePicker> createState() => _DatePickerState();
  var date;
  DateTime showDate;
  DatePicker({required this.date, required this.showDate});
}

class _DatePickerState extends State<DatePicker> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 44,
            child: ElevatedButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all(Color(0xff2c2772)),
              ),
              onPressed: () {
                _selectDate(context);
              },
              child: Text(
                  "${widget.showDate.day}/${widget.showDate.month}/${widget.showDate.year}"),
            ),
          ),
        ],
      ),
    );
  }

  _selectDate(BuildContext context) async {
    final DateTime? selected = await showDatePicker(
      locale: const Locale('tr'),
      context: context,
      initialDate: widget.showDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2025),
    );
    if (selected != null && selected != widget.date)
      setState(() {
        widget.date(selected);
      });
  }
}
