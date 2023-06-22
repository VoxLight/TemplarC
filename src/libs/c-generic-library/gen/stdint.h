#ifndef STDINT_H_
#define STDINT_H_
#ifdef _WIN32
#define int8_t char
#define u_int8_t unsigned char
#define int16_t short int
#define u_int16_t unsigned short int
#define int32_t int
#define u_int32_t unsigned int
#define int64_t long
#define u_int64_t unsigned long
#define __func__ "Unknown"
#else
#include <stdint.h>
#endif
#endif
