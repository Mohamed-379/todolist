import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

showLoadingDialog(BuildContext context)
{
  return showDialog(
    barrierDismissible: false,
    context: context,
    useSafeArea: true,
    builder: (context) {
    return Center(
      child: Container(
        width: 160,
        height: 140,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(18)),
        ),
        child: Center(child: LoadingAnimationWidget.staggeredDotsWave(color: const Color.fromARGB(255, 72, 108, 189), size: 55)),
      ),
    );
  },);
}

hideLoadingDialog(BuildContext context)
{
  Navigator.pop(context);
}

showErrorsDialog(BuildContext context, String message)
{
  showDialog(context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.white,
        elevation: 0,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15))),
        title: const Text("Error!",textAlign: TextAlign.center,
            style: TextStyle(fontFamily: "Ubuntu", fontSize: 22, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 72, 108, 189))),
        content: Text(message, style: const TextStyle(fontFamily: "Ubuntu", fontSize: 20, color: Color.fromARGB(255, 72, 108, 189))),
        actions: [
          Center(
            child: TextButton(onPressed: (){
              Navigator.pop(context);
            }, child: const Text("Ok", style: TextStyle(color: Color.fromARGB(255, 72, 108, 189), fontFamily: "Ubuntu", fontSize: 20, fontWeight: FontWeight.bold),),),
          )
        ],
      ),
  );
}