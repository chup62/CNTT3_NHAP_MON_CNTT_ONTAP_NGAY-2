# BÀI LÀM – ÔN TẬP NGÀY 2

- **Họ tên:** Nguyễn Trung Thành
- **Hệ điều hành (Windows/macOS):** Windows

## Bài 1. Lọc log thủ công

```powershell
Get-Content logs/access.log | Select-String "ERROR" > logs/error_report.txt
Get-Content logs/error_report.txt
```

2 dòng lỗi đầu tiên:

```text
2025-10-18 08:17:59 [ERROR] Khong tim thay trang /lich-thi (404)
2025-10-18 08:25:55 [ERROR] Het thoi gian cho (timeout)
```

## Bài 2. Đếm bằng pipeline

```powershell
Get-Content logs/access.log | Select-String "WARNING" | Measure-Object
Get-Content logs/payment.log | Select-String "ERROR" | Measure-Object
```

Kết quả:

```text
Số dòng WARNING trong access.log: 4
Số dòng ERROR trong payment.log: 3
```

## Bài 3. Hoàn thiện script
.\bai3.ps1
logs\payment.log:4:2025-10-18 09:19:13 [WARNING] Cong thanh toan phan hoi cham
logs\payment.log:7:2025-10-18 09:28:16 [WARNING] Nhieu lan nhap sai ma OTP
logs\payment.log:12:2025-10-18 09:43:01 [WARNING] So du vi gan bang hoc phi
logs\payment.log:13:2025-10-18 09:46:22 [WARNING] So du vi gan bang hoc phi
logs\payment.log:14:2025-10-18 09:49:43 [WARNING] So du vi gan bang hoc phi
File `auto_warning.ps1`:

```powershell
# Script: auto_warning.ps1
# Tac gia: NGUYEN TRUNG THANH
# Ngay tao: 2026-10-21

Write-Host "Dang loc canh bao thanh toan..."

"=== CANH BAO THANH TOAN ===" > logs/warning_report.txt
Get-Content logs/payment.log | Select-String "WARNING" >> logs/warning_report.txt

Write-Host "Hoan thanh!"
```

Lệnh chạy (từ thư mục gốc):

```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\auto_warning.ps1
Get-Content logs/warning_report.txt
```

Nội dung `logs/warning_report.txt`:

```text
(chưa có payment.log, điền sau)
```

## Bài 4. Báo cáo tổng hợp

```powershell
"=== TONG HOP ACCESS LOG ===" > logs/tong_hop_ngay2.txt
Get-Content logs/access.log | Select-String "ERROR" >> logs/tong_hop_ngay2.txt
(Get-Content logs/payment.log | Select-String "WARNING").Count >> logs/tong_hop_ngay2.txt
Get-Content logs/tong_hop_ngay2.txt
```

Nội dung `logs/tong_hop_ngay2.txt`:

```text
=== TONG HOP ACCESS LOG ===
2025-10-18 08:17:59 [ERROR] Khong tim thay trang /lich-thi (404)
2025-10-18 08:25:55 [ERROR] Het thoi gian cho (timeout)
2025-10-18 08:33:51 [ERROR] Ket noi may chu du lieu that bai
2025-10-18 08:37:19 [ERROR] Ket noi may chu du lieu that bai
2025-10-18 08:49:43 [ERROR] Het thoi gian cho (timeout)
2025-10-18 08:53:11 [ERROR] Het thoi gian cho (timeout)
2025-10-18 08:53:11 [ERROR] Het thoi gian cho (timeout)
5
```

## Bài 5. Câu hỏi ngắn

**a)** `>` ghi đè: xóa nội dung cũ của file (hoặc tạo file mới) rồi ghi nội dung mới. `>>` ghi nối: giữ nội dung cũ và thêm nội dung mới vào cuối file.

**b)** Dòng tiêu đề `=== TONG HOP ACCESS LOG ===` bị xóa, file chỉ còn các dòng ERROR. Sau đó lệnh thứ ba (dùng `>>`) vẫn thêm số đếm WARNING vào cuối.

**c)** Đường dẫn tương đối không phụ thuộc cấu trúc thư mục của một máy cụ thể, nên script chạy được trên máy khác hoặc khi thư mục dự án bị di chuyển, miễn là chạy từ thư mục gốc. Đường dẫn tuyệt đối như `C:/Users/An/Desktop/...` chỉ đúng trên máy của An, sang máy khác sẽ báo không tìm thấy file.