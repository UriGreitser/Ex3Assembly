.file "run_main.s"
.section .rodata
    formatPrintOf50: .string "first pstring length: %d, second pstring length: %d\n"
     formatPrintOf52: .string "old char: %c, new char: %c, first string: %s, second string: %s\n"
     formatPrintOf53: .string "length: %d, string: %s\n"
     fomratPrintOf54: .string "length: %d, string: %s\n "
     formatPrintOf55: .string "compare result: %d\n"
     formatDefault: .string "invalid option!\n"
          string_format: .string "%s"
                    int_format: .string "%d"

.text
.global run_main
.extern run_func
.type run_main, @function
   
run_main:
    # write your code here
    #%rsi - the operation

    #length of the first pstring
  pushq %rbp
  movq  %rsp, %rbp
  subq  $528, %rsp
  movq  $int_format, %rdi
  movq  %rsp, %rsi
  xor   %rax, %rax
  call  scanf

  #first string data
  movq  $string_format, %rdi
  leaq 1(%rsp), %rsi
  xor %rax, %rax
  call  scanf
  leaq (%rsp), %r12 #first pstring

  #second string length
    movq  $int_format, %rdi
    leaq 258(%rsp), %rsi
    xor   %rax, %rax
    call  scanf

      #second string data
      movq  $string_format, %rdi
      leaq 259(%rsp), %rsi
      xor %rax, %rax
      call  scanf
      leaq 258(%rsp), %r13 #first pstring

      #getting the operation
          movq  $int_format, %rdi
          leaq 515(%rsp), %rsi
          xor   %rax, %rax
          call  scanf

          leaq 515(%rsp), %r14 #first pstring
          xor %rdx, %rdx
          movb (%r14), %r15b
          movzbl %r15b, %rdx

          #saves the strings
          movq %r12, %rdi
          movq %r13, %rsi
          xor %r8, %r8
          xor %r9, %r9
          movb (%rdi), %r8b
          movb (%rsi), %r9b


          #push \0 into the strings
          push %r12
          push %r13
        #  leaq 1(%r8,%r12), %r12
        #  movb $0, (%r12)
        #  leaq 1(%r9,%r13), %r13
        #  movb $0, (%r13)


          pop %r13
          pop %r12
      #calling run_func
      #rdi - first pstring
      #rsi - second pstring
      #r8 - first length
      #r9 - second length
      call run_func
      movq %rbp, %rsp
      pop %rbp
      xor %rax, %rax
      ret






