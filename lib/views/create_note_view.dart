import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/cloud/cloud_notes.dart';
import 'package:simpletodo/cloud/crud_firebase.dart';
import 'package:simpletodo/utilites/get_argument.dart';

class CreateNoteView extends StatefulWidget {
  const CreateNoteView({super.key});

  @override
  State<CreateNoteView> createState() => _CreateNoteViewState();
}

class _CreateNoteViewState extends State<CreateNoteView> {
   CloudNotes? _notes;
   late final CrudFirebase _crudFirebase;
   late final TextEditingController _textController;
  
  @override
  void initState() {
    _crudFirebase=CrudFirebase();
    _textController=TextEditingController();
    super.initState();
  }

  void _textControllerListener()async{
    final note=_notes;
    if(note==null){
      return;
    }
    final text=_textController.text;
    await _crudFirebase.updateNote(documentId: note.documentId, updatedText: text);
  }

  void _setupTextControllerListener(){
    _textController.removeListener(_textControllerListener);
    _textController.addListener(_textControllerListener);
  }

  void _deleteNoteIfTextEmpty()async{
    final note=_notes;
    if(_textController.text.isEmpty && note!=null){
      await _crudFirebase.deleteNote(documentId: note.documentId);
    }
  }

  void _saveNoteIfTextNotEmpty()async{
    final note=_notes;
     final text=_textController.text;
    if(_textController.text.isNotEmpty && note!=null){
      await _crudFirebase.updateNote(documentId: note.documentId,
       updatedText: text);
    }
  }

  Future<CloudNotes>_createOrGetExistingNotes(BuildContext context)async{

    final widgetNote=context.getArgument<CloudNotes>();
    if(widgetNote!=null){
    _textController.text=widgetNote.userText;
    _notes=widgetNote;
    return widgetNote;
    }
    
    final existingNote=_notes;
    if(existingNote!=null){
      return existingNote;
    }
    final userId=FirebaseAuth.instance.currentUser!.uid;

    final newNote=await _crudFirebase.createNewNote(userId: userId);
    _notes=newNote;
    return newNote;
  }

  @override
  void dispose() {
    _deleteNoteIfTextEmpty();
    _saveNoteIfTextNotEmpty();
    _textController.dispose();  
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 215, 219, 218),
        title: const Text('Create your notes'),
      ),
      body:FutureBuilder(future: _createOrGetExistingNotes(context),
       builder:(context, snapshot) {
         switch(snapshot.connectionState){
           case ConnectionState.done:
             _setupTextControllerListener();
           return Padding(
             padding: const EdgeInsets.fromLTRB(3, 5, 0, 0),
             child: TextField(
              controller: _textController,
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Write your note..'
              ),
              maxLines: null,
             ),
           );
           default:
           return const CircularProgressIndicator();
         }
       },)
    );
  }
}
