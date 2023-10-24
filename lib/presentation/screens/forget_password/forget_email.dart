import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_event.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_state.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_bloc.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_state.dart';

import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/screens/forget_password/otp_scree.dart';
import 'package:miicon_protocol/presentation/utils/form_validator.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';

class ForgetPasswordEmailScreen extends StatefulWidget {
  const ForgetPasswordEmailScreen({super.key});
  static const id = "/email";

  @override
  State<ForgetPasswordEmailScreen> createState() =>
      _ForgetPasswordEmailScreenState();
}

class _ForgetPasswordEmailScreenState extends State<ForgetPasswordEmailScreen> {
  final GlobalKey _formKey = GlobalKey<FormState>();
  late TextEditingController emailCtr;
  FToast? fToast;

  @override
  void initState() {
    emailCtr = TextEditingController();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    emailCtr.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
        body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        if (state is CheckedMailForForgetPasswordState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OTPScreen(email: emailCtr.text),
            ),
          );
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
                title: 'Forget your\nPassword?',
                subtitle: "",
                isBackButton: true,
              ),
              HelperWidgets.spacer(size, 0.04),
              Text(
                "Don't worry it occures. Please enter the email \naddress linked with your account.",
                style: KConstTextStyle.forgetScreenMsg,
                maxLines: 2,
              ),

              ///=============================> email text field
              HelperWidgets.spacer(size, 0.04),
              Form(
                key: _formKey,
                child: CustomTextInputfield(
                  textController: emailCtr,
                  size: size,
                  hintText: "Enter your email",
                  prefixIcon: FeatherIcons.mail,
                  keyBoardType: TextInputType.emailAddress,
                  screenName: "email",
                ),
              ),
              // Error msg if mail not valid.
              if (state is CheckedMailForForgetPasswordErrorState)
                HelperWidgets.inputFieldError(errorMsg: "Mail not found"),
              // TextButton(
              //   onPressed: () {},
              //   child: Text(
              //     "Resend verification code",
              //     style: TextStyle(
              //       color: const Color(0xff4271CF),
              //       fontFamily: 'Inter',
              //       fontWeight: FontWeight.w500,
              //       fontSize: size.width * 0.03,
              //     ),
              //   ),
              // ),

              ///==================================> button
              HelperWidgets.spacer(size, 0.04),
              if (state is CheckingMailForForgetPasswordState)
                const Center(
                  child: CircularProgressIndicator(
                    color: KConstColors.secondaryColor,
                  ),
                )
              else
                AuthButton(
                    buttonText: 'Send Code',
                    onTriger: () {
                      String? errorMsg =
                          FormValidator.emailValidator(emailCtr.text);

                      if (errorMsg == null) {
                        context.read<AuthenticationBloc>().add(
                              CheckingMailForForgetPasswordEvent(
                                  email: emailCtr.text),
                            );
                      } else {
                        showToast(
                            fToast: fToast,
                            context: context,
                            size: size,
                            text: errorMsg);
                      }
                    }),

              ///====================================>
              HelperWidgets.spacer(size, 0.32),
            ],
          ),
        );
      },
    ));
  }
}
