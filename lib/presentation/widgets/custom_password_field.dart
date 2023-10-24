import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class CustomPasswordInputfield extends StatefulWidget {
  const CustomPasswordInputfield({
    Key? key,
    this.keyBoardType,
    this.prefixIcon,
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

  final String hintText;
  final TextEditingController textController;
  final String? Function(String?)? validator;
  final String? Function(String?)? onChanged;
  final bool isConfirmPass;
  final String? screenName;
  final TextInputAction textInputAction;
  final Size size;
  final bool isLargeFields;

  @override
  State<CustomPasswordInputfield> createState() =>
      _CustomPasswordInputfieldState();
}

class _CustomPasswordInputfieldState extends State<CustomPasswordInputfield> {
  bool isVisible = false;

  OutlineInputBorder inputFieldBorder() {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(24),
      borderSide:
          const BorderSide(color: Color.fromARGB(255, 71, 73, 77), width: 2.0),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
      ),
      height: widget.isLargeFields
          ? widget.size.height * 0.12
          : widget.size.height * 0.075,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: const Color(0xffF7F8F9),
        border: Border.all(
          color: const Color(0xffE8ECF4),
        ),
      ),
      child: Align(
        alignment: widget.isLargeFields ? Alignment.topLeft : Alignment.center,
        child: TextFormField(
          controller: widget.textController,
          keyboardType: widget.keyBoardType,
          textInputAction: widget.textInputAction,
          maxLines: widget.isLargeFields ? 3 : 1,
          obscureText: isVisible ? false : true,

          // obscureText: isPassword
          //     ? isVisible
          //     : isConfirmPass
          //         ? isConfVisible
          //         : false,

          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: widget.hintText,
              hintStyle: TextStyle(
                fontFamily: "urbanist",
                fontWeight: FontWeight.w500,
                fontSize: widget.size.width * 0.04,
                color: const Color(0xff8391A1),
              ),
              suffixIcon: isVisible
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: const Icon(
                        Icons.visibility,
                        color: Color(0xff4271CF),
                      ),
                    )
                  : GestureDetector(
                      onTap: () {
                        setState(() {
                          isVisible = !isVisible;
                        });
                      },
                      child: const Icon(Icons.visibility_off,
                          color: Color(0xff4271CF))),
              suffixIconColor: const Color(0xff4271CF)),
          validator: widget.validator,
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}
