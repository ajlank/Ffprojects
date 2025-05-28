import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:simpletodo/cloud/cloud_user_name.dart';
import 'package:simpletodo/cloud/cloud_user_update.dart';
import 'package:simpletodo/constants/route_constants.dart';
import 'package:simpletodo/utilites/notifierval.dart';

class DrwerWidgetView extends StatefulWidget {
  const DrwerWidgetView({super.key});

  @override
  State<DrwerWidgetView> createState() => _DrwerWidgetViewState();
}

class _DrwerWidgetViewState extends State<DrwerWidgetView> {
    
   CloudUserName? _users;
   late final CloudUserUpdate _userUpadte;
   late final TextEditingController _textController;

   @override
  void initState() {
   _userUpadte=CloudUserUpdate();
   _textController=TextEditingController();    
   fetchUserName();
   super.initState();
  }

void _deleteNoteIfTextEmpty()async{
    final user=_users;
    if(_textController.text.isEmpty && user!=null){
      await _userUpadte.deleteName(documentId: user.userId);
    }
  }

  void _saveNoteIfTextNotEmpty()async{
    final user=_users;
     final text=_textController.text;
    if(_textController.text.isNotEmpty && user!=null){
      await _userUpadte.updateNote(documentId: user.userId, updatedName: text);
    }
  }


 Future<void>fetchUserName() async {
  final userId=FirebaseAuth.instance.currentUser!.uid;
  final userName=await _userUpadte.getuserName(userId: userId);

  if(userName.isNotEmpty){
    final name=userName.first;
    setState(() {
      _users=name;
    });
  }
 }
  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: ListView(
         children: [
          DrawerHeader(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                   CircleAvatar(
                    child:Icon(Icons.person) ,
                   ),
                   SizedBox(
                    width: 12,
                   ),
                   Text(_users?.userName??'User123', style: TextStyle(fontSize: 20),),
                   IconButton(onPressed: ()async{
                     fetchUserName();
                     final userId=FirebaseAuth.instance.currentUser!.uid;
                     final userName=await saveNameDialog(context);
                     await _userUpadte.createNewName(userId: userId, userName: userName);
                 
                   }, icon: Icon(Icons.edit))
                  ],
                ),
              
              ],
            ),
            
            ),
         
           Padding(
             padding: const EdgeInsets.all(12.0),
             child:ValueListenableBuilder(
              valueListenable: notifier, 
              builder:(context, value, child) {
                 return  Row(
              children: [
                const Text('Light Mode'),
                IconButton(onPressed: (){
                  notifier.value=!value;
              }, icon: Icon(value?Icons.dark_mode:Icons.light))   
              ],
             );
              },)
           ),
            Padding(
             padding: const EdgeInsets.all(12.0),
             child: Row(
              children: [
                const Text('Log Out'),
                IconButton(onPressed: () async {
                  await FirebaseAuth.instance.signOut();
                  if(context.mounted){
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      loginRoute, (_)=>false);
                  }
              }, icon: Icon(Icons.logout))   
              ],
             ),
           )       
         ],
        ),
      );
  }
  
Future<String>saveNameDialog(BuildContext context){
  return showDialog(context: context,
   builder: (context) {
    return AlertDialog(
      title: const Text('Write your name'),
      content: TextField(
        controller: _textController,
      ),
      actions: [
        TextButton(onPressed: (){
            Navigator.of(context).pop();
          
        }, child: const Text('Cancel'),),
        TextButton(onPressed: ()async{
            await fetchUserName();
           _deleteNoteIfTextEmpty();
          _saveNoteIfTextNotEmpty();
           if(context.mounted){
            Navigator.of(context).pop(_textController.text);
           }

        }, child: const Text('Save'),),
      ],
    );
   },).then((value) => value??false,);
}
}
