# Remove chat icon from taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "TaskbarMn" -Value 0 -Type DWord -Force

# Remove the "Learn more about this picture" link from desktop background
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{2cc5ca98-6485-489a-920e-b3e88a6ccce3}" -Value 1 -Type DWord -Force

# Remove task view icon from taskbar
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" -Name "ShowTaskViewButton" -Value 0 -Type DWord -Force

# Remove search bar from task bar
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search" -Name "SearchBoxTaskbarMode" -Value 0 -Type DWord -Force

# Enable dark theme
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "SystemUsesLightTheme" -Value 0 -Force
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize" -Name "AppsUseLightTheme" -Value 0 -Force

# Remove Recycle Bin from desktop
Set-ItemProperty -Path "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\HideDesktopIcons\NewStartPanel" -Name "{645FF040-5081-101B-9F08-00AA002F954E}" -Value 1 -Type DWord -Force

# Turn off "Ease Cursor movement between displays" (Requires reboot to take effect)
Set-ItemProperty -Path "HKCU:\Control Panel\Cursors" -Name "CursorDeadzoneJumpingSetting" -Value 0 -Type DWord -Force

# Turn off Sticky Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value 346 -Force

# Turn off Filter Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value 90 -Force

# Turn off Toggle Keys
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value 62 -Force

# Remove Microsoft Store from task bar
((New-Object -Com Shell.Application).NameSpace("shell:::{4234d49b-0245-4df3-b780-3893943456e1}").Items() | ? { $_.Name -eq "Microsoft Store" }).Verbs() | ? { $_.Name.replace('&', '') -match 'Unpin from taskbar' } | % { $_.DoIt(); $exec = $true }

# Restart explorer so changes take effect
Get-Process -Name Explorer | Stop-Process -Force

# Disable ssh-agent service (using 1Password instead)
Set-Service -Name ssh-agent -StartupType Disabled

# Stream Deck (Need to map the config folder to the Stream Deck folder before installing)
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\AppData\Roaming\Elgato\StreamDeck\Audio" -Target "$PWD\config\StreamDeck\Audio" -Force
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\AppData\Roaming\Elgato\StreamDeck\ProfilesV2" -Target "$PWD\config\StreamDeck\ProfilesV2" -Force

# Also need to install the following plugins
# Audio Switcher
# API Request

# Install Dev Applications\Tools
winget install --id Microsoft.PowerShell --silent
winget install --id Microsoft.VisualStudioCode --silent
winget install --id GitHub.cli --silent
winget install --id JanDeDobbeleer.OhMyPosh --silent
winget install --id junegunn.fzf --silent
winget install --id Microsoft.PowerToys --silent
winget install --id ScooterSoftware.BeyondCompare5 --silent
winget install --id Microsoft.AzureDataStudio --silent
winget install --id Postman.Postman
winget install --id CoreyButler.NVMforWindows --silent
winget install --id FocusriteAudioEngineeringLtd.FocusriteControl --silent
winget install --id AgileBits.1Password --silent
winget install --id Guru3D.Afterburner --silent

# Install Gaming Applications
winget install --id Microsoft.Office --silent
winget install --id Discord.Discord --silent
winget install --id Elgato.StreamDeck --silent
winget install --id WhirlwindFX.SignalRgb --silent
winget install --id Valve.Steam --silent
winget install --id Nvidia.GeForceExperience --silent

# Clear desktop of links added during installs
Remove-Item C:\Users\*\Desktop\*lnk

# Refresh Path
$env:Path = [System.Environment]::GetEnvironmentVariable("Path", "Machine") + ";" + [System.Environment]::GetEnvironmentVariable("Path", "User")

# Set up terminal
Install-Module -Name posh-git -Force
Install-Module -Name Terminal-Icons -Force
Install-Module -Name PSFzf -Force

Update-Module

# Install nerd fonts
oh-my-posh.exe font install Hack

# PowerShell
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\Documents\WindowsPowerShell\Profile.ps1" -Target "$PWD\config\PowerShell\Profile.ps1" -Force
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Target "$PWD\config\PowerShell\Microsoft.PowerShell_profile.ps1" -Force

# PowerShell 7
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\Documents\PowerShell\Profile.ps1" -Target "$PWD\config\PowerShell\Profile.ps1" -Force
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\Documents\PowerShell\Microsoft.PowerShell_profile.ps1" -Target "$PWD\config\PowerShell\Microsoft.PowerShell_profile.ps1" -Force

# oh-my-posh
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\Documents\oh-my-posh" -Target "$PWD\config\oh-my-posh" -Force

# Terminal
Move-Item -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Destination "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState.bak" -Force
New-Item -ItemType SymbolicLink -Path "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState" -Target "$PWD\config\Terminal" -Force

# Startup
New-Item -ItemType SymbolicLink -Path "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Startup\startup.cmd" -Target "$PWD\config\startup.cmd" -Force

# Git
New-Item -ItemType SymbolicLink -Path "$env:HOMEPATH\.gitconfig" -Target "$PWD\config\git\.gitconfig" -Force


# SignalRGB Settings
# @echo off
# reg export HKEY_CURRENT_USER\SOFTWARE\WhirlwindFX\SignalRgb SignalRGB_ALL_Backup.reg
# reg export HKEY_CURRENT_USER\SOFTWARE\WhirlwindFX\SignalRgb\layouts SignalRGB_Layout_Backup.reg
# reg export HKEY_CURRENT_USER\SOFTWARE\WhirlwindFX\SignalRgb\devices SignalRGB_Devices_Backup.reg
# reg export HKEY_CURRENT_USER\SOFTWARE\WhirlwindFX\SignalRgb\lighting SignalRGB_Endpoint_Backup.reg
# reg export HKEY_CURRENT_USER\SOFTWARE\WhirlwindFX\SignalRgb\MacroBlocks SignalRGB_MacroBlocks_Backup.reg
# exit