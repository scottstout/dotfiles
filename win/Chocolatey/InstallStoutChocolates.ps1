# parts of this file must be run as an admin

# Note: Was able to use Powershell approach (straight from the website) on my new Win10 surface rebuild.
Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

#Install Cholatey (I've had it not properly set the path varaible when this is run from powershell)
#Set-ExecutionPolicy Bypass -Scope Process -Force; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

# Install Choclatey from CMD (This is from hanselman)
#@powershell -NoProfile -ExecutionPolicy unrestricted -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%systemdrive%\chocolatey\bin

#@"%SystemRoot%\System32\WindowsPowerShell\v1.0\powershell.exe" -NoProfile -InputFormat None -ExecutionPolicy Bypass -Command "iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))" && SET "PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin"



# run this line by pasting into the powershell console (running as admin)
# if you just installed chocolately you may need to restart powershell before this will work
choco install vscode -y

#refresh the environment variables so you don't have to restart powershell (Update: maybe didn't help?)
refreshenv 



# Open this file in VS Code. VSCode will prompt you to install the PowerShell extension. Do this and then restart VSCode.
# Select the line then press F8 to run each of these. If you feel lucky you can run several (or all) at once.
# or better yet, just runthis file from the command line.Y

choco install git -y
choco install nodejs -y
choco install wiztree -y
choco install starship -y
choco install nerd-fonts-firacode -y
#choco install googlechrome -y
choco install python -y
choco install azure-cli -y
#choco install docker-for-windows -y  # This took a long time but eventually finsished.
choco install docker-desktop
# requires restart after preivious command (for it to work)
choco install kubernetes-cli -y
#choco install minikube -y
choco install sql-server-management-studio -y # takes a while
#choco install kindle -y
choco install 7zip -y
choco install visualstudio2019enterprise -y
choco install diffmerge -y
choco install powerbi -y
choco install powertoys -y
choco install microsoft-windows-terminal -y

choco install wsl -y # Restart after this.
# Requires Restart after previous step.
#choco install wsl-ubuntu-1804 -y  # I didn't like installing this way. Doesn't create shortcut. Had to find installation path and create a shortcut. Decided to uninstall.


##you may have to restart powershell before you can run this (running as admin)
code --install-extension ms-vscode.PowerShell
code --install-extension ms-vscode.azure-account

code --install-extension ms-python.python
#code --install-extension ms-vscode.vscode-azureextensionpack # Deprecated
code --install-extension ms-vscode.vscode-node-azure-pack

code --install-extension yzane.markdown-pdf
code --install-extension ban.spellright

# Clone a git REPO. Use PAT with HTTPS.  Look up PAT in password store.

#Install Az for PowerShell
Install-Module -Name Az -AllowClobber

# In Terminal - Update the profile to auto-load the config;
notepad $PROFILE

# if that gives and error, create the profile:
New-Item -Path $PROFILE -Type File -Force

# add this to the the file
#oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\gruvbox.omp.json" | Invoke-Expression
Invoke-Expression (&starship init powershell)

#VSCode — settings.json:
#````json
#"terminal.integrated.fontFamily": "'JetBrainsMono Nerd Font'",
#"editor.fontFamily": "'JetBrainsMono Nerd Font', Consolas, monospace"
#````
#Windows Terminal — Settings → your PowerShell profile → Appearance → Font face, pick the Nerd Font.
#Gotcha on font names: the installed family name isn't always the package name. After install, check the actual name with:
#powershell[System.Drawing.Text.InstalledFontCollection]::new().Families | Where-Object Name -like '*Nerd*'
#Use that exact string in your settings. JetBrains Mono, for example, installs as JetBrainsMono Nerd Font (no space between "JetBrains" and "Mono"), which trips people up.
#Once configured, restart VSCode / Windows Terminal and starship's git branches, folder icons, and language symbols will render instead of showing as boxes.

