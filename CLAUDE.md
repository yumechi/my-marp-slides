# Marp Slides プロジェクト

Marp CLI と Podman を使用して Markdown から PDF スライドを生成するプロジェクトです。

実行方法については [README.md](README.md) を参照してください。

## ファイル構成

| ファイル | 説明 |
|---------|------|
| `README.md` | 使い方・実行コマンド |
| `CLAUDE.md` | このファイル（プロジェクト構成情報） |
| `build.sh` | Podman を使った PDF 生成スクリプト |
| `.gitignore` | Git 除外設定 |
| `slides/` | スライド出力ディレクトリ（内容は Git 管理対象外） |

## ディレクトリ構造

```
slides/
└── {slide-name}/      # 各スライド用ディレクトリ (777)
    ├── slides.md      # ソースファイル（固定名）
    └── {slide-name}.pdf  # 生成される PDF
```

## 注意事項

- `slides/` 配下の `*.md` と `*.pdf` は Git 管理対象外
- 新規ディレクトリ作成時はパーミッション 777 を設定
