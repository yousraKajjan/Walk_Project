// *****firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:namaa_poject/firebase_options.dart';
import 'package:namaa_poject/auth/login_page.dart';
import 'package:namaa_poject/auth/signup_page.dart';
import 'package:namaa_poject/home/home_page.dart';
import 'package:namaa_poject/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await cacheHelper.initInstance();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: "/",
      routes: {
        "/": (context) => const SplashScreen(),
        "/login": (context) => const LoginView(),
        "/sign_up": (context) => const SignUpView(),
        "/home": (context) => const HomePage()
      },
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
          actionsIconTheme: IconThemeData(color: Colors.black45),
          iconTheme: IconThemeData(color: Colors.grey),
          backgroundColor: Colors.transparent,
          elevation: 0,
          titleTextStyle: TextStyle(
              color: Colors.indigo, fontSize: 27, fontWeight: FontWeight.bold),
        ),
        colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.indigo)
            .copyWith(error: Colors.amber),
      ),
      // home: const LoginView()
    );
  }
}
