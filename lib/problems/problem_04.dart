import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 4;

class Problem4 extends Problem {
  Problem4({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      TestPart2(testInput),
      Part2(input),
    ];
  }

  @override
  String getTestInput() {
    return '''2-4,6-8
2-3,4-5
5-7,7-9
2-8,3-7
6-6,4-6
2-6,4-8''';
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

class TestPart2 extends ProblemPart {
  TestPart2(input, {key}) : super(ProblemType.testPart2, input, key: key);
  @override
  solve(List<String> lines) => _solve2(lines);
}

class Part2 extends ProblemPart {
  Part2(input, {key}) : super(ProblemType.part2, input, key: key);
  @override
  solve(List<String> lines) => _solve2(lines);
}

String _solve(List<String> lines) {
  var newLines = parseInput(lines);
  var overlaps = 0;
  for (var line in newLines) {
    //1 in 2, or 2 in 1
    if ((line[0][0] <= line[1][0] && line[0][1] >= line[1][1]) ||
        (line[1][0] <= line[0][0] && line[1][1] >= line[0][1])) {
      overlaps++;
    }
  }

  return '$overlaps';
}

String _solve2(List<String> lines) {
  var newLines = parseInput(lines);
  var overlaps = 0;
  for (var line in newLines) {
    var a = line[0][0];
    var b = line[0][1];
    var c = line[1][0];
    var d = line[1][1];
    if (b < c || d < a) continue;
    overlaps++;
  }
  return '$overlaps';
}

List<List<List<int>>> parseInput(List<String> lines) {
  return lines
      .where((element) => element.contains(','))
      .map((line) => line
          .split(',')
          .map(
              (section) => section.split('-').map((i) => int.parse(i)).toList())
          .toList())
      .toList();
}
