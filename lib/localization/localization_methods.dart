
import 'package:flutter/material.dart';
import 'package:nash2en_masr/localization/set_localization.dart';

String? getTranslated(BuildContext context, String key) {
  return SetLocalization.of(context)!.getTranslateValue(key);
}
