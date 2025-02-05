part of models;

class VoiceNote {
  VoiceNote({
    required this.createdAt,
    this.id = '',
    this.audioUrl = '',
  });

  final String id;
  final String audioUrl;
  final DateTime createdAt;

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
}
