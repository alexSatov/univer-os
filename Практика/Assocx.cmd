@echo off
setlocal
for /f "tokens=2 delims=:" %%i in ('chcp') do set /a lastCHCP=%%i
chcp 855>nul

if "%1"=="/?" echo Enter extension

set e=%1
set e=.%e:.=""%

reg query HKCR\%e% /ve 2>nul >nul
if ERRORLEVEL 1 (echo ERROR: Extension is not exist & goto :end)

for /f "tokens=3" %%i in ('reg query HKCR\%e% /ve ^|findstr "REG_SZ"') do ( 
    if "%%i" == "(value" (echo ERROR: Extension is not exist & goto :end)
    for /f "tokens=4 delims=\" %%a in ('reg query HKCR\%%i\shell /f * /k') do (
        for /f "tokens=3,*" %%k in ('reg query HKCR\%%i\shell\%%a\command /ve') do echo %%a: %%k%%l
)
)

:end
chcp %lastCHCP%>nul
endlocal