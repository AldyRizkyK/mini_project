import 'package:google_fonts/google_fonts.dart';
import 'package:mini_project/models/plant_model.dart';
import 'package:mini_project/view_model/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPlant extends StatefulWidget {
  const AddPlant({
    Key? key,
    // required this.onCreate,
  }) : super(key: key);

  @override
  State<AddPlant> createState() => _AddPlantState();
}

class _AddPlantState extends State<AddPlant> {
  // final Function(PlantModel) onCreate;
  final formKey = GlobalKey<FormState>();
  final namePlantController = TextEditingController();
  final qtyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<Plant>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add Plant',
          style: GoogleFonts.rubik(
            fontSize: 20,
            color: const Color.fromARGB(255, 50, 59, 46),
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Form(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: namePlantController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    labelText: 'Nama Tanaman',
                    border: const UnderlineInputBorder(),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tambahkan Nama Tanaman';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: qtyController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    labelText: 'Jumlah Tanaman Anda',
                    border: const UnderlineInputBorder(),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Tambahkan Jumlah';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size.fromHeight(40)),
                    onPressed: () {
                      setState(() {
                        formKey.currentState!.validate();
                      });
                      if (namePlantController.text.isEmpty ||
                          qtyController.text.isEmpty) {
                        return;
                      }
                      final plantItem = PlantModel(
                        id: const Uuid().v1(),
                        nameplant: namePlantController.text,
                        qty: qtyController.text,
                      );
                      plantProvider.addPlant(plantItem);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Add Plant',
                      style: GoogleFonts.rubik(
                        fontSize: 15,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ))
              ],
            ),
          )),
    );
  }
}
