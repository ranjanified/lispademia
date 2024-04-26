#define MAX_SINGLY_LL_NODES 100

struct node {
  int key;
  struct node *next;
};

struct node *list_initialize();
struct node *delete_next(struct node *node);
struct node *insert_after(struct node *node, int value);

int singly_ll_keys[MAX_SINGLY_LL_NODES + 2], singly_ll_nexts[MAX_SINGLY_LL_NODES + 2];
unsigned int singly_ll_head, singly_ll_tail, singly_ll_current;

void singly_ll_initialize();
void singly_ll_delete_next(unsigned int node);
unsigned int singly_ll_insert_after(unsigned int node, int key);

unsigned int *sieve_primes(unsigned int primes_upto, unsigned int *primes_count);

struct stack {
  struct node *head;
  struct node *tail;
};

struct stack *stack_initialize();
struct node *stack_push(struct stack *stack, int key);
int stack_pop(struct stack *stack);
int stack_empty(struct stack *stack);
