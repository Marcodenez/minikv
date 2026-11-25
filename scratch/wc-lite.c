#include <stdio.h>

int main(int argc, char *argv[])
{
    if (argc < 2)
    {
        printf("Usage: %s <filename>\n", argv[0]);
        return 1;
    }

    FILE *file = fopen(argv[1], "rb");

    if( file == NULL)
    {
        perror("fopen");
        return 1;
    }

    char buffer[4096];
    int newline = 0;
    size_t total_bytes = 0;

    size_t bytes_read;

    while ((bytes_read = fread(buffer, 1, sizeof(buffer), file)) > 0)
    {
        for (size_t i = 0; i < bytes_read; i++)
        {
            if (buffer[i] == '\n')
            {
                newline++;
            }
        }

        total_bytes += bytes_read;     
    }

    printf("Bytes read: %zu\n", total_bytes);
    printf("Total newline: %i\n", newline);

    fclose(file);
    return 0;
}