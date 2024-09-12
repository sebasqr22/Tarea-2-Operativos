BITS 16 ; se usan 16 bits 
ORG 0x7C00 ; direccion de inicio


start:
    mov ax, 0x0003 ; limpiar la pantalla
    int 0x10 ; interrupcion de video

    mov si, mensaje_bienvenida ; direccion del mensaje
    call imprimir ; imprimir mensaje

esperar_tecla:
    mov ah, 0 ; esperar_tecla
    int 0x16 ; interrupcion de teclado
    cmp al, 'y' ; si la tecla es 'y'
    je comenzar_juego ; saltar a comenzar_juego
    jmp esperar_tecla ; si no, esperar_tecla


comenzar_juego:
    mov ax, 0x0003 ; limpiar la pantalla
    int 0x10 ; interrupcion de video
    call generar_posiciones_random ; generar posiciones random
    call imprimir_nombres ; imprimir nombres


teclas:
    mov ah, 00h ;leer codigo de la tecla
    int 16h ;interrupcion de teclado

    cmp al, 'w' ; tecla w
    je limpiar_pantalla_aux ; saltar a limpiar_pantalla_aux
    cmp al, 'a' ; tecla a
    je limpiar_pantalla_aux ; saltar a limpiar_pantalla_aux
    cmp al, 's' ; tecla s
    je limpiar_pantalla_aux ; saltar a limpiar_pantalla_aux
    cmp al, 'd' ; tecla d
    je limpiar_pantalla_aux ; saltar a limpiar_pantalla_aux

    jmp teclas ; si no, esperar_tecla


limpiar_pantalla_aux:
    call limpiar_pantalla ; limpiar la pantalla
    call imprimir_nombres ; imprimir nombres
    jmp teclas ; esperar_tecla

hang:
    jmp hang ; bucle infinito


imprimir: