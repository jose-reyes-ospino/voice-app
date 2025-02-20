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

  Future<Uint8List?> downloadVoiceNoteBytes({
    required VoiceNote voiceNote,
    required Function(double) onProgress,
  }) async {
    try {
      final ref = FirebaseStorage.instance
          .ref()
          .child('notes/${voiceNote.createdAt.millisecondsSinceEpoch}');
      print('ref: $ref');

      final downloadUrl = await ref.getDownloadURL();
      print('downloadUrl: $downloadUrl');

      final response = await http.get(Uri.parse(downloadUrl));
      if (response.statusCode == 200) {
        final audioBytes = response.bodyBytes;
        print('audioBytes: $audioBytes');
        return audioBytes;
      } else {
        throw Exception('Error al descargar los bytes del archivo');
      }
    } catch (e) {
      print('Error al descargar nota de voz: $e');
      rethrow;
    }
  }
}
