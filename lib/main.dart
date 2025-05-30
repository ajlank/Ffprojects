
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home:New(),
       
      ),
  );
}

class New extends StatelessWidget {
  const New({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}