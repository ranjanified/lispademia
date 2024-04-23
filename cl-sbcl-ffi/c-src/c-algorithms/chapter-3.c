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
