import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EmptyPlantScreen extends StatelessWidget {
  const EmptyPlantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.add_alert, color: Colors.green,),
            Text(
              'You Dont Have Any Plant',
              style: GoogleFonts.rubik(
                fontSize: 15,
                color: const Color.fromARGB(255, 50, 59, 46),
                fontWeight: FontWeight.w600,
              ),
            )
          ],
        ),
      ),
    );
  }
}
