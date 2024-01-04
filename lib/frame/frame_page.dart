import 'package:bit_im/chats/chats_page.dart';
import 'package:bit_im/contacts/contacts_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class FramePage extends StatefulWidget {
  const FramePage({super.key});

  @override
  State<FramePage> createState() => _FramePageState();
}

class _FramePageState extends State<FramePage> {
  int cuffindex = 0;
  List<Widget> pages = [const ChatsPage(), const ContactsPage()];
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
