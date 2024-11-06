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
  }

  Future<void> selectQuiz() async {
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
          takeQuiz(selectedQuiz);
        } else {
          print("Invalid selection. Please try again.");
          input = "";
        }
      }
    } while (input.isEmpty);
  }

  void takeQuiz(Quiz quiz) {
    stdout.write("Enter your first name: ");
    String firstName = stdin.readLineSync()!.trim();
    stdout.write("Enter your last name: ");
    String lastName = stdin.readLineSync()!.trim();

    print("\nStarting Quiz: ${quiz.title}");
    print('${quiz.description}\n');

    int score = 0;

    // Go through each question and calculate the score
    for (var question in quiz.questions) {
      print(question.questionText);
      question.answers.forEach((key, value) {
        print('$key: $value');
      });

      stdout.write("Your Answer: ");
      String? userAnswer = stdin.readLineSync(); // Read user input
      bool isCorrect = checkAnswer(question, userAnswer);
      
      if (isCorrect) {
        print('Correct!');
        score++;
      } else {
        print('Incorrect. The correct answer is: ${question.correctAnswer}');
      }
      print("");
    }
    // Display the result of the student
    print("Quiz Completed!");
    print("Student: $firstName $lastName");
    print("Score: $score / ${quiz.questions.length}");
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
