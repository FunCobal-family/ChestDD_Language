/**
  Lobiac処理系本体。LobiacSystemを起動してデータを読み込み処理を行う。
 */
import "package:logging/logging.dart";

import "package:lobiac/typedData.dart";
import "package:lobiac/interface.dart";
import "package:lobiac/src/lobFile.dart";

/**
Lobiac言語におけるファイル種別を定義する。
 */
enum LobFiles{
  biac,
  ritab
  lobpkg,
}
/**
Lobiac言語のファイル種別から拡張子や名称などの情報を取得するためのユーティリティ。
 */
extension LobiacFilesUtl on LobFiles {
  /**
  ファイルの拡張子(ドットなし)
   */
  String get ext => this.toString().split(".").skip(1).join(".");
  /**
  ファイルの拡張子(ドットつき)
   */
  String get extd => "." + this.ext;
  /**
  ファイルの名称
   */
  String get name {
    switch(this){
      case LobFiles.biac:
        return "Lobiac Article";
      case LobFiles.ritab:
        return "Resource Index Table";
      case LobFiles.lobpkg:
        return "Lobiac Package";
    }
  }
}
  /**
  Lobiac処理系本体たるLobiacSystem。LobiacSystem.launchコンストラクタで起動する。
   */
class LobiacSystem implements LobiacUnitManager{
  List<LobUnitRec> _dataUnitList = [];
  List<LobiacData> _data =[];
  /**
  ロガー。
   */
  Logger lg;
  /**
  コンストラクタ。ロガーとともに起動。
   */
  LobiacSystem.launch(this.lg);
  /**
  Lobiacファイルデータ処理プラグインを登録する。
   */
  void registerUnit<T extends LobiacSysUnitBasic>(LobDataKind kind, String name,T dataUnit)=>
    this._dataUnitList.add(LobUnitRec(kind, name, dataUnit));
  /**
  biacファイルのデータを読み込む。
   */
  void loadBiacData(String named, String data){}
  /**
  biacファイルをファイルから読み込む(同期)。
   */
  void loadBiacFile(String named, File file){
    if(file.path.endsWith(LobFiles.biac.extd)){
      if(file.existsSync()){
        String data = file.readAsStringSync();
        this.loadBiacData(named, data);
      }
    }
  }
  /**
  biacファイルをファイルから読み込む(非同期)。
   */
  Future<void> loadBiacFileAsync(String named, File file) async{
    if(file.path.endsWith(".biac")){
      if(await file.exists()){
        String data = await file.readAsString();
        this.loadBiacData(named, data);
      }
    }
  }
  /**
  登録されているLobiacファイルデータ処理プラグインを取得。
   */
  List<LobUnitRec> get dataUnits => this._dataUnitList;
}