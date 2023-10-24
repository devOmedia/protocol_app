import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class AttendanceCardWidget extends StatelessWidget {
  const AttendanceCardWidget({
    Key? key,
    required this.size,
    required this.dayOfWeak,
    required this.date,
    required this.month,
    required this.attendance,
  }) : super(key: key);

  final Size size;
  final String? dayOfWeak;
  final String? date;
  final String? month;
  final Result attendance;

  _totalBreakTime() {
    if (attendance.breaksset!.isNotEmpty) {
      final length = attendance.breaksset!.length;
      int totalBreak = 0;
      for (int i = 0; i < length; i++) {
        totalBreak += attendance.breaksset![i]!.breakduration!;
      }
      return totalBreak;
    }
    return 0;
  }

  _getAttendanceDateFormater(String dateString) {
    DateTime dateTime = DateFormat("yyyy-MM-dd").parse(dateString);
    final day = DateFormat.EEEE().format(dateTime);
    final date = DateFormat.d().format(dateTime);
    final month = DateFormat.MMMM().format(dateTime);

    return "$day $date/$month";
  }

  ///present status
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
      //age aschi
    } else if (time > 10) {
      return const Text(
        "Early",
        style: TextStyle(
          color: Color.fromARGB(255, 239, 161, 26),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
      //pore aschi
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
        "Absent",
        style: TextStyle(
          color: Color(0xffFF395D),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    }
  }

  Widget _clockOutTimeStatus(int time) {
    //+ hole pore
    //- hole age
    if (time >= -10 && time <= 10) {
      return const Text(
        "In Time",
        style: TextStyle(
          color: Color(0xff30B900),
          fontFamily: "roboto",
          fontWeight: FontWeight.w400,
        ),
      );
    } else if (time < -10) {
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

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height * 0.13,
      width: size.width,
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: KConstColors.cardColor,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Attendance",
                style: TextStyle(
                  fontFamily: "urbanist",
                  fontWeight: FontWeight.w700,
                  color: const Color(0xff3C3C3C),
                  fontSize: size.width * 0.04,
                ),
              ),
              Row(
                children: [
                  Icon(
                    Icons.calendar_month_outlined,
                    size: size.width * 0.045,
                    color: const Color(0xff4271CF),
                  ),
                  SizedBox(
                    width: size.width * 0.01,
                  ),
                  Text(
                    _getAttendanceDateFormater(attendance.date!),
                    //"$dayOfWeak $date/$month",
                    style: TextStyle(
                      fontFamily: "roboto",
                      fontWeight: FontWeight.w400,
                      fontSize: size.width * 0.035,
                    ),
                  )
                ],
              ),
            ],
          ),
          HelperWidgets.spacer(size, 0.01),

          ///=====================>>>
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: "roboto",
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.035,
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Clock in ${attendance.clockintime}"),
                    SizedBox(
                      width: size.width * 0.01,
                    ),
                    _clockInTimeStatus(attendance.ontimeclockin!),
                  ],
                ),
                Text("Total Break: ${_totalBreakTime()} Mins")
              ],
            ),
          ),
          HelperWidgets.spacer(size, 0.01),
          DefaultTextStyle(
            style: TextStyle(
              fontFamily: "roboto",
              fontWeight: FontWeight.w400,
              fontSize: size.width * 0.035,
              color: Colors.black,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                //===================>>> clock out time.
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.start,
                //   mainAxisSize: MainAxisSize.min,
                //   children: [
                //     if (!attendance.isOut!)
                //       Text("Clock out: ${attendance.clockouttime ?? " _:_"}")
                //     else
                //       Text("Clock out: ${attendance.clockouttime ?? " _:_"}"),
                //     SizedBox(
                //       width: size.width * 0.01,
                //     ),
                //     if (attendance.ontimeclockout != null)
                //       _clockOutTimeStatus(attendance.ontimeclockout!),
                //   ],
                // ),
                if (attendance.workDuration != null)
                  Text("Work durations: ${attendance.workDuration!}"),
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    "See Breaks List >>",
                    style: TextStyle(
                      color: const Color(0xff4271CF),
                      fontWeight: FontWeight.w600,
                      fontSize: size.width * 0.04,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
