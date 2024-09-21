# File for Current User, All Hosts - $PROFILE.CurrentUserAllHosts

# Show path to executable
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
    Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Modules
Import-Module Terminal-Icons
Import-Module posh-git

# PSReadLine
Set-PSReadLineOption -BellStyle None
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -PredictionViewStyle ListView

# PSFzf
Set-PSFzfOption -PSReadLineChordProvider 'Ctrl+f' -PSReadLineChordReverseHistory 'Ctrl+r'

oh-my-posh init pwsh --config "$HOME/Documents/oh-my-posh/prompt.omp.json" | Invoke-Expression
