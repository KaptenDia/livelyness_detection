import 'package:flutter/material.dart';
import 'dart:async';

class FaceDetectionIndicator extends StatefulWidget {
  final int maxSecToDetect;

  const FaceDetectionIndicator({
    required this.maxSecToDetect,
    super.key,
  });

  @override
  _FaceDetectionIndicatorState createState() => _FaceDetectionIndicatorState();
}

class _FaceDetectionIndicatorState extends State<FaceDetectionIndicator>
    with TickerProviderStateMixin {
  late AnimationController _progressController;
  late Animation<double> _progressAnimation;
  Timer? _timer;
  double _currentProgress = 1.0;

  @override
  void initState() {
    super.initState();

    // Initialize the circular progress indicator
    _progressController = AnimationController(
      duration: Duration(seconds: widget.maxSecToDetect),
      vsync: this,
    );
    _progressAnimation =
        Tween(begin: 1.0, end: 0.0).animate(_progressController)
          ..addListener(() {
            setState(() {
              _currentProgress = _progressAnimation.value;
            });
          });

    // Start the timer
    _startCountdown();
  }

  void _startCountdown() {
    _progressController.forward();
    _timer = Timer(Duration(seconds: widget.maxSecToDetect), () {
      _onTimeUp();
    });
  }

  void _onTimeUp() {
    // Action to perform when time is up
    if (mounted) {
      setState(() {
        // Show capture button or take any other action
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    _progressController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          // Background image for the face detection indicator
          IgnorePointer(
            ignoring: true,
            child: Image.asset(
              'packages/livelyness_detection/src/assets/bg_camera_overlay.png', // Use the correct path to the asset
              height: double.infinity,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),

          // Circular progress indicator
          // SizedBox(
          //   width: 100,
          //   height: 100,
          //   child: CircularProgressIndicator(
          //     value: _currentProgress,
          //     strokeWidth: 8,
          //     backgroundColor: Colors.grey.shade300,
          //     valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          //   ),
          // ),

          // Optional: Additional animated overlay (e.g., pulsing ring around the face)
          // Positioned(
          //   top: 0,
          //   left: 0,
          //   right: 0,
          //   bottom: 0,
          //   child: AnimatedOpacity(
          //     opacity: _currentProgress > 0.5 ? 1.0 : 0.5,
          //     duration: const Duration(milliseconds: 500),
          //     child: Container(
          //       decoration: BoxDecoration(
          //         shape: BoxShape.circle,
          //         border: Border.all(
          //           color: Colors.blue,
          //           width: 4,
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }
}
