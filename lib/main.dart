import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Padding(
        padding: EdgeInsets.all(32.0),
        child: SquareAnimation(),
      ),
    );
  }
}

class SquareAnimation extends StatefulWidget {
  const SquareAnimation({super.key});

  @override
  State<SquareAnimation> createState() {
    return SquareAnimationState();
  }
}

class SquareAnimationState extends State<SquareAnimation> {
  static const _squareSize = 50.0;
  bool _isAlignedRight = false;
  bool _isAnimationRunning = false;
  bool _isStartingPosition = true;

  void _rightSideAnimation() {
    setState(() {
      if (!_isAlignedRight) {
        _isAnimationRunning = true;
        _isAlignedRight = true;
        _isStartingPosition = false;
      }
    });
  }

  void _leftSideAnimation() {
    setState(() {
      if (_isAlignedRight) {
        _isAnimationRunning = true;
        _isAlignedRight = false;
        _isStartingPosition = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedAlign(
          duration: Duration(seconds: 1),
          onEnd: () {
            setState(() {
              _isAnimationRunning = false;
            });
          },
          alignment: _isStartingPosition
              ? Alignment.center
              : _isAlignedRight
              ? Alignment.centerRight
              : Alignment.centerLeft,
          child: Container(
            width: _squareSize,
            height: _squareSize,
            decoration: BoxDecoration(
              color: Colors.red,
              border: Border.all(),
            ),
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            ElevatedButton(
              onPressed: _leftSideAnimation,
              child: const Text('Left'),
              style: ElevatedButton.styleFrom(
                backgroundColor: !_isStartingPosition &&
                    (!_isAlignedRight || _isAnimationRunning)
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              onPressed: _rightSideAnimation,
              child: const Text('Right'),
              style: ElevatedButton.styleFrom(
                backgroundColor: !_isStartingPosition &&
                    (_isAlignedRight || _isAnimationRunning)
                    ? Colors.grey
                    : Colors.white,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
