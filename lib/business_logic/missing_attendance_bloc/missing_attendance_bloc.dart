import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';
import 'missing_attendance.dart';
class MissingAttendanceBloc
    extends Bloc<MissingAttendanceEvent, MissingAttendanceState> {
  MissingAttendanceBloc({required this.protocolRepository})
      : super(MissingAttendanceState()) {
    on<MissingAttendanceDataPostingEvent>((event, emit) async {
      emit(MissingAttendanceDataPostingState());

      try {
        ///TODO: review 
        final isPosted = await protocolRepository.applyMissingAttendance({
          "date": event.date,
          "reason": event.reason,
          "late_attendance": false,
          "title": event.title,
          if (event.clockIn != " ") "clock_in": event.clockIn,
          if (event.clockIn != " ") "clock_out": event.clockOut,
        });
        if (isPosted) {
          emit(MissingAttendanceDataPostedState());
        } else {
          emit(MissingAttendanceDataPostErrorState(
              errorMsg: "Something went wrong"));
        }
      } catch (e) {
        throw Exception([e]);
      }
    });
  }
  final ProtocolRepository protocolRepository;
}
