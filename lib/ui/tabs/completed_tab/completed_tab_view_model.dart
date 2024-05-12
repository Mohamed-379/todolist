import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/repos/todos_repo/data_sources/online_data_source.dart';
import 'package:todolist/data/repos/todos_repo/todos_repo.dart';
import '../../../models/todos_dm.dart';

class CompletedTabViewModel extends Cubit<DoneTodosState>
{
  CompletedTabViewModel(): super(DoneTodosLoadingState());

  TodoRepo todoRepo = TodoRepo(onlineDateSource: OnlineDateSource());
  List<TodoDM> todos = [];
  void getDoneTodos(bool isSort) async{
    emit(DoneTodosLoadingState());
    try{
      todos = await todoRepo.getDoneTodos(isSort);
      if(todos.isNotEmpty) emit(DoneTodosSuccessState(todos: todos));
    }catch(e){
      emit(DoneTodosErrorState());
    }
  }
}

abstract class DoneTodosState{}
class DoneTodosSuccessState extends DoneTodosState{
  List<TodoDM> todos;
  DoneTodosSuccessState({required this.todos});
}
class DoneTodosLoadingState extends DoneTodosState{}
class DoneTodosErrorState extends DoneTodosState{}