#include "hiredis-bridge.h"
#include "hiredis/hiredis.h"

void *redisSendCommand(redisContext *c, const char *format){
    return redisCommand(c, format);
}