# Hướng dẫn Deploy lên Vercel

## Các bước deploy:

### 1. Cài đặt Vercel CLI (nếu chưa có)
```bash
npm install -g vercel
```

### 2. Đăng nhập Vercel
```bash
vercel login
```

### 3. Deploy từ thư mục gốc của project
```bash
cd /Users/tranvanhuy/Desktop/PDF-To-Excel-Converter
vercel
```

### 4. Làm theo hướng dẫn:
- Chọn project scope (team hoặc personal)
- Link to existing project? → Chọn `N` (tạo project mới) hoặc `Y` (link với project có sẵn)
- Project name → Nhập tên project (hoặc Enter để dùng tên mặc định)
- Directory → Enter (sử dụng thư mục hiện tại)

### 5. Deploy production
```bash
vercel --prod
```

## Lưu ý quan trọng:

1. **Java Runtime**: Tabula-py yêu cầu Java Runtime Environment (JRE). Vercel có thể không hỗ trợ Java mặc định. Bạn có thể cần:
   - Sử dụng build command để cài đặt Java
   - Hoặc xem xét sử dụng thư viện khác không cần Java

2. **Giới hạn thời gian**: Vercel serverless functions có giới hạn:
   - Free plan: 10 giây
   - Pro plan: 60 giây
   - Việc xử lý PDF lớn có thể vượt quá giới hạn này

3. **Kích thước file**: Giới hạn upload là 50MB (đã cấu hình trong code)

4. **Dependencies**: Đảm bảo tất cả dependencies trong `requirements.txt` đều tương thích với Vercel Python runtime

## Kiểm tra sau khi deploy:

1. Truy cập URL được cung cấp bởi Vercel
2. Test upload PDF file nhỏ trước
3. Kiểm tra console logs trên Vercel dashboard nếu có lỗi

## Troubleshooting:

- Nếu gặp lỗi về Java/tabula-py: Có thể cần thay thế tabula-py bằng thư viện khác hoặc sử dụng Vercel với custom build
- Nếu timeout: Cân nhắc upgrade lên Pro plan hoặc tối ưu code xử lý PDF
- Nếu lỗi import: Kiểm tra PYTHONPATH trong vercel.json

