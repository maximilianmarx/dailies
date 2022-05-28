$pass = ConvertTo-SecureString 'PasswordPlaceholder' -AsPlainText -Force

$cred = New-Object System.Management.Automation.PSCredential('UsernamePlaceholder', $pass)

New-PSDrive -Name 0wn3d -PSProvider FileSystem -Credential $cred -Root \\10.10.15.79\SomeShare

cd 0wn3d:

dir
