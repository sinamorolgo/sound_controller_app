// android/app/src/main/kotlin/com/example/sound_controller_app/MainActivity.kt

package com.example.sound_controller_app

import android.content.Context
import android.media.AudioManager
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlin.math.max

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example.soundcontroller/volume"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
            call, result ->
            when (call.method) {
                "adjustVolume" -> {
                    val volumeFraction = call.argument<Double>("volumeFraction") ?: 1.0
                    adjustVolume(volumeFraction)
                    result.success(null)
                }
                "stopMusic" -> {
                    stopMusic()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }

    private fun adjustVolume(volumeFraction: Double) {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        val maxVolume = audioManager.getStreamMaxVolume(AudioManager.STREAM_MUSIC)
        val newVolume = max((maxVolume * volumeFraction).toInt(), 1)
        audioManager.setStreamVolume(AudioManager.STREAM_MUSIC, newVolume, 0)
    }

    private fun stopMusic() {
        val audioManager = getSystemService(Context.AUDIO_SERVICE) as AudioManager
        audioManager.requestAudioFocus(null, AudioManager.STREAM_MUSIC, AudioManager.AUDIOFOCUS_GAIN_TRANSIENT)
    }
}
