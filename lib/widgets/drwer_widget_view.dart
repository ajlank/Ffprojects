import 'package:flutter/material.dart';

class DrwerWidgetView extends StatelessWidget {
  const DrwerWidgetView({super.key});

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
                   const Text('Ajlan Khan', style: TextStyle(fontSize: 20),),
                   IconButton(onPressed: (){

                   }, icon: Icon(Icons.edit))
                  ],
                )
              ],
            ),
            ),
          ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
           ListTile(
            title: const Text('Item 1'),
            onTap: () {
              
            },
          ),
          
         ],
        ),
      );
  }
}