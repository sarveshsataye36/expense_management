import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import '../../components/custom_drawer.dart';
import '../../components/empty_transaction.dart';
import '../../components/expense_tile_analysis.dart';
import '../../components/header.dart';
import '../../data/expense_curd.dart';
import '../../data/expense_data.dart';
import '../../graph/piechart.dart';
import '../../helpers/constant.dart';

class AnalyticDashboard extends StatefulWidget {
  const AnalyticDashboard({super.key});

  @override
  State<AnalyticDashboard> createState() => _AnalyticDashboardState();
}

class _AnalyticDashboardState extends State<AnalyticDashboard> {
   DateTime startDate = DateTime(DateTime.now().year - 1);
   DateTime endDate = DateTime.now();
   final expenseCurd = ExpenseCurd();

  @override
  Widget build(BuildContext context) {
    String showStartDate = '${startDate.day}/${startDate.month}/${startDate.year}';
    String showEndDate = '${endDate.day}/${endDate.month}/${endDate.year}';
    String currentCurrency = expenseCurd.readCurrency();
    return SafeArea(
        child: Consumer<ExpenseData>(
            builder: (context, value, child) => Scaffold(
                  backgroundColor: lightRedBackground,
                  drawer: const CustomDrawer(),
                  body: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(children: [
                        // App bar with heading
                        const HeaderUi(),
                        //
                        const SizedBox(
                          height: 14,
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('Date Filter'),
                              TextButton.icon(
                                  onPressed: () {
                                    showDialog<Widget>(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return Padding(
                                            padding: const EdgeInsets.all(14),
                                            child: SfDateRangePicker(
                                              selectionMode:DateRangePickerSelectionMode.range,
                                              backgroundColor: Colors.white,
                                              showActionButtons: true,
                                              onSubmit: (Object? value) {
                                                if (value is PickerDateRange) {
                                                  setState(() {
                                                    startDate = value.startDate!;
                                                    endDate = value.endDate!;
                                                  });
                                                }
                                                Navigator.pop(context);
                                              },
                                              onCancel: () {
                                                Navigator.pop(context);
                                              },
                                            ),
                                          );
                                        });
                                  },
                                  icon: const Icon(Icons.date_range_outlined),
                                  label: const Text('Select Date')),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(7),
                          color: Colors.white,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$showStartDate  -  $showEndDate'),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(value.dateWiseFilterTransactionTotal(startDate,endDate,'Income').toString() + currentCurrency,
                                      style:GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.displayLarge,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.green
                                      )),
                                  Text('   |   ',
                                      style:GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.displayLarge,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.black
                                      )),
                                  Text(value.dateWiseFilterTransactionTotal(startDate,endDate,'Expense').toString() + currentCurrency,
                                      style:GoogleFonts.lato(
                                          textStyle: Theme.of(context).textTheme.displayLarge,
                                          fontSize: 15,
                                          fontWeight: FontWeight.w500,
                                          fontStyle: FontStyle.normal,
                                          color: Colors.redAccent
                                      )),
                                ],
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: SingleChildScrollView(
                              child: Column(
                            children: [
                              PieChartTotal(
                                  income: value.dateWiseFilterTransactionTotal(startDate,endDate,'Income') == 0.0 ? 1: value.dateWiseFilterTransactionTotal(startDate,endDate,'Income'),
                                  expense: value.dateWiseFilterTransactionTotal(startDate,endDate,'Expense')
                              ),
                              value.dateWiseFilter(startDate,endDate)!.isEmpty
                                  ? const NoTransaction()
                                  : ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: value.dateWiseFilter(startDate,endDate)?.length,
                                itemBuilder: (context, index) => ExpenseTilesAnalysis(
                                  expenseName:value.dateWiseFilter(startDate,endDate)![index].name,
                                  expenseAmount:value.dateWiseFilter(startDate,endDate)![index].amount,
                                  expenseDateTime:value.dateWiseFilter(startDate,endDate)![index].dateTime,
                                  type:value.dateWiseFilter(startDate,endDate)![index].type
                                ),
                              )
                            ],
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ])),
                )));
  }
}
