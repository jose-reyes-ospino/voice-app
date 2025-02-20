part of providers;

final playerProvider = StateNotifierProvider<PlayerController, AudioPlayer>(
  (Ref<AudioPlayer> ref) {
    return PlayerController(ref: ref);
  },
);
