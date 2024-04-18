struct fraction {
  int numerator;
  int denominator;
};

unsigned long euclid_gcd(unsigned long num1, unsigned long num2);
void reduce_fraction(struct fraction *fraction);
int convert_int(char *number_str);
