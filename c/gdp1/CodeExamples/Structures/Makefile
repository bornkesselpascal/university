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

#TARGETS += $(BIN_DIR)/points-V0
TARGETS += $(BIN_DIR)/points-V1
TARGETS += $(BIN_DIR)/points-V2
TARGETS += $(BIN_DIR)/points-V3

#TARGETS += $(BIN_DIR)/vectors-V0
TARGETS += $(BIN_DIR)/vectors-V1
TARGETS += $(BIN_DIR)/vectors-V2
TARGETS += $(BIN_DIR)/vectors-V3

TARGETS += $(BIN_DIR)/students-V1
TARGETS += $(BIN_DIR)/students-V2
TARGETS += $(BIN_DIR)/students-V3

#TARGETS += $(BIN_DIR)/complex-V0
TARGETS += $(BIN_DIR)/complex-V1
TARGETS += $(BIN_DIR)/complex-V2
TARGETS += $(BIN_DIR)/complex-V3
TARGETS += $(BIN_DIR)/complex-V4

#################################################
# There is no need to edit below this line
#################################################

# Generate debugging symbols?
CFLAGS = -g -Wall
LDFLAGS = -lm

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
	$(CC) $(CFLAGS) $< -o $@ $(LDFLAGS)

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)

.PHONY: clean
clean :
	$(RM_DIR) $(BIN_DIR)

