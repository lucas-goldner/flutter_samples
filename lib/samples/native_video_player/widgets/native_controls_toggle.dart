import 'package:flutter/material.dart';

class NativeControlsToggle extends StatelessWidget {
  final bool showNativeControls;
  final ValueChanged<bool> onToggle;

  const NativeControlsToggle({
    super.key,
    required this.showNativeControls,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Native Controls',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () => onToggle(!showNativeControls),
              icon: Icon(
                showNativeControls
                    ? Icons.videogame_asset
                    : Icons.videogame_asset_off,
              ),
              label: Text(
                showNativeControls
                    ? 'Disable Native Controls'
                    : 'Enable Native Controls',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
