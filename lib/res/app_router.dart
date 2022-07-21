import 'package:chatapp/screens/auth/signin_screen.dart';
import 'package:chatapp/screens/auth/signup_or_signin_screen.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:chatapp/screens/auth/splash_screen.dart';
import 'package:chatapp/screens/chat/chat_screen.dart';
import 'package:chatapp/screens/find_people/search_screen.dart';
import 'package:chatapp/screens/home/home_screen.dart';
import 'package:flutter/foundation.dart' show immutable;
import 'package:get/get.dart';

@immutable
abstract class AppRouter {
  static List<GetPage> getAppPages() => <GetPage>[
        GetPage(
          name: SplashScreen.name,
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: SignupOrSigninScreen.name,
          page: () => const SignupOrSigninScreen(),
        ),
        GetPage(
          name: SignupScreen.name,
          page: () => const SignupScreen(),
        ),
        GetPage(
          name: SigninScreen.name,
          page: () => const SigninScreen(),
        ),
        GetPage(
          name: HomeScreen.name,
          page: () => const HomeScreen(),
        ),
        GetPage(
          name: SearchScreen.name,
          page: () => const SearchScreen(),
        ),
        GetPage(
          name: ChatScreen.name,
          page: () => ChatScreen(),
        ),
      ];
}
