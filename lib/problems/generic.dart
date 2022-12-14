import 'dart:async';

import 'package:aoc2022/util.dart' as util;
import 'package:flutter/material.dart';

enum ProblemType {
  testPart1,
  part1,
  testPart2,
  part2,
}

enum ProblemStatus {
  none,
  input,
  solving,
  solved,
}

const inputError = "ERROR: input";
const solvingError = "ERROR: solving";

extension TypeNameExtension on ProblemType {
  String get name {
    switch (this) {
      case ProblemType.testPart1:
        return "Part1 Test";
      case ProblemType.part1:
        return "Part1";
      case ProblemType.testPart2:
        return "Part2 Test";
      case ProblemType.part2:
        return "Part2";
    }
  }
}

extension StatusNameExtension on ProblemStatus {
  String get name {
    switch (this) {
      case ProblemStatus.none:
        return 'None';
      case ProblemStatus.input:
        return 'Input';
      case ProblemStatus.solving:
        return 'Solving';
      case ProblemStatus.solved:
        return 'Solved';
    }
  }
}

abstract class Problem {
  Problem({this.key});
  Key? key;
  int get day;
  late List<ProblemPart> parts;
  String getTestInput();
  Duration? inputDuration;

  List<String>? _input;
  List<String>? _testInput;
  Future<List<String>> input() async {
    if (_input == null) {
      inputDuration = await _timeIt(() async {
        _input = (await util.getInput(day))!.split('\n');
      });
    }
    return _input!;
  }

  Future<List<String>> testInput() async =>
      _testInput ??= getTestInput().split('\n');
}

abstract class ProblemPart {
  Key? key = UniqueKey();
  ProblemType type;
  Future<List<String>> Function() input;
  ProblemPart(this.type, this.input, {this.key});
  ProblemStatus status = ProblemStatus.none;

  Duration? solveDuration;
  Widget? visualise;
  String? result;

  String solve(List<String> lines);

  Future<void> runProblem() async {
    List<String> problemInput = await input();
    solveDuration = await _timeIt(() => result = solve(problemInput));
  }
}

class ProblemContainer extends StatefulWidget {
  const ProblemContainer({Key? key, required this.problem}) : super(key: key);

  final Problem problem;

  @override
  State<StatefulWidget> createState() => _ProblemContainerState();
}

class _ProblemContainerState extends State<ProblemContainer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Day ${widget.problem.day}"),
      ),
      body: Column(
        children: widget.problem.parts
            .map(
              (e) => subProblem(context, e),
            )
            .toList(),
      ),
    );
  }

  Widget subProblem(BuildContext context, ProblemPart p) {
    solvingButton(text) => Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
            child: Text(text),
            onPressed: () {
              setState(() {
                p.status = ProblemStatus.input;
              });
              p.runProblem().then((value) => setState(() {
                    p.status = ProblemStatus.solved;
                  }));
            }));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.type.name),
        ),
        p.status == ProblemStatus.solving
            ? const CircularProgressIndicator()
            : (p.result != null
                ? Row(children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(p.result!),
                    ),
                    solvingButton("↻"),
                  ])
                : solvingButton("Solve")),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            child: Text(p.visualise == null
                ? "Visualisation unavailable"
                : "Visualise"),
            onPressed: () => p.visualise == null
                ? null
                : MaterialPageRoute(
                    builder: (context) {
                      return p.visualise!;
                    },
                  ),
          ),
        ),
      ],
    );
  }
}

Future<Duration> _timeIt(Function f) async {
  Stopwatch timer = Stopwatch();
  timer.start();
  await f();
  timer.stop();
  return timer.elapsed;
}
