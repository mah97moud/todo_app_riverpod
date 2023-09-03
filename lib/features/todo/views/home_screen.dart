import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/filled_text_field.dart';
import 'package:todo_app_riverpod/core/common/wiidgets/white_space.dart';
import 'package:todo_app_riverpod/core/helper/database_helper.dart';

import '../../../core/resources/colours.dart';
import '../../authentication/views/sign_in_screen.dart';
import '../app/task_provider.dart';
import '../widgets/active_tasks.dart';
import '../widgets/completed_tasks.dart';
import 'add_task_screen.dart';

class HomeScreen extends HookConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    final screenHeight = screenSize.height;
    final tabController = useTabController(initialLength: 2);
    final tabTextStyle = GoogleFonts.poppins(
      fontSize: 16,
      color: ColorsRes.darkBackground,
      fontWeight: FontWeight.bold,
    );

    ref.read(taskProvider.notifier).refresh();

    
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(85),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RotatedBox(
                      quarterTurns: 2,
                      child: IconButton(
                        onPressed: () async {
                          final navigator = Navigator.of(context);
                          await DBHelper.deleteUser();
                          navigator.pushAndRemoveUntil(
                            MaterialPageRoute(
                                builder: (_) => const SignInScreen()),
                            (route) => false,
                          );
                        },
                        icon: const Icon(
                          AntDesign.logout,
                          color: ColorsRes.light,
                        ),
                      ),
                    ),
                    Text(
                      'Task Management',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        color: ColorsRes.light,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton.filled(
                      style: IconButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(9.0),
                        ),
                        backgroundColor: ColorsRes.light,
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const AddOrEditTaskScreen(),
                          ),
                        );
                      },
                      icon: const Icon(
                        Icons.add,
                        color: ColorsRes.darkBackground,
                      ),
                    ),
                  ],
                ),
                const WhiteSpace(height: 20.0),
                const FilledTextField(
                  prefixIcon: Icon(
                    AntDesign.search1,
                    color: ColorsRes.lightGrey,
                  ),
                  hintText: 'Search',
                  suffixIcon: Icon(
                    FontAwesome.sliders,
                    color: ColorsRes.lightGrey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.symmetric(
            horizontal: 20.0.w,
            vertical: 25.0.h,
          ),
          children: [
            Row(
              children: [
                const Icon(
                  FontAwesome.tasks,
                  size: 20.0,
                  color: ColorsRes.light,
                ),
                const WhiteSpace(width: 10.0),
                Text(
                  'Today\'s Tasks',
                  style: GoogleFonts.poppins(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: ColorsRes.light,
                  ),
                ),
              ],
            ),
            const WhiteSpace(height: 25.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: ColoredBox(
                color: ColorsRes.light,
                child: TabBar(
                  controller: tabController,
                  indicatorSize: TabBarIndicatorSize.label,
                  indicator: BoxDecoration(
                    color: ColorsRes.lightGrey,
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  labelPadding: EdgeInsets.zero,
                  isScrollable: false,
                  labelColor: ColorsRes.lightBlue,
                  labelStyle: GoogleFonts.poppins(
                    fontSize: 24.0,
                    color: ColorsRes.lightBlue,
                    fontWeight: FontWeight.bold,
                  ),
                  unselectedLabelColor: ColorsRes.light,
                  tabs: [
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        child: Center(
                          child: Text(
                            'Pending',
                            style: tabTextStyle,
                          ),
                        ),
                      ),
                    ),
                    Tab(
                      child: SizedBox(
                        width: screenWidth * 0.5,
                        child: Center(
                          child: Text(
                            'Completed',
                            style: tabTextStyle,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const WhiteSpace(height: 20.0),
            SizedBox(
              height: screenHeight * 0.26,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0),
                child: TabBarView(
                  controller: tabController,
                  children:  [
                    const ActiveTasks(),
                    const CompletedTasks()
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
