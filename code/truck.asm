extern fscanf
extern printf

global _InTruck

section .data
    format db "%d", 0 ; format for inputting load capacity
section .bss
    .FILE resq 1   ; temp pointer to the file
    .adress resq 1 ; pointer to the truck
section .text
_InTruck:
   push rbp
   mov rbp, rsp
   
   mov [.FILE], rsi    ; saving pointer to the FILE
   mov [.adress], rdi  ; savint adress for the truck
   
   ; preparing arguments for the truck
   mov rdi, [.FILE]
   mov rsi, format
   mov rdx, [.adress]
   mov rax, 0 ; no float numbers
   call fscanf
   
   leave 
   ret 
