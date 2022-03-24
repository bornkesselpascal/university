# On linux build like this:
# mkdir -p bin
# gcc -g -Wall -nostdlib hello_intel.s -o bin/hello_intel
#
# Note: we use POSIX system calls -> will not run in MinGW
#
# From http://en.wikipedia.org/wiki/GNU_Assembler#Usage
# Also consult https://www.mirbsd.org/htman/i386/man7/gas-intel-howto.htm
# for intel syntax
	.intel_syntax noprefix
	.data
 
msg:
        .asciz  "Hello, world!\n" # "asciz" will cause the assembler to append
                                  # the null byte that many C library routines
                                  # expect. The C library isn't being used in
                                  # the example.
MSGLEN  = . - msg # this will cause the assembler to count the number of bytes
                  # between the label "msg" and here. The number will be 15,
                  # as the null byte is included.
 
	.text
 
        .globl  _start
_start:
        mov     edx, MSGLEN # argument 3 for write. Number of bytes to write.
                            # A macro is used, which means the MSGLEN will be
                            # replaced with the immediate value 0xf (15) during
                            # assembly. Comparable to C preprocessor macros.
        mov     ecx, offset msg    # argument 2 for write. Pointer to data.
        mov     ebx,0x1     # argument 1. file descriptor number. (stdout=1,
                            # see article on file descriptors)
        mov     eax,4       # syscall number 4 = write(2)
        int     0x80
        xor     ebx,ebx     # argument for syscall. exit code = 0
                            #(xor of a value with itself always equals 0)
        mov     eax,1       # syscall number 1 = exit(2)
        int     0x80

