part of services;

class UserStorageService {
  Future<String> uploadVoiceNote({
    required VoiceNote voiceNote,
    Function(double)? onProgress,
  }) async {
    try {
      final fileName = 'notes/${voiceNote.createdAt.millisecondsSinceEpoch}';
      final file = XFile(voiceNote.localPath);
      final storage = FirebaseStorage.instance;
      final storageRef = storage.ref().child(fileName);

      final bytes = await file.readAsBytes();
      final uploadTask = storageRef.putData(bytes);

      uploadTask.snapshotEvents.listen((TaskSnapshot snapshot) {
        final progress = snapshot.bytesTransferred / snapshot.totalBytes;
        onProgress?.call(progress);
      });

      final downloadUrl =
          await uploadTask.then((snapshot) => snapshot.ref.getDownloadURL());
      return downloadUrl;
    } catch (e) {
      log('Error en la subida de la nota de voz: $e');
      rethrow;
    }
  }
}
