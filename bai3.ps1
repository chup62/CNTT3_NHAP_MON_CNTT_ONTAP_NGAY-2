# Tác giả: Nguyễn Trung Thành
# Ngày tạo: 21/10/2026

$inputFile = "logs\payment.log"
$outputFile = "logs\warning_report.txt"

# Đọc file payment.log, lọc dòng chứa WARNING và ghi vào warning_report.txt
Select-String -Path $inputFile -Pattern "WARNING" | Out-File -FilePath $outputFile

Write-Host "Da loc xong WARNING va luu vao $outputFile"