$ModuleConfigPath = Join-Path (Split-Path -Parent $PROFILE) "Profile"

if (Test-Path $ModuleConfigPath) {
	$ConfigFiles = Get-ChildItem -Path $ModuleConfigPath -Filter *.ps1 -File | Sort-Object Name

	foreach ($File in $ConfigFiles){
		. $File.FullName
	}
}
