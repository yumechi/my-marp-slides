#!/bin/bash

# テンプレートから新しいスライドを作成するスクリプト

set -e

TEMPLATE_DIR="src/template-with-fonts"
TARGET_BASE_DIR="src"

# 引数から名前を取得、なければインタラクティブに入力
if [ -n "$1" ]; then
    SLIDE_NAME="$1"
else
    echo "新しいスライドの名前を入力してください:"
    read -r SLIDE_NAME

    # 入力が空の場合
    if [ -z "$SLIDE_NAME" ]; then
        echo "エラー: スライド名が入力されていません"
        exit 1
    fi
fi

TARGET_DIR="${TARGET_BASE_DIR}/${SLIDE_NAME}"

# すでに存在するかチェック
if [ -d "$TARGET_DIR" ]; then
    echo "エラー: ディレクトリ '${TARGET_DIR}' は既に存在します"
    exit 1
fi

# テンプレートの存在確認
if [ ! -d "$TEMPLATE_DIR" ]; then
    echo "エラー: テンプレートディレクトリ '${TEMPLATE_DIR}' が見つかりません"
    exit 1
fi

# テンプレートをコピー
echo "テンプレートをコピー中: ${TEMPLATE_DIR} -> ${TARGET_DIR}"
cp -r "$TEMPLATE_DIR" "$TARGET_DIR"

# README.md を削除（テンプレート用の説明なので不要）
if [ -f "${TARGET_DIR}/README.md" ]; then
    rm "${TARGET_DIR}/README.md"
fi

echo ""
echo "✓ 新しいスライドを作成しました: ${TARGET_DIR}"
echo ""
echo "次のステップ:"
echo "  1. ${TARGET_DIR}/slides.md を編集してスライドを作成"
echo "  2. ./build.sh ${SLIDE_NAME} でPDFを生成"
echo ""
