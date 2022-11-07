import 'package:flutter/material.dart';
import 'package:mini_project/view_model/provider.dart';
import 'package:provider/provider.dart';
import 'screens/splash/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Plant(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primaryColor: const Color.fromARGB(255, 255, 255, 255),
            useMaterial3: true),
        home: const SplashScreens(),
      ),
    );
  }
}
