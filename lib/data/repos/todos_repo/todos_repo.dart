import 'package:todolist/data/repos/todos_repo/data_sources/online_data_source.dart';
import 'package:todolist/models/todos_dm.dart';

class TodoRepo
{
  OnlineDateSource onlineDateSource;
  List<TodoDM> todos = [];
  TodoRepo({required this.onlineDateSource});

  void addTodoToFirestore(String category, int color, String title, String description, DateTime date, String timeFrom, String timeTo)
  {
    onlineDateSource.addTodoToFirestore(category, color, title, description, date, timeFrom, timeTo);
  }

  void addTodoToImportantCollection(TodoDM todo){
    onlineDateSource.addTodoToImportant(todo);
  }

  Future<List<TodoDM>> getTodoFromFirestore(String field, Object sortBy, bool isSort, DateTime dateTime) async
  {
   todos = await onlineDateSource.getTodos(field, sortBy, isSort, dateTime);
   if(todos.isNotEmpty){
     return todos;
   }
   throw Exception("Something went wrong, Please try again later");
  }

  void addDoneTodosToCollection(TodoDM todo){
    onlineDateSource.addTodosToDoneCollection(todo);
  }

  Future<List<TodoDM>> getDoneTodos(bool isSort) async{
    todos = await onlineDateSource.getDoneTodos(isSort);
    if(todos.isNotEmpty){
      return todos;
    }
    throw Exception("Something went wrong, Please try again later");
  }

  Future<List<TodoDM>> getImportantTodos(DateTime dateTime, bool isSort) async{
    todos = await onlineDateSource.getImportantTodos(dateTime, isSort);
    if(todos.isNotEmpty){
      return todos;
    }
    throw Exception("Something went wrong, Please try again later");
  }

  Future<List<TodoDM>> getUpcomingTodoFromFirestore(String field, Object sortBy, DateTime dateTime, bool isSort) async
  {
    todos = await onlineDateSource.getUpcomingTodos(field, sortBy, dateTime, isSort);
    if(todos.isNotEmpty){
      return todos;
    }
    throw Exception("Something went wrong, Please try again late");
  }

  void deleteTodo(String id, String collectionName){
    onlineDateSource.deleteTodo(id, collectionName);
  }

  void updateTodo(TodoDM todo){
    onlineDateSource.updateTodo(todo);
  }
}