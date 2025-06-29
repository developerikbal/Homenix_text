// File: lib/developer/real_time_status_mock.dart

import 'dart:async';
import 'package:flutter/material.dart';

class RealTimeStatusMock extends StatefulWidget {
  final VoidCallback? onComplete;

  const RealTimeStatusMock({Key? key, this.onComplete}) : super(key: key);

  @override
  _RealTimeStatusMockState createState() => _RealTimeStatusMockState();
}

class _RealTimeStatusMockState extends State<RealTimeStatusMock> {
  late Timer _timer;
  int _progress = 0;
  final int _maxProgress = 100;
  bool _isCompleted = false;

  @override
  void initState() {
    super.initState();
    _startMockUpload();
  }

  void _startMockUpload() {
    _timer = Timer.periodic(const Duration(milliseconds: 100), (timer) {
      if (_progress >= _maxProgress) {
        timer.cancel();
        setState(() {
          _isCompleted = true;
        });
        if (widget.onComplete != null) {
          widget.onComplete!();
        }
      } else {
        setState(() {
          _progress += 5;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        LinearProgressIndicator(
          value: _progress / _maxProgress,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(
            _isCompleted ? Colors.green : Colors.blue,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          _isCompleted
              ? 'Upload Complete'
              : 'Uploading... $_progress%',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }
}