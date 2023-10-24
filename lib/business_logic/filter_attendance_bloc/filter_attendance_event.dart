import 'package:equatable/equatable.dart';

class FilteredAttendanceEvent extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

//filter attendance events
class FilterAttendanceLoadingEvent extends FilteredAttendanceEvent {
  final String? id;
  final String? month;
  final String? year;
  FilterAttendanceLoadingEvent({this.id, this.month, this.year});
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilterAttendanceInitLoadingEvent extends FilteredAttendanceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}


class FilterAttendanceLoadedEvent extends FilteredAttendanceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FilterAttendanceLoadErrorEvent extends FilteredAttendanceEvent {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}
