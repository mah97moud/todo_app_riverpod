import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:todo_app_riverpod/features/on_boarding/views/widgets/first_page.dart';
import 'package:todo_app_riverpod/features/on_boarding/views/widgets/second_page.dart';

import '../../../core/common/wiidgets/fading_text.dart';
import '../../../core/resources/colours.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  final _pageController = PageController();

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            PageView(
              controller: _pageController,
              children: const [
                FirstPage(),
                SecondPage(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 20.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton.icon(
                    onPressed: () {
                      _pageController.nextPage(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.bounceInOut,
                      );
                    },
                    label: const FadingText(
                      'Skip',
                      fontSize: 16.0,
                      fontWeight: FontWeight.w500,
                    ),
                    icon: const Icon(
                      size: 30.0,
                      color: ColorsRes.light,
                      Ionicons.chevron_forward_circle,
                    ),
                  ),

                  // Swipe indicator
                  SmoothPageIndicator(
                    controller: _pageController,
                    count: 2,
                    effect: ExpandingDotsEffect(
                      dotHeight: 12,
                      spacing: 10.0,
                      dotColor: ColorsRes.yellow.withOpacity(0.5),
                      activeDotColor: ColorsRes.light,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
/**
 *
*/
