import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../resources/colours.dart';

class FilledTextField extends StatelessWidget {
  const FilledTextField({
    Key? key,
    this.controller,
    this.readOnly = false,
    this.suffixIcon,
    this.prefixIcon,
    this.hintText,
    this.keyboardType, this.hintStyle,
  }) : super(key: key);

  final TextEditingController? controller;
  final bool readOnly;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextStyle? hintStyle;

  @override
  Widget build(BuildContext context) {
    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(16.0),
      ),
    );
    return TextFormField(
      onTapOutside: (pointer) {
        FocusScope.of(context).unfocus();
      },
      readOnly: readOnly,
      keyboardType: keyboardType,
      controller: controller,
      style: GoogleFonts.poppins(
        fontSize: 18,
        color: ColorsRes.darkBackground,
        fontWeight: FontWeight.bold,
      ),
      decoration: InputDecoration(
        filled: true,
        fillColor: ColorsRes.light,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        hintText: hintText,
        hintStyle: hintStyle,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16.0,
          vertical: 5.0,
        ),
        focusedBorder: border,
        enabledBorder: border,
      ),
    );
  }
}
