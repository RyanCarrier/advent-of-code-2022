import 'dart:developer';
import 'dart:math' as math;
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

import 'package:aoc2022/problems/generic.dart';

const day = 5;

class Problem5 extends Problem {
  Problem5({Key? key}) : super(day, key: key) {
    parts = [
      TestPart1(testInput, visualise: () => Part1Visualisation(testInput)),
      Part1(input, visualise: () => Part1Visualisation(input)),
      TestPart2(testInput, visualise: () => Part1Visualisation(testInput)),
      Part2(input, visualise: () => Part1Visualisation(input)),
    ];
  }

  @override
  String getTestInput() {
    return '''    [D]    
[N] [C]    
[Z] [M] [P]
 1   2   3 

move 1 from 2 to 1
move 3 from 1 to 3
move 2 from 2 to 1
move 1 from 1 to 2''';
  }
}

class TestPart1 extends ProblemPart {
  TestPart1(input, {visualise, key})
      : super(ProblemType.testPart1, input, key: key, visualise: visualise);

  @override
  solve(List<String> lines) => _solve(lines);
}

class Part1 extends ProblemPart {
  Part1(input, {visualise, key})
      : super(ProblemType.part1, input, key: key, visualise: visualise);
  @override
  solve(List<String> lines) => _solve(lines);
}

class TestPart2 extends ProblemPart {
  TestPart2(input, {visualise, key})
      : super(ProblemType.testPart2, input, key: key, visualise: visualise);
  @override
  solve(List<String> lines) => _solve2(lines);
}

class Part2 extends ProblemPart {
  Part2(input, {visualise, key})
      : super(ProblemType.part2, input, key: key, visualise: visualise);
  @override
  solve(List<String> lines) => _solve2(lines);
}

String _solve(List<String> lines) {
  var data = Problem5Data.fromInput(lines);
  for (var action in data.actions) {
    var fromStack = action.from;
    var toStack = action.to;
    for (var i = 0; i < action.amount; i++) {
      data.stacks[toStack].insert(0, data.stacks[fromStack].removeAt(0));
    }
  }

  return data.stacks.fold(
      "", (previousValue, element) => previousValue + element.first.value);
}

String _solve2(List<String> lines) {
  return solvingError;
}

class Problem5Data {
  final List<List<Crate>> stacks;
  final List<Action> actions;
  Problem5Data(this.stacks, this.actions);

  factory Problem5Data.fromInput(List<String> lines) {
    // int space = ' '.codeUnits[0];
    int leftBracket = '['.codeUnits[0];
    String columnNumberStarter = " 1   2";
    List<String> columnNumberLine = lines
        .firstWhere((element) => element.startsWith(columnNumberStarter))
        .split(' ')
        .where((element) => element.isNotEmpty)
        .toList();
    log(columnNumberLine.toString());

    var stackAmount = int.parse(columnNumberLine.last);
    List<List<Crate>> stacks = List.generate(stackAmount, (index) => []);
    var actionsMode = false;
    List<Action> actions = [];
    for (var line in lines) {
      if (line.isEmpty) continue;
      if (line.startsWith(columnNumberStarter)) {
        actionsMode = true;
        continue;
      }
      if (actionsMode) {
        actions.add(Action.fromInput(line));
      } else {
        for (var i = 0; i < stackAmount; i++) {
          var j = i * 4;
          if (line.codeUnitAt(j) == leftBracket) {
            var crate = Crate(String.fromCharCode(line.codeUnitAt(j + 1)),
                key: UniqueKey());
            stacks[i].add(crate);
          }
        }
      }
    }
    return Problem5Data(stacks, actions);
  }

  void apply(Action action) {
    for (var i = 0; i < action.amount; i++) {
      stacks[action.to].insert(0, stacks[action.from].removeAt(0));
    }
  }
}

class Action {
  final int amount;
  final int from;
  final int to;
  Action(this.amount, this.from, this.to);
  factory Action.fromInput(String input) {
    var parts = input.split(' ');
    var amount = int.parse(parts[1]);
    var from = int.parse(parts[3]) - 1;
    var to = int.parse(parts[5]) - 1;
    return Action(amount, from, to);
  }
}

class Part1Visualisation extends StatefulWidget {
  const Part1Visualisation(this.input, {Key? key}) : super(key: key);

  final Future<List<String>> Function() input;
  @override
  State<Part1Visualisation> createState() => _Part1VisualisationState();
}

