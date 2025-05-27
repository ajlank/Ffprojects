import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpletodo/cloud/cloud_constants.dart';
import 'package:simpletodo/cloud/cloud_exceptions.dart';
import 'package:simpletodo/cloud/cloud_user_name.dart';

class CloudUserUpdate {
  
  final userNameCollection=FirebaseFirestore.instance.collection('username');

    Future<void>deleteName({required String documentId}) async{
    try{
     await userNameCollection.doc(documentId).delete();
    }catch(e){
      throw CouldNotDeleteNoteException();
    }
  }

  Future<void>updateNote({required String documentId, required String updatedName}) async{
    try{
     await userNameCollection.doc(documentId).update({
      userNameField:updatedName,        
     });
    }catch(e){
      throw CouldNotUpdateNoteException();
    }
  }


   Future<Iterable<CloudUserName>>getuserName({required String userId})async{
   
     return userNameCollection.where(
       userIdFieldName,
       isEqualTo: userId,
     ).get()
     .then((value) => value.docs.map((doc) =>CloudUserName.fromSnapshot(doc) ,),);

   }
  Future<CloudUserName>createNewName({required String userId, required String userName}) async {
   try{
    final updatedNameDocument= await userNameCollection.add({
      userIdFieldName:userId,
      userNameField:userName,
      'createdAt':FieldValue.serverTimestamp()
     });

     final fetchedName=await updatedNameDocument.get();
    return CloudUserName.fromSnapshot(fetchedName);

   }catch(e){
    throw CouldNotUpdateUserNameException();
   }

  }


 static final CloudUserUpdate _shared=CloudUserUpdate._sharedInstance();
  CloudUserUpdate._sharedInstance();
  factory CloudUserUpdate ()=>_shared;

}