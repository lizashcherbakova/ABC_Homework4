extern readNumber   
extern fscanf   
global _InTransportation

section .data
    formc db "%c", 0
    formd db "%d", 0

section .text
    
; Input: rax - descriptor; rbx - pointer to array.    
_InTransportation:
    push rax  ; saving File.
    push rbx  ; saving pointer.

    mov rdi, rax   ; pointer to file.
    mov rsi, formc ; format.
    mov rdx, rbx   ; adress.
    mov rax, 0     ;
    call fscanf
    
    mov rbx, [rsp] ; getting pointer to container.
    mov cl, [rbx]
    sub cl, 48
    mov [rbx], cl  ; saving the index of transport.

    cmp cl, 4
    jae _endInTransportation ; if key >= 4 - key is not valid.
    pop rdx          ; getting pointer of array
    inc rdx          ; moving pointer to save other data in free spot.
    mov rax, [rsp]   ; getting pointer to File.
    push rdx   
    
    ; reading capacity.
    mov rdi, rax   ; pointer to file.
    mov rsi, formd ; format.
    ;mov rdx, rbx   ; adress.
    mov rax, 0     ;
    call fscanf
   
    pop rdx
    add rdx, 4     ; moving to the new adress
    mov rax, [rsp]   ; getting pointer to File.
    push rdx   
       
    ; reading consumption.
    mov rdi, rax   ; pointer to file.
    mov rsi, formd ; format.
    ;mov rdx, rbx   ; adress.
    mov rax, 0     ;
    call fscanf

    pop rdx
    add rdx, 8     ; moving to the new adress
    mov rax, [rsp]   ; getting pointer to File.
    push rdx 
    
    ; reading data for specific transportation.
    ; since this specific data has the same number type,
    ; we can read it in general transportation function.
    mov rdi, rax   ; pointer to file.
    mov rsi, formd ; format.
    ;mov rdx, rbx   ; adress.
    mov rax, 0     ;
    call fscanf

    leave
    ret
    
_endInTransportation:
    mov rcx, 10
    leave
    ret
    
    
