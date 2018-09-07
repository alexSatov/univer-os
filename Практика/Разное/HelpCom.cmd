@echo off
for /f "tokens=2 delims=:" %%i in ('chcp') do set /a lastCHCP=%%i
chcp 855
if not exist Help (
   
   md Help
)
for /f "tokens=1" %%i in ('help ^| findstr /b [A-Z] ^| findstr /v /i diskpart ^| findstr /v /i graftabl') do help %%i > Help/%%i.txt
chcp %lastCHCP%



