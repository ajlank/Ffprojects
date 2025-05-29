import 'package:flutter/material.dart';
import 'package:vanillacontacts_course/inherited_notifier_view.dart';
import 'package:vanillacontacts_course/value_notifier_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:HomePageThree(),
      routes: {'/new-contact': (context) => NewContactView()},
    ),
  );
}

