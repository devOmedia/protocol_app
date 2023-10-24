import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';
import 'package:miicon_protocol/presentation/widgets/auth_button.dart';
import 'package:miicon_protocol/presentation/widgets/custom_inputfield.dart';

class ProfileEditScreen extends StatefulWidget {
  const ProfileEditScreen({super.key});
  static const id = "/profileEdit";

  @override
  State<ProfileEditScreen> createState() => _ProfileEditScreenState();
}

class _ProfileEditScreenState extends State<ProfileEditScreen> {
  TextEditingController? _firstName;
  TextEditingController? _lastName;
  TextEditingController? _phone;
  TextEditingController? _email;

  TextEditingController? _address;
  TextEditingController? _birth;
  TextEditingController? _gender;
  GlobalKey<FormState> _formKey = GlobalKey();

  @override
  void initState() {
    _firstName = TextEditingController();
    _lastName = TextEditingController();
    _email = TextEditingController();
    _phone = TextEditingController();
    _address = TextEditingController();
    _birth = TextEditingController();
    _gender = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _firstName!.dispose();
    _lastName!.dispose();
    _email!.dispose();
    _phone!.dispose();
    _address!.dispose();
    _birth!.dispose();
    _gender!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          padding: HelperWidgets.topHorizontalPadding(size),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HelperWidgets.topBackButton(size, context),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Edit Profile",
                    style: TextStyle(
                      fontFamily: "urbanist",
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff3C3C3C),
                      fontSize: size.width * 0.07,
                    ),
                  ),
                  Stack(
                    children: [
                      CircleAvatar(
                        radius: size.width * 0.12,
                        child: const FlutterLogo(),
                      ),
                      Positioned(
                        bottom: size.width * 0.01,
                        right: size.width * 0.01,
                        child: GestureDetector(
                          onTap: () {},
                          child: Icon(
                            Icons.camera_alt,
                            color: KConstColors.iconColor,
                            size: size.width * 0.07,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: size.height * 0.04),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextInputfield(
                        hintText: "First Name",
                        textController: _firstName!,
                        size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Last Name",
                        textController: _lastName!,
                        size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Email", textController: _email!, size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Phone", textController: _phone!, size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Address",
                        textController: _address!,
                        size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Date of Birth",
                        textController: _birth!,
                        size: size),
                    SizedBox(height: size.height * 0.02),
                    CustomTextInputfield(
                        hintText: "Gender",
                        textController: _gender!,
                        size: size),
                    SizedBox(height: size.height * 0.02),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              AuthButton(buttonText: "Edit Profile", onTriger: () {}),
              SizedBox(height: size.height * 0.04),
            ],
          ),
        ),
      ),
    );
  }
}
