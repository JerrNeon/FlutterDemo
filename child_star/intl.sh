#!/usr/bin/env bash
#国际化生成
flutter pub run intl_translation:extract_to_arb --output-dir=i10n-arb lib/i10n/gm_localizations_intl.dart
flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_*.arb

flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_en.arb
flutter pub run intl_translation:generate_from_arb --output-dir=lib/i10n --no-use-deferred-loading lib/i10n/gm_localizations_intl.dart i10n-arb/intl_zh.arb

#根据生成json文件生成model类
flutter packages pub run json_model