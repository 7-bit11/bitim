// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bit_im/message/message.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart' as gett;
import 'package:get/get.dart';
import 'package:just_waveform/just_waveform.dart';
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:path/path.dart' as p;

class AudioController extends gett.GetxController {
  AudioController({required this.message, required this.messages});
  final Message message;
  final List<Message> messages;
  final progressStream = BehaviorSubject<WaveformProgress>();
  PlayerController controller = PlayerController();
  gett.Rx<Duration> duration = gett.Rx(const Duration());
  late RxBool isPlay = RxBool(false);
  late List<double> waveformData = [];

  void onPlay() async {
    isPlay.value = !isPlay.value;
    if (isPlay.value) {
      for (var element in messages) {
        if (element.contentType == MessageContentType.audio) {
          if (message.messageAudio!.audioFileName !=
              element.messageAudio!.audioFileName) {
            AudioController audioControllers = Get.find<AudioController>(
                tag: element.messageAudio!.audioFileName);
            audioControllers.isPlay.value = false;
            await audioControllers.controller.pausePlayer();
          }
        }
      }
      controller.startPlayer();
      // await Future.delayed(const Duration(seconds: 5), () async {
      //   await controller.seekTo(1);
      // });
    } else {
      controller.pausePlayer();
    }
  }

  @override
  void onInit() {
    super.onInit();
    initAudio();
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  initAudio() async {
    //创建音频文件
    final audioFile = File(p.join((await getTemporaryDirectory()).path,
        '${message.messageAudio!.audioFileName}.mp3'));

    //是否存在
    // if (await audioFile.exists()) {
    await audioFile.writeAsBytes((await rootBundle
            .load('assets/audios/${message.messageAudio!.audioFileName}.mp3'))
        .buffer
        .asUint8List());
    waveformData = await controller.extractWaveformData(
      path: message.messageAudio!.audioFilePath,
      noOfSamples: 25,
    );

    await controller.preparePlayer(
      path: message.messageAudio!.audioFilePath,
      shouldExtractWaveform: true,
      noOfSamples: 25,
      volume: 1,
    );
    controller.onExtractionProgress.listen((progress) async {
      debugPrint("当前的音频加载进度是：=======  $progress");
      final duration1 = await controller.getDuration(DurationType.max);
      duration.value = Duration(milliseconds: duration1);
    });
    controller.onCurrentDurationChanged.listen((duration) async {
      debugPrint("当前音频播放的进度ms：=======  $duration");
      if (((this.duration.value.inSeconds * 1000) - 300) < duration) {
        await controller.seekTo(0);
        isPlay.value = false;
        await controller.pausePlayer();
      }
    });
  }
}
