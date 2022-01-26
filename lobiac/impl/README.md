# Lobiac: コンテンツデータ蓄積・発行操作言語

<div style="width: 30%;float: left;">

![Lobiac Logo](./Lobiac_Logo.svg)

</div>

[ChestDD](https://github.com/FunCobal-family/ChestDD_Language/blob/master/README.md) > Lobiac

Language for Operating BuildUp and Issuing of Accumulated Content-Data

ブログなどにおけるコンテンツのデータ(文書のほか画像、映像など各種リソースファイル)の蓄積にあたってそれらを統合・体系的に管理し、また発行にあたってそれらの処理(HTML 等の生成・出力など)に関する操作をするための言語

ヘッドレスコンテンツ管理システムなどで用いるために策定された。

## 方式

ドキュメントに埋め込むリソースの配置によって 3 種の方式に分れる。

- リソース包含式(RIF: Resource Included Formula): biac ファイルにリソースデータも共に埋め込み記述したもの
- リソース梱束式(RPF: Resource Packaging Formula): 個別のコンテンツごとにパッケージを構成しポータブル仕様としたもの。詳細は[`.lobpkg`: Lobiac Package](https://github.com/FunCobal-family/ChestDD_Language/blob/master/lobiac/index.md#lobpkg-lobiac-package)
- リソース分離式(RSF: Resource Separated Formula)

## ドキュメント

<div style="width: 1.5em;float: left;padding-left: 1em;">

![Lobiac Logo](./Lobiac_Logo.svg)

</div>

Documents of **Lobiac** Language

<div style="clear: left;padding-left: 1em;"></div>

- Lobiac 言語　トップ: [index.md](https://github.com/FunCobal-family/ChestDD_Language/blob/master/lobiac/index.md)
- Lobiac 言語　仕様書: [spec.md](https://github.com/FunCobal-family/ChestDD_Language/blob/master/lobiac/spec.md)
- 処理系 API リファレンス: THIS!
