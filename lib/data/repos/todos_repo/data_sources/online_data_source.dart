import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/models/todos_dm.dart';
import 'package:todolist/models/user_dm.dart';

class OnlineDateSource{
  List<TodoDM> todos = [];
  void addTodoToFirestore(String category, int color, String title, String description, DateTime date, String timeFrom, String timeTo) async{
    CollectionReference collectionReference = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.collectionName);
    DocumentReference documentReference = collectionReference.doc();
    await documentReference.set(
        TodoDM(
            id: documentReference.id,
            category: category,
            color: color,
            title: title,
            description: description,
            timeFrom: timeFrom,
            timeTo: timeTo,
            date: date,
            day: date.day,
            isDone: false,
            isImportant: false
        ).toJson()
    );
  }

  void addTodoToImportant(TodoDM todo) async{
    CollectionReference collectionReference = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.importantCollectionName);
    DocumentReference documentReference = collectionReference.doc(todo.id);
    await documentReference.set(
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
        ).toJson()
    );
  }

  void addTodosToDoneCollection(TodoDM todo) async{
    CollectionReference doneTodosCollection = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.doneCollectionName);
    DocumentReference documentReference = doneTodosCollection.doc(todo.id);
    await documentReference.set(
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
            isImportant: todo.isImportant).toJson()
    );
  }

  Future<List<TodoDM>> getTodos(String field, Object sortBy, bool isSort, DateTime dateTime) async{
    Query<TodoDM> todosCollectionReference =
    UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.collectionName).
    withConverter(
      fromFirestore: (snapshot, options) {
        Map json = snapshot.data() as Map;
        TodoDM todos = TodoDM.fromJson(json);
        return todos;
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).orderBy("date", descending: isSort).where(field, isEqualTo: sortBy);

    QuerySnapshot<TodoDM> querySnapshot =  await todosCollectionReference.get();
    List<QueryDocumentSnapshot<TodoDM>> docs = querySnapshot.docs;
    todos = docs.map((todo) {
      return todo.data();
    }).toList();
    if(todos.isNotEmpty)
    {
      todos = todos.where((todo) {
        if(todo.date.day != dateTime.day || todo.date.month != dateTime.month || todo.date.year != dateTime.year){
          return false;
        }
        else{
          return true;
        }
      }).toList();
      return todos;
    }
    throw "Something went wrong please try again later";
  }

  Future<List<TodoDM>> getImportantTodos(DateTime dateTime, bool isSort) async{
   CollectionReference<TodoDM> importantTodosCollectionReference =
   UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.importantCollectionName).
   withConverter<TodoDM>(
       fromFirestore: (snapshot, options) {
         Map json = snapshot.data() as Map;
         TodoDM todos = TodoDM.fromJson(json);
         return todos;
       },
       toFirestore: (value, options) {
         return value.toJson();
       },
   );

  QuerySnapshot<TodoDM> querySnapshot =  await importantTodosCollectionReference.
  orderBy("date", descending: isSort).get();
  List<QueryDocumentSnapshot<TodoDM>> docs = querySnapshot.docs;

  todos = docs.map((todo) => todo.data()).toList();

  if(todos.isNotEmpty){
    todos = todos.where((todo) {
      if(todo.date.day != dateTime.day || todo.date.month != dateTime.month || todo.date.year != dateTime.year){
        return false;
      }
      else{
        return true;
      }
    }).toList();
    return todos;
    }
   throw "Something went wrong please try again later";
  }
  
  Future<List<TodoDM>> getDoneTodos(bool isSort) async{
    CollectionReference<TodoDM> doneTodosCollection = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.doneCollectionName).withConverter(
        fromFirestore: (snapshot, options) {
          Map json = snapshot.data() as Map;
          TodoDM todos = TodoDM.fromJson(json);
          return todos;
        }, 
        toFirestore: (value, options) {
          return value.toJson();
        },
    );

    QuerySnapshot<TodoDM> querySnapshot = await doneTodosCollection.orderBy('date', descending: isSort).get();
    List<QueryDocumentSnapshot<TodoDM>> docs =  querySnapshot.docs;
    
    todos = docs.map((todo) => todo.data()).toList();
    
    if(todos.isNotEmpty){
      return todos;
    }
    
    throw Exception("Something went wrong please try again later.");
  }

  Future<List<TodoDM>> getUpcomingTodos(String field, Object sortBy, DateTime dateTime, bool isSort) async{
    Query<TodoDM> todosCollectionReference =
    UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.collectionName).
    withConverter(
      fromFirestore: (snapshot, options) {
        Map json = snapshot.data() as Map;
        TodoDM todos = TodoDM.fromJson(json);
        return todos;
      },
      toFirestore: (value, options) {
        return value.toJson();
      },
    ).orderBy("date", descending: isSort).where(field, isGreaterThan: sortBy);

    QuerySnapshot<TodoDM> querySnapshot =  await todosCollectionReference.get();
    List<QueryDocumentSnapshot<TodoDM>> docs = querySnapshot.docs;
    todos = docs.map((todo) {
      return todo.data();
    }).toList();
    if(todos.isNotEmpty)
    {
      todos = todos.where((todo) {
        if(todo.date.day != dateTime.day || todo.date.month != dateTime.month || todo.date.year != dateTime.year){
          return false;
        }
        else{
          return true;
        }
      }).toList();
      return todos;
    }
    throw "Something went wrong please try again later";
  }

  void deleteTodo(String id, String collectionName){
    CollectionReference todosCollection = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(collectionName);
    todosCollection.doc(id).delete();
  }

  void updateTodo(TodoDM todo){
    CollectionReference todoCollectionReference = UserDM.getCollection().doc(UserDM.currentUser!.id).collection(TodoDM.collectionName);
    todoCollectionReference.doc(todo.id).update(
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
        ).toJson()
    );
  }
}