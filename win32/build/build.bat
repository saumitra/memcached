@REM
@REM Retrieve and validate command line arguments
@REM

@set EVENT_LOC=%1

@set PTHREAD_LOC=%2


@set BLD_TYPE="%3"

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

@set PATH=%PTHREAD_LOC%;%PATH%
@cd ..\
@mingw32-make clean
@mingw32-make EVENT=%EVENT_LOC% PTHREAD=%PTHREAD_LOC% memcached.exe
@if errorlevel 1 goto error_no_BUILD_FAILED
@mingw32-make test
@if errorlevel 1 goto error_no_TEST_FAILED
@cd ..\
@goto end

:error_no_BUILD_FAILED
@echo ERROR: Make with memcached.exe target failed
@goto end

@:error_no_TEST_FAILED
@echo ERROR: Make with test target failed

:end

