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
      showDialog<void>(
        context: context,
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
    }
  }

  Future<void> sendHelloWorld() async {
    try {
      await ref.read(userRepositoryProvider).sendHelloWorld();
    } catch (e) {
      log('Error sending hello world: $e');
    }
  }
}
