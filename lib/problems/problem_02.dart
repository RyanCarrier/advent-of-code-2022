import 'package:aoc2022/util.dart';
import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const problemDay = 2;

class Problem2 implements Problem {
  Problem2({Key? key});

  @override
  final int day = problemDay;

  @override
  final List<ProblemPart> parts = [
    TestPart1(),
    Part1(),
    TestPart2(),
    Part2(),
  ];
}

class TestPart1 extends ProblemPart {
  TestPart1() : super(ProblemType.testPart1);

  @override
  Future<void> solve() async => result = _solve(testInput());
}

class Part1 extends ProblemPart {
  Part1() : super(ProblemType.part1);

  @override
  Future<void> solve() async => result = _solve(await getInput(problemDay));
}

class TestPart2 extends ProblemPart {
  TestPart2() : super(ProblemType.testPart2);

  @override
  Future<void> solve() async => result = _solve2(testInput());
}

class Part2 extends ProblemPart {
  Part2() : super(ProblemType.part2);

  @override
  Future<void> solve() async => result = _solve2(await getInput(problemDay));
}

String? _solve(String? input) {
  if (input == null) return null;
  var lines = input.split("\n");
  var a = 'A'.codeUnits[0];
  var x = 'X'.codeUnits[0];
  var results = [
    [3, 6, 0],
    [0, 3, 6],
    [6, 0, 3]
  ];

  var total = 0;
  for (var line in lines) {
    var runes = line.runes.toList();
    if (runes.length != 3) continue;
    total += runes[2] - x + 1 + results[runes[0] - a][runes[2] - x];
  }
  return '$total';
}

String testInput() {
  return '''A Y
B X
C Z''';
}

String? _solve2(String? input) {
  if (input == null) return null;
  var lines = input.split("\n");
  var a = 'A'.codeUnits[0];
  var x = 'X'.codeUnits[0];
  // ignore: unused_local_variable
  var results = [
    [3, 1, 2],
    [1, 2, 3],
    [2, 3, 1]
  ];
  var shiftValue = (a + x + 1);
  var total = 0;
  for (var line in lines) {
    var runes = line.runes.toList();
    if (runes.length != 3) continue;
    var result = (runes[2] - x) * 3;
    // var value = results[runes[0] - a][runes[2] - x];

    //this method of getting value is just way cooler
    // var value = (runes[0] + runes[2] - shiftValue) % 3 + 1;

    //this method is even cooler and even less readible, nice!
    var value = ((runes[0] + runes[2] - shiftValue) % 3) + 1;
    total += result + value;
  }
  return '$total';
}
