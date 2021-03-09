@echo off
setlocal ENABLEDELAYEDEXPANSION
set DEST=%USERPROFILE%

set arg_count=0
set VERBOSE=N
set TEST=N
set OVERRIDE=N

:LOOP_ARG
if "%~1"=="" GOTO PROG
if /i "%~1"=="/v" SET VERBOSE=Y
if /i "%~1"=="/verbose" SET VERBOSE=Y
if /i "%~1"=="--verbose" SET VERBOSE=Y
if /i "%~1"=="-v" SET VERBOSE=Y

if /i "%~1"=="/t" SET TEST=Y
if /i "%~1"=="/test" SET TEST=Y
if /i "%~1"=="--test" SET TEST=Y
if /i "%~1"=="-t" SET TEST=Y

if /i "%~1"=="/o" SET OVERRIDE=Y
if /i "%~1"=="/override" SET OVERRIDE=Y
if /i "%~1"=="--override" SET OVERRIDE=Y
if /i "%~1"=="-o" SET OVERRIDE=Y
shift & GOTO LOOP_ARG

:PROG
if !VERBOSE!==Y echo Verbose!
if !TEST!==Y echo Test mode!
if !OVERRIDE!==Y echo Override!
GOTO RUN_LOOP

:LINK_FILE
    SETLOCAL
    set _source="%~1"
    set _dest="%~2"
    :: 3rd param /d - indicates directory
    set _dir=%3 

    if exist %_dest% (
        if !OVERRIDE!==Y (
            if !VERBOSE!==Y echo %_dest% already exists. Removing to relink.
            if exist %~2%\* (
                if !VERBOSE!==Y echo rmdir /s /q %~2%
                if !TEST!==N rmdir /s /q %~2%
            ) else (
                if !VERBOSE!==Y echo del /f /q %_dest%
                if !TEST!==N del /f /q %_dest%
            )
        )
    )
    if !VERBOSE!==Y echo mklink %_dir% %_dest% %_source%
    if !TEST!==N mklink %_dir% %_dest% %_source%
    ENDLOCAL & GOTO :EOF

::: =================================================================
::: Configure applications here 
::: =================================================================

:VIM
call :LINK_FILE "%CD%\vim" "%USERPROFILE%\vimfiles" /d
call :LINK_FILE "%CD%\vim\vsvimrc.vim" "%USERPROFILE%\_vsvimrc" 
goto :EOF

:POWERSHELL
::: old powershell
call :LINK_FILE "%CD%\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1"
::: new powershell
call :LINK_FILE "%CD%\PowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
goto :EOF

:GIT
call :LINK_FILE "%CD%\git\.gitconfig" "%USERPROFILE%\.gitconfig"
call :LINK_FILE "%CD%\git\.gitconfig-win" "%USERPROFILE%\.gitconfig-extra"
call :LINK_FILE "%CD%\git\.gitignore_global" "%USERPROFILE%\.gitignore_global"
goto :EOF

:VSCODE
call :LINK_FILE "%CD%\VSCode\keybindings.json" "%APPDATA%\Code\User\keybindings.json"
call :LINK_FILE "%CD%\VSCode\settings.json" "%APPDATA%\Code\User\settings.json"
call :LINK_FILE "%CD%\VSCode\snippets" "%APPDATA%\Code\User\snippets"
goto :EOF

::: =================================================================
::: Enumerate applications here 
::: =================================================================
:RUN_LOOP
call :VIM
call :POWERSHELL
call :GIT
call :VSCODE

:EOF