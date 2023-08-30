import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/app/country_code_provider/country_code_provider.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/round_button.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/white_space.dart';
import 'package:todo_app_riverpod/core/resources/colours.dart';
import 'package:todo_app_riverpod/core/resources/image_res.dart';
import 'package:todo_app_riverpod/core/utils/core_utils.dart';
import 'package:todo_app_riverpod/features/authentication/controller/authentication_controller.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const border = OutlineInputBorder(
      borderSide: BorderSide.none,
      borderRadius: BorderRadius.all(
        Radius.circular(16.0),
      ),
    );
    final phoneController = useTextEditingController();
    final code = ref.watch(countryCodeProvider);
    return Scaffold(
      appBar: AppBar(),
      body: SafeArea(
        child: Center(
          child: ListView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.symmetric(
              horizontal: 30.0,
            ),
            children: [
              Image.asset(ImageRes.logo),
              const WhiteSpace(
                height: 20.0,
              ),
              Text(
                'Please enter your number to get the verification code.',
                style: GoogleFonts.poppins(
                  fontSize: 17,
                  color: ColorsRes.light,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
              const WhiteSpace(height: 20),
              TextFormField(
                onTapOutside: (pointer) {
                  FocusScope.of(context).unfocus();
                },
                readOnly: code == null,
                keyboardType: TextInputType.phone,
                controller: phoneController,
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: ColorsRes.darkBackground,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: ColorsRes.light,
                  prefixIcon: Padding(
                    padding: const EdgeInsets.only(
                      top: 8.0,
                      left: 14.0,
                    ),
                    child: GestureDetector(
                      onTap: () {
                        showCountryPicker(
                          context: context,
                          onSelect: (code) {
                            ref
                                .read(countryCodeProvider.notifier)
                                .changeCountry(code);
                          },
                          countryListTheme: CountryListThemeData(
                            backgroundColor: ColorsRes.darkBackground,
                            bottomSheetHeight:
                                MediaQuery.of(context).size.height * 0.6,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(12.0),
                            ),
                            textStyle: GoogleFonts.poppins(
                              color: ColorsRes.light,
                            ),
                            searchTextStyle: GoogleFonts.poppins(
                              color: ColorsRes.light,
                            ),
                            inputDecoration: InputDecoration(
                              hintStyle: GoogleFonts.poppins(
                                color: ColorsRes.lightGrey,
                              ),
                              hintText: 'Search',
                              border: const OutlineInputBorder(),
                              labelText: 'Search',
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: EdgeInsets.only(
                          top: code == null ? 6.0.h : 0.h,
                        ),
                        child: Text(
                          code == null
                              ? 'Pick country'
                              : '${code.flagEmoji} +${code.phoneCode} ',
                          style: GoogleFonts.poppins(
                            fontSize: code == null ? 13.0 : 18.0,
                            color: ColorsRes.darkBackground,
                            fontWeight: code == null
                                ? FontWeight.w500
                                : FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 5.0,
                  ),
                  focusedBorder: border,
                  enabledBorder: border,
                ),
              ),
              const WhiteSpace(height: 20),
              RoundButton(
                onPressed: () async {
                  if (code == null) return;
                  final navigator = Navigator.of(context);
                  CoreUtils.showLoader(
                    context: context,
                    message: 'Loading...',
                  );
                  await ref.read(authControllerProvider).sendOTP(
                        context: context,
                        phoneNumber:
                            '+${code.phoneCode}${phoneController.text}',
                      );
                  navigator.pop();
                },
                title: 'Send code',
              )
            ],
          ),
        ),
      ),
    );
  }
}
