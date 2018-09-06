library json_l10n_serializable.builder;

import 'package:build/build.dart';

import 'src/json_part_builder.dart';

Builder jsonL10nSerializable(BuilderOptions options) {
  var optionsMap = Map<String, dynamic>.from(options.config);
  var builder = jsonPartBuilder();

  if (optionsMap.isNotEmpty) {
    if (log == null) {
      throw StateError('Upgrade `build_runner` to at least 0.8.2.');
    } else {
      log.warning('These options were ignored: `$optionsMap`.');
    }
  }
  return builder;
}
