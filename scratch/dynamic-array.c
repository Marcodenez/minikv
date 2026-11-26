#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

int main(void)
{
    int *p;
    int n = 1000000;
    int size = 8;
    int count = 0;
    bool check = true;

    p = malloc(size * sizeof(int));

    if (p == NULL)
    {
        printf("Memory allocation failed\n");
        return 1;
    }

    for (int i = 0; i < n; i++)
    {   
        if (count == size)
        {
            size *= 2;
            int *tmp = realloc(p, size * sizeof(int));

            if (tmp == NULL)
            {
                printf("Memory reallocation failed\n");
                free(p);
                return 1;
            }

            p = tmp;

        }

        p[i] = i + 1;
        count++;
    }

    for (int i = 0; i < count; i++)
    {
        if (p[i] != i + 1)
        {
            check = false;
            break;
        }
    }

    if (check)
    {
        printf("Verification passed: %i values checked\n", count);
    }
    else
    {
        printf("Verification failed.\n");
    }

    free(p);
    return 0;
}
