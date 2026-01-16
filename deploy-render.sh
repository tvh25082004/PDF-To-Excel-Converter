#!/bin/bash

# Script deploy lên Render
# Sử dụng: ./deploy-render.sh

echo "🚀 Bắt đầu deploy lên Render..."

# Kiểm tra đã login chưa
echo "📋 Kiểm tra đăng nhập..."
if ! render whoami &>/dev/null; then
    echo "❌ Chưa đăng nhập. Đang mở browser để đăng nhập..."
    render login
    echo "✅ Đã đăng nhập thành công!"
else
    echo "✅ Đã đăng nhập!"
    render whoami
fi

echo ""
echo "📦 Kiểm tra services hiện có..."
render services

echo ""
echo "📝 Hướng dẫn:"
echo "1. Nếu chưa có service, vào: https://dashboard.render.com"
echo "2. Click 'New +' → 'Web Service'"
echo "3. Kết nối repo: tvh25082004/PDF-To-Excel-Converter"
echo "4. Render sẽ tự động detect render.yaml"
echo "5. Click 'Create Web Service'"
echo ""
echo "Sau khi tạo service, bạn có thể:"
echo "- Xem logs: render logs <service-name>"
echo "- Restart: render restart <service-name>"
echo "- Deploy lại: render deploys create <service-id> --wait"
echo ""

