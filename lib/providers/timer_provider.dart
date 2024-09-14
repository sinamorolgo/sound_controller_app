import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../services/volume_service.dart';
import 'dart:math' as math;

class TimerProvider extends ChangeNotifier {
  int _timerSeconds = 0;
  int _timeSetFirst = 0;
  bool _isRunning = false;
  Timer? _timer;
  final VolumeService _volumeService;

  TimerProvider(this._volumeService);

  int get timerMinutes => _timerSeconds ~/ 60;
  int get timerSeconds => _timerSeconds % 60;
  bool get isRunning => _isRunning;

  void incrementTimer() {
    _timerSeconds += 60;
    notifyListeners();
  }

  void decrementTimer() {
    if (_timerSeconds > 60) {
      _timerSeconds -= 60;
      notifyListeners();
    }
  }

  void startTimer() {
    if (_isRunning || _timerSeconds == 0) return;
    _timeSetFirst = _timerSeconds;
    _isRunning = true;
    notifyListeners();

    int totalSeconds = _timerSeconds;
    int elapsedSeconds = 0;

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      elapsedSeconds++;
      _timerSeconds--;
      notifyListeners();

      double volumeFraction =
          _calculateVolumeFraction(elapsedSeconds, totalSeconds);
      _volumeService.adjustVolume(volumeFraction);

      if (_timerSeconds <= 0) {
        stopTimer();
        _volumeService.stopMusic();
      }
    });
  }

  void stopTimer() {
    _timer?.cancel();
    _isRunning = false;
    _timerSeconds = _timeSetFirst;
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
