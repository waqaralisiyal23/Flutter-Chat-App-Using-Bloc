import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/auth/signin_screen.dart';
import 'package:chatapp/screens/auth/signup_or_signin_screen.dart';
import 'package:chatapp/screens/auth/signup_screen.dart';
import 'package:chatapp/screens/auth/splash_screen.dart';
import 'package:chatapp/screens/chat/individual_chat_screen.dart';
import 'package:chatapp/screens/find_people/search_screen.dart';
import 'package:chatapp/screens/home/home_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init(); // Initialize Storage Driver
  BlocOverrides.runZoned(
    () => runApp(const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AuthBloc()),
        BlocProvider(create: (_) => HomeBloc()),
      ],
      child: GetMaterialApp(
        title: 'Flutter Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData(context),
        darkTheme: AppTheme.darkThemeData(context),
        initialRoute: SplashScreen.name,
        getPages: getAllPages(),
      ),
    );
  }

  List<GetPage> getAllPages() {
    return [
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
        name: IndividualChatScreen.name,
        page: () => const IndividualChatScreen(),
      ),
    ];
  }
}
