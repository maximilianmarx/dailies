# dailies
Repository containing useful scripts for daily usage saving some time.

## amsi-bypass.ps1
This script is able to bypass AMSI (Anti Malware Scan Interface) on a recent Windows 10 installation (20.08.2021).
It was influenced by Rasta-Mouse's C# implementation https://github.com/rasta-mouse/AmsiScanBufferBypass/blob/main/AmsiBypass.cs.
To evade Defense solutions we're not accessing AmsiScanBuffer directly, but instead through DllGetObjectClass and an offset.

You can calculate the offset using DLL Export Viewer and opening amsi.dll, as shown in the image below:
![image](https://user-images.githubusercontent.com/49280556/130318160-fad781bd-3a0f-4a6f-bc2e-d7e850637c12.png)

PoC (click to enlarge):

<img src="https://user-images.githubusercontent.com/49280556/130318266-4b08c4a6-e22e-46db-bc81-eefd35c1d5ed.png" width="700">

```powershell
. .\amsi-bypass.ps1
```

## ua-select.py
This script picks a random User-Agent. Too many tools use their own user agent which are commonly known by various IDS / WAF.
Why wasting one minute using your favorite search engine, when this script does the job?

```python
python ua-select.py
```
