// ignore_for_file: use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:todolist/ui/auth/register/register_view_model.dart';

import '../login/login.dart';

class Register extends StatefulWidget {

  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  String email = "";
  String password = "";
  String username = "";
  RegisterViewModel viewModel = RegisterViewModel();
  bool isVisible = true;
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          decoration: const BoxDecoration(
              gradient: LinearGradient(colors: [
                Color.fromARGB(255, 72, 108, 189),
                Color.fromARGB(255, 186, 202, 231),
              ])
          ),
          child: Form(
            key: formKey,
            child: Stack(
              children: [
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 55, horizontal: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text("Sing Up",
                        style: TextStyle(fontFamily: "Ubuntu" ,fontSize: 45, fontWeight: FontWeight.bold, color: Colors.white),),
                      Text("Create Your Account",
                        style: TextStyle(fontFamily: "Ubuntu" ,fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 200),
                  child: Container(
                      height: MediaQuery.of(context).size.height * .71,
                      padding: const EdgeInsets.symmetric(horizontal: 14),
                      decoration: const BoxDecoration(
                          color: Color.fromARGB(255, 228, 233, 247),
                          borderRadius: BorderRadius.only(topRight: Radius.circular(40), topLeft: Radius.circular(40))
                      ),
                   child:
                   Column(
                     crossAxisAlignment: CrossAxisAlignment.stretch,
                     children: [
                      SizedBox(height: MediaQuery.of(context).size.height * 0.1,),
                      TextFormField(
                        onChanged: (value) => username = value,
                        style: const TextStyle(fontSize: 18,color: Colors.black, fontFamily: "Ubuntu"),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Color.fromARGB(255, 72, 108, 189)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 72, 108, 189))
                          ),
                          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 72, 108, 189), fontFamily: "Ubuntu"),
                          labelText: "Username",
                          prefixIcon: Icon(Icons.person, color: Color.fromARGB(255, 72, 108, 189),),
                        ),
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return "Username is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      TextFormField(
                        onChanged: (value) => email = value,
                        style: const TextStyle(fontSize: 18,color: Colors.black, fontFamily: "Ubuntu"),
                        cursorColor: Colors.black,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2,color: Color.fromARGB(255, 72, 108, 189)),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 72, 108, 189))
                          ),
                          labelStyle: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,
                              color: Color.fromARGB(255, 72, 108, 189), fontFamily: "Ubuntu"),
                          labelText: "Email",
                          prefixIcon: Icon(Icons.email, color: Color.fromARGB(255, 72, 108, 189)),
                        ),
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return "Email is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      TextFormField(
                        onChanged: (value) => password = value,
                        style: const TextStyle(fontSize: 18, color: Colors.black, fontFamily: "Ubuntu"),
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          border: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1)
                          ),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 2, color: Color.fromARGB(255, 72, 108, 189))
                          ),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(width: 1,color: Color.fromARGB(255, 72, 108, 189))
                          ),
                          labelStyle: const TextStyle(fontFamily: "Ubuntu", fontSize: 20, fontWeight: FontWeight.bold, color: Color.fromARGB(255, 72, 108, 189)),
                          labelText: "Password",
                          prefixIcon: const Icon(Icons.password, color: Color.fromARGB(255, 72, 108, 189),),
                          suffixIcon: IconButton( icon: Icon(isVisible ? Icons.visibility_off : Icons.visibility, color: const Color.fromARGB(255, 72, 108, 189),),
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              }); },),
                        ),
                        obscureText: isVisible,
                        validator: (value) {
                          if(value!.isEmpty)
                          {
                            return "Password is required";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            if(formKey.currentState!.validate())
                            {
                              viewModel.register(context, email, username, password);
                            }
                          },
                          style: const ButtonStyle(backgroundColor: MaterialStatePropertyAll(Color.fromARGB(255, 72, 108, 189)),
                            shape: MaterialStatePropertyAll(RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(15)))),
                            fixedSize: MaterialStatePropertyAll(Size(200, 50)),
                          ),
                          child: const Text("Sing Up", style: TextStyle(fontFamily: "Ubuntu", fontSize: 22,color: Color.fromARGB(255, 235, 239, 251)),),
                        ),
                      ),
                      SizedBox(height: MediaQuery.of(context).size.height * 0.04,),
                      Padding(
                        padding: const EdgeInsets.only(left: 10),
                        child: Row(
                          children: [
                            const Text("Already have an account? ",
                              style: TextStyle(fontFamily: "Ubuntu", fontSize: 18, fontWeight: FontWeight.w400,color: Colors.black),
                            ),
                            InkWell(
                              onTap: () => Navigator.pushReplacementNamed(context, Login.routeName),
                              child: const Text("Login",
                                style: TextStyle(fontFamily: "Ubuntu", fontSize: 18, fontWeight: FontWeight.bold,color: Color.fromARGB(255, 72, 108, 189)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}