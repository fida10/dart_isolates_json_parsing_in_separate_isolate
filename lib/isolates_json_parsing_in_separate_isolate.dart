/// Support for doing something awesome.
///
/// More dartdocs go here.
library;

export 'src/isolates_json_parsing_in_separate_isolate_base.dart';

/*
Practice Question 2: JSON Parsing in Separate Isolate

Task:

Parse a JSON string in a separate isolate and convert it to a map.
 */

import 'dart:async';
import 'dart:convert';
import 'dart:isolate';

void decodeJsonWithIsolate(List<Object> params) {
  String jsonString = params[0] as String;
  SendPort sendPort = params[1] as SendPort;

  Map<String, dynamic> decoded = jsonDecode(jsonString);

  sendPort.send(decoded);
}

Future<Map<String, dynamic>> parseJsonInIsolate(String jsonString) async {
  ReceivePort receivePort = ReceivePort();
  final completer = Completer<Map<String, dynamic>>();

  final isolate = await Isolate.spawn<List<Object>>(
      decodeJsonWithIsolate, [jsonString, receivePort.sendPort]);

  receivePort.listen((message) {
    if (!completer.isCompleted) {
      completer.complete(message);
      receivePort.close();
      isolate.kill();
    }
  });

  return completer.future;
}
