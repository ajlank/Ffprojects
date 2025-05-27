import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/cloud/cloud_notes.dart';
import 'package:simpletodo/cloud/crud_firebase.dart';
import 'package:simpletodo/constants/route_constants.dart';
import 'package:simpletodo/views/new_list_view.dart';
import 'package:simpletodo/widgets/drwer_widget_view.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final CrudFirebase crudFirebaseOp;
  String get userId => FirebaseAuth.instance.currentUser!.uid;

  @override
  void initState() {
    crudFirebaseOp = CrudFirebase();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: DrwerWidgetView(),
      appBar: AppBar(
        title: const Text('Notes View'),
        backgroundColor: const Color.fromARGB(255, 215, 219, 218),
        actions: [
          IconButton(
            onPressed: () {
              if (context.mounted) {
                Navigator.of(context).pushNamed(notesCreateRoute);
              } else {
                return;
              }
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body:StreamBuilder(
        stream: crudFirebaseOp.allNotes(userId: userId),
         builder: (context, snapshot) {
           switch(snapshot.connectionState){
             case ConnectionState.waiting:
             case ConnectionState.active:
             if(snapshot.hasData){
              final allNotes=snapshot.data as Iterable<CloudNotes>;
              return NewListView(allNotes: allNotes);
             }else{
              return const CircularProgressIndicator();
             }
            default:
            return const CircularProgressIndicator();
           }
         },)
    );
  }
}