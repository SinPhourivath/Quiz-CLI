import 'package:firedart/firedart.dart';
import 'package:quiz_cli/env/env.dart';

void main() async {
  // Some test code for Firebase's connection
  const projectId = Env.projectId;

  Firestore.initialize(projectId);
  final firestore = Firestore.instance;

  var documents = await firestore.collection('Quiz').get();
  for (var doc in documents) {
    print('Document ID: ${doc.id}, Data: ${doc.map}');
  }
  /*******************************************************/
}
