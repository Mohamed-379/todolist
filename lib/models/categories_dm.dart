import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CategoryDM
{
  Color backgroundColor;
  String title;
  IconData iconData;

  CategoryDM({
    required this.backgroundColor,
    required this.title,
    required this.iconData
  });

  static List<CategoryDM> category = [
    CategoryDM(
        backgroundColor: const Color.fromARGB(255, 92, 123, 206),
        title: "Personal",
        iconData: Icons.person
    ),
    CategoryDM(
        backgroundColor: const Color.fromARGB(255, 146, 106, 163),
        title: "Learning",
        iconData: CupertinoIcons.pencil
    ),
    CategoryDM(
        backgroundColor: const Color.fromARGB(255, 96, 140, 193),
        title: "Work",
        iconData: Icons.work_rounded
    ),
    CategoryDM(
        backgroundColor: const Color.fromARGB(255, 237, 121, 120),
        title: "Shopping",
        iconData: Icons.shopping_bag_rounded
    )
  ];
}