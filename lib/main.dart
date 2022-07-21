import 'package:chatapp/blocs/bloc_exports.dart';
import 'package:chatapp/firebase_options.dart';
import 'package:chatapp/res/res_exports.dart';
import 'package:chatapp/screens/auth/splash_screen.dart';
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
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: GetMaterialApp(
        title: 'Flutter Chat App',
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightThemeData(context),
        darkTheme: AppTheme.darkThemeData(context),
        initialRoute: SplashScreen.name,
        getPages: AppRouter.getAppPages(),
      ),
    );
  }
}
