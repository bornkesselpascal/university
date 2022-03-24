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

####################################################
# Examples for chapter 'Arrays'
# Simple examples: one and two dimensional arrays
# We use array syntax for the types of parameters
TARGETS += $(BIN_DIR)/endianess
TARGETS += $(BIN_DIR)/passArrayAsArray-1dim
TARGETS += $(BIN_DIR)/passStringAsCharArray
TARGETS += $(BIN_DIR)/passArrayAsArray-2dim
TARGETS += $(BIN_DIR)/passArrayAddress
TARGETS += $(BIN_DIR)/storageLayoutArray-1dim
TARGETS += $(BIN_DIR)/storageLayoutArray-2dim

####################################################
# Examples for chapter 'Pointers'

# We use pointer syntax for the types of parameters
# Simple
TARGETS += $(BIN_DIR)/differentPointerTypes-StringInt
TARGETS += $(BIN_DIR)/passArrayAsPointer-1dim
TARGETS += $(BIN_DIR)/passStringAsCharPointer

# Show pointer arithmatics
TARGETS += $(BIN_DIR)/pointerSubtraction
TARGETS += $(BIN_DIR)/pointerArithmetics_WhatIsAllowed

# Some details aboid void pointer
TARGETS += $(BIN_DIR)/voidPointer

# Advanced and exotique
# Show access to 2-dim array via pointer arithmetics
TARGETS += $(BIN_DIR)/passArrayAsPointer-2dim
# Change dimension and type of array via void pointer
TARGETS += $(BIN_DIR)/differentPointerTypes-2DimArray

####################################################
# Examples for chapter 'Strings'

# Simple
TARGETS += $(BIN_DIR)/nullByteTerminatedStrings
TARGETS += $(BIN_DIR)/nullByteTerminatedStrings-V2

# Advanced
# Character arrays
TARGETS += $(BIN_DIR)/charArrayVersusPointer-V1
TARGETS += $(BIN_DIR)/charArrayVersusPointer-V2
TARGETS += $(BIN_DIR)/charArrayVersusPointer-V3

TARGETS += $(BIN_DIR)/constantStringsAndPointers
TARGETS += $(BIN_DIR)/constantStringsAndPointersConst
TARGETS += $(BIN_DIR)/charArrayVersusPointer-V4

####################################################
# Examples for chapter 'Structures'

# An exotique trick to simulate pass by value for arrays
TARGETS += $(BIN_DIR)/array_envelope
TARGETS += $(BIN_DIR)/wrapArrayIntoStruct-1dim

####################################################
# Examples for topic 'Declaration vs. definition'
TARGETS += $(BIN_DIR)/declarationVsDefinition

#################################################
# There is no need to edit below this line
#################################################

# Generate debugging symbols?
CFLAGS = -g -Wall

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
	$(CC) $(CFLAGS) $< -o $@

$(BIN_DIR):
	$(MKDIR) $(BIN_DIR)

.PHONY: clean
clean :
	$(RM_DIR) $(BIN_DIR)

