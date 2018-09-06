import 'dart:io' show exitCode;

import 'package:build/build.dart';
import 'package:build_config/build_config.dart';
import 'package:build_runner/build_runner.dart';
import 'package:json_l10n_serializable/src/json_part_builder.dart'
    as jpb;

Builder _jsonPartBuilder({
  bool format,
}) {
  format ??= true;
  String Function(String code) formatOutput;

  if (!format) {
    formatOutput = (s) => s;
  }

  return jpb.jsonPartBuilder(
    formatOutput: formatOutput,
  );
}

final List<BuilderApplication> builders = [
  applyToRoot(_jsonPartBuilder(),
      generateFor: const InputSet(
        include: [
          'test/example.dart',
        ],
      ),
      hideOutput: false),
];

void main(List<String> args) async {
  exitCode = await run(args, builders);
}
