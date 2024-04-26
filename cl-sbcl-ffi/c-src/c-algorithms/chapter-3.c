#include <stdlib.h>
#include <calg-3.h>

unsigned int *sieve_primes(unsigned int primes_upto, unsigned int *primes_count)
{
  unsigned int buffer[(primes_upto + 1)];
  unsigned int index = 0, run_index = 0;

  for (buffer[0] = 0, buffer[1] = 0, index = 2; index <= primes_upto; index++) {
    buffer[index] = 1;
  }
  
  for (index = 2; index <= (primes_upto / 2); index++) {
    for (run_index = 2; run_index <= (primes_upto / index); run_index++) {
      buffer[index * run_index] = 0;
    }
  }
  
  for(index = 1; index <= primes_upto; index++) {
    if (buffer[index] == 1) {
      ++(*primes_count);
    }
  }
  
  unsigned int *primes_buffer = malloc (sizeof (unsigned int) * (*primes_count));
  *primes_count = 0;
  for(index = 1; index <= primes_upto; index++) {
    if (buffer[index] == 1) {
      primes_buffer[(*primes_count)++] = index;
    }
  }
  return primes_buffer;
}

struct node *list_initialize()
{
  struct node *head, *tail;

  head = malloc(sizeof *head);
  tail = malloc(sizeof *tail);

  head->key = -10;
  head->next = tail;
  tail->next = tail;

  return head;
}

struct node *delete_next(struct node *node)
{
  struct node *deleted_node = node->next;
  node->next = node->next->next;

  return deleted_node;
}

struct node *insert_after(struct node *node, int key)
{
  struct node *new_node;

  new_node = malloc(sizeof *new_node);
  new_node->key = key;

  new_node->next = node->next;
  node->next = new_node;

  return new_node;
}

void singly_ll_initialize()
{
  singly_ll_head = 0;
  singly_ll_tail = 1;
  singly_ll_current = 2;

  singly_ll_nexts[singly_ll_head] = singly_ll_tail;
  singly_ll_nexts[singly_ll_tail] = singly_ll_tail;
}

void singly_ll_delete_next(unsigned int node)
{
  singly_ll_nexts[node] = singly_ll_nexts[singly_ll_nexts[node]];
}

unsigned int singly_ll_insert_after(unsigned int node, int key)
{
  singly_ll_keys[singly_ll_current] = key;
  singly_ll_nexts[singly_ll_current] = singly_ll_nexts[node];
  singly_ll_nexts[node] = singly_ll_current;
  return singly_ll_current++;
}

struct stack *stack_initialize()
{
  struct node *head = malloc(sizeof(struct node));
  struct node *tail = malloc(sizeof(struct node));

  struct stack *stack_start = malloc(sizeof(struct node));

  head->key = 0;
  tail->key = 0;

  head->next = tail;
  tail->next = tail;
  
  stack_start->head = head;
  stack_start->tail = tail;
  
  return stack_start;
}

struct node *stack_push(struct stack *stack, int key)
{
  struct node *new_key_node = malloc(sizeof(struct node));
  new_key_node->key = key;

  new_key_node->next = stack->head->next;
  stack->head->next = new_key_node;

  return new_key_node;
}

int stack_pop(struct stack *stack)
{
  struct node *key_node = stack->head->next;
  int key = key_node->key;
  stack->head->next = key_node->next;
  free(key_node);
  return key;
}

int stack_empty(struct stack *stack)
{
  return stack->head->next == stack->tail;
}
