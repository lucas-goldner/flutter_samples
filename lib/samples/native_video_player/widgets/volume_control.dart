import 'package:flutter/material.dart';

class VolumeControl extends StatelessWidget {
  final double volume;
  final ValueChanged<double> onVolumeChanged;

  const VolumeControl({
    super.key,
    required this.volume,
    required this.onVolumeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Volume',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                '${(volume * 100).toStringAsFixed(0)}%',
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ],
          ),
          Slider(
            value: volume,
            min: 0.0,
            max: 1.0,
            divisions: 10,
            label: (volume * 100).toStringAsFixed(0),
            onChanged: onVolumeChanged,
          ),
        ],
      ),
    );
  }
}
