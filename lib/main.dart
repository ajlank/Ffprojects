import 'package:flutter/material.dart';
import 'package:vanillacontacts_course/value_notifier_view.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home:Hello(),
      routes: {'/new-contact': (context) => NewContactView()},
    ),
  );
}
class Hello extends StatelessWidget {
  const Hello({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}