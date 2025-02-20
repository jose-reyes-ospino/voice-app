part of services;

class FirebaseRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> sendHelloWorld() async {
    await _firestore.collection('documents').add({'message': 'Hello World'});
  }

  Future<void> saveVoiceNoteData(VoiceNote voiceNote) async {
    try {
      DocumentReference docRef = _firestore.collection('voiceNotes').doc();
      voiceNote = voiceNote.copyWith(id: docRef.id);
      await docRef.set(voiceNote.toJson());
    } catch (e) {
      log('Error saving voice note data: $e');
      rethrow;
    }
  }
}
