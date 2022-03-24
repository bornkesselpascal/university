; ----------------------------------------------------------------------
; even.asm
;
; Demonstrate build environment for nasm in the virtual
; Linux machine vmmint-13
; 
; Author: FABR
; ----------------------------------------------------------------------

extern  printf, scanf

; Initialized data
segment .data                 ; Format strings used for scanf and printf

    prompt_n1:                dd `Bitte geben Sie eine nicht-negative ganze Zahl ein: \0`
    scanf_format_read_int:    dd `%d\0`

    ; For the next two string constants we use back quotes for
    ; delimiters since they contain the escape sequence \n
    prompt_res_even:      dd `Die eingegebene Zahl ist gerade\n\0`
    prompt_res_odd:       dd `Die eingegebene Zahl ist ungerade\n\0`

; Uninitialized data
segment .bss
; Reserve DWORDs because we use 4 byte integers for printf and scanf.
; Note: we could use the stack frame of function main as well.

    n1: resd 1                  ; reserve 1 DWORD for input 1
    res: resd 1                 ; reserve 1 DWORD for the result

; Code segment
segment .text

global main

main:
    ; --------------------------------------------------------
    ; start frame: save old frame pointer and set the new one
    push    ebp 
    mov     ebp, esp 

    ; --------------------------------------------------------
    ; read first number n1
    ; push argument for call of printf
    push      prompt_n1
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 4
    ; push argument for call of scanf: from right to left
    push      n1
    push      scanf_format_read_int
    call      scanf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 8

    ; --------------------------------------------------------
    ; test if number is even and branch accordingly
    check:
    mov       eax, [n1]         ; copy n1 into eax
    and       eax, 0x1          ; logical and with bitmask 0x01
    jnz       odd

    ; --------------------------------------------------------
    ; print result for case even
    ; push argument for call of printf: from right to left
    even: 
    push      prompt_res_even
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 4
    jmp       cont

    ; --------------------------------------------------------
    ; print result for case odd
    ; push argument for call of printf: from right to left
    odd: 
    push      prompt_res_odd
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 4

    cont:
    ; --------------------------------------------------------
    ; leave function main with return value 0 (for OK)
    mov       eax,0
    leave
    ret

