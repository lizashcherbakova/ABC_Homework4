extern convertNumber   ; converts number from null terminated string ; rax - pointer to str; rbx - number
extern readNumber      ; reads number; rax - descriptor ; output: rbx - number
extern printInt        ; prints int number; rax - number, rdi - descriptor
extern fopen
extern fclose
extern _InContainer

section .data
    msg db "Start", 0ah
    
    err1 db "incorrect command line!",10 
    err2 db "incorrect qualifier value!",10
    err3 db "incorrect numer of transport. Set 0 < number <= 10000",10
    exp  db "Waited:",10,"     command -f infile outfile01 outfile02",10,"  Or:",10,"     command -n number outfile01 outfile02",10

section .bss
    container resb 130;000
    infile resb 100
    
section .text
    global _start


_start:
    pop rax
    cmp rax, 5
    jne _errMessage1   ; if even number of arguments isn't correct, call mistake output.
    
    mov rax, 1
    mov rdi, 1
    mov rsi, msg       ; if number args is good - print start
    mov rdx, 6
    syscall
    
    pop rax            ; exe name
    pop rax            ; qualifier
    
    mov cl, [rax]
    cmp cl, 45         ; if first symbol is '-'
    jne _errMessage2
    
    inc rax            ; check that the word has 2 letters
    mov cl, [rax]
    cmp cl, 0
    je _errMessage2
    
    inc rax            ; check that the word has 2 letters
    mov cl, [rax]
    cmp cl, 0
    jne _errMessage2
    
    dec rax            ; now checking the symbol
    mov cl, [rax]
    cmp cl, 102        ; if letter == 'f'
    je _prepareInFile
    cmp cl, 110
    je _prepareRndContainer
    call _errMessage2
    
_outputData:
   
_exit:    
    mov rax, 60
    mov rdi, 0
    syscall
    
_prepareInFile:
    pop rdi                   ; file name
    mov     rsi, 64           ; open to read
    mov     rax, 0              ; no double numbers
    call    fopen
    push rax                    ; saving the file descriptor

    call _InContainer ; filling the container

    pop rdi
    mov rax, 0
    call fclose
    jmp _outputData

_prepareRndContainer:
    pop rax    ; string that contains the number of elements
    call convertNumber   ; gives number in rbx
    cmp rbx, 0           ; if number is equal to 0
    je _errMessage3
    cmp rbx, 10000       ; or if number is more then 10'000
    ja _errMessage3
    
    ;call _InRndContainer
    
    jmp _outputData
    
_errMessage1:
    mov rax, 1
    mov rdi, 1
    mov rsi, err1
    mov rdx, 24
    syscall
    jmp _explanation
_errMessage3:
    mov rax, 1
    mov rdi, 1
    mov rsi, err3
    mov rdx, 54
    syscall
    jmp _exit
_errMessage2:
    mov rax, 1
    mov rdi, 1
    mov rsi, err2
    mov rdx, 27
    syscall
_explanation:    
    mov rax, 1
    mov rdi, 1
    mov rsi, exp
    mov rdx, 100
    syscall
    call _exit
    
    
