import 'package:aoc2022/problems/generic.dart';
import 'package:flutter/material.dart';

import 'problems/problem_01.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  List<Problem> problems=[Problem1()];

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jun is poo poo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Home(),
    );
  }
}

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      body:ListView(children:const []
      ))
    ))
  }

  ElevatedButton problemButton(Widget problem){
    return ElevatedButton(onPressed: ()=>Navigator.of(context).push(MaterialPageRoute(builder: (context)=>problem))), child: Text problem.title)
  }
}
