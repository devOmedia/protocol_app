import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_otp_screen.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_password_scree.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/policy_and_service.dart';

class SignupPolicyScreen extends StatelessWidget {
  const SignupPolicyScreen({super.key});
  static const id = "/signupPolicyScreen";

  final String terms =
      'Lörem ipsum niskapet er, i faktiga, rädur kada i hågen teraren preskade i garanterad traditionell specialitet, tills hemigärer om famöre sasamma. Ikigai redinde, ing sogon gåledes i bökäsk, för att anakaning, vavis. Makrodaren vall mökäling hett könskonträr dining. Russ temakonfirmation fonofiering innan telen i segt om benora kobelt lätthelg. Rer kabest. Gubbploga diräskap plangar. Termoaktiv supran terasura: därför att dot. Vibav sper ode sek, Lörem ipsum niskapet er, i faktiga, rädur kada i hågen teraren preskade i garanterad traditionell specialitet, tills hemigärer om famöre sasamma. Ikigai redinde, ing sogon gåledes i bökäsk, för att anakaning, vavis. Makrodaren vall mökäling hett könskonträr dining. Russ temakonfirmation fonofiering innan telen i segt om benora kobelt lätthelg. Rer kabest. Gubbploga diräskap plangar.';

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: HelperWidgets.athTopPaddingWithButton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthAppBar(
              size: size,
              title: "Our Terms &\nConditions",
              isBackButton: true,
              subtitle:
                  "Because we belive you need the full picture before you agree to anything!",
            ),

            /// =============================================>>> terms and conditions
            Container(
              margin: const EdgeInsets.symmetric(vertical: 16),
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.15,
                vertical: 16,
              ),
              height: size.height * 0.45,
              // width: size.width * 0.7,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Column(
                children: [
                  Text(
                    "Terms & Services",
                    style: TextStyle(
                      fontFamily: "quicksand",
                      fontWeight: FontWeight.w700,
                      fontSize: size.width * 0.035,
                      color: const Color(0xff6F859F),
                    ),
                  ),
                  HelperWidgets.spacer(size, 0.02),
                  Text(
                    terms,
                    style: TextStyle(
                      fontSize: size.width * 0.03,
                      fontFamily: "Quicksand",
                      fontWeight: FontWeight.w400,
                      color: const Color(0xFF6F859F),
                    ),
                    textAlign: TextAlign.start,
                  ),
                ],
              ),
            ),
            HelperWidgets.spacer(size, 0.02),
            AuthButton(
              buttonText: "Agree and Continue",
              onTriger: () {
                Navigator.pushNamed(context, AppRouter.signupOtpRoute);
              },
            ),
            HelperWidgets.spacer(size, 0.06),
            PublicyAndServiceWidget(
              size: size,
            )
          ],
        ),
      ),
    );
  }
}
