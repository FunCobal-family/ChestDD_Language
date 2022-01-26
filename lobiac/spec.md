# Specifications of Lobiac

[ChestDD](./../README.md) > [Lobiac](./index.md) > Spec

Lobiac 言語には、Lobiac Article、Resource Index Table、及び Lobiac Package の 3 ファイル形式がある。

また、ドキュメントに埋め込むリソースの配置によって 3 種の方式に分れる。

- リソース包含式(RIF: Resource Included Formula): biac ファイルにリソースデータも共に埋め込み記述したもの。
- リソース梱束式(RPF: Resource Packaging Formula):個別のコンテンツごとにパッケージを構成しポータブル仕様としたもの。
- リソース分離式(RSF: Resource Separated Formula):biac ファイルとリソースファイルが別の場所にあるもの。サーバなどで用いる。

biac ファイルは全ての場合で必要であり、また RPF(リソース梱束式)の場合 lobpkg ファイルに梱束される。

リソースデータを記事中に埋め込む場合はリソースファイル及び ritab ファイルは RIF(リソース包含式)以外の全ての場合で必要である。

なお、biac ファイルとは[Lobiac Article](#lobiac-article)を、ritab ファイルとは[Resource Index Table](#resource-index-table)を、lobpkg ファイルとは[Lobiac Package](#lobiac-package)をいう。

Lobiac 言語におけるテキストファイルは、Unicode 又は Sicode の文字コードによって表現されていなければならず、その他の文字コードは無効である。

## Lobiac Article

Lobiac Article(`biac`)は、[ChestDD TC91 Cardinals](./../tc/crd.291/spec.md) に準拠して構成されるテキストファイルである。

一つの`biac`ファイルは、必須の`lob.conf`グループ及び`lob.art`グループ、加えて RIF(リソース包含式)では`lob.res`グループからなる。

---

ただし(Lobiac Article として(専用処理系で)認識する場合は)それぞれのグループ名は、`lob.`の部分を省略して表記することが可能である。

(※ChestDD として個別エディション/フレーバ/派生を区別せずに認識させる場合は名前空間として必須)

---

`lob.conf`グループには設定およびその他メタ情報が記述され、`lob.art`グループには記事本体がバージョニング付きで記述される。
RIF(リソース包含式)における`lob.kind`グループには Resource Index Table に記載される内容が、同じく`lob.res`グループには記事に埋め込まれるべきリソースデータが記録される。リソースデータのうち、バイナリデータはテキストデータに変換して記録される必要がある。

### `lob.conf`グループ

設定およびメタ情報を制約 yaml 形式で記述する。ただし最上位のリスト表記は省略する。

グループ内部は`Map<String, Map<String, String|List<String>|List<List<String>>|DateTime|Map<class:Hash,DateTime>|class:Version|enum:Forml>>`である。

---

制約 yaml 形式: セパレータ及びインライン形式は利用できない。また、インデントは 2 個単位に限る。

---

記述可能な設定項目及びメタ項目、並びにそれぞれに要する値は以下に列挙するとおりである。なお、項目名の直前に`$`がついているものは方式問わず必須であり、また同様に`%`がついているものは条件に合致する場合にのみ記述可能であり、`&`がついているものは記述位置が指定されている。

また、項目名の直後にある括弧書きは、パースする際に認識する型を示す(Dart 式による例)。なお、`class:`プリフィックスが独自クラスを、`enum:`プリフィックスが独自列挙体を表す。

- $& `version`(`class:Version`): そのドキュメントが対応する Lobiac 仕様及び処理系のバージョンを指示する。グループの最初に存在しなければならない。
- $& `kind`, `formula`,又は`forml`(`enum:Forml`): 方式を指定する。 `RIF`、`RPF`又は`RSF`が有効である。`version`の次に存在しなければならない。

- `tag`(`List<List<String>>`):記事のタグを列記する。各タグにおいてスラッシュで区切ると階層構造として認識する。
- `author`(`List<String>`):著者名を列記する。
- `org`(`String`):著者の所属組織・機関を記す。
- `div`(`String`):著者の所属部門・部署を記す。

#### title 系

- `title.main`(`String`): 記事のタイトルを記述する。
- `title.sub`(`String`): 記事の副タイトルを記述する。
- `title.serial`(`String`): 記事のシリーズ ID を指定する。

#### date 系

- `date.latest`(`DateTime`): 記事の最新版変更日時を記述する。
- `date.create`(`DateTime`): 記事の作成日時を記述する。
- `date.modified`(`Map<class:Hash,DateTime>`): 記事の変更日時をマッピングし記録する。

#### res 系

- `res.tab`(`String`): Resource Index Table の存在するパス又は URL を指定する。RSF でのみ指定できる。
- `res.use`(`List<String>`): 記事中で用いるリソースデータの識別名をリスト形式で指定する。指定されている場合、処理系によってはプリロードが効く場合もある。

#### doc 系

- % `doc.md`(`String`): 記事データ中で用いる MarkDown フレーバを指定する。その符号に応じた処理系が呼び出される。記事データ中で MarkDown を用いる場合にのみ指定できる。
- % `doc.xml`(`String`): 記事データ中で用いる XML フレーバを指定する。その符号に応じた処理系が呼び出される。記事データ中で XML を用いる場合にのみ指定できる。
- % `doc.sgml`(`String`): 記事データ中で用いる SGML フレーバを指定する。その符号に応じた処理系が呼び出される。記事データ中で SGML を用いる場合にのみ指定できる。

#### bin 系

- % `bin.encode`(`String`): バイナリファイルのエンコード方式を指定する。RIF でのみ指定できる。既定は`Base64`である。

### `lob.art`グループ

`$&`で始まる行は処理指示である。

`-line`の行はデータの行区切りである。

`.`で始まる行はデータである。ハッシュ値及び`:`に後続して行データが記述される。

### `lob.kind`グループ

RIF(リソース包含式)において、Resource Index Table に記載されるべき内容を記述する。

### `lob.res`グループ

RIF(リソース包含式)において、記事に埋め込まれるべきリソースデータが記録される。

`$`に続いて bin/txt の種別、拡張子、リソースデータの行数(バイナリの場合はシリアライズ後の行数)を示す行があったのちにデータを挿入する

ex:

```biac
$bin img 1
SXQncyBzYW1wbGUgRGF0YQ==
```

```biac
$txt svg 19
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<svg width="210mm" height="210mm" viewBox="0 0 210 210" version="1.1">
  <g transform="translate(0,-87)">
    <g>
      <path d="M 25.702005,268.95379 V 105.8952 l 113.091045,-3e-5 4.76233,8.46683 -109.764308,-1.3e-4 v 154.59192 z"
         style="fill:#98dde7;fill-opacity:1;stroke:none;stroke-width:0.26458332px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
      <path d="M 39.007005,120.06879 V 283.128 H 161.62238 V 130.65258 l -7.937,-10.58337 z m 8.530666,8.05577 100.919389,-7.3e-4 4.76266,6.35051 V 274.77917 H 47.537671 Z"
         style="fill:#25b7c0;fill-opacity:1;stroke:none;stroke-width:0.26458332px;stroke-linecap:butt;stroke-linejoin:miter;stroke-opacity:1" />
    </g>
    (中略)
  </g>
</svg>
```

## Resource Index Table

Resource Index Table(`ritab`)は、[ChestDD TC92 Tabular](./../tc/tab.292/spec.md) に準拠して構成されるテキストファイルである。ドキュメント形式ではなくデータ形式を用いる。

`lob.kind`グループ(なおこの場合の`lob`も Lobiac Article に同じ)でテーブルデータを囲う。

テーブルのヘッダーには Kind, Ext, Ident, Path, CreateDate, LastModDate を記述する。各カラムには次の内容を記す。

- Kind: txt(テキストファイル)又は bin(バイナリファイル)
- Ext: ファイルの拡張子
- Ident: ファイルの識別名
- Path: ファイルのの実パス
- CreateDate: ファイルの作成日時
- LastModDate: ファイルの最終更新日時

ただし、表計算機能は用いることができない。

## Resource Files

記事データ中に埋め込むための任意のリソースファイル及びその集合をいう。RPF(リソース梱束式)及び RSF(リソース分離式)で用いるリソースデータ表現である。

---

各々のリソースデータは、そのリソースデータを(記事データ中で)指定するための識別名を持つ。識別名は`([a-zA-Z][a-zA-Z0-9]*)(\.[a-zA-Z][a-zA-Z0-9]*)*`の POSIX 正規表現で指定される形式に合致する

---

リソースファイルのファイル名は任意に指定することができる。

## Lobiac Package

Lobiac Package は以下のディレクトリ構成を zip 圧縮しバイト列冒頭に後述のとおりマジックナンバーたるバイト列を付加したものである。

- `root`

  - index.biac
  - assets.ritab
  - `assets`
    - actual.path.to.file1.ext
    - actual.path.to.file2.ext
    - actual.path.to.file3.ext

- `root`: パッケージルートディレクトリ。そのパッケージを認識可能な任意の名称でよい。
- `assets`: リソースディレクトリ。そのパッケージで用いるリソースの実データを収める。
- assets.ritab: そのパッケージ(の`assets`ディレクトリ)に収めるリソースファイルのテーブルである。
- index.biac: そのパッケージを開いたときに最初に表示されるページには`index.biac` というファイル名を与える。リンクに応じて適宜 biac ファイルを追加してよい。
- obj.ident.to.file*1*.ext: そのパッケージで用いるリソースファイル群。各々のリソースファイルは、形式に合致する任意のファイル名を持つ。

---

マジックナンバーは 8 バイトからなる。

- 1~2 バイト目は hex 数値で`d5 d0`である。
- 3~5 バイト目は小文字英字文字列`lob`を ASCII 符号化したものである。
- 6 ～ 7 バイト目は Lobiac のメジャーバージョン中の数字をアラビア数字として ASCII 符号化したものである。2 桁に満たなければ先頭を 0 でパディングし、2 桁を越しているならば先頭 2 桁を用いる。
- 8 バイト目は hex 数値で`c5`である。

Lobiac 仕様 v1 準拠ならば、マジックナンバーは hex 数値で`d5 d0 6c 6f 62 30 31 c5`,`List<int>`で`[213, 208, 108, 111, 98, 48, 49, 197,]`となる。

マジックナンバーの計算のサンプル Dart コードは[GitHub Gist](https://gist.github.com/halka9000stg/3260ebdf869e62a7ac34f2cbd91b154f)にある。実行サンプルは[DartPad](https://dartpad.dev/?null_safety=true&id=3260ebdf869e62a7ac34f2cbd91b154f)にて行える。
