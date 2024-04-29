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

char *stack_contents(struct stack *stack)
{
  char *buffer = malloc(sizeof(char *));
  struct node *curr_node = stack->head->next;
  unsigned int index = 0;
  
  while(curr_node != stack->tail) {
    buffer[index++] = curr_node->key;
    curr_node = curr_node->next;
  }
  buffer[index] = '\0';
  
  return buffer;
}

void stack_uninitialize(struct stack *stack)
{
  struct node *head = stack->head;
  struct node *tail = stack->tail;
  struct node *curr_node = head->next;
  struct node *next_node = curr_node;

  while(curr_node != tail) {
    next_node = curr_node->next;
    free(curr_node);
    curr_node = next_node;
  }
  
  free(stack->tail);
  free(stack->head);
  free(stack);
}

int stack_top(struct stack *stack)
{
  int top = stack_pop(stack);
  stack_push(stack, top);
  return top;
}

short is_operator(char op)
{
  short index = -1;
  char ops[5] = {'-', '+', '*', '/', '$'};
  for(short i = 0; i < 5; i++) {
    if (ops[i] == op) {
      index = i;
      break;
    }
  }
  return index > -1;
}

char *infix_postfix(char *infix)
{
  struct stack *stack = stack_initialize();
  char *postfix_string = malloc(sizeof(char *));
  unsigned int next_char = 0, postfix_index = 0;
  char next_symbol = '\0';

  while((next_symbol = infix[next_char++]) != '\0') {
    if (next_symbol == ')') {
      postfix_string[postfix_index++] = stack_pop(stack);
    } else {
      if(is_operator(next_symbol)) {
	stack_push(stack, next_symbol);
      } else {
	if(next_symbol != '(') {
	  postfix_string[postfix_index++] = next_symbol;
	}
      }
    }
  }
  
  while(!stack_empty(stack)) {
    postfix_string[postfix_index++] = stack_pop(stack);;
  }
  
  stack_uninitialize(stack);
  postfix_string[postfix_index] = '\0';
  return postfix_string; 
}

queue *queue_initialize()
{
  struct node *head = malloc(sizeof(struct node));
  struct node *tail = malloc(sizeof(struct node));
  struct queue *queue_start = malloc(sizeof(struct queue));
  
  head->key = -1;
  tail->key = -1;

  head->next = tail;
  tail->next = tail;

  queue_start->head = head;
  queue_start->tail = tail;

  return queue_start;
}

struct node *queue_insert(queue *queue, int key)
{
  struct node *key_node = malloc(sizeof(struct node));
  key_node->key = key;

  struct node *curr_node = queue->head;
  while(curr_node->next != queue->tail) {
    curr_node = curr_node->next;
  }
  key_node->next = curr_node->next;
  curr_node->next = key_node;
  
  return key_node;
}

int queue_remove(queue *queue)
{
  struct node *key_node = queue->head->next;
  if(key_node != queue->tail) {
    int key = key_node->key;
    queue->head->next = key_node->next;
    free(key_node);
    return key;
  }
  return queue->tail->key;
}

unsigned short queue_empty(queue *queue)
{
  return queue->head->next == queue->tail;
}
