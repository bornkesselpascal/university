; ----------------------------------------------------------------------
; adder.asm
;
; Demonstrate build environment for nasm in the virtual
; Linux machine vmmint-13
; 
; Author: FABR
; ----------------------------------------------------------------------

extern  printf, scanf

; Initialized data
segment .data                 ; Format strings used for scanf and printf

    ; For the string constants we use back quotes as
    ; delimiters since they contain the escape sequences \n and \0
    prompt_n1:                dd `Bitte geben Sie die erste  Zahl ein: \0`
    prompt_n2:                dd `Bitte geben Sie die zweite Zahl ein: \0`
    scanf_format_read_int:    dd `%d\0`

    prompt_res:      dd `Die Summe der beiden Zahlen %d und %d ist %d\n\0`
    prompt_myprint_int:  dd `Das Argument fuer myprint_int lautet: %d\n\0`

; Uninitialized data
segment .bss
; Reserve DWORDs because we use 4 byte integers for printf and scanf.
; Note: we could use the stack frame of function main as well.

    n1: resd 1                  ; reserve 1 DWORD for input 1
    n2: resd 1                  ; reserve 1 DWORD for input 2
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
    ; read second number n2
    ; push argument for call of printf
    push      prompt_n2
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 4
    ; push argument for call of scanf: from right to left
    push      n2
    push      scanf_format_read_int
    call      scanf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 8

    ; --------------------------------------------------------
    ; add the two numbers
    mov       eax, [n1]         ; copy n1 into eax
    add       eax, [n2]         ; add n2 to eax
    mov       [res], eax        ; save result into variable res

    ; --------------------------------------------------------
    ; print result
    ; push argument for call of printf: from right to left
    push      dword [res]
    push      dword [n2]
    push      dword [n1]
    push      prompt_res
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 16

    ; --------------------------------------------------------
    ; Call our own print function for integers
    ; This is done in order to demonstrate function calls
    push      dword [res]
    call      myprint_int
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 4

    ; --------------------------------------------------------
    ; leave function main with return value 0 (for OK)
    mov       eax,0
    leave
    ret

myprint_int:
    ; --------------------------------------------------------
    ; start frame: save old frame pointer and set the new one
    push    ebp 
    mov     ebp, esp 

    ; --------------------------------------------------------
    ; print the integer argument of the function
    ; push argument for call of printf
    push      dword [ebp+8]
    push      prompt_myprint_int
    call      printf
    ; cleanup stack, restore situation bevor push of arguments
    add       esp, 8

    ; --------------------------------------------------------
    leave
    ret

