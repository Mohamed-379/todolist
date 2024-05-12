import 'package:flutter/material.dart';
import 'package:todolist/models/bottom_sheet_dm.dart';

void datePicker(StateSetter setState, BuildContext context, BottomSheetDM bottomSheetDM) async {
  bottomSheetDM.date = await showDatePicker(
    context: context,
    initialDate: bottomSheetDM.date,
    firstDate: DateTime.now(),
    lastDate: DateTime.now().add(const Duration(days: 365)),
    builder: (context, child) {
      return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
                primary: Color.fromARGB(255, 72, 108, 189),
                onPrimary: Colors.white,
                onSurface: Color.fromARGB(255, 72, 108, 189),
                tertiaryContainer: Color.fromARGB(255, 72, 108, 189),
                onTertiaryContainer: Colors.white),
          ),
          child: child!);
    },
  ) ??
      bottomSheetDM.date;
  setState(() {});
}