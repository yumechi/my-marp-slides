# Marp スライドテンプレート（フォント設定あり）

このテンプレートは Noto Sans CJK JP フォントを使用した Marp スライドのテンプレートです。

## 使い方

1. このディレクトリをコピーして新しいスライドを作成します

```bash
cp -r src/template-with-fonts src/your-slide-name
```

2. `src/your-slide-name/slides.md` を編集してスライドを作成します

3. PDF を生成します

```bash
./build.sh your-slide-name
```

## ファイル構成

- `slides.md` - スライドの Markdown ソース
- `assets/custom.css` - カスタムテーマとフォント設定

## フォント設定

このテンプレートでは以下のフォントが設定されています：

- **本文・見出し**: Noto Sans CJK JP
- **コードブロック**: Noto Sans Mono CJK JP

フォントは `assets/custom.css` で設定されています。

## SNS ID 表示機能

h1 見出しがないページでは、右下に SNS ID が自動的に表示されます。

### 設定方法

フロントマターの `footer` で SNS ID を設定します：

```markdown
---
marp: true
theme: custom-gaia
paginate: true
footer: "X: @your_username"
---
```

### 動作

- **h1 があるページ**（タイトルスライドなど）: SNS ID は非表示
- **h1 がないページ**（本文スライド）: 右下に SNS ID を表示

### 特定スライドで非表示にする

コンテンツが多いスライドなど、SNS ID を非表示にしたい場合は、そのスライドに以下を追加します：

```markdown
<!-- _footer: "" -->
```

例：

```markdown
---

<!-- _footer: "" -->

## コンテンツが多いスライド

（内容がいっぱいのスライド...）
```

## ライセンス情報

スライドの最後に含まれているライセンス情報は削除しないでください：

- **Noto Sans CJK JP** - SIL Open Font License 1.1
- **Marp** - MIT License
