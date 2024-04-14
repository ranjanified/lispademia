#include <stdio.h>
#include <stdlib.h>
#include <mdc-3.h>

char *tprintf(int i, float j)
{
  char *buffer = malloc(sizeof (char) * 100);
  
  snprintf(buffer, 100, "|%d|%5d|%-5d|%5.3d|\n|%10.3f|%10.3e|%-10g\n", i, i, i, i, j, j, j);

  return buffer;
}

char *add_fraction(int numerator1, int denominator1, int numerator2, int denominator2)
{
  char *buffer = malloc(sizeof (char) * 100);

  int result_numerator = numerator1 * denominator2 + numerator2 * denominator1;
  int result_denominator = denominator1 * denominator2;

  snprintf(buffer, 50, "The sum is %d/%d\n", result_numerator, result_denominator);

  return buffer;
}
