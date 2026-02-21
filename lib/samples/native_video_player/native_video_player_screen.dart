import 'package:flutter/material.dart';
import 'package:golden_video_player/golden_video_player.dart';
import 'widgets/widgets.dart';

class NativeVideoPlayerScreen extends StatefulWidget {
  const NativeVideoPlayerScreen({super.key});

  @override
  State<NativeVideoPlayerScreen> createState() =>
      _NativeVideoPlayerScreenState();
}

class _NativeVideoPlayerScreenState extends State<NativeVideoPlayerScreen> {
  NativeVideoPlayerController? _controller;
  VideoSource? _currentVideoSource;
  bool _isPlaying = false;
  bool _isLooping = false;
  bool _isPictureInPictureActive = false;
  bool _showNativeControls = false;
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
      final videoSource = VideoSource(
        path: 'assets/sample_video.mp4',
        type: VideoSourceType.asset,
      );
      _currentVideoSource = videoSource;
      _controller!.loadVideo(videoSource);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Loading video from assets...')),
      );
    }
  }

  void _loadVideoFromNetwork() {
    if (_controller != null) {
      final videoSource = VideoSource(
        path:
            'https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/BigBuckBunny.mp4',
        type: VideoSourceType.network,
      );
      _currentVideoSource = videoSource;
      _controller!.loadVideo(videoSource);
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
                // Reload the previous video if one was loaded
                if (_currentVideoSource != null) {
                  _controller?.loadVideo(_currentVideoSource!);
                }
              },
              showNativeControls: _showNativeControls,
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
            const SizedBox(height: 16),
            NativeControlsToggle(
              showNativeControls: _showNativeControls,
              onToggle: (value) {
                setState(() => _showNativeControls = value);
              },
            ),
            const SizedBox(height: 16),
            PictureInPictureToggle(
              isPictureInPictureActive: _isPictureInPictureActive,
              controller: _controller,
              onToggle: (value) {
                setState(() => _isPictureInPictureActive = value);
              },
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
