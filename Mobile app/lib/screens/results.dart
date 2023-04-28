import 'package:flutter/material.dart';
import 'feedback_screen.dart';


class Results extends StatefulWidget {
  @override
  State<Results> createState() => _ResultsState();
}

class _ResultsState extends State<Results> {


  @override
  Widget build(BuildContext context) {
    var x='food';
    return Scaffold(
     
        body: Center(
          child: Column(
            children: [
              Container(
                child: GestureDetector(child: x=='food'?Icon(Icons.food_bank,size: 400,color:Colors.pink,):Icon(Icons.local_drink,size: 400,color:Colors.pink,),onTap: () {
                  print('Hello');
                  setState(() {
                    x='drink';
                  });
                  print(x);
                },),// <---- Use
              ),
          ElevatedButton(onPressed: (){
            Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => Feedback_screen()),);}, child: Text("feedback"))
            ],
          ),
        ),
      
    );
  }
}