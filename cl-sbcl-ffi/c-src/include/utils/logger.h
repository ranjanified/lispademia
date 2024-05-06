#ifndef LOGGER
#define LOGGER

extern void (*stdout_format)(char *); 

// void write_stdout(const char *, ...);
#define write_stdout(fmt_str, ...)				\
  {								\
    char *buffer = malloc(sizeof(char) * 1024);			\
    snprintf(buffer, 1024, fmt_str __VA_OPT__(,) __VA_ARGS__);	\
    stdout_format(buffer);					\
    free(buffer);						\
  }

#endif
