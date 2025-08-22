import 'package:flutter/material.dart';
import 'package:projek_mini/Tugas13/home_page.dart';
import 'package:projek_mini/Tugas13/login.dart';
import 'package:projek_mini/Tugas13/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
      ),
      initialRoute: SplashScreen.id,
      routes: {
        Login.id: (context) => const Login(),
        Homepage.id: (context) => const Homepage(),
        SplashScreen.id: (context) => const SplashScreen(),
      },
    );
  }
}
