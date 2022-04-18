import 'dart:ffi';

class Milk {
  Milk({
    required this.dateTime,
    required this.varible,
  });
  final String dateTime;
  final double varible;
}

class MilkQuantity extends Milk {
  MilkQuantity({required super.dateTime, required super.varible});
}

class MilkConductivity extends Milk {
  MilkConductivity({required super.dateTime, required super.varible});
}

class TrendValue extends Milk {
  TrendValue({required super.dateTime, required super.varible});
}
