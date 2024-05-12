import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todolist/models/bottom_sheet_dm.dart';
import 'package:todolist/models/todos_dm.dart';
import 'package:todolist/ui/utils/time_picker.dart';
import 'package:todolist/ui/widgets/text_field_widget.dart';
import '../tabs/home/categories_screens/categories_screen_view_model.dart';
import '../tabs/home/home_screen_view_model.dart';
import 'date_picker.dart';

void showUpdateTodosBottomSheet(
    BuildContext context, BottomSheetDM bottomSheetDM, HomeScreenViewModel viewModel, TodoDM todo,
    [CategoriesScreenViewModel? categoryViewModel, String? field, Object? sortBy, String? upcomingField, Object? upcomingSortBy]
    )
{
  if(todo.category == "Personal"){
    bottomSheetDM.segmentedControlGroupValue = 0;
  }
  else if(todo.category == "Learning"){
    bottomSheetDM.segmentedControlGroupValue = 1;
  }
  else if(todo.category == "Work"){
    bottomSheetDM.segmentedControlGroupValue = 2;
  }
  else{
    bottomSheetDM.segmentedControlGroupValue = 3;
  }
  bottomSheetDM.cat = todo.category;
  bottomSheetDM.titleController.text = todo.title;
  bottomSheetDM.descriptionController.text = todo.description;
  bottomSheetDM.date = todo.date;
  String timeFrom = todo.timeFrom;
  String timeTo = todo.timeTo;
  showMaterialModalBottomSheet(
    isDismissible: false,
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) => Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: SingleChildScrollView(
        child: StatefulBuilder(
          builder: (context, setState) => Form(
            key: bottomSheetDM.formKey,
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 244, 251),
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(30)),
              ),
              height: MediaQuery.of(context).size.height * .8,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Center(
                    child: Text(
                      "Edit task",
                      style: TextStyle(fontSize: 22, fontFamily: "Ubuntu"),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  const Text(
                    "Edit category",
                    style: TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
                    textAlign: TextAlign.start,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  CupertinoSlidingSegmentedControl(
                    groupValue: bottomSheetDM.segmentedControlGroupValue,
                    children: bottomSheetDM.tabs,
                    onValueChanged: (value) {
                      setState(() {
                        bottomSheetDM.segmentedControlGroupValue = value!;
                        bottomSheetDM.cat = bottomSheetDM.category[bottomSheetDM.segmentedControlGroupValue];
                      });
                    },
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  TextFieldWidget(label: "Edit title", controller: bottomSheetDM.titleController,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.03,
                  ),
                  TextFieldWidget(label: "Edit description", controller: bottomSheetDM.descriptionController,),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.04,
                  ),
                  const Text(
                    "Edit date:",
                    style: TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
                  ),
                  Center(
                    child: TextButton(
                        onPressed: () {
                          datePicker(setState, context, bottomSheetDM);
                        },
                        child: Text(
                          "${bottomSheetDM.date.day}/${bottomSheetDM.date.month}/${bottomSheetDM.date.year}",
                          style: const TextStyle(
                              color: Colors.black54,
                              fontFamily: "Ubuntu",
                              fontSize: 18),
                        )),
                  ),
                  const Text(
                    "Edit time:",
                    style: TextStyle(fontSize: 18, fontFamily: "Ubuntu"),
                  ),
                  const SizedBox(height: 10,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("From: ", style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),),
                      const SizedBox(width: 2,),
                      TextButton(
                          onPressed: () async{
                              timeFrom = await timePicker(setState, context);
                          },
                          style: const ButtonStyle(
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                              side: BorderSide(width: 1, color: Colors.black),
                              borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(12))
                            ))
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 3, right: 4),
                                child: Icon(CupertinoIcons.time_solid, color: Colors.black54, size: 18,),
                              ),
                              Text(
                                timeFrom,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Ubuntu",
                                    fontSize: 17),
                              ),
                            ],
                          )),
                      const SizedBox(width: 10,),
                      const Text("To: ", style: TextStyle(fontSize: 17, fontFamily: "Ubuntu"),),
                      const SizedBox(width: 2,),
                      TextButton(
                          onPressed: () async{
                            timeTo = await timePicker(setState, context);
                          },
                          style: const ButtonStyle(
                              shape: MaterialStatePropertyAll(RoundedRectangleBorder(
                                  side: BorderSide(width: 1, color: Colors.black),
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(12), bottom: Radius.circular(12))
                              ))
                          ),
                          child: Row(
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 3, right: 4),
                                child: Icon(CupertinoIcons.time_solid, color: Colors.black54, size: 18,),
                              ),
                              Text(
                                timeTo,
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontFamily: "Ubuntu",
                                    fontSize: 17),
                              ),
                            ],
                          )),
                    ],
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      //todo:addTodo
                      if (bottomSheetDM.formKey.currentState!.validate()) {
                        categoryViewModel?.todoUpdate(
                            TodoDM(
                                id: todo.id,
                                category: bottomSheetDM.category[bottomSheetDM.segmentedControlGroupValue],
                                color: bottomSheetDM.colors[bottomSheetDM.segmentedControlGroupValue].value,
                                title: bottomSheetDM.titleController.text,
                                description: bottomSheetDM.descriptionController.text,
                                timeFrom: timeFrom,
                                timeTo: timeTo,
                                date: bottomSheetDM.date,
                                day: bottomSheetDM.date.day,
                                isDone: todo.isDone,
                                isImportant: todo.isImportant
                            )
                        );
                        bottomSheetDM.titleController.clear();
                        bottomSheetDM.descriptionController.clear();
                        if(field != null && sortBy != null){
                          categoryViewModel?.getTodoFromFirestore(field, sortBy, false);
                        }
                        else if(upcomingField != null && upcomingSortBy != null && bottomSheetDM.date != DateTime.now()){
                          categoryViewModel?.getUpcomingTodoFromFirestore(upcomingField, upcomingSortBy, false);
                        }
                        Navigator.pop(context);
                        setState((){});
                        return;
                      }
                    },
                    style: const ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 72, 108, 189)),
                      padding: MaterialStatePropertyAll(EdgeInsets.all(15)),
                      shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.vertical(bottom: Radius.circular(13), top: Radius.circular(13))))
                    ),
                    child: const Text(
                      "Edit task",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "Ubuntu",
                          fontSize: 18),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}