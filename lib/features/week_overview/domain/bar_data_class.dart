import 'package:polybudget/features/week_overview/domain/individual_bar_class.dart';

class BarData{
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thuAmount;
  final double friAmount;
  final double satAmount;
  final double sunAmount;
  BarData({
    required this.monAmount,
    required this.tueAmount,
    required this.wedAmount,
    required this.thuAmount,
    required this.friAmount,
    required this.satAmount,
    required this.sunAmount,
  });

  List<IndividualBar> barData = [];

  void initBarData(){
    barData = [
      // Monday
      IndividualBar(x: 0, y: monAmount),
      // Tuesday
      IndividualBar(x: 1, y: tueAmount),
      // Wednesday
      IndividualBar(x: 2, y: wedAmount),
      // Thursday
      IndividualBar(x: 3, y: thuAmount),
      // Friday
      IndividualBar(x: 4, y: friAmount),
      // Saturday
      IndividualBar(x: 5, y: satAmount),
      // Sunday
      IndividualBar(x: 6, y: sunAmount),
    ];
  }

}