import 'package:bit_im/chats/chats_model.dart';
import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:bit_im/frame/data_base.dart';
import 'package:bit_im/personalchat/personal_chat.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({super.key});

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  void initState() {
    super.initState();
    initCacheData();
  }

  void initCacheData() async {
    await Future.delayed(Durations.extralong1);
    Database database = await BitDataBase.database;
    List<Map<String, Object?>> data =
        await database.query('CHATSTABLE', orderBy: 'id ASC');
    for (var element in data) {
      ChatsModel chatsModel = ChatsModel.fromJson(element);
      chatsModels.add(chatsModel);
    }
    setState(() {});
  }

  List<ChatsModel> chatsModels = [];
  //  [
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_cap_blouse_980525_1280x720.jpg',
  //       name: 'Ashish',
  //       time: '10:30',
  //       message: 'Good morning, did you sleep well?',
  //       count: 12,
  //       state: ChatsStateEnum.online,
  //       id: 1),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/buzzard_bird_sky_1154521_1280x720.jpg',
  //       name: 'UX Team',
  //       time: '15m ago',
  //       message: 'How is it going?',
  //       state: ChatsStateEnum.online,
  //       id: 2),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/thistle_plant_bud_1154486_1280x720.jpg',
  //       name: 'Erlan Sadewa',
  //       time: '1h ago',
  //       message: 'Aight, noted',
  //       count: 5,
  //       id: 3),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/arctic_fox_wild_animal_wildlife_1151659_1280x720.jpg',
  //       name: 'Athalia Putri',
  //       time: '3m ago',
  //       message: 'Good morning, did you sleep well?',
  //       count: 1,
  //       state: ChatsStateEnum.online,
  //       id: 4),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_smile_flower_1035552_1280x720.jpg',
  //       name: 'UX Team',
  //       time: '15m ago',
  //       message: 'How is it going?',
  //       id: 5),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_smile_fish_1005833_1280x720.jpg',
  //       name: 'Erlan Sadewa',
  //       time: '1h ago',
  //       message: 'Aight, noted',
  //       count: 1,
  //       id: 6),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_smile_bob_1136652_1280x720.jpg',
  //       name: 'Erlan Sadewa',
  //       time: '1h ago',
  //       message: 'Aight, noted',
  //       id: 7),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/aquilegia_plant_leaves_1151450_1280x720.jpg',
  //       name: 'UX Team',
  //       time: '15m ago',
  //       message: 'How is it going?',
  //       count: 50,
  //       id: 8),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_demon_horns_1085787_1280x720.jpg',
  //       name: 'Erlan Sadewa',
  //       time: '1h ago',
  //       message: 'Aight, noted',
  //       id: 9),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/girl_knife_glance_1145057_1280x720.jpg',
  //       name: 'Erlan Sadewa',
  //       time: '1h ago',
  //       message: 'Aight, noted',
  //       id: 10),
  //   ChatsModel(
  //       url:
  //           'https://images.wallpaperscraft.com/image/single/cobweb_snow_blur_1140721_1280x720.jpg',
  //       name: 'UX Team',
  //       time: '15m ago',
  //       message: 'How is it going?',
  //       id: 11)
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: () {
          Get.dialog(
            Center(
                child: Container(
              width: MediaQuery.of(context).size.width * .6,
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(8)),
              child: DefaultTextStyle(
                style: const TextStyle(color: Colors.black, fontSize: 16),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('温馨提示',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold)),
                    const Text(
                        '欢迎您使用是APP，请充分阅读知疾《用户协议》和《隐私政策》点“同意并继续“代表您已同意前述协议及下列约定;为了给您提供服务，我们会申请系统权限收集设备及个人信息;工再将严格保守您的个人信息，确保信息安全。您在点击”同意并继续”前，务必审慎阅读，充分理解协议条款内容'),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                          onPressed: () {
                            Get.back();
                          },
                          child: const Text('同意并继续',
                              style: TextStyle(color: Colors.white))),
                    )
                  ]),
                ),
              ),
            )),
            barrierDismissible: false,
          );
        }),
        body: CustomScrollView(//controller: controller,
            slivers: [
          const CupertinoSliverNavigationBar(
            largeTitle: Text('Chats'),
            backgroundColor: Color(0x88FFFFFF),
            automaticallyImplyTitle: false,
            brightness: Brightness.light,
            alwaysShowMiddle: false,
          ),
          SliverList.builder(
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () => Get.to(
                      () => PersonalChatPage(name: chatsModels[index].name)),
                  child: DefaultTextStyle(
                      style: const TextStyle(color: Colors.black, fontSize: 15),
                      child: buildWidget(chatsModel: chatsModels[index])),
                );
              },
              itemCount: chatsModels.length)
        ]));
  }
}

buildWidget({required ChatsModel chatsModel}) {
  Widget data = Container(
      decoration: const BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      constraints: const BoxConstraints(minHeight: 20, minWidth: 20),
      child: Center(
          child: Text(chatsModel.count.toString(),
              style: const TextStyle(color: Colors.white, fontSize: 12))));
  if (chatsModel.count <= 0) {
    data = const SizedBox();
  }
  return Container(
      padding: const EdgeInsets.all(15),
      child: Row(
          //crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                      imageUrl: chatsModel.url,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                      placeholder: (c, s) {
                        return Container(
                          width: 50,
                          height: 50,
                          color: Colors.grey.withOpacity(.4),
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
                ),
                Positioned(
                  right: 0,
                  bottom: 0,
                  child: Stack(
                    alignment: AlignmentDirectional.center,
                    children: [
                      Container(
                          decoration: BoxDecoration(
                              color: chatsModel.state == ChatsStateEnum.online
                                  ? Colors.white
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          width: 13,
                          height: 13),
                      Container(
                          decoration: BoxDecoration(
                              color: chatsModel.state == ChatsStateEnum.online
                                  ? const Color(0xff32d877)
                                  : Colors.transparent,
                              borderRadius: BorderRadius.circular(20)),
                          width: 11,
                          height: 11),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(children: [
                Row(children: [
                  Expanded(
                      child: Text(chatsModel.name,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              fontSize: 17, fontWeight: FontWeight.w400))),
                  Text(chatsModel.time)
                ]),
                const SizedBox(height: 5),
                Row(children: [
                  Expanded(
                    child: Text(chatsModel.message,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Color(0xffADB5BD))),
                  ),
                  data
                ])
              ]),
            )
          ]));
}
