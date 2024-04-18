#include <stdio.h>
#include <stdlib.h>
#include <mdc-2.h>

char *print_pun() {
  char *buffer = malloc( sizeof(char) * 50); 
  snprintf(buffer, 50, "To C, or not to C: that is the question.%c", '\0');
  return buffer;
}

float dimensional_weight_of_box (unsigned int length, unsigned int width, unsigned int height) {
  unsigned int volume = length * width * height;

  float dimensional_weight = (volume + (INCHES_PER_POUND - 1)) / INCHES_PER_POUND;

  return dimensional_weight;
}

float fahrenheit_to_celsius (float fahrenheit) {
  float celsius = (fahrenheit - FREEZING_POINT) * SCALE_FACTOR;
  return celsius;
}

float sphere_volume (float radius) {
  return (4.0f / 3.0f) * PI * (radius * radius * radius);
}

float taxed_dollars (float dollars, float tax) {
  return dollars + (dollars * (tax / 100.0f));
}

long solve_polynomial_for (int x) {
  return (3 * x * x * x * x * x)
    + (2 * x * x * x * x) - (5 * x * x * x) - (x * x) + (7 * x) -6;
}

long opt_solve_polynomial_for (int x) {
  return (((((((((3 * x) + 2) * x) - 5) * x) - 1) * x) + 7) * x) - 6;
}

char *dollar_bills (int dollars) {
  char *buffer = malloc (sizeof (char) * 100);
  int remaining_dollars = 0, num_20s = 0, num_10s = 0, num_5s = 0, num_1s = 0;

  num_20s = dollars / 20;
  remaining_dollars = dollars - (20 * num_20s);

  num_10s = remaining_dollars / 10;
  remaining_dollars = remaining_dollars - (10 * num_10s);

  num_5s = remaining_dollars / 5;
  remaining_dollars = remaining_dollars - (10 * num_5s);

  num_1s = remaining_dollars;

  snprintf(buffer, 100, "$20 bills: %d\n$10 bills: %d\n$5 bills: %d\n$1 bills: %d%c", num_20s, num_10s, num_5s, num_1s, '\0');

  return buffer;
}

char *loan_repayment (float amount, float yearly_interest_rate, float monthly_payment) {
  float monthly_interest_rate = yearly_interest_rate / 12;
  float remaining_amount_1 = taxed_dollars(amount, monthly_interest_rate) - monthly_payment;
  float remaining_amount_2 = taxed_dollars(remaining_amount_1, monthly_interest_rate) - monthly_payment;
  float remaining_amount_3 = taxed_dollars(remaining_amount_2, monthly_interest_rate) - monthly_payment;


  char *buffer = malloc (sizeof (char) * 200);
  snprintf(buffer, 200,
"Balance remaining after first payment : %.2f\n\
Balance remaining after second payment: %.2f\n\
Balance remaining after third payment : %.2f\n", remaining_amount_1, remaining_amount_2, remaining_amount_3);

  return buffer;
}
