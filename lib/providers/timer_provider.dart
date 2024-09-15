import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../services/volume_service.dart';
import 'dart:math' as math;

class TimerProvider extends ChangeNotifier {
  int _remainingSeconds = 0;
  int _totalSecondsFirstSet = 0;
  bool _isRunning = false;
  Timer? _timer;
  final VolumeService _volumeService;

  TimerProvider(this._volumeService);

  int get timerMinutes => _remainingSeconds ~/ 60;
  int get timerSeconds => _remainingSeconds % 60;
  int get timerSecondsFirstSet => _totalSecondsFirstSet;
  int get remainingSeconds => _remainingSeconds;
  bool get isRunning => _isRunning;

  void incrementTimer() {
    _remainingSeconds += 60;
    notifyListeners();
  }

  void decrementTimer() {
    if (_remainingSeconds > 60) {
      _remainingSeconds -= 60;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_isRunning || _remainingSeconds == 0) return;
    _totalSecondsFirstSet = _remainingSeconds;
    _isRunning = true;
    notifyListeners();

    int totalSeconds = _remainingSeconds;
    int elapsedSeconds = 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      _remainingSeconds--;
      notifyListeners();

      double volumeFraction =
          _calculateVolumeFraction(elapsedSeconds, totalSeconds);
      _volumeService.adjustVolume(volumeFraction);

      if (_remainingSeconds <= 0) {
        stopTimer();
        _volumeService.stopMusic();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _remainingSeconds = _totalSecondsFirstSet;
    notifyListeners();
    _volumeService.resetVolume();
  }

  double _calculateVolumeFraction(int elapsedSeconds, int totalSeconds) {
    if (elapsedSeconds >= totalSeconds) {
      return 0.1;
    } else {
      double halfLife = 300; // 5 minutes
      double decayConstant = (math.log(2) / halfLife);
      return math.exp(-decayConstant * elapsedSeconds);
    }
  }
}
