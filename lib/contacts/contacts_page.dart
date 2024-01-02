import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ContactsPage extends StatefulWidget {
  const ContactsPage({super.key});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: const CupertinoNavigationBar(
        // Try removing opacity to observe the lack of a blur effect and of sliding content.
        middle: Text('CupertinoNavigationBar Sample'),
        backgroundColor: Color(0x88FFFFFF),
      ),
      child: ListView(
        children: <Widget>[
          Container(height: 150, color: CupertinoColors.systemRed),
          Container(height: 150, color: CupertinoColors.systemGreen),
          Container(height: 150, color: CupertinoColors.systemBlue),
          Container(height: 150, color: CupertinoColors.systemYellow),
          Container(height: 150, color: CupertinoColors.activeGreen),
          Container(height: 150, color: CupertinoColors.tertiarySystemFill),
          Container(height: 150, color: CupertinoColors.systemTeal),
        ],
      ),
    );
  }
}
