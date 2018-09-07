@echo off
setlocal
if "%1"=="" (echo end & exit /B)
set /a sleepTime = %1

set realTime=%TIME%
set realTime=%realTime:08=8%
set realTime=%realTime:09=9%
for /F "tokens=1-3 delims=:" %%a in ("%realTime%") do (
	set hours=%%a 
        set min=%%b 
        set sec=%%c 	
)
set /a startTime = hours * 3600 + min * 60 + sec 
set /a endTime = %startTime% + %sleepTime%

set /a t=24 * 3600
echo "%t%"
if %endTime% GEQ %t% (
  set /a endTime = %endTime% - %t%
)

:SLEEP
set realTime=%TIME%
set realTime=%realTime:08=8%
set realTime=%realTime:09=9%
for /F "tokens=1-3 delims=:" %%a in ("%realTime%") do (
	set hours=%%a 
        set min=%%b 
        set sec=%%c 	
)
set /a currentTime = hours * 3600 + min * 60 + sec
if %currentTime% == %endTime%  (echo end & exit /B)
goto SLEEP