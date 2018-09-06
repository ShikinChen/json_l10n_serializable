import 'dart:async';
import 'dart:convert';

import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:path/path.dart' as p;
import 'package:source_gen/source_gen.dart';

import 'package:json_l10n_annotation/json_l10n_annotation.dart';

import 'utils.dart';

class JsonLocalizationGenerator
    extends GeneratorForAnnotation<JsonLocalization> {
  JsonLocalizationGenerator();

  var keyBuffer = StringBuffer();

  List<String> languages = [];

  @override
  Future<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) async {
    if (p.isAbsolute(annotation.read('path').stringValue)) {
      throw ArgumentError(
          '`annotation.path` must be relative path to the source file.');
    }

    var sourcePathDir = p.dirname(buildStep.inputId.path);
    var fileId = AssetId(buildStep.inputId.package,
        p.join(sourcePathDir, annotation.read('path').stringValue));
    var content = json.decode(await buildStep.readAsString(fileId));

    if (keyBuffer.length > 0) {
      keyBuffer.clear();
    }
    var thing = jsonLocalizationAsDart(content).toString();
    var languageBuffer = StringBuffer();
    languages.forEach((key) {
      languageBuffer.writeln(genKeyText(key));
    });
    return '''
    ${languageBuffer.toString()}\n
    ${keyBuffer.toString()}\n 
    Map<String, dynamic> _\$${lowerFirstCase(element.name)}JsonLocalization(String language) => $thing.map((key, value) {
      var val;
      if (value is String) {
        val = value;
      } else if (value is Map) {
        Map<String, dynamic> map = value as Map<String, dynamic>;
        val = map[language];
        if (val == null) {
          val = map[map.keys.elementAt(0)];
        }
      }
      return MapEntry(key, val);
    });''';
  }

  String jsonLocalizationAsDart(dynamic value, [bool isRoot = true]) {
    if (value == null) return 'null';

    if (value is String) return escapeDartString(value);

    if (value is bool || value is num) return value.toString();

    if (value is Map) return jsonMapAsDart(value, isRoot);

    throw StateError(
        'Should never get here – with ${value.runtimeType} - `$value`.');
  }

  String jsonMapAsDart(Map value, [bool isRoot = true]) {
    var buffer = StringBuffer();
    buffer.write('{');

    var first = true;
    value.forEach((k, v) {
      String key = k as String;

      if (isRoot) {
        keyBuffer.writeln('///${v}');
        keyBuffer.writeln(genKeyText(key));
      } else {
        if (!languages.contains(key)) {
          languages.add(key);
        }
      }
      if (first) {
        first = false;
      } else {
        buffer.writeln(',');
      }
      buffer.write(escapeDartString(key));
      buffer.write(': ');
      buffer.write(jsonLocalizationAsDart(v, false));
    });

    buffer.write('}');

    return buffer.toString();
  }

  String genKeyText(String key) =>
      'const String  ${fixSymbol(key).toUpperCase()}=${escapeDartString(key)};';
}
