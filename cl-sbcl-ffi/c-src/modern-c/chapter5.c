#include<errno.h>
#include<stddef.h>
#include<mdc-5.h>
#include<stdlib.h>
#include<stdio.h>

float broker_commision(float trade_amount)
{
  if (trade_amount < 2500.00f) {
    return 30.00f + (0.017f * trade_amount);
  } else if (trade_amount >= 2500.00f && trade_amount < 6250.00f) {
    return 56.00f + (0.0066f * trade_amount);
  } else if (trade_amount >= 6250.00f && trade_amount < 20000.00f) {
    return 76.00f + (0.0034f * trade_amount);
  } else if (trade_amount >= 20000.00f && trade_amount < 50000.00f) {
    return 100.00f + (0.0022f * trade_amount);
  } else if (trade_amount >= 50000.00f && trade_amount < 500000.00f) {
    return 155.00f + (0.0011f * trade_amount);
  } else {
    return 255.00f + (0.0009f * trade_amount);
  }
}

char* worded_number(unsigned short number)
{
  if (number > 9 && number < 100) {
    unsigned short first_digit = 0, second_digit = 0;
    char *first_digit_word = "";
    char *second_digit_word = "";
    char *buffer = malloc (sizeof (char) * 20);
    unsigned short buf_count = 0, buf_index = 0;

    switch (number) {
    case 10:
      first_digit_word = "ten";
      break;
    case 11:
      first_digit_word = "eleven";
      break;
    case 12:
      first_digit_word = "twelve";
      break;
    case 13:
      first_digit_word = "thirteen";
      break;
    case 14:
      first_digit_word = "fourteen";
      break;
    case 15:
      first_digit_word = "fifteen";
      break;
    case 16:
      first_digit_word = "sixteen";
      break;
    case 17:
      first_digit_word = "seventeen";
      break;
    case 18:
      first_digit_word = "eighteen";
      break;
    case 19:
      first_digit_word = "nineteen";
      break;
    default:
      first_digit = (number / 10) % 10, second_digit = number % 10;
      switch(first_digit) {
      case 2:
	first_digit_word = "twenty";
	break;
      case 3:
	first_digit_word = "thirty";
	break;
      case 4:
	first_digit_word = "forty";
	break;
      case 5:
	first_digit_word = "fifty";
	break;
      case 6:
	first_digit_word = "sixty";
	break;
      case 7:
	first_digit_word = "seventy";
	break;
      case 8:
	first_digit_word = "eighty";
	break;
      case 9:
	first_digit_word = "ninety";
	break;
      }

      switch(second_digit) {
      case 1:
	second_digit_word = "one";
	break;
      case 2:
	second_digit_word = "two";
	break;
      case 3:
	second_digit_word = "three";
	break;
      case 4:
	second_digit_word = "four";
	break;
      case 5:
	second_digit_word = "five";
	break;
      case 6:
	second_digit_word = "six";
	break;
      case 7:
	second_digit_word = "seven";
	break;
      case 8:
	second_digit_word = "eight";
	break;
      case 9:
	second_digit_word = "nine";
	break;
      default:
	break;
      }
      break;
    }
    if (second_digit > 0) {
      while (first_digit_word[buf_index] != '\0') {
	buffer[buf_count++] = first_digit_word[buf_index++];
      }
      buf_index = 0;
      buffer[buf_count++] = '-';
      while (second_digit_word[buf_index] != '\0') {
	buffer[buf_count++] = second_digit_word[buf_index++];
      }
      buffer[buf_count] = '\0';
      return buffer;
    } else {
      while (first_digit_word[buf_index] != '\0') {
	buffer[buf_count++] = first_digit_word[buf_index++];
      }
      buffer[buf_count] = '\0';
      return buffer;
    }
  } else {
    errno = NUMBER_NOT_IN_RANGE;
    return NULL;
  }
}

unsigned short count_digits(unsigned long number)
{
  unsigned short digits_counter = 0;
  unsigned long current_number = number;
  
  do {
    current_number /= 10;
    digits_counter++;
  } while (current_number > 0);

  return digits_counter;
}

char *format_time_12(unsigned short hour, unsigned int minutes)
{
  unsigned short hour_12 = 0;
  char *buffer = malloc( sizeof (char) * 9);
  char *format_string = "%02d:%02d AM%c";
  
  if (hour > 0) {
    hour_12 = (hour + 12) % 12;
    if (hour_12 == 0) {
      hour_12 = 12;
    }
    if (hour >= 12) {
      format_string = "%02d:%02d PM%c";
    }
  }
  snprintf(buffer, 9, format_string, hour_12, minutes, '\0');
  return buffer;
}
