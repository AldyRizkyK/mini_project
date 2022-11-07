// ignore_for_file: use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/screens/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mini_project/screens/plant/home_page.dart';

class DrawerWidget extends StatefulWidget {
  const DrawerWidget({
    Key? key,
    required this.collectionName,
    required this.firestoreRef,
  }) : super(key: key);

  final String collectionName;
  final FirebaseFirestore firestoreRef;

  @override
  State<DrawerWidget> createState() => _DrawerWidgetState();
}

class _DrawerWidgetState extends State<DrawerWidget> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.green,
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 20),
              color: Colors.white,
              child: Row(
                children: [
                  const SizedBox(
                    width: 20,
                  ),
                  Image.asset("assets/images/logo.png"),
                  const SizedBox(
                    width: 40,
                  ),
                  Text(
                    "Florist",
                    style: GoogleFonts.rubik(
                      fontSize: 35,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w700,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Penyakit Tanaman',
                  style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Disease(
                            collectionName: widget.collectionName,
                            firestoreRef: widget.firestoreRef,
                          )),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Tanaman Anda',
                  style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 255, 255, 255),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const YourPlant()),
                );
              },
            ),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      ),
    );
  }
}
