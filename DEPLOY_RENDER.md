# Hướng dẫn Deploy lên Render

## Render là gì?
Render là một platform cloud hiện đại, **TỐT HƠN Vercel** cho Flask app xử lý file vì:
- ✅ **Không giới hạn timeout** như serverless (Vercel chỉ có 10-60s)
- ✅ **Hỗ trợ Python/Flask tốt** với persistent storage
- ✅ **Free tier tốt** cho thử nghiệm
- ✅ **Xử lý file upload/download tốt** - phù hợp với app convert PDF sang Excel
- ✅ **Deploy tự động từ GitHub**

## Các bước deploy:

### 1. Đăng ký tài khoản Render (MIỄN PHÍ)
- Truy cập: https://render.com
- Đăng ký bằng GitHub account (khuyến nghị) hoặc email

### 2. Tạo Web Service mới

1. Vào Dashboard → Click **"New +"** → Chọn **"Web Service"**
2. Kết nối GitHub repository: `TsvetanG2/PDF-To-Excel-Converter`
3. Cấu hình:
   - **Name**: `pdf-to-excel-converter` (hoặc tên bạn muốn)
   - **Region**: Chọn gần nhất (Singapore hoặc US)
   - **Branch**: `main`
   - **Root Directory**: Để trống (hoặc `ConverterApp` nếu cần)
   - **Runtime**: `Python 3`
   - **Build Command**: `pip install -r ConverterApp/requirements.txt`
   - **Start Command**: `cd ConverterApp && gunicorn pdftoexcel:app --bind 0.0.0.0:$PORT`
   - **Environment Variables**: 
     - `PYTHON_VERSION` = `3.11.0`
     - `PORT` = `10000` (Render tự động set)

4. Chọn **Free** plan (hoặc Starter nếu muốn)
5. Click **"Create Web Service"**

### 3. Chờ deploy hoàn tất
- Render sẽ tự động build và deploy
- Thời gian: khoảng 5-10 phút lần đầu
- Bạn sẽ nhận được URL: `https://pdf-to-excel-converter.onrender.com`

### 4. Test ứng dụng
- Truy cập URL được cung cấp
- Upload file PDF test
- Kiểm tra convert và download Excel

## Lưu ý quan trọng:

### ⚠️ Về Java Runtime (tabula-py):
Tabula-py yêu cầu Java. Render có thể không có Java mặc định. Có 2 cách:

**Cách 1: Thêm Java vào build (Khuyến nghị)**
Thêm vào `render.yaml`:
```yaml
buildCommand: |
  apt-get update && apt-get install -y default-jre
  pip install -r ConverterApp/requirements.txt
```

**Cách 2: Sử dụng thư viện khác không cần Java**
- Thay tabula-py bằng pdfplumber (đã có sẵn)
- Hoặc camelot-py (cần Ghostscript)

### 📁 File Storage:
- Render sử dụng **ephemeral storage** (mất khi restart)
- File upload được lưu vào `/tmp` (tempfile)
- File sẽ tự động xóa sau khi download

### 💰 Pricing:
- **Free tier**: 
  - App ngủ sau 15 phút không dùng
  - Startup mất ~30s khi có request đầu tiên
  - Đủ cho demo và test
- **Starter ($7/tháng)**: 
  - App luôn chạy
  - Không bị ngủ
  - Phù hợp production

## Troubleshooting:

1. **Lỗi Java/tabula-py**: 
   - Xem phần "Về Java Runtime" ở trên
   - Hoặc comment out phần sử dụng tabula-py

2. **Timeout khi convert PDF lớn**:
   - Upgrade lên Starter plan
   - Hoặc tối ưu code xử lý

3. **Lỗi import module**:
   - Kiểm tra `requirements.txt` đã đầy đủ
   - Kiểm tra đường dẫn trong code

4. **Static files không load**:
   - Kiểm tra `static_folder` trong Flask app
   - Đảm bảo file CSS/JS trong đúng thư mục

## So sánh với Vercel:

| Tính năng | Render | Vercel |
|-----------|--------|--------|
| Timeout limit | Không giới hạn | 10-60s |
| File processing | ✅ Tốt | ⚠️ Hạn chế |
| Python/Flask | ✅ Hỗ trợ tốt | ⚠️ Serverless only |
| Free tier | ✅ Có (ngủ khi không dùng) | ✅ Có |
| Production | ✅ Phù hợp | ⚠️ Hạn chế |

**Kết luận: Render phù hợp hơn cho app này!**

