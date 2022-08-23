#include <stdlib.h>
#include <stdio.h>
#include "HsFFI.h"
#include "Lib_stub.h"

void hsInit(void)
{
    hs_init(NULL, NULL);
}

void hsExit(void)
{
    hs_exit();
}

void hsHello(void)
{
    printf("hsHello: about to call 'fromHaskell'\n");
    fromHaskell();
}
