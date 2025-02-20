part of controllers;

class PlayerController extends StateNotifier<AudioPlayer> {
  PlayerController({required this.ref}) : super(AudioPlayer());

  final Ref ref;

  bool get isPlaying {
    return state.state == PlayerState.playing;
  }

  Future<void> playVoiceNoteByUrl(String url) async {
    await state.play(UrlSource(url));
  }

  Future<void> playVoiceNoteByBytes(Uint8List bytes) async {
    await state.play(BytesSource(bytes));
  }

  void pauseVoiceNote() {
    state.pause();
  }
}
