#include <stdio.h>
#include <stdlib.h>
#include <types.h>

// build command: gcc -shared -Wall -g -o libtest.so -fPIC test.c

struct c_struct
{
  int x;
  char *s;
};

struct c_struct *c_function (i, s, r, a)
    int i;
    char *s;
    struct c_struct *r;
    int a[10];
{
  // char c = a_char;
  int j;
  struct c_struct *r2;

  printf("i = %d\n", i);
  printf("s = %s\n", s);
  printf("r->x = %d\n", r->x);
  printf("r->s = %s\n", r->s);
  for (j = 0; j < 10; j++){
    printf("a[%d] = %d.\n", j, a[j]);
    fflush(stdin);
  }
  r2 = (struct c_struct *) malloc (sizeof(struct c_struct));
  r2->x = i + 5;
  r2->s = "a C string";
  return(r2);
}
