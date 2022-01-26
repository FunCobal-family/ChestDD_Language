# Lobiac: コンテンツデータ蓄積・発行操作言語

[ChestDD](./../README.md) > Lobiac

Language for Operating BuildUp and Issuing of Accumulated Content-Data

ブログなどにおけるコンテンツのデータ(文書のほか画像、映像など各種リソースファイル)の蓄積にあたってそれらを統合・体系的に管理し、また発行にあたってそれらの処理(HTML 等の生成・出力など)に関する操作をするための言語

ヘッドレスコンテンツ管理システムなどで用いるために策定された。

仕様書は[Specifications of Lobiac](./spec.md)を参照。

## 方式

ドキュメントに埋め込むリソースの配置によって 3 種の方式に分れる。

- リソース包含式(RIF: Resource Included Formula): biac ファイルにリソースデータも共に埋め込み記述したもの。
- リソース梱束式(RPF: Resource Packaging Formula):個別のコンテンツごとにパッケージを構成しポータブル仕様としたもの。
- リソース分離式(RSF: Resource Separated Formula):biac ファイルとリソースファイルが別の場所にあるもの。サーバなどで用いる。

## `.biac`: Lobiac Article

コンテンツの本体となる文書そのものを記述し、管理する。

```biac
<conf>
version: v0.1.0.1
foml: RPF
title.main: Main Title
title.sub: SubTitle
title.serial: Ident of Series
tag:
  - tag1
  - tag2
  - tag3
author:
  - Author1
  - Author2
  - Author3
org: OrgName
div: Name Of Division
date.create: timestamp1
date.modified:
  - hash1: timestamp1
  - hash2: timestamp2
  - hash3: timestamp3
res.table: ./assets.ritab
res.use:
  - :kind:obj.ident.to.file1
  - :kind:obj.ident.to.file2
doc.md: egfmd
doc.xml: none
doc.sgml: html
</conf>
<art>
$&lang[md]
- line
.hash1:# title
- line
.hash1:- list
- line
.hash1:- list
.hash2:- list-2r
- line
.hash1:## chapter
.hash1:### section
- line
.hash3:### section
$end
</art>
```

## `.ritab`: Resource Index Table

```ritab
<Kind>
{|tab ritab|}
! Kind | Ext | Ident | Path | CreateDate | LastModDate |
| txt | svg | obj.ident.to.file1 | actual.path.to.file1.svg | 2022-1-25 11:5:24 | 2022-1-26 14:26:24 |
| bin | png | obj.ident.to.file2 | actual.path.to.file2.png | 2022-1-23 12:5:04 | 2022-1-23 12:26:31 |
| bin | pdf | obj.ident.to.file3 | actual.path.to.file3.pdf | 2021-5-25 11:5:58 | 2021-12-21 16:45:10 |
{|endtab|}
</Kind>
```

## `.lobpkg`: Lobiac Package

Lobiac Package は以下のディレクトリ構成を zip 圧縮したものであり、`.lobpkg`の拡張子を持つ。

- `root`
  - index.biac
  - assets.ritab
  - `assets`
    - actual.path.to.file1.ext
    - actual.path.to.file2.ext
    - actual.path.to.file3.ext
