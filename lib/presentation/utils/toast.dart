import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:miicon_protocol/presentation/constants/constants.dart';

showToast({fToast, text, context, size}) {
  Widget toast = Container(
    width: size.width * 0.8,
    height: size.height * 0.08,
    padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 8.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8.0),
      color: const Color(0xffFFDEEF),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Icon(
              Icons.error_outline,
              color: Color(0xff9A4D6F),
            ),
            SizedBox(
              width: 12.0,
            ),
            Text(
              "Worning",
              style: TextStyle(
                color: Color(0xff9A4D6F),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: Text(
            text,
            style: const TextStyle(
              color: Color(0xff9A4D6F),
            ),
          ),
        ),
      ],
    ),
  );

  fToast.showToast(
    child: toast,
    gravity: ToastGravity.BOTTOM,
    toastDuration: const Duration(seconds: 2),
  );

  // Custom Toast Position
// return  fToast.showToast(
//     child: toast,
//     toastDuration: const Duration(seconds: 2),
//     positionedToastBuilder: (context, child) {
//       return Positioned(
//         top: 16.0,
//         left: 16.0,
//         child: child,
//       );
//     },
//   );
}
