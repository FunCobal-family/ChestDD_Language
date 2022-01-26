/**
  Lobiac仕様におけるデータの型を定義する。
 */
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
// ignore: implementation_imports
import "package:pointycastle/src/utils.dart";

/**
  Lobiac言語のデータ型の列挙
 */
enum LobType{
  Version,
  String,
  Url, // URL
  Path, // Local path
  TimeStamp, //Unix TimeStamp
  Hash,
  DateTime,
  Unit, // Conf Group
  List, //List<T>
  Map, //Map<K,V>
  Document,
  LineData,
  BinStr, // Sirialized Binary Data with such as Base64
}
/**
  Map型におけるKey, Valueの型
 */
abstract class LobMap{
  static LobType typeOfKey;
  static LobType typeOfVal;
}
/**
  List型におけるValueの型
 */
abstract class LobList{
  static LobType typeOfVal;
}
/** 
  Lobiac記事データのバージョン管理のためのハッシュ生成・保持の系
*/
class LobHash{
  Digest keccak = Digest("Keccak/256");
  late Uint8List data;
  late BigInt hashBI;
  late String hashStr;
  LobHash(String str){
    List<int> charCodes = str.codeUnits;
    this.data = Uint8List.fromList(charCodes);
    this.keccak.update(this.data, 0, this.data.length);
    Uint8List hashUL = Uint8List(this.keccak.digestSize);
    this.keccak.doFinal(hashUL, 0);
    this.hashBI = decodeBigInt(hashUL);
    this.hashStr = this.hashBI.toRadixString(16);
  }
  String hashStrTop(int length)=>this.hashStr.substring(0,length);

}

//groups
/**
  Ｌｏｂｉａｃ記事データの型定義
 */
abstract class LobData{
  static LobType type;
}
/**
  Lobiac設定・メタ情報の型・形式定義
 */
abstract class LobConf{
  static String? group;
  static String key;
  static LobType type;
}

