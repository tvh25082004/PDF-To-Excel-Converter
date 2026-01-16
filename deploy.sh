#!/bin/bash

echo "🚀 Bắt đầu deploy PDF-To-Excel-Converter lên Railway..."
echo ""

# Kiểm tra Railway CLI
if ! command -v railway &> /dev/null; then
    echo "❌ Railway CLI chưa được cài đặt. Đang cài đặt..."
    npm install -g @railway/cli
fi

# Kiểm tra đăng nhập
echo "📋 Kiểm tra đăng nhập Railway..."
if ! railway whoami &> /dev/null; then
    echo "⚠️  Chưa đăng nhập Railway. Vui lòng chạy: railway login"
    echo "   Sau đó chạy lại script này."
    exit 1
fi

echo "✅ Đã đăng nhập Railway"
echo ""

# Tạo project mới hoặc link với project có sẵn
echo "🔧 Đang tạo/link Railway project..."
railway init --name pdf-to-excel-converter || railway link

# Deploy
echo "📦 Đang deploy..."
railway up

echo ""
echo "✅ Deploy hoàn tất!"
echo "🌐 Lấy URL của service..."
railway domain

echo ""
echo "🎉 Hoàn thành! Truy cập URL ở trên để sử dụng ứng dụng."

