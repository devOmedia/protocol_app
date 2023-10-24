import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_event.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_bloc.dart';
import 'package:miicon_protocol/business_logic/filter_attendance_bloc/filter_attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/filter_attendance_bloc/filter_attendance_state.dart';
import 'package:miicon_protocol/business_logic/missing_attendance_bloc/missing_attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_bloc.dart';
import 'package:miicon_protocol/business_logic/salary_bloc/salary_event.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_bloc.dart';
import 'package:miicon_protocol/business_logic/user_profile_bloc/profile_bloc.dart';
import 'package:miicon_protocol/business_logic/user_profile_bloc/profile_event.dart';
import 'package:miicon_protocol/data/repository/auth_repository.dart';
import 'package:miicon_protocol/data/repository/protocol_repository.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/screens/salary_event_screen.dart';

import 'business_logic/filter_attendance_bloc/filter_attendance_event.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final AppRouter _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthenticationRepository(),
        ),
        RepositoryProvider(
          create: (context) => ProtocolRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider<AuthenticationBloc>(
              create: (context) => AuthenticationBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  )),
          BlocProvider<SignupBloc>(
            create: (context) => SignupBloc(
              RepositoryProvider.of<AuthenticationRepository>(context),
            ),
          ),
          BlocProvider<AttendanceBloc>(
            create: (context) => AttendanceBloc(
              protocal_repository:
                  RepositoryProvider.of<ProtocolRepository>(context),
            )..add(
                AttendanceLoadingEvent(),
              ),
          ),
          BlocProvider<MissingAttendanceBloc>(
            create: (context) => MissingAttendanceBloc(
              protocolRepository:
                  RepositoryProvider.of<ProtocolRepository>(context),
            ),
          ),
          BlocProvider<ProfileBloc>(
            create: (context) => ProfileBloc(
              repository: RepositoryProvider.of<ProtocolRepository>(context),
            )..add(
                ProfileLoadingEvent(),
              ),
          ),
          BlocProvider<FilteredAttendanceBloc>(
            create: (context) => FilteredAttendanceBloc(
              protocal_repository:
                  RepositoryProvider.of<ProtocolRepository>(context),
            )..add(
                FilterAttendanceInitLoadingEvent(),
              ),
          ),
          BlocProvider<SalaryEventBloc>(
            create: (context) => SalaryEventBloc(
              repository: RepositoryProvider.of<ProtocolRepository>(context),
            )..add(
                SalaryLoadingInitEvent(),
              ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: KConstColors.primaryColor,
            fontFamily: "urbanist",
          ),
          onGenerateRoute: _appRouter.onGenerateRoute,
          //home: SalaryEventScreen(),
          // initialRoute: ProfileScreen.id,
          // routes: {
          //   LoginScree.id: (context) => const LoginScree(),
          //   DeshboardScreen.id: (context) => const DeshboardScreen(),
          //   ForgetPasswordEmailScreen.id: (context) =>
          //       const ForgetPasswordEmailScreen(),
          //   ProfileScreen.id: (context) => const ProfileScreen(),
          //   ProfileEditScreen.id: (context) => const ProfileEditScreen(),

          //   SignupScreen.id: (context) => const SignupScreen(),
          //   SignupPolicyScreen.id: (context) => const SignupPolicyScreen(),
          //   //SignupPasswordScreen.id: (context) => const SignupPasswordScreen(),
          //   SignupOtpScreen.id: (context) => const SignupOtpScreen(),
          //   MissingAttendanceApplicationScreen.id: (context) =>
          //       const MissingAttendanceApplicationScreen(),
          // },
        ),
      ),
    );
  }
}
