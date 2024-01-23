// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bit_im/chats/chats_model.dart';
import 'package:bit_im/chats/chats_page.dart';
import 'package:bit_im/contacts/contacts_page.dart';
import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:bit_im/frame/data_base.dart';
import 'package:bit_im/message/message_audio.dart';
import 'package:bit_im/message/message_content_type_enum.dart';
import 'package:bit_im/message/message_video.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as p;
import 'package:bit_im/message/message.dart' as message;
import 'package:uuid/uuid.dart';
import 'package:bit_im/message/message_image.dart' as mimage;

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int cuffindex = 0;
  List<Widget> pages = [const ChatsPage(), const ContactsPage()];

  @override
  void initState() {
    BitDataBase.initDataBase();
    initDataBase();
    super.initState();
  }

  void initDataBase() async {
    // Get a location using getDatabasesPath

    List<ChatsModel> chatsModels = [
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_cap_blouse_980525_1280x720.jpg',
          name: 'Ashish',
          time: '10:30',
          message: 'Good morning, did you sleep well?',
          count: 12,
          state: ChatsStateEnum.online,
          id: 1002),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/buzzard_bird_sky_1154521_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          state: ChatsStateEnum.online,
          id: 1003),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/thistle_plant_bud_1154486_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          count: 5,
          id: 1004),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/arctic_fox_wild_animal_wildlife_1151659_1280x720.jpg',
          name: 'Athalia Putri',
          time: '3m ago',
          message: 'Good morning, did you sleep well?',
          count: 1,
          state: ChatsStateEnum.online,
          id: 1005),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_flower_1035552_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          id: 1006),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_fish_1005833_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          count: 1,
          id: 1007),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_bob_1136652_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 1008),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/aquilegia_plant_leaves_1151450_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          count: 50,
          id: 1009),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_demon_horns_1085787_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 1010),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_knife_glance_1145057_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 1011),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/cobweb_snow_blur_1140721_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          id: 1012)
    ];
    for (var element in chatsModels) {
      Database database = await BitDataBase.database;
      int i = await database.insert(
          'CHATSTABLE',
          {
            'id': element.id,
            'url': element.url,
            'name': element.name,
            'time': element.time,
            'message': element.message,
            'count': element.count,
            'state': element.state.id,
          },
          conflictAlgorithm: ConflictAlgorithm.replace);
      debugPrint("====== ======== ========   $i");
    }
    initData1();
  }

  //加载数据
  void initData1() async {
    final audioFile =
        File(p.join((await getTemporaryDirectory()).path, 'xxx.mp3'));
    List<message.Message> messagedata = [
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
          senderId: '1002',
          receiverId: '1001',
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
    Database database = await BitDataBase.database;
    int i = 10001;
    for (var element in messagedata) {
      String uuid = const Uuid().v4();
      String? imageId;
      String? audioId;
      String? videoId;
      switch (element.contentType) {
        case MessageContentType.text:
          break;
        case MessageContentType.image:
          await database.insert(
              BitDataBase.DATA_TABLENAME_MESSAGEIMAGE,
              {
                'id': uuid,
                'url': element.imageInfo!.url,
                'width': element.imageInfo!.width,
                'height': element.imageInfo!.height,
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
          imageId = uuid;
          break;
        case MessageContentType.audio:
          await database.insert(
              BitDataBase.DATA_TABLENAME_MESSAGEAUDIO,
              {
                'id': uuid,
                'audioFilePath': element.messageAudio!.audioFilePath,
                'audioFileName': element.messageAudio!.audioFileName,
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
          audioId = uuid;
          break;
        case MessageContentType.video:
          await database.insert(
              BitDataBase.DATA_TABLENAME_MESSAGEVIDEO,
              {
                'id': uuid,
                'url': element.messageVideo!.url,
                'width': element.messageVideo!.width,
                'height': element.messageVideo!.height,
              },
              conflictAlgorithm: ConflictAlgorithm.replace);
          videoId = uuid;
          break;
        default:
          break;
      }
      await database.insert(
          BitDataBase.DATA_TABLENAME_MESSAGE,
          {
            'messageId': i.toString(),
            'message': element.message,
            'senderId': element.senderId,
            'receiverId': element.receiverId,
            'time': DateTime.now().toString(),
            'contentType': element.contentType.type,
            'imageInfoId': imageId,
            'messageAudioId': audioId,
            'messageVideoId': videoId,
          },
          conflictAlgorithm: ConflictAlgorithm.ignore);
      i++;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: cuffindex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: cuffindex,
          onTap: (value) => setState(() => cuffindex = value),
          items: [
            BottomNavigationBarItem(
                label: 'Chats',
                icon: SvgPicture.asset(
                  'assets/images/chat.svg',
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                      cuffindex == 0 ? const Color(0xff002DE3) : Colors.grey,
                      BlendMode.srcIn),
                )),
            BottomNavigationBarItem(
                label: 'Contacts',
                icon: SvgPicture.asset('assets/images/supervisor_account.svg',
                    width: 24,
                    height: 24,
                    colorFilter: ColorFilter.mode(
                        cuffindex == 1 ? const Color(0xff002DE3) : Colors.grey,
                        BlendMode.srcIn)))
          ]),
    );
  }
}
