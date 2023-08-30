import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:pinput/pinput.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/white_space.dart';
import 'package:todo_app_riverpod/core/resources/image_res.dart';
import 'package:todo_app_riverpod/features/authentication/controller/authentication_controller.dart';

import '../../../core/resources/colours.dart';
import '../../../core/utils/core_utils.dart';

class OTPVerificationScreen extends ConsumerWidget {
  const OTPVerificationScreen({
    super.key,
    required this.verificationId,
  });

  final String verificationId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var defaultTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: GoogleFonts.poppins(
        fontSize: 20,
        color: ColorsRes.light,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromRGBO(234, 239, 243, 1)),
        color: ColorsRes.greyBackground,
        borderRadius: BorderRadius.circular(20),
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 30.0,
          ),
          child: Column(
            children: [
              Image.asset(ImageRes.logo),
              const WhiteSpace(height: 26.0),
              Pinput(
                length: 6,
                defaultPinTheme: defaultTheme,
                // focusedPinTheme: defaultTheme.copyDecorationWith(
                //   border:
                //       Border.all(color: const Color.fromRGBO(114, 178, 238, 1)),
                //   borderRadius: BorderRadius.circular(8),
                // ),
                submittedPinTheme: defaultTheme.copyWith(
                  decoration: defaultTheme.decoration!.copyWith(
                    color: ColorsRes.darkBackground,
                  ),
                ),
                onTapOutside: (event) {
                  FocusScope.of(context).unfocus();
                },
                validator: (s) {
                  // return s == '2222' ? null : 'Pin is incorrect';
                  return null;
                },
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,

                showCursor: true,
                onCompleted: (pin) async {
                  CoreUtils.showLoader(
                    context: context,
                    message: 'Loading...',
                  );
                  await ref.read(authControllerProvider).verifyOTP(
                        context: context,
                        verificationId: verificationId,
                        otp: pin,
                      );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
