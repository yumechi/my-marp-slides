# my-marp-slides

Marp CLI を使用して Markdown から PDF スライドを生成するプロジェクトです。

## 前提条件

- Podman がインストールされていること

## 使い方

### スライドのビルド

```bash
# 特定のスライドをビルド
./build.sh <ディレクトリ名>

# 例
./build.sh sample
```

### 利用可能なスライド一覧を表示

```bash
./build.sh
```

### 新しいスライドの作成

1. `slides/` 配下に新しいディレクトリを作成（パーミッション 777）
   ```bash
   mkdir -m 777 slides/my-new-slide
   ```

2. ディレクトリ内に `slides.md` を作成

3. ビルドを実行
   ```bash
   ./build.sh my-new-slide
   ```

生成される PDF: `slides/my-new-slide/my-new-slide.pdf`

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
