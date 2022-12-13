import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:flutter/services.dart';

const int year = 2022;

Future<String?> getInput(int day) async {
  // String dayString = day.toString().padLeft(2, '0');
  String? session = await getSessionCookie();
  if (session == null) return null;

  try {
    final request = await HttpClient()
        .getUrl(Uri.parse('https://adventofcode.com/$year/day/$day/input'));
    request.cookies.add(Cookie("session", session));
    final response = readResponse(await request.close());
    return response;
  } on Error catch (e) {
    log('Error loading file: $e');
  }
  return null;
}

Future<String?> getSessionCookie() async {
  const String assetsFileName = 'session.env';
  const String keyName = 'SESSION_COOKIE';
  final lines = await rootBundle.loadString(assetsFileName);
  for (String line in lines.split('\n')) {
    line = line.trim();
    if (line.startsWith('$keyName=')) {
      List<String> contents = line.split('=');
      if (contents.length == 2) {
        return contents[1];
      }
    }
  }
  return null;
}

Future<String> readResponse(HttpClientResponse response) {
  final completer = Completer<String>();
  final contents = StringBuffer();
  response.transform(utf8.decoder).listen((data) {
    contents.write(data);
  }, onDone: () => completer.complete(contents.toString()));
  return completer.future;
}
