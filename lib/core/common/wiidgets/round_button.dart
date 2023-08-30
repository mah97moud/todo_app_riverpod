import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    this.title,
    this.onPressed,
    super.key,
  });

  final VoidCallback? onPressed;
  final String? title;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorsRes.light,
        minimumSize: Size(
          ScreenUtil.defaultSize.width * 0.9,
          ScreenUtil.defaultSize.height * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Text(
        title ?? '',
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: ColorsRes.darkBackground,
        ),
      ),
    );
  }
}
