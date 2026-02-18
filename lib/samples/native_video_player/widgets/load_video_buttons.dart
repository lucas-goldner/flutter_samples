import 'package:flutter/material.dart';

class LoadVideoButtons extends StatelessWidget {
  final VoidCallback onLoadFromAssets;
  final VoidCallback onLoadFromNetwork;

  const LoadVideoButtons({
    super.key,
    required this.onLoadFromAssets,
    required this.onLoadFromNetwork,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Load Video',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLoadFromAssets,
              child: const Text('Load from Assets'),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: onLoadFromNetwork,
              child: const Text('Load from Network'),
            ),
          ),
        ],
      ),
    );
  }
}
