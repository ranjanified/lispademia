#define INCHES_PER_POUND 166

#define FREEZING_POINT   32.0f
#define SCALE_FACTOR     (5.0f / 9.0f)

#define PI 3.14159f

char *print_pun();

float dimensional_weight_of_box (unsigned int length, unsigned int width, unsigned int height);

float fahrenheit_to_celsius (float fahrenheit);

float sphere_volume (float radius);

float taxed_dollars (float dollars, float tax);

long solve_polynomial_for (int x);

long opt_solve_polynomial_for (int x);

char *dollar_bills (int dollars);

char *loan_repayment (float amount, float yearly_interest_rate, float monthly_payment);
