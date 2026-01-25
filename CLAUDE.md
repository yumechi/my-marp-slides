# Marp Slides プロジェクト

Marp CLI と Podman を使用して Markdown から PDF スライドを生成するプロジェクトです。

実行方法については [README.md](README.md) を参照してください。

## ファイル構成

| ファイル | 説明 |
|---------|------|
| `README.md` | 使い方・実行コマンド |
| `CLAUDE.md` | このファイル（プロジェクト構成情報） |
| `build.sh` | Podman を使った PDF 生成スクリプト |
| `create.sh` | テンプレートから新しいスライドを作成するスクリプト |
| `Containerfile` | 日本語フォント付きカスタムコンテナイメージ定義 |
| `.gitignore` | Git 除外設定 |
| `src/` | Markdown ソースディレクトリ（Git 管理対象） |
| `slides/` | PDF 出力ディレクトリ（Git 管理対象外） |

## ディレクトリ構造

```
src/
└── {slide-name}/
    ├── slides.md      # ソースファイル（固定名）
    └── assets/        # アセットディレクトリ
        ├── custom.css # カスタムスタイル
        └── *.png      # 画像ファイルなど

slides/
└── {slide-name}.pdf   # 生成される PDF
```

## 注意事項

- `slides/*.pdf` は Git 管理対象外
