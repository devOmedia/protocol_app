import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_event.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/screens/forget_password/new_password_screen.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/policy_and_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OTPScreen extends StatefulWidget {
  const OTPScreen({super.key, required this.email});
  static const id = "/OtpScreen";
  final String email;

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  TextEditingController? _otpController;
  @override
  void initState() {
    super.initState();
    _otpController = TextEditingController();
  }

  @override
  void dispose() {
    _otpController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is CheckedOTPForForgetPasswordState) {
            _otpController!.clear();
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        SetPasswordScreen(email: widget.email)));
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: HelperWidgets.athTopPaddingWithButton,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AuthAppBar(
                  size: size,
                  title: 'OTP\nVarification',
                  subtitle: "",
                  isBackButton: true,
                ),
                HelperWidgets.spacer(size, 0.02),
                const Text(
                  'Enter the verification code we just sent on your\nemail address.',
                  style: TextStyle(
                    fontFamily: "quicksand",
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: Color(0xff838BA1),
                  ),
                ),
                HelperWidgets.spacer(size, 0.02),
                ////===========================================> otp pin text field
                SizedBox(
                  //width: size.width * 0.70,
                  child: PinCodeTextField(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    appContext: context,
                    pastedTextStyle: TextStyle(
                      color: Colors.green.shade600,
                      fontWeight: FontWeight.bold,
                    ),
                    length: 4,
                    obscureText: false,
                    animationType: AnimationType.fade,
                    pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(8),
                      fieldHeight: size.height * 0.10,
                      fieldWidth: size.width * 0.18,
                      inactiveFillColor:
                          Colors.white, //KConstColors.primaryColor,
                      inactiveColor: Colors.white, //KConstColors.primaryColor,
                      selectedColor: KConstColors.otpBorderColor,
                      selectedFillColor: Colors.white,
                      activeFillColor: KConstColors.primaryColor,
                      activeColor: KConstColors.otpBorderColor,
                    ),
                    cursorColor: Colors.black,
                    animationDuration: const Duration(milliseconds: 300),
                    enableActiveFill: true,
                    controller: _otpController,
                    keyboardType: TextInputType.number,
                    boxShadows: const [
                      // BoxShadow(
                      //   offset: Offset(0, 1),
                      //   color: Colors.black12,
                      //   blurRadius: 10,
                      // )
                    ],
                    onCompleted: (v) {},
                    onChanged: (value) {
                      print(value);
                      setState(() {});
                    },
                  ),
                ),
                //====================>>>the otp error widget
                if (state is CheckedOTPForForgetPasswordErrorState)
                  HelperWidgets.inputFieldError(errorMsg: state.errorMsg),

                ///------------------------------------------------------->

                // InkWell(
                //   onTap: () {},
                //   child: const Text(
                //     'Resend Verification Code',
                //     style: TextStyle(
                //         fontFamily: "inter",
                //         fontSize: 12,
                //         fontWeight: FontWeight.w500,
                //         color: KConstColors.auThtextButton),
                //   ),
                // ),
                HelperWidgets.spacer(size, 0.08),

                ///============================>>> auth button.
                if (state is CheckingOTPForForgetPasswordEvent)
                  const Center(
                    child: CircularProgressIndicator(
                      color: KConstColors.secondaryColor,
                    ),
                  )
                else
                  AuthButton(
                    buttonText: "Verify",
                    onTriger: () {
                      context
                          .read<AuthenticationBloc>()
                          .add(CheckingOTPForForgetPasswordEvent(
                            otp: _otpController!.text,
                            email: widget.email,
                          ));
                    },
                  ),

                HelperWidgets.spacer(size, 0.26),
                Center(child: PublicyAndServiceWidget(size: size))
              ],
            ),
          );
        },
      ),
    );
  }
}
