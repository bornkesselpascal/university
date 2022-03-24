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

TARGETS += $(BIN_DIR)/swap-V1
TARGETS += $(BIN_DIR)/swap-V2
TARGETS += $(BIN_DIR)/swap-V2-stackdemo
TARGETS += $(BIN_DIR)/myname-V1
TARGETS += $(BIN_DIR)/myname-V2
TARGETS += $(BIN_DIR)/simple
TARGETS += $(BIN_DIR)/spy1
TARGETS += $(BIN_DIR)/spy2

#################################################
# There is no need to edit below this line
#################################################

# Generate debugging symbols?
CFLAGS = -g -Wall

#LDFLAGS = -lrt
LDFLAGS =

#EXTRA_FLAGS = -mpush-args -mpreferred-stack-boundary=4 -mno-accumulate-outgoing-args
# default for -mpreferred-stack-boundary=4 on 32/64bit machines
EXTRA_FLAGS = -mpush-args -mno-accumulate-outgoing-args -mpreferred-stack-boundary=4
#EXTRA_FLAGS += -fomit-frame-pointer
#EXTRA_FLAGS = 

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

