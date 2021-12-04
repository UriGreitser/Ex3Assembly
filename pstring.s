.file "pstring.s"
.section .rodata
          string_format: .string "%s"
          int_format: .string "%d"
          invalid_format53:   .string "invalid input!\n"


.text
.global pstrlen,replaceChar, pstrijcpy, swapCase, pstrijcmp
  .type pstrlen @function
  #First function
pstrlen:
         xor %rax, %rax
         movb (%rsi), %al
         ret
  .type replaceChar @function
  #Second function
replaceChar:
leaq 1(%rdi), %r12
.loop:
    cmpb %sil, (%r12)
    je .replaceLabel
    cmpb $0,(%r12)
    je .returnLabel
    add $1, %r12
    jmp .loop


.replaceLabel:
movb %dl, (%r12)
add $1, %r12
jmp .loop

.returnLabel:
leaq 1(%rdi), %rax
ret

  .type pstrijcpy @function
  #Third function
pstrijcpy:
.setAdress:
movq %rdi, %r11
movq %rsi, %r12
addq %rdx, %rdi
addq %rdx, %rsi
addq $1, %rdi
addq $1, %rsi
addq $-1, %r8
addq $-1, %r9

.checkInvalid:
cmpq $0, %rdx
jb .invalidIndex
cmpq %r8, %rcx
ja .invalidIndex
cmpq %r9, %rcx
ja .invalidIndex
xor %rax, %rax
jmp .loop53

.loop53:
cmp %rcx, %rdx
je .lastIt
xor %r15, %r15
movb (%rsi), %r15b
movb %r15b, (%rdi)
addq $1, %rdx
addq $1, %rsi
addq $1, %rdi
jmp .loop53

.lastIt:
xor %r15, %r15
movb (%rsi), %r15b
movb %r15b, (%rdi)
movq %r11, %rax
ret



.invalidIndex:
movq $invalid_format53, %rdi
pushq %r11
xor %rax, %rax
call printf
pop %r11
ret

  .type swapCase @function
  #First function
swapCase:
 movq %rdi, %rdx
 add $1, %rdi
 .loop54:
 movb (%rdi), %r15b
 cmpb $0, %r15b
 je .done54
 xor %rax, %rax
 movb (%rdi), %r15b
 cmpb $65, %r15b
 jb .invalidCase54
 cmpb $122, %r15b
 ja .invalidCase54
 jmp .caseAbove65

.done54:
movq %rdx, %rax
ret

.invalidCase54:
add $1, %rdi
jmp .loop54

.caseAbove65:
 cmpb $91, %r15b
 jb .caseCap
 cmpb $97, %r15b
 jb .invalidCase54
 jmp .caseSmall

 .caseCap:
 add $32, %r15
 movb %r15b, (%rdi)
 add $1, %rdi
 jmp .loop54

 .caseSmall:
 add $-32, %r15
 movb %r15b, (%rdi)
 add $1, %rdi
 jmp .loop54



  .type pstrijcmp @function
  #Third function
pstrijcmp:
addq %rdx, %rdi
addq %rdx, %rsi
addq $1, %rdi
addq $1, %rsi
addq $-1, %r8
addq $-1, %r9

.checkInvalid55:
cmpq $0, %rdx
jb .invalidIndex55
cmpq %r8, %rcx
ja .invalidIndex55
cmpq %r9, %rcx
ja .invalidIndex55
xor %rax, %rax
jmp .loop55


.loop55:
    cmpq %rdx, %rcx
    je .LastIt55
    movzbq (%rdi), %r15
    movzbq (%rsi), %r14
    cmpb %r15b, %r14b
    leaq 1(%rdx), %rdx
    leaq 1(%rdi), %rdi
    leaq 1(%rsi), %rsi
    je .loop55
    ja .secondStringBigger
    jb .firstStringBigger

.invalidIndex55:
movq $invalid_format53, %rdi
xor %rax, %rax
call printf
xor %rax, %rax
movq $-2, %rax
ret

.LastIt55:
    movzbq (%rdi), %r15
    movzbq (%rsi), %r14
    cmpb %r15b, %r14b
    je .equalStrings
    ja .secondStringBigger
    jb .firstStringBigger

.equalStrings:
xor %rax, %rax
movq $0, %rax
ret


.secondStringBigger:
xor %rax, %rax
movq $-1, %rax
ret


.firstStringBigger:
xor %rax, %rax
movq $1, %rax
ret














