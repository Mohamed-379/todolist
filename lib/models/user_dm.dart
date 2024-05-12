import 'package:cloud_firestore/cloud_firestore.dart';

class UserDM{
  static UserDM? currentUser;
  static bool? isExist;
  static const String collectionName = "Users";
  static const String collectionNameVIP = "VIPUsers";
  late String id;
  late String email;
  late String username;

  UserDM({required this.id, required this.email, required this.username});

  UserDM.fromJson(Map json){
    id = json["id"];
    email = json["email"];
    username = json["user_name"];
  }

  Map<String, dynamic> toJson(){
    return {
      "id" : id,
      "email" : email,
      "user_name" : username
    };
  }

  static CollectionReference<UserDM> getCollection()
  {
    return FirebaseFirestore.instance.collection(UserDM.collectionName).
    withConverter<UserDM>(
      fromFirestore: (snapshot, _) {
        return UserDM.fromJson(snapshot.data()!);
      },
      toFirestore: (user, _) {
        return user.toJson();
      },
    );
  }
}