import 'package:flutter/material.dart';

class PublicyAndServiceWidget extends StatelessWidget {
  const PublicyAndServiceWidget({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size.width * 0.70,
        child: RichText(
          textAlign: TextAlign.center,
          text: const TextSpan(
              text: "By continuting you agree to our ",
              style: TextStyle(
                fontFamily: "quicksand",
                color: Color(0xffC8C8C8),
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              children: [
                TextSpan(
                  text: 'Privacy Policy',
                  style: TextStyle(
                    color: Color(0xff30429A),
                  ),
                ),
                TextSpan(text: ' & '),
                TextSpan(
                  text: 'Terms of Service ',
                  style: TextStyle(
                    color: Color(0xff30429A),
                  ),
                )
              ]),
        ),
      ),
    );
  }
}
