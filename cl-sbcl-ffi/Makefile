.PHONY: clean

SHELL           = /bin/sh
CC              = gcc
FLAGS           = -std=gnu99
CFLAGS          = -fPIC -pedantic -Wall -Wextra -march=native -ggdb3 $(HEADER_INCLUDES)
LDFLAGS         = -shared
DEBUGFLAGS      = -O0 -D _DEBUG
RELEASEFLAGS    = -O2 -D NDEBUG -combine -fwhole-program

PREFIX          = c-src
OBJDIR          = $(PREFIX)/obj
BINDIR          = $(PREFIX)/bin

TARGET          = libsbclffi.so
SOURCES         = $(shell echo $(PREFIX)/*.c $(PREFIX)/**/*.c)
HEADER_INCLUDES = $(shell echo -I$(PREFIX)/include -I$(PREFIX)/include/modern-c -I$(PREFIX)/include/c-algorithms)
OBJECTS         = $(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): clean $(OBJECTS)
	$(CC) $(FLAGS) $(CFLAGS) $(DEBUGFLAGS) $(LDFLAGS) -o $(TARGET) $(OBJECTS)

clean:
	rm -rf $(TARGET) $(PREFIX)/*.o $(PREFIX)/**/*.o $(PREFIX)/*~ $(PREFIX)/**/*~
