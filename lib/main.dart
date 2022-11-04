import 'package:flutter/material.dart';
import 'package:mini_project/provider/provider.dart';
import 'package:mini_project/screens/home/home_screen.dart';
import 'package:mini_project/screens/plant/add_plant_screen.dart';
import 'package:mini_project/screens/plant/home_page.dart';
import 'package:provider/provider.dart';
import 'constans.dart';
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
            primaryColor: Colors.green,
            useMaterial3: true),
        home: const SplashScreens(),
        // routes: {
        //   '/': (context) => const SplashScreens(),
        //   '/homepage': (context) => const HomePage(),
        // },

        // return MaterialApp(
        //   title: 'Flutter Demo',
        //   debugShowCheckedModeBanner: false,
        //   theme: ThemeData(
        //       primaryColor: kPrimaryColor,
        //       textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextColor),
        //       visualDensity: VisualDensity.adaptivePlatformDensity,
        //       useMaterial3: true),
        //   home: const SplashScreens(),
        // );
      ),
    );
  }
}
