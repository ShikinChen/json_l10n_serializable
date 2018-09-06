// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

// **************************************************************************
// JsonLocalizationGenerator
// **************************************************************************

const String ZH_RCN = 'zh-rCN';
const String EN = 'en';

///Test
const String APP_TITLE = 'app_title';

///{zh-rCN: 搜索, en: Search}
const String SEARCH = 'search';

///{en: test}
const String TEST = 'test';

Map<String, dynamic> _$localizationJsonLocalization(String language) => {
      'app_title': 'Test',
      'search': {'zh-rCN': '搜索', 'en': 'Search'},
      'test': {'en': 'test'}
    }.map((key, value) {
      var val = value;
      if (value is Map) {
        val = value[language];
        if (val == null) {
          val = value[value.keys.elementAt(0)];
        }
      }
      return MapEntry(key, val);
    });
