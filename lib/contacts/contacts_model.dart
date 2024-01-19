import 'package:azlistview/azlistview.dart';
import 'package:bit_im/enum/chats_state_enum.dart';
import 'package:json_annotation/json_annotation.dart';

part 'contacts_model.g.dart';

@JsonSerializable()
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

  factory ContactsModel.fromJson(Map<String, dynamic> data) =>
      _$ContactsModelFromJson(data);

  Map<String, dynamic> toJson() => _$ContactsModelToJson(this);
}
