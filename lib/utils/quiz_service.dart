import 'dart:async';
import 'package:fulutter_quiz_app/utils/quiz_model.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';

Future<String> _questionsAsset(String filePathToLoad) async {
  return await rootBundle.loadString("assets/quiz_questions/$filePathToLoad");
}

Future loadQuestions(String filePathToLoad) async {
  String jsonAddress = await _questionsAsset(filePathToLoad);
  final jsonResponse = json.decode(jsonAddress);
  Quiz quiz = new Quiz.fromJson(jsonResponse);
  print(quiz.category);
  print(quiz.numberOfQuestions);
}