part of services;

class UserStorageService {
  Future<String> uploadVoiceNote({
    required VoiceNote voiceNote,
  }) async {
    try {
      final fileName = 'notes/${voiceNote.createdAt.millisecondsSinceEpoch}';
      final file = XFile(voiceNote.localPath);
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref().child(fileName);

      final bytes = await file.readAsBytes();
      final uploadTask = await storageRef.putData(bytes);

      final downloadUrl = await uploadTask.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      log('Error en la subida de la nota de voz: $e');
      rethrow;
    }
  }
}
