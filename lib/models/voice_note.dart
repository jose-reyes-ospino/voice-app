part of models;

class VoiceNote {
  VoiceNote({
    required this.createdAt,
    this.id = '',
    this.audioUrl = '',
    this.localPath = '',
    this.isRecording = false,
    this.loadingProgress = 0,
    this.audioBytes,
  });

  final String id;
  final String audioUrl;
  final DateTime createdAt;
  final bool isRecording;
  final String localPath;
  final double loadingProgress;
  final Uint8List? audioBytes;

  factory VoiceNote.fromJson(Map<String, dynamic> json) {
    Timestamp timestamp = json['createdAt'] ?? Timestamp.now();
    DateTime creationTime = timestamp.toDate();

    return VoiceNote(
      id: json['id'] ?? '',
      audioUrl: json['audioUrl'] ?? '',
      createdAt: creationTime,
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
    String? localPath,
    double? loadingProgress,
    Uint8List? audioBytes,
  }) {
    return VoiceNote(
      id: id ?? this.id,
      audioUrl: audioUrl ?? this.audioUrl,
      createdAt: createdAt ?? this.createdAt,
      isRecording: isRecording ?? this.isRecording,
      localPath: localPath ?? this.localPath,
      loadingProgress: loadingProgress ?? this.loadingProgress,
      audioBytes: audioBytes ?? this.audioBytes,
    );
  }
}
