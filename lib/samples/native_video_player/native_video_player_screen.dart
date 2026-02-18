import 'package:flutter/material.dart';
import 'package:native_video_player/native_video_player.dart';
import 'widgets/widgets.dart';

class NativeVideoPlayerScreen extends StatefulWidget {
  const NativeVideoPlayerScreen({super.key});

  @override
  State<NativeVideoPlayerScreen> createState() =>
      _NativeVideoPlayerScreenState();
}

class _NativeVideoPlayerScreenState extends State<NativeVideoPlayerScreen> {
  NativeVideoPlayerController? _controller;
  bool _isPlaying = false;
  bool _isLooping = false;
  double _playbackSpeed = 1.0;
  double _volume = 1.0;
  Duration _currentPosition = Duration.zero;
  final Duration _videoDuration = Duration.zero;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void _setupEventListeners() {
    _controller?.events.listen((event) {
      switch (event) {
        case PlaybackStatusChangedEvent(:final status):
          setState(() {
            _isPlaying = status == PlaybackStatus.playing;
          });
        case PlaybackPositionChangedEvent(:final position):
          setState(() {
            _currentPosition = position;
          });
        case PlaybackReadyEvent():
          // Video is ready to play
          break;
        case PlaybackEndedEvent():
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Video playback completed')),
            );
          }
        case PlaybackErrorEvent():
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Playback error occurred')),
            );
          }
        case PlaybackSpeedChangedEvent():
          // Speed changed
          break;
        case VolumeChangedEvent():
          // Volume changed
          break;
      }
    });

    // Auto-load a sample video
    _loadVideoFromNetwork();
  }

  void _loadVideoFromAssets() {
    if (_controller != null) {
      _controller!.loadVideo(
        VideoSource(
          path: 'assets/sample_video.mp4',
          type: VideoSourceType.asset,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading video from assets...')),
      );
    }
  }

  void _loadVideoFromNetwork() {
    if (_controller != null) {
      _controller!.loadVideo(
        VideoSource(
          path:
              'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
          type: VideoSourceType.network,
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading video from network...')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Native Video Player Demo'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            VideoPlayerWidget(
              onViewReady: (controller) {
                _controller = controller;
                _setupEventListeners();
              },
            ),
            VideoInfoCard(
              isPlaying: _isPlaying,
              currentPosition: _currentPosition,
              videoDuration: _videoDuration,
            ),
            const SizedBox(height: 16),
            PlaybackControls(
              isPlaying: _isPlaying,
              isLooping: _isLooping,
              controller: _controller,
              onToggleLoop: () {
                setState(() => _isLooping = !_isLooping);
              },
            ),
            const SizedBox(height: 16),
            PlaybackSpeedControl(
              playbackSpeed: _playbackSpeed,
              onSpeedChanged: (value) {
                setState(() => _playbackSpeed = value);
              },
            ),
            const SizedBox(height: 16),
            VolumeControl(
              volume: _volume,
              onVolumeChanged: (value) {
                setState(() => _volume = value);
              },
            ),
            const SizedBox(height: 16),
            LoadVideoButtons(
              onLoadFromAssets: _loadVideoFromAssets,
              onLoadFromNetwork: _loadVideoFromNetwork,
            ),
            const SizedBox(height: 24),
            const FeaturesList(),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
