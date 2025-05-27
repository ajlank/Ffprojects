import 'package:flutter/material.dart';
import 'package:simpletodo/cloud/cloud_notes.dart';

class NewListView extends StatelessWidget {
   final Iterable<CloudNotes>allNotes;
 
  const NewListView({super.key, required this.allNotes});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: allNotes.length,
      itemBuilder: (context, index) {
        final note = allNotes.elementAt(index);
        return Padding(
          padding: const EdgeInsets.fromLTRB(3, 12, 0, 20),
          child: ListTile(
            title: Text(note.userText),
            tileColor: const Color.fromARGB(255, 235, 240, 239),
          ),
        );
      },
    );
  }
}
