import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';

class ProtocolAppBar extends StatelessWidget {
  const ProtocolAppBar({
    Key? key,
    required this.size,
  }) : super(key: key);

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Protocol",
          style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: size.width * 0.08,
              color: const Color(0xff2f19b8)),
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            notificationButtons(
              icon: Icons.notifications_outlined,
            ),
            notificationButtons(
              icon: FeatherIcons.briefcase,
            ),
            IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRouter.profileRoute);
              },
              icon: const Icon(
                FeatherIcons.user,
                color: Color(0xff49576E),
              ),
            ),
          ],
        )
      ],
    );
  }

  Stack notificationButtons({icon}) {
    return Stack(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(
            icon,
            color: const Color(0xff49576E),
          ),
        ),
        Positioned(
          top: 10,
          right: 10,
          child: CircleAvatar(
            radius: size.width * 0.01,
            backgroundColor: Colors.redAccent,
          ),
        )
      ],
    );
  }
}
