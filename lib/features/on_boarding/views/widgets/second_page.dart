import 'package:flutter/material.dart';

import '../../../../core/common/wiidgets/round_button.dart';
import '../../../../core/common/wiidgets/white_space.dart';
import '../../../../core/resources/image_res.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({Key? key}) : super(key: key);

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
            height: 50.0,
          ),
          RoundButton(
            onPressed: (){},
            title: 'Login with phone',
          ),
        ],
      ),
    );
  }
}
