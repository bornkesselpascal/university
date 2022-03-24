############################################################
# General purpose makefile
#
# Works for all NASM-projects where
# - binaries are compiled into sub-dir bin
# - binaries are created from multiple asm sources
#   and depend on all object files in ./
#

# Please add all object files in ./ here
OBJECTS += adder.o

# Please add THE target in ./bin here
TARGET += $(BIN_DIR)/adder
 
#################################################
# There is no need to edit below this line
#################################################

# Generate debugging symbols?
CFLAGS = -g -Wall
ASMFLAGS = -g -f elf32 -F dwarf -d ELF_TYPE

#### Fixed variable definitions

ASM = nasm
CC = gcc
RM_DIR = rm -rf
MKDIR = mkdir
SHELL = /bin/bash
BIN_DIR = bin

#### Default target
all: $(BIN_DIR) $(TARGET)

#### Fixed build rules for binaries with multiple object files

%.o : %.asm 
	$(ASM) $(ASMFLAGS) $< 

#### Binaries
$(TARGET) : $(OBJECTS)
	$(CC) -o $@ $(OBJECTS) $(LDLIBS)

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)

.PHONY: clean
clean :
	$(RM_DIR) $(BIN_DIR) $(OBJECTS)

