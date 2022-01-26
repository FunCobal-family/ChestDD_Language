import "package:lobiac/typedData.dart";

//lob.conf
class ConfAuthor implements LobConf, LobList{
  @override
  static String? group = null;
  @override
  static String key = "author";
  @override
  static LobType type = LobType.List;
  @override
  static LobType typeOfVal = LobType.String;
}
class ConfOrgOfVal implements LobConf{
  @override
  static String? group = null;
  @override
  static String key = "org";
  @override
  static LobType type = LobType.String;
}
class ConfTag implements LobConf, LobList{
  @override
  static String? group = null;
  @override
  static String key = "tag";
  @override
  static LobType type = LobType.List;
  @override
  static LobType typeOfVal = LobType.String;
}