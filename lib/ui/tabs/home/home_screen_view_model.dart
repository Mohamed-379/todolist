import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todolist/data/repos/todos_repo/data_sources/online_data_source.dart';
import 'package:todolist/data/repos/todos_repo/todos_repo.dart';

import '../../../models/todos_dm.dart';

class HomeScreenViewModel extends Cubit<DataState>
{
  HomeScreenViewModel(): super(DataLoadingState());
  TodoRepo todoRepo = TodoRepo(onlineDateSource: OnlineDateSource());

  void addTodoToFirestore(String category, int color, String title, String description, DateTime date, String timeFrom, String timeTo){
    try{
      emit(DataLoadingState());
      todoRepo.addTodoToFirestore(category, color, title, description, date, timeFrom, timeTo);
      emit(DataSuccessState());
      EasyLoading.showToast("Added Task Successfully", toastPosition: EasyLoadingToastPosition.bottom);
    }catch(e){
      emit(DataErrorState());
      EasyLoading.showToast("Failure To Add Task", toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  addTodoToImportantCollection(TodoDM todo){
    try{
      emit(DataLoadingState());
      todoRepo.addTodoToImportantCollection(todo);
      emit(DataSuccessState());
      EasyLoading.showToast("Added Task Successfully", toastPosition: EasyLoadingToastPosition.bottom);
    }catch(e){
      emit(DataErrorState());
      EasyLoading.showToast("Failure To Add Task", toastPosition: EasyLoadingToastPosition.bottom);
    }
  }

  addTodoToDoneCollection(TodoDM todo){
    try{
      emit(DataLoadingState());
      todoRepo.addDoneTodosToCollection(todo);
      emit(DataSuccessState());
      EasyLoading.showToast("Completed Task Successfully", toastPosition: EasyLoadingToastPosition.bottom);
    }catch(e){
      emit(DataErrorState());
      EasyLoading.showToast("Failure To Complete Task", toastPosition: EasyLoadingToastPosition.bottom);
    }
  }
}

abstract class DataState{}
class DataLoadingState extends DataState{}
class DataSuccessState extends DataState{}
class DataErrorState extends DataState{}