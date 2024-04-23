struct node {
  int key;
  struct node *next;
};

struct node *list_initialize();
struct node *delete_next(struct node *node);
struct node *insert_after(struct node *node, int value);

unsigned int *sieve_primes(unsigned int primes_upto, unsigned int *primes_count);
