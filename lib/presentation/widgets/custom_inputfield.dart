import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class CustomTextInputfield extends StatelessWidget {
  const CustomTextInputfield({
    Key? key,
    this.keyBoardType,
    this.prefixIcon,
    this.isPassword = false,
    required this.hintText,
    required this.textController,
    this.validator,
    this.isConfirmPass = false,
    this.screenName,
    this.textInputAction = TextInputAction.next,
    this.onChanged,
    required this.size,
    this.isLargeFields = false,
  }) : super(key: key);

  final TextInputType? keyBoardType;
  final IconData? prefixIcon;
  final bool isPassword;
  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isConfirmPass;
  final String? screenName;
  final TextInputAction textInputAction;
  final Size size;
  final bool isLargeFields;

  OutlineInputBorder inputFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide: const BorderSide(
          color: KConstColors.inputFieldBorderColor, width: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      height: isLargeFields ? size.height * 0.12 : size.height * 0.075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffF7F8F9),
        border: Border.all(
          color: const Color(0xffE8ECF4),
        ),
      ),
      child: Align(
        alignment: isLargeFields ? Alignment.topLeft : Alignment.center,
        child: TextFormField(
          controller: textController,
          keyboardType: keyBoardType,
          textInputAction: textInputAction,
          maxLines: isLargeFields ? 3 : 1,

          // obscureText: isPassword
          //     ? isVisible
          //     : isConfirmPass
          //         ? isConfVisible
          //         : false,

          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(
              fontFamily: "urbanist",
              fontWeight: FontWeight.w500,
              fontSize: size.width * 0.04,
              color: const Color(0xff8391A1),
            ),
          ),
          validator: validator,
          onChanged: onChanged,
        ),
      ),
    );
  }
}
