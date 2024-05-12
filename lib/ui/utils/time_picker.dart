import 'package:flutter/material.dart';

Future<String> timePicker(StateSetter setState, BuildContext context) async {
  TimeOfDay time = TimeOfDay.now();
  time = await showTimePicker(
    context: context,
    initialTime: time,
    builder: (context, child) {
      return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 72, 108, 189),
                onPrimary: Colors.white,
                tertiaryContainer: Color.fromARGB(255, 72, 108, 189),
                onTertiaryContainer: Colors.white),
          ),
          child: child!);
    },
  ) ?? time;
  setState(() {});
  return time.format(context).toString();
}