import 'package:firedart/firedart.dart';
import 'package:quiz_cli/env/env.dart';
import 'package:quiz_cli/model.dart';

class FirestoreDB {
  late final Firestore firestore;

  FirestoreDB(this.firestore);

  factory FirestoreDB.initialize() {
    Firestore.initialize(Env.projectId);
    return FirestoreDB(Firestore.instance);
  }

  Future<void> addQuiz(Quiz quiz) async {
    final document = firestore.collection('quizzes');
    await document.add(quiz.toJson());
  }

  Future<List<Quiz>> getAllQuizzes() async {
    final document = firestore.collection('quizzes');
    final quizzes = await document.get();

    List<Quiz> quiz = quizzes.map((doc) {
      return Quiz.fromJson(doc.map);
    }).toList();

    return quiz;
  }
}
