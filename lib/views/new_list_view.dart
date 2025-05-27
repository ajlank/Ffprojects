import 'package:flutter/material.dart';
import 'package:simpletodo/cloud/cloud_notes.dart';
import 'package:simpletodo/dialoges.dart';

enum ListActionOptions{
  update,
  delete
}

typedef OnCallBack =void Function(CloudNotes note);
class NewListView extends StatelessWidget {

   final Iterable<CloudNotes>allNotes;
   final OnCallBack onDelete;
   final OnCallBack onUpdate;
  const NewListView({super.key, required this.allNotes, required this.onDelete, required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allNotes.length,
      itemBuilder: (context, index) {
        final note = allNotes.elementAt(index);
        return Container(
          margin: EdgeInsets.symmetric(horizontal: 8, vertical:12),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 235, 240, 239),
            borderRadius: BorderRadius.circular(12)
          ),
          child: ListTile(
          title: Text(note.userText),
          tileColor: const Color.fromARGB(255, 235, 240, 239),
          trailing: PopupMenuButton(
            onSelected: (value) async{
              switch(value){
                case ListActionOptions.update:
                    onUpdate(note);
                case ListActionOptions.delete:
                  final val=await showTodoDeleteDialog(context);
                 if(val){
                   onDelete(note);   
                 } 
              }
            },
            itemBuilder: (context) {
              return [
              PopupMenuItem(
                value: ListActionOptions.update,
                child: const Text('Update'),
               ),
               PopupMenuItem(
                value: ListActionOptions.delete,
                child: const Text('Delete'),
               )
              ];
            },
          )
        ),
        );
      },
    );
  }
}

