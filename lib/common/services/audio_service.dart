import '../utils.dart';

enum AudioStatus {
  buffering,

  /// Currently playing audio.
  playing,

  /// Pause has been called.
  paused,

  /// initial state, stop has been called or an error occurred.
  stopped,

  /// The audio successfully completed (reached the end).
  completed,
}

class AudioModel<T> {
  final AudioStatus status;
  final String uri;
  final Duration? _progress;
  final Duration? duration;
  final String? name;
  final String? des;
  final T? data;

  const AudioModel({
    this.status = AudioStatus.buffering,
    required this.uri,
    Duration? progress,
    this.duration,
    this.name,
    this.des,
    this.data,
  }) : _progress = progress;

  Duration get progress => _progress ?? Duration.zero;

  AudioModel<T> copyWith({
    AudioStatus? status,
    String? uri,
    Duration? progress,
    Duration? duration,
    String? name,
    String? des,
    T? data,
  }) {
    return AudioModel<T>(
      status: status ?? this.status,
      uri: uri ?? this.uri,
      progress: progress ?? this.progress,
      duration: duration ?? this.duration,
      name: name ?? this.name,
      des: des ?? this.des,
      data: data ?? this.data,
    );
  }

  bool get isPlaying => status == AudioStatus.playing;
  bool get isPaused => status == AudioStatus.paused;
  bool get isBuffering => status == AudioStatus.buffering;
  bool get isStopped => status == AudioStatus.stopped;
  bool get isCompleted => status == AudioStatus.completed;

  bool get isLocal => uri.isLocalUrl;

  @override
  String toString() {
    return '''AudioModel(
  status: $status, 
  uri: $uri, 
  progress: $_progress, 
  duration: $duration, 
  name: $name, 
  des: $des, 
  data: $data,
  isLocal: $isLocal,
)''';
  }
}

abstract class AudioService {
  AudioModel? get currentAudio;
  Stream<AudioModel?> get audioStream;
  Future<bool> playUri(String uri);
  Future<bool> playAudio(AudioModel audio);
  Future<bool> seek(Duration position);
  Future<bool> pauseOrResume();
  Future<bool> stop();
  void dispose();
}
