@echo off
setlocal

set MYPATH=%~dp0
set LISTFILE=%MYPATH%bookmarklets.txt
type nul > %LISTFILE%

for /f %%a in ('dir /b /s %MYPATH% ^| findstr /r ".js$" ^| findstr /r /v ".min.js$"') do (
	call :CONVERT %%a
)

endlocal
exit /b

:CONVERT
rem minifyと同時にjsのファイルリスト作成。
set MINFILE=%~n1.min%~x1
set RELPATH=
set WKPATH=%~dp1

call :GETRELPATH "%WKPATH:~0,-1%"
echo %RELPATH%%MINFILE%>>%LISTFILE%

set OUTPATH=%MYPATH%doc\%RELPATH%
if not exist %OUTPATH% mkdir %OUTPATH%

call uglifyjs --compress --mangle -- %1 > %OUTPATH%%MINFILE%
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
