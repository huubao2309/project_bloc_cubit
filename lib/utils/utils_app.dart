import 'dart:convert';
import 'dart:developer' as developer;
import 'dart:math';

import 'package:flutter/services.dart';

Future<Map<String, dynamic>> getJson(String fileName) async {
  final value = await rootBundle.loadString('assets/data/$fileName');
  Map<String, dynamic> map = json.decode(value);
  return map;
}

int getRandom({int? size}) {
  final random = Random();
  int randomNumber = random.nextInt(size ?? 2);
  printLog('Random number: $randomNumber');
  return randomNumber;
}

void printLog(String content) {
  developer.log(content);
}