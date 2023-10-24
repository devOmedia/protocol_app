import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:lottie/lottie.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';

class SignupSuccessScreen extends StatefulWidget {
  const SignupSuccessScreen({super.key});
  static const id = "/signupSuccess";

  @override
  State<SignupSuccessScreen> createState() => _SignupSuccessScreenState();
}

class _SignupSuccessScreenState extends State<SignupSuccessScreen> {
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(child: LottieBuilder.asset("assets/success.json")),
            Text(
              "Register Success",
              style: TextStyle(
                fontSize: size.width * 0.08,
                fontWeight: FontWeight.w600,
                color: KConstColors.secondaryColor,
              ),
            ),
            Center(
              child: Text(
                "You have succesfully registered\n an account with us,\n Login to continue!",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: KConstColors.subTextColor,
                  fontSize: size.width * 0.035,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.04,
            ),
            AuthButton(
                buttonText: "Login",
                onTriger: () {
                  Navigator.pushNamed(context, AppRouter.loginRoute);
                })
          ],
        ),
      ),
    );
  }
}
