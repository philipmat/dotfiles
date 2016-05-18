@echo off
setlocal ENABLEDELAYEDEXPANSION
set DEST=%USERPROFILE%

set arg_count=0
set VERBOSE=N
set TEST=N
set OVERRIDE=N

:LOOP_ARG
if "%~1"=="" GOTO PROG
if /i "%~1"=="/v" OR SET VERBOSE=Y
if /i "%~1"=="/verbose" SET VERBOSE=Y
if /i "%~1"=="--verbose" SET VERBOSE=Y
if /i "%~1"=="-v" SET VERBOSE=Y

if /i "%~1"=="/t" OR SET TEST=Y
if /i "%~1"=="/test" SET TEST=Y
if /i "%~1"=="--test" SET TEST=Y
if /i "%~1"=="-t" SET TEST=Y

if /i "%~1"=="/o" OR SET OVERRIDE=Y
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
set _source=%1
set _dest=%2
:: 3rd param /d - indicates directory
set _dir=%3 

if exist %_dest% (
    if !OVERRIDE!==Y (
        if !VERBOSE!==Y echo %_dest% already exists. Removing to relink.
        if !TEST!==N rm %_dest%
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
call :LINK_FILE "%CD%\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" "%USERPROFILE%\Documents\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" 
goto :EOF


::: =================================================================
::: Enumerate applications here 
::: =================================================================
:RUN_LOOP
call :VIM
call :POWERSHELL

:EOF