@REM
@REM Retrieve and validate command line arguments
@REM

set EVENT_LOC=%1

set PTHREAD_LOC=%2


set BLD_TYPE="%3"

@if %EVENT_LOC% == "" (
    @echo "Usage: build.bat <pathname for libevent> <pathname for pthread> DEBUG|RELEASE"
    @goto end
)

@if %PTHREAD_LOC% == "" (
    @echo "Usage: build.bat <pathname for libevent> <pathname for pthread> DEBUG|RELEASE"
    @goto end
)

@if /i %BLD_TYPE% NEQ "DEBUG" (
    @if /i %BLD_TYPE% NEQ "RELEASE" (
        @echo "Usage: build.bat <pathname for libevent> <pathname for pthread> DEBUG|RELEASE"
        @goto end
    )
)

@REM
@REM Setting environment variable for Visual Studio and Visual C
@REM

@SET VSINSTALLDIR=C:\Program Files\Microsoft Visual Studio 9.0
@SET VCINSTALLDIR=C:\Program Files\Microsoft Visual Studio 9.0\VC
@SET FrameworkDir=C:\WINDOWS\Microsoft.NET\Framework
@SET FrameworkVersion=v2.0.50727
@SET Framework35Version=v3.5
@if "%VSINSTALLDIR%"=="" goto error_no_VSINSTALLDIR
@if "%VCINSTALLDIR%"=="" goto error_no_VCINSTALLDIR

@echo Setting environment for using Microsoft Visual Studio 2008 x86 tools.

@call :GetWindowsSdkDir

@if not "%WindowsSdkDir%" == "" (
	set "PATH=%WindowsSdkDir%bin;%PATH%"
	set "INCLUDE=%WindowsSdkDir%include;%INCLUDE%"
	set "LIB=%WindowsSdkDir%lib;%LIB%"
)


@rem
@rem Root of Visual Studio IDE installed files.
@rem
@set DevEnvDir=C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE

@set PATH=C:\Program Files\Microsoft Visual Studio 9.0\Common7\IDE;C:\Program Files\Microsoft Visual Studio 9.0\VC\BIN;C:\Program Files\Microsoft Visual Studio 9.0\Common7\Tools;C:\WINDOWS\Microsoft.NET\Framework\v3.5;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727;C:\Program Files\Microsoft Visual Studio 9.0\VC\VCPackages;%PATH%
@set INCLUDE=C:\Program Files\Microsoft Visual Studio 9.0\VC\INCLUDE;%INCLUDE%
@set LIB=C:\Program Files\Microsoft Visual Studio 9.0\VC\LIB;%LIB%
@set LIBPATH=C:\WINDOWS\Microsoft.NET\Framework\v3.5;C:\WINDOWS\Microsoft.NET\Framework\v2.0.50727;C:\Program Files\Microsoft Visual Studio 9.0\VC\LIB;%LIBPATH%

@REM
@REM Setup test files for chosen build
@REM

@cd %BLD_TYPE%
@if not exist t mkdir t
@cd t
@erase *.t *.save
@if not exist lib mkdir lib
@copy /Y ..\..\..\..\t\win32\lib\MemcachedTest.pm .\lib
@copy /Y ..\..\..\..\t\*.t .
@copy /Y ..\..\..\..\t\win32\*.t .
@rename unixsocket.t unixsocket.save
@rename daemonize.t daemonize.save

@REM
@REM Perform the chosen build and run tests
@REM

@cd ..\
@nmake /C clean
@nmake /C EVENT=%EVENT_LOC% PTHREAD=%PTHREAD_LOC% memcached.exe
@REM nmake /C EVENT=%1 PTHREAD=%2 memcached.exe
@if errorlevel 1 goto error_no_BUILD_FAILED
@nmake /C test
@if errorlevel 1 goto error_no_TEST_FAILED
@cd ..\

:GetWindowsSdkDir
@call :GetWindowsSdkDirHelper HKLM > nul 2>&1
@if errorlevel 1 call :GetWindowsSdkDirHelper HKCU > nul 2>&1
@if errorlevel 1 set WindowsSdkDir=%VCINSTALLDIR%\PlatformSDK\
@exit /B 0

:GetWindowsSdkDirHelper
@for /F "tokens=1,2*" %%i in ('reg query "%1\SOFTWARE\Microsoft\Microsoft SDKs\Windows" /v "CurrentInstallFolder"') DO (
	if "%%i"=="CurrentInstallFolder" (
		SET "WindowsSdkDir=%%k"
	)
)
@if "%WindowsSdkDir%"=="" exit /B 1
@exit /B 0

:error_no_VSINSTALLDIR
@echo ERROR: VSINSTALLDIR variable is not set. 
@goto end

:error_no_VCINSTALLDIR
@echo ERROR: VCINSTALLDIR variable is not set. 
@goto end

:error_no_BUILD_FAILED
@echo ERROR: Make with memcached.exe target failed
@goto end

:error_no_TEST_FAILED
@echo ERROR: Make with test target failed
@goto end

:end
