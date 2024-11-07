class Quiz {
  final String _title;
  final String _description;
  final List<Question> _questions;

  Quiz({
    required String title,
    required String description,
    required List<Question> questions,
  })  : _title = title,
        _description = description,
        _questions = questions;

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      title: json['title'] as String,
      description: json['description'] as String,
      questions: (json['questions'] as List)
          .map((question) => Question.fromJson(question))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'questions': questions.map((question) => question.toJson()).toList(),
    };
  }

  String get title => _title;
  String get description => _description;
  List<Question> get questions => _questions;

  @override
  String toString() {
    return 'Title: $title\nDescription: $description\n\n$questions';
  }
}

class Question {
  final String _questionText;
  final Map<String, String> _answers;
  final bool _isMultiChoice;
  final dynamic _correctAnswer;

  Question({
    required String questionText,
    required Map<String, String> answers,
    required bool isMultiChoice,
    required dynamic correctAnswer,
  })  : _questionText = questionText,
        _answers = answers,
        _isMultiChoice = isMultiChoice,
        _correctAnswer = correctAnswer;

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

  bool validateAnswer(String userAnswer) {
    final validOptions = _answers.keys.toSet();
    if (_isMultiChoice) {
      final userAnswers = userAnswer.split(',').map((e) => e.trim()).toSet();
      return userAnswers.isNotEmpty &&
          userAnswers.difference(validOptions).isEmpty;
    } else {
      return validOptions.contains(userAnswer);
    }
  }

  String get questionText => _questionText;
  Map<String, String> get answers => _answers;
  bool get isMultiChoice => _isMultiChoice;
  dynamic get correctAnswer => _correctAnswer;

  @override
  String toString() {
    return 'Questions: $questionText\nAnswers: $answers\nisMultiChoice: $isMultiChoice\ncorrectAnswer: $correctAnswer\n\n';
  }
}

class Student {
  final String _firstName;
  final String _lastName;

  Student({
    required String firstName,
    required String lastName,
  })  : _firstName = firstName,
        _lastName = lastName;

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
    };
  }

  String get firstName => _firstName;
  String get lastName => _lastName;

  @override
  String toString() {
    return 'Student: $firstName $lastName';
  }
}

class QuizResult {
  final String _quizName;
  final String _studentName;
  final int _score;
  final List<QuestionResult> _questionResults;

  QuizResult({
    required String quizName,
    required String studentName,
    required int score,
    required List<QuestionResult> questionResults,
  })  : _quizName = quizName,
        _studentName = studentName,
        _score = score,
        _questionResults = questionResults;

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

  Map<String, dynamic> toJson() {
    return {
      'quizName': quizName,
      'studentName': studentName,
      'score': score,
      'questionResults': questionResults.map((q) => q.toJson()).toList(),
    };
  }

  String get quizName => _quizName;
  String get studentName => _studentName;
  int get score => _score;
  List<QuestionResult> get questionResults => _questionResults;

  @override
  String toString() {
    return 'QuizResult for Student $studentName\nQuiz Name: $quizName\nScore: $score\nQuestions: $questionResults';
  }
}

class QuestionResult {
  final String _questionText;
  final String _selectedAnswer;
  final bool _isCorrect;

  QuestionResult({
    required String questionText,
    required String selectedAnswer,
    required bool isCorrect,
  })  : _questionText = questionText,
        _selectedAnswer = selectedAnswer,
        _isCorrect = isCorrect;

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      questionText: json['questionText'] as String,
      selectedAnswer: json['selectedAnswer'] as String,
      isCorrect: json['isCorrect'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'questionText': questionText,
      'selectedAnswer': selectedAnswer,
      'isCorrect': isCorrect,
    };
  }

  String get questionText => _questionText;
  String get selectedAnswer => _selectedAnswer;
  bool get isCorrect => _isCorrect;

  @override
  String toString() {
    return 'Question: $questionText\nSelected Answer: $selectedAnswer\nCorrect: $isCorrect\n';
  }
}
