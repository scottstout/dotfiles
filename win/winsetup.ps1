# Install a moder Powershell
winget install --id Microsoft.PowerShell --source winget

# Install Scoop
Set-ExecutionPolicy RemoteSigned -Scope CurrentUser
iwr -useb get.scoop.sh | iex
# Install some tools with Scoop
scoop install git

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




scoop install nodejs
scoop install vscode
#scoop install 7zip
scoop install python
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