import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class MissingAttendanceEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MissingAttendanceDataPostingEvent extends MissingAttendanceEvent {
  final String title;
  final String? clockIn;
  final String? clockOut;
  final String reason;
  final String date;
  MissingAttendanceDataPostingEvent({
    required this.title,
    required this.date,
    this.clockIn,
    this.clockOut,
    required this.reason,
  });
}

class MissingAttendanceDataPostedEvent extends MissingAttendanceEvent {}
