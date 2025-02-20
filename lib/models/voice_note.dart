part of models;

class VoiceNote {
  VoiceNote({
    required this.createdAt,
    this.id = '',
    this.audioUrl = '',
    this.localPath = '',
    this.isRecording = false,
  });

  final String id;
  final String audioUrl;
  final DateTime createdAt;
  final bool isRecording;
  final String localPath;

  factory VoiceNote.fromJson(Map<String, dynamic> json) {
    return VoiceNote(
      id: json['id'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      createdAt: json['createdAt'] ?? DateTime.now(),
      localPath: json['localPath'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'audioUrl': audioUrl,
      'createdAt': createdAt,
      'localPath': localPath,
    };
  }

  VoiceNote copyWith({
    String? id,
    String? audioUrl,
    DateTime? createdAt,
    bool? isRecording,
    String? localPath,
  }) {
    return VoiceNote(
      id: id ?? this.id,
      audioUrl: audioUrl ?? this.audioUrl,
      createdAt: createdAt ?? this.createdAt,
      isRecording: isRecording ?? this.isRecording,
      localPath: localPath ?? this.localPath,
    );
  }
}
