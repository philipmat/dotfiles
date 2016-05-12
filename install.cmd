@echo off
setlocal ENABLEDELAYEDEXPANSION
set DEST=%USERPROFILE%
for /D %%i in (*) do (
    set _inst=%%i\_install.cmd
    if exist !_inst! (
        echo Will execute !_inst!
        cd %%i
        call _install.cmd
        cd ..
    )
)