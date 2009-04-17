Instructions for Installation/Build/Test of Memcached on Windows

Building memcached executables on Windows depends on the following prerequisites:

*  The build is currently supported only for Windows XP 32-bit 
*  Microsoft Visual C++ 2008 Express Edition:
   *    installed in the default location c:\Program Files\Microsoft Visual Studio 9.0
   *    dependency Microsoft .NET Framework V3.5 installed in the default
          location C:\WINDOWS\Microsoft.NET\Framework\v3.5
   *    If either version or location is different, manually edit
          file memcached\win32\build\build.bat to make appropriate changes
*  Perl installation to run tests
   *    The build has been tested with Active Perl V5.10.0
        * the tests require Process module of Active Perl to run
*  libevent
   *  tested with libevent-1.4.8-stable
   *  note down the installation directory to be explicitly passed to the build script
*  pthreads
   *  memcached multithreading is built using open source posix library
   *  note down the installation directory to be explicitly passed to the build script
*  memcached is built and tested by running the script build.bat in directory memcached\win32\build
   *  the invocation is in three steps
      1) set EVENTLOC environment variable to the root of the libevent installation
         using command such as,
              set EVENTLOC=<libevent-install-dir>
      2) set PTHREADLOC environment variable to the root of the pthread library installation
         using command such as,
              set PTHREADLOC=<pthreads-install-dir>
      3) run the build script for either RELEASE or DEBUG build using the command
              build.bat "%EVENTLOC%" "%PTHREADLOC%" DEBUG
         For a RELEASE build and test, substitute DEbUG with RELEASE
