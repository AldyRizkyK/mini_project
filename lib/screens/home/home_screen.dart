import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/screens/home/add_disease.dart';
import 'package:mini_project/screens/plant/home_page.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ListDisease extends StatefulWidget {
  const ListDisease({
    Key? key,
    required this.firestoreRef,
    required this.collectionName,
  }) : super(key: key);

  final FirebaseFirestore firestoreRef;
  final String collectionName;

  @override
  State<ListDisease> createState() => _ListDiseaseState();
}

class _ListDiseaseState extends State<ListDisease> {
  FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Image";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Daftar Penyakit Tanaman'),
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
                            collectionName: widget.collectionName,
                            firestoreRef: widget.firestoreRef,
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
          child: Column(
            children: [
              Expanded(
                child: FutureBuilder<QuerySnapshot>(
                  future: widget.firestoreRef
                      .collection(widget.collectionName)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isNotEmpty) {
                      List<DocumentSnapshot> arrData = snapshot.data!.docs;
                      // SHOW DATA HERE
                      return GridView.builder(
                        itemCount: arrData.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () async{
                              var uniqueKey =
                                  firestoreRef.collection(collectionName).doc();
                                  // print(uniqueKey.id);
                              firestoreRef
                                  .collection(collectionName)
                                  .doc(arrData[index]['id'])
                                  .delete();
                            },
                            child: Card(
                                child: Column(
                              children: [
                                Image.network(
                                  arrData[index]['image'],
                                  height: 150,
                                  width: 180,
                                  fit: BoxFit.fill,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) {
                                      return child;
                                    } else {
                                      return Center(
                                        child: CircularProgressIndicator(
                                            value: loadingProgress
                                                        .expectedTotalBytes !=
                                                    null
                                                ? loadingProgress
                                                        .cumulativeBytesLoaded /
                                                    loadingProgress
                                                        .expectedTotalBytes!
                                                : null),
                                      );
                                    }
                                  },
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                                Text(arrData[index]['namapen'].length > 25
                                    ? arrData[index]['namapen']
                                            .substring(0, 25) +
                                        '...'
                                    : arrData[index]['namapen']),
                              ],
                            )),
                          );
                        },
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                // banyak grid yang ditampilkan dalam satu baris
                                crossAxisCount: 2),
                      );
                    } else {
                      return const Center(
                        child: Text("No Data Found"),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
