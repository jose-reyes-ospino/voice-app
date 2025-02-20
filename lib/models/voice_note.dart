part of models;

class VoiceNote {
  VoiceNote({
    required this.createdAt,
    this.id = '',
    this.audioUrl = '',
    this.isRecording = false,
  });

  final String id;
  final String audioUrl;
  final DateTime createdAt;
  final bool isRecording;

  factory VoiceNote.fromJson(Map<String, dynamic> json) {
    return VoiceNote(
      id: json['id'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'audioUrl': audioUrl,
      'createdAt': createdAt,
    };
  }

  VoiceNote copyWith({
    String? id,
    String? audioUrl,
    DateTime? createdAt,
    bool? isRecording,
  }) {
    return VoiceNote(
      id: id ?? this.id,
      audioUrl: audioUrl ?? this.audioUrl,
      createdAt: createdAt ?? this.createdAt,
      isRecording: isRecording ?? this.isRecording,
    );
  }
}
