import 'package:isolates_json_parsing_in_separate_isolate/isolates_json_parsing_in_separate_isolate.dart';
import 'package:test/test.dart';

const jsonString = '''
{
  "language": "Dart",
  "feeling": "love it",
  "level": "intermediate"
}
''';

void main() {
  group('JSON Parsing in Separate Isolate Tests', () {
    test('Parses JSON string correctly', () async {
      var result = await parseJsonInIsolate(jsonString);
      expect(result, isA<Map<String, dynamic>>());
      expect(result['language'], equals('Dart'));
      expect(result['feeling'], equals('love it'));
      expect(result['level'], equals('intermediate'));
    });
  });
}
