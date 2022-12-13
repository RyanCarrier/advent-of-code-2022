import 'package:flutter/material.dart';

enum ProblemType {
  testPart1,
  part1,
  testPart2,
  part2,
}

extension NameExtension on ProblemType {
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

abstract class Problem {
  int get day;

  List<ProblemPart> get parts;
}

abstract class ProblemPart {
  ProblemType type;
  ProblemPart(this.type);
  bool solving = false;
  Widget? visualise;
  String? result;

  Future<void> solve();
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
                p.solving = true;
              });
              p.solve().then((value) => setState(() {
                    p.solving = false;
                  }));
            }));
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(p.type.name),
        ),
        p.solving
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
