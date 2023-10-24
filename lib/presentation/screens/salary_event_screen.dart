import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_bloc.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_event.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_state.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/data/models/salary_model.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class SalaryEventScreen extends StatefulWidget {
  @override
  State<SalaryEventScreen> createState() => _SalaryEventScreenState();
}

class _SalaryEventScreenState extends State<SalaryEventScreen> {
  String dropdownvalue = '2022';
  DateTime? currentTime;

  _getCurrentMonth() {
    return DateFormat.MMMM().format(currentTime!);
  }

  var years = [
    '2022',
    // '2021',
    // '2020',
    // '2019',
    // '2018',
  ];
  String selectedYear = "2022";

  final List<String> monthList = [
    "January",
    "February",
    "March",
    "April",
    "May",
    "June",
    "July",
    "August",
    "September",
    "October",
    "November",
    "December",
  ];
  String selectedMonth = "December";
  String? joinDate;

  String? employeID;
  int? joiningMonth;
  String? joiningYear;

  _getUserJoiningData() async {
    joinDate = await UserInfoDB.getUserJoiningDate();
    employeID = await UserInfoDB.getUserEmployeeIDData();

    ///formate the date data to month and year data

    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(joinDate!);

    joiningMonth = int.parse(DateFormat.M().format(dateTime));
    joiningYear = DateFormat.y().format(dateTime);
    print(joiningMonth.toString());
  }

  _getMonthIndex(String month) {
    switch (month) {
      case "January":
        return 1;
      case "February":
        return 2;
      case "March":
        return 3;
      case "April":
        return 4;
      case "May":
        return 5;
      case "June":
        return 6;
      case "July":
        return 7;
      case "August":
        return 8;
      case "September":
        return 9;
      case "October":
        return 10;
      case "November":
        return 11;
      case "December":
        return 12;
    }
  }

  @override
  void initState() {
    currentTime = DateTime.now();
    _getUserJoiningData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<SalaryEventBloc, SalaryState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: HelperWidgets.athTopPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Salary Event",
                    style: TextStyle(
                      color: const Color(0xff3C3C3C),
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.05,
                    ),
                  ),
                ),
                HelperWidgets.spacer(size, 0.02),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //=================>>> year
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: size.width * 0.3,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: KConstColors.cardColor,
                      ),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                        value: selectedYear,
                        items: years.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                color: Color(0xff777E91),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (year) {
                          setState(() {
                            selectedYear = year.toString();
                          });
                        },
                      ),
                    ),

                    ///==================>> month
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      width: size.width * 0.4,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: KConstColors.cardColor,
                      ),
                      child: DropdownButtonFormField(
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Country',
                        ),
                        value: selectedMonth,
                        items: monthList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                fontFamily: 'Urbanist',
                                color: Color(0xff777E91),
                              ),
                            ),
                          );
                        }).toList(),
                        onChanged: (month) {
                          setState(() {
                            selectedMonth = month.toString();
                          });
                          context.read<SalaryEventBloc>().add(
                                SalaryLoadingEvent(
                                  id: employeID!,
                                  year: "2022",
                                  month: _getMonthIndex(month!).toString(),
                                ),
                              );
                        },
                      ),
                    ),
                  ],
                ),

                const SizedBox(
                  height: 24,
                ),

                const SizedBox(
                  height: 24,
                ),
                //     Expanded(
                //       child: GridView.builder(
                //          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                //   crossAxisCount: 4,
                // ),
                //         primary: false,
                //        // padding: const EdgeInsets.all(16),
                //         itemBuilder: (context, index) {
                //           return Container(
                //             margin: const EdgeInsets.all(8),
                //              decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(8),
                //         color: KConstColors.cardColor,
                //       ),
                //     child: const Center(child: Text("January")),
                //           );
                //         },
                //       ),
                //     ),
                if (state is SalaryLoadedState) salaryCard(size, state.salary),
                if (state is SalaryLoadInitState) salaryCard(size, state.salary)
              ],
            ),
          );
        },
      ),
    );
  }

  SizedBox salaryCard(Size size, SalaryEventModel salary) {
    return SizedBox(
      height: size.height * 0.65,
      child: ListView.builder(
          itemCount: salary.salary!.length,
          itemBuilder: (context, index) {
            final salaryData = salary.salary![index];
            return Container(
              margin: const EdgeInsets.only(bottom: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: KConstColors.cardColor,
              ),
              child: ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text("Attendance Salary"),
                    Text("${salaryData.salary!} tk"),
                  ],
                ),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Date: ${salaryData.date}"),
                    Text("Event: ${salaryData.createdAt}"),
                  ],
                ),
              ),
            );
          }),
    );
  }
}
