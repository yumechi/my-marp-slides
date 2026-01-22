# Marp Slides プロジェクト

Marp CLI を使用してMarkdownからPDFスライドを生成するプロジェクトです。

## プロジェクト構成

```
my-marp-slides/
├── CLAUDE.md          # このファイル
├── README.md          # プロジェクト概要
├── Containerfile      # Podman用コンテナ定義
├── build.sh           # ビルドスクリプト
├── .gitignore         # Git除外設定
└── slides/            # スライドディレクトリ
    └── {slide-name}/  # 各スライド用ディレクトリ
        └── slide.md   # スライドのMarkdownファイル
```

## スライドの作成方法

1. `slides/` 配下に新しいディレクトリを作成
2. ディレクトリ内にMarkdownファイル（例: `slide.md`）を作成
3. Marp形式でスライドを記述

### Markdownファイルのテンプレート

```markdown
---
marp: true
theme: default
paginate: true
---

# タイトル

内容

---

## 次のスライド

- ポイント1
- ポイント2
```

## ビルド方法

### 前提条件

- Podman がインストールされていること

### 全スライドをビルド

```bash
./build.sh
```

各スライドディレクトリ内にPDFファイルが生成されます。

## 注意事項

- PDFファイル（`*.pdf`）はGit管理対象外です
- 各スライドは独立したディレクトリで管理してください
- Markdownファイル名がそのままPDFファイル名になります
