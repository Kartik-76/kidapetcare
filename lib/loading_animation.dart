// loading_animation.dart
import 'package:flutter/material.dart';

class LoadingAnimation extends StatelessWidget {
  final String message;

  const LoadingAnimation({super.key, this.message = "Uploading..."});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 20),
          Text(
            message,
            style: const TextStyle(fontSize: 18),
          ),
        ],
      ),
    );
  }
}
