import 'package:json_l10n_annotation/json_l10n_annotation.dart';
import 'package:test/test.dart';

part 'example.l10n.dart';

@JsonLocalization('localization.json')
class Localization {
  Map localization = _$localizationJsonLocalization(ZH_RCN);
}

void main() {
  group('A group of tests', () {
    Localization localization;

    setUp(() {
      localization = Localization();
    });

    test('First Test', () {
      expect(localization.localization[APP_TITLE], 'test');
    });
  });
}
