import 'package:flutter/material.dart';

class SliderData extends ChangeNotifier{
  double _value=0.0;
  double get value=>_value;

  set value(double newValue){
    if(newValue!=_value){
      _value=newValue;
      notifyListeners();
    }
  }
}

final sliderData=SliderData();

class SliderInheritedNotifier extends InheritedNotifier<SliderData>{
  const SliderInheritedNotifier({
    super.key,
    required SliderData sliderData,
    required super.child,
    
    }):super(notifier:sliderData);

   static double of(BuildContext context)=>
    context.dependOnInheritedWidgetOfExactType<SliderInheritedNotifier>()
    ?.notifier
    ?.value?? 0.0;
   

}

class HomePageThree extends StatelessWidget {
  const HomePageThree({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
    appBar: AppBar(
      title: const Text('Home Page'),
    ),
    body: SliderInheritedNotifier(
      sliderData: sliderData,
      child: Builder(
        builder: (context) {
          return Column(
            children: [
              Slider(
                value: SliderInheritedNotifier.of(context),
                 onChanged: (value) {
                   sliderData.value=value;
                 },
                 ),
                 Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Opacity(
                      opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        color: Colors.yellow,
                        height: 200,
                        width: 200,
                        
                      ),
                    ),
                    Opacity(
                    opacity: SliderInheritedNotifier.of(context),
                      child: Container(
                        color: Colors.blue,
                        height: 200,
                        width: 200,
                      ),
                    )
                  ].expandEqually().toList(),
                 )
            ]
          );
        }
      ),
    ),
    );
  }
}

extension ExpandEqually on Iterable<Widget>{

  Iterable<Widget>expandEqually()=>map((w)=>Expanded(child:w));

}