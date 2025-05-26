import 'package:flutter/material.dart';

Future<void>showErrorDialog(BuildContext context){
  return showDialog(context: context,
   builder: (context) {
    return AlertDialog(
      title: const Text('An error occured'),
      content: const Text('Talk to the developer at [ ajlankhanofficial23@gmail.com '),
      actions: [
        TextButton(onPressed: (){
            Navigator.of(context).pop();
          
        }, child: const Text('Ok'),)

      ],
    );
   },);
}