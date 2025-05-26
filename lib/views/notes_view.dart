import 'package:flutter/material.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
         children: [
          DrawerHeader(
            child: const Text('This is drawer header'),
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
      ),
      appBar: AppBar(
        title: const Text('Hello, welcome to the notes view'),
        
      ),
    );
  }
}