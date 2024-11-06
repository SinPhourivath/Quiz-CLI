import 'dart:convert';
import 'dart:io';

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

  Future<List<Quiz>> getAllQuizzes() async {
    final document = firestore.collection('quizzes');
    final quizzes = await document.get();

    List<Quiz> quiz = quizzes.map((doc) {
      return Quiz.fromJson(doc.map);
    }).toList();

    return quiz;
  }

  Future<void> addQuizFromJson(String filePath) async {
    final document = firestore.collection('quizzes');

    try {
      final file = File(filePath);
      final jsonString = await file.readAsString();

      final jsonData = jsonDecode(jsonString);
      final quiz = Quiz.fromJson(jsonData);

      await document.add(quiz.toJson());

      print("Quiz from $filePath has been added to Firestore.");
    } catch (e) {
      print("Failed to load quiz from file: $e");
    }
  }

  Future<void> deleteQuiz(int index) async {
    try {
      final document = firestore.collection('quizzes');
      final quizzes = await document.get();

      index = index - 1;
      if (index < 0 || index >= quizzes.length) {
        print("Invalid choice.");
        return;
      }

      final documentToDelete = quizzes[index];
      final quizId = documentToDelete.id;

      await document.document(quizId).delete();
      print(
          "Quiz at index $index (ID: $quizId) has been deleted from Firestore.");
    } catch (e) {
      print("Failed to delete quiz at index $index: $e");
    }
  }

  // New method to save quiz result
  Future<void> saveQuizResult(String firstName, String lastName, int score) async {
    final document = firestore.collection('quizResults');

    try {
      await document.add({
        'firstName': firstName,
        'lastName': lastName,
        'score': score,
        'timestamp': DateTime.now(),// toIso8601String(),
      });

      //await document.add(.toJson()); must implement save to database

      print("Quiz result for $firstName $lastName has been saved to Firestore.");
    } catch (e) {
      print("Failed to save quiz result: $e");
    }
  }
}
