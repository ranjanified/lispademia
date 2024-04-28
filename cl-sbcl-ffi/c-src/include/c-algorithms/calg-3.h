#define MAX_SINGLY_LL_NODES 100
#define STACK_MAX_SIZE 10000000

struct node {
  int key;
  struct node *next;
};

struct node *list_initialize();
struct node *delete_next(struct node *);
struct node *insert_after(struct node *, int);

int singly_ll_keys[MAX_SINGLY_LL_NODES + 2], singly_ll_nexts[MAX_SINGLY_LL_NODES + 2];
unsigned int singly_ll_head, singly_ll_tail, singly_ll_current;

void singly_ll_initialize();
void singly_ll_delete_next(unsigned int);
unsigned int singly_ll_insert_after(unsigned int, int);

unsigned int *sieve_primes(unsigned int, unsigned int *);

struct stack {
  struct node *head;
  struct node *tail;
};

struct stack *stack_initialize();
struct node *stack_push(struct stack *, int);
int stack_pop(struct stack *);
int stack_empty(struct stack *);
char *stack_contents(struct stack *);
void stack_uninitialize(struct stack *);
/*
typedef struct arr_stack {
  unsigned int keys[STACK_MAX_SIZE];
  unsigned int top;
  unsigned int nexts[STACK_MAX_SIZE];
} STACK_USING_ARRAY;
*/

char *infix_postfix(char *);
