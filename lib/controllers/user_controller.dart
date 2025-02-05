part of controllers;

class UserController extends StateNotifier<VoiceNote> {
  Ref<VoiceNote> ref;
  UserController({required this.ref})
      : super(VoiceNote(createdAt: DateTime.now()));
}
