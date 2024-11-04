import 'dart:io';

import 'package:quiz_cli/db.dart';
import 'package:quiz_cli/quiz_manager.dart';

void main() async {
  final db = FirestoreDB.initialize();
  final quizzes = await db.getAllQuizzes();

  QuizManager quiz = QuizManager(quizzes);
  quiz.displayAvailableQuiz();
  quiz.selectQuiz();

  exit(0);
}
