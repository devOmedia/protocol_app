import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/business_logic/attendance_bloc/attendance_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_bloc.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_event.dart';
import 'package:miicon_protocol/business_logic/auth_bloc/auth_state.dart';

import 'package:miicon_protocol/presentation/constants/constants.dart'; 
import 'package:miicon_protocol/presentation/utils/form_validator.dart';
import 'package:miicon_protocol/presentation/utils/toast.dart';
import 'package:miicon_protocol/presentation/widgets/%20AuthAppBar.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';
import 'package:miicon_protocol/presentation/widgets/custom_password_field.dart';

class SetPasswordScreen extends StatefulWidget {
  const SetPasswordScreen({super.key, required this.email});
  static const id = "\ setPasswordScreen";
  final String email;

  @override
  State<SetPasswordScreen> createState() => _SetPasswordScreenState();
}

class _SetPasswordScreenState extends State<SetPasswordScreen> {
  late TextEditingController newPassController;
  late TextEditingController confPassController;
  GlobalKey _formkey = GlobalKey<FormState>();
  FToast? fToast;

  @override
  void initState() {
    newPassController = TextEditingController();
    confPassController = TextEditingController();
    fToast = FToast();
    fToast!.init(context);
    super.initState();
  }

  @override
  void dispose() {
    newPassController.dispose();
    confPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<AuthenticationBloc, AuthenticationState>(
        listener: (context, state) {
          if (state is SetedPasswordForForgetPasswordState) {}
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
                  title: 'Create New \nPassword',
                  subtitle: "",
                  isBackButton: true,
                ),
                HelperWidgets.spacer(size, 0.04),
                Text(
                  "Your new password must be unique from those\npreviously used.",
                  style: KConstTextStyle.forgetScreenMsg,
                  maxLines: 2,
                ),
                HelperWidgets.spacer(size, 0.04),
                Form(
                  key: _formkey,
                  child: Column(
                    children: [
                      CustomPasswordInputfield(
                        textController: newPassController,
                        size: size,
                        prefixIcon: FeatherIcons.lock,
                        hintText: 'New password',
                      ),
                      if (state is SetedPasswordForForgetPasswordErrorState)
                        HelperWidgets.inputFieldError(errorMsg: state.errorMsg),
                      HelperWidgets.spacer(size, 0.02),
                      CustomPasswordInputfield(
                        size: size,
                        prefixIcon: FeatherIcons.lock,
                        hintText: 'Confirm password',
                        textController: confPassController,
                        isConfirmPass: true,
                      ),
                    ],
                  ),
                ),
                HelperWidgets.spacer(size, 0.08),
                if (state is SettingPasswordForForgetPasswordState)
                  const Center(
                    child: CircularProgressIndicator(
                      color: KConstColors.secondaryColor,
                    ),
                  )
                else
                  AuthButton(
                    buttonText: 'Resent Password',
                    onTriger: () async {
                      final isPassword = FormValidator.isPasswordCompliant(
                          newPassController.text);

                      if (isPassword &&
                          confPassController.text == newPassController.text) {
                        context.read<AuthenticationBloc>().add(
                            SettingPasswordForForgetPasswordEvent(
                                email: widget.email,
                                password: confPassController.text));
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

                      ///this one for reset password.
                      if (FormValidator.validateAndSave(_formkey)) {
                        context
                            .read<AuthenticationBloc>()
                            .add(SettingPasswordForForgetPasswordEvent(
                              password: confPassController.text,
                              email: widget.email,
                            ));
                      }
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}
