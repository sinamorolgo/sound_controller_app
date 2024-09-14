import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  private let channelName = "com.example.soundcontroller/volume"

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let volumeChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
    
    volumeChannel.setMethodCallHandler { [weak self] (call, result) in
      switch call.method {
      case "adjustVolume":
        // Not permitted on iOS
        print("Volume adjustment not supported on iOS.")
        result(FlutterMethodNotImplemented)
      case "stopMusic":
        self?.stopMusic()
        result(nil)
      default:
        result(FlutterMethodNotImplemented)
      }
    }

    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
  private func stopMusic() {
    // Attempt to stop music playback using MPRemoteCommandCenter
    let commandCenter = MPRemoteCommandCenter.shared()
    commandCenter.pauseCommand.addTarget { event in
        return .success
    }
  }
}
