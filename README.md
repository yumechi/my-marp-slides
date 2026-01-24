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

1. `src/` 配下に新しいディレクトリを作成
   ```bash
   mkdir src/my-new-slide
   ```

2. ディレクトリ内に `slides.md` を作成

3. ビルドを実行
   ```bash
   ./build.sh my-new-slide
   ```

生成される PDF: `slides/my-new-slide.pdf`

## スライドの書き方

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
