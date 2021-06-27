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
rem minify�Ɠ�����js�̃t�@�C�����X�g�쐬�B
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
rem ���΃p�X�擾�B�x�[�X�t�H���_�ƈ�v����܂ōċA�����B
rem ������\�����Ă��dp�Ŏ��g���擾����邽�ߖ�����\�������Ă���B
rem ���̎d�l�ɂ��x�[�X�t�H���_�Ƃ̈�v���莞��\��t���Ă���B
if "%~1\ "=="%MYPATH% " exit /b

set RELPATH=%~n1\%RELPATH%
set WKPATH=%~dp1
call :GETRELPATH "%WKPATH:~0,-1%"

exit /b
