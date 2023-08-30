import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app_riverpod/core/resources/colours.dart';

class CoreUtils {
  const CoreUtils._();

  static void showSnackBar(
      {required BuildContext context, required String message}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  static void showLoader({
    required BuildContext context,
    String? message,
  }) {
    showDialog(
      context: context,
      builder: (_) => Center(
        child: Scaffold(
          body: Column(
            children: [
              const CircularProgressIndicator(
                color: ColorsRes.lightBlue,
              ),
              if (message != null)
                Text(
                  message,
                  style: GoogleFonts.poppins(
                    color: ColorsRes.lightBlue,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
