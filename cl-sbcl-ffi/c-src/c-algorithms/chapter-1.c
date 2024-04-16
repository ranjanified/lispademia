#include<calg-1.h>

unsigned long euclid_gcd(unsigned long num1, unsigned long  num2)
{
  unsigned long temp = 0, u = num1, v = num2;
  while (u > 0) {
    if (u < v) {
      temp = u;
      u = v;
      v = temp;
    }
    u = u - v;
  }
  return v;
}
