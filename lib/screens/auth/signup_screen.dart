import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/global_widgets.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/auth/components/auth_field.dart';
import 'package:chatapp/screens/auth/components/primary_button.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);
  static const name = '/signup_screen';

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final TextEditingController nameController;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
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
                        height: 100,
                      ),
                      const SizedBox(height: 40),
                      AuthField(
                        controller: nameController,
                        hintText: 'Enter Name',
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                      ),
                      const SizedBox(height: 20),
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
                          return authState.signupLoading
                              ? circularProgress()
                              : PrimaryButton(
                                  text: 'Sign Up',
                                  onPressed: () {
                                    FocusScope.of(context).unfocus();
                                    context.read<AuthBloc>().add(
                                          SignUpEvent(
                                              name: nameController.text.trim(),
                                              email:
                                                  emailController.text.trim(),
                                              password:
                                                  passwordController.text),
                                        );
                                  },
                                );
                        },
                      ),
                      const SizedBox(height: 20),
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
