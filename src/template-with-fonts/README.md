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

## ライセンス情報

スライドの最後に含まれているライセンス情報は削除しないでください：

- **Noto Sans CJK JP** - SIL Open Font License 1.1
- **Marp** - MIT License
