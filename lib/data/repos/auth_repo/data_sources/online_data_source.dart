import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:todolist/ui/tabs/main_tab.dart';
import '../../../../../models/user_dm.dart';
import '../../../../ui/auth/login/login.dart';
import '../../../../ui/utils/dialog_utils.dart';

class OnlineDataSource
{
  void login(BuildContext context, String email, String password) async{
    try{
      //todo: Show loading dialog
      showLoadingDialog(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
      UserDM currentUser = await getUserFromFirestore(userCredential.user!.uid);
      UserDM.currentUser = currentUser;
      Stopwatch stopwatch = Stopwatch()..start();
      //todo: Hide loading dialog
      // navigate home screen
      Future.delayed(Duration(seconds: stopwatch.elapsed.inSeconds + 2),(){
        hideLoadingDialog(context);
        EasyLoading.showToast("Successfully Login", toastPosition: EasyLoadingToastPosition.bottom);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainTab()));
      });
    }on FirebaseAuthException catch(e){
      //todo: Hide loading dialog
      hideLoadingDialog(context);
      //todo: Show Errors dialog
      showErrorsDialog(context, e.message ?? "Something went wrong\nPlease try again later");
    }
  }

  Future<UserDM> getUserFromFirestore(String id) async{
    CollectionReference<UserDM> collectionReference = UserDM.getCollection();
    DocumentSnapshot<UserDM> doc = await collectionReference.doc(id).get();
    return doc.data()!;
  }

  void deleteUserFromFirestore(String userId) async
  {
    CollectionReference collectionReference = UserDM.getCollection();
    await collectionReference.doc(userId).delete();
  }

  void register(BuildContext context, String email , String username, String password) async{
    try{
      //todo: Show loading dialog
      showLoadingDialog(context);
      UserCredential userCredential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);
      UserDM newUser = UserDM(id: userCredential.user!.uid, email: email, username: username);
      await addUserToFirebase(newUser);
      UserDM.currentUser = newUser;
      Stopwatch stopwatch = Stopwatch()..start();
      //todo: Hide loading dialog
      // navigate home screen
      Future.delayed(Duration(seconds: stopwatch.elapsed.inSeconds + 2),(){
        hideLoadingDialog(context);
        EasyLoading.showToast("The Account Was Created Successfully.", toastPosition: EasyLoadingToastPosition.bottom);
        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const MainTab()));
      });
    }on FirebaseAuthException catch(e){
      //todo: Hide loading dialog
      hideLoadingDialog(context);
      //todo: Show Errors dialog
      showErrorsDialog(context, e.message ?? "Something went wrong\nPlease try again later");
    }
  }

  Future addUserToFirebase(UserDM user) async {
    CollectionReference<UserDM> usersCollection = UserDM.getCollection();
    usersCollection.doc(user.id).set(user);
  }

  void deleteUser(BuildContext context) async
  {
    EasyLoading.show(status: "Loading...");
    try{
      await FirebaseAuth.instance.currentUser?.delete();
      deleteUserFromFirestore(UserDM.currentUser!.id);
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Login(),));
      EasyLoading.showToast("Account Deleted Successfully", toastPosition: EasyLoadingToastPosition.bottom);
    }on FirebaseAuthException catch(e){
      EasyLoading.showError(e.message ?? "Something went wrong please try again later.");
    }
  }

  void updateUsernameFirestore(String username){
    CollectionReference collectionReference = UserDM.getCollection();
    collectionReference.doc(UserDM.currentUser!.id).update({"user_name": username});
  }

  void updateEmailFirestore(String email){
    CollectionReference collectionReference = UserDM.getCollection();
    collectionReference.doc(UserDM.currentUser!.id).update({"email": email});
  }

  void updateUsername(String username)
  {
    updateUsernameFirestore(username);
  }

  void updateEmail(String email) async
  {
    var user = FirebaseAuth.instance.currentUser;
    await user!.updateEmail(email);
    updateEmailFirestore(email);
  }
}