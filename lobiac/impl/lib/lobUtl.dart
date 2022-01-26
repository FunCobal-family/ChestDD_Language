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
Lobiacのマジックナンバーと合致しているか検査する。合致していれば非負intでバージョン値、合致していなければエラーコード。
- -9: 引数のリストがマジックナンバーのバイト数に足りない
- -2: バージョンのパースに失敗した
- -1: 固定部が合致しない
 */
int matchLobMagic(List<int> src){
  if(src.length < 8){
    return -9;
  }
  List<int> magic = [];
  if(src.length > 8){
    magic = src.take(8).toList();
  }else{
    magic = src;
  }
  if(magic.take(5).toList() == [108+105,111+97,].addAll(ascii.encode("lob").toList())){
    if(magic.last ==98+99){
      List<int> nrCand = magic.skip(5).take(2).toList();
      String asciiStr = ascii.decode(nrCand, allowInvalid: true);
      try{
        int ver = inr.parse(asciiStr);
        return ver;
      }catch (e){
        return -2;
      }
    }
  }
  return -1;
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

