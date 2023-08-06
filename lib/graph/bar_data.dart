import 'individual_bar.dart';

class BarData{
  final double sunAmount;
  final double monAmount;
  final double tueAmount;
  final double wedAmount;
  final double thruAmount;
  final double friAmount;
  final double satAmount;

  BarData(this.sunAmount, this.monAmount, this.tueAmount, this.wedAmount, this.thruAmount, this.friAmount, this.satAmount);

  List<IndividualBar> barData = [];

  void initializedBarData(){
    barData = [
      IndividualBar(0, sunAmount ),
      IndividualBar(1, monAmount ),
      IndividualBar(2, tueAmount ),
      IndividualBar(3, wedAmount ),
      IndividualBar(4, thruAmount ),
      IndividualBar(5, friAmount ),
      IndividualBar(6, satAmount ),
    ];
  }
}