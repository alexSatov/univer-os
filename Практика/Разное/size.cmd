@echo off
setlocal enabledelayedexpansion
set size = 0
for /R %%i in (*.txt) do (
        set /a size = !size!+%%~zi
)
echo %size%