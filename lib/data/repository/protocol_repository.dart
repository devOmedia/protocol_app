import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/date_symbols.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_event.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/data/models/joining_date.dart';
import 'package:miicon_protocol/data/models/profile_model.dart';
import 'package:miicon_protocol/data/models/salary_model.dart';
import 'package:miicon_protocol/data/models/user.dart';
import 'package:miicon_protocol/data/models/user_attendance.dart';
import 'package:miicon_protocol/data/network_connection/connection_helper.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class ProtocolRepository {
  final _connection = ConnectionHelper();
  // final token =
  //     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNjcwMzIzNjUxLCJpYXQiOjE2NzAyMzcyNTEsImp0aSI6IjU1OGE0ZjBjYWY0YzQ5OTc5ZWZlY2UzNTYxODE5ZGY5IiwidXNlcl9pZCI6Ijg4ZDc0ZmRhLTg1NjUtNDE4Zi1iMDQ1LWQ4ZmFlZGQzMGEzZSJ9.WeOqpFVBQtE9aA0g4WYNpGCxaO4hX1wTX6ntOlANI7U";

  Future<dynamic> getUserAttendanceData() async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
      "${KApiUrls.baseUrl}/attendance-list/",
      token,
    );
    if (response != null) {
      if (response.statusCode == 200) {
        //calling method to get the joining date and id info
        getJoiningDate();
        return Attendance.fromJson(response.data);
      } else if (response.statusCode == 403) {
        return null;
      } else {
        throw Exception();
      }
    } else {
      throw Error();
    }
  }

  Future<bool> applyMissingAttendance(dynamic data) async {
    final String email = UserInfoDB.getUserEmail("email");
    final String token = UserInfoDB.getUserToken(email);
    final response = await _connection.postDataWithHeaders(
        "${KApiUrls.baseUrl}/list-create-missing-attendance/", data, token);

    if (response != null) {
      if (response.statusCode == 201) {
        return true;
      } else {
        throw Exception([response.statusCode, response.data]);
      }
    } else {
      throw Exception();
    }
  }

  Future<Profile> userProfile() async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
        "${KApiUrls.baseUrl}/profile/", token);

    if (response != null) {
      if (response.statusCode == 200) {
        return Profile.fromJson(response.data);
      } else {
        throw Exception([response.statusCode, response.data]);
      }
    } else {
      throw Exception();
    }
  }

  Future<UserAdditionalInfo?> getUserAdditionalInfo() async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
        "${KApiUrls.baseUrl}/get-additional-info/", token);

    if (response != null) {
      if (response.statusCode == 200) {
        return UserAdditionalInfo.fromJson(response.data);
      }
    } else {
      throw Exception(response!.data);
    }
    return null;
  }

  Future<void> getJoiningDate() async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
        "${KApiUrls.baseUrl}/joining-date/", token);

    if (response != null) {
      if (response.statusCode == 200) {
        final data = JoiningData.fromJson(response.data);
        await UserInfoDB.storeUserJoiningData(data.employeeId!, data.date!);
      }
    } else {
      throw Exception(response!.statusCode);
    }
  }

  Future<Attendance?> getFilteredAttendance(
      String id, String month, String year) async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
        "${KApiUrls.baseUrl}/list-attendance-of-given-month/$id/$year/$month",
        token);

    if (response != null) {
      if (response.statusCode == 200) {
        return Attendance.fromJson(response.data);
      }
    } else {
      throw Exception(response!.statusCode);
    }
    return null;
  }

  Future<SalaryEventModel?> getEmployeeSalary(
      String id, String month, String year) async {
    final String email = await UserInfoDB.getUserEmail("email");
    final String token = await UserInfoDB.getUserToken(email);
    final response = await _connection.getDataWithToken(
        "${KApiUrls.baseUrl}/daily-salary/$id/$year/$month", token);

    if (response != null) {
      if (response.statusCode == 200) {
        return SalaryEventModel.fromJson(response.data);
      }
    } else {
      throw Exception(response!.statusCode);
    }
    return null;
  }
}
