# Hướng dẫn Deploy lên Render bằng CLI

## ⚠️ Lưu ý quan trọng:
Render CLI **KHÔNG hỗ trợ tạo service mới** từ CLI. Bạn cần tạo service qua Dashboard một lần, sau đó dùng CLI để quản lý.

## Bước 1: Tạo Service qua Dashboard (CHỈ CẦN LÀM 1 LẦN)

1. Mở: https://dashboard.render.com
2. Click **"New +"** → **"Web Service"**
3. Kết nối GitHub repo: `tvh25082004/PDF-To-Excel-Converter`
4. Render tự động detect `render.yaml` → Click **"Create Web Service"**
5. Chờ 5-10 phút để build xong

## Bước 2: Đăng nhập CLI

```bash
render login
```

Mở link trong browser và xác thực.

## Bước 3: Kiểm tra đăng nhập

```bash
render whoami
```

## Bước 4: Quản lý Service bằng CLI

### Xem danh sách services:
```bash
render services
```

### Xem logs real-time:
```bash
render logs pdf-to-excel-converter
```

### Restart service:
```bash
render restart pdf-to-excel-converter
```

### Xem thông tin service:
```bash
render services --output json | grep -A 10 "pdf-to-excel"
```

### Deploy lại (sau khi push code mới):
```bash
# Lấy service ID
SERVICE_ID=$(render services --output json | jq -r '.[] | select(.name=="pdf-to-excel-converter") | .id')

# Deploy lại
render deploys create $SERVICE_ID --wait
```

## Tự động deploy sau khi push code:

Render tự động deploy khi bạn push code lên GitHub (nếu đã kết nối repo).

Hoặc trigger deploy thủ công:
```bash
render deploys create <SERVICE_ID> --wait
```

## Troubleshooting:

- **Lỗi "not logged in"**: Chạy `render login` lại
- **Không thấy service**: Đảm bảo đã tạo service qua Dashboard
- **Lỗi build**: Xem logs bằng `render logs <service-name>`
