import 'dart:io';

import 'package:quiz_cli/db.dart';
import 'package:quiz_cli/logic.dart';
import 'package:quiz_cli/model.dart';
import 'package:quiz_cli/quiz_manager.dart';

void main() async {
  final db = FirestoreDB.initialize();
  final quizzes = await db.getAllQuizzes();

  final logic = Logic();

  print("===Welcome Admin===");

  while (true) {
    print("1. Display all quizzes");
    print("2. Add a quiz");
    print("3. Delete a quiz");
    print("4. Display all Student's quiz result");
    print("5. Quit\n");

    String choice = logic.promptForNum("Enter your choice: ");

    switch (choice) {
      case '1':
        var quizzes = await db.getAllQuizzes();
        for (var quiz in quizzes) {
          print(quiz);
          print("\n\n");
        }
        break;

      case '2':
        await db.addQuizFromJson("assets/quiz.json");
        break;

      case '3':
        QuizManager quiz = QuizManager(quizzes);
        print("");
        quiz.displayAvailableQuiz();
        String index = logic.promptForNum("Enter your choice: ");
        await db.deleteQuiz(int.parse(index));
        break;

      case '4':
        List<QuizResult> results = await db.fetchAllStudentQuizResults();
        for (var result in results) {
          print("\nQuiz: ${result.quizName}\nStudent: ${result.studentName}\nScore: ${result.score}");
          print("\n");
        }
        break;

      case '5':
        exit(0);

      default:
        print('Invalid choice. Please try again.\n');
    }
  }
}