class _Part1VisualisationState extends State<Part1Visualisation>
    with SingleTickerProviderStateMixin {
  late Problem5Data data;
  // late final List<Crate> stacks;
  // late final List<Path?> paths;
  final Map<Key, Path?> paths = {};
  bool dataLoaded = false;
  late AnimationController _controller;
  late Animation _animation;
  late double genSize;
  late double currentPathLength;
  late double middle;
  Duration baseAnimationDuration = const Duration(milliseconds: 500);
  late int maxStacks;

  @override
  void initState() {
    super.initState();
    initData();

    _controller =
        AnimationController(vsync: this, duration: baseAnimationDuration)
          ..addStatusListener((status) {
            if (status == AnimationStatus.completed) {
              paths.clear();
            }
          });
    _animation = Tween(begin: 0.0, end: 1.0).animate(_controller)
      ..addListener(() {
        setState(() {});
      });
  }

  void initData() {
    widget.input().then((value) async {
      setState(() {
        data = Problem5Data.fromInput(value);
        maxStacks = data.stacks.length;
        for (var stack in data.stacks) {
          for (var crate in stack) {
            paths[crate.key!] = null;
          }
        }

        dataLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    middle = (size.width / 2);
    return Container(
      height: size.height,
      width: size.width,
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedSwitcher(
          duration: baseAnimationDuration,
          child: dataLoaded
              ? _buildStacks(context)
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
    );
  }

  Offset calculatePath(double value, Path path) {
    PathMetrics pathMetrics = path.computeMetrics();
    PathMetric pathMetric = pathMetrics.first;
    var pathValue = pathMetric.length * value;
    Tangent? pos = pathMetric.getTangentForOffset(pathValue);
    return pos!.position;
  }

  void _reset() {
    setState(() {
      initData();
    });
  }

  Widget _buildStacks(BuildContext context) {
    var size = MediaQuery.of(context).size;
    genSize = size.height / (4 * data.stacks.length);
    List<Widget> crates = [];
    late Offset pos;
    for (var i = 0; i < data.stacks.length; i++) {
      var jMax = data.stacks[i].length - 1;
      for (var j = 0; j < data.stacks[i].length; j++) {
        var crate = data.stacks[i][jMax - j];
        pos = paths[crate.key] != null
            ? calculatePath(_animation.value, paths[crate.key]!)
            : getStackPosition(i, j);

        crates.add(
          Positioned(
            height: genSize / 2,
            width: genSize,
            left: pos.dx,
            bottom: pos.dy,
            child: crate,
          ),
        );
      }
    }
    var stacks = [
      for (var i = 0; i < data.stacks.length; i++)
        Positioned(
          left: getStackLeft(i),
          bottom: genSize * 2,
          child: ElfStack(genSize),
        ),
    ];
    button(text, onPressed, displacement) => Positioned(
          bottom: genSize / 2,
          left: displacement + middle,
          width: middle / 4,
          child: ElevatedButton(
            onPressed: onPressed,
            child: AutoSizeText(text),
          ),
        );
    var buttons = [
      button("Speed +", increaseSpeed, 2.5 * middle / 4),
      button("Reset", _reset, -2 * middle / 4),
      button(">", data.actions.isNotEmpty ? step : null, -middle / 8),
      button("Start", data.actions.isEmpty ? null : start, 1 * middle / 4),
      button("Speed -", decreaseSpeed, -3.5 * middle / 4),
    ];
    return Stack(
      children: [
        ...crates,
        ...stacks,
        ...buttons,
        // Positioned(
        //   left: middle,
        //   bottom: 0,
        //   height: 500,
        //   width: 5,
        //   child: Container(color: Colors.red),
        // ),
      ],
    );
  }

  void increaseSpeed() {
    _controller.duration = _controller.duration! * 0.8;
  }

  void decreaseSpeed() {
    _controller.duration = _controller.duration! * 1.3;
  }

  Offset getStackPosition(int i, int j) =>
      Offset(getStackLeft(i), getStackBottom(j));

  double getStackLeft(int i) =>
      middle + (i - (maxStacks - 1) / 2) * (genSize * 1.2) - genSize / 2;

  double getStackBottom(int j) => 2.2 * genSize + j * genSize * 0.8;

  Path buildPath(int fromStack, toStack, j, toJ, maxStack) {
    var path = Path();
    var fromX = getStackLeft(fromStack);
    var toX = getStackLeft(toStack);
    double maxHeight = getStackBottom(maxStack - 1);
    path.moveTo(fromX, getStackBottom(j));
    path.lineTo(fromX, maxHeight);
    path.lineTo(toX, maxHeight);
    path.lineTo(toX, getStackBottom(toJ));
    return path;
  }

  void start() {
    if (data.actions.isNotEmpty) {
      var action = data.actions.removeAt(0);
      _move(action);
      _startAnimation(true);
    }
  }

  void step() {
    var action = data.actions.removeAt(0);
    _move(action);
    _startAnimation(false);
  }

  void _move(Action action) {
    int maxStack = 0;
    for (var i = math.min(action.from, action.to);
        i < math.max(action.to, action.from);
        i++) {
      maxStack = math.max(maxStack, data.stacks[i].length + 1);
    }
    maxStack =
        math.max(maxStack, data.stacks[action.to].length + action.amount);
    late Crate crate;
    for (var i = 0; i < action.amount; i++) {
      crate = data.stacks[action.from].removeAt(0);
      data.stacks[action.to].insert(0, crate);
      log('$i\t${crate.key}');
      paths[crate.key!] = buildPath(
          action.from,
          action.to,
          data.stacks[action.from].length,
          data.stacks[action.to].length - 1,
          maxStack);
    }

    currentPathLength =
        paths[crate.key]!.computeMetrics().fold(0.0, (pv, e) => pv + e.length);
  }

  void _startAnimation(bool repeat) {
    setState(() {
      _controller.reset();
      _controller.forward().whenCompleteOrCancel(() {
        paths.clear();
        if (repeat) {
          start();
        }
      });
    });
  }
}

class ElfStack extends StatelessWidget {
  const ElfStack(this.size, {Key? key}) : super(key: key);
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size / 10,
      color: Colors.black,
    );
  }
}

class Crate extends StatelessWidget {
  Crate(this.value, {Key? key}) : super(key: key) {
    var colors = [
      Colors.blue,
      Colors.red,
      Colors.yellow,
      Colors.green,
      Colors.purple,
      Colors.orange,
    ];
    int index = value.codeUnitAt(0) - 'A'.codeUnitAt(0);
    color = colors[index ~/ 5][(1 + (index % 5)) * 100]!;
  }

  factory Crate.fromInput(String input) => Crate(input[1]);

  factory Crate.fromCodeUnit(int input) => Crate(String.fromCharCode(input));

  final String value;
  late final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Center(
        child: AutoSizeText(
          value,
          maxLines: 1,
        ),
      ),
    );
  }
}
