#include <stdlib.h>

int main(void)
{
    int *a = malloc(4 * sizeof *a);
    a[4] = 1;
    free(a);
    return 0;
}