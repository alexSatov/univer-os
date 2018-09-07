@echo off
setlocal
if "%1" == "help" (echo "Help is internal command" & exit /b)
set p=%1
for /f "tokens=1 delims=." %%i in ("%p%") do set p=%%i
if "%p%"=="" goto :Error

for /f %%i in ('chdir') do (
    set a=%%i
)
set b=%PATH%;%a%

for %%i in ("%b:;=" "%") do call :Path %p% %%i
exit /b

:Path
for %%i in ("%PATHEXT:;=" "%") do call :Check %1 %2 %%i
exit /b

 
:Check
set Q=%~2\
set W=%Q:\\=\%%~1%~3
if exist "%W%" echo %W%  
exit /b

:Error
echo Name required
exit /b
endlocal