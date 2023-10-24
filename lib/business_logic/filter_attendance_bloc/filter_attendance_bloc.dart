import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';
import 'filter_attendance.dart';

class FilteredAttendanceBloc
    extends Bloc<FilteredAttendanceEvent, FilteredAttendanceState> {
  FilteredAttendanceBloc({required this.protocal_repository})
      : super(FilteredAttendanceState()) {
    on<FilterAttendanceInitLoadingEvent>((event, emit) async {
      emit(FilteredAttendanceInitLoadingState());
      final id = await UserInfoDB.getUserEmployeeIDData();
      final joininDate = await UserInfoDB.getUserJoiningDate();
      final joiningYear = joininDate.split("-")[0];
      final joiningMonth = joininDate.split("-")[1];

      try {
        final Attendance? attendance = await protocal_repository
            .getFilteredAttendance(id!, joiningMonth!, joiningYear!);
        if (attendance != null) {
          emit(FilteredAttendanceInitLoadedState(attendance: attendance));
        } else {
          emit(FilteredAttendanceInitLoadErrorState());
        }
      } catch (e) {
        throw Exception(e);
      }
    });
    on<FilterAttendanceLoadingEvent>((event, emit) async {
      try {
        final Attendance? attendance = await protocal_repository
            .getFilteredAttendance(event.id!, event.month!, event.year!);
        if (attendance != null) {
          emit(FilteredAttendanceLoadedState(attendance: attendance));
        } else {
          emit(FilteredAttendanceLoadErrorState());
        }
      } catch (e) {
        throw Exception(e);
      }
    });
  }
  final ProtocolRepository protocal_repository;
}
