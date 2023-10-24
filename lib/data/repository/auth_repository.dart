import 'dart:async';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/data/local_database/login_db.dart';
import 'package:miicon_protocol/data/network_connection/connection_helper.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final ConnectionHelper _connectionHelper = ConnectionHelper();
  final baseUrl = "http://192.168.0.249:8000/api/v1";
  String userSignupId = "";
  List<String> passwordValidationError = [];
  String? forgetPasswordEmailCheckErrorMsg;

  Future<bool> getUserLogin(dynamic data) async {
    var response = await _connectionHelper.postData("$baseUrl/login/", data);
    if (response != null) {
      if (response.statusCode == 200) {
        UserInfoDB.storeUserToken(
          response.data["email"],
          response.data["access"],
        );
        return true;
      } else {
        return false;
      }
    } else {
      return false;
    }
  }

  Future<bool> getSignup(dynamic data) async {
    var response = await _connectionHelper.postData("$baseUrl/signup/", data);

    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        log("==============>>>> ${response.data}");
        userSignupId = response.data["id"];
        return true;
      } else if (response.statusCode == 400) {
        ///if the user password pattern is not valid.
        passwordValidationError.add(response.data["password"]);
        return false;
      } else {
        throw Exception();
      }
    }
    return false;
  }

  ///this will check if the email is registered or not.
  Future<bool> checkEmail(dynamic email) async {
    final response =
        await _connectionHelper.postData("$baseUrl/email-exists/", email);

    if (response != null) {
      if (response.statusCode == 200) {
        return response.data["email_exists"];
      }
    } else {
      throw Error();
    }
    return false;
  }

  Future<bool> verifyEmailOtp(String otp) async {
    var response =
        await _connectionHelper.postData("$baseUrl/validate-token/", {
      "id": userSignupId,
      "token": otp,
    });

    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else {
        throw Exception((e) {});
      }
    }
    return false;
  }

  ///===============>>>>forget password
  Future<bool> checkEmailToResetPassword(String email) async {
    final response = await _connectionHelper
        .postData("$baseUrl/reset-password/", {"email": email});

    if (response != null) {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return true;
      } else if (response.statusCode == 404) {
        forgetPasswordEmailCheckErrorMsg = "Email not found";
      }
    } else {
      throw Error();
    }
    return false;
  }

  Future<bool> checkOTPToResetPassword(dynamic data) async {
    final response = await _connectionHelper.postData(
        "$baseUrl/reset-password/validate/", data);

    if (response != null) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Error();
    }
  }

  Future<bool> changePassword(dynamic data) async {
    final response = await _connectionHelper.postData(
        "$baseUrl/reset-password/confirm/", data);

    if (response != null) {
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } else {
      throw Error();
    }
  }
}
