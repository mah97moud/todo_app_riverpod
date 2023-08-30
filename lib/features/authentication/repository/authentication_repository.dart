import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:todo_app_riverpod/core/helper/database_helper.dart';
import 'package:todo_app_riverpod/core/utils/core_utils.dart';
import 'package:todo_app_riverpod/features/todo/views/home_screen.dart';

import '../views/otp_verification_screen.dart';

final authRepoProvider = Provider<AuthenticationRepository>(
  (ref) {
    return AuthenticationRepository(
      auth: FirebaseAuth.instance,
    );
  },
);

class AuthenticationRepository {
  const AuthenticationRepository({
    required this.auth,
  });

  final FirebaseAuth auth;

  Future<void> sendOTP({
    required BuildContext context,
    required String phoneNumber,
  }) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      verificationCompleted: (credential) {
        auth.signInWithCredential(credential);
      },
      verificationFailed: (exception) {
        debugPrint('${exception.code}:\n' '${exception.message}');
        CoreUtils.showSnackBar(
          context: context,
          message: '${exception.code}:\n'
              '${exception.message}',
        );
      },
      codeSent: (verificationId, _) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) =>  OTPVerificationScreen(verificationId: verificationId),
          ),
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }

  Future<void> verifyOTP({
    required BuildContext context,
    required String verificationId,
    required String otp,
  }) async {
    try {
      final credential = PhoneAuthProvider.credential(
        verificationId: verificationId,
        smsCode: otp,
      );
      final navigator = Navigator.of(context);
      void showSnack(message) {
        CoreUtils.showSnackBar(
          context: context,
          message: message,
        );
      }

      final userCredential = await auth.signInWithCredential(credential);

      if (userCredential.user != null) {
        //store user to database
        await DBHelper.createUser(isVerified: true);
        navigator.pushAndRemoveUntil(
          MaterialPageRoute(
            builder: (_) => const HomeScreen(),
          ),
          (route) => false,
        );
      } else {
        showSnack('Error Occurred, Fail to sign up user.');
      }
    } on FirebaseException catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: '${e.code}:\n'
            '${e.message}',
      );
    } catch (e) {
      CoreUtils.showSnackBar(
        context: context,
        message: '505: Error Occurred, Failed to sign up user.',
      );
    }
  }
}
