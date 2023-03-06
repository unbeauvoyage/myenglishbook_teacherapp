import 'package:flutter/foundation.dart';

class QuizController with ChangeNotifier {
  final List<String> _questions;
  int _currentIndex = 0;

  QuizController(this._questions);

  List<String> get questions => _questions;
  int get currentIndex => _currentIndex;

  void nextQuestion() {
    if (_currentIndex < _questions.length - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  void reset() {
    _currentIndex = 0;
    notifyListeners();
  }
}
