abstract class VolumeService {
  Future<void> adjustVolume(double volumeFraction);
  Future<void> stopMusic();
  Future<void> resetVolume();
}
