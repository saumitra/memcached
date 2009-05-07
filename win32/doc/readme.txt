Instructions for Installation/Build/Test of Memcached on Windows

Building memcached executables on Windows depends on the following prerequisites:

* The build is currently supported only for Windows XP 32-bit 
* MingW
    - installed in the default location c:\MingW
    - consists of the following packages: GNU BinUtils, GCC-Core, mingwrt, w32api, mingw32-make, gdb(optional).
    - add the paths c:\MingW\bin and c:\Ming W\mingw32\bin to the PATH environment variable
* Perl installation to run tests
    - the build has been tested with Active Perl V5.10.0
    - the tests require Process module of Active Perl to run
* libevent
    - tested with libevent-1.4.8-stable
    - it is assumed required libraries(libevent.a) and header files(event.h, event_config.h, evutil.h) are in one directory
    - note down the absolute pathname for this directory to be explicitly passed to the build script
* pthreads
    - memcached multithreading is built using open source posix library
    - it is assumed required libraries(libpthreadGC2.a, pthreadGC2.dll) and header files(pthread.h, sched.h) are in one directory
    - note down the absolute pathname for this directory to be explicitly passed to the build script
* memcached is built and tested by running the script build.bat in directory memcached\win32\build
    - the invocation is in four steps
        1) set EVENTLOC environment variable to the root of the libevent installation
           using command such as,
               set EVENTLOC=<libevent-install-dir>
        2) set PTHREADLOC environment variable to the root of the pthread library installation
           using command such as,
               set PTHREADLOC=<pthreads-install-dir>
        3) add the pathname to the pthreadGC2.dll (contained in PTHREAD_LOC) to the PATH environment variable
           using command such as,
               set PATH=%PTHREADLOC%;%PATH%
        4) run the build script for either RELEASE or DEBUG build using the command
          build.bat "%EVENTLOC%" "%PTHREADLOC%" DEBUG
    - For a RELEASE build and test, substitute DEBUG with RELEASE
