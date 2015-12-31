#ifndef hiredis_bridge_h
#define hiredis_bridge_h

#include "hiredis/hiredis.h"

void *redisSendCommand(redisContext *c, const char *format);

#endif