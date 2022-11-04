import 'package:mini_project/models/plant_model.dart';
import 'package:flutter/material.dart';
import 'package:mini_project/provider/provider.dart';

class PlantScreen extends StatelessWidget {
  const PlantScreen({
    Key? key,
    required this.plant,
  }) : super(key: key);
  final Plant plant;

  @override
  Widget build(BuildContext context) {
    final plantItems = plant.plants;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: ListView.separated(
        itemCount: plantItems.length,
        itemBuilder: (context, index) {
          PlantModel item = plantItems[index];
          return buildContactItem(context, item, index);
        },
        separatorBuilder: (context, index) {
          return const SizedBox(
            height: 16,
          );
        },
      ),
    );
  }

  Widget buildContactItem(BuildContext context, PlantModel item, int index) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(left: 16, right: 16),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.nameplant,
                  style: const TextStyle(
                      fontSize: 14, fontWeight: FontWeight.w600),
                ),
                Text(
                  item.latinName,
                  style: TextStyle(
                      fontSize: 14, color: Colors.black.withOpacity(0.6)),
                ),
              ],
            ),
          ),
          IconButton(
              onPressed: () {
                plant.deletePlant(
                  index,
                );
              },
              icon: Icon(
                Icons.delete,
                color: Colors.grey[600],
              ))
        ],
      ),
    );
  }
}
