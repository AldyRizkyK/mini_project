import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mini_project/screens/home/home_screen.dart';

class AddDisease extends StatefulWidget {
  const AddDisease({
    Key? key,
    required this.collectionName,
    required this.firestoreRef,
  }) : super(key: key);

  final String collectionName;
  final FirebaseFirestore firestoreRef;

  @override
  State<AddDisease> createState() => _AddDiseaseState();
}

class _AddDiseaseState extends State<AddDisease> {
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
        }).then((value) => _showMessage("Data Inserted"));
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
      content: Text(
        msg,
        style: GoogleFonts.rubik(
          fontSize: 20,
          color: Colors.green,
          fontWeight: FontWeight.w600,
        ),
      ),
      duration: const Duration(seconds: 3),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => Disease(
                          collectionName: widget.collectionName,
                          firestoreRef: widget.firestoreRef,
                        )),
              );
            }),
        centerTitle: true,
        title: Text(
          'Tambah Penyakit Tanaman',
          style: GoogleFonts.rubik(
            fontSize: 20,
            color: const Color.fromARGB(255, 50, 59, 46),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: SingleChildScrollView(
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
                    ElevatedButton(
                        onPressed: () {
                          imagePicker();
                        },
                        child: Text(
                          "Select Image",
                          style: GoogleFonts.rubik(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
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
                        child: Text(
                          "Upload",
                          style: GoogleFonts.rubik(
                            fontSize: 15,
                            color: Colors.green,
                            fontWeight: FontWeight.w600,
                          ),
                        )),
                  ],
                ),
        ),
      ),
    );
  }
}
