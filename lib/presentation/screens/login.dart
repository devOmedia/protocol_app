import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_event.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/screens/forget_password/forget_email.dart';
import 'package:miicon_protocol/presentation/screens/signup/signup_screen.dart';
import 'package:miicon_protocol/presentation/utils/form_validator.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/auth_text_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';
import 'package:miicon_protocol/presentation/widgets/custom_password_field.dart';
import 'package:miicon_protocol/presentation/widgets/policy_and_service.dart';

class LoginScree extends StatefulWidget {
  const LoginScree({super.key});
  static const id = "/login";

  @override
  State<LoginScree> createState() => _LoginScreeState();
}

class _LoginScreeState extends State<LoginScree> {
  final GlobalKey<FormState> _formkey = GlobalKey();
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  bool isVisible = true;
  FToast? fToast;

  @override
  void initState() {
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(body: BlocBuilder<AuthenticationBloc, AuthenticationState>(
      builder: (context, state) {
        return BlocConsumer<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            print(state);
            if (state is AuthenticationErrorState) {
              showToast(
                  fToast: fToast!,
                  text: "User data not found",
                  context: context,
                  size: size);
            } else if (state is AuthenticatedState) {
              print(state);
              Navigator.pushReplacementNamed(context, AppRouter.deshBoradRoute);
            }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                    horizontal: 22, vertical: size.height * 0.10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ///===========================> welcome msg
                    AuthAppBar(
                      size: size,
                      title: 'Welcome back! Glad \nto see you, Again!',
                      subtitle: "",
                    ),

                    ///=============================> inputfield
                    Form(
                      key: _formkey,
                      child: Column(
                        children: [
                          HelperWidgets.spacer(size, 0.06),
                          CustomTextInputfield(
                            textController: _emailController,
                            hintText: "Enter your email",
                            //  prefixIcon: Icons.mail_outline,
                            keyBoardType: TextInputType.emailAddress,
                            screenName: "login",
                            textInputAction: TextInputAction.next,
                            size: size,
                          ),
                          HelperWidgets.spacer(size, 0.02),
                          CustomPasswordInputfield(
                            textController: _passwordController,
                            hintText: "Enter your password",
                            screenName: "login",
                            textInputAction: TextInputAction.done,
                            size: size,
                          ),
                          HelperWidgets.spacer(size, 0.03),
                        ],
                      ),
                    ),

                    ///=====================================> forgetbutton
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {
                          Navigator.pushNamed(
                              context, AppRouter.forgetPasswordEmailRoute);
                        },
                        child: const Text(
                          'Forget Password?',
                          style: TextStyle(
                            fontFamily: "'Quicksand'",
                            fontWeight: FontWeight.w600,
                            color: Color(0xff6A707C),
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),

                    ///=========================================> buttons
                    if (state is AuthenticatingState)
                      const Center(
                        child: CircularProgressIndicator(
                          color: KConstColors.secondaryColor,
                        ),
                      )
                    else
                      AuthButton(
                          buttonText: "Login",
                          onTriger: () {
                            //checking email validation
                            String? emailValidate =
                                FormValidator.emailValidator(
                                    _emailController.text);

                            //if all field valid
                            if (emailValidate == null &&
                                _passwordController.text.isNotEmpty) {
                              context
                                  .read<AuthenticationBloc>()
                                  .add(AuthenticationStateChange(
                                    email: _emailController.text,
                                    password: _passwordController.text,
                                  ));
                            } else {
                              if (_emailController.text.isEmpty) {
                                showToast(
                                    fToast: fToast!,
                                    text: emailValidate!,
                                    context: context,
                                    size: size);
                              } else {
                                showToast(
                                    fToast: fToast!,
                                    text: "Password field can be empty",
                                    context: context,
                                    size: size);
                              }
                            }
                          }),
                    HelperWidgets.spacer(size, 0.01),
                    AuthtextButton(
                      msg: "Don't have an account?",
                      buttonText: 'Register Now',
                      onTriger: () {
                        Navigator.pushNamed(context, AppRouter.signupRoute);
                      },
                    ),
                    HelperWidgets.spacer(size, 0.26),

                    ///===============================> policy and service
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: PublicyAndServiceWidget(size: size),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    ));
  }
}
