import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpletodo/cloud/cloud_constants.dart';
import 'package:simpletodo/cloud/cloud_exceptions.dart';
import 'package:simpletodo/cloud/cloud_notes.dart';

class CrudFirebase {

  
  final todoDaily=FirebaseFirestore.instance.collection('tododaily');

  
  Future<void>deleteNote({required String documentId}) async{
    try{
     todoDaily.doc(documentId).delete();
    }catch(e){
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void>updateNote({required String documentId, required String updatedText}) async{
    try{
     todoDaily.doc(documentId).update({
      textFieldName:updatedText        
     });
    }catch(e){
      throw CouldNotUpdateNoteException();
    }
  }

  Stream<Iterable<CloudNotes>>allNotes({required String userId}){
  
     try{
      return todoDaily.orderBy('createdAt',descending: true).snapshots().map((events) =>events.docs.map((doc) => CloudNotes.snapshot(doc),)
    .where((note) =>note.userId==userId,) ,);
     }catch(e){
      throw CouldNotGetNoteException();
     }
  }

  Future<Iterable<CloudNotes>>getNotes({required String userId})async{
        
        try{
          return await todoDaily.where(
          userIdFieldName,
          isEqualTo: userId
        ).get()
        .then((value) => value.docs.map((doc) 
        => CloudNotes.snapshot(doc),),);

        }catch(e){
          throw CouldNotGetNoteException();
        }
  }

  Future<CloudNotes>createNewNote({required String userId})async{
    try{
      final document = await todoDaily.add({
       userIdFieldName:userId,
        textFieldName:'',
        'createdAt':FieldValue.serverTimestamp()
    });

    final fetchedData=await document.get();
    return CloudNotes(
    documentId: fetchedData.id,
    userId: userId, 
    userText: ''
    );
    }catch(e){
      throw CouldNotCreateNoteException();
    }
  }
 static final CrudFirebase _shared = CrudFirebase._sharedInstance();
 CrudFirebase._sharedInstance();
 factory CrudFirebase()=>_shared;

}