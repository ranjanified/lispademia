#include<stdlib.h>
#include<mdc-4.h>

unsigned short upc_check_digit(unsigned short product_id_digits[])
{
  unsigned short d = product_id_digits[0];
  
  unsigned short group1_digit1 = product_id_digits[1], group2_digit1 = product_id_digits[6];
  unsigned short group1_digit2 = product_id_digits[2], group2_digit2 = product_id_digits[7];
  unsigned short group1_digit3 = product_id_digits[3], group2_digit3 = product_id_digits[8];
  unsigned short group1_digit4 = product_id_digits[4], group2_digit4 = product_id_digits[9];
  unsigned short group1_digit5 = product_id_digits[5], group2_digit5 = product_id_digits[10];

  unsigned int first_sum = d + group1_digit2 + group1_digit4 + group2_digit1 + group2_digit3 + group2_digit5,
    second_sum = group1_digit1 + group1_digit3 + group1_digit5 + group2_digit2 + group2_digit4,
    total = 3 * first_sum + second_sum;
  
  return 9 - ((total - 1) % 10);
}

char *reverse_digits(int number)
{
  char *digits_buffer = malloc( sizeof (char) * 10);
  unsigned short digit_counter = 0;
  unsigned short divisor = 0;
  unsigned short remainder = 0;
  unsigned short current_number = 0;

  current_number = number;

  do
  {
    divisor = current_number / 10;
    remainder = current_number % 10;
    digits_buffer[digit_counter++] = remainder + '0';
    current_number = divisor;
  } while (current_number > 0);

  digits_buffer[digit_counter] = '\0';
  
  return digits_buffer;
}

char *convert_octal(int number)
{
  char *digits_buffer = malloc( sizeof (char) * 10), *copy_digits_buffer = malloc( sizeof (char) * 10);;
  unsigned short octal_base = 8, remainder = 0, digit_counter = 0, copy_digit_counter = 0; 
  int current_number = number;
  unsigned int divisor = 0;

  do
    {
      divisor = current_number / octal_base;
      remainder = current_number % octal_base;
      digits_buffer[digit_counter++] = remainder + '0';
      current_number = divisor;
    }
  while (current_number > 0);

  if (digit_counter < 5)
  {
    do
      {
	digits_buffer[digit_counter++] = '0';
      }
    while (digit_counter < 5);
  }
  
  digits_buffer[digit_counter] = '\0';
  copy_digit_counter = 0;

  do
    {
      copy_digits_buffer[copy_digit_counter] = digits_buffer[digit_counter - copy_digit_counter - 1];
      copy_digit_counter = copy_digit_counter + 1;
    }
  while (copy_digit_counter < digit_counter);

  copy_digits_buffer[copy_digit_counter] = '\0';

  return copy_digits_buffer;
}
