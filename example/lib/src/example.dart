import 'package:json_l10n_annotation/json_l10n_annotation.dart';

part 'example.l10n.dart';

@JsonLocalization('localization.json')
class Localization {
  Map localization = _$localizationJsonLocalization(ZH_RCN);
}

void main() {
  Localization localization = Localization();
  print('${localization.localization[SEARCH]}');
}
