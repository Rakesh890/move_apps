import 'package:video_player/video_player.dart';

class VideoControllerSingleton {
  static VideoControllerSingleton? _instance;

  late VideoPlayerController _controller;

  VideoControllerSingleton._();

  static VideoControllerSingleton get instance {
    assert(_instance != null,
    'VideoControllerSingleton.instance has not been initialized. Call VideoControllerSingleton.initialize(videoUrl) first.');

    return _instance!;
  }

  static VideoPlayerController initialize(String videoUrl) {
    _instance ??= VideoControllerSingleton._();
    _instance!._controller = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
    // Optional: Add listeners, configure settings, etc.
    return _instance!._controller;
  }

  static playVideo(){
    _instance?._controller.play();
  }

  static pauseVideo(){
    _instance?._controller.pause();
  }

  void dispose() {
    _controller.dispose();
    _instance = null;
  }
}
