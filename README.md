## 根据json文件生成本地化代码类
基本[json_serializable](https://github.com/dart-lang/json_serializable)源码中的@JsonLiteral简单改造
## 使用说明

在pubspec.yaml分别配置

```yaml
dependencies:
  json_l10n_annotation:
    git:
        url: git://github.com/ShikinChen/json_l10n_serializable.git
        path: json_l10n_annotation

dev_dependencies:
  json_l10n_serializable:
    git:
      url: git://github.com/ShikinChen/json_l10n_serializable.git
      path: json_l10n_serializable
```

在对应类或者方法上面写上@JsonLocalization并且写上json文件路径
```dart
@JsonLocalization('localization.json')
class Localization {
  Map localization = _$localizationJsonLocalization(ZH_RCN);
}
```

localization.json文件
```json
{
  "app_title": "Test",
  "search": {
    "zh-cn": "搜索",
    "en": "Search"
  },
  "test": {
    "en": "test"
  }
}
```

然后在终端输入<br>
dart
```bash
pub run build_runner build
```
flutter
```bash
flutter packages pub run build_runner build
```

就会在对应文件生成.l10n.dart文件直接用part引用具体操作看example
