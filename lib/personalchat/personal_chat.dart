// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:bit_im/chats/chats_model.dart';
import 'package:bit_im/frame/data_base.dart';
import 'package:bit_im/message/message.dart' as message;
import 'package:bit_im/message/message_audio.dart' as audio;
import 'package:bit_im/message/message_audio.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
import 'package:bit_im/message/message_video.dart';
import 'package:bit_im/message/message_widget.dart';
import 'package:bit_im/message/widget/voice_bar.dart';
import 'package:bit_im/user/user.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:bit_im/message/message_image.dart' as mimage;
import 'package:sqflite/sqflite.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';

class PersonalChatPage extends StatefulWidget {
  const PersonalChatPage({super.key, required this.chatsModel});
  final ChatsModel chatsModel;
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
    focusNode = FocusNode();
    focusNode.addListener(() {
      if (focusNode.hasFocus) {
        if (height > 0) {
          height = 0;
          if (mounted) {
            setState(() {});
          }
        }
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  void getLostData() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      final size = ImageSizeGetter.getSize(FileInput(File(image.path)));
      String id = const Uuid().v4();
      message.Message mesg = message.Message(
          message: image.path,
          time: DateTime.now().toString(),
          senderId: '1001',
          receiverId: widget.chatsModel.id.toString(),
          contentType: MessageContentType.localImage,
          messageId: const Uuid().v1(),
          imageInfoId: id,
          imageInfo: mimage.ImageInfo(
              url: image.path,
              width: size.width.toDouble(),
              height: size.height.toDouble()));
      messages.insert(0, mesg);
      Database database = await BitDataBase.database;

      await database.insert(
          BitDataBase.DATA_TABLENAME_MESSAGEIMAGE,
          {
            'id': mesg.imageInfoId,
            'url': mesg.message,
            'width': mesg.imageInfo!.width,
            'height': mesg.imageInfo!.height
          },
          conflictAlgorithm: ConflictAlgorithm.replace);

      await database.insert(
          BitDataBase.DATA_TABLENAME_MESSAGE,
          {
            'messageId': mesg.messageId,
            'contentType': mesg.contentType.type,
            'time': mesg.time,
            'senderId': mesg.senderId,
            'receiverId': mesg.receiverId,
            'message': mesg.message,
            'imageInfoId': mesg.imageInfoId
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      if (mounted) {
        setState(() {});
      }
    }
  }

  // messages
  List<message.Message> messages = [];
  late double height = 0;
  late FocusNode focusNode;
  late bool isAudio = false;
  //加载数据
  void initData() async {
    Database database = await BitDataBase.database;
    List<Map<String, Object?>> data = await database.query(
        BitDataBase.DATA_TABLENAME_MESSAGE,
        orderBy: 'time DESC',
        where:
            '(senderId=${widget.chatsModel.id} and receiverId=${UserInfo.USER_ID}) or (senderId=${UserInfo.USER_ID} and receiverId=${widget.chatsModel.id})');
    for (var element in data) {
      message.Message myMessage = message.Message.fromJson(element);
      switch (myMessage.contentType) {
        case MessageContentType.image || MessageContentType.localImage:
          List<Map<String, Object?>> imageData = await database.query(
              BitDataBase.DATA_TABLENAME_MESSAGEIMAGE,
              where: 'id=?',
              whereArgs: [myMessage.imageInfoId]);
          myMessage.imageInfo = mimage.ImageInfo.fromJson(imageData[0]);
          break;
        case MessageContentType.audio:
          List<Map<String, Object?>> audioData = await database.query(
              BitDataBase.DATA_TABLENAME_MESSAGEAUDIO,
              where: 'id=?',
              whereArgs: [myMessage.messageAudioId]);
          myMessage.messageAudio = audio.MessageAudio.fromJson(audioData[0]);
          break;
        case MessageContentType.video:
          List<Map<String, Object?>> videoData = await database.query(
              BitDataBase.DATA_TABLENAME_MESSAGEVIDEO,
              where: 'id=?',
              whereArgs: [myMessage.messageVideoId]);
          myMessage.messageVideo = MessageVideo.fromJson(videoData[0]);
          break;
        default:
          break;
      }
      messages.add(myMessage);
    }
    debugPrint("data$messages");
    // final audioFile =
    //     File(p.join((await getTemporaryDirectory()).path, 'xxx.mp3'));
    // final audioFile1 =
    //     File(p.join((await getTemporaryDirectory()).path, 'eva.mp3'));
    // final audioFile2 =
    //     File(p.join((await getTemporaryDirectory()).path, 'qimeide.mp3'));
    // messages = [
    //   message.Message(
    //     message: '你好',
    //     time: '2021-01-01 12:00:00',
    //     senderId: '1002',
    //     receiverId: '1001',
    //     contentType: MessageContentType.text,
    //     messageId: '1001',
    //   ),
    //   message.Message(
    //     message: '您有啥事吗？',
    //     time: '2021-01-01 12:00:00',
    //     senderId: '1001',
    //     receiverId: '1002',
    //     contentType: MessageContentType.text,
    //     messageId: '1002',
    //   ),
    //   message.Message(
    //     message: '我看了您写的IM程序,希望能和您有合作的机会',
    //     time: '2021-01-01 12:00:00',
    //     senderId: '1002',
    //     receiverId: '1001',
    //     contentType: MessageContentType.text,
    //     messageId: '1003',
    //   ),
    //   message.Message(
    //     message: '我发的这个动物是啥？',
    //     time: '2021-01-01 12:00:00',
    //     senderId: '1001',
    //     receiverId: '1002',
    //     contentType: MessageContentType.text,
    //     messageId: '1004',
    //   ),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/snow_leopard_snow_hunting_57947_1280x720.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       contentType: MessageContentType.image,
    //       messageId: '1005',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/snow_leopard_snow_hunting_57947_1280x720.jpg',
    //           width: 1280,
    //           height: 720)),
    //   message.Message(
    //     message: '芝士雪豹',
    //     time: '2021-01-01 12:00:00',
    //     senderId: '1002',
    //     receiverId: '1001',
    //     contentType: MessageContentType.text,
    //     messageId: '1006',
    //   ),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/girl_anime_food_671_1280x720.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.image,
    //       messageId: '1007',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/girl_anime_food_671_1280x720.jpg',
    //           width: 1280,
    //           height: 720)),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/girl_glasses_heart_1141129_1280x720.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.image,
    //       messageId: '1008',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/girl_glasses_heart_1141129_1280x720.jpg',
    //           width: 1280,
    //           height: 720)),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/boat_mountains_lake_135258_1280x720.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.image,
    //       messageId: '1009',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/boat_mountains_lake_135258_1280x720.jpg',
    //           width: 1280,
    //           height: 720)),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/girl_schoolgirl_street_1139289_2160x3840.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       contentType: MessageContentType.image,
    //       messageId: '1010',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/girl_schoolgirl_street_1139289_2160x3840.jpg',
    //           width: 2160,
    //           height: 3840)),
    //   message.Message(
    //       message:
    //           'https://images.wallpaperscraft.com/image/single/girl_ears_cape_1036660_2160x3840.jpg',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.image,
    //       messageId: '1011',
    //       imageInfo: mimage.ImageInfo(
    //           url:
    //               'https://images.wallpaperscraft.com/image/single/girl_ears_cape_1036660_2160x3840.jpg',
    //           width: 2160,
    //           height: 3840)),
    //   message.Message(
    //       message: 'audio',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       contentType: MessageContentType.audio,
    //       messageId: '1012',
    //       messageAudio: MessageAudio(
    //           audioFilePath: audioFile.path, audioFileName: 'xxx')),
    //   message.Message(
    //       message: '我实现了语音单独播放',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       messageId: '1013',
    //       contentType: MessageContentType.text),
    //   message.Message(
    //       message: 'audio',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.audio,
    //       messageId: '1014',
    //       messageAudio: MessageAudio(
    //           audioFilePath: audioFile1.path, audioFileName: 'eva')),
    //   message.Message(
    //       message: '残酷な天使のてーぜ',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       messageId: '1015',
    //       contentType: MessageContentType.text),
    //   message.Message(
    //       message: '凄美的',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       messageId: '1016',
    //       contentType: MessageContentType.text),
    //   message.Message(
    //       message: 'audio',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       messageId: '1017',
    //       contentType: MessageContentType.audio,
    //       messageAudio: MessageAudio(
    //           audioFilePath: audioFile2.path, audioFileName: 'qimeide')),
    //   message.Message(
    //       message: 'audio',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1002',
    //       receiverId: '1001',
    //       contentType: MessageContentType.video,
    //       messageId: '1018',
    //       messageVideo: MessageVideo(
    //           url: 'https://media.w3.org/2010/05/sintel/trailer.mp4', //'',
    //           height: 1080,
    //           width: 1920)),
    //   message.Message(
    //       message: 'audio',
    //       time: '2021-01-01 12:00:00',
    //       senderId: '1001',
    //       receiverId: '1002',
    //       contentType: MessageContentType.video,
    //       messageId: '1019',
    //       messageVideo: MessageVideo(
    //           url: 'https://www.w3school.com.cn/i/movie.mp4',
    //           height: 1080,
    //           width: 1920)),
    // ];
    // //messages.add(await initAudio());
    // messages = messages.reversed.toList();
    if (mounted) {
      setState(() {});
    }
  }

  TextEditingController textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF1F1F1),
      appBar: CupertinoNavigationBar(
          middle: Text(widget.chatsModel.name),
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
                      message: messages[index],
                      messages: messages,
                      chatsModel: widget.chatsModel);
                },
                itemCount: messages.length,
              ),
            ),
          ),
          Container(
            color: const Color(0xffF7F7F7),
            height: 50,
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: Row(children: [
              const SizedBox(width: 10),
              SizedBox(
                width: 40,
                child: IconButton(
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent)),
                    icon: SvgPicture.asset(
                      isAudio
                          ? 'assets/images/microphone.svg'
                          : 'assets/images/Edit_Pencil_Line.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          Colors.black54, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      isAudio = !isAudio;
                      if (!isAudio) {
                        if (height > 0) {
                          height = 0;
                        }
                      }
                      if (mounted) {
                        setState(() {});
                      }
                    }),
              ),
              const SizedBox(width: 10),
              Expanded(
                  child: !isAudio
                      ? FadeInUp(
                          duration: Durations.long1,
                          child: Container(
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    width: 1,
                                    color: Colors.grey.shade300,
                                    style: BorderStyle.solid)),
                            alignment: Alignment.center,
                            child: VoiceBar(
                              onRecorderEnd: (String path, int duration,
                                  String name) async {
                                debugPrint(
                                    "=======================================================");
                                debugPrint(path);
                                var audioId = const Uuid().v4();
                                Database database = await BitDataBase.database;
                                message.Message mesg = message.Message(
                                    message: name,
                                    time: DateTime.now().toString(),
                                    senderId: '1001',
                                    receiverId: widget.chatsModel.id.toString(),
                                    contentType: MessageContentType.audio,
                                    messageId: const Uuid().v1(),
                                    messageAudioId: audioId,
                                    messageAudio: MessageAudio(
                                        audioFilePath: path,
                                        audioFileName: name));
                                int audioOK = await database.insert(
                                    BitDataBase.DATA_TABLENAME_MESSAGEAUDIO,
                                    {
                                      'id': mesg.messageAudioId,
                                      'audioFilePath':
                                          mesg.messageAudio!.audioFilePath,
                                      'audioFileName':
                                          mesg.messageAudio!.audioFileName
                                    },
                                    conflictAlgorithm:
                                        ConflictAlgorithm.replace);
                                int messageOK = await database.insert(
                                    BitDataBase.DATA_TABLENAME_MESSAGE,
                                    {
                                      'messageId': mesg.messageId,
                                      'contentType': mesg.contentType.type,
                                      'time': mesg.time,
                                      'senderId': mesg.senderId,
                                      'receiverId': mesg.receiverId,
                                      'message': mesg.message,
                                      'messageAudioId': mesg.messageAudioId
                                    },
                                    conflictAlgorithm:
                                        ConflictAlgorithm.replace);
                                if (audioOK > 0 && messageOK > 0) {
                                  messages.insert(0, mesg);
                                  debugPrint("添加成功");
                                } else {
                                  debugPrint("添加失败");
                                }

                                if (mounted) {
                                  setState(() {});
                                }
                              },
                            ),
                          ),
                        )
                      : FadeIn(
                          duration: Durations.long1,
                          child: TextField(
                            focusNode: focusNode,
                            controller: textEditingController,
                            style: const TextStyle(color: Colors.black),
                            cursorColor: const Color(0xff002DE3),
                            decoration: const InputDecoration(
                              prefixIconConstraints: BoxConstraints(
                                  maxHeight: 24,
                                  minHeight: 24,
                                  maxWidth: 40,
                                  minWidth: 40),
                              suffixIconConstraints: BoxConstraints(
                                  maxHeight: 38, minHeight: 38, minWidth: 100),
                              isCollapsed: true,
                              filled: true,
                              fillColor: Colors.white,
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              hintStyle: TextStyle(color: Colors.black),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 5, horizontal: 10),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide.none),
                            ),
                          ),
                        )),
              const SizedBox(width: 10),
              SizedBox(
                width: 40,
                child: IconButton(
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    onPressed: () async {
                      if (textEditingController.value.text.isEmpty) return;
                      message.Message mesg = message.Message(
                        message: textEditingController.value.text,
                        time: DateTime.now().toString(),
                        senderId: '1001',
                        receiverId: widget.chatsModel.id.toString(),
                        contentType: MessageContentType.text,
                        messageId: const Uuid().v1(),
                      );
                      messages.insert(0, mesg);
                      Database database = await BitDataBase.database;
                      await database.insert(
                          BitDataBase.DATA_TABLENAME_MESSAGE,
                          {
                            'messageId': mesg.messageId,
                            'contentType': mesg.contentType.type,
                            'time': mesg.time,
                            'senderId': mesg.senderId,
                            'receiverId': mesg.receiverId,
                            'message': mesg.message
                          },
                          conflictAlgorithm: ConflictAlgorithm.replace);
                      textEditingController.clear();
                      if (mounted) {
                        setState(() {});
                      }
                    },
                    icon: SvgPicture.asset('assets/images/send.svg',
                        width: 24, height: 24)),
              ),
              SizedBox(
                width: 40,
                child: IconButton(
                    style: const ButtonStyle(
                        overlayColor:
                            MaterialStatePropertyAll(Colors.transparent),
                        padding: MaterialStatePropertyAll(EdgeInsets.zero)),
                    icon: SvgPicture.asset(
                      'assets/images/Icon.svg',
                      width: 24,
                      height: 24,
                      colorFilter: const ColorFilter.mode(
                          Colors.black54, BlendMode.srcIn),
                    ),
                    onPressed: () {
                      FocusScope.of(context).requestFocus(FocusNode());
                      if (!isAudio) {
                        isAudio = !isAudio;
                      }
                      height == 0
                          ? height = MediaQuery.of(context).size.height * .3
                          : height = 0;
                      if (mounted) {
                        setState(() {});
                      }
                    }),
              ),
              const SizedBox(width: 5)
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
                    GestureDetector(
                      onTap: () => getLostData(),
                      child: Column(children: [
                        SvgPicture.asset('assets/images/Image_01.svg',
                            colorFilter: const ColorFilter.mode(
                                Colors.black54, BlendMode.srcIn),
                            width: 26,
                            height: 26),
                        const SizedBox(height: 5),
                        const Text('相册',
                            style: TextStyle(color: Colors.grey, fontSize: 14))
                      ]),
                    ),
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
