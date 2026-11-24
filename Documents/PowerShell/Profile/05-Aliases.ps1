# CD to Zoxide
if (Get-Command z -ErrorAction SilentlyContinue) {
    Remove-Item alias:cd -Force -ErrorAction SilentlyContinue
    Set-Alias -Name cd -Value z
}

# Set editor alias for vim
Set-Alias -Name vim -Value $EDITOR -Force

# Set alias for the Edit-Profile function from 06-Functions.ps1
Set-Alias -Name ep -Value Edit-Profile -Force

# Set alias for the Admin function from 06-Functions.ps1
Set-Alias -Name su -Value admin -Force

# Sets a shorthand alias for the gpush function from 06-Functios.ps1
Set-Alias -Name gp -Value gpush -Force
