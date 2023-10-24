import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class AuthtextButton extends StatelessWidget {
  const AuthtextButton({
    Key? key,
    required this.msg,
    required this.buttonText,
    required this.onTriger,
  }) : super(key: key);

  final String msg;
  final String buttonText;
  final Function onTriger;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          msg,
          style: KConstTextStyle.textButton1,
        ),
        TextButton(
          onPressed: () {
            onTriger();
          },
          child: Text(
            buttonText,
            style: KConstTextStyle.textButton,
          ),
        )
      ],
    );
  }
}
