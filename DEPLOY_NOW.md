# 🚀 HƯỚNG DẪN DEPLOY NGAY - LẤY LINK WEB

## ⚡ CÁCH NHANH NHẤT (Railway - Khuyến nghị)

### Bước 1: Đăng nhập Railway (CHỈ CẦN LÀM 1 LẦN)
```bash
cd /Users/tranvanhuy/Desktop/PDF-To-Excel-Converter
railway login
```
→ Mở browser và đăng nhập bằng GitHub

### Bước 2: Chạy script tự động deploy
```bash
python3 auto-deploy.py
```

**HOẶC** chạy thủ công:
```bash
railway init --name pdf-to-excel-converter
railway up
railway domain
```

→ **Link web sẽ hiển thị ngay!**

---

## 🌐 CÁCH 2: Deploy qua Render Dashboard (Không cần CLI)

### Bước 1: Truy cập Render
1. Vào: https://render.com
2. Đăng nhập bằng GitHub

### Bước 2: Tạo Web Service
1. Click **"New +"** → **"Web Service"**
2. Chọn repo: `TsvetanG2/PDF-To-Excel-Converter`
3. Render tự động detect `render.yaml`
4. Click **"Create Web Service"**
5. Chờ 5-10 phút

### Bước 3: Lấy link
→ Link sẽ có dạng: `https://pdf-to-excel-converter.onrender.com`

---

## 📋 TÓM TẮT CÁC FILE ĐÃ CHUẨN BỊ:

✅ `render.yaml` - Cấu hình Render  
✅ `railway.json` - Cấu hình Railway  
✅ `ConverterApp/Procfile` - Lệnh start  
✅ `ConverterApp/requirements.txt` - Dependencies (đã có gunicorn)  
✅ `auto-deploy.py` - Script tự động deploy  
✅ `deploy.sh` - Script shell deploy  

---

## 🎯 KHUYẾN NGHỊ:

**Railway** - Nhanh nhất, có CLI tốt, free tier tốt  
**Render** - Ổn định, tự động detect config, free tier tốt  

**Bạn muốn dùng cách nào?**

