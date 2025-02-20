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

  void pauseVoiceNote() {
    state.pause();
  }
}
