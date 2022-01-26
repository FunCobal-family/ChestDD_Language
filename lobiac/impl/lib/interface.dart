/**
  Lobiac処理系におけるプラグイン類似物、プラグイン管理システム、及びその他のインターフェースを定義する。
 */
import "package:lobiac/lobiac.dart" show LobiacSystem;

  /**
  Lobiacプラグインのテーブルのレコード
   */
typedef LobUnitRec = TabRec<LobDataKind, LobiacSysUnitBasic>;


/**
  Lobiac Articleファイルの記事本体となるマークダウン/マークアップ言語その他データ記述言語を処理するためのユニットを与えるためのプラグインフォーマット
 */
abstract class LobiacSysUnitBasic{
  /**
  データを解析しパースする。
   */
  ParsedData parse(String source);
  /**
  HTMLやaltHTMLなどのブラウザ可読形式を出力する。
   */
  String toOutput(String source, OutputStyle outStyle);
  /**
  Lobiac処理系に登録されたときに発火するイニシャライズ機構。
   */
  FutureOr<void> onRegister(LobiacSystem sys, Logger lg);
}

  /**
  LobiacプラグインのMarkDown族のための原型。
   */
abstract class BasicUnit4MD extends LobiacSysUnitBasic{}
  /**
  LobiacプラグインのXML族のための原型。
   */
abstract class BasicUnit4XML extends LobiacSysUnitBasic{}
  /**
  LobiacプラグインのSGML族のための原型。
   */
abstract class BasicUnit4SGML extends LobiacSysUnitBasic{}

  /**
  Lobiacプラグイン管理システムのインターフェース。
   */
abstract class LobiacUnitManager{
  /**
  保持しているLobiacプラグインのリスト。
   */
  List<LobUnitRec> get dataUnits;

  /**
  Lobiacプラグインを登録する。
   */
  void registerUnit<T extends LobiacSysUnitBasic>(LobDataKind kind, String name, T dataUnit);
}
  /**
  Lobiacにおいて許容するDDLの種別を定義する。
   */
enum LobDataKind{
  md,
  xml,
  sgml,
}
//末尾AはAttrのA。classが予約語と衝突しないように
  /**
  出力する際につける識別系属性の定義。
   */
enum MarkingKind{
  idA,
  classA,
}
  /**
  HTMLやaltHTMLなどのブラウザ可読形式を定義する。
   */
enum OutputStyle{
  html,
  haml,
  slim,
  pug,
  xadoc,
}
  /**
  テーブルのレコードの形式。
   */
class TabRec<K,U>{
  
  /**
  データの種別。
   */
  K kind;
  /**
  データの名前。
   */
  String name;
  /**
  レコードのデータ。
   */
  U data;
  /**
  コンストラクタ。
   */
  TabRec(this.kind,this.name,this.data);
}