import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todolist/models/bottom_sheet_dm.dart';
import 'package:todolist/models/todos_dm.dart';
import '../tabs/home/categories_screens/categories_screen_view_model.dart';
import '../tabs/home/home_screen_view_model.dart';
import '../utils/update_bottom_sheet.dart';

class TodoWidget extends StatefulWidget{
  TodoDM todo;
  CategoriesScreenViewModel viewModel;
  HomeScreenViewModel homeScreenViewModel;
  String? firstField;
  Object? firstSortBy;
  String? secondField;
  Object? secondSortBy;
  TodoWidget({super.key, required this.todo, required this.viewModel, required this.homeScreenViewModel,
    this.firstField, this.firstSortBy,
    this.secondField, this.secondSortBy}
  );

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}


BottomSheetDM bottomSheetDM = BottomSheetDM();

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: !widget.todo.expanded ? 125 : 215,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            widget.todo.expanded = !widget.todo.expanded;
          });
        },
        child: Slidable(
          endActionPane: ActionPane(
              motion: const StretchMotion(),
              extentRatio: .30,
              children: [
                SlidableAction(
                  onPressed: (_){
                    deleteTodo();
                  },
                  icon: Icons.delete,
                  backgroundColor: Colors.red,
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(22), bottomLeft: Radius.circular(22)),
                ),
              ]
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: !widget.todo.expanded ? const Color.fromARGB(255, 241, 244, 251):
                const Color.fromARGB(255, 191, 208, 255),
                borderRadius: BorderRadius.circular(25)
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(24),
                      border: Border.all(color: Colors.grey, width: 1.5)
                  ),
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        widget.todo.isDone = !widget.todo.isDone;
                        widget.homeScreenViewModel.addTodoToDoneCollection(widget.todo);
                        deleteTodo();
                      });
                    },
                    child: const CircleAvatar(radius: 22,
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10 , left: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 220,
                        child: Text(widget.todo.title,
                          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 92, 123, 206), fontFamily: "Ubuntu"),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),

                      const SizedBox(height: 6,),
                      Row(
                        children: [
                          Text(
                            "${widget.todo.timeFrom} : ",
                            style: const TextStyle(fontSize: 16, color: Colors.black54, fontFamily: "Ubuntu"),),
                          Text(
                            widget.todo.timeTo,
                            style: const TextStyle(fontSize: 16, color: Colors.black54, fontFamily: "Ubuntu"),),
                        ],
                      ),
                      const SizedBox(height: 6,),
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: Color(widget.todo.color),
                          ),
                          const SizedBox(width: 8,),
                          Text(widget.todo.category,
                            style: const TextStyle(fontSize: 16, color: Color.fromARGB(
                                179, 0, 0, 0), fontFamily: "Ubuntu", fontWeight: FontWeight.bold),)
                        ],
                      ),
                      !widget.todo.expanded ?const SizedBox(): const Flexible(child: SizedBox(height: 8,)),
                      !widget.todo.expanded ? const SizedBox(): Expanded(
                        child: DelayedDisplay(
                          delay: const Duration(milliseconds: 20),
                          fadingDuration: const Duration(milliseconds: 200),
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * .613,
                            child: AutoSizeText(
                              widget.todo.description, style: const TextStyle(
                              fontSize: 16, fontFamily: "Ubuntu", color: Colors.black,
                              ),
                              maxLines: 3,
                              overflow: TextOverflow.visible,
                            ),
                          ),
                        ),
                      ),
                      !widget.todo.expanded ?const SizedBox(): const Spacer(),
                      !widget.todo.expanded ? const SizedBox(): Expanded(
                        child: DelayedDisplay(
                          delay: const Duration(milliseconds: 20),
                          fadingDuration: const Duration(milliseconds: 200),
                          child: Text("Date: ${widget.todo.date.day}/${widget.todo.date.month}/${widget.todo.date.year}",
                            style: const TextStyle(fontSize: 17, color: Colors.black54, fontFamily: "Ubuntu",
                            ),
                            overflow: TextOverflow.visible,
                            //softWrap: true,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(flex: 8,),
                Column(
                  children: [
                    IconButton(
                        onPressed: (){
                          showUpdateTodosBottomSheet(context, bottomSheetDM, widget.homeScreenViewModel, widget.todo, widget.viewModel,
                            widget.firstField, widget.firstSortBy, widget.secondField, widget.secondSortBy
                          );
                        },
                        icon: const Icon(Icons.edit, size: 30, color: Color.fromARGB(255, 92, 123, 206))
                    ),
                    const Spacer(),
                    IconButton(
                        onPressed: (){
                          setState(() {
                            widget.todo.isImportant = !widget.todo.isImportant;
                            widget.viewModel.todoUpdate(widget.todo);
                            if(widget.todo.isImportant == true){
                              widget.homeScreenViewModel.addTodoToImportantCollection(widget.todo);
                            }
                            else{
                              widget.viewModel.deleteTodo(widget.todo.id, TodoDM.importantCollectionName);
                              EasyLoading.showToast("Task Removed of Important List", toastPosition: EasyLoadingToastPosition.bottom);
                              if(widget.firstField == null && widget.secondField == null){
                                widget.viewModel.getImportantTodo(widget.viewModel.selectedDate, false);
                              }
                            }
                          });
                        },
                        icon: Icon(!widget.todo.isImportant ? Icons.star_border : Icons.star, size: 30, color: const Color.fromARGB(255, 92, 123, 206))
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void deleteTodo(){
    widget.viewModel.deleteTodo(widget.todo.id, TodoDM.collectionName);
    widget.viewModel.deleteTodo(widget.todo.id, TodoDM.importantCollectionName);
    if(widget.todo.isDone == false){
      EasyLoading.showToast("Task Removed", toastPosition: EasyLoadingToastPosition.bottom);
    }
    if(widget.firstField == null && widget.secondField == null){
      widget.viewModel.getImportantTodo(widget.viewModel.selectedDate, false);
    }
    if(widget.firstField != null){
      widget.viewModel.getTodoFromFirestore(widget.firstField??"", widget.firstSortBy??"", false);
    }
    if(widget.secondField != null && widget.secondSortBy != DateTime.now()){
      widget.viewModel.getUpcomingTodoFromFirestore(widget.secondField??"", widget.secondSortBy??"", false);
    }
  }
}