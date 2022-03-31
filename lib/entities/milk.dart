import 'dart:ffi';

class Milk {
  Milk({
    required this.dateTime,
    required this.milk_quantity,
    required this.conductivity,
  });
  final String dateTime;
  final double milk_quantity;
  final double conductivity;
}
