import 'dart:io';

import 'package:quiz_cli/db.dart';
import 'package:quiz_cli/quiz_manager.dart';

void main() async {
  final db = FirestoreDB.initialize();
  final quizzes = await db.getAllQuizzes();

  print("===Welcome Admin===");
  while (true) {
    print("1. Display all quizzes");
    print("2. Add a quiz");
    print("3. Delete a quiz");
    print("4. Quit");
    print("");

    stdout.write("Enter your choice: ");
    String choice = stdin.readLineSync()!.trim();

    switch (choice) {
      case '1':
        var quizzes = await db.getAllQuizzes();
        for (var quiz in quizzes) {
          print(quiz);
          print("\n\n");
        }
      case '2':
        await db.addQuizFromJson("assets/quiz.json");
      case '3':
        QuizManager quiz = QuizManager(quizzes);
        quiz.displayAvailableQuiz();

        stdout.write("Enter your choice: ");
        String index = stdin.readLineSync()!.trim();

        await db.deleteQuiz(int.parse(index));
      case '4':
        exit(0);
      default:
        print('Invalid choice. Please try again.');
    }
  }
}
