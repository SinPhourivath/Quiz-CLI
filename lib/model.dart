class Quiz {
  final String title;
  final String description;
  final List<Question> questions;

  Quiz({
    required this.title,
    required this.description,
    required this.questions,
  });

  // Create an instace from a JSON
  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }

  // Convert instacne back to JSON
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'Title: $title\nDescription: $description\n\n$questions';
  }
}

class Question {
  final String questionText;
  final Map<String, String> answers;
  final bool isMultiChoice;
  final dynamic
      correctAnswer; // List<String> or String depending on isMultiChoice

  Question({
    required this.questionText,
    required this.answers,
    required this.isMultiChoice,
    required this.correctAnswer,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      questionText: json['questionText'] as String,
      answers: Map<String, String>.from(json['answers']),
      isMultiChoice: json['isMultiChoice'] as bool,
      correctAnswer: json['isMultiChoice']
          ? List<String>.from(json['correctAnswer'])
          : json['correctAnswer'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'answers': answers,
      'isMultiChoice': isMultiChoice,
      'correctAnswer': correctAnswer,
    };
  }

  bool validateAnswer(
    String userAnswer,
  ) {
    final validOptions = answers.keys.toSet();
    if (isMultiChoice) {
      final userAnswers = userAnswer.split(',').map((e) => e.trim()).toSet();
      return userAnswers.isNotEmpty &&
          userAnswers.difference(validOptions).isEmpty;
    } else {
      return validOptions.contains(userAnswer);
    }
  }

  @override
  String toString() {
    return 'Questions: $questionText\nAnswers: $answers\nisMultiChoice: $isMultiChoice\ncorrectAnswer: $correctAnswer\n\n';
  }
}

class Student {
  final String firstName;
  final String lastName;

  Student({
    required this.firstName,
    required this.lastName,
  });

  // Create an instance from JSON
  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  // Convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  @override
  String toString() {
    return 'Student: $firstName $lastName';
  }
}

class QuizResult {
  final String quizName;
  final String studentName;
  final int score;
  final List<QuestionResult> questionResults;

  QuizResult({
    required this.quizName,
    required this.studentName,
    required this.score,
    required this.questionResults,
  });

  // Create an instance from JSON
  factory QuizResult.fromJson(Map<String, dynamic> json) {
    return QuizResult(
      quizName: json['quizName'] as String,
      studentName: json['studentName'] as String,
      score: json['score'] as int,
      questionResults: (json['questionResults'] as List)
          .map((question) => QuestionResult.fromJson(question))
          .toList(),
    );
  }

  // Convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'quizName': quizName,
      'studentName': studentName,
      'score': score,
      'questionResults': questionResults.map((q) => q.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'QuizResult for Student $studentName\nQuiz Name: $quizName\n Score: $score\nQuestions: $questionResults';
  }
}

class QuestionResult {
  final String questionText;
  final String selectedAnswer;
  final bool isCorrect;

  QuestionResult({
    required this.questionText,
    required this.selectedAnswer,
    required this.isCorrect,
  });

  // Create an instance from JSON
  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      questionText: json['questionText'] as String,
      selectedAnswer: json['selectedAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  // Convert instance back to JSON
  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'selectedAnswer': selectedAnswer,
      'isCorrect': isCorrect,
    };
  }

  @override
  String toString() {
    return 'Question: $questionText\nSelected Answer: $selectedAnswer\nCorrect: $isCorrect\n';
  }
}
