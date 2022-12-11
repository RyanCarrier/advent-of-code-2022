import 'package:aoc2022/problems/generic.dart';
import 'package:flutter/material.dart';

class Problem1 extends StatelessWidget implements Problem {
  Problem1({Key? key}) : super(key: key);

  @override
  final int day = 1;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  @override
  String? result;

  @override
  MaterialPageRoute? visualise;

  @override
  void solve() {}

  String? testInput() {
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
