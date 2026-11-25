#include <stdlib.h>
#include <string.h>

int main(void)
{
    char *p = malloc(100);
    strcpy(p, "Leaked");
    free(p);
    return 0;
}