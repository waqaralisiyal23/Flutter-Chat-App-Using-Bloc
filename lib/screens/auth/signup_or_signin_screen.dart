import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/auth/components/primary_button.dart';
import 'package:chatapp/screens/auth/signin_screen.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SignupOrSigninScreen extends StatelessWidget {
  const SignupOrSigninScreen({Key? key}) : super(key: key);
  static const name = '/signup_or_signin_screen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.defaultPadding),
          child: Center(
            child: Column(
              children: [
                const Spacer(flex: 2),
                Image.asset(
                  MediaQuery.of(context).platformBrightness == Brightness.light
                      ? Images.logoLight
                      : Images.logoDark,
                  height: 146,
                ),
                const Spacer(),
                PrimaryButton(
                  text: 'Sign In',
                  onPressed: () => Get.toNamed(SigninScreen.name),
                ),
                const SizedBox(height: Constants.defaultPadding * 1.5),
                PrimaryButton(
                  color: Theme.of(context).colorScheme.secondary,
                  text: 'Sign Up',
                  onPressed: () => Get.toNamed(SignupScreen.name),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
