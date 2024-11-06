import 'package:quiz_cli/logic.dart';
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
    Logic logic = Logic();

    do {
      String input = logic.promptForValidNumber("Choose a quiz to attempt: ");
      int selectedIndex = int.parse(input) - 1;

      if (selectedIndex >= 0 && selectedIndex < quizzes.length) {
        Quiz selectedQuiz = quizzes[selectedIndex];
        takeQuiz(selectedQuiz);
      } else {
        print("Invalid selection. Please try again.");
      }
    } while (true);
  }

  void takeQuiz(Quiz quiz) {
    Logic logic = Logic();

    String firstName = logic.promptForValidString("\nEnter your first name: ");
    String lastName = logic.promptForValidString("Enter your last name: ");

    print("\nStarting Quiz: ${quiz.title}");
    print('${quiz.description}\n');

    int score = 0;

    for (var question in quiz.questions) {
      print(question.questionText);
      question.answers.forEach((key, value) {
        print('$key: $value');
      });

      String? userAnswer;

      // Check if answer are listed alphabetically or numerically
      String answerType = question.answers.keys.first;
      if (int.tryParse(answerType) == null) {
        question.isMultiChoice
            ? userAnswer = logic.promptForValidStringList("Your answer: ")
            : userAnswer = logic.promptForValidString("Your answer: ");
      } else {
        question.isMultiChoice
            ? userAnswer = logic.promptForValidNumberList("Your answer: ")
            : userAnswer = logic.promptForValidNumber("Your answer: ");
      }

      bool isCorrect = checkAnswer(question, userAnswer);

      if (isCorrect) {
        print('Correct!\n');
        score++;
      } else {
        print('Incorrect. The correct answer is: ${question.correctAnswer}\n');
      }
    }

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

      return Set.from(userAnswers).containsAll(Set.from(correctAnswers)) &&
          Set.from(correctAnswers).containsAll(Set.from(userAnswers));
    } else {
      return userAnswer == question.correctAnswer;
    }
  }
}
