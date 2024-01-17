import 'package:bit_im/chats/chats_model.dart';
import 'package:bit_im/chats/chats_page.dart';
import 'package:bit_im/contacts/contacts_page.dart';
import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

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
    super.initState();
    initDataBase();
  }

  void initDataBase() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'im.db');
    Database database = await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      // When creating the db, create the table
      await db.execute(
          'CREATE TABLE CHATSTABLE (id INTEGER, url TEXT, name TEXT, time TEXT,message TEXT,count INTEGER,state INTEGER,unique(id))');
    });
    List<ChatsModel> chatsModels = [
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_cap_blouse_980525_1280x720.jpg',
          name: 'Ashish',
          time: '10:30',
          message: 'Good morning, did you sleep well?',
          count: 12,
          state: ChatsStateEnum.online,
          id: 1),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/buzzard_bird_sky_1154521_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          state: ChatsStateEnum.online,
          id: 2),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/thistle_plant_bud_1154486_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          count: 5,
          id: 3),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/arctic_fox_wild_animal_wildlife_1151659_1280x720.jpg',
          name: 'Athalia Putri',
          time: '3m ago',
          message: 'Good morning, did you sleep well?',
          count: 1,
          state: ChatsStateEnum.online,
          id: 4),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_flower_1035552_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          id: 5),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_fish_1005833_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          count: 1,
          id: 6),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_smile_bob_1136652_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 7),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/aquilegia_plant_leaves_1151450_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          count: 50,
          id: 8),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_demon_horns_1085787_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 9),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/girl_knife_glance_1145057_1280x720.jpg',
          name: 'Erlan Sadewa',
          time: '1h ago',
          message: 'Aight, noted',
          id: 10),
      ChatsModel(
          url:
              'https://images.wallpaperscraft.com/image/single/cobweb_snow_blur_1140721_1280x720.jpg',
          name: 'UX Team',
          time: '15m ago',
          message: 'How is it going?',
          id: 11)
    ];
    // Insert some records in a transaction
    // await database.transaction((txn) async {
    //   for (var element in chatsModels) {
    //     // List<Map<String, Object?>> data = await txn.query('CHATSTABLE',
    //     //     columns: ['id'], where: 'id=?', whereArgs: [element.id]);
    //     // if (data.isEmpty) {
    //     //   print('true');
    //     //   int id1 = await txn.rawInsert(
    //     //       'INSERT INTO CHATSTABLE(id, url, name,time, message, count,state) VALUES(${element.id}, "${element.url}", "${element.name}","${element.time}","${element.message}",${element.count},${element.state.id})');
    //     // } else {
    //     //   print('false');
    //     // }
    //     int id1 = await txn.rawInsert(
    //         'INSERT INTO CHATSTABLE(id, url, name,time, message, count,state) VALUES(${element.id}, "${element.url}", "${element.name}","${element.time}","${element.message}",${element.count},${element.state.id})');
    //     print(id1);
    //   }
    // });

    for (var element in chatsModels) {
      // List<Map<String, Object?>> data = await database.query('CHATSTABLE',
      //     columns: ['id'], where: 'id=?', whereArgs: [element.id]);
      // if (data.isEmpty) {
      //   print('true');
      //   await database.insert(
      //       'CHATSTABLE',
      //       {
      //         'id': element.id,
      //         'url': element.url,
      //         'name': element.name,
      //         'time': element.time,
      //         'message': element.message,
      //         'count': element.count,
      //         'state': element.state.id,
      //       },
      //       conflictAlgorithm: ConflictAlgorithm.replace);
      // } else {
      //   print('false');
      // }
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
      print(i);
    }

    await database.close();
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
