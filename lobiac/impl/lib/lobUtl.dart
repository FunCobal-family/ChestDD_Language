/**
Lobiac関連のユーティリティを収める。
 */
import "dart:convert";
/**
Lobiacのマジックナンバーの算出。引数はLobiacのメジャーバージョン中の数字を指定する。
 */
List<int> lobMagic(int ver){
  List<int> lobHex = [108+105,111+97,98+99,];
  String verStr = ver.toString();
  if(verStr.length < 2){
    verStr = verStr.padLeft(2,"0");
  }else if(verStr.length > 2){
    verStr = verStr.substring(0,2);
  }
  String forASCII = "lob$verStr";
  List<int> asciiLi = ascii.encode(forASCII).toList();
  lobHex.insertAll(2,asciiLi);
  return lobHex;
}
/**
List\<int\>からHexStrへの変換
 */
extension HexUtl4int on List<int>{
  /**
  List\<int\>からHexStrへの変換
   */
String toHex({String sep = " "})=>this.map((int elm)=>elm.toRadixString(16)).join(sep);
}
/**
Uint8ListからHexStrへの変換
 */
extension HexUtl4Uint8List on Uint8List{
  /**
  Uint8ListからHexStrへの変換
  */
  String toHex({String sep = " "})=>this.toList().toHex(sep);
}

