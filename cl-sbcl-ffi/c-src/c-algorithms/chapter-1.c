#include<stdlib.h>
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

void reduce_fraction(struct fraction *fraction)
{
  int numerator = fraction->numerator, denominator = fraction->denominator;
  int gcd_num_denom = euclid_gcd(numerator, denominator);
  unsigned short num_sign = numerator < 0 ? -1 : 1;
  unsigned short denom_sign = denominator < 0 ? -1 : 1;

  if (gcd_num_denom != 0) {
    fraction->numerator = num_sign * denom_sign * (abs(numerator) / gcd_num_denom);
    fraction->denominator = abs(denominator) / gcd_num_denom;
  }
}
