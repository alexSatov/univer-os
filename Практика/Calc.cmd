@echo off
setlocal
set x=
if "%1"=="" (set /p x="Enter the expression: " & goto :m2)
if "%1"=="/?" goto :help
:m1
if "%1"=="" goto :m2
rem echo %1
set x=%x%%1
shift
goto :m1
:m2
set /a y=%x% 2>nul
if %errorlevel% neq 0 echo ERROR & goto :eof
echo %y%
goto :eof
:help
echo "Program Calc"
echo This program performs simple arithmetic operations (+,-,*,/) with integer numbers.
echo Also this program can work with integer variable besides "x" and "y". (For example: h + 7)
echo If the result of the action will be a real number, then the screen will indicate only the integer part.
echo If you see an inscription ERROR likely you make a mistake in the number or in the order of arithmetic signs.

