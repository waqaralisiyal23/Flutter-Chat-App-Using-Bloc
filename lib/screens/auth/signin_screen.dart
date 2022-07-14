import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/auth/components/auth_field.dart';
import 'package:chatapp/screens/auth/components/primary_button.dart';
import 'package:flutter/material.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);
  static const name = '/signin_screen';

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: size.width,
            height: size.height,
            alignment: Alignment.center,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: Constants.defaultPadding),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset(
                        MediaQuery.of(context).platformBrightness ==
                                Brightness.light
                            ? Images.logoLight
                            : Images.logoDark,
                        height: 120,
                      ),
                      const SizedBox(height: 40),
                      AuthField(
                        controller: emailController,
                        hintText: 'Enter Email',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      const SizedBox(height: 20),
                      AuthField(
                        controller: passwordController,
                        hintText: 'Enter Password',
                        textInputAction: TextInputAction.done,
                        obscureText: true,
                      ),
                      const SizedBox(height: 40),
                      BlocBuilder<AuthBloc, AuthState>(
                        builder: (context, authState) {
                          return authState.signinLoading
                              ? circularProgress()
                              : PrimaryButton(
                                  text: 'Sign In',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    context.read<AuthBloc>().add(
                                          SignInEvent(
                                            email: emailController.text.trim(),
                                            password: passwordController.text,
                                          ),
                                        );
                                  },
                                );
                        },
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
