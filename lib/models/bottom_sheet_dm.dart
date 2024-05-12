import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BottomSheetDM{
  int segmentedControlGroupValue = 0;
  Map<int, Widget> tabs = const {
    0: Column(
      children: [
        Icon(
          CupertinoIcons.circle_filled,
          color: Color.fromARGB(255, 92, 123, 206),
        ),
        Text("Personal", style: TextStyle(fontFamily: "Ubuntu"))
      ],
    ),
    1: Column(
      children: [
        Icon(
          CupertinoIcons.circle_filled,
          color: Color.fromARGB(255, 146, 106, 163),
        ),
        Text("Learning", style: TextStyle(fontFamily: "Ubuntu"))
      ],
    ),
    2: Column(
      children: [
        Icon(
          CupertinoIcons.circle_filled,
          color: Color.fromARGB(255, 96, 140, 193),
        ),
        Text("Work", style: TextStyle(fontFamily: "Ubuntu"))
      ],
    ),
    3: Column(
      children: [
        Icon(
          CupertinoIcons.circle_filled,
          color: Color.fromARGB(255, 237, 121, 120),
        ),
        Text("Shopping", style: TextStyle(fontFamily: "Ubuntu"))
      ],
    ),
  };
  List<String> category = ["Personal", "Learning", "Work", "Shopping"];
  List<Color> colors = [
    const Color.fromARGB(255, 92, 123, 206),
    const Color.fromARGB(255, 146, 106, 163),
    const Color.fromARGB(255, 96, 140, 193),
    const Color.fromARGB(255, 237, 121, 120)
  ];
  String? cat;
  DateTime date = DateTime.now();
  TimeOfDay timeFrom = TimeOfDay.now();
  TimeOfDay timeTo = TimeOfDay.now();
  final formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
}