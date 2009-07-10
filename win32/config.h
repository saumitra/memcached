#ifndef _CONFIG_H
#define _CONFIG_H
/* Name of package */
#define PACKAGE "memcached"

/* Define to the address where bug reports for this package should be sent. */
#define PACKAGE_BUGREPORT "brad@danga.com"

/* Define to the full name of this package. */
#define PACKAGE_NAME "memcached Server"

/* Define to the full name and version of this package. */
#define PACKAGE_STRING "memcached 1.2.5"

/* Define to the full name and version of this package. */
#define PACKAGE_DESCRIPTION "memcached 1.2.5 is a high-performance, distributed memory object caching system, generic in nature, but intended for use in speeding up dynamic web applications by alleviating database load. Win32 port by Kronuz."

/* Define to the one symbol short name of this package. */
#define PACKAGE_TARNAME "memcached"

/* Define to the version of this package. */
#define PACKAGE_VERSION "1.2.5"

/* Define to 1 if you have the ANSI C header files. */
#define STDC_HEADERS 1

/* Version number of package */
#define VERSION "1.2.5"

/* Machine is littleendian */
#define ENDIAN_LITTLE 1

/* Windows-specific includes */
#include <sys/types.h>
#include <sys/stat.h>
#include "win32.h"
#include <Winsock2.h>
#include <ws2tcpip.h>
#include <process.h>
#include "ntservice.h"
#include "bsd_getopt.h"

/*******************************/
/* HACKS to compile under UNIX */

#define SIGHUP 0
#define HAVE_SIGIGNORE
#define SIGINT 2
#define SIGPIPE 13
#define S_ISSOCK(mode) 0
#define RLIMIT_CORE 4
#define RLIM_INFINITY ((unsigned long int) (-0UL))
#define RLIMIT_NOFILE 7

/* Create expected type and struct definitions */

typedef short int _uid_t;

struct passwd {
    char * pw_name;
    char * pw_passwd;
    _uid_t pw_uid;
    _uid_t pw_gid;
    char * pw_gecos;
    char * pw_dir;
    char * pw_shell;
};

struct sockaddr_un {
    unsigned short int sun_family;
    char sun_path[108];
};

struct rlimit {
    unsigned long int rlim_cur, rlim_max;
};

/* Function prototypes expected by UNIX code
 * - function definitions in dummy_defs.c
 */

int lstat(char * path, struct stat * tstat);
int sigignore(int sig);
int getrlimit(int __resource, struct rlimit * __rlimits);
int setrlimit(int __resource, struct rlimit * __rlimits);
_uid_t getuid();
_uid_t geteuid();
struct passwd * getpwnam(char * name);
int setuid(_uid_t uid);
int setgid(_uid_t gid);
int daemonize(int nochdir, int noclose);
#endif // _CONFIG_H
