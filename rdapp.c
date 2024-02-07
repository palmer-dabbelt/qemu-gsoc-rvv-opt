#include <stdlib.h>

#define BUFSZ (1UL << 16)
#define LOOPS (1UL << 16)

void __attribute__((noinline)) foo(int * restrict a, int * restrict b, int * restrict c)
{
  for (long i = 0; i < BUFSZ; i++)
    c[i] = a[i] + b[i];
}

int main ()
{
  int *a = malloc (BUFSZ * sizeof (int));
  int *b = malloc (BUFSZ * sizeof (int));
  int *c = malloc (BUFSZ * sizeof (int));

  for (size_t i = 0; i < LOOPS; ++i)
    foo(a, b, c);

  return c[BUFSZ-1];
}


