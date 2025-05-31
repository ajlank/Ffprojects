import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:uuid/uuid.dart';
import 'dart:async';
// void main() {
//   runApp(
//     MaterialApp(
//           debugShowCheckedModeBanner: false,
//           title: 'Flutter Demo',
//           theme: ThemeData(
//             colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//           ),
//           home:ThirdHomePage(),
         
//         ),
//   );
// }

String now()=>DateTime.now().toIso8601String();

@immutable
class Seconds{
  final String value;
  Seconds():value=now();
}

@immutable
class Minutes{
  final String value;
  Minutes():value=now();
}


class SecondsWidget extends StatelessWidget {
  const SecondsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final seconds=context.watch<Seconds>();

    return Expanded(child: Container(
       color: Colors.yellow,
       height: 100,
       child: Text(seconds.value),
    ));
  }
}

class MinutesWidget extends StatelessWidget {
  const MinutesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final minutes=context.watch<Minutes>();
    return Expanded(child: Container(
     height: 100,
     color: Colors.blue,
     child: Text(minutes.value),
    ));
  }
}

class ThirdHomePage extends StatelessWidget {
  const ThirdHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: MultiProvider(
        providers: [
          StreamProvider.value(
             value: Stream<Seconds>.periodic(const Duration(seconds: 1),(_)=>Seconds()),
             initialData: Seconds()
             ),
             StreamProvider.value(
             value: Stream<Minutes>.periodic(const Duration(minutes: 1),(_)=>Minutes()),
             initialData: Minutes(),
             )
        ],
        child: Column(children: [
          Row(
            children:const [
              SecondsWidget(),
              MinutesWidget()
            ],
          )
        ],),
      ),
    );
  }
}
