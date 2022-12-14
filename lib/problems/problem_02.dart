import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 2;

class Problem2 extends Problem {
  Problem2({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      Part2(input),
    ];
  }

  @override
  String getTestInput() {
    return '''A Y
B X
C Z''';
  }
}

class TestPart1 extends ProblemPart {
  TestPart1(input, {key}) : super(ProblemType.testPart1, input, key: key);
  @override
  solve(List<String> lines) => _solve(lines);
}

class Part1 extends ProblemPart {
  Part1(input, {key}) : super(ProblemType.part1, input, key: key);
  @override
  solve(List<String> lines) => _solve(lines);
}

class Part2 extends ProblemPart {
  Part2(input, {key}) : super(ProblemType.part2, input, key: key);
  @override
  solve(List<String> lines) => _solve2(lines);
}

String _solve(List<String> lines) {
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

String _solve2(List<String> lines) {
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
