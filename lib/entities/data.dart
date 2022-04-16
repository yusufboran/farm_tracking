import 'dart:ffi';

class Data {
  String dateTime;
  double conductivity;
  double milk_quantity;
  String animalId;
  int movement;

  Data(
      {required this.dateTime,
      required this.conductivity,
      required this.milk_quantity,
      required this.animalId,
      required this.movement});
}
