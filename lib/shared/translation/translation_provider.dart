import 'package:flutter/widgets.dart';
import 'translation_service.dart';

class TranslationProvider extends InheritedNotifier<TranslationService> {
  const TranslationProvider({
    super.key,
    required TranslationService notifier,
    required super.child,
  }) : super(notifier: notifier);

  static TranslationService of(BuildContext context) {
    final provider = context
        .dependOnInheritedWidgetOfExactType<TranslationProvider>();
    assert(provider != null, 'TranslationProvider not found in context');
    return provider!.notifier!;
  }
}

extension TranslationBuildContext on BuildContext {
  TranslationService get translation => TranslationProvider.of(this);
}
