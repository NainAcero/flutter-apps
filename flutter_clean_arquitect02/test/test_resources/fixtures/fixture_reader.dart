import 'dart:io';

String fixture(String name) {
  String json;

  try {
    json = File('test/test_resources/fixtures/$name').readAsStringSync();
  } catch(e) {
    json = File('../test/test_resources/fixtures/$name').readAsStringSync();
  }

  return json;
}
