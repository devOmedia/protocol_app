import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_bloc.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_event.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_state.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/policy_and_service.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class SignupOtpScreen extends StatefulWidget {
  const SignupOtpScreen({super.key});
  static const id = "/signupOtpScreen";

  @override
  State<SignupOtpScreen> createState() => _SignupOtpScreenState();
}

class _SignupOtpScreenState extends State<SignupOtpScreen> {
  TextEditingController? _otpController;
  FToast? fToast;
  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast!.init(context);
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
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupTokenValidateErrorState) {
            showToast(
              context: context,
              size: size,
              text: "Something went wrong",
              fToast: fToast,
            );
          } else if (state is SignupTokenValidateSuccessState) {
            Navigator.pushNamed(context, AppRouter.signupSuccess);
          }
        },
        child: BlocBuilder<SignupBloc, SignupState>(
          builder: (context, state) {
            return SingleChildScrollView(
              padding: HelperWidgets.athTopPaddingWithButton,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AuthAppBar(
                    size: size,
                    title: 'OTP\nVarification',
                    isBackButton: true,
                    subtitle:
                        "Enter the verification code we just sent on your email address.",
                  ),
                  // Helper.spacer(size, 0.02),
                  // const Text(
                  //   'Enter the verification code we just sent on your\nemail address.',
                  //   style: TextStyle(
                  //     fontFamily: "quicksand",
                  //     fontSize: 14,
                  //     fontWeight: FontWeight.w500,
                  //     color: Color(0xff838BA1),
                  //   ),
                  // ),
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
                        inactiveColor:
                            Colors.white, //KConstColors.primaryColor,
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
                  if (state is SignupTokenValidateErrorState)

                    ///------------------------------------------------------->

                    InkWell(
                      onTap: () {
                        context.read<SignupBloc>().add(
                            SignupTokenValidationEvent(_otpController!.text));
                      },
                      child: const Text(
                        'Resend Verification Code',
                        style: TextStyle(
                            fontFamily: "inter",
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: KConstColors.auThtextButton),
                      ),
                    ),
                  HelperWidgets.spacer(size, 0.08),
                  if (state is SignupingState)
                    const Center(
                      child: CircularProgressIndicator(
                        color: KConstColors.secondaryColor,
                      ),
                    )
                  else
                    AuthButton(
                      buttonText: "Verify",
                      onTriger: () {
                        context.read<SignupBloc>().add(
                            SignupTokenValidationEvent(_otpController!.text));
                      },
                    ),

                  ///============================>>> auth button.

                  HelperWidgets.spacer(size, 0.34),
                  Center(child: PublicyAndServiceWidget(size: size))
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
