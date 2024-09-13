BITS 16
ORG 0x8000 ;arraque que se definio en en el bin


start:
    call configurar_pantalla
    mov si, menu_principal
    call imprimir

enciclado_principal:
    mov ah, 0x00
    int 0x16 ;interrupcion para el teclado

    cmp al, 'i'
    je comenzar

    cmp al, 'x' ;salir
    je salir

    jmp enciclado_principal

leer_teclas:
    mov ah, 00h          
    int 16h  

    cmp al, 'x'
    je salir        

    cmp al, 'w'        
    je arriba

    cmp al, 'a'        
    je izquierda

    cmp al, 's'     
    je abajo

    cmp al, 'd'   
    je derecha


    jmp leer_teclas 

configurar_pantalla:
    mov ax, 0x03
    int 0x10
    ret

volver_a_comenzar:
    jmp start


comenzar:
    call configurar_pantalla
    call arriba 

salir:
    call configurar_pantalla
    mov si, mensaje_finalizado
    call imprimir
    cli
    hlt
    jmp $


imprimir:
    mov ah, 0x0E

.next_char:
    lodsb               
    cmp al, 0         
    je .done           
    int 0x10           
    jmp .next_char  

.done:
    ret

arriba:
    call configurar_pantalla
    arr db '####     ###    #####   #####   #####   #   #', 0x0D, 0x0A
                db '#   #   #   #   #       #       #        # # ', 0x0D, 0x0A
                db '# ##    #   #   #####   #####   ####      #  ', 0x0D, 0x0A
                db '#   #   #####       #       #   #         #  ', 0x0D, 0x0A
                db '####    #   #   #####   #####   #####     #  ', 0x0D, 0x0A, 0
    mov si ,arr
    call imprimir
    jmp leer_teclas

abajo:
    call configurar_pantalla
    abj db '####    #   #   #####   #####   #####     #  ', 0x0D, 0x0A
                db '#   #   #####   #       #       #         #  ', 0x0D, 0x0A
                db '# ##    #   #   #####   #####   ####      #  ', 0x0D, 0x0A
                db '#   #   #   #       #       #   #        # # ', 0x0D, 0x0A
                db '####     ###    #####   #####   #####   #   #', 0x0D, 0x0A, 0             
    mov si ,abj
    call imprimir
    jmp leer_teclas


izquierda:
    call configurar_pantalla
    izq db '#    ', 0x0D,0x0A
                 db ' #   ', 0x0D,0x0A
                 db '  ###', 0x0D,0x0A
                 db ' #   ', 0x0D,0x0A
                 db '#    ', 0x0D,0x0A
                 
                  db '', 0x0D,0x0A

                 db '#   #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#####', 0x0D,0x0A
                 
                  db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

 		 db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                 db '', 0x0D,0x0A

                 db ' ####', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db ' ####', 0x0D,0x0A

                  db '', 0x0D,0x0A

                 db ' # # ', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A
                 db '#####', 0x0D,0x0A,0  
    mov si ,izq
    call imprimir
    jmp leer_teclas

derecha:
    call configurar_pantalla
    der db '#####', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db ' # # ', 0x0D,0x0A

                 db '', 0x0D,0x0A


                 db '#### ', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db '#### ', 0x0D,0x0A

                 db '', 0x0D,0x0A
   

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                  db '', 0x0D,0x0A


                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                 db '', 0x0D,0x0A

                 db '#####', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A

                  db '', 0x0D,0x0A


                 db '    #', 0x0D,0x0A
                 db '   # ', 0x0D,0x0A
                 db '###  ', 0x0D,0x0A
                 db '   # ', 0x0D,0x0A
                 db '    #', 0x0D,0x0A,0
    mov si ,der
    call imprimir
    jmp leer_teclas

menu_principal db 'Precione una tecla:', 0x0D, 0x0A
     db 'i: Iniciar el juego', 0x0D, 0x0A
     db 'x: Salir del programa', 0x0D, 0x0A, 0

mensaje_finalizado db '...', 0

times 2000-($-$$) db 0 
dw 0xAA55         
