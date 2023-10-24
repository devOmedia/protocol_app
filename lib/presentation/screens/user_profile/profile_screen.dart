import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miicon_protocol/business_logic/user_profile_bloc/profile_bloc.dart';
import 'package:miicon_protocol/business_logic/user_profile_bloc/profile_state.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/route/app_router.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const id = "/profile";

  showCustomDialog(BuildContext context) {
    return showGeneralDialog(
      context: context,
      barrierLabel: "Barrier",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (_, __, ___) {
        return Center(
          child: Container(
            height: 240,
            padding: const EdgeInsets.all(8),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: SizedBox.expand(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(18),
                      backgroundColor: KConstColors.secondaryColor,
                    ),
                    child: Center(
                      child: Text(
                        "Edit Profile",
                        style: KConstTextStyle.buttonText.copyWith(
                          color: KConstColors.primaryColor,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const SizedBox(
                    height: 20,
                    child: Text(
                      "You need to have permission to edit your restricted information",
                      style: TextStyle(
                        fontSize: 8,
                        color: KConstColors.subTextColor,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(18),
                      backgroundColor: const Color(0XFFE8ECF4),
                    ),
                    child: Center(
                      child: Text(
                        "Request Permission",
                        style: KConstTextStyle.buttonText.copyWith(
                          color: KConstColors.secondaryColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
      // transitionBuilder: (_, anim, __, child) {
      //   Tween<Offset> tween;
      //   if (anim.status == AnimationStatus.reverse) {
      //     tween = Tween(begin: Offset(-1, 0), end: Offset.zero);
      //   } else {
      //     tween = Tween(begin: Offset(1, 0), end: Offset.zero);
      //   }

      //   return SlideTransition(
      //     position: tween.animate(anim),
      //     child: FadeTransition(
      //       opacity: anim,
      //       child: child,
      //     ),
      //   );
      // },
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: BlocConsumer<ProfileBloc, ProfileState>(
        listener: (context, state) {},
        builder: (context, state) {
          return SingleChildScrollView(
            child: Padding(
              padding: HelperWidgets.topHorizontalPadding(size),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  HelperWidgets.topBackButton(size, context),
                  if (state is ProfileLoadedState)
                    //===========================>>>user profile informations
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Profile",
                              style: TextStyle(
                                fontFamily: "urbanist",
                                fontWeight: FontWeight.w600,
                                color: const Color(0xff3C3C3C),
                                fontSize: size.width * 0.07,
                              ),
                            ),
                            ClipOval(
                              child: SizedBox.fromSize(
                                size: Size.fromRadius(
                                    size.width * 0.12), // Image radius
                                child: Image.network(
                                    state.profile.profilePicture!,
                                    fit: BoxFit.cover),
                              ),
                            )
                          ],
                        ),
                        profileWidget(
                          size: size,
                          profile: state.profile,
                        ),
                      ],
                    ),

                  ///===========================>>>bottom buttons
                  HelperWidgets.spacer(size, 0.10),

                  AuthButton(
                      buttonText: "Edit profile",
                      onTriger: () {
                        Navigator.pushNamed(context, AppRouter.editProfile);
                      }),
                  HelperWidgets.spacer(size, 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.all(18),
                      backgroundColor: const Color(0xffFF395D),
                    ),
                    child: Center(
                      child: Text(
                        "Logout",
                        style: KConstTextStyle.buttonText,
                      ),
                    ),
                  ),
                  HelperWidgets.spacer(size, 0.02),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      padding: const EdgeInsets.all(18),
                      backgroundColor: const Color(0XFFE8ECF4),
                    ),
                    child: Center(
                      child: Text(
                        "Delete Account",
                        style: KConstTextStyle.buttonText.copyWith(
                          color: KConstColors.subTextColor,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: size.height * 0.02,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Column profileWidget({size, profile}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        infoTextWidget(
          size: size,
          title: "Name",
          titleValue: profile.fullName,
        ),
        Text(
          profile.designation,
          style: TextStyle(
            color: KConstColors.subTextColor,
            fontWeight: FontWeight.w700,
            fontSize: size.width * 0.04,
          ),
        ),
        HelperWidgets.spacer(size, 0.01),
        infoTextWidget(
          size: size,
          title: "Fathers Name",
          titleValue: profile.fathersName,
        ),
        infoTextWidget(
          size: size,
          title: "Mothers Name",
          titleValue: profile.mothersName,
        ),
        infoTextWidget(
          size: size,
          title: "Birthday",
          titleValue: profile.birthDate,
        ),
        infoTextWidget(
          size: size,
          title: "phone",
          titleValue: profile.phone,
        ),
        infoTextWidget(
          size: size,
          title: "Email",
          titleValue: profile.email,
        ),
        infoTextWidget(
          size: size,
          title: "Employment Type",
          titleValue: profile.employmentType,
        ),
        infoTextWidget(
          size: size,
          title: "Employment Schedule",
          titleValue: profile.shift,
        ),
        infoTextWidget(
          size: size,
          title: "Address",
          titleValue: profile.address,
        ),
        infoTextWidget(
          size: size,
          title: "BloodGroup",
          titleValue: profile.bloodGroup,
        ),
        infoTextWidget(
          size: size,
          title: "NID",
          titleValue: profile.nid,
        ),
        infoTextWidget(
          size: size,
          title: "Emergency Contact Person",
          titleValue: profile.emergencyContactPerson,
        ),
        infoTextWidget(
          size: size,
          title: "Emergency Contact Relationship",
          titleValue: profile.emergencyContactRelationship,
        ),
        infoTextWidget(
          size: size,
          title: "Emergency Contact",
          titleValue: profile.emergencyContact,
        ),
      ],
    );
  }

  Padding infoTextWidget({size, title, titleValue}) {
    return Padding(
      padding: EdgeInsets.only(bottom: size.width * 0.01),
      child: RichText(
        text: TextSpan(
            text: '$title: ',
            style: TextStyle(
              color: KConstColors.subTextColor,
              fontWeight: FontWeight.w700,
              fontSize: size.width * 0.04,
            ),
            children: [
              TextSpan(
                text: titleValue,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: size.width * 0.035,
                ),
              ),
            ]),
      ),
    );
  }
}
