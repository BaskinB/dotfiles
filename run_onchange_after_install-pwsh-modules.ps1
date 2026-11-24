$modules = @(
    'PSReadLine'
    'posh-git'
    'Terminal-Icons'
    'z'
)

foreach ($m in $modules) {
    if (-not (Get-Module -ListAvailable -Name $m)) {
        Write-Host "Installing $m..."
        Install-Module -Name $m -Scope CurrentUser -Force -AcceptLicense
    }
}
