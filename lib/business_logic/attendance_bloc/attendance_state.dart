import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:miicon_protocol/data/models/profile_model.dart';
import 'package:miicon_protocol/data/models/user.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';

@immutable
class AttendanceState extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AttendanceInitial extends AttendanceState {}

class AttendanceLoadingState extends AttendanceState {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AttendanceLoadedState extends AttendanceState {
  AttendanceLoadedState({required this.attendance, required this.info});

  final Attendance attendance;
  final UserAdditionalInfo info;

  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class AttendanceNotFoundState extends AttendanceState {
  @override
  List<Object?> get props => [];
}

