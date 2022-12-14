import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';
import 'dart:math' as math;

const problemDay = 1;

class Problem1 extends Problem {
  Problem1({Key? key}) : super(key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      Part2(input),
    ];
  }

  @override
  final int day = problemDay;

  @override
  String getTestInput() {
    return '''1000
2000
3000

4000

5000
6000

7000
8000
9000

10000''';
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

String _solve(List<String>? lines) {
  if (lines == null) return inputError;
  var max = 0;
  var current = 0;
  for (var line in lines) {
    if (line.isEmpty) {
      max = math.max(current, max);
      current = 0;
    } else {
      current += int.parse(line);
    }
  }
  return '$max';
}

String _solve2(List<String>? lines) {
  if (lines == null) return inputError;

  var elves = [];
  var current = 0;
  for (var line in lines) {
    if (line.isNotEmpty) {
      current += int.parse(line);
      continue;
    }
    elves.add(current);
    current = 0;
  }
  elves.sort();
  elves = elves.reversed.toList();

  return (elves[0] + elves[1] + elves[2]).toString();
}
