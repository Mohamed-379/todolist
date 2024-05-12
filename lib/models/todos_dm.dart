import 'package:cloud_firestore/cloud_firestore.dart';

class TodoDM{
  static const String collectionName = "todos";
  static const String importantCollectionName = "important";
  static const String doneCollectionName = "done";
  late String id;
  late String category;
  late int color;
  late String title;
  late String description;
  late String timeFrom;
  late String timeTo;
  late DateTime date;
  late int day;
  late bool isDone;
  late bool isImportant;
  bool expanded = false;

  TodoDM(
      {
        required this.id,
        required this.category,
        required this.color,
        required this.title,
        required this.description,
        required this.timeFrom,
        required this.timeTo,
        required this.date,
        required this.day,
        required this.isDone,
        required this.isImportant
      });

  TodoDM.fromJson(Map json){
    id = json["id"];
    category = json["category"];
    color = json["color"];
    title = json["title"];
    description = json["description"];
    timeFrom = json["timeFrom"];
    timeTo = json["timeTo"];
    Timestamp timestamp = json["date"];
    date = timestamp.toDate();
    day = json["day"];
    isDone = json["isDone"];
    isImportant = json["isImportant"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "category" : category,
      "color" : color,
      "title" : title,
      "description" : description,
      "timeFrom" : timeFrom,
      "timeTo" : timeTo,
      "date" : date,
      "day" : day,
      "isDone" : isDone,
      "isImportant" : isImportant,
    };
  }

  static CollectionReference<TodoDM> getCollection()
  {
    return FirebaseFirestore.instance.collection(TodoDM.collectionName).
    withConverter<TodoDM>(
      fromFirestore: (snapshot, _) {
        return TodoDM.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }
}