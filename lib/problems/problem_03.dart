import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 3;

class Problem3 extends Problem {
  Problem3({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      Part2(input),
    ];
  }

  @override
  String getTestInput() {
    return '''vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw''';
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
//

  return solvingError;
}

String _solve2(List<String> lines) {
  return solvingError;
}
