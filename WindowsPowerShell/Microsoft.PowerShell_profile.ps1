

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
    $Host.UI.RawUI.ForegroundColor = $GitPromptSettings.DefaultForegroundColor

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

if ($gitStatus) {
	# Enable-GitColors
	Start-SshAgent -Quiet
}

Import-Module -ErrorAction:Ignore PowerYaml

New-Alias d Get-ChildItem 
# New-Alias cat Get-Content
New-Alias g git
New-Alias p Invoke-PSake


# any per-machine settings can be set in a local.ps1 file
$localps1 = Join-Path $PSScriptRoot 'local.ps1'
if((Test-Path $localps1)){ 
	. $localps1
}
