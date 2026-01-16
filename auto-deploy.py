#!/usr/bin/env python3
"""
Script tự động deploy lên Railway
Chạy script này sau khi đã đăng nhập Railway một lần
"""

import subprocess
import sys
import os

def run_command(cmd, check=True):
    """Chạy lệnh shell và trả về output"""
    try:
        result = subprocess.run(cmd, shell=True, capture_output=True, text=True, check=check)
        return result.stdout.strip(), result.stderr.strip(), result.returncode
    except subprocess.CalledProcessError as e:
        return e.stdout.strip(), e.stderr.strip(), e.returncode

def main():
    print("🚀 Bắt đầu deploy tự động lên Railway...")
    print("=" * 60)
    
    # Kiểm tra Railway CLI
    print("\n1️⃣ Kiểm tra Railway CLI...")
    stdout, stderr, code = run_command("which railway", check=False)
    if code != 0:
        print("   ⚠️  Railway CLI chưa được cài đặt. Đang cài đặt...")
        stdout, stderr, code = run_command("npm install -g @railway/cli")
        if code != 0:
            print(f"   ❌ Lỗi cài đặt: {stderr}")
            sys.exit(1)
        print("   ✅ Đã cài đặt Railway CLI")
    else:
        print(f"   ✅ Railway CLI đã được cài đặt tại: {stdout}")
    
    # Kiểm tra đăng nhập
    print("\n2️⃣ Kiểm tra đăng nhập Railway...")
    stdout, stderr, code = run_command("railway whoami", check=False)
    if code != 0:
        print("   ⚠️  Chưa đăng nhập Railway!")
        print("   📝 Vui lòng chạy lệnh sau để đăng nhập:")
        print("      railway login")
        print("   Sau đó chạy lại script này.")
        sys.exit(1)
    print(f"   ✅ Đã đăng nhập: {stdout}")
    
    # Chuyển vào thư mục project
    os.chdir("/Users/tranvanhuy/Desktop/PDF-To-Excel-Converter")
    
    # Kiểm tra xem đã link project chưa
    print("\n3️⃣ Kiểm tra Railway project...")
    stdout, stderr, code = run_command("railway status", check=False)
    if code != 0 or "No project linked" in stdout:
        print("   📦 Chưa có project. Đang tạo project mới...")
        stdout, stderr, code = run_command("railway init --name pdf-to-excel-converter", check=False)
        if code != 0:
            print("   ⚠️  Không thể tạo project tự động. Vui lòng chạy:")
            print("      railway init")
            print("   Hoặc link với project có sẵn:")
            print("      railway link")
            sys.exit(1)
        print("   ✅ Đã tạo project mới")
    else:
        print("   ✅ Đã link với project")
    
    # Deploy
    print("\n4️⃣ Đang deploy code lên Railway...")
    stdout, stderr, code = run_command("railway up", check=False)
    if code != 0:
        print(f"   ⚠️  Có lỗi khi deploy: {stderr}")
        print("   Thử deploy lại thủ công với: railway up")
    else:
        print("   ✅ Deploy thành công!")
    
    # Lấy URL
    print("\n5️⃣ Lấy URL của service...")
    stdout, stderr, code = run_command("railway domain", check=False)
    if code == 0 and stdout:
        print(f"\n{'='*60}")
        print("🎉 DEPLOY THÀNH CÔNG!")
        print(f"{'='*60}")
        print(f"\n🌐 URL của bạn: {stdout}")
        print(f"\n📝 Hoặc kiểm tra trên Railway Dashboard:")
        print("   https://railway.app/dashboard")
        print(f"\n{'='*60}")
    else:
        print("   ⚠️  Không thể lấy URL tự động.")
        print("   Vui lòng kiểm tra trên Railway Dashboard:")
        print("   https://railway.app/dashboard")
        print("   Hoặc chạy: railway domain")

if __name__ == "__main__":
    main()

