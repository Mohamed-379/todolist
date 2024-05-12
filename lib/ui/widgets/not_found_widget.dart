import 'package:flutter/material.dart';

class NotFoundWidget extends StatelessWidget {
  const NotFoundWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: MediaQuery.of(context).size.height * 0.28,),
          const Text("No tasks found",
            style: TextStyle(fontSize: 35, color: Colors.black54, fontFamily: "Ubuntu", fontWeight: FontWeight.bold),)
        ],
      ),
    );
  }
}
