Add-Type -AssemblyName System.Speech
$Speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$Speak.Speak("Haha! Your PC is being haunted by HackeringTrue.")
Start-Sleep -Seconds 1
[console]::beep(1000, 500)
[console]::beep(800, 500)
[console]::beep(600, 500)
Add-Type -AssemblyName PresentationFramework
[System.Windows.MessageBox]::Show('Windows has detected suspicious behavior.', 'Warning', 'OK', 'Error')
