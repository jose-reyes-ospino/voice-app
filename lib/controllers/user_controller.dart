part of controllers;

class UserController extends StateNotifier<VoiceNote> {
  Ref<VoiceNote> ref;
  UserController({required this.ref})
      : super(VoiceNote(createdAt: DateTime.now()));

  AudioRecorder record = AudioRecorder();
  Stream<Uint8List>? voiceStream;
  String? directoryPath;
  List<Uint8List> audioData = [];

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      log('Permission granted, starting recording');

      await record.start(
        const RecordConfig(
          encoder: AudioEncoder.wav,
          bitRate: 44100,
          sampleRate: 44100,
          numChannels: 1,
        ),
        path: 'recording_${DateTime.now().millisecondsSinceEpoch}.wav',
      );

      state = state.copyWith(isRecording: true);
      log('Recording started');
    } else {
      log('Permission not granted');
    }
  }

  Future<void> stopRecording(context) async {
    final path = await record.stop();
    log('Recording stopped at path: $path');
    state = state.copyWith(isRecording: false);
    if (path != null) {
      state = state.copyWith(localPath: path);
      showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => const AlertDialog(
          content: SizedBox(
            height: 300,
            child: Padding(
              padding: EdgeInsets.all(16),
              child: RecordedWidget(),
            ),
          ),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('There was an error stopping recording')),
      );
    }
  }

  Future<void> sendHelloWorld() async {
    try {
      await ref.read(userRepositoryProvider).sendHelloWorld();
    } catch (e) {
      log('Error sending hello world: $e');
    }
  }

  Future<void> playVoiceNote() async {
    await ref.read(playerProvider.notifier).playVoiceNoteByUrl(state.localPath);
  }

  void pauseVoiceNote() {
    ref.read(playerProvider.notifier).pauseVoiceNote();
  }

  void discardVoiceNote(context) {
    state = VoiceNote(createdAt: DateTime.now());
    Navigator.of(context).pop();
  }

  Future<void> uploadVoiceNote() async {
    try {
      router.push(LoadingScreen.routeName);

      final String url =
          await ref.read(userStorageProvider).uploadVoiceNote(voiceNote: state);
      state = state.copyWith(audioUrl: url);
      log('Voice note uploaded successfully');
      await ref.read(userRepositoryProvider).saveVoiceNoteData(state);
    } catch (e) {
      log('Error uploading voice note: $e');
    }
  }
}
