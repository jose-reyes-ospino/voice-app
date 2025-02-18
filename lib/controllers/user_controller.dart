part of controllers;

class UserController extends StateNotifier<VoiceNote> {
  Ref<VoiceNote> ref;
  UserController({required this.ref})
      : super(VoiceNote(createdAt: DateTime.now()));

  final record = AudioRecorder();

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      log('Permission granted, starting recording');
      await record.start(const RecordConfig(), path: 'aFullPath/myFile.m4a');
    } else {
      log('Permission not granted');
    }
  }

  Future<void> stopRecording() async {
    await record.cancel();
    record.dispose();
  }
}
