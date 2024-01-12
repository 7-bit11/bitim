import 'package:bit_im/message/message.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
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
  final List<Message> messages;
  VideoController({required this.message, required this.messages});
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
    videoPlayerController.addListener(() {});
  }

  void play() {
    if (!isPlay.value) {
      for (var element in messages) {
        if (element.contentType == MessageContentType.video) {
          if (message.messageVideo!.url != element.messageVideo!.url) {
            VideoController videoController =
                Get.find<VideoController>(tag: element.messageVideo!.url);
            videoController.isPlay.value = false;
            videoController.playCircleOpacity.value = 1;
          }
        }
      }
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
