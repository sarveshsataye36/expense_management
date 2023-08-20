import 'package:flutter/material.dart';
import '../../components/components_title.dart';
import '../../components/custom_drawer.dart';
import '../../components/header.dart';
import '../../data/expense_curd.dart';
import '../../helpers/constant.dart';
const List<String> currency = <String>['₹ Rupee', '\$ Dollar', '€ Euro'];
class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: lightRedBackground,
        drawer: const CustomDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(14),
          child: Column(
            children: [
              // App bar with heading
              const HeaderUi(),
              //
              const SizedBox(
                height: 20,
              ),
              ComponentTitle(title: 'Setting'),
              const SizedBox(
                height: 20,
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Currency'),
                    DropdownButtonExample(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class DropdownButtonExample extends StatefulWidget {
  const DropdownButtonExample({super.key});

  @override
  State<DropdownButtonExample> createState() => _DropdownButtonExampleState();
}

class _DropdownButtonExampleState extends State<DropdownButtonExample> {

  @override
  Widget build(BuildContext context) {
    final expenseCurd = ExpenseCurd();
    String currencyValue = expenseCurd.readCurrency();
    String dropdownValue;
    if (currencyValue == '₹'){
       dropdownValue = currency.first;
    }else if(currencyValue == '\$'){
      dropdownValue = currency[1];
    }else{
      dropdownValue = currency[2];
    }


    return DropdownButton<String>(
      value: dropdownValue,
      elevation: 16,
      style: const TextStyle(color: Colors.deepPurple),
      underline: Container(
        height: 2,
        color: Colors.deepPurpleAccent,
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          expenseCurd.saveCurrency(value!);
          dropdownValue = value!;
        });
      },
      items: currency.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
}