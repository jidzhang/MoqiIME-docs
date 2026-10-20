@echo off
REM Build MoqiTextService Win32 + x64 (MSVC, must run via .bat)
setlocal
set REPO=Z:\dev\IME\MoqiIME\moqi-im-windows
set ERR=0

echo == Win32 ==
cmake --build "%REPO%\build-vs32" --config Release --target MoqiTextService || set ERR=1
if %ERR% neq 0 goto :fail

echo == x64 ==
cmake --build "%REPO%\build-vs64" --config Release --target MoqiTextService || set ERR=1
if %ERR% neq 0 goto :fail

echo BUILD-OK
exit /b 0
:fail
echo BUILD-FAIL
exit /b 1
