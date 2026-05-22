# Install a moder Powershell
winget install --id Microsoft.PowerShell --source winget

# Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex

# Just go into the UI and turn on the developers mode (Setttings > Update & Security > For Developers > Developer Mode)
sudo Set-ItemProperty 'HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem' -Name 'LongPathsEnabled' -Value 1

# Install some tools with Scoop
scoop install git
git config --global user.name "Scott Stout"
git config --global user.email "scott.stout@framedata.ai"

scoop install dark
scoop intsll innounp
scoop install sudo

scoop checkup
scoop bucket add extras
scoop bucket add nerd-fonts
scoop install extras/obsidian
scoop install main/go `
  nerd-fonts/Meslo-NF `
  nerd-fonts/Meslo-NF-Mono `
  main/kubectx `
  main/k9s `
  extras/mkcert `
  extras/notepadplusplus `
  main/terraform `
  #main/oh-my-posh `
  main/starship ` # I think starship might be better. I'm using this on mac
  main/yq 

 # Manually go into terminal defaults > Apppearance and set the font to MesloLGL NF Mono 

reg import "C:\Users\ScottStout\scoop\apps\7zip\current\install-context.reg"

scoop install uv
scoop install nodejs
#scoop install vscode

# Best to install vscode manuall so it can automatically update
# Best to install Claude manually so it can automatically update

#scoop install 7zip
#scoop install python
#scoop install cmder
#scoop install notepadplusplus
scoop install vscode-python
#scoop install vscode-cpp
#scoop install vscode-go
#scoop install vscode-java
scoop install vscode-docker
scoop install vscode-remote
#scoop install vscode-git
scoop install vscode-markdown
#scoop install vscode-yaml
#scoop install vscode-json
#scoop install vscode-csharp
#scoop install vscode-powershell



# In Terminal - Update the profile to auto-load the config;
notepad $PROFILE

# if that gives and error, create the profile:
New-Item -Path $PROFILE -Type File -Force

# add this to the the file
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\gruvbox.omp.json" | Invoke-Expression
Invoke-Expression (&starship init powershell)