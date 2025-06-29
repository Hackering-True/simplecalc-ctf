for ($i = 0; $i -lt 10; $i++) {
    [console]::beep(500 + ($i * 100), 200)
    Start-Sleep -Milliseconds 100
}
