#ifndef CALG3
#define CALG3

#define MAX_SINGLY_LL_NODES 100
#define STACK_MAX_SIZE 10000000

struct node {
  int key;
  struct node *next;
};

struct node *list_initialize();
struct node *delete_next(struct node *);
struct node *insert_after(struct node *, int);

extern int singly_ll_keys[];
extern int singly_ll_nexts[];
extern unsigned int singly_ll_head;
extern unsigned int singly_ll_tail;
extern unsigned int singly_ll_current;

void singly_ll_initialize(void);
void singly_ll_delete_next(unsigned int);
unsigned int singly_ll_insert_after(unsigned int, int);

unsigned int *sieve_primes(unsigned int, unsigned int *);

struct stack {
  struct node *head;
  struct node *tail;
};

struct stack *stack_initialize(void);
struct node *stack_push(struct stack *, int);
int stack_pop(struct stack *);
int stack_empty(struct stack *);
int *stack_contents(struct stack *, unsigned int *);
void stack_uninitialize(struct stack *);

char *infix_postfix(char *);

typedef struct queue {
  struct node *head;
  struct node *tail;
} queue;

queue *queue_initialize(void);
struct node *queue_insert(queue *, int);
int queue_remove(queue *);
unsigned short queue_empty(queue *);

unsigned short **fill_having_gcd_1(unsigned short, unsigned short);
void free_fill_array_having_gcd_1(unsigned short **, unsigned short);

void move_next_to_front(struct node *, int); 

#endif
