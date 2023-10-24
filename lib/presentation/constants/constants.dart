import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';

class KApiUrls {
  static const baseUrl =
      "http://192.168.0.249:8000/api/v1"; //"https://uc-backend.unitedchauffeur.co.uk/api/v1";
}

const String google_api_key = "AIzaSyAKSPz1gj2oXdJ9Usl9x_dlBrYA_6PdsO4";

class KConstColors {
  static const Color primaryColor = Color(0xFFf5f5f5);
  static const Color secondaryColor = Color(0xff2F19B8);
  static const Color otpBorderColor = Color(0xff4271CF);
  static const Color cardColor = Color.fromARGB(255, 239, 243, 246);
  static const Color whiteColor = Color(0xFFE8ECF4);
  static const Color hintColor = Color(0xFF8391A1);
  static const Color orangeColor = Color(0xFFF76654);
  static const Color textColor = Color(0xFF000000);
  static Color dropDownColor = Colors.white;
  static const Color subTextColor = Color(0xff8391A1);

  ///new color
  static const Color iconColor = Color(0xff4271cf);
  static const Color inputFieldBorderColor = Color(0xff3772ff);
  static const buttonColor = Color(0xFF2F19B8);
  static const auThtextButton = Color(0xff4271CF);
}

class HelperWidgets {
  static Widget spacer(Size size, double space) {
    return SizedBox(
      height: size.height * space,
    );
  }

  static Container topBackButton(Size size, BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: size.width * 0.15,
      ),
      height: 41,
      width: 41,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: const Color(0xffe8ecf4),
        ),
      ),
      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: const Icon(FeatherIcons.chevronLeft),
      ),
    );
  }

  static topHorizontalPadding(Size size) {
    return EdgeInsets.symmetric(
      horizontal: size.width * 0.08,
    );
  }

  static Widget inputFieldError({errorMsg}) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 8.0,
        bottom: 8.0,
      ),
      child: Text(
        errorMsg,
        style: const TextStyle(
          color: Colors.redAccent,
        ),
      ),
    );
  }

  static const athTopPadding =
      EdgeInsets.symmetric(horizontal: 24, vertical: 60);

  static const athTopPaddingWithButton =
      EdgeInsets.symmetric(horizontal: 22, vertical: 40);

  static OutlineInputBorder inputFieldBorder({color}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(16),
      borderSide: BorderSide(
        color: color ?? KConstColors.inputFieldBorderColor,
        width: 1.5,
      ),
    );
  }
}

class KConstTextStyle {
  static TextStyle Header = const TextStyle(
    fontFamily: "urbanist",
    fontWeight: FontWeight.w700,
    fontSize: 30,
    color: KConstColors.secondaryColor,
  );

  static TextStyle get SubHeader => const TextStyle(
      fontWeight: FontWeight.w500,
      fontSize: 14,
      fontFamily: "Quicksand",
      color: Color(0xff8391A1)
      //color: MYEColors.secondaryColor,
      );

  static const TextStyle akBodyText = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 16,
    //color: MYEColors.textColor,
  );

  static const TextStyle akHintText = TextStyle(
    fontSize: 16,
    //color: MYEColors.hintColor,
  );
  static const TextStyle testFormLettering = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    color: Colors.black,
  );
  static const TextStyle levelFormLettering = TextStyle(
    fontWeight: FontWeight.w500,
    fontSize: 18,
    // color: MYEColors.secondaryColor,
  );

  static TextStyle buttonText = const TextStyle(
    fontWeight: FontWeight.w600,
    fontFamily: 'Urbanist',
    fontSize: 18,
    color: Colors.white,
  );

  static TextStyle textButton = const TextStyle(
    color: Color(0xff4271CF),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static TextStyle textButton1 = const TextStyle(
    fontFamily: "urbanist",
    color: Color(0xff1E232C),
    fontSize: 14,
    fontWeight: FontWeight.w700,
  );

  static TextStyle birthFieldText = const TextStyle(
    fontFamily: "GT Walsheim Pro",
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: Color(0xff777E91),
  );

  static TextStyle forgetScreenMsg = const TextStyle(
    fontFamily: "'Quicksand'",
    color: Color(0xff8391A1),
    fontSize: 14,
    fontWeight: FontWeight.w500,
  );

  static TextStyle inputfieldHintTextStyle = const TextStyle(
    fontFamily: "roboto",
    fontWeight: FontWeight.w400,
    color: Color(0xff8391A1),
  );
}

const Icon backButton = Icon(
  Icons.arrow_back_ios,
  color: Colors.black,
  size: 20,
);
const Icon menuButton = Icon(
  Icons.menu_outlined,
  color: Colors.black,
  size: 20,
);
