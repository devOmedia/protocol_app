import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:miicon_protocol/business_logic/missing_attendance_bloc/missing_attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/missing_attendance_bloc/missing_attendance_event.dart';
import 'package:miicon_protocol/business_logic/missing_attendance_bloc/missing_attendance_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';

class MissingAttendanceApplicationScreen extends StatefulWidget {
  const MissingAttendanceApplicationScreen({super.key});
  static const id = "/missingAttendanceApplicationScreen";

  @override
  State<MissingAttendanceApplicationScreen> createState() =>
      _MissingAttendanceApplicationScreenState();
}

class _MissingAttendanceApplicationScreenState
    extends State<MissingAttendanceApplicationScreen> {
  TextEditingController? _applicationName;
  TextEditingController? _reason;
  GlobalKey<FormState> _formkey = GlobalKey();
  String? selectedDate;
  String? clockin;
  String? clockout;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020, 1),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      DateFormat dateFormater = DateFormat("yyyy-MM-dd");
      selectedDate = dateFormater.format(picked);

      setState(() {});
    }
  }

  Future<void> _selectTime(BuildContext context, bool isClockIn) async {
    TimeOfDay? selectedTime24Hour = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child!,
        );
      },
    );

    if (selectedTime24Hour != null) {
      // ignore: use_build_context_synchronously

      if (isClockIn) {
        clockin = selectedTime24Hour.format(context);
      } else {
        clockout = selectedTime24Hour.format(context);
      }
      setState(() {});
    }
  }

  @override
  void initState() {
    _applicationName = TextEditingController();

    _reason = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _applicationName!.dispose();
    _reason!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<MissingAttendanceBloc, MissingAttendanceState>(
        listener: (context, state) {
          if (state is MissingAttendanceDataPostedState) {}
        },
        builder: (context, state) {
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.08,
              ),
              child: Form(
                key: _formkey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HelperWidgets.topBackButton(size, context),
                    HelperWidgets.spacer(size, 0.03),
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "Applying for Missing Attendance",
                        style: TextStyle(
                          color: const Color(0xff3C3C3C),
                          fontWeight: FontWeight.w600,
                          fontSize: size.width * 0.05,
                        ),
                      ),
                    ),
                    HelperWidgets.spacer(size, 0.04),
                    CustomTextInputfield(
                      hintText: "Application title",
                      textController: _applicationName!,
                      size: size,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "This field can be empty";
                      },
                    ),
                    HelperWidgets.spacer(size, 0.02),
                    dateTimeCardWidget(
                      size: size,
                      text: selectedDate ?? "Select Missing Attendance Date",
                      onTriger: () {
                        FocusScope.of(context).unfocus();
                        _selectDate(context);
                      },
                    ),
                    HelperWidgets.spacer(size, 0.02),
                    dateTimeCardWidget(
                        size: size,
                        text: clockin ?? "Select Starting Time",
                        onTriger: () {
                          FocusScope.of(context).unfocus();
                          _selectTime(context, true);
                        }),
                    HelperWidgets.spacer(size, 0.02),
                    dateTimeCardWidget(
                        size: size,
                        text: clockout ?? "Select Ending Time",
                        onTriger: () {
                          FocusScope.of(context).unfocus();
                          _selectTime(context, false);
                        }),
                    HelperWidgets.spacer(size, 0.02),
                    CustomTextInputfield(
                      hintText: "Reason for missing attendance",
                      textController: _reason!,
                      textInputAction: TextInputAction.done,
                      size: size,
                      isLargeFields: true,
                      validator: (value) {
                        if (value!.isNotEmpty) {
                          return null;
                        }
                        return "This field can be empty";
                      },
                    ),
                    HelperWidgets.spacer(size, 0.04),
                    if (state is MissingAttendanceDataPostingState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: KConstColors.secondaryColor,
                        ),
                      )
                    else
                      AuthButton(
                        buttonText: "Apply",
                        onTriger: () {
                          if (_formkey.currentState!.validate() &&
                              selectedDate != null) {
                            context.read<MissingAttendanceBloc>().add(
                                  MissingAttendanceDataPostingEvent(
                                    title: _applicationName!.text,
                                    date: selectedDate!,
                                    clockIn: clockin != null
                                        ? clockin!.contains("AM")
                                            ? "$selectedDate ${clockin!.split(" AM")[0]}:00"
                                            : "$selectedDate ${clockin!.split(" PM")[0]}:00"
                                        : " ",
                                    clockOut: clockin != null
                                        ? clockout!.contains("AM")
                                            ? "$selectedDate ${clockout!.split(" AM")[0]}:00"
                                            : "$selectedDate ${clockout!.split(" PM")[0]}:00"
                                        : " ",
                                    reason: _reason!.text,
                                  ),
                                );
                          }
                        },
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget dateTimeCardWidget({size, text, onTriger}) {
    return GestureDetector(
      onTap: onTriger,
      child: Container(
        height: size.height * 0.08,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xffF7F8F9),
          border: Border.all(
            color: const Color(0xffE8ECF4),
          ),
        ),
        child: Row(
          children: [
            Icon(
              Icons.calendar_month_outlined,
              color: KConstColors.iconColor,
              size: size.width * 0.06,
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              text.toString(),
              style: KConstTextStyle.inputfieldHintTextStyle.copyWith(
                fontSize: size.width * 0.04,
                color: const Color(0xff8391A1),
              ),
            )
          ],
        ),
      ),
    );
  }
}
