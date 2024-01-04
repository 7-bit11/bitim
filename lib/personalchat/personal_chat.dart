import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PersonalChatPage extends StatefulWidget {
  const PersonalChatPage({super.key, required this.name});
  final String name;
  @override
  State<PersonalChatPage> createState() => _PersonalChatPageState();
}

class _PersonalChatPageState extends State<PersonalChatPage> {
  @override
  void initState() {
    super.initState();
    initData();
  }

  // messages
  List<Message> messages = [];
  //加载数据
  void initData() {
    messages = [
      Message(
        message: '你好',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
      ),
      Message(
        message: '您有啥事吗？',
        time: '2021-01-01 12:00:00',
        senderId: '1001',
        receiverId: '1002',
        contentType: MessageContentType.text,
      ),
      Message(
        message: '我看了您写的IM程序,希望能和您有合作的机会',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
      ),
      Message(
        message: '我发的这个动物是啥？',
        time: '2021-01-01 12:00:00',
        senderId: '1001',
        receiverId: '1002',
        contentType: MessageContentType.text,
      ),
      Message(
        message:
            'https://images.wallpaperscraft.com/image/single/snow_leopard_snow_hunting_57947_1280x720.jpg',
        time: '2021-01-01 12:00:00',
        senderId: '1001',
        receiverId: '1002',
        contentType: MessageContentType.image,
      ),
      Message(
        message: '芝士雪豹',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.text,
      ),
      Message(
        message:
            'https://images.wallpaperscraft.com/image/single/girl_anime_food_671_1280x720.jpg',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.image,
      ),
      Message(
        message:
            'https://images.wallpaperscraft.com/image/single/girl_glasses_heart_1141129_1280x720.jpg',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.image,
      ),
      Message(
        message:
            'https://images.wallpaperscraft.com/image/single/boat_mountains_lake_135258_1280x720.jpg',
        time: '2021-01-01 12:00:00',
        senderId: '1002',
        receiverId: '1001',
        contentType: MessageContentType.image,
      )
    ];
    messages = messages.reversed.toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF2F2F2),
      appBar: CupertinoNavigationBar(
          middle: Text(widget.name),
          trailing: SvgPicture.asset('assets/images/more_vert.svg')),
      body: ListView.builder(
        shrinkWrap: true,
        reverse: true,
        itemBuilder: (BuildContext context, int index) {
          return MessageWidget(message: messages[index]);
        },
        itemCount: messages.length,
      ),
    );
  }
}

class MessageWidget extends StatefulWidget {
  const MessageWidget({super.key, required this.message});
  final Message message;
  @override
  State<MessageWidget> createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget> {
  @override
  void initState() {
    super.initState();

    initData();
  }

  late Widget mseeageContent;
  late String url;
  late String id;
  //模拟查询用户信息
  initData() {
    //根据用户id查询用户信息 1001默认为用户自己本地存储的用户id
    if (widget.message.senderId == '1001') {
      id = '1001';
      url =
          'https://upload.jianshu.io/users/upload_avatars/26977695/60eaf225-00fe-4028-95bd-1652cd174ee6.jpg';
    } else if (widget.message.senderId == '1002') {
      id = '1002';
      url =
          'https://upload.jianshu.io/users/upload_avatars/7705786/a90dc05d-63f6-4690-8c1a-dcf7ff4422df.jpg';
    }
  }

  void buildMessageContent() {
    switch (widget.message.contentType) {
      case MessageContentType.text:
        mseeageContent = Text(widget.message.message);
      case MessageContentType.image:
        mseeageContent = ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height * .1),
              child: CachedNetworkImage(
                imageUrl: widget.message.message,
                placeholder: (context, url) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                },
              )),
        );
      default:
        mseeageContent = Text(widget.message.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    buildMessageContent();
    //假如是自己发送的消息
    return id == '1001' ? buildRightMessage() : buildLeftMessage();
  }

  // 右边消息
  buildRightMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7),
              padding: widget.message.contentType == MessageContentType.image
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Color(0xff0099FF),
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: DefaultTextStyle(
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  child: mseeageContent)),
          const SizedBox(width: 10),
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
        ],
      ),
    );
  }

  //左边消息
  buildLeftMessage() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipOval(
            child: CachedNetworkImage(
              imageUrl: url,
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Container(
              constraints: BoxConstraints(
                  maxWidth: MediaQuery.of(context).size.width * .7),
              padding: widget.message.contentType == MessageContentType.image
                  ? const EdgeInsets.all(0)
                  : const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  )),
              child: DefaultTextStyle(
                  style: const TextStyle(
                      color: Color.fromARGB(255, 48, 31, 31), fontSize: 15),
                  child: mseeageContent)),
        ],
      ),
    );
  }
}

class Message {
  //发送信息
  late dynamic message;
  //发送者ID
  late String senderId;
  //接收者ID
  late String receiverId;
  //发送时间
  late String time;
  late MessageContentType contentType;
  //构造函数
  Message(
      {required this.message,
      required this.senderId,
      required this.receiverId,
      required this.time,
      required this.contentType});
}

enum MessageContentType {
  text(type: 1),
  image(type: 2),
  video(type: 3),
  audio(type: 4),
  file(type: 5),
  location(type: 6),
  custom(type: 7);

  final int type;
  const MessageContentType({required this.type});
}
