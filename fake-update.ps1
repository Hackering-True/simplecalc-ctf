Add-Type -AssemblyName PresentationFramework
$window = New-Object Windows.Window
$window.WindowStyle = "None"
$window.WindowState = "Maximized"
$window.Topmost = $true
$window.Background = "Black"

$textBlock = New-Object Windows.Controls.TextBlock
$textBlock.Text = "Installing Windows Updates 0% Complete. Do not turn off your computer."
$textBlock.Foreground = "White"
$textBlock.FontSize = 48
$textBlock.VerticalAlignment = "Center"
$textBlock.HorizontalAlignment = "Center"
$window.Content = $textBlock

$window.ShowDialog() | Out-Null