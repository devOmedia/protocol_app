import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_state.dart';
import 'package:miicon_protocol/business_logic/filter_attendance_bloc/filter_attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/filter_attendance_bloc/filter_attendance_event.dart';
import 'package:miicon_protocol/business_logic/filter_attendance_bloc/filter_attendance_state.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/widgets/protocol_app_bar.dart';

class AttendanceDetailsScreen extends StatefulWidget {
  const AttendanceDetailsScreen({super.key});

  @override
  State<AttendanceDetailsScreen> createState() =>
      _AttendanceDetailsScreenState();
}

class _AttendanceDetailsScreenState extends State<AttendanceDetailsScreen> {
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

  // _getFilteredMonthList() {
  //   List? filteredMonth = [];
  //   print(joiningMonth);
  //   print(monthList[joiningMonth! - 1]);

  //   for (int i = joiningMonth! - 1; i < 12; i++) {
  //     filteredMonth.add(monthList[i]);
  //     print(filteredMonth[i]);
  //   }
  //   //  return filteredMonth;
  // }

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
    _getUserJoiningData();
    //_getFilteredMonthList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    print(joiningMonth);

    return Scaffold(
      body: BlocConsumer<FilteredAttendanceBloc, FilteredAttendanceState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          return Padding(
            padding: HelperWidgets.athTopPadding,
            child: Column(
              children: [
                ProtocolAppBar(size: size),
                HelperWidgets.spacer(size, 0.02),

                ///attendace history
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Attendance History",
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
                          context
                              .read<FilteredAttendanceBloc>()
                              .add(FilterAttendanceLoadingEvent(
                                id: employeID,
                                month: _getMonthIndex(month!).toString(),
                                year: joiningYear,
                              ));
                        },
                      ),
                    ),
                  ],
                ),

                ///list of attendance
                if (state is FilteredAttendanceInitLoadedState)
                  SizedBox(
                    height: size.height * 0.65,
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: state.attendance.results!.length,
                        itemBuilder: (context, index) {
                          final data = state.attendance.results![index];
                          return Container(
                            height: size.height * 0.1,
                            margin: const EdgeInsets.only(top: 8),
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: KConstColors.cardColor,
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data!.date!,
                                    style: TextStyle(
                                      color: const Color(0xff4271CF),
                                      fontFamily: "bebas Neue",
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                  Text(
                                      "clock in status: ${data.clockinstatus!}"),
                                ],
                              ),
                              subtitle: DefaultTextStyle(
                                style: TextStyle(
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.width * 0.04,
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("clockin: ${data.clockintime}"),
                                    Text("clockout: ${data.clockouttime}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                if (state is FilteredAttendanceLoadedState)
                  SizedBox(
                    height: size.height * 0.65,
                    child: ListView.builder(
                        //shrinkWrap: true,
                        itemCount: state.attendance.results!.length,
                        itemBuilder: (context, index) {
                          final data = state.attendance.results![index];
                          return Container(
                            height: size.height * 0.1,
                            margin: const EdgeInsets.only(top: 8),
                            width: size.width,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8),
                              color: KConstColors.cardColor,
                            ),
                            child: ListTile(
                              title: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    data!.date!,
                                    style: TextStyle(
                                      color: const Color(0xff4271CF),
                                      fontFamily: "bebas Neue",
                                      fontWeight: FontWeight.w400,
                                      fontSize: size.width * 0.045,
                                    ),
                                  ),
                                  Text(
                                      "clock in status: ${data.clockinstatus!}"),
                                ],
                              ),
                              subtitle: DefaultTextStyle(
                                style: TextStyle(
                                  fontFamily: "roboto",
                                  fontWeight: FontWeight.w400,
                                  fontSize: size.width * 0.04,
                                  color: Colors.black,
                                ),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text("clockin: ${data.clockintime}"),
                                    Text("clockout: ${data.clockouttime}"),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
