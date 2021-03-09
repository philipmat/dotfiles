if ($host.UI.RawUI.WindowTitle -match "Administrator") {
    $host.UI.RawUI.BackgroundColor = "DarkBlue";
    $host.UI.RawUI.ForegroundColor = "White"
}

# Import-Module "C:\Program Files (x86)\Microsoft SQL Server\120\Tools\PowerShell\Modules\SQLPS\SQLPS.PS1"
Import-Module -ErrorAction:Ignore PsGet

Import-Module -ErrorAction:Ignore PSake

if(!(Test-Path Alias:\psake)){ 
	New-Alias psake Invoke-PSake 
}
function poop { Invoke-PSake gutcheck }

Import-Module -ErrorAction:Ignore posh-git
function prompt {
	Write-Host -NoNewline -ForegroundColor Gray "[ "
	Write-Host -NoNewline -ForegroundColor White "$pwd"
	Write-Host -ForegroundColor Gray " ]  $(Get-Date -Format 'r')"
	return "> "
}
function which($name) {
	Get-Command $name | Select-Object -ExpandProperty Definition
}
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    # Reset color, which can be messed up by Enable-GitColors
    if ($GitPromptSettings.DefaultForegroundColor) {
        $Host.UI.RawUI.ForegroundColor =  $GitPromptSettings.DefaultForegroundColor
    }

	Write-Host -NoNewline -ForegroundColor Gray "[ "
    Write-Host($pwd.ProviderPath) -nonewline -ForegroundColor White
	Write-Host -NoNewline -ForegroundColor Gray " ] "

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE

	Write-Host -ForegroundColor Gray " $(Get-Date -Format 'r')"
    return "> "
}


Function Reload-Module($ModuleName) {
	if((get-module -list | where{$_.name -eq "$ModuleName"} | measure-object).count -gt 0) {
		if((get-module -all | where{$_.Name -eq "$ModuleName"} | measure-object).count -gt 0) {
			rmo $ModuleName
			Write-Host "Module $ModuleName Unloading"
		}
		ipmo $ModuleName
		Write-Host "Module $ModuleName Loaded"
	}
	Else {
		Write-Host "Module $ModuleName Doesn't Exist"
	}
}

Function n() {} # this is to fix the multiple Ns when coming out of git unlink index failed issue
New-Alias -Name rlo -Value Reload-Module

Function Init-File
{
    $Usage = "Usage: Init-File [file1 ... fileN]";
    # if no arguments, display an error
    if ($args.Count -eq 0) {
        throw $Usage;
    }
    # see if any arguments match -h[elp] or --h[elp] 
    foreach($file in $args) {
        if ($file -ilike "-h*" -or $file -ilike "--h*") {
            echo $Usage;
            return;
        }
    }

    foreach($file in $args) {
        if(Test-Path $file)
        {
            # file exists, update last write time to now
            (Get-ChildItem $file).LastWriteTime = Get-Date
        }
        else
        {
            # create new file. 
            # don't use `echo $null > $file` because it creates an UTF-16 (LE)
            # and a lot of tools have issues with that
            echo $null | Out-File -Encoding utf8 $file
        }
    }
}
New-Alias -Name touch -Value Init-File

Start-SshAgent -Quiet

if ($gitStatus) {
    # Enable-GitColors
    # Set up tab expansion and include psake expansion
    ############### Start psakeTabExpansion Initialization Code #########################
    Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition-Parent)
    . ./Modules/psake/tabexpansion/PsakeTabExpansion.ps1
    Pop-Location
    if ((Test-Path Function:\TabExpansion) -and (-not (Test-Path Function:\DefaultTabExpansion))) {
        Rename-Item Function:\TabExpansion DefaultTabExpansion
    }
    function TabExpansion($line, $lastWord) {
        $lastBlock = [regex]::Split($line, '[|;]')[-1]
        switch -regex ($lastBlock) {
            # Execute psake tab completion for all psake-related commands
            '(Invoke-psake|psake) (.*)' { PsakeTabExpansion $lastBlock }
            # Fall back on existing tab expansion
            default { DefaultTabExpansion $line $lastWord }
        }
    }
    ############### End psakeTabExpansion Initialization Code ###########################
}

Import-Module -ErrorAction:Ignore PowerYaml

New-Alias d Get-ChildItem 
# New-Alias cat Get-Content
New-Alias g git
New-Alias p Invoke-PSake
If (Test-Path Alias:wget) {Remove-Item Alias:wget}
New-Alias pbcopy clip
New-Alias make "C:\Program Files (x86)\Microsoft Visual Studio\2017\Community\SDK\ScopeCppSDK\VC\bin\nmake.exe"
New-Alias python3 python
Remove-Item alias:curl

# any per-machine settings can be set in a local.ps1 file
$localps1 = Join-Path $PSScriptRoot 'local.ps1'
if((Test-Path $localps1)){ 
	. $localps1
}

# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

