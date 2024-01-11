import 'package:bit_im/message/message.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoController extends GetxController {
  late VideoPlayerController videoPlayerController;
  final Message message;
  late RxDouble w = RxDouble(message.messageVideo!.width);
  late RxDouble h = RxDouble(message.messageVideo!.height);
  late RxBool isInited = RxBool(false);
  late RxBool isPlay = RxBool(false);
  late RxDouble playCircleOpacity = RxDouble(1);
  VideoController({required this.message});
  @override
  void onInit() {
    super.onInit();
    initVideoPlayer();
  }

  void initVideoPlayer() {
    videoPlayerController =
        VideoPlayerController.networkUrl(Uri.parse(message.messageVideo!.url))
          ..initialize().then((_) {
            if (videoPlayerController.value.isInitialized) {
              isInited.value = true;
              w.value = videoPlayerController.value.size.width;
              h.value = videoPlayerController.value.size.height;
              //videoPlayerController.play();
            }
          });
  }

  void play() {
    if (!isPlay.value) {
      videoPlayerController.play();
      isPlay.value = true;
      playCircleOpacity.value = 0;
    } else {
      videoPlayerController.pause();
      isPlay.value = false;
      playCircleOpacity.value = 1;
    }
  }

  @override
  void dispose() {
    super.dispose();
    videoPlayerController.dispose();
  }
}
