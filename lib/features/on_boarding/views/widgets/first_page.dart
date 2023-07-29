import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/common/wiidgets/fading_text.dart';
import '../../../../core/common/wiidgets/white_space.dart';
import '../../../../core/resources/colours.dart';
import '../../../../core/resources/image_res.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 30.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(ImageRes.logo),
          const WhiteSpace(
            height: 100.0,
          ),
          const FadingText(
            'ToDo with Riverpod',
            textAlign: TextAlign.center,
            fontSize: 30.0,
            fontWeight: FontWeight.w500,
          ),
          const WhiteSpace(
            height: 10,
          ),
          Text(
            'Welcome!!! '
            'Do you want to clear tasks super fast with ToDo?',
            style: GoogleFonts.poppins(
              fontSize: 16.0,
              fontWeight: FontWeight.normal,
              color: ColorsRes.lightGrey,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
