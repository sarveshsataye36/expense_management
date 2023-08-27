import 'package:custom_date_range_picker/custom_date_range_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../components/components_title.dart';
import '../../components/custom_drawer.dart';
import '../../components/header.dart';
import '../../data/expense_data.dart';
import '../../helpers/constant.dart';
class AnalyticDashboard extends StatefulWidget {
  const AnalyticDashboard({super.key});

  @override
  State<AnalyticDashboard> createState() => _AnalyticDashboardState();
}

class _AnalyticDashboardState extends State<AnalyticDashboard> {
  var endDate;
  var startDate;

  // List dateWiseFilterList(){
  //   return Provider.of<ExpenseData>(context, listen: false).dateWiseFilter(startDate,endDate);
  // }
  @override
  Widget build(BuildContext context) {

    return SafeArea(child:  Consumer<ExpenseData>(builder: (context, value, child)=> Scaffold(
      backgroundColor: lightRedBackground,
      drawer: CustomDrawer(),
      body:  Padding(
          padding: EdgeInsets.all(14),
          child: Column(
              children: [
            // App bar with heading
            HeaderUi(),
            //
           SizedBox(
            height: 14,
           ),
            Container(
              padding: EdgeInsets.all(7),
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Date Filter'),
                  TextButton.icon(
                      onPressed: (){
                        showCustomDateRangePicker(
                          context,
                          dismissible: true,
                          minimumDate: DateTime.now().subtract(const Duration(days: 30)),
                          maximumDate: DateTime.now().add(const Duration(days: 30)),
                          endDate: endDate,
                          startDate: startDate,
                          backgroundColor: Colors.white,
                          primaryColor: Colors.blueAccent,
                          onApplyClick: (start, end) {
                            setState(() {
                              endDate = end;
                              startDate = start;
                            });
                          },
                          onCancelClick: () {
                            setState(() {
                              endDate = null;
                              startDate = null;
                            });
                          },
                        );
                      },
                      icon: Icon(Icons.date_range_outlined),
                      label: Text('Select Date')
                  ),
                ],
              ),
            )
          ])),
    )));
  }
}
