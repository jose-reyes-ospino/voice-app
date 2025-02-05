part of providers;

final userProvider = StateNotifierProvider<UserController, VoiceNote>(
  (Ref<VoiceNote> ref) {
    return UserController(ref: ref);
  },
);
