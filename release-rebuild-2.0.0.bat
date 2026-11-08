@echo off
rem Release rebuild driver for Moqi IM v2.0.0 (2026-11-08).
rem Cold rebuild: all cmake caches wiped first (tree was built on another system).
rem ASCII only. Logs: librime-*.log (from inner bats) + release-rebuild-2.0.0.log.
setlocal EnableExtensions
set ROOT=Z:\dev\IME\MoqiIME
set W=%ROOT%\moqi-im-windows

echo === [0/7] preflight ===
where cmake || goto :fail
where powershell || goto :fail

echo === [1/7] wipe all build caches ===
rmdir /s /q "%ROOT%\librime\build"
rmdir /s /q "%ROOT%\librime\build-x86"
rmdir /s /q "%W%\build-vs32"
rmdir /s /q "%W%\build-vs64"
rmdir /s /q "%W%\moqi-daemon\build-x86"
rmdir /s /q "%W%\moqi-daemon\build-x86-lite"
rmdir /s /q "%ROOT%\moqi-ime\scripts\build"
rmdir /s /q "%W%\installer\stage"
rmdir /s /q "%W%\installer\stage-lite"

echo === [2/7] librime x64 full rebuild ===
call "%ROOT%\librime\rebuild-librime2.bat"
if errorlevel 1 goto :fail
if not exist "%ROOT%\librime\build\bin\Release\rime.dll" goto :fail
copy /y "%ROOT%\librime\build\bin\Release\rime.dll" "%ROOT%\eval-workspace\rime.dll" || goto :fail

echo === [3/7] librime x86 full rebuild ===
call "%ROOT%\librime\rebuild-librime-x86.bat"
if errorlevel 1 goto :fail
if not exist "%ROOT%\librime\build-x86\bin\Release\rime.dll" goto :fail

echo === [4/7] MoqiDaemon x86 full rebuild ===
cmake -S "%W%\moqi-daemon" -B "%W%\moqi-daemon\build-x86" -G "Visual Studio 17 2022" -A Win32 || goto :fail
cmake --build "%W%\moqi-daemon\build-x86" --config Release --target MoqiDaemon || goto :fail
if not exist "%W%\moqi-daemon\build-x86\Release\MoqiDaemon.exe" goto :fail

echo === [5/7] moqi-im-windows full rebuild (Win32 solution + x64 TSF) ===
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%W%\scripts\build.ps1" -RepoRoot "%W%" || goto :fail

echo === [6/7] five installer tiers (std/lite/essay/wiki/wanxiang) ===
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "%W%\scripts\_all_local_packages.ps1" -RepoRoot "%W%" || goto :fail

echo === [7/7] artifacts ===
dir /O-D "%W%\installer\dist\moqi-im-windows-setup*.exe"
echo REBUILD-ALL-OK
exit /b 0

:fail
echo REBUILD-FAILED errorlevel=%errorlevel%
exit /b 1
