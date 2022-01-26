import "package:lobiac/typedData.dart";

//lob.art
class DocumentLine implements LobData, LobMap{
  static String head = "-line";
  @override
  static LobType type = LobType.LineData;
  @override
  static LobType typeOfKey = LobType.Hash;
  @override
  static LobType typeOfVal = LobType.String;
  Map<LobHash,String> data = {};
  void addData(String lineData, LobHash hash){
    this.data.putIfAbsent(hash, lineData);
  }
}

