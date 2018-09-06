import 'package:build/build.dart';
import 'package:json_l10n_serializable/src/json_l10n_generator.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_gen/src/builder.dart';

Builder jsonPartBuilder({
  String formatOutput(String code),
}) {
  return PartBuilder(
    [JsonLocalizationGenerator()],
    '.l10n.dart',
    formatOutput: formatOutput,
  );
}
