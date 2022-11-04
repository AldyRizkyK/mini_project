import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/provider/provider.dart';
import 'package:mini_project/screens/home/add_disease.dart';
import 'package:mini_project/screens/home/home_screen.dart';
import 'package:mini_project/screens/plant/add_plant_screen.dart';
import 'package:mini_project/screens/plant/plant_screen.dart';
import 'package:mini_project/screens/plant/empty_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

class HomePage extends StatefulWidget {
  

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;

  FirebaseStorage storageRef = FirebaseStorage.instance;

  String collectionName = "Image";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Daftar Tanaman Anda'),
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            const SizedBox(
              width: 18,
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Penyakit Tanaman',
                  style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 50, 59, 46),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'Daftar Tanaman',
                  style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 50, 59, 46),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
            ),
            ListTile(
              title: Container(
                padding: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  'List Penyakit',
                  style: GoogleFonts.rubik(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 50, 59, 46),
                    fontWeight: FontWeight.w600,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListDisease(collectionName: collectionName, firestoreRef: firestoreRef,)),
                );
              },
            ),
            const SizedBox(
              width: 18,
            ),
          ],
        ),
      ),
      body: buildHomePage(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // final contactProvider = Provider.of<Contact>(context, listen: false);
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) {
              return const AddPlantPage(
                  // onCreate: (task) {
                  //   contactProvider.addContact(task);
                  //   Navigator.pop(context);
                  // },
                  );
            },
          ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildHomePage() {
    return Consumer<Plant>(
      builder: (context, plant, child) {
        if (plant.plants.isNotEmpty) {
          return PlantScreen(plant: plant);
        } else {
          return const EmptyPage();
        }
      },
    );
  }
}
