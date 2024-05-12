import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/bottom_sheet_dm.dart';
import 'package:todolist/models/todos_dm.dart';
import 'package:todolist/ui/utils/bottom_sheet.dart';
import 'package:todolist/ui/widgets/not_found_widget.dart';
import 'package:todolist/ui/widgets/todo_widget.dart';

import '../home_screen_view_model.dart';
import 'categories_screen_view_model.dart';


class CategoriesTab extends StatefulWidget {
  String field;
  Object sortBy;
  String title;
  CategoriesTab({super.key, required this.field, required this.sortBy, required this.title});

  @override
  State<CategoriesTab> createState() => _CategoriesTabState();
}

class _CategoriesTabState extends State<CategoriesTab> {

  BottomSheetDM bottomSheetDM = BottomSheetDM();
  CategoriesScreenViewModel viewModel = CategoriesScreenViewModel();
  HomeScreenViewModel homeViewModel = HomeScreenViewModel();

  bool isSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getTodoFromFirestore(widget.field, widget.sortBy, isSort);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheetDM.segmentedControlGroupValue = 0;
          bottomSheetDM.cat = bottomSheetDM.category[0];
          bottomSheetDM.date = DateTime.now();
          bottomSheetDM.timeFrom = TimeOfDay.now();
          bottomSheetDM.timeTo = TimeOfDay.now();
          showTodosBottomSheet(context, bottomSheetDM, homeViewModel, viewModel, widget.field, widget.sortBy);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color.fromARGB(255, 72, 108, 189),
        focusColor: Colors.white,
        isExtended: true,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 228, 233, 247),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: Text(widget.title, style: const TextStyle(fontSize: 30, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),),
        leading: IconButton(
            onPressed: (){
              Navigator.pop(context);
            },
            icon: const Icon(CupertinoIcons.back, size: 35, color: Colors.black,)
        ),
        actions: [
          IconButton(
              onPressed: (){
                setState(() {
                  isSort = !isSort;
                  viewModel.getTodoFromFirestore(widget.field, widget.sortBy, isSort);
                });
              },
              icon: Image.asset(!isSort ? "assets/images/sort-descending.png": "assets/images/sort.png"))
        ],
      ),
      body: Column(
        children: [
          widget.title != "My day" ? EasyDateTimeLine(
            initialDate: DateTime.now(),
            onDateChange: (selectedDate) {
              viewModel.selectedDate = selectedDate;
              viewModel.getTodoFromFirestore(widget.field, widget.sortBy, false);
            },
            activeColor: const Color.fromARGB(255, 72, 108, 189),
            headerProps: const EasyHeaderProps(
              dateFormatter: DateFormatter.monthOnly(),
            ),
            dayProps: const EasyDayProps(
              height: 56.0,
              width: 56.0,
              dayStructure: DayStructure.dayNumDayStr,
              inactiveDayStyle: DayStyle(
                borderRadius: 48.0,
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ) : const SizedBox(),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          BlocBuilder<CategoriesScreenViewModel, TodosState>(
            bloc: viewModel,
            builder: (context, state) {
                Widget currentWidget;
                if(state is TodosLoadingState){
                  currentWidget = Column(
                    children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.29,),
                      const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 72, 108, 189),)),
                    ],
                  );
                }
                else if(state is TodosSuccessState){
                  currentWidget = buildTodosList(state.todos);
                }else{
                  currentWidget = const NotFoundWidget();
                }
                return currentWidget;
            },
          ),
        ],
      ),
    );
  }

  Widget buildTodosList(List<TodoDM> todos) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: todos.length,
        itemBuilder: (context, index) => TodoWidget(todo: todos[index], viewModel: viewModel, homeScreenViewModel: homeViewModel,
          firstField: widget.field,
          firstSortBy: widget.sortBy,
        ),
      ),
    );
  }
}