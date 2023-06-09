if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
	Start-Process PowerShell -Verb RunAs "-NoProfile -ExecutionPolicy Bypass -Command `'cd $pwd`; & '$PSCommandPath';`"";
	exit
}


$process

if ($args.Length -gt 0) {
	$process = $args[0]
}
else {
	$process = Read-Host "Enter process name"
}

$current_path = Get-Location

Get-WmiObject Win32_Process -Filter "name = '$process'" | Select-Object CommandLine | % { $_ | Out-File -Width 10000 -FilePath $current_path\\args.txt -Encoding ascii -Append } | Out-Null