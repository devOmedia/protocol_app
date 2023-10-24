import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    Key? key,
    required this.buttonText,
    required this.onTriger,
  }) : super(key: key);

  final String buttonText;
  final Function onTriger;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onTriger();
      },
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.all(18),
        backgroundColor: KConstColors.buttonColor,
      ),
      child: Center(
          child: Text(
        buttonText,
        style: KConstTextStyle.buttonText,
      )),
    );
  }
}
