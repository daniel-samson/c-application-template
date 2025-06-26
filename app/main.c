/**
 * @file main.c
 * @brief Main executable demonstrating library usage
 */

#include "app/app.h"
#include <stdio.h>

int main(void)
{
    printf("Version: %s\n", get_version());
    return 0;
}