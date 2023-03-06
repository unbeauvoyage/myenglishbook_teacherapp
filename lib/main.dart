import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'quiz_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: rootBundle.loadString('assets/data.dart'),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final questions =
              List<String>.from(jsonDecode(snapshot.data)['questions']);
          return ChangeNotifierProvider(
            create: (_) => QuizController(questions),
            child: MaterialApp(
              title: 'Flutter Quiz App',
              home: QuizScreen(),
            ),
          );
        } else {
          return CircularProgressIndicator();
        }
      },
    );
  }
}

class QuizScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final quizController = Provider.of<QuizController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter Quiz App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              quizController.questions[quizController.currentIndex],
              style: TextStyle(fontSize: 24),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                quizController.nextQuestion();
              },
              child: Text('Next'),
            ),
            SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                quizController.reset();
              },
              child: Text('Restart'),
            ),
          ],
        ),
      ),
    );
  }
}
