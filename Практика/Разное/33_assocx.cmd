@echo off
setlocal
rem справка
if "%~1"=="/?" (
	echo Usage: %~n0 ^<file extension with dot^> ^(.txt^)
	goto :eof
)

rem далее разбираем на примере расширения .psd (Photoshop)
rem reg query HKCR\.psd /ve вернет следующее (что означают ключ /ve посмотри в справке reg query /?)
rem
rem HKEY_CLASSES_ROOT\.psd
rem     (по умолчанию)    REG_SZ    Photoshop.Image.55
rem именно так с пустой строкой в начале
rem при помощи findstr "REG_SZ" находим только строку
rem     (по умолчанию)    REG_SZ    Photoshop.Image.55
rem разделителем в оператьоре for по умолчанию является пробел, т.е. эта строка разделится на следующие столбцы:
rem 1. "(по", 2. "умолчанию)", 3. "REG_SZ" и  4. "Photoshop.Image.55"
rem нам нужен 4-й столбец, поэтому пишем for /f "tokens=4"
rem кстати, здесь потенциальное место для ошибок, т.к. в английской версии "(по умолчанию)" превратится в "(default)"
rem т.е. количество столбцов сократится и нужно будет поправить на for /f "tokens=3"
for /f "tokens=4" %%i in ('reg query HKCR\%~1 /ve ^|findstr "REG_SZ"') do (
rem reg query HKCR\Photoshop.Image.55\shell /f * /k вернет следующее (что означают ключи /f и /k посмотри в справке reg query /?)
rem
rem HKEY_CLASSES_ROOT\Photoshop.Image.55\shell\edit
rem HKEY_CLASSES_ROOT\Photoshop.Image.55\shell\open
rem HKEY_CLASSES_ROOT\Photoshop.Image.55\shell\preview
rem HKEY_CLASSES_ROOT\Photoshop.Image.55\shell\print
rem Поиск завершен: найдено совпадений: 4.
rem при помощи for /f "tokens=4 delims=\" делим каждую строку по \ и берем 4-й столбец, т.е. edit, open, preview и print в нашем случае
rem т.е. фактически мы нашли какие действия с файлами .psd зарегистрированы в системе
	for /f "tokens=4 delims=\" %%a in ('reg query HKCR\%%i\shell /f * /k') do (
rem окончательно, например, для действия edit команда reg query HKCR\Photoshop.Image.55\shell\edit\command /ve вернет
rem 
rem HKEY_CLASSES_ROOT\Photoshop.Image.55\shell\edit\command
rem     (по умолчанию)    REG_SZ    "C:\Program Files\Adobe\Adobe Photoshop CS5.1 (64 Bit)\Photoshop.exe" "%1"
rem yнам нужен 4 слолбец и далее (т.к. в имени файла может встретится пробел), поэтому for /f "tokens=4,*" и %%k%%l при выводе
		for /f "tokens=4,*" %%k in ('reg query HKCR\%%i\shell\%%a\command /ve') do echo %%a: %%k%%l
	)
)
endlocal