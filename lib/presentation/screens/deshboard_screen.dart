import 'package:bottom_bar_matu/bottom_bar/bottom_bar_bubble.dart';
import 'package:bottom_bar_matu/bottom_bar_item.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_event.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_state.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/screens/attendance_details_screen.dart';
import 'package:miicon_protocol/presentation/screens/salary_event_screen.dart';
import 'package:miicon_protocol/presentation/widgets/attendance_Card_widget.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/dashboard_card_widget.dart';
import 'package:miicon_protocol/presentation/widgets/protocol_app_bar.dart';

class DeshboardScreen extends StatefulWidget {
  const DeshboardScreen({super.key});
  static const id = "/deshboad";

  @override
  State<DeshboardScreen> createState() => _DeshboardScreenState();
}

class _DeshboardScreenState extends State<DeshboardScreen> {
  late DateTime currentTime;
  String? dayOfWeak;
  String? dateTimeString;
  String? month;
  String? year;
  String? date;
  int _index = 2;
  _getDateTime() {
    dayOfWeak = DateFormat.EEEE().format(currentTime);
    month = DateFormat.MMMM().format(currentTime);
    year = DateFormat.y().format(currentTime);
    date = DateFormat.d().format(currentTime);

    final dayInt = DateTime.now().day;
    final dateOrdinal = _getDateOrdinal(dayInt);

    setState(() {
      dateTimeString = "${date}${dateOrdinal} $month $year";
    });
  }

  String _getDateOrdinal(int date) {
    if (date == 11 || date == 12 || date == 13) return ("th");

    // everything else is consistent
    date %= 10;
    if (date == 1) return ("st");
    if (date == 2) return ("nd");
    if (date == 3) return ("rd");
    return ("th");
  }

  @override
  void initState() {
    currentTime = DateTime.now();
    _getDateTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocBuilder<AttendanceBloc, AttendanceState>(
        // listener: (context, state) {
        //   // TODO: implement listener
        // },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: GestureDetector(
              onDoubleTap: () {
                context.read<AttendanceBloc>().add(AttendanceLoadingEvent());
              },
              child: Padding(
                padding: HelperWidgets.athTopPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProtocolAppBar(size: size),
                    HelperWidgets.spacer(size, 0.02),

                    ///==============================>>>top card
                    if (state is AttendanceLoadedState)
                      DeshboardCardWidget(
                        size: size,
                        info: state.info,
                        dayOfWeak: dayOfWeak,
                        dateTimeString: dateTimeString,
                        attendance: state.attendance.results!.isNotEmpty
                            ? state.attendance.results![0]!.date!.contains(
                                    DateFormat("yyyy-MM-dd")
                                        .format(currentTime))
                                ? state.attendance.results![0]!
                                : Result()
                            : Result(),
                      ),

                    ///============>>>if the user is not an emply
                    if (state is AttendanceNotFoundState)
                      RefreshIndicator(
                        onRefresh: () async {
                          context
                              .read<AttendanceBloc>()
                              .add(AttendanceLoadingEvent());
                        },
                        child: const Center(
                          child: Text("Attendance not found"),
                        ),
                      ),

                    /// =================>>> if the state is loading..
                    if (state is AttendanceLoadingState)
                      const Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(
                          color: KConstColors.secondaryColor,
                        ),
                      ),

                    /// ===================>>> if the staet is loaded..
                    if (state is AttendanceLoadedState)
                      RefreshIndicator(
                        onRefresh: () async {
                          return context
                              .read<AttendanceBloc>()
                              .add(AttendanceLoadingEvent());
                        },
                        child: SizedBox(
                          height: size.height * 0.38,
                          child: ListView.builder(
                            physics: ScrollPhysics(),
                            //shrinkWrap: true,
                            itemCount: state.attendance.results!.length,
                            itemBuilder: (context, index) {
                              return AttendanceCardWidget(
                                size: size,
                                dayOfWeak: dayOfWeak,
                                date: date,
                                month: month,
                                attendance: state.attendance.results![index]!,
                              );
                            },
                          ),
                        ),
                      ),
                    AuthButton(
                        buttonText: "See all alltendance",
                        onTriger: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendanceDetailsScreen()));
                        })
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        color: Colors.white,
        child: BottomBarBubble(
          color: KConstColors.otpBorderColor,
          selectedIndex: _index,
          height: size.height * 0.08,
          items: [
            BottomBarItem(iconData: FeatherIcons.bell),
            BottomBarItem(iconData: Icons.menu_rounded),
            BottomBarItem(iconData: Icons.home),
            BottomBarItem(iconData: FeatherIcons.clock),
            BottomBarItem(iconData: FeatherIcons.briefcase),
          ],
          onSelect: (index) {
            if (index == 4) {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SalaryEventScreen()));
            }
            // implement your select function here
          },
        ),
      ),
    );
  }
}
