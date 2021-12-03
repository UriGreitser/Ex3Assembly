.section .rodata
    .align 8
    .Switch:
    .quad .Case50Or60
    .quad .CaseDefault
    .quad .Case52
    .quad .Case53
    .quad .Case54
    .quad .Case55
    .quad .Case56
    .quad .Case57
    .quad .Case58
    .quad .Case59
    .quad .Case60

    formatPrintOf50: .string "first pstring length: %d, second pstring length: %d\n"
     formatPrintOf52: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
     formatPrintOf53: .string "length: %d, string: %s\n"
     fomratPrintOf54: .string "length: %d, string: %s\n"
     formatPrintOf55: .string "compare result: %d\n"
     formatDefault: .string "invalid option!\n"
          string_format: .string "%s"
          int_format: .string "%d"


.text
.global run_func
.type run_func, @function
   
run_func:
    # write your code here
    #%rsi - the operation
    pushq %rbp
    movq  %rsp, %rbp
    leaq -50(%rdx), %r15 #substracts 50 from the operation
    cmpq $10, %r15 #compares 10 with rsi
    ja .CaseDefault #if %rsi is above 10, jumps to default
    cmpq $0, %r15
    jb .CaseDefault
    jmp *.Switch(,%r15,8) #

    xorq  %rax, %rax
    movq $10, %r11

        .CaseDefault:
        movq $formatDefault, %rdi
        movq $0, %rax
        call printf
         ret

         .Case50Or60:
         movq %r12, %rsi
         call pstrlen
         xor %r12, %r12
         movb %al, %r12b
         movq %r13, %rsi
         call pstrlen
         xor %r13, %r13
         movb %al, %r13b
         movq $formatPrintOf50, %rdi
         xor %rdx, %rdx
         movq %r12, %rsi
         movq %r13, %rdx
         xor %rax, %rax
         call printf
         movq %rbp, %rsp
         pop %rbp
         ret

         .Case52:
           pushq %rbp
           movq  %rsp, %rbp
           #get the first char
           subq  $8, %rsp
           movq $string_format, %rdi
           leaq -8(%rbp), %rsi
           xor %rax, %rax
           call scanf
           xor %rcx, %rcx
           movb -8(%rbp), %r15b

           #gets the second char
           movq $string_format, %rdi
           leaq -7(%rbp), %rsi
           xor %rax, %rax
           call scanf
           xor %r8, %r8
           movb -7(%rbp), %r8b
           xor %rax, %rax

           #sends the right paramaters to the function, first string
           movq %r12, %rdi
           movzbq %r15b, %rsi
           movzbq %r8b, %rdx
           call replaceChar
           movq %rax, %r9

           #sends the right paramaters to the function, second string
           movq $string_format, %rdi
           movq %r13, %rdi
           movzbq %r15b, %rsi
           movzbq %r8b, %rdx
           call replaceChar
           movq %rax, %r13


           #print
           movq $formatPrintOf52, %rdi
           movzbq %r15b, %rsi
           movzbq %r8b, %rdx
           movq %r9, %rcx
           movq %r13, %r8
           call printf
           movq %rbp, %rsp
           pop %r15
           pop %rbp
           movq %rbp, %rsp
           pop %rbp
           xor %rax, %rax
           xor %rax, %rax
          ret

             .Case53:
                    pushq %rbp
                    movq  %rsp, %rbp
                    pushq %rdi
                    pushq %rsi
                    pushq %r8
                    pushq %r9

                    #gets the first number
                    subq  $8, %rsp
                    movq $int_format, %rdi
                    movq %rsp, %rsi
                    xor %rax, %rax
                    call scanf

                    #gets the second number
                    movq $int_format, %rdi
                    leaq 4(%rsp), %rsi
                    xor %rax, %rax
                    call scanf
                    xor %rcx, %rcx
                    xor %rdx, %rdx
                    leaq 4(%rsp), %rcx
                    movzbq (%rcx), %rcx
                    movl (%rsp), %edx
                    pop %rbp
                    pop %r9
                    pop %r8
                    popq %rsi
                    popq %rdi
                    call pstrijcpy

                    #print the first string
                    xor %rdi, %rdi
                    movq $formatPrintOf53, %rdi
                    xor %rsi, %rsi
                    movb (%r11), %sil
                    movq %r11, %rdx
                    add $1, %rdx
                    xor %rax, %rax
                    call printf

                    #print the second string
                    xor %rdi, %rdi
                    movq $formatPrintOf53, %rdi
                    xor %rsi, %rsi
                    movb (%r12), %sil
                    movq %r12, %rdx
                    add $1, %rdx
                    xor %rax, %rax
                    call printf




                    movq %rbp, %rsp
                    popq %rbp
                    movq $0, %rax
          ret

         .Case54:
         push %rsi
         call swapCase
         movq $fomratPrintOf54, %rdi
         xor %rsi, %rsi
         movb (%rax), %sil
         movq %rax, %rdx
         add $1, %rdx
         xor %rax, %rax
         call printf

          pop %rdi
          call swapCase
          xor %rdi, %rdi
          movq $fomratPrintOf54, %rdi
          xor %rsi, %rsi
          movb (%rax), %sil
          movq %rax, %rdx
          add $1, %rdx
          xor %rax, %rax
          call printf



          movq $0, %rax
          ret

         .Case55:
                    pushq %rbp
                    movq  %rsp, %rbp
                    pushq %rdi
                    pushq %rsi
                    pushq %r8
                    pushq %r9

                    #gets the first number
                    subq  $8, %rsp
                    movq $int_format, %rdi
                    movq %rsp, %rsi
                    xor %rax, %rax
                    call scanf

                    #gets the second number
                    movq $int_format, %rdi
                    leaq 4(%rsp), %rsi
                    xor %rax, %rax
                    call scanf
                    xor %rcx, %rcx
                    xor %rdx, %rdx
                    leaq 4(%rsp), %rcx
                    movzbq (%rcx), %rcx
                    movl (%rsp), %edx
                    pop %rbp
                    pop %r9
                    pop %r8
                    popq %rsi
                    popq %rdi
                    call pstrijcmp
          ret

         .Case56:
          jmp .CaseDefault
          ret

         .Case57:
          jmp .CaseDefault
          ret

         .Case58:
          jmp .CaseDefault
          ret

         .Case59:
          jmp .CaseDefault
          ret

         .Case60:
          jmp .Case50Or60
          ret



