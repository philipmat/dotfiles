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


for /D %%i in (*) do (
    set _inst=%%i\_install.cmd
    if exist !_inst! (
        if !VERBOSE!==Y echo Will execute !_inst!
        cd %%i
        call _install.cmd
        cd ..
    )
)