import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_bloc.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_event.dart';
import 'package:miicon_protocol/business_logic/signup_bloc/signup_state.dart';

import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_password_scree.dart';
import 'package:miicon_protocol/presentation/utils/form_validator.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/auth_text_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});
  static const id = "/signup";

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late TextEditingController _firstNameCtr;
  late TextEditingController _lastNameCtr;
  late TextEditingController _countryCtr;
  late TextEditingController _emailController;
  final GlobalKey<FormState> _form = GlobalKey();
  FToast? fToast;

  @override
  void initState() {
    _firstNameCtr = TextEditingController();
    _lastNameCtr = TextEditingController();
    _countryCtr = TextEditingController(text: "Bangladesh");
    _emailController = TextEditingController();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _firstNameCtr.dispose();
    _countryCtr.dispose();
    _lastNameCtr.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: BlocListener<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is EmailValidState && state.isEmailRegistered == false) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SignupPasswordScreen(
                  singupData: {
                    "first_name": _firstNameCtr.text,
                    "last_name": _lastNameCtr.text,
                    "country": _countryCtr.text,
                    "email": _emailController.text,
                  },
                ),
              ),
            );
          }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            padding: HelperWidgets.athTopPaddingWithButton,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///=========================================> appbar
                AuthAppBar(
                  size: size,
                  title: "Let's Get you\nRegistered",
                  subtitle:
                      "But! before that, We need some details about you to get you started.",
                  isBackButton: true,
                ),
                HelperWidgets.spacer(size, 0.06),

                ///=======================================> input form
                BlocBuilder<SignupBloc, SignupState>(
                  builder: (context, state) {
                    return Form(
                      key: _form,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextInputfield(
                            size: size,
                            hintText: 'Enter your first name',
                            textController: _firstNameCtr,
                            keyBoardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              }
                              return "Name cann't be empty";
                            },
                          ),
                          HelperWidgets.spacer(size, 0.01),
                          CustomTextInputfield(
                            size: size,
                            hintText: 'Enter your last name',
                            textController: _lastNameCtr,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              }
                              return "Name cann't be empty";
                            },
                          ),
                          HelperWidgets.spacer(size, 0.01),
                          CustomTextInputfield(
                            size: size,
                            hintText: 'Enter your email',
                            textController: _emailController,
                            keyBoardType: TextInputType.emailAddress,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@+")
                                        .hasMatch(value)
                                    ? null
                                    : "Invalid email";
                              } else {
                                return "Empty email";
                              }
                            },
                          ),
                          // ===============================>>> this will show the email validation error.
                          if (state is EmailValidState &&
                              state.isEmailRegistered)
                            HelperWidgets.inputFieldError(
                              errorMsg: "Email is already used",
                            ),
                          HelperWidgets.spacer(size, 0.01),
                          CustomTextInputfield(
                            size: size,
                            hintText: 'Enter country',
                            textController: _countryCtr,
                            textInputAction: TextInputAction.done,
                            keyBoardType: TextInputType.text,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              }
                              return "Invalid country";
                            },
                          ),
                          HelperWidgets.spacer(size, 0.04),
                          if (state is EmailValidatingState)
                            const Center(
                              child: CircularProgressIndicator(
                                color: KConstColors.secondaryColor,
                              ),
                            )
                          else
                            AuthButton(
                                buttonText: "Next",
                                onTriger: () {
                                  String? emailError =
                                      FormValidator.emailValidator(
                                          _emailController.text);

                                  if (emailError == null &&
                                      _countryCtr.text.isNotEmpty &&
                                      _firstNameCtr.text.isNotEmpty &&
                                      _lastNameCtr.text.isNotEmpty) {
                                    context.read<SignupBloc>().add(
                                        CheckEmailEvent(_emailController.text));
                                  } else {
                                    if (_firstNameCtr.text.isEmpty) {
                                      showToast(
                                          fToast: fToast,
                                          size: size,
                                          context: context,
                                          text: "First name can be empty");
                                    } else if (_lastNameCtr.text.isEmpty) {
                                      showToast(
                                          fToast: fToast,
                                          size: size,
                                          context: context,
                                          text: "Last name can be empty");
                                    } else if (emailError != null) {
                                      showToast(
                                          fToast: fToast,
                                          size: size,
                                          context: context,
                                          text: emailError);
                                    } else {
                                      showToast(
                                          fToast: fToast,
                                          size: size,
                                          context: context,
                                          text: "Country name can be empty");
                                    }
                                  }
                                })
                        ],
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
