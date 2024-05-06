#include <stdio.h>
#include <stdlib.h>
#include <stdarg.h>
#include <logger.h>

void format_default(char * fmt_str)
{
  printf(fmt_str);
}

void (*stdout_format)(char *) = format_default;

/* void write_stdout(const char *fmt_str, ...) */
/* { */
/*   char *buffer = malloc(sizeof(char) * 1024); */
/*   va_list arg; */
/*   snprintf(buffer, 1024, fmt_str, arg); */
/*   va_end(arg); */
/*   stdout_format(buffer); */
/*   free(buffer); */
/* } */
