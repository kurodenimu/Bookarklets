@echo off
setlocal

set MYPATH=%~dp0
set HTML=docs\index.html
type Template.html > %HTML%

for /f %%a in ('dir /b /s %MYPATH% ^| findstr /r ".js$" ^| findstr /r /v ".min.js$"') do (
	call :MINIFY %%a
)

echo ^</body^>>> %HTML%
echo ^</html^>>> %HTML%

endlocal
exit /b

:MINIFY
set MINFILE=%~n1.min%~x1
set RELPATH=
set WKPATH=%~dp1

call :GETRELPATH "%WKPATH:~0,-1%"

set OUTPATH=%MYPATH%docs\%RELPATH%
if not exist %OUTPATH% mkdir %OUTPATH%

call uglifyjs --compress --mangle -- %1 > %OUTPATH%%MINFILE%

rem 末尾の\を区切り文字に変換しないように削除。
set TITLE=%RELPATH:~0,-1%
set TITLE=%TITLE:\= - %
echo ^<div class='bookmarklet'^>^<h2^>%TITLE%^</h2^>>> %HTML%
echo |set /p="<a href='javascript: (function() {">> %HTML%
type %OUTPATH%%MINFILE% >> %HTML%
echo |set /p="})()'>%~n1</a>">> %HTML%
echo |set /p="</div>">> %HTML%
echo.>> %HTML%

exit /b

:GETRELPATH
rem 相対パス取得。ベースフォルダと一致するまで再帰処理。
rem 末尾に\がついてるとdpで自身が取得されるため末尾の\を消している。
rem その仕様によりベースフォルダとの一致判定時に\を付けている。
if "%~1\ "=="%MYPATH% " exit /b

set RELPATH=%~n1\%RELPATH%
set WKPATH=%~dp1
call :GETRELPATH "%WKPATH:~0,-1%"

exit /b
