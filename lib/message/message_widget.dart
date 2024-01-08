import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bit_im/message/message.dart';
import 'package:bit_im/message/message_audio_widget.dart';
import 'package:bit_im/message/message_content_type.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:shimmer/shimmer.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:ui' as ui;

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  final progressStream = BehaviorSubject<WaveformProgress>();
  @override
  void initState() {
    initAudio();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  late List<double> waveformData = [];
  Duration duration = const Duration();
  initAudio() async {
    if (widget.message.contentType == MessageContentType.audio) {
      waveformData = await controller.extractWaveformData(
        path: widget.message.messageAudio!.audioFile.path,
        noOfSamples: 100,
      );
      await controller.preparePlayer(
        path: widget.message.messageAudio!.audioFile.path,
        shouldExtractWaveform: true,
        noOfSamples: 20,
        volume: 1.0,
      );
      //播放完成监听
      controller.onCompletion.listen((_) async {
        print('123123123123123123');
        bool bool1 = await controller.setVolume(0.0);
        print(bool1);
        //controller.pausePlayer(); // Pause audio player
        setState(() {});
        //controller.setRefresh(true);
      });
      final duration1 = await controller.getDuration(DurationType.max);
      duration = Duration(milliseconds: duration1);
      setState(() {});
      // await controller.record(
      //     path: widget.message.messageAudio!.audioFile.path);
      // final hasPermission = await controller.checkPermission();
      // print(
      //     '==============================initAudio==================================');
      // JustWaveform.extract(
      //         audioInFile: widget.message.messageAudio!.audioFile,
      //         waveOutFile: widget.message.messageAudio!.waveFile)
      //     .listen(progressStream.add, onError: progressStream.addError);
    }
  }

  late Widget mseeageContent;
  late String url;
  late String id;
  late bool isPlay = false;
  PlayerController controller = PlayerController(); // Initialise

  // Record (path is optional)
// final hasPermission = await controller.checkPermission();  // Check mic permission (also called during record)
// await controller.pause();                                  // Pause recording
// final path = await controller.stop();                      // Stop recording and get the path
// controller.refresh();                                      // Refresh waveform to original position
// controller.dispose();                                      // Dispose controller

  //模拟查询用户信息
  initData() {
    //根据用户id查询用户信息 1001默认为用户自己本地存储的用户id
    if (widget.message.senderId == '1001') {
      id = '1001';
      url =
          'https://upload.jianshu.io/users/upload_avatars/26977695/60eaf225-00fe-4028-95bd-1652cd174ee6.jpg';
    } else if (widget.message.senderId == '1002') {
      id = '1002';
      url =
          'https://upload.jianshu.io/users/upload_avatars/7705786/a90dc05d-63f6-4690-8c1a-dcf7ff4422df.jpg';
    }
  }

  void buildMessageContent() async {
    switch (widget.message.contentType) {
      case MessageContentType.text:
        mseeageContent = Text(widget.message.message);
      case MessageContentType.image:
        mseeageContent = ConstrainedBox(
            constraints: BoxConstraints(
                minWidth: MediaQuery.of(context).size.width * .3,
                maxWidth: MediaQuery.of(context).size.width * .7,
                minHeight: MediaQuery.of(context).size.height * .1,
                maxHeight: MediaQuery.of(context).size.height * .4),
            child: AspectRatio(
                aspectRatio: widget.message.imageInfo!.width /
                    widget.message.imageInfo!.height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: CachedNetworkImage(
                      imageUrl: widget.message.imageInfo!.url,
                      fit: BoxFit.cover,
                      placeholder: (context, url) {
                        return SizedBox(
                          width: double.infinity,
                          height: MediaQuery.of(context).size.height * .1,
                          child: Shimmer.fromColors(
                            baseColor: const Color.fromARGB(255, 245, 245, 245),
                            highlightColor: Colors.white,
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8)),
                            ),
                          ),
                        );
                      }),
                )));
      case MessageContentType.audio:
        mseeageContent = GestureDetector(
          onTap: () {
            isPlay = !isPlay;
            if (isPlay) {
              controller.startPlayer();
            } else {
              controller.pausePlayer();
            }
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              AudioFileWaveforms(
                size: Size(MediaQuery.of(context).size.width * .3, 30),
                playerController: controller,
                enableSeekGesture: false,
                waveformType: WaveformType.long,
                waveformData: waveformData,
                playerWaveStyle: const PlayerWaveStyle(
                    fixedWaveColor: Colors.white54,
                    liveWaveColor: Colors.white,
                    spacing: 5,
                    scaleFactor: 50,
                    waveCap: StrokeCap.round),
              ),
              const SizedBox(width: 5),
              duration.inSeconds <= 0
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ))
                  : Text('${duration.inSeconds}’’',
                      style: const TextStyle(color: Colors.white, fontSize: 16))
            ],
          ),
        );
      default:
        mseeageContent = Text(widget.message.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    initData();
    buildMessageContent();
    //假如是自己发送的消息
    return id == '1001' ? buildRightMessage() : buildLeftMessage();
  }

  // 右边消息
  buildRightMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7),
              padding: widget.message.contentType == MessageContentType.image
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xff0099FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  child: mseeageContent)),
          const SizedBox(width: 10),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  //左边消息
  buildLeftMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7),
              padding: widget.message.contentType == MessageContentType.image
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 48, 31, 31), fontSize: 15),
                  child: mseeageContent)),
        ],
      ),
    );
  }
}
