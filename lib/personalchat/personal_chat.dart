// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bit_im/message/message.dart' as message;
import 'package:bit_im/message/message_audio.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
import 'package:bit_im/message/message_video.dart';
import 'package:bit_im/message/message_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:bit_im/message/message_image.dart' as mimage;

class PersonalChatPage extends StatefulWidget {
  const PersonalChatPage({super.key, required this.name});
  final String name;
  @override
  State<PersonalChatPage> createState() => _PersonalChatPageState();
}

class _PersonalChatPageState extends State<PersonalChatPage> {
  //waveform
  //final progressStream = BehaviorSubject<WaveformProgress>();
  @override
  void initState() {
    super.initState();
    initData();
    // initAudio();
    initDataFile();
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (height > 0) {
          setState(() => height = 0);
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  initDataFile() async {}

  // messages
  List<message.Message> messages = [];
  late double height = 0;
  late FocusNode focusNode;
  //加载数据
  void initData() async {
    final audioFile =
        File(p.join((await getTemporaryDirectory()).path, 'xxx.mp3'));
    final audioFile1 =
        File(p.join((await getTemporaryDirectory()).path, 'eva.mp3'));
    final audioFile2 =
        File(p.join((await getTemporaryDirectory()).path, 'qimeide.mp3'));
    messages = [
      message.Message(
        message: '你好',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
        messageId: '1001',
      ),
      message.Message(
        message: '您有啥事吗？',
        time: '2021-01-01 12:00:00',
        senderId: '1001',
        receiverId: '1002',
        contentType: MessageContentType.text,
        messageId: '1002',
      ),
      message.Message(
        message: '我看了您写的IM程序,希望能和您有合作的机会',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
        messageId: '1003',
      ),
      message.Message(
        message: '我发的这个动物是啥？',
        time: '2021-01-01 12:00:00',
        senderId: '1001',
        receiverId: '1002',
        contentType: MessageContentType.text,
        messageId: '1004',
      ),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/snow_leopard_snow_hunting_57947_1280x720.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          contentType: MessageContentType.image,
          messageId: '1005',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/snow_leopard_snow_hunting_57947_1280x720.jpg',
              width: 1280,
              height: 720)),
      message.Message(
        message: '芝士雪豹',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
        messageId: '1006',
      ),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/girl_anime_food_671_1280x720.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.image,
          messageId: '1007',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/girl_anime_food_671_1280x720.jpg',
              width: 1280,
              height: 720)),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/girl_glasses_heart_1141129_1280x720.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.image,
          messageId: '1008',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/girl_glasses_heart_1141129_1280x720.jpg',
              width: 1280,
              height: 720)),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/boat_mountains_lake_135258_1280x720.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.image,
          messageId: '1009',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/boat_mountains_lake_135258_1280x720.jpg',
              width: 1280,
              height: 720)),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/girl_schoolgirl_street_1139289_2160x3840.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          contentType: MessageContentType.image,
          messageId: '1010',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/girl_schoolgirl_street_1139289_2160x3840.jpg',
              width: 2160,
              height: 3840)),
      message.Message(
          message:
              'https://images.wallpaperscraft.com/image/single/girl_ears_cape_1036660_2160x3840.jpg',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.image,
          messageId: '1011',
          imageInfo: mimage.ImageInfo(
              url:
                  'https://images.wallpaperscraft.com/image/single/girl_ears_cape_1036660_2160x3840.jpg',
              width: 2160,
              height: 3840)),
      message.Message(
          message: 'audio',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          contentType: MessageContentType.audio,
          messageId: '1012',
          messageAudio: MessageAudio(
              audioFilePath: audioFile.path, audioFileName: 'xxx')),
      message.Message(
          message: '我实现了语音单独播放',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          messageId: '1013',
          contentType: MessageContentType.text),
      message.Message(
          message: 'audio',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.audio,
          messageId: '1014',
          messageAudio: MessageAudio(
              audioFilePath: audioFile1.path, audioFileName: 'eva')),
      message.Message(
          message: '残酷な天使のてーぜ',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          messageId: '1015',
          contentType: MessageContentType.text),
      message.Message(
          message: '凄美的',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          messageId: '1016',
          contentType: MessageContentType.text),
      message.Message(
          message: 'audio',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          messageId: '1017',
          contentType: MessageContentType.audio,
          messageAudio: MessageAudio(
              audioFilePath: audioFile2.path, audioFileName: 'qimeide')),
      message.Message(
          message: 'audio',
          time: '2021-01-01 12:00:00',
          senderId: '1002',
          receiverId: '1001',
          contentType: MessageContentType.video,
          messageId: '1018',
          messageVideo: MessageVideo(
              url: 'https://media.w3.org/2010/05/sintel/trailer.mp4', //'',
              height: 1080,
              width: 1920)),
      message.Message(
          message: 'audio',
          time: '2021-01-01 12:00:00',
          senderId: '1001',
          receiverId: '1002',
          contentType: MessageContentType.video,
          messageId: '1019',
          messageVideo: MessageVideo(
              url: 'https://www.w3school.com.cn/i/movie.mp4',
              height: 1080,
              width: 1920)),
    ];
    //messages.add(await initAudio());
    messages = messages.reversed.toList();
    setState(() {});
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: CupertinoNavigationBar(
          middle: Text(widget.name),
          trailing: SvgPicture.asset('assets/images/more_vert.svg')),
      body: Column(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
              child: ListView.builder(
                shrinkWrap: true,
                reverse: true,
                itemBuilder: (BuildContext context, int index) {
                  return MessageWidget(
                      message: messages[index], messages: messages);
                },
                itemCount: messages.length,
              ),
            ),
          ),
          Container(
            color: const Color(0xffF7F7F7),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(children: [
              IconButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  icon: SvgPicture.asset(
                    'assets/images/Icon.svg',
                    width: 24,
                    height: 24,
                    colorFilter:
                        const ColorFilter.mode(Colors.black54, BlendMode.srcIn),
                  ),
                  onPressed: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                    setState(() => height == 0
                        ? height = MediaQuery.of(context).size.height * .3
                        : height = 0);
                  }),
              const SizedBox(width: 10),
              Expanded(
                  child: TextField(
                focusNode: focusNode,
                controller: textEditingController,
                style: const TextStyle(color: Colors.black),
                cursorColor: const Color(0xff002DE3),
                decoration: const InputDecoration(
                  prefixIconConstraints: BoxConstraints(
                      maxHeight: 24, minHeight: 24, maxWidth: 40, minWidth: 40),
                  suffixIconConstraints: BoxConstraints(
                      maxHeight: 38, minHeight: 38, minWidth: 100),
                  isCollapsed: true,
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(borderSide: BorderSide.none),
                  hintStyle: TextStyle(color: Colors.black),
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                  enabledBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                  focusedBorder:
                      OutlineInputBorder(borderSide: BorderSide.none),
                ),
              )),
              const SizedBox(width: 15),
              IconButton(
                  style: const ButtonStyle(
                      overlayColor:
                          MaterialStatePropertyAll(Colors.transparent)),
                  onPressed: () {
                    if (textEditingController.value.text.isEmpty) return;
                    messages.insert(
                        0,
                        message.Message(
                          message: textEditingController.value.text,
                          time: '2021-01-01 12:00:00',
                          senderId: '1001',
                          receiverId: '1002',
                          contentType: MessageContentType.text,
                          messageId: '',
                        ));
                    textEditingController.clear();
                    setState(() {});
                  },
                  icon: SvgPicture.asset('assets/images/send.svg',
                      width: 24, height: 24)),
              const SizedBox(width: 5),
            ]),
          ),
          AnimatedContainer(
              padding: const EdgeInsets.all(10),
              duration: const Duration(milliseconds: 300),
              curve: Curves.linearToEaseOut,
              height: height,
              color: const Color(0xffF7F7F7),
              child: GridView(
                  padding: const EdgeInsets.symmetric(vertical: 30),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4),
                  children: [
                    Column(children: [
                      SvgPicture.asset('assets/images/Image_01.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('相册',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                    Column(children: [
                      SvgPicture.asset('assets/images/Folder.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('文件夹',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                    Column(children: [
                      SvgPicture.asset('assets/images/Image_01.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('相册',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                    Column(children: [
                      SvgPicture.asset('assets/images/Folder.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('文件夹',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                    Column(children: [
                      SvgPicture.asset('assets/images/Image_01.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('相册',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                    Column(children: [
                      SvgPicture.asset('assets/images/Folder.svg',
                          colorFilter: const ColorFilter.mode(
                              Colors.black54, BlendMode.srcIn),
                          width: 26,
                          height: 26),
                      const SizedBox(height: 5),
                      const Text('文件夹',
                          style: TextStyle(color: Colors.grey, fontSize: 14))
                    ]),
                  ]))
        ],
      ),
    );
  }
}
