part of services;

class UserStorageService {
  Future<String> uploadVoiceNote({
    required VoiceNote voiceNote,
    Function(double)? onProgress,
  }) async {
    try {
      final fileName =
          'notes/${voiceNote.createdAt.millisecondsSinceEpoch}.wav';
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
          .child('notes/${voiceNote.createdAt.millisecondsSinceEpoch}.wav');

      final downloadUrl = await ref.getDownloadURL();

      // Usar dio en lugar de http para mejor manejo de progreso y errores
      final dio = Dio();
      final response = await dio.get(
        downloadUrl,
        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'Access-Control-Allow-Origin': '*',
          },
        ),
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            onProgress(progress);
          }
        },
      );

      if (response.statusCode == 200) {
        final audioBytes = response.data as Uint8List;
        return audioBytes;
      } else {
        throw Exception(
            'Error al descargar los bytes del archivo: ${response.statusCode}');
      }
    } on DioException catch (e) {
      print('Error de Dio al descargar nota de voz: ${e.message}');
      log('Error tipo: ${e.type}');
      log('Error respuesta: ${e.response}');
      rethrow;
    } catch (e) {
      log('Error general al descargar nota de voz: $e');
      rethrow;
    }
  }
}
