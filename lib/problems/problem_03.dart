import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 3;

class Problem3 extends Problem {
  Problem3({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput),
      Part1(input),
      TestPart2(testInput),
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
//2 large compartments
//one item type per compartment
//first half is comp 1, second is 2
  int A = 'A'.codeUnits[0];
  int a = 'a'.codeUnits[0];
  getPriority(int x) => x < a ? x - A + 27 : x - a + 1;
  // getStringPriority(String s) => getPriority(s.codeUnits[0]);

  List<int> repeats = [];
  for (var line in lines) {
    List<int> lineRepeats = [];
    //2*alphabet +1 to start at index 1
    List<bool> items = List<bool>.filled(27 * 2 + 1, false);
    var mid = line.length / 2;
    for (var i = 0; i < line.length; i++) {
      var p = getPriority(line.codeUnitAt(i));
      if (i >= mid) {
        if (!items[p]) continue;
        lineRepeats.add(p);
      } else {
        items[p] = true;
      }
    }
    repeats.addAll(lineRepeats.toSet());
  }

  return repeats
      .fold(0, (previousValue, element) => (previousValue + element))
      .toString();
}

String _solve2(List<String> lines) {
  int A = 'A'.codeUnits[0];
  int a = 'a'.codeUnits[0];
  getPriority(int x) => x < a ? x - A + 27 : x - a + 1;
  newBags() =>
      List<List<bool>>.generate(2, (i) => List<bool>.filled(27 * 2 + 1, false));
  //2*alphabet +1 to start at index 1

  List<int> badges = [];
  var bag = 2;

  List<List<bool>> bags = newBags();
  for (var line in lines) {
    bag++;
    if (bag > 2) {
      bag = 0;
      bags = newBags();
    }
    for (var i = 0; i < line.length; i++) {
      var p = getPriority(line.codeUnitAt(i));
      if (bag < 2) {
        bags[bag][p] = true;
        continue;
      }
      if (bags[0][p] && bags[1][p]) {
        badges.add(p);
        break;
      }
    }
  }

  return badges
      .fold(0, (previousValue, element) => (previousValue + element))
      .toString();
}
