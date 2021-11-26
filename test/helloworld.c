#include <stdio.h>

int main(void)
{
    char *ptr;

    ptr = calloc(1, 13);
    strncpy(ptr, "Hello World!", 12);
    printf("%s\n", ptr);
    free(ptr);
}