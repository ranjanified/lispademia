#ifndef CALG2
#define CALG2

struct fraction {
  int numerator;
  int denominator;
};

unsigned long euclid_gcd(unsigned long num1, unsigned long num2);
void reduce_fraction(struct fraction *fraction);
int convert_int(char *number_str);
char *binary(int num);
unsigned long gcd_triplet(unsigned long a, unsigned long b, unsigned long c);
unsigned long *largest_pair_with_gcd_1 ();

#endif
