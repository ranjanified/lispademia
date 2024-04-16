#include<calg-1.h>

unsigned long euclid_gcd(unsigned long num1, unsigned long  num2)
{
  unsigned long temp = 0;
  if (num1 == 0) {
    return num2;
  }
  
  if (num2 == 0) {
    return num1;
  }
  
  while (num1 > 0) {
    if (num1 < num2) {
      temp = num1;
      num1 = num2;
      num2 = temp;
    }
    num1 = num1 - num2;
  }
  return num2;
}
