import 'package:flutter/material.dart';

abstract class Problem {
  int get number;
  List<SubProblem> get subproblems;
}

enum ProblemType {
  example,
  small,
  large,
  test,
}

class SubProblem {
  final ProblemType type;
  final MaterialPageRoute? visualiseTest;
  String? result;

  final Function solve;

  SubProblem({
    required this.type,
    this.visualiseTest,
    this.result,
    required this.solve,
  });

  List<String> getInput(ProblemType type) {}
}
