import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_bloc.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_event.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_termsAndCondition_scree.dart';
import 'package:miicon_protocol/presentation/utils/form_validator.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';
import 'package:miicon_protocol/presentation/widgets/custom_password_field.dart';
import 'package:miicon_protocol/presentation/widgets/policy_and_service.dart';

class SignupPasswordScreen extends StatefulWidget {
  const SignupPasswordScreen({super.key, required this.singupData});
  static const id = "signuPasswordScreen";
  final Map singupData;

  @override
  State<SignupPasswordScreen> createState() => _SignupPasswordScreenState();
}

class _SignupPasswordScreenState extends State<SignupPasswordScreen> {
  late TextEditingController _passwordController;

  late TextEditingController _conformPasswordController;
  final GlobalKey<FormState> _formKey = GlobalKey();
  FToast? fToast;

  @override
  void initState() {
    _passwordController = TextEditingController();
    _conformPasswordController = TextEditingController();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _conformPasswordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
        body: BlocListener<SignupBloc, SignupState>(
      listener: (context, state) {
        if (state is SignupCompetedState) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const SignupPolicyScreen(),
            ),
          );
        }
      },
      child: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        padding: HelperWidgets.athTopPaddingWithButton,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///==================>>>> appbar
            AuthAppBar(
              size: size,
              isBackButton: true,
              title: "Let's Get you\nRegistered",
              subtitle:
                  "Now, to make your account secured enter a password with a minimum of 8 characters containing at least 1 lowercase AND 1 uppercase AND 1 number",
            ),
            HelperWidgets.spacer(size, 0.04),

            ///==================>>>> input fields
            BlocBuilder<SignupBloc, SignupState>(
              builder: (context, state) {
                return Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      CustomPasswordInputfield(
                        hintText: "Enter your password",
                        textController: _passwordController,
                        keyBoardType: TextInputType.visiblePassword,
                        size: size,
                      ),

                      /// =============================>>>> error msg widget
                      if (state is SignupErrorState)
                        HelperWidgets.inputFieldError(
                          errorMsg: state.errorMsg,
                        ),
                      HelperWidgets.spacer(size, 0.02),
                      CustomPasswordInputfield(
                        hintText: "Confirm your password",
                        textController: _conformPasswordController,
                        size: size,
                        textInputAction: TextInputAction.done,
                        keyBoardType: TextInputType.visiblePassword,
                      ),
                      HelperWidgets.spacer(size, 0.04),
                      if (state is SignupingState)
                        const Center(
                          child: CircularProgressIndicator(
                            color: KConstColors.secondaryColor,
                          ),
                        )
                      else
                        AuthButton(
                          buttonText: "Next",
                          onTriger: () {
                            final isPassword =
                                FormValidator.isPasswordCompliant(
                                    _passwordController.text);

                            if (isPassword &&
                                _conformPasswordController.text ==
                                    _passwordController.text) {
                              context.read<SignupBloc>().add(
                                    SignupSubmittingEvent(
                                      firstName:
                                          widget.singupData["first_name"],
                                      lastName: widget.singupData["last_name"],
                                      country: widget.singupData["country"],
                                      email: widget.singupData["email"],
                                      password: _passwordController.text,
                                    ),
                                  );
                            } else {
                              if (!isPassword) {
                                showToast(
                                  fToast: fToast,
                                  context: context,
                                  size: size,
                                  text: "Password field can be empty",
                                );
                              } else {
                                showToast(
                                  fToast: fToast,
                                  context: context,
                                  size: size,
                                  text: "Password didn't metched",
                                );
                              }
                            }
                          },
                        )
                    ],
                  ),
                );
              },
            ),
            HelperWidgets.spacer(size, 0.32),
            PublicyAndServiceWidget(
              size: size,
            )
          ],
        ),
      ),
    ));
  }
}
