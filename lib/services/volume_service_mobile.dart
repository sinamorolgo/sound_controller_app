import 'package:flutter/services.dart';
import 'volume_service.dart';

class MobileVolumeService implements VolumeService {
  static const _channel = MethodChannel('com.example.soundcontroller/volume');
  double _initialVolumeFraction = 1.0;

  @override
  Future<void> adjustVolume(double volumeFraction) async {
    try {
      await _channel
          .invokeMethod('adjustVolume', {'volumeFraction': volumeFraction});
    } on PlatformException catch (e) {
      print('Failed to adjust volume: ${e.message}');
    }
  }

  @override
  Future<void> stopMusic() async {
    // 모바일 플랫폼에서 실행할 수 있는 로직
  }

  @override
  Future<void> resetVolume() async {
    await adjustVolume(_initialVolumeFraction);
  }
}

VolumeService getVolumeService() => MobileVolumeService();
