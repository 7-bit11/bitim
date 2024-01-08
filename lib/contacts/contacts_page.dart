import 'package:azlistview/azlistview.dart';
import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  late List<ContactsModel> contactsModels;
  @override
  void initState() {
    super.initState();
    initData();
  }

  void initData() {
    contactsModels = [
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'NX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: 'Orlan Sadewa',
          time: 'Last seen 3 hours ago'),
      ContactsModel(
          url: 'assets/images/Frame 32933.svg',
          name: 'Pthalia Putri',
          time: '3m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 3293.svg',
          name: 'Ashish',
          time: 'Last seen yesterday',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'BX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32933.svg',
          name: 'Vthalia Putri',
          time: '3m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32934.svg',
          name: 'WX Team',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'ZX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32935.svg',
          name: 'Frlan Sadewa',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 3293.svg',
          name: 'Gshish',
          time: 'Last seen yesterday',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'HX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: 'Irlan Sadewa',
          time: 'Last seen 3 hours ago'),
      ContactsModel(
          url: 'assets/images/Frame 32933.svg',
          name: 'Jthalia Putri',
          time: '3m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32934.svg',
          name: 'KX Team',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 32935.svg',
          name: 'Lrlan Sadewa',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 3293.svg',
          name: 'Mshish',
          time: 'Last seen yesterday',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'NX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: 'Crlan Sadewa',
          time: 'Last seen 3 hours ago'),
      ContactsModel(
          url: 'assets/images/Frame 32933.svg',
          name: 'Dthalia Putri',
          time: '3m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32934.svg',
          name: 'EX Team',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: 'Orlan Sadewa',
          time: 'Last seen 3 hours ago'),
      ContactsModel(
          url: 'assets/images/Frame 32935.svg',
          name: 'Xrlan Sadewa',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 3293.svg',
          name: 'Yshish',
          time: 'Last seen yesterday',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32933.svg',
          name: 'Pthalia Putri',
          time: '3m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32934.svg',
          name: 'QX Team',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 32935.svg',
          name: 'Rrlan Sadewa',
          time: 'Last seen 30 minutes ago'),
      ContactsModel(
          url: 'assets/images/Frame 3293.svg',
          name: 'Sshish',
          time: 'Last seen yesterday',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32931.svg',
          name: 'TX Team',
          time: '15m ago',
          state: ChatsStateEnum.online),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: 'Urlan Sadewa',
          time: 'Last seen 3 hours ago'),
      ContactsModel(
          url: 'assets/images/Frame 32932.svg',
          name: '####rlan Sadewa',
          time: 'Last seen 3 hours ago'),
    ];
    for (int i = 0, length = contactsModels.length; i < length; i++) {
      String tag = contactsModels[i].name.substring(0, 1).toUpperCase();
      if (RegExp("[A-Z]").hasMatch(tag)) {
        contactsModels[i].tagIndex = tag;
      } else {
        contactsModels[i].tagIndex = "#";
      }
    }

    // A-Z sort.
    SuspensionUtil.sortListBySuspensionTag(contactsModels);

    // show sus tag.
    SuspensionUtil.setShowSuspensionStatus(contactsModels);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        child: Scaffold(
          appBar: AppBar(
              title: const Text('Contacts',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold)),
              backgroundColor: const Color(0xffFEFBFE),
              surfaceTintColor: const Color(0xffFEFBFE)),
          body: AzListView(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height * .7),
              data: contactsModels,
              itemCount: contactsModels.length,
              itemBuilder: (BuildContext context, int index) {
                return buildWidget(contactsModel: contactsModels[index]);
              },
              indexBarData: SuspensionUtil.getTagIndexList(contactsModels),
              indexBarOptions: const IndexBarOptions(
                needRebuild: true,
                ignoreDragCancel: true,
                hapticFeedback: true,
                downTextStyle: TextStyle(fontSize: 12, color: Colors.white),
                downItemDecoration: BoxDecoration(
                    shape: BoxShape.circle, color: Color(0xff002DE3)),
                indexHintWidth: 120 / 2,
                indexHintHeight: 100 / 2,
              )),
        ));
  }
}

buildWidget({required ContactsModel contactsModel}) {
  return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      child: Row(children: [
        Stack(
          children: [
            SvgPicture.asset(contactsModel.url, width: 50, height: 50),
            Container(
                decoration: BoxDecoration(
                    color: contactsModel.state == ChatsStateEnum.online
                        ? Colors.transparent
                        : Colors.grey.withOpacity(.4),
                    borderRadius: BorderRadius.circular(10)),
                width: 50,
                height: 50),
            Positioned(
              right: 0,
              bottom: 0,
              child: Stack(
                alignment: AlignmentDirectional.center,
                children: [
                  Container(
                      decoration: BoxDecoration(
                          color: contactsModel.state == ChatsStateEnum.online
                              ? Colors.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20)),
                      width: 13,
                      height: 13),
                  Container(
                      decoration: BoxDecoration(
                          color: contactsModel.state == ChatsStateEnum.online
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contactsModel.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: Colors.black)),
            Text(
                contactsModel.state == ChatsStateEnum.offline
                    ? contactsModel.time
                    : 'Online',
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffADB5BD))),
          ],
        )
      ]));
}

class ContactsModel extends ISuspensionBean {
  late String url;
  late String name;
  late String time;
  String? tagIndex;
  late ChatsStateEnum state;
  ContactsModel(
      {required this.url,
      this.name = '',
      this.time = '',
      this.tagIndex,
      this.state = ChatsStateEnum.offline});

  @override
  String getSuspensionTag() => tagIndex!;
}
