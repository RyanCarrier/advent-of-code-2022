import 'package:flutter/material.dart';

abstract class Problem implements StatelessWidget {
  int get day;

  MaterialPageRoute? visualise;
  String? result;

  void solve();

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
