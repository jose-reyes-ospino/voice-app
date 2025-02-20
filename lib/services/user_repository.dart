part of services;

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _voiceNotesCollection =
    _firestore.collection('voiceNotes');

class FirebaseRepository {
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

  Query<VoiceNote> getAllVoiceNotesQuery() => _voiceNotesCollection
      .orderBy('createdAt', descending: true)
      .withConverter(
        fromFirestore: (snapshot, _) => VoiceNote.fromJson(snapshot.data()!),
        toFirestore: (visit, _) => visit.toJson(),
      );
}
