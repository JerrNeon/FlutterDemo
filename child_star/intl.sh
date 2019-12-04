#!/usr/bin/env bash
#国际化生成
flutter pub run intl_translation:extract_to_arb --output-dir=i10n-arb lib/i10n/gm_localizations_intl.dart
flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_*.arb

flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_en.arb
flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_zh.arb

#根据生成json文件生成model类
flutter packages pub run json_model

#Android Apk生成
flutter build apk
#Android debug模式运行
flutter run
#Android release模式运行
flutter run --release

#IOS ipa生成(会先生成一个Runner.app文件，把它放进文件夹进行压缩，然后修改压缩包后缀为ipa即可)
flutter build ios --release