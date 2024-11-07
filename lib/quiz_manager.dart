import 'package:quiz_cli/logic.dart';
import 'package:quiz_cli/model.dart';

class QuizManager {
  final List<Quiz> quizzes;

  QuizManager(this.quizzes);

  void displayAvailableQuiz() {
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

  Quiz selectQuiz() {
    Logic logic = Logic();

    do {
      String input = logic.promptForNum("Choose a quiz to attempt: ");
      int selectedIndex = int.parse(input) - 1;

      if (selectedIndex >= 0 && selectedIndex < quizzes.length) {
        Quiz selectedQuiz = quizzes[selectedIndex];
        return selectedQuiz;
      } else {
        print("Invalid selection. Please try again.");
      }
    } while (true);
  }

  QuizResult takeQuiz() {
    Quiz quiz = selectQuiz();

    Logic logic = Logic();

    String firstName = logic.promptForChar("\nEnter your first name: ");
    String lastName = logic.promptForChar("Enter your last name: ");

    print("\nStarting Quiz: ${quiz.title}");
    print('${quiz.description}\n');

    int score = 0;
    List<QuestionResult> questionResults = [];

    for (var question in quiz.questions) {
      bool isMultiChoice = !question.isMultiChoice;

      print(question.questionText);

      isMultiChoice ? print("Please choose exactly one answer") : print("Please choose multiple answers");
      question.answers.forEach((key, value) {
        print('$key: $value');
      });

      String? userAnswer;
      String answerType = question.answers.keys.first;

      do {
        if (int.tryParse(answerType) == null) {
          if (question.isMultiChoice) {
            userAnswer = logic.promptForCharList("Enter your answer: ");
            if (!question.validateAnswer(userAnswer!)) {
              print("Please only choose the available option.");
              userAnswer = "";
            }
          } else {
            userAnswer = logic.promptForChar("Enter your answer: ");
            if (!question.validateAnswer(userAnswer)) {
              print("Please only choose the available option.");
              userAnswer = "";
            }
          }
        } else {
          if (question.isMultiChoice) {
            userAnswer = logic.promptForNumList("Enter your answer: ");
            if (!question.validateAnswer(userAnswer!)) {
              print("Please only choose the available option.");
              userAnswer = "";
            }
          } else {
            userAnswer = logic.promptForNum("Enter your answer: ");
            if (!question.validateAnswer(userAnswer)) {
              print("Please only choose the available option.");
              userAnswer = "";
            }
          }
        }
      } while (userAnswer == "");

      bool isCorrect = checkAnswer(question, userAnswer);

      if (isCorrect) {
        print('Correct!\n');
        score++;
      } else {
        print('Incorrect. The correct answer is: ${question.correctAnswer}\n');
      }

      questionResults.add(QuestionResult(
          questionText: question.questionText,
          selectedAnswer: userAnswer,
          isCorrect: isCorrect));
    }

    print("Quiz Completed!");
    print("Student: $firstName $lastName");
    print("Score: $score / ${quiz.questions.length}");

    return QuizResult(
        quizName: quiz.title,
        studentName: "$firstName $lastName",
        score: score,
        questionResults: questionResults);
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
