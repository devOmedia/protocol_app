import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_event.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_state.dart';
import 'package:miicon_protocol/data/models/joining_date.dart';
import 'package:miicon_protocol/data/models/profile_model.dart';
import 'package:miicon_protocol/data/models/user.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';

class AttendanceBloc extends Bloc<AttendanceEvent, AttendanceState> {
  AttendanceBloc({required this.protocal_repository})
      : super(AttendanceInitial()) {
    on<AttendanceLoadingEvent>((event, emit) async {
      emit(AttendanceLoadingState());
      try {
        //TODO: error review
        final dynamic attendance =
            await protocal_repository.getUserAttendanceData();
        final UserAdditionalInfo? info =
            await protocal_repository.getUserAdditionalInfo();
        if (attendance != null) {
          emit(AttendanceLoadedState(
              attendance: attendance as Attendance, info: info!));
        } else {
          emit(AttendanceNotFoundState());
        }
      } catch (e) {
        //print(e);
        throw Exception([e]);
      }
    });
  
  }
  final ProtocolRepository protocal_repository;
  @override
  void onChange(Change<AttendanceState> change) {
    print("${change.currentState} to ${change.nextState}");

    super.onChange(change);
  }
}
