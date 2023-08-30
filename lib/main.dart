import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/app/user_provider.dart';

import 'core/resources/colours.dart';
import 'features/on_boarding/views/on_boarding_screen.dart';
import 'features/todo/views/home_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ScreenUtilInit(
      designSize: const Size(411.4, 843.4),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) {
        return MaterialApp(
          title: 'ToDo App',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lightBlueAccent,
            ),
            scaffoldBackgroundColor: ColorsRes.darkBackground,
            useMaterial3: true,
          ),
          home: ref.watch(userProvider).when(
            data: (userExists) {
              debugPrint('UserExist $userExists');
              if (userExists) return const HomeScreen();
              return const OnBoardingScreen();
            },
            error: (error, stackTrace) {
              debugPrint('Error: $error');
              debugPrint(stackTrace.toString());
              return const OnBoardingScreen();
            },
            loading: () {
              debugPrint('Loading:');
              return const Scaffold(
                body: Center(
                  child: CircularProgressIndicator.adaptive(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
