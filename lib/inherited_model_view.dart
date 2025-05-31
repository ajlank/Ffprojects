import 'dart:math' show Random;

import 'package:flutter/material.dart';

class MySecondHomePage extends StatefulWidget {
  const MySecondHomePage({super.key});

  @override
  State<MySecondHomePage> createState() => _MySecondHomePageState();
}

class _MySecondHomePageState extends State<MySecondHomePage> {
  var color1=Colors.yellow;
  var color2=Colors.blue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        centerTitle: true,
      ),
      body: AvailableColorsWidget(
        color1: color1,
         color2: color2,
       child: Column(
        children: [
          Row(
            children: [
              TextButton(onPressed: (){
               setState(() {
                 color1=colors.getRandomElement();
               });
              }, child: const Text('Change color1')),
              TextButton(onPressed: (){
               setState(() {
                  color2=colors.getRandomElement();
               });
              }, child: const Text('Change color2'))
            ],
          ),
          const ColorWidget(color: AvailableColors.one),
          const ColorWidget(color: AvailableColors.two)

        ],
       )),
    );
  }
}

enum AvailableColors{
  one,two
}

class AvailableColorsWidget extends InheritedModel<AvailableColors>{
  

  final Color color1;
  final Color color2;

  const AvailableColorsWidget({
    super.key,
     required this.color1,
     required this.color2,
     required super.child
     });

 static AvailableColorsWidget of(BuildContext context, AvailableColors aspect){
 
  return InheritedModel.inheritFrom<AvailableColorsWidget>(
    context, aspect:aspect)!;
 }
 
  @override
  bool updateShouldNotify(covariant AvailableColorsWidget oldWidget) {
    print('updateShouldNotify');
    return color1!=oldWidget.color1 || color2!=oldWidget.color2;
  }
 
  @override
  bool updateShouldNotifyDependent(
   covariant AvailableColorsWidget oldWidget, 
    Set<AvailableColors> dependencies) {
    print('updateShouldNotifyDependent');
    
    if(dependencies.contains(AvailableColors.one) && color1!=oldWidget.color1){
      return true;
    }
     if(dependencies.contains(AvailableColors.two) && color2!=oldWidget.color2){
      return true;
    }
    return false;
  }
 

}

class ColorWidget extends StatelessWidget {
  final AvailableColors color;
  const ColorWidget({super.key, required this.color});

  @override
  Widget build(BuildContext context) {
    switch(color){
      case AvailableColors.one:
        print('color1');
        break;
      case AvailableColors.two:
       print('color2');
       break;
    }
    final provider=AvailableColorsWidget.of(context, color);
    
    return Container(
        height: 100,
        color: color==AvailableColors.one? provider.color1 : provider.color2,
    );
  }
}

final colors=[
 
 Colors.blue,
 Colors.red,
 Colors.yellow,
 Colors.orange,
 Colors.purple,
 Colors.cyan,
 Colors.brown,
 Colors.amber,
 Colors.deepPurple,
   
];

extension RandomElement<T> on Iterable<T>{
  T getRandomElement()=>elementAt(
  Random().nextInt(length),
  );
} 