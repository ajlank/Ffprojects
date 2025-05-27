
import 'package:flutter/material.dart';

Future<bool>showTodoDeleteDialog(BuildContext context){
  return showDialog(
    context: context, 
    builder: (context) {
      return AlertDialog(
        title: const Text('Delete'),
        content: const Text('Want to delete this note?'),
        actions: [
          TextButton(onPressed: (){
             if(context.mounted){
              Navigator.of(context).pop(false);
             }
          }, child: const Text('No')),
          TextButton(onPressed: (){
             if(context.mounted){
              Navigator.of(context).pop(true);
             }
          }, child: const Text('Yes')),
        ],
      );
    },
    ).then((value) => value??false);
}