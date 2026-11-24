if ($host.Name -eq 'ConsoleHost') {
	if (Get-Module -ListAvailable -Name PSReadLine) {
		Import-Module PSReadLine
	}
}

if (Get-Module -ListAvailable -Name Terminal-Icons) {
	Import-Module Terminal-Icons
}

if (Get-Command starship -ErrorAction SilentlyContinue) {
	Invoke-Expression (&starship init powershell)
}

if (Get-Module -ListAvailable -Name posh-git) {
	Import-Module posh-git
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
	Invoke-Expression (& { (zoxide init powershell | Out-String) })
}
