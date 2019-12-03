import 'package:drop_example/widgets/drop_down.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
     
    return MaterialApp(
    
       title: 'My App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Quicksand',
        primarySwatch: Colors.purple,
      ),
      home:  DropDownApp(),
      
       
 
    );
  } 
 


}