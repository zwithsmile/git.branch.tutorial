@echo off

set buildtype=perf

set cdsave=%cd%
if "%EFI_SOURCE%" == "" goto help

rem, delete the previous binary in case the build fails
del %cdsave%\%boardname%x64%buildtype%.rom  > nul 2> nul

REM Navigate to our source folder
cd %EFI_SOURCE%\Project\%boardname%
nmake -nologo uefi64%buildtype%
if %ERRORLEVEL% NEQ 0 goto fail

rem # copy final image top project top level
copy %EFI_SOURCE%\Project\%boardname%\BIOS\%boardname%X64%buildtype%.bin %cdsave%\%boardname%x64%buildtype%.rom
echo === build complete ===
goto finish
:help
echo === first run go.bat to setup the build environment ===
pause
goto finish
:fail
echo *** build failed ***
:finish
cd %cdsave%
set cdsave=
