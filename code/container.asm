extern _InTransportation
extern print

global _InRndContainer
global _InContainer
global _OutContainer

section .data
    part1 db "Container contains ",0
    part2 db " elements.",0,10
section .bss
    container resb 130000
    size resb 32

section .text

; Input - rbx - amount of elements.  
_InRndContainer:
    mov [size], rbx
    mov rax, container
rndLoop:    
    push rbx    ; Remember the amount of elements.
    push rax    ; Remember the position.
    
    ; _InRndTransportation
    
    pop rax
    add rax, 13 ; Moving pointer of the container to fill new element.
    pop rbx
    dec rbx     ; Since we created an element, decrement left amount.
    cmp rbx, 0  ; If left amount to create is 0, then leave the function. 
    ja rndLoop
    ret
    
_InContainer:
    mov edx, 0         ; start size.
    mov rbx, container ; Moving pointer of the container start.
inloop:    
    push rbx   ; saving container pointer
    push rax   ; saving descriptor
    ;
      push rbx
push rax
    mov rdi, 1
    mov rax, part1
    call print     ; container contains.
pop rax
pop rbx
    ;
    
    inc edx    ; increment size.
    push rdx   
    
    call _InTransportation
    
    pop rdx    ; size
    pop rax    ; descriptor
    pop rbx    ; container pointer
    cmp rcx, 10
    jne inloop
    dec edx    ; decrementing size, size the last element wasn't valid.
    mov [size], edx ; saving size
    ret

    
;input: rdi as descriptor
_OutContainer:
    push rdi
    mov rax, part1
    call print     ; container contains.
    
    mov rdi, [rsp]
    mov rax, 0 
    mov rax, [size]
    ; call printInt  ; number of elements.
    
    mov rax, part2  ; elements.
    mov rdi, [rsp]
    call print
    
    mov [size], rbx
    mov rax, container
    pop rdi
outLoop:    
    push rbx    ; Remember the amount of elements.
    push rax    ; Remember the position.
    push rdi    ; Remember the descriptor.
    
    ; _OutTransportation
    
    pop rdi
    pop rax
    add rax, 13 ; Moving pointer of the container to fill new element.
    pop rbx
    dec rbx     ; Since we created an element, decrement left amount.
    cmp rbx, 0  ; If left amount to show is 0, then leave the function. 
    ja outLoop
    ret
