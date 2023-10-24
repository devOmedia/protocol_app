import 'package:equatable/equatable.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';

class FilteredAttendanceState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//filted attendance states
class FilteredAttendanceLoadingState extends FilteredAttendanceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredAttendanceLoadedState extends FilteredAttendanceState {
  final Attendance attendance;
  FilteredAttendanceLoadedState({required this.attendance});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredAttendanceLoadErrorState extends FilteredAttendanceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredAttendanceInitLoadingState extends FilteredAttendanceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredAttendanceInitLoadedState extends FilteredAttendanceState {
  final Attendance attendance;
  FilteredAttendanceInitLoadedState({required this.attendance});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilteredAttendanceInitLoadErrorState extends FilteredAttendanceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
