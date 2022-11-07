import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/widget/drawer_widget.dart';
import 'package:mini_project/screens/home/add_disease.dart';

class Disease extends StatefulWidget {
  const Disease({
    Key? key,
    required this.firestoreRef,
    required this.collectionName,
  }) : super(key: key);

  final FirebaseFirestore firestoreRef;
  final String collectionName;

  @override
  State<Disease> createState() => _DiseaseState();
}

class _DiseaseState extends State<Disease> {
  final FirebaseFirestore firestoreRef = FirebaseFirestore.instance;
  FirebaseStorage storageRef = FirebaseStorage.instance;
  String collectionName = "Image";

  CollectionReference delDisease =
      FirebaseFirestore.instance.collection("Image");

  double turns = 0.0;
  bool isClicked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(
          'Daftar Penyakit Tanaman',
          style: GoogleFonts.rubik(
            fontSize: 20,
            color: const Color.fromARGB(255, 50, 59, 46),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
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
            // ignore: use_build_context_synchronously
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
                  return AddDisease(collectionName: collectionName, firestoreRef: firestoreRef,);
                },
              ),
            );
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.add),
        ),
      ),
      drawer: DrawerWidget(
          collectionName: collectionName, firestoreRef: firestoreRef),
      body: bodyBuild(),
    );
  }

  SafeArea bodyBuild() {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder<QuerySnapshot>(
                future:
                    widget.firestoreRef.collection(widget.collectionName).get(),
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
                          onTap: () {
                            _showModalBottomSheet(context, arrData, index);
                          },
                          onLongPress: () {
                            _showDialogMethod(
                                context, arrData, snapshot, index);
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
                              Text(
                                arrData[index]['namapen'].length > 25
                                    ? arrData[index]['namapen']
                                            .substring(0, 25) +
                                        '...'
                                    : arrData[index]['namapen'],
                                style: GoogleFonts.rubik(
                                  fontSize: 14,
                                  color: const Color.fromARGB(255, 50, 59, 46),
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
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
                    return Center(
                      child: Text(
                        "No Data Found",
                        style: GoogleFonts.rubik(
                          fontSize: 20,
                          color: const Color.fromARGB(255, 50, 59, 46),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> _showModalBottomSheet(BuildContext context,
      List<DocumentSnapshot<Object?>> arrData, int index) {
    return showModalBottomSheet(
      context: context,
      builder: (builder) {
        return Container(
          // height: 350.0,
          color: Colors.transparent,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10.0),
                    topRight: Radius.circular(10.0))),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Text(
                    'Nama Penyakit',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    arrData[index]['namapen'],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    thickness: 5,
                    height: 30,
                  ),
                  Text(
                    'Deskripsi',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    arrData[index]['description'],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    thickness: 5,
                  ),
                  Text(
                    'Penanganan',
                    style: GoogleFonts.rubik(
                      fontSize: 20,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const Divider(
                    thickness: 1,
                  ),
                  Text(
                    arrData[index]['pen'],
                    textAlign: TextAlign.justify,
                    style: GoogleFonts.rubik(
                      fontSize: 14,
                      color: const Color.fromARGB(255, 50, 59, 46),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Future<dynamic> _showDialogMethod(
      BuildContext context,
      List<DocumentSnapshot<Object?>> arrData,
      AsyncSnapshot<QuerySnapshot<Object?>> snapshot,
      int index) {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete'),
        content: const Text('Apakah anda yakin untuk menghapus data?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              FirebaseFirestore.instance.runTransaction(
                (Transaction myTransaction) async {
                  myTransaction.delete(snapshot.data!.docs[index].reference);
                },
              );
              setState(() {
                arrData.length;
              });
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ],
      ),
    );
  }
}
