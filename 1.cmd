@echo off
for /f "tokens=3 delims= " %%a in ('dir %%1 /-c ^| find "байт свободно"') do echo %%a

