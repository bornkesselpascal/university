############################################################
# General purpose makefile
#
# Works for all simple C-projects where
# - binaries are compiled into sub-dir bin
# - binaries are created from a single c-source of the same name
#
# Note: multiple targets (binaries) in ./bin are supported
#

# Please add all targets in ./bin here

TARGETS += $(BIN_DIR)/factorial
TARGETS += $(BIN_DIR)/factorial_anim
TARGETS += $(BIN_DIR)/fibonacci
TARGETS += $(BIN_DIR)/fibonacci_anim
TARGETS += $(BIN_DIR)/fibonacci_it
TARGETS += $(BIN_DIR)/ackermann
TARGETS += $(BIN_DIR)/roma

#################################################
# There is no need to edit below this line
#################################################

# Generate debugging symbols?
CFLAGS = -g -Wall

#LDFLAGS = -lrt
LDFLAGS =

#EXTRA_FLAGS = -mpush-args -mpreferred-stack-boundary=4 -mno-accumulate-outgoing-args
# default for -mpreferred-stack-boundary=4 on 32/64bit machines
EXTRA_FLAGS = -mpush-args -mpreferred-stack-boundary=4
#EXTRA_FLAGS = -mpush-args -mpreferred-stack-boundary=2

#### Fixed variable definitions
CC = gcc
RM_DIR = rm -rf
MKDIR = mkdir
SHELL = /bin/bash
BIN_DIR = bin

####

all: $(BIN_DIR) $(TARGETS)

#### Fixed build rules
$(BIN_DIR)/% : %.c
	$(CC) $(EXTRA_FLAGS) $(CFLAGS) $< -o $@ $(LDFLAGS)

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)

.PHONY: clean
clean :
	$(RM_DIR) $(BIN_DIR)

