#include <stdlib.h>
#include <math.h>
#include <calg-1.h>

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
  unsigned int numerator = abs(fraction->numerator), denominator = abs(fraction->denominator);
  unsigned int gcd_num_denom = euclid_gcd(numerator, denominator);
  short num_sign = fraction->numerator < 0 ? -1 : 1, denom_sign = fraction->denominator < 0 ? -1 : 1;

  if (gcd_num_denom != 0) {
    fraction->numerator = num_sign * denom_sign * (numerator / gcd_num_denom);
    fraction->denominator = denominator / gcd_num_denom;
  }
}

int convert_int(char *number_str)
{
  unsigned short str_len = 0, str_index = 0;
  int accumulated_number = 0;
  while (number_str[str_index++] != '\0') {
    str_len++;
  }
  str_index = 0;
  while (str_index < str_len) {
    accumulated_number = accumulated_number + ((number_str[str_len - 1 - str_index] - '0') * pow(10, str_index));
    ++str_index;
  }
  return accumulated_number;
}

char *binary(int num)
{
  char *buffer = malloc( sizeof (char) * 64);
  int current_number = num;
  unsigned char temp = '\0';
  unsigned int divisor = 0;
  unsigned short remainder = 0, digit_index = 0, reverse_index = 0;
  do {
    divisor = current_number / 2;
    remainder = current_number % 2;
    buffer[digit_index++] = remainder + '0';
    current_number = divisor;
  } while (divisor > 0);
  
  buffer[digit_index] = '\0';
  
  while (reverse_index < digit_index) {
    temp = buffer[reverse_index];
    buffer[reverse_index++] = buffer[--digit_index];
    buffer[digit_index] = temp;
  }
  return buffer;
}
