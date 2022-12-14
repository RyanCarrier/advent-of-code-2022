import 'package:aoc2022/problems/generic.dart';
import 'package:aoc2022/problems/problem_02.dart';
import 'package:aoc2022/problems/problem_03.dart';
import 'package:aoc2022/util.dart';
import 'package:flutter/material.dart';

import 'problems/problem_01.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jun is poo poo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Home(),
    );
  }
}

class Home extends StatelessWidget {
  Home({Key? key}) : super(key: key);

  final List<Problem> problems = [
    Problem1(),
    Problem2(),
    Problem3(),
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(title: const Text("AOC $year")),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "Days",
                style: Theme.of(context).textTheme.headline4,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView(
                shrinkWrap: true,
                children:
                    problems.map((e) => problemButton(context, e)).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget problemButton(BuildContext context, Problem problem) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        onPressed: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ProblemContainer(problem: problem),
          ),
        ),
        child: Text("${problem.day}"),
      ),
    );
  }
}
