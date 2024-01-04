enum ChatsStateEnum {
  online(name: 'online', id: 0),
  offline(name: 'offline', id: 1);

  final String name;
  final int id;
  const ChatsStateEnum({required this.name, required this.id});
}
