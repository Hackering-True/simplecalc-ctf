Add-Type -AssemblyName System.Speech
$speak = New-Object System.Speech.Synthesis.SpeechSynthesizer
$compliments = @(
    "You look amazing today!",
    "Your code is bug-free... for now.",
    "Keep being awesome!",
    "Did someone say coffee? You deserve one."
)
while ($true) {
    $msg = Get-Random $compliments
    $speak.Speak($msg)
    Start-Sleep -Seconds 10
}
