
import 'package:flutter/foundation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:simpletodo/cloud/cloud_constants.dart';

@immutable
class CloudNotes {
 final String documentId;
 final String userId;
 final String userText;

 const CloudNotes({required this.documentId, required this.userId, required this.userText});

 
 CloudNotes.snapshot(QueryDocumentSnapshot<Map<String,dynamic>>snapshot):
 documentId=snapshot.id,
 userId=snapshot.data()[userIdFieldName],
 userText=snapshot.data()[textFieldName] as String;
 
}