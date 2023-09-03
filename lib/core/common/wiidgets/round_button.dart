import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class RoundButton extends StatelessWidget {
  const RoundButton({
    this.title,
    this.onPressed,
    super.key,
    this.backgroundColor,
    this.borderColor,
  });

  final VoidCallback? onPressed;
  final String? title;
  final Color? backgroundColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: backgroundColor ?? ColorsRes.light,
        minimumSize: Size(
          ScreenUtil.defaultSize.width * 0.9,
          ScreenUtil.defaultSize.height * 0.06,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
          side: borderColor == null
              ? BorderSide.none
              : BorderSide(
                  color: borderColor!,
                ),
        ),
      ),
      child: Text(
        title ?? '',
        style: GoogleFonts.poppins(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: borderColor ?? ColorsRes.darkBackground,
        ),
      ),
    );
  }
}
