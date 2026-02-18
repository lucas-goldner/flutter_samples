import 'package:flutter/material.dart';
import 'samples/samples.dart';
import 'samples/native_video_player/native_video_player_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Samples',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: const SamplesListScreen(),
    );
  }
}

class SamplesListScreen extends StatelessWidget {
  const SamplesListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Samples'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: Samples.values.length,
        itemBuilder: (context, index) {
          final sample = Samples.values[index];
          return ListTile(
            title: Text(sample.displayName),
            subtitle: Text(sample.description),
            trailing: const Icon(Icons.arrow_forward),
            onTap: () {
              _navigateToSample(context, sample);
            },
          );
        },
      ),
    );
  }

  void _navigateToSample(BuildContext context, Samples sample) {
    Widget screen;

    switch (sample) {
      case Samples.nativeVideoPlayer:
        screen = const NativeVideoPlayerScreen();
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => screen),
    );
  }
}
