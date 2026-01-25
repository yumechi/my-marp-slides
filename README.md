# my-marp-slides

Marp CLI を使用して Markdown から PDF スライドを生成するプロジェクトです。

## 前提条件

- Podman がインストールされていること

## 使い方

### スライドのビルド

```bash
# 特定のスライドをビルド
./build.sh <スライド名>

# 例
./build.sh sample
```

### 利用可能なスライド一覧を表示

```bash
./build.sh
```

### 新しいスライドの作成

テンプレートから新しいスライドを作成します（フォント設定とライセンス情報が含まれます）。

```bash
# スライド名を引数で指定
./create.sh my-new-slide

# または、引数なしで実行して対話的に入力
./create.sh
```

作成後、以下の手順で編集・ビルドします：

1. `src/my-new-slide/slides.md` を編集してスライドを作成

2. ビルドを実行
   ```bash
   ./build.sh my-new-slide
   ```

生成される PDF: `slides/my-new-slide.pdf`

## スライドの書き方

### 基本構造

```markdown
---
marp: true
theme: custom-gaia
paginate: true
footer: "X: @your_id"
---

# プレゼンテーションタイトル
## (2026/01/25 勉強会の名前) あなたの名前

---

## 通常スライド

- 箇条書きリスト
- Noto Sans CJK JP フォントが適用されます

---

# 強調スライド

<!-- h1 のみのスライドは自動的に中央配置されます -->
```

### スライドの種類

| 種類 | 書き方 | 特徴 |
|------|--------|------|
| タイトルスライド | `# タイトル` + `## サブタイトル` | 中央配置、footer 非表示 |
| 強調スライド | `# メッセージ` のみ | 中央配置 |
| 通常スライド | `## 見出し` + 本文 | 左揃え、footer 表示 |

### ディレクティブ

特定のスライドで footer やページ番号を非表示にする場合:

```markdown
<!-- _footer: "" -->
<!-- _paginate: false -->

# このスライドは footer とページ番号が非表示
```

## ライセンス

### プロジェクト本体

このプロジェクト（ビルドスクリプト、設定ファイル等）は [MIT License](LICENSE) の下で公開されています。

### 生成されるスライド

生成されるPDFスライドには、以下のライセンスが適用されるコンポーネントが含まれています:

- **フォント**: Noto Sans CJK ([SIL Open Font License 1.1](https://github.com/notofonts/noto-cjk/blob/main/Sans/LICENSE))
  - 商用・非商用問わず自由に使用可能
  - ドキュメント（PDF）への埋め込み可能
  - フォント単体での販売は不可

### 使用技術のライセンス

- **Marp CLI**: [MIT License](https://github.com/marp-team/marp-cli)
- **Podman**: [Apache License 2.0](https://github.com/containers/podman/blob/main/LICENSE) (ビルドツールとして使用)
