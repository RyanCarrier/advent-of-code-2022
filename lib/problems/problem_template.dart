import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 0;

class Problem00 extends Problem {
  Problem00({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      TestPart2(testInput),
      Part2(input),
    ];
  }

  @override
  String getTestInput() {
    return '''00''';
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
  return solvingError;
}

String _solve2(List<String> lines) {
  return solvingError;
}
