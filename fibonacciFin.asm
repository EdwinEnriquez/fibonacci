!algorithmist.com Fibonacci

!author:Edwin Enriquez
!Description about the program


.begin
.org 2048
.macro push arg
    st arg,%r14
    sub %r14,4,%r14
.endmacro

.macro pop arg  
    add %r14,4,%r14
    ld %r14,arg
.endmacro
.macro reset_stack
    sethi 0x1FFFFF,%r14
    or %r14,0x3FC,%r14
.endmacro

main:
    reset_stack
    mov n,%r2
    ld %r2,%r1
    push %r1   !guardar el valor en la pila

    call Fibonacci  
    pop %r1
    
    halt

Fibonacci: 

    pop %r1 !r1<-n  !recuperar valor n de la pila
    push %r15.      !guarda direccion de retorno
    cmp %r1,2.      !caso base
    bge L1
    mov %r1, %r2    !si n es uno o cero se regresa n f(1)=1 f(0)=0
    ba L2           !saltar siempre al final
    L1:
    sub %r1,1,%r4    !calcular n-1
    push %r1         !salvar n
    push %r4         !salvar n-1 en el tope de la pila
    call Fibonacci   !calcular fibonacci de n-1
    pop %r4          ! obtener el resultado de f(n-1)
    pop %r1          !obtener n
    sub %r1,2,%r5    !calcular n-2
    push %r4         !Salvar n-1
    push %r1         !Salvar n
    push %r5         !Salvar n-2
    call Fibonacci   !Calcular f(n-2)
    pop %r5          !obtener f(n-2)
    pop %r1          !obterner n
    pop %r4          ! obterner f(n-1)
    add %r4,%r5,%r2  !sumar f(n-1)+f(n-2)
    L2:              !recuperar el salto de regreso, respaldar el resultado en el tope de la pila
    pop %r15         
    push %r2
    jmpl %r15+4,%r0
n:4 !fibonacci 4
res: 
.end
