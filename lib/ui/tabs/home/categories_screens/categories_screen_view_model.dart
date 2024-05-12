import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todolist/data/repos/todos_repo/data_sources/online_data_source.dart';
import 'package:todolist/data/repos/todos_repo/todos_repo.dart';
import 'package:todolist/models/todos_dm.dart';

class CategoriesScreenViewModel extends Cubit<TodosState>
{
  CategoriesScreenViewModel(): super(TodosLoadingState());

  TodoRepo todoRepo = TodoRepo(onlineDateSource: OnlineDateSource());
  List<TodoDM> todos = [];
  DateTime selectedDate = DateTime.now();
  void getTodoFromFirestore(String field,Object sortBy, bool isSort) async{
    emit(TodosLoadingState());
    try{
      todos = await todoRepo.getTodoFromFirestore(field, sortBy, isSort , selectedDate);
      if(todos.isNotEmpty) emit(TodosSuccessState(todos: todos));
    }catch(e){
      emit(TodosErrorState());
    }
  }

  void getUpcomingTodoFromFirestore(String field,Object sortBy, bool isSort) async{
    emit(TodosLoadingState());
    try{
      todos = await todoRepo.getUpcomingTodoFromFirestore(field, sortBy, selectedDate, isSort);
      if(todos.isNotEmpty) emit(TodosSuccessState(todos: todos));
    }catch(e){
      emit(TodosErrorState());
    }
  }

  void getImportantTodo(DateTime dateTime, bool isSort) async{
    emit(TodosLoadingState());
    try{
      todos = await todoRepo.getImportantTodos(dateTime, isSort);
      if(todos.isNotEmpty) emit(TodosSuccessState(todos: todos));
    }catch(e){
      emit(TodosErrorState());
    }
  }

  void deleteTodo(String id, String collectionName){
    todoRepo.deleteTodo(id, collectionName);
  }

  void todoUpdate(TodoDM todo){
    todoRepo.updateTodo(
        TodoDM(
            id: todo.id,
            category: todo.category,
            color: todo.color,
            title: todo.title,
            description: todo.description,
            timeFrom: todo.timeFrom,
            timeTo: todo.timeTo,
            date: todo.date,
            day: todo.day,
            isDone: todo.isDone,
            isImportant: todo.isImportant
        )
    );
  }
}

abstract class TodosState{}
class TodosLoadingState extends TodosState{}
class TodosSuccessState extends TodosState{
  List<TodoDM> todos;
  TodosSuccessState({required this.todos});
}
class TodosDeleteSuccessState extends TodosState{}
class TodosErrorState extends TodosState{}