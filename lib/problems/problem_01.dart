import 'package:aoc2022/util.dart';
import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';
import 'dart:math' as math;

const problemDay = 1;

class Problem1 implements Problem {
  Problem1({Key? key});

  @override
  final int day = problemDay;

  @override
  final List<ProblemPart> parts = [
    TestPart1(),
    Part1(),
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

class Part2 extends ProblemPart {
  Part2() : super(ProblemType.part2);

  @override
  Future<void> solve() async => result = _solve2(await getInput(problemDay));
}

String? _solve(String? input) {
  if (input == null) return null;
  var lines = input.split("\n");
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

String testInput() {
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

String? _solve2(String? input) {
  if (input == null) return null;
  var lines = input.split("\n");

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
