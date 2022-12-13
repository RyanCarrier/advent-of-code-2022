import 'package:aoc2022/util.dart';
import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const problemDay = 0;

class Problem0 implements Problem {
  Problem0({Key? key});

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
  return '${lines.length}';
}

String testInput() {
  return '''00''';
}

String? _solve2(String? input) {
  if (input == null) return null;
  var lines = input.split("\n");
  return '${lines.length}';
}
