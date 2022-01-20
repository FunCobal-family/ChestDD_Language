# Lobiac: コンテンツデータ蓄積・発行操作言語

[ChestDD](./../README.md) > Lobiac

Language for Operating BuildUp and Issuing of Accumulated Content-Data

ブログなどにおけるコンテンツのデータ(文書のほか画像、映像など各種リソースファイル)の蓄積にあたってそれらを統合・体系的に管理し、また発行にあたってそれらの処理(HTML 等の生成・出力など)に関する操作をするための言語

ヘッドレスコンテンツ管理システムなどで用いるために策定された。

## 方式

ドキュメントに埋め込むリソースの配置によって 2 種の方式に分れる。

- リソース包含式(RIF: Resource Included Formula): 個別のコンテンツごとにパッケージを構成しポータブル仕様としたもの。詳細は[`.lobpkg`: Lobiac Package](#`.lobpkg`: Lobiac Package)
- リソース分離式(RSF: Resource Separated Formula)

## `.biac`: Lobiac Article

コンテンツの本体となる文書そのものを記述し、管理する。

```biac
<conf>
version: v0.1.0.1
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
res:
  - :kind:obj.ident.to.file1
  - :kind:obj.ident.to.file2
doc.md: egfmd
doc.xml: none
doc.sgml: html
</conf>
<art>
$&md,sgml
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
Ext,Ident,Path,CreateDate,LastModDate
:
:
</Kind>

```

## `.lobpkg`: Lobiac Package

Lobiac Package は以下のディレクトリ構成を zip 圧縮したものであり、`.lobpkg`の拡張子を持つ。

- `root`
  - index.biac
  - assets.ritab
  - `assets`
    - obj.ident.to.file1.ext
    - obj.ident.to.file2.ext
    - obj.ident.to.file3.ext
