#include <stdlib.h>
#include <assert.h>
#include <ctype.h>
#include <errno.h>
#include <string.h>
#include <stdlib.h>

#include "memcached.h"

bool safe_strtoull(const char *str, uint64_t *out) {
    char *endptr;
    unsigned long long ull;
    assert(out != NULL);
#ifndef WIN32
    errno = 0;
#else /* WIN32 */
    _set_errno(0);
#endif /* !WIN32 */
    *out = 0;
    ull = strtoull(str, &endptr, 10);
    if (errno == ERANGE)
        return false;
    if (isspace(*endptr) || (*endptr == '\0' && endptr != str)) {
        if ((long long) ull < 0) {
            /* only check for negative signs in the uncommon case when
             * the unsigned number is so big that it's negative as a
             * signed number. */
            if (strchr(str, '-') != NULL) {
                return false;
            }
        }
        *out = ull;
        return true;
    }
    return false;
}

bool safe_strtoll(const char *str, int64_t *out) {
    char *endptr;
    long long ll;
    assert(out != NULL);
#ifndef WIN32
    errno = 0;
#else
    _set_errno(0);
#endif
    *out = 0;
    ll = strtoll(str, &endptr, 10);
    if (errno == ERANGE)
        return false;
    if (isspace(*endptr) || (*endptr == '\0' && endptr != str)) {
        *out = ll;
        return true;
    }
    return false;
}

bool safe_strtoul(const char *str, uint32_t *out) {
    char *endptr = NULL;
    unsigned long l = 0;
    assert(out);
    assert(str);
    *out = 0;
#ifndef WIN32
    errno = 0;
#else
    _set_errno(0);
#endif

    l = strtoul(str, &endptr, 10);
    if (errno == ERANGE) {
        return false;
    }

    if (isspace(*endptr) || (*endptr == '\0' && endptr != str)) {
        if ((long) l < 0) {
            /* only check for negative signs in the uncommon case when
             * the unsigned number is so big that it's negative as a
             * signed number. */
            if (strchr(str, '-') != NULL) {
                return false;
            }
        }
        *out = l;
        return true;
    }

    return false;
}

bool safe_strtol(const char *str, int32_t *out) {
    char *endptr;
    long l;
    assert(out != NULL);
#ifndef WIN32
    errno = 0;
#else
    _set_errno(0);
#endif
    *out = 0;
    l = strtol(str, &endptr, 10);
    if (errno == ERANGE)
        return false;
    if (isspace(*endptr) || (*endptr == '\0' && endptr != str)) {
        *out = l;
        return true;
    }
    return false;
}
