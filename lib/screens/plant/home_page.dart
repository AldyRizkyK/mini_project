// ignore_for_file: use_build_context_synchronously

import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/widget/drawer_widget.dart';
import 'package:mini_project/view_model/provider.dart';
import 'package:mini_project/screens/plant/add_plant_screen.dart';
import 'package:mini_project/screens/plant/plant_screen.dart';
import 'package:mini_project/screens/plant/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class YourPlant extends StatefulWidget {
  const YourPlant({super.key});

  @override
  State<YourPlant> createState() => _YourPlantState();
}

class _YourPlantState extends State<YourPlant> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  FirebaseStorage storageRef = FirebaseStorage.instance;

  String collectionName = "Image";

  double turns = 0.0;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Daftar Tanaman Anda',
          style: GoogleFonts.rubik(
            fontSize: 20,
            color: const Color.fromARGB(255, 50, 59, 46),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      drawer: DrawerWidget(
          collectionName: collectionName, firestoreRef: firestoreRef),
      body: buildHomePage(),
      floatingActionButton: AnimatedRotation(
        curve: Curves.easeOutExpo,
        turns: turns,
        duration: const Duration(seconds: 1),
        child: FloatingActionButton(
          onPressed: () async {
            if (isClicked) {
              setState(() => turns -= 1 / 4);
            } else {
              setState(() => turns += 1 / 4);
            }
            isClicked = !isClicked;
            await Future.delayed(const Duration(milliseconds: 200));

            Navigator.push(
              context,
              PageRouteBuilder(
                transitionDuration: const Duration(seconds: 1),
                transitionsBuilder: (BuildContext context,
                    Animation<double> animation,
                    Animation<double> secAnimation,
                    Widget child) {
                  animation = CurvedAnimation(
                      parent: animation, curve: Curves.elasticIn);

                  return ScaleTransition(
                      scale: animation,
                      alignment: Alignment.center,
                      child: child);
                },
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secAnimation) {
                  return const AddPlant();
                },
              ),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(
            Icons.add,
          ),
        ),
      ),
    );
  }

  Widget buildHomePage() {
    return Consumer<Plant>(
      builder: (context, plant, child) {
        if (plant.plants.isNotEmpty) {
          return PlantScreen(plant: plant);
        } else {
          return const EmptyPlantScreen();
        }
      },
    );
  }
}
