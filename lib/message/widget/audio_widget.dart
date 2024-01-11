import 'package:animate_do/animate_do.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:bit_im/message/message.dart';
import 'package:bit_im/message/role_enum.dart';
import 'package:bit_im/message/widget/audio_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class AudioMessageWidget extends GetView<AudioController> {
  const AudioMessageWidget(
      {super.key,
      required this.roleEnum,
      required this.message,
      this.fixedWaveColor,
      this.liveWaveColor,
      this.seekLineColor,
      required this.messages});
  final RoleEnum roleEnum;
  final Color? fixedWaveColor;
  final Color? liveWaveColor;
  final Color? seekLineColor;
  final Message message;
  final List<Message> messages;

  @override
  String? get tag => message.messageAudio!.audioFileName;

  @override
  Widget build(BuildContext context) {
    Get.put(AudioController(message: message, messages: messages),
        tag: message.messageAudio!.audioFileName);
    return GestureDetector(
      onTap: () => controller.onPlay(),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          roleEnum == RoleEnum.i
              ? Obx(
                  () => !controller.isPlay.value
                      ? SvgPicture.asset(
                          'assets/images/Play_Circle.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Colors.white, BlendMode.srcIn),
                        )
                      : FadeIn(
                          child: SvgPicture.asset(
                            'assets/images/Pause_Circle.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.white, BlendMode.srcIn),
                          ),
                        ),
                )
              : const SizedBox(),
          roleEnum == RoleEnum.you ? getWaveform() : const SizedBox(),
          AudioFileWaveforms(
            size: ui.Size(MediaQuery.of(context).size.width * .33, 20),
            playerController: controller.controller,
            enableSeekGesture: false,
            waveformType: WaveformType.fitWidth,
            waveformData: controller.waveformData,
            playerWaveStyle: PlayerWaveStyle(
                fixedWaveColor: fixedWaveColor ?? Colors.white54,
                liveWaveColor: liveWaveColor ?? Colors.white,
                seekLineColor: seekLineColor ?? Colors.white,
                spacing: 5,
                scaleFactor: 35,
                waveCap: StrokeCap.round),
          ),
          const SizedBox(width: 5),
          roleEnum == RoleEnum.i ? getWaveform() : const SizedBox(),
          roleEnum == RoleEnum.you
              ? Obx(
                  () => !controller.isPlay.value
                      ? SvgPicture.asset(
                          'assets/images/Play_Circle.svg',
                          width: 24,
                          height: 24,
                          colorFilter: const ColorFilter.mode(
                              Colors.black, BlendMode.srcIn),
                        )
                      : FadeIn(
                          child: SvgPicture.asset(
                            'assets/images/Pause_Circle.svg',
                            width: 24,
                            height: 24,
                            colorFilter: const ColorFilter.mode(
                                Colors.black, BlendMode.srcIn),
                          ),
                        ),
                )
              : const SizedBox()
        ],
      ),
    );
  }

  Widget getWaveform() {
    return Obx(
      () => controller.duration.value.inSeconds <= 0
          ? SizedBox(
              width: 20,
              height: 20,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: seekLineColor,
              ))
          : Text('${controller.duration.value.inSeconds}’’',
              style: TextStyle(color: seekLineColor, fontSize: 16)),
    );
  }
}
