part of services;

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendHelloWorld() async {
    await _firestore.collection('documents').add({'message': 'Hello World'});
  }
}
