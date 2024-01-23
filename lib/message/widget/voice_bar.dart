import 'dart:io';

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class VoiceBar extends StatefulWidget {
  const VoiceBar({
    super.key,
    required this.onRecorderEnd,
  });

  @override
  State<VoiceBar> createState() => _VoiceBarState();

  final Function(String path, int duration, String fileName)? onRecorderEnd;
}

class _VoiceBarState extends State<VoiceBar> {
  /// 遮罩层
  OverlayEntry? _overlayEntry;

  /// 手势
  late ValueNotifier<bool> _onLongPressSubject;
  late ValueNotifier<Offset?> _longPressMoveOffsetSubject;

  /// 录音
  late RecorderController _recorderController;

  /// 权限
  bool _hasPermission = false;

  final GlobalKey _keyOfSendArea = GlobalKey();

  @override
  void initState() {
    _onLongPressSubject = ValueNotifier<bool>(false);
    _longPressMoveOffsetSubject = ValueNotifier<Offset?>(null);
    _recorderController = RecorderController();

    super.initState();
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    _overlayEntry?.dispose();
    _overlayEntry = null;
    _onLongPressSubject.dispose();
    _longPressMoveOffsetSubject.dispose();
    _recorderController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onLongPressDown: (details) {
        if (!_hasPermission) {
          _getPermission();
        }
      },
      onLongPressStart: (details) async {
        HapticFeedback.mediumImpact();
        if (_hasPermission) {
          _startRecorder(
            details: details,
          );
        }
      },
      onLongPressEnd: (details) {
        _stopRecorder(
          details: details,
        );
      },
      onLongPressMoveUpdate: (details) {
        var longPressOffset = details.globalPosition;
        _longPressMoveOffsetSubject.value = longPressOffset;
      },
      child: SizedBox(
        height: 48,
        child: Center(
          child: ValueListenableBuilder<bool>(
            valueListenable: _onLongPressSubject,
            builder: (_, onLongPress, child) {
              return ValueListenableBuilder<Offset?>(
                valueListenable: _longPressMoveOffsetSubject,
                builder: (_, moveOffset, child) {
                  bool inCancel = false;
                  if (moveOffset != null) {
                    var move = moveOffset;
                    var box = _keyOfSendArea.currentContext?.findRenderObject();
                    if (box != null && (box is RenderBox) && box.hasSize) {
                      var local = box.globalToLocal(move);
                      if (box.hitTest(BoxHitTestResult(), position: local)) {
                        inCancel = false;
                      } else {
                        inCancel = true;
                      }
                    }
                  }
                  return Text(
                    onLongPress == true
                        ? (inCancel ? '松开  取消' : '松开  发送')
                        : '按住说话',
                    style: const TextStyle(
                      color: Color(0xFF333333),
                      fontSize: 15.0,
                      fontWeight: FontWeight.normal,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  void _startRecorder({
    required LongPressStartDetails details,
  }) async {
    // final session = await AudioSession.instance;
    // await session.configure(AudioSessionConfiguration(
    //   avAudioSessionCategory: AVAudioSessionCategory.playAndRecord,
    //   avAudioSessionCategoryOptions:
    //       AVAudioSessionCategoryOptions.allowBluetooth |
    //           AVAudioSessionCategoryOptions.defaultToSpeaker,
    //   avAudioSessionMode: AVAudioSessionMode.spokenAudio,
    //   avAudioSessionRouteSharingPolicy:
    //       AVAudioSessionRouteSharingPolicy.defaultPolicy,
    //   avAudioSessionSetActiveOptions: AVAudioSessionSetActiveOptions.none,
    //   androidAudioAttributes: const AndroidAudioAttributes(
    //     contentType: AndroidAudioContentType.speech,
    //     flags: AndroidAudioFlags.none,
    //     usage: AndroidAudioUsage.voiceCommunication,
    //   ),
    //   androidAudioFocusGainType: AndroidAudioFocusGainType.gain,
    //   androidWillPauseWhenDucked: true,
    // ));
    try {
      var tempDir = await getTemporaryDirectory();
      String voiceDir = p.join(tempDir.path, "voices");
      if (!(await Directory(voiceDir).exists())) {
        await Directory(voiceDir).create(recursive: true);
      }
      String name = DateTime.now().millisecondsSinceEpoch.toString();
      String fileName = "$name.mp3";
      String filePath = p.join(voiceDir, fileName);
      await _recorderController.record(
        path: filePath,
        sampleRate: 44100,
        bitRate: 48000,
      );
      _onLongPressSubject.value = true;

      ///显示录音悬浮布局
      // ignore: use_build_context_synchronously
      _buildOverLayView(context);
    } catch (err) {
      debugPrint('startRecorder error: ${err.toString()}');
      _stopRecorder(
        details: LongPressEndDetails(globalPosition: details.globalPosition),
      );
    }
  }

  Future<void> _stopRecorder({required LongPressEndDetails details}) async {
    _onLongPressSubject.value = false;
    try {
      var path = await _recorderController.stop();
      var move = _longPressMoveOffsetSubject.value ?? Offset.zero;
      var box = _keyOfSendArea.currentContext?.findRenderObject();
      if (box != null && (box is RenderBox)) {
        var local = box.globalToLocal(move);
        if (box.hitTest(BoxHitTestResult(), position: local)) {
          if ((_recorderController.recordedDuration.inSeconds) > 0) {
            String name = path!
                .substring(path.lastIndexOf('/') + 1, path.lastIndexOf('.'));
            widget.onRecorderEnd?.call(
                path, _recorderController.recordedDuration.inSeconds, name);
          }
        }
      }
    } on Exception catch (err) {
      debugPrint('stopRecorder error: $err');
    }
    _hideVoiceView();
  }

  void _getPermission() async {
    _hasPermission = await _recorderController.checkPermission();
  }

  ///显示录音悬浮布局
  _buildOverLayView(BuildContext context) {
    if (_overlayEntry == null) {
      const Color color = Color.fromARGB(150, 255, 255, 255);

      _overlayEntry = OverlayEntry(
        builder: (context) {
          return Material(
            type: MaterialType.canvas,
            color: const Color(0x99000000),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                StreamBuilder<Duration>(
                  stream: _recorderController.onCurrentDuration,
                  builder: (_, snapshotDuration) {
                    double extended = ((snapshotDuration.data?.inSeconds ?? 0) >
                            60)
                        ? 40.0
                        : ((snapshotDuration.data?.inSeconds ?? 0).toDouble() /
                            60.0 *
                            40.0);
                    int length = 24;
                    var waveData = _recorderController.waveData.toList();
                    waveData.insertAll(0, List.generate(length, (index) => 0));
                    List<double> amplitudes =
                        waveData.skip(waveData.length - length).toList();

                    //上方的盒子
                    return Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 50.0 + extended,
                        vertical: 25.0,
                      ),
                      decoration: const BoxDecoration(
                        color: color,
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                      ),
                      child: SizedBox(
                        height: 40.0,
                        child: ListView.separated(
                          padding: EdgeInsets.zero,
                          scrollDirection: Axis.horizontal,
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            var amplitude = amplitudes[index];
                            return Center(
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 100),
                                width: 2.0,
                                height: 16.0 +
                                    (amplitude *
                                            ((amplitude <= 0.08 &&
                                                    amplitude >= 0.04)
                                                ? 3
                                                : 1)) *
                                        32.0,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFFFFFF),
                                  borderRadius: BorderRadius.circular(3.0),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return const SizedBox(
                              width: 2.0,
                            );
                          },
                          itemCount: length,
                        ),
                      ),
                    );
                    // return AudioWaveforms(
                    //   size: Size(80.0 + extended, 40.0),
                    //   decoration: const BoxDecoration(
                    //     color: Color(0xDDFD5DA5),
                    //     borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    //   ),
                    //   padding: const EdgeInsets.symmetric(
                    //     horizontal: 70.0,
                    //     vertical: 25.0,
                    //   ),
                    //   recorderController: _recorderController!,
                    //   enableGesture: false,
                    //   shouldCalculateScrolledPosition: true,
                    //   waveStyle: const WaveStyle(
                    //     waveColor: Color(0xFFFFFFFF),
                    //     showDurationLabel: false,
                    //     spacing: 6.0,
                    //     waveThickness: 3.0,
                    //     showTop: true,
                    //     showBottom: true,
                    //     extendWaveform: true,
                    //     showMiddleLine: false,
                    //   ),
                    // );
                  },
                ),
                Container(
                  width: 0,
                  height: 0,
                  margin: const EdgeInsets.only(top: 12.0),
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: color,
                        width: 12,
                        style: BorderStyle.solid,
                      ),
                      right: BorderSide(
                        color: Colors.transparent,
                        width: 12,
                        style: BorderStyle.solid,
                      ),
                      left: BorderSide(
                        color: Colors.transparent,
                        width: 12,
                        style: BorderStyle.solid,
                      ),
                      top: BorderSide(
                        color: Colors.transparent,
                        width: 12,
                        style: BorderStyle.solid,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30.0),
                ValueListenableBuilder<Offset?>(
                  valueListenable: _longPressMoveOffsetSubject,
                  builder: (_, moveOffset, child) {
                    bool inCancel = false;
                    if (moveOffset != null) {
                      var move = moveOffset;
                      var box =
                          _keyOfSendArea.currentContext?.findRenderObject();
                      if (box != null && (box is RenderBox)) {
                        var local = box.globalToLocal(move);
                        if (box.hitTest(BoxHitTestResult(), position: local)) {
                          inCancel = false;
                        } else {
                          inCancel = true;
                        }
                      }
                    }

                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 30.0,
                          child: inCancel
                              ? const Text(
                                  '松开  取消',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                )
                              : const SizedBox.shrink(),
                        ),
                        SizedBox(
                          width: 60.0,
                          height: 60.0,
                          child: Center(
                            child: Icon(
                              Icons.remove_circle_rounded,
                              color: inCancel
                                  ? const Color(0x88FFFFFF)
                                  : const Color(0x33000000),
                              size: inCancel ? 60.0 : 40.0,
                            ),
                          ),
                        ),

                        const SizedBox(height: 30.0),
                        SizedBox(
                          width: double.infinity,
                          height: 30.0,
                          child: inCancel
                              ? const SizedBox.shrink()
                              : const Text(
                                  '松开  发送',
                                  style: TextStyle(
                                    color: Color(0xFFFFFFFF),
                                    fontSize: 15.0,
                                    fontWeight: FontWeight.normal,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                        ),

                        /// 语音发送区域
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          width: MediaQuery.sizeOf(context).width,
                          height: 148.0,
                          padding: EdgeInsets.only(top: inCancel ? 20.0 : 0),
                          child: FittedBox(
                            fit: BoxFit.none,
                            alignment: Alignment.topCenter,
                            clipBehavior: Clip.hardEdge,
                            child: Container(
                              key: _keyOfSendArea,
                              width: 1080.0,
                              height: 1080.0,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(1080.0),
                                border: Border.all(
                                  color: inCancel
                                      ? Colors.transparent
                                      : const Color(0x44FFFFFF),
                                  width: 4.0,
                                ),
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: inCancel
                                      ? [
                                          const Color(0x60888888),
                                          const Color(0x60888888),
                                        ]
                                      : [
                                          const Color(0x60999999),
                                          const Color(0x60FFFFFF),
                                        ],
                                ),
                              ),
                              child: const Align(
                                alignment: Alignment.topCenter,
                                child: SizedBox(
                                  height: 148.0,
                                  child: Icon(
                                    Icons.multitrack_audio_rounded,
                                    size: 24.0,
                                    color: Color(0xFF333333),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      );
      Overlay.of(context).insert(_overlayEntry!);
    }
  }

  _hideVoiceView() async {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry?.dispose();
      _overlayEntry = null;
    }
  }
}
