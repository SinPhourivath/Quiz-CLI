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

  @override
  String toString() {
    return 'Questions: $questionText\nAnswers: $answers\nisMultiChoice: $isMultiChoice\ncorrectAnswer: $correctAnswer\n\n';
  }
}
