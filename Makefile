CC = i686-elf-gcc
CFLAGS = -std=gnu99 -ffreestanding -O2 -Wall -Wextra -Iinclude
AS = i686-elf-as

KDIR = kernel

SOURCE = "kernel"
LIBDIR = lib

CCODE 	    = $(shell find $(SOURCE) -type f -name '*.c')
SCODE	    = $(shell find $(SOURCE) -type f -name '*.s')
LIBCCODE 	= $(shell find $(LIBDIR) -type f -name '*.c')
LIBSCODE 	= $(shell find $(LIBDIR) -type f -name '*.s')
OBJECTS	= $(patsubst $(SOURCE)/%.c, $(OUTPUT)/%.c.o, $(CCODE))
OBJECTS += $(patsubst $(SOURCE)/%.s, $(OUTPUT)/%.s.o, $(SCODE))
OBJECTS += $(patsubst $(LIBDIR)/%.s, $(LIBDIR)/%.s.o, $(LIBCCODE))
OBJECTS += $(patsubst $(LIBDIR)/%.s, $(LIBDIR)/%.s.o, $(LIBSCODE))

bread_os: $(OBJECTS) 
	i686-elf-gcc -Iinclude -T linker.ld -o $@ -ffreestanding -O2 -nostdlib $(OBJECTS) -lgcc 

%.c.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@


%.s.o: %.s
	$(AS) $< -o $@

install:

