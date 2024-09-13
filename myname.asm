BITS 16
ORG 0x8000 ;arraque que se definio en en el bin

start:
    call configurar_pantalla
    mov si, menu_principal
    call imprimir

enciclado_principal:
    mov ah, 0x00
    int 0x16 ;interrupcion para el teclado

    cmp al, 'c'
    je comenzar

    cmp al, 's'salir
    je salir

    ; Vuelve al menú principal si la tecla no es reconocida
    jmp enciclado_principal

comenzar:
    call configurar_pantalla
    call arriba


leer_teclas:
    mov ah, 00h           ; Leer el código extendido de la tecla
    int 16h               ; Espera una tecla

    ; Verificar si la tecla es W, A, S o D
    cmp al, 48h        
    je arriba

    cmp al, 4Bh           ; Verificar si la tecla es 'a'
    je izquierda

    cmp al, 50h           ; Verificar si la tecla es 's'
    je abajo

    cmp al, 4Dh           ; Verificar si la tecla es 'd'
    je derecha

    cmp al, 'r'
    je volver_a_comenzar

    cmp al, 'p'
    je salir

    jmp leer_teclas    ; Continuar en el bucle de entrada de teclas

 
configurar_pantalla:
    ; Configura el modo de texto 80x25 con 16 colores
    mov ax, 0x03
    int 0x10
    ret

volver_a_comenzar:
    jmp start

salir:
    ; Se queda en un bucle infinito para detener el programa
    call configurar_pantalla
    mov si, mensaje_finalizado
    call imprimir
    cli
    hlt
    jmp $


imprimir:
    mov ah, 0x0E        ; Función 0Eh de BIOS para imprimir caracteres
.next_char:
    lodsb               ; Cargar el siguiente carácter de DS:SI en AL
    cmp al, 0           ; Comprobar si es el final de la cadena
    je .done            ; Si es cero, final de la cadena
    int 0x10            ; Llamar a la interrupción de video
    jmp .next_char      ; Continuar con el siguiente carácter
.done:
    ret


izquierda:
    call configurar_pantalla
    izq db '#    ', 0x0D,0x0A
                 db ' #   ', 0x0D,0x0A
                 db '  ###', 0x0D,0x0A
                 db ' #   ', 0x0D,0x0A
                 db '#    ', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '#   #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#####', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                  db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db ' ####', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db '#  # ', 0x0D,0x0A
                 db ' ####', 0x0D,0x0A

                  db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db ' # # ', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A
                 db '#####', 0x0D,0x0A,0  
    mov si ,izq
    call imprimir
    jmp leer_teclas

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

derecha:
    call configurar_pantalla
    der db '#####', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db ' # # ', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '#### ', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db ' #  #', 0x0D,0x0A
                 db '#### ', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                  db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '# ###', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '### #', 0x0D,0x0A

                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '#####', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '# # #', 0x0D,0x0A
                 db '#   #', 0x0D,0x0A

                  db '', 0x0D,0x0A
                 db '', 0x0D,0x0A
                 db '', 0x0D,0x0A

                 db '    #', 0x0D,0x0A
                 db '   # ', 0x0D,0x0A
                 db '###  ', 0x0D,0x0A
                 db '   # ', 0x0D,0x0A
                 db '    #', 0x0D,0x0A,0
    mov si ,der
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


menu_principal db 'Hola! Presiona alguna tecla:', 0x0D, 0x0A
     db '- c: iniciar', 0x0D, 0x0A
     db '- s: detener', 0x0D, 0x0A, 0


mensaje_finalizado db 'Se ha terminado el programa...', 0

times 995-($-$$) db 0   ; Rellenar con ceros hasta 510 bytes
dw 0xAA55              ; Firma del sector de arranque
