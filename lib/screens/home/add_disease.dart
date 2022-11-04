import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project/screens/home/home_screen.dart';
import 'package:mini_project/screens/plant/home_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String imageName = "";
  XFile? imagePath;
  final ImagePicker _picker = ImagePicker();
  var descriptionController = TextEditingController();
  var namapenController = TextEditingController();
  var penController = TextEditingController();

  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Image";

  bool _isLoading = false;

  imagePicker() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        imagePath = image;
        // descriptionController.text = Faker().lorem.sentence();
        imageName = image.name.toString();
      });
    }
  }

  _uploadImage() async {
    setState(() {
      _isLoading = true;
    });
    var uniqueKey = firestoreRef.collection(collectionName).doc();
    String uploadFileName = "${DateTime.now().millisecondsSinceEpoch}.jpg";
    Reference reference =
        storageRef.ref().child(collectionName).child(uploadFileName);
    UploadTask uploadTask = reference.putFile(File(imagePath!.path));

    uploadTask.snapshotEvents.listen((event) {});

    await uploadTask.whenComplete(() async {
      var uploadPath = await uploadTask.snapshot.ref.getDownloadURL();

      if (uploadPath.isNotEmpty) {
        firestoreRef.collection(collectionName).doc(uniqueKey.id).set({
          "description": descriptionController.text,
          "namapen": namapenController.text,
          'pen': penController.text,
          "image": uploadPath
        }).then((value) => _showMessage("Record Inserted"));
      } else {
        _showMessage("Something While Uploading Image");
      }
      setState(() {
        _isLoading = false;
        namapenController.text = "";
        descriptionController.text = "";
        penController.text = "";
        imageName = "";
      });
    });
  }

  _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(msg),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Tambah Penyakit Tanaman'),
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
                  MaterialPageRoute(
                      builder: (context) => ListDisease(
                            collectionName: collectionName,
                            firestoreRef: firestoreRef,
                          )),
                );
              },
            ),
            const SizedBox(
              width: 18,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    imageName == "" ? Container() : Text(imageName),
                    const SizedBox(
                      height: 10,
                    ),
                    OutlinedButton(
                        onPressed: () {
                          imagePicker();
                        },
                        child: const Text("Select Image")),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: namapenController,
                      decoration: const InputDecoration(
                          labelText: "Nama Penyakit",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: "Description",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: penController,
                      minLines: 3,
                      maxLines: 5,
                      decoration: const InputDecoration(
                          labelText: "Penanganan",
                          border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          _uploadImage();
                        },
                        child: const Text("Upload")),
                    // listdisease(firestoreRef: firestoreRef, collectionName: collectionName),
                  ],
                ),
        ),
      ),
    );
  }
}
