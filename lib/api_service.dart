import 'dart:convert';

import 'package:flutter/services.dart';

class ApiService {
  static Future<List<String>> getQuestions() async {
    final data = await rootBundle.loadString('assets/data.dart');
    final questions = List<String>.from(jsonDecode(data)['questions']);
    return questions;
  }
}
