import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todolist/ui/auth/login/login.dart';
import 'package:todolist/ui/splash_screen/splash_screen.dart';
import 'package:todolist/ui/tabs/home/home_screen.dart';
import 'package:todolist/ui/tabs/main_tab.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      maintainBottomViewPadding: true,
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          routes: {
            Login.routeName: (_) => const Login(),
            HomeScreen.routeName: (_) => const HomeScreen(),
            MainTab.routeName: (_) => const MainTab()
          },
          home: const SplashScreen(),
          builder: EasyLoading.init(),
        )
    );
  }
}