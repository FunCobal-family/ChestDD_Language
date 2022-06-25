# FROS: File Resource Object Structure (Draft Memorandum)

テキスト・バイナリ問わずファイルのメタデータと内容をKV-DDLを用いてテキストファイルで表現するためのデータ構造仕様

- `kind`: `bin` or `text`
- `type`: 要素タイプ - Content Type
  - `ifdc`: [統合ファイルデータ要素タイプ - Integrated File Data Content Type](https://github.com/All-the-Filename-extensions/All_the_Filename_extensions/tree/master/IFDC)
  - `uti`: [統一タイプ識別子 - Uniform Type Identifier](https://ja.wikipedia.org/wiki/Uniform_Type_Identifier) (by vendor:Apple)
  - `mime` [MIMEメディアタイプ - MIME Media Type](https://ja.wikipedia.org/wiki/メディアタイプ) (by vendor:IETF)
- `filename` or `name`: ファイル名
- `extension` or `extension`: 拡張子
- `encording`: データ内容のエンコーディング
  - on `text` kind: e.g. `legacy/ascii`, `unicode/utf-8`, `unicode/utf-16`, `sicode/ucrf-32-2`, `sicode/sbrf`
  - on `bin` kind: e.g. `base64/type-a`, `base64/type-ar`, `base64/type-b`, `base64/type-br`
- `date.create`: 作成日時
- `date.latest`: 最終更新日時
- `date.modified`: 更新日時のリスト
- `object.own`: 所有者
- `object.create`: 作成者
- `object.latest`: 最終更新者
- `object.modified`: 更新者のリスト
- `version`: バージョン
- `meta`: その他メタデータ(画像のEXIFデータや音楽のID3タグデータなど)
- `data`: ファイル内容
