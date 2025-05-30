import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/constants/route_constants.dart';
import 'package:simpletodo/utilites/notifierval.dart';
import 'package:simpletodo/views/create_note_view.dart';
import 'package:simpletodo/views/email_verify_view.dart';
import 'package:simpletodo/views/login_view.dart';
import 'package:simpletodo/views/notes_view.dart';
import 'package:simpletodo/views/sign_up_view.dart';
import 'firebase_options.dart';
void main() {
  runApp(
    MyMaterialApp()
    );
}

class MyMaterialApp extends StatelessWidget {
  const MyMaterialApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(valueListenable: notifier,
     builder: (context, value, child) {
       return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal, 
        brightness: value?Brightness.light:Brightness.dark),
      ),
      home: HomeView(),
      routes: {
        signUpRoute:(context)=>SignUpView(),
        loginRoute:(context)=>LoginView(),
        notesRoute:(context)=>NotesView(),
        emailverifyRoute:(context)=>EmailVerifyView(),
        notesCreateRoute:(context)=>CreateNoteView()
      },
    );
     },);
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,),
      builder: (context, snapshot) {
      switch(snapshot.connectionState){
        case ConnectionState.done:
           final user=FirebaseAuth.instance.currentUser;
       if(user!=null){
        if(user.emailVerified){
          return NotesView();
        }else{
          return EmailVerifyView();
        }
       }else{
         return LoginView();
       }
          default:
          return const CircularProgressIndicator();
      }
      },);
  }
}
