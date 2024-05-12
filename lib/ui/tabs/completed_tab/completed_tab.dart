import 'package:auto_size_text/auto_size_text.dart';
import 'package:delayed_display/delayed_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/models/todos_dm.dart';
import 'package:todolist/ui/tabs/completed_tab/completed_tab_view_model.dart';
import 'package:todolist/ui/tabs/home/categories_screens/categories_screen_view_model.dart';

class CompletedTab extends StatefulWidget {
  const CompletedTab({super.key});

  @override
  State<CompletedTab> createState() => _CompletedTabState();
}

CompletedTabViewModel viewModel = CompletedTabViewModel();
CategoriesScreenViewModel categoriesScreenViewModel = CategoriesScreenViewModel();

class _CompletedTabState extends State<CompletedTab> {

  bool isSort = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      viewModel.getDoneTodos(false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text("Completed Tasks",
          style: TextStyle(fontFamily: "Ubuntu", fontSize: 28, fontWeight:  FontWeight.bold),),
        actions: [
          IconButton(
              onPressed: (){
            setState(() {
              isSort = !isSort;
              viewModel.getDoneTodos(isSort);
            });
          },
              icon: Image.asset(!isSort ? "assets/images/sort-descending.png": "assets/images/sort.png"))
        ],
      ),
      body: BlocBuilder<CompletedTabViewModel, DoneTodosState>(
          bloc: viewModel,
          builder: (context, state) {
            Widget currentWidget;
            if(state is DoneTodosLoadingState){
              currentWidget = const Center(child: CircularProgressIndicator(color: Color.fromARGB(255, 72, 108, 189),),);
            }
            else if(state is DoneTodosSuccessState)
              {
                currentWidget = buildTodosList(state.todos);
              }
            else{
              currentWidget = const Center(child: Text("No completed tasks found",
                style: TextStyle(fontSize: 28, fontFamily: "Ubuntu", fontWeight: FontWeight.bold, color: Colors.black54),));
            }
            return currentWidget;
          },
      ),
    );
  }

  Widget buildTodosList(List<TodoDM> todos) {
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) => buildDoneTodoWidget(todos[index]),
    );
  }

  buildDoneTodoWidget(TodoDM todo) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: !todo.expanded ? 125 : 215,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: GestureDetector(
        onTap: () {
          setState(() {
            todo.expanded = !todo.expanded;
          });
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
              color: !todo.expanded ? const Color.fromARGB(255, 241, 244, 251):
              const Color.fromARGB(89, 72, 108, 189),
              borderRadius: BorderRadius.circular(25)
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(color: Colors.grey, width: 1.5)
                ),
                child: const CircleAvatar(radius: 22,
                  backgroundColor: Colors.transparent,
                  child: Image(image: AssetImage("assets/images/done.png")),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10 , left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 220,
                      child: Text(todo.title,
                        style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                            fontFamily: "Ubuntu",
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),

                    const SizedBox(height: 6,),
                    Row(
                      children: [
                        Text(
                          "${todo.timeFrom} : ",
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Ubuntu"
                          ),),
                        Text(
                          todo.timeTo,
                          style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: "Ubuntu",
                          ),),
                      ],
                    ),
                    const SizedBox(height: 6,),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 8,
                          backgroundColor: Color(todo.color),
                        ),
                        const SizedBox(width: 8,),
                        Text(todo.category,
                          style: const TextStyle(fontSize: 16, color: Colors.black, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),)
                      ],
                    ),
                    !todo.expanded ?const SizedBox(): const Flexible(child: SizedBox(height: 8,)),
                    !todo.expanded ? const SizedBox(): Expanded(
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 20),
                        fadingDuration: const Duration(milliseconds: 200),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * .613,
                          child: AutoSizeText(
                            todo.description, style: const TextStyle(
                            fontSize: 16, fontFamily: "Ubuntu", color: Colors.black,
                          ),
                            maxLines: 3,
                            overflow: TextOverflow.visible,
                          ),
                        ),
                      ),
                    ),
                    !todo.expanded ?const SizedBox(): const Spacer(),
                    !todo.expanded ? const SizedBox(): Expanded(
                      child: DelayedDisplay(
                        delay: const Duration(milliseconds: 20),
                        fadingDuration: const Duration(milliseconds: 200),
                        child: Text("Date: ${todo.date.day}/${todo.date.month}/${todo.date.year}",
                          style: const TextStyle(fontSize: 17, color: Colors.black, fontFamily: "Ubuntu",
                          ),
                          overflow: TextOverflow.visible,
                          //softWrap: true,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              IconButton(onPressed: (){
                categoriesScreenViewModel.deleteTodo(todo.id, TodoDM.doneCollectionName);
                viewModel.getDoneTodos(false);
              }, icon: const Icon(Icons.delete, color: Colors.black,))
            ],
          ),
        ),
      ),
    );
  }
}