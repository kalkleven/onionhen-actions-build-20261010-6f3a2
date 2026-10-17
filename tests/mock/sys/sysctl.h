#pragma once
#include <stddef.h>
#ifdef __cplusplus
extern "C" {
#endif
int sysctlbyname(const char *, void *, size_t *, const void *, size_t);
#ifdef __cplusplus
}
#endif

