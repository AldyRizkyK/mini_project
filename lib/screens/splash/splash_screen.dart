import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/screens/home/home_screen.dart';

class SplashScreens extends StatefulWidget {
  const SplashScreens({super.key});

  @override
  State<SplashScreens> createState() => _SplashScreensState();
}

class _SplashScreensState extends State<SplashScreens> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const HomeScreen()));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/bgsplash.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            children: [
              const SizedBox(
                height: 90,
              ),
              SizedBox(
                height: 90,
                width: 128,
                child: Image.asset(
                  "assets/images/logos.png",
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Center(
                child: Text(
                  "You Can Grow Your Own Way",
                  style: GoogleFonts.rubik(
                    fontSize: 45,
                    color: const Color.fromARGB(255, 50, 59, 46),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          )),
    );
  }
}
