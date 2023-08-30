import 'package:flutter/material.dart';
import 'package:todo_app_riverpod/features/authentication/views/sign_in_screen.dart';

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
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const SignInScreen(),
                ),
              );
            },
            title: 'Login with phone',
          ),
        ],
      ),
    );
  }
}
