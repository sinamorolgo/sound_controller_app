import 'volume_service.dart';

class WebVolumeService implements VolumeService {
  @override
  Future<void> adjustVolume(double volumeFraction) async {
    print('웹에서는 볼륨 조절이 지원되지 않습니다.');
  }

  @override
  Future<void> stopMusic() async {
    print('웹에서는 음악을 중지하는 기능이 지원되지 않습니다.');
  }

  @override
  Future<void> resetVolume() async {}
}

VolumeService getVolumeService() => WebVolumeService();
