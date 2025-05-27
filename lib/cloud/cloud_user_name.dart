
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:simpletodo/cloud/cloud_constants.dart';

@immutable
class CloudUserName {
  
  final String userName;
  final String userId;  
  const CloudUserName({required this.userId, required this.userName});
 
  // CloudUserName.snapshot(QueryDocumentSnapshot<Map<String,dynamic>>snapshot):
  // userName=snapshot.data()[userNameField],
  // userId=snapshot.data()[userIdFieldName];

   CloudUserName.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot)
    : userName = snapshot.data()?[userNameField] ?? '',
      userId = snapshot.data()?[userIdFieldName] ?? '';
      
}