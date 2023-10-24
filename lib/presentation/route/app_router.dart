import 'package:flutter/material.dart';
import 'package:miicon_protocol/data/models/profile_model.dart';
import 'package:miicon_protocol/presentation/screens/attendance_details_screen.dart';
import 'package:miicon_protocol/presentation/screens/deshboard_screen.dart';
import 'package:miicon_protocol/presentation/screens/forget_password/forget_email.dart';
import 'package:miicon_protocol/presentation/screens/forget_password/otp_scree.dart';
import 'package:miicon_protocol/presentation/screens/login.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_otp_screen.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_password_scree.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_screen.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_success_screen.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_termsAndCondition_scree.dart';
import 'package:miicon_protocol/presentation/screens/user_profile/edit_profile_screen.dart';
import 'package:miicon_protocol/presentation/screens/user_profile/profile_screen.dart';

class AppRouter {
  static const loginRoute = "/";
  static const signupRoute = '/signup';
  static const signupPasswordRoute = "/signupPassword";
  static const signupPolicyRoute = "/signupPolicy";
  static const signupOtpRoute = "/signupOtp";
  static const forgetPasswordEmailRoute = "/forgetPasswordEmail";
  static const forgetPasswordOtpRoute = "/forgetPasswordOtp";
  static const deshBoradRoute = "/deshBoard";
  static const profileRoute = "/profile";
  static const signupSuccess = "/signupSuccess";
  static const editProfile = "/editProfile";
  static const attendanceDetails = "/attendanceDetails";

  Route? onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case loginRoute:
        return MaterialPageRoute(
          builder: (_) => const LoginScree(),
        );
      case signupRoute:
        return MaterialPageRoute(
          builder: (_) => const SignupScreen(),
        );
      case signupPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => SignupPasswordScreen(
            singupData: routeSettings.arguments! as Map<String, dynamic>,
          ),
        );
      case signupPolicyRoute:
        return MaterialPageRoute(
          builder: (_) => const SignupPolicyScreen(),
        );
      case signupOtpRoute:
        return MaterialPageRoute(
          builder: (_) => const SignupOtpScreen(),
        );
      case forgetPasswordEmailRoute:
        return MaterialPageRoute(
          builder: (_) => const ForgetPasswordEmailScreen(),
        );
      case forgetPasswordOtpRoute:
        return MaterialPageRoute(
          builder: (_) => OTPScreen(
            email: routeSettings.arguments as String,
          ),
        );
      case deshBoradRoute:
        return MaterialPageRoute(
          builder: (_) => const DeshboardScreen(),
        );
      case profileRoute:
        return MaterialPageRoute(
          builder: (_) => const ProfileScreen(),
        );
      case signupSuccess:
        return MaterialPageRoute(
          builder: (_) => const SignupSuccessScreen(),
        );
      case editProfile:
        return MaterialPageRoute(
          builder: (_) => const ProfileEditScreen(),
        );
      case attendanceDetails:
        return MaterialPageRoute(
          builder: (_) => const AttendanceDetailsScreen(),
        );

      default:
        return null;
    }
  }
}
