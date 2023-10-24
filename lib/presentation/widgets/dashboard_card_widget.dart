import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/data/models/user.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class DeshboardCardWidget extends StatefulWidget {
  const DeshboardCardWidget({
    Key? key,
    required this.size,
    required this.dayOfWeak,
    required this.dateTimeString,
    required this.attendance,
    required this.info,
  }) : super(key: key);

  final Size size;
  final String? dayOfWeak;
  final String? dateTimeString;
  final Result attendance;
  final UserAdditionalInfo info;

  @override
  State<DeshboardCardWidget> createState() => _DeshboardCardWidgetState();
}

class _DeshboardCardWidgetState extends State<DeshboardCardWidget> {
  Timer? _timer;
  String? workDuration = "00:00:00";
  DateTime? currentTime;

  Widget _clockInTimeStatus(int time) {
    if (time <= 10 && time >= -10) {
      return const Text(
        "In Time",
        style: TextStyle(
          color: Color(0xff30B900),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else if (time >= 10) {
      return const Text(
        "Early",
        style: TextStyle(
          color: Color.fromARGB(255, 239, 161, 26),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else if (time <= -120) {
      return const Text(
        "Absent",
        style: TextStyle(
          color: Color(0xffFF395D),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return const Text(
        "Late",
        style: TextStyle(
          color: Color(0xffFF395D),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  Widget _clockOutTimeStatus(int time) {
    if (time == 0) {
      return const Text(
        "In Time",
        style: TextStyle(
          color: Color(0xff30B900),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else if (time < 0) {
      return const Text(
        "Early",
        style: TextStyle(
          color: Color.fromARGB(255, 239, 161, 26),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else {
      return const Text(
        "Late",
        style: TextStyle(
          color: Color(0xffFF395D),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  _isAbsentStatus(String? clockintime, String reportTime,
      String lastRepotingTime, String earliesttimetogiveattendance) {
    //converting last Repost time to int
    int lastreposthoure = int.parse(lastRepotingTime.split(":")[0]);
    String lreminuteString = lastRepotingTime.split(":")[1].contains("AM")
        ? lastRepotingTime.split(":")[1].split(" AM")[0]
        : lastRepotingTime.split(":")[1].split(" PM")[0];
    int lrclockminute = int.parse(lreminuteString);

    //converting earliest report time to int
    int reporthoure = int.parse(earliesttimetogiveattendance.split(":")[0]);
    String rminuteString =
        earliesttimetogiveattendance.split(":")[1].contains("AM")
            ? earliesttimetogiveattendance.split(":")[1].split(" AM")[0]
            : earliesttimetogiveattendance.split(":")[1].split(" PM")[0];
    int repostminute = int.parse(rminuteString);

//if clockin time is not null then clock time will show
//else if current time is morethen or 12 then absent
    if (clockintime != null) {
      return false;
    } else {
      final currentHour = DateFormat.jm().format(DateTime.now()).split(":")[0];
      final currentHourInt = int.parse(currentHour);

      if (currentHourInt <= lastreposthoure) {
        if (currentHourInt <= reporthoure) {
          return true;
        }
      }
      return false;
    }
  }

  ///calculating the total working durations
  _getWorkingHoureDurations(
    String clockintime,
    String date,
    String? clockouttime,
    bool? isOut,
  ) {
    DateTime dateTime =
        DateFormat("yyyy-MM-dd h:mm a").parse("$date $clockintime");

    final currentTime = DateFormat("yyyy-MM-dd").format(DateTime.now());

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        workDuration =
            DateTime.now().difference(dateTime).toString().split(".")[0];
      });
      if (clockouttime != null && isOut!) {
        DateTime clockoutDateTime =
            DateFormat("yyyy-MM-dd h:mm a").parse("$date $clockouttime");
        timer.cancel();
        workDuration =
            clockoutDateTime.difference(dateTime).toString().split(".")[0];
      }
    });

    return workDuration;

    // if (clockouttime != null) {
    //   workDuration =
    //       clockoutDateTime.difference(dateTime).toString().split(".")[0];
    // }
  }

  _getTimer(String? breakStart, String? breakEnd, String? cin, String? cout,
      String? date, String? breakDurationFromApi) {
    String? workDuration;
    String? breakDuration;

    ///convert cin string to cin datetime obj.
    DateTime cinDateTime = DateFormat("yyyy-MM-dd h:mm a").parse("$date $cin");

    if (breakStart == null) {
      if (cout != null) {
      } else {
        workDuration =
            DateTime.now().difference(cinDateTime).toString().split(".")[0];
      }
    } else {
      ///converting break  time to datetime obj.
      DateTime breakStartDateTime =
          DateFormat("yyyy-MM-dd h:mm a").parse("$date $breakStart");
      DateTime breakEndDateTime =
          DateFormat("yyyy-MM-dd h:mm a").parse("$date $breakEnd");

      ///calculating work duration from cin to break start time.
      workDuration = breakStartDateTime.difference(cinDateTime).toString();
      breakDuration = DateTime.now().difference(breakStartDateTime).toString();
      if (breakEnd == null) {
        breakDuration = breakDurationFromApi;
      }
    }
  }

  ///=======>>>> break durations
  String? currentBreakDuration = "00:00:00";
  _getBreakTime(String? date, String startTime) {
    //  currentBreakDuration = "00:00:00";
    DateTime startDateTime =
        DateFormat("yyyy-MM-dd h:mm a").parse("$date $startTime");

    _timer = Timer.periodic(const Duration(seconds: 2), (timer) {
      setState(() {
        currentBreakDuration =
            DateTime.now().difference(startDateTime).toString().split(".")[0];
      });
    });
    return currentBreakDuration;
  }

  _wordDurationWidget() {
    if (widget.attendance.clockintime != null) {
      return Text(
        _getWorkingHoureDurations(
          widget.attendance.clockintime!,
          widget.attendance.date!,
          widget.attendance.clockouttime,
          widget.attendance.isOut,
        ),
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: widget.size.width * 0.05,
        ),
      );
    } else {
      return Text(
        "00:00",
        style: TextStyle(
          fontWeight: FontWeight.w700,
          fontSize: widget.size.width * 0.05,
        ),
      );
    }
  }

  @override
  void initState() {
    currentTime = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _timer!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // if (widget.attendance.clockintime != null) {
    //   _getWorkingHoureDurations(widget.attendance.clockintime!,
    //       widget.attendance.date!, widget.attendance.clockouttime);
    // }
    return Column(
      children: [
        Container(
          height: widget.size.height * 0.2,
          width: widget.size.width,
          decoration: const BoxDecoration(
            color: KConstColors.secondaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30),
              topRight: Radius.circular(30),
            ),
          ),
          child: DefaultTextStyle(
            style: TextStyle(
              fontFamily: "quicksand",
              fontWeight: FontWeight.w700,
              color: Colors.white,
              fontSize: widget.size.width * 0.05,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome back, ${widget.info.name}!"),
                HelperWidgets.spacer(widget.size, 0.02),
                Text(
                  "Today's ${widget.dayOfWeak},",
                  style: TextStyle(
                    fontSize: widget.size.width * 0.045,
                  ),
                ),
                Text(
                  widget.dateTimeString!,
                  style: TextStyle(
                    fontSize: widget.size.width * 0.045,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          height: widget.size.height * 0.10,
          width: widget.size.width,
          padding: EdgeInsets.only(top: widget.size.height * 0.02),
          decoration: const BoxDecoration(
            color: KConstColors.cardColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(30),
              bottomRight: Radius.circular(30),
            ),
          ),

          ///=======================>>>>>
          child: _isAbsentStatus(
                  widget.attendance.clockintime,
                  widget.info.officeStartTime!,
                  widget.info.lastTimeToGiveAttendance!,
                  widget.info.earliesttimetogiveattendance!)
              ? Center(
                  child: Text(
                    "ABSENT",
                    style: TextStyle(
                      color: const Color(0xffFF395D),
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w600,
                      fontSize: widget.size.width * 0.06,
                    ),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    DefaultTextStyle(
                      style: TextStyle(
                        color: const Color(0xff4271CF),
                        fontFamily: "bebas Neue",
                        fontWeight: FontWeight.w400,
                        fontSize: widget.size.width * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ///=====================>>> clock in time
                          const Text('Time in'),
                          if (widget.attendance.clockintime != null)
                            Text(
                              "${widget.attendance.clockintime}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: widget.size.width * 0.04,
                              ),
                            )
                          else
                            Text(
                              "00:00",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: widget.size.width * 0.04,
                              ),
                            ),
                          // clock in time status
                          if (widget.attendance.ontimeclockin != null)
                            Row(
                              children: [
                                const Text("status: "),
                                _clockInTimeStatus(
                                    widget.attendance.ontimeclockin!),
                              ],
                            )
                        ],
                      ),
                    ),
                    DefaultTextStyle(
                      style: TextStyle(
                        color: const Color(0xff4271CF),
                        fontFamily: "bebas Neue",
                        fontWeight: FontWeight.w400,
                        fontSize: widget.size.width * 0.04,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          if (!widget.attendance.isOut!)
                            const Text('Work Durations'),
                          //======================>>> work durations
                          if (!widget.attendance.isOut!) _wordDurationWidget(),

                          ///=====================>>> break durations
                          if (widget.attendance.isOut!)
                            const Text(
                              'Break Durations',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 132, 78, 11)),
                            ),
                          if (widget.attendance.isOut!)
                            Text(
                              _getBreakTime(
                                widget.attendance.date!,
                                widget.attendance.clockouttime!,
                              ),
                              style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: widget.size.width * 0.05,
                                  color:
                                      const Color.fromARGB(255, 132, 78, 11)),
                            )

                          // if (attendance.ontimeclockout != null)
                          //   Row(
                          //     children: [
                          //       const Text("Status: "),
                          //       _clockOutTimeStatus(attendance.ontimeclockout!),
                          //     ],
                          //   )
                          // Text(
                          //     "Status: ${_clockInTimeStatus(attendance.ontimeclockout!)}")
                        ],
                      ),
                    ),
                  ],
                ),
        )
      ],
    );
  }
}
