import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';

extension LocaleExtension on BuildContext
{

  Locale get currentLocale => locale;
}
String capitalize(String name) {
  return name
      .split(' ')
      .map((word) => word.isNotEmpty
      ? word[0].toUpperCase() + word.substring(1).toLowerCase()
      : '')
      .join(' ');
}
enum QrViewMode { none, scan, generate, tokenGot,error}

String chatId(String token1, String token2) {
  final sorted = [token1, token2]..sort();
  return "${sorted[0]}_${sorted[1]}";
}