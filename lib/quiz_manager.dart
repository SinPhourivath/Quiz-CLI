import 'dart:io';

import 'package:collection/collection.dart';
import 'package:quiz_cli/model.dart';

class QuizManager {
  final List<Quiz> quizzes;

  QuizManager(this.quizzes);

  Future<void> displayAvailableQuiz() async {
    if (quizzes.isEmpty) {
      print("No quizzes available.");
      return;
    }

    print("Available Quizzes:");
    for (int i = 0; i < quizzes.length; i++) {
      print("${i + 1}. ${quizzes[i].title}");
    }
    print("");

    String input;
    do {
      // Prompt user to select a quiz
      stdout.write("Select a quiz by entering its number: ");
      input = stdin.readLineSync()!.trim();

      if (input.isEmpty) {
        print("Input cannot be empty. Please try again.");
      } else if (int.tryParse(input) == null) {
        print("Invalid input. Please enter a number.");
        input = "";
      } else {
        int selectedIndex = int.parse(input) - 1;
        if (selectedIndex >= 0 && selectedIndex < quizzes.length) {
          Quiz selectedQuiz = quizzes[selectedIndex];
          startQuiz(selectedQuiz);
        } else {
          print("Invalid selection. Please try again.");
          input = "";
        }
      }
    } while (input.isEmpty);
  }

  void startQuiz(Quiz quiz) {
    print('Starting Quiz: ${quiz.title}');
    print('${quiz.description}\n');

    for (var question in quiz.questions) {
      print(question.questionText);
      question.answers.forEach((key, value) {
        print('$key: $value');
      });

      stdout.write("Your Answer: ");
      String? userAnswer = stdin.readLineSync(); // Read user input
      bool isCorrect = checkAnswer(question, userAnswer);
      print(isCorrect
          ? 'Correct!'
          : 'Incorrect. The correct answer is: ${question.correctAnswer}\n');
      print("");
    }
  }

  bool checkAnswer(Question question, String? userAnswer) {
    if (question.isMultiChoice) {
      List<String> userAnswers =
          userAnswer?.split(',').map((answer) => answer.trim()).toList() ?? [];
      List<String> correctAnswers =
          question.correctAnswer is List<String> ? question.correctAnswer : [];
      return ListEquality().equals(userAnswers, correctAnswers);
    } else {
      return userAnswer == question.correctAnswer;
    }
  }
}
