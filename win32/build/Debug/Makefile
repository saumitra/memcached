CPP = gcc

LD = gcc

#CFLAGS = /Od /I "..\..\Win32-Code" /D "WIN32" /D "_DEBUG" /I "$(PTHREAD)" /I "$(EVENT)" \
#		/D "PTW32_STATIC_LIB" /D "_CONSOLE" /D "HAVE_CONFIG_H" \
#		/D "_CRT_SECURE_NO_DEPRECATE" /D "_VC80_UPGRADE=0x0600" \
#		/D "_MBCS" /FD /RTC1 /MT /Gy /W3 /nologo /c /TC

CFLAGS = -posix -g -I "../../" -D "WIN32" -D "_DEBUG" -I "$(PTHREAD)" -I "$(EVENT)" \
		-DPTW32_STATIC_LIB -D "_CONSOLE" -D "HAVE_CONFIG_H" \
		-D "_CRT_SECURE_NO_DEPRECATE" -D "_VC80_UPGRADE=0x0600" \
		-D "_MBCS" -c

#LDFLAGS = /INCREMENTAL:NO /NOLOGO /LIBPATH:"$(PTHREAD)" /LIBPATH:"$(EVENT)" \
#		/DYNAMICBASE:NO /MACHINE:X86 /DEBUG /PDB:".\memcache.pdb" \
#		/NODEFAULTLIB:"LIBCMTD" /SUBSYSTEM:CONSOLE libevent.lib \
#		pthreadvc2.lib ws2_32.lib  kernel32.lib user32.lib gdi32.lib \
#		winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib \
#		oleaut32.lib uuid.lib odbc32.lib odbccp32.lib

LDFLAGS = -L "$(PTHREAD)" -lpthreadGC2d -L "$(EVENT)" -levent \
 		-lws2_32 
#               -lkernel32 -luser32 -lgdi32 -lwinspool -lcomdlg32 \
#		-ladvapi32 -lshell32 -lole32 -loleaut32 -luuid -lodbc32 -lodbccp32
#ws2_32.lib  kernel32.lib user32.lib gdi32.lib \
#		winspool.lib comdlg32.lib advapi32.lib shell32.lib ole32.lib \
#		oleaut32.lib uuid.lib odbc32.lib odbccp32.lib

OBJS = 	ntservice.o win32.o bsd_getopt.o assoc.o \
			util.o globals.o hash.o \
			items.o memcached.o slabs.o stats.o thread.o

all		:	memcached.exe sizes.exe internal_tests.exe

memcached.exe	:	$(OBJS)
			@$(LD) -o memcached.exe $(OBJS) $(LDFLAGS)

globals.o	:	../../../globals.c ../../../memcached.h
			@$(CPP) $(CFLAGS) ../../../globals.c

hash.o	:	../../../hash.c ../../../hash.h
			@$(CPP) $(CFLAGS) ../../../hash.c

ntservice.o	:	../../ntservice.c ../../ntservice.h \
				../../config.h
			@$(CPP) $(CFLAGS) ../../ntservice.c

win32.o	:	../../win32.c ../../win32.h
			@$(CPP) $(CFLAGS) ../../win32.c

bsd_getopt.o	:	../../bsd_getopt.c ../../bsd_getopt.h
			@$(CPP) $(CFLAGS) ../../bsd_getopt.c
			

assoc.o	:	../../../assoc.c ../../../memcached.h ../../config.h
			@$(CPP) $(CFLAGS) ../../../assoc.c

items.o	:	../../../items.c ../../../memcached.h
			@$(CPP) $(CFLAGS) ../../../items.c

memcached.o	:	../../../memcached.c ../../../memcached.h ../../config.h \
			../../ntservice.h ../../bsd_getopt.h
			@$(CPP) $(CFLAGS) ../../../memcached.c

slabs.o	:	../../../slabs.c ../../../memcached.h
			@$(CPP) $(CFLAGS) ../../../slabs.c

stats.o	:	../../../stats.c ../../../memcached.h
			@$(CPP) $(CFLAGS) ../../../stats.c

thread.o	:	../../../thread.c ../../../memcached.h
			@$(CPP) $(CFLAGS) ../../../thread.c

util.o	:	../../../util.c ../../../util.h
			@$(CPP) $(CFLAGS) ../../../util.c

sizes.o	:	../../../sizes.c
			@$(CPP) $(CFLAGS) ../../../sizes.c

sizes.exe	:	sizes.o
			@$(LD) /OUT:"sizes.exe" $(LDFLAGS) $(OBJS)			

internal_tests.exe	:	internal_tests.o
			@$(LD) /OUT:"internal.exe" $(LDFLAGS) $(OBJS)

clean		:	
			@erase memcached.exe sizes.exe internal_tests.exe *.o

test		:
			@prove t/
			

