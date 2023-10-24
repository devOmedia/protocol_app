import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

class AuthAppBar extends StatelessWidget {
  const AuthAppBar({
    Key? key,
    required this.size,
    required this.title,
    this.subtitle,
    this.isBackButton = false,
  }) : super(key: key);

  final Size size;
  final String title;
  final String? subtitle;
  final bool isBackButton;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: size.width * 0.15),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isBackButton
              ? Container(
                  margin: EdgeInsets.only(
                    bottom: size.height * 26 / 580,
                  ),
                  height: 41,
                  width: 41,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Color(0xffe8ecf4),
                    ),
                  ),
                  child: IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: Icon(FeatherIcons.chevronLeft),
                  ),
                )
              : const SizedBox(),
          Text(
            title,
            style: KConstTextStyle.Header,
            maxLines: 2,
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            subtitle!,
            style: KConstTextStyle.SubHeader,
            maxLines: 4,
          ),
        ],
      ),
    );
  }
}
