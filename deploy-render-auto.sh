#!/bin/bash

# Script tự động deploy lên Render
# Sử dụng: ./deploy-render-auto.sh

set -e

echo "🚀 PDF-To-Excel-Converter - Deploy lên Render"
echo "=============================================="
echo ""

# Kiểm tra đăng nhập
echo "📋 Bước 1: Kiểm tra đăng nhập..."
if render whoami &>/dev/null; then
    echo "✅ Đã đăng nhập!"
    render whoami
else
    echo "❌ Chưa đăng nhập. Đang mở browser..."
    echo "👉 Vui lòng hoàn thành đăng nhập trong browser"
    render login
    if render whoami &>/dev/null; then
        echo "✅ Đăng nhập thành công!"
    else
        echo "❌ Đăng nhập thất bại. Vui lòng thử lại."
        exit 1
    fi
fi

echo ""
echo "📦 Bước 2: Kiểm tra services..."
SERVICES=$(render services --output json 2>/dev/null || echo "[]")

if echo "$SERVICES" | grep -q "pdf-to-excel-converter"; then
    echo "✅ Đã tìm thấy service: pdf-to-excel-converter"
    SERVICE_ID=$(echo "$SERVICES" | jq -r '.[] | select(.name=="pdf-to-excel-converter") | .id' 2>/dev/null || echo "")
    
    if [ -n "$SERVICE_ID" ]; then
        echo "🔄 Đang deploy lại service..."
        render deploys create "$SERVICE_ID" --wait
        echo "✅ Deploy thành công!"
    else
        echo "⚠️  Không tìm thấy service ID. Vui lòng kiểm tra trên Dashboard."
    fi
else
    echo "⚠️  Chưa có service 'pdf-to-excel-converter'"
    echo ""
    echo "📝 Hướng dẫn tạo service:"
    echo "1. Mở: https://dashboard.render.com"
    echo "2. Click 'New +' → 'Web Service'"
    echo "3. Kết nối repo: tvh25082004/PDF-To-Excel-Converter"
    echo "4. Render tự động detect render.yaml"
    echo "5. Click 'Create Web Service'"
    echo ""
    echo "Sau khi tạo service, chạy lại script này để deploy tự động."
fi

echo ""
echo "📊 Xem logs:"
echo "   render logs pdf-to-excel-converter"
echo ""
echo "🔄 Restart service:"
echo "   render restart pdf-to-excel-converter"
echo ""

