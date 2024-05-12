import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/bottom_sheet_dm.dart';
import 'package:todolist/models/todos_dm.dart';
import 'package:todolist/ui/utils/bottom_sheet.dart';
import 'package:todolist/ui/widgets/not_found_widget.dart';
import 'package:todolist/ui/widgets/todo_widget.dart';
import '../../home_screen_view_model.dart';
import '../categories_screen_view_model.dart';

class ImportantScreen extends StatefulWidget {
  String title;
  ImportantScreen({super.key, required this.title});

  @override
  State<ImportantScreen> createState() => _ImportantScreenState();
}

class _ImportantScreenState extends State<ImportantScreen> {

  BottomSheetDM bottomSheetDM = BottomSheetDM();
  CategoriesScreenViewModel viewModel = CategoriesScreenViewModel();
  HomeScreenViewModel homeViewModel = HomeScreenViewModel();

  bool isSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getImportantTodo(viewModel.selectedDate, isSort);
    });
  }

  @override
  Widget build(BuildContext context) {
    viewModel.selectedDate = DateTime.now();
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bottomSheetDM.segmentedControlGroupValue = 0;
          bottomSheetDM.cat = bottomSheetDM.category[0];
          bottomSheetDM.date = DateTime.now();
          bottomSheetDM.timeFrom = TimeOfDay.now();
          bottomSheetDM.timeTo = TimeOfDay.now();
          showTodosBottomSheet(context, bottomSheetDM, homeViewModel, viewModel);
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
                  viewModel.getImportantTodo(viewModel.selectedDate, isSort);
                });
              },
              icon: Image.asset(!isSort ? "assets/images/sort-descending.png": "assets/images/sort.png"))
        ],
      ),
      body: Column(
        children: [
          EasyDateTimeLine(
            initialDate: viewModel.selectedDate,
            onDateChange: (selectedDate) {
              viewModel.selectedDate = selectedDate;
              viewModel.getImportantTodo(viewModel.selectedDate, false);
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
                    fontFamily: "Ubuntu"
                ),
              ),
              activeDayStyle: DayStyle(
                dayNumStyle: TextStyle(
                  fontSize: 18.0,
                  fontFamily: "Ubuntu",
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          SizedBox(height: MediaQuery.of(context).size.height * 0.02,),
          BlocBuilder<CategoriesScreenViewModel, TodosState>(
            bloc: viewModel,
            builder: (context, state) {
              Widget currentWidget;
              if(state is TodosLoadingState){
                currentWidget = Column(
                  children: [
                    SizedBox(height: MediaQuery.of(context).size.height * 0.25,),
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
        itemBuilder: (context, index) => TodoWidget(todo: todos[index], viewModel: viewModel, homeScreenViewModel: homeViewModel),
      ),
    );
  }
}