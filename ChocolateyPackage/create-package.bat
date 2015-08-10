@echo off
setlocal

set PACKAGE_DIR=%~dp0
set PROJECT_DIR=%PACKAGE_DIR%\..
if not exist "%PROJECT_DIR%\Release\re2c.exe" (
    if exist "%PROJECT_DIR%\Debug\re2c.exe" (
            echo re2c.exe found, but was built in Debug configuration.
            echo Please rebuild the solution file using Release configuration before packaging.
            exit /b 1
	)
	
	echo re2c.exe not found. Please build the solution file before packaging.
	exit /b 1
)

copy /y "%PROJECT_DIR%\Release\re2c.exe" "%PACKAGE_DIR%\tools" > nul || goto :copy_failure
choco pack "%PACKAGE_DIR%\re2c.nuspec" || goto :pack_failure
goto :eof

:copy_failure
echo Copying "%PROJECT_DIR%\Release\re2c.exe" to "%PACKAGE_DIR%\tools" failed.
exit /b 2

:pack_failure
echo choco pack failed. Please see above output for details on the error.
exit /b 2
