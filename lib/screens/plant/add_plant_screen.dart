import 'package:mini_project/models/plant_model.dart';
import 'package:mini_project/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class AddPlantPage extends StatefulWidget {
  const AddPlantPage({
    Key? key,
    // required this.onCreate,
  }) : super(key: key);

  @override
  State<AddPlantPage> createState() => _AddPlantPageState();
}

class _AddPlantPageState extends State<AddPlantPage> {
  // final Function(PlantModel) onCreate;
  final formKey = GlobalKey<FormState>();
  final namePlantController = TextEditingController();
  final latinNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final plantProvider = Provider.of<Plant>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Plant'),
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
                      return 'Add Name Properly';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16,
                ),
                TextFormField(
                  controller: latinNameController,
                  decoration: InputDecoration(
                    fillColor: Colors.grey.withOpacity(0.2),
                    labelText: 'Nama Latin Tanaman',
                    border: const UnderlineInputBorder(),
                    filled: true,
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Add Latin Name Properly';
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
                          latinNameController.text.isEmpty) {
                        return;
                      }
                      final plantItem = PlantModel(
                        id: const Uuid().v1(),
                        nameplant: namePlantController.text,
                        latinName: latinNameController.text,
                      );
                      plantProvider.addPlant(plantItem);
                      Navigator.pop(context);
                    },
                    child: const Text('Add Plant'))
              ],
            ),
          )),
    );
  }
}
