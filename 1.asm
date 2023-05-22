.model small       ;version 104
.stack 100h
.data
    message db 'Write the length of the base of the triangle: $'
    message1 db 'Write the length of the height of the triangle: $'
    base dw ?
    height dw ?
    hecal dw ?
    bacal dw ?
    hecal1 dw ?
    ans dw ?
.code       



    mov ax, @data
    mov ds, ax

    ; mevakesh et habasis
    mov ah, 09h
    lea dx, message
    int 21h

    ; kore et hakelet
    mov ah, 01h
    int 21h
    sub al, 30h ; memir mispar le-aski
    mov bl, al ; shomer et hakelet be - bl
    mov ah, 00h ; Clear AH
    mov al, 0ah ; Use 0ah as the multiplier
    mul bl ; machpil et BL by 10
    mov base, ax ; shomer et hatotzaa be-base

    ; mevakesh et hagova
    mov ah, 09h
    lea dx, message1
    int 21h

    ; kore et hakelet
    mov ah, 01h
    int 21h
    sub al, 30h ; memir mispar le-aski
    mov bl, al ; shomer et hakelet be - bl
    mov ah, 00h ; Clear AH
    mov al, 0ah ; Use 0ah as the multiplier
    mul bl ; machpil et BL by 10
    mov height, ax ; shomer et hatotzaa be-base

    ; Set video mode
    mov ah, 00h
    mov al, 13h
    int 10h

    ; hagdarot rishoniot
    mov ah, 0ch   ; Set pixel color and position
    mov al, 10    ; Blue color

; metzayer et habasis
mov cx, base       ; orech shel habasis
mov dx, 80         ; nekudat ha-y
mov ax, 30         ; nekudat ha-x

draw_base:
    mov bh, 0       ; Page number
    mov al, 10      ; Blue color
    mov ah, 0ch     ; Set pixel color and position
    int 10h         ; Plot pixel

    inc ax          ; Move right one pixel
    dec cx          ; Decrease length by 1 pixel
    jnz draw_base   ; Repeat until cx (length) is zero

    mov ax, height    ; Move the value from height to AX
    mov hecal, ax     ; Copy the value from AX to hecal
    mov ax, base    ; Move the value from height to AX
    mov bacal, ax     ; Copy the value from AX to hecal
    shl hecal, 1 ; Multiply height by 2
    mov ax, hecal    ; Move the value from height to AX
    mov hecal1, ax     ; Copy the value from AX to hecal
    shr bacal, 1 ; divide height by 2    
    shl bacal, 1 ; Multiply base by 2 
    mov ax, hecal      ; Move the value of hecal to AX
    add ax, bacal      ; Add the value of bacal to AX
    mov hecal, ax      ; Copy the result from AX back to hecal
    
    
    
    
...
    ; Calculate the square root of hecal using Newton's method
    mov ax, hecal          ; Move the value of hecal to AX

    ; Set an initial guess for the square root
    mov bx, ax             ; Copy the value to BX
    shr bx, 1              ; Divide BX by 2 (right shift)

    ; Iterate to refine the square root approximation
    sqrt_iteration:
        mov cx, ax         ; Copy the original value to CX
        xor dx, dx         ; Clear DX
        div bx             ; Divide CX by BX (AX = CX / BX)

        ; Average the quotient and divisor to improve the approximation
        add ax, bx         ; Add BX to AX
        shr ax, 1          ; Divide AX by 2 (right shift)

        ; Check if the approximation is satisfactory
        cmp bx, ax         ; Compare BX and AX
        jae sqrt_done      ; Jump if approximation is satisfactory

        ; Update BX with the new approximation
        mov bx, ax         ; Copy the new approximation to BX
        jmp sqrt_iteration ; Repeat the iteration

    sqrt_done:
    mov hecal, ax          ; Store the square root result back to hecal

    ; Now hecal contains the square root of its original value

  ...    
  
      
      
      
  
    mov ax, hecal1      ; Move the value of hecal to AX
    cwd                ; Sign-extend AX into DX:AX for signed division

    mov bx, base       ; Move the value of base to BX
    idiv bx            ; Divide DX:AX by BX (result in AX, remainder in DX)  
    mov ans, ax
    
  
  
  
  


    ; Draw the left line of the triangle
    mov cx, 30                    ; Set x-coordinate to 30
    mov bx, hecal                 ; Set height of triangle
    draw_left_line:
        inc cx       ; Move right one pixel
        sub dx, ans       ; Move up one pixel
        int 10h      ; Plot pixel
        dec bx       ; Decrease height by 1 pixel
        jnz draw_left_line ; Jump if height is not zero

   ; Calculate the x-coordinate for the right line based on the current value of cx
mov si, cx                  ; Store the current value of cx in si
sub cx, base                ; Subtract the base length from cx
add cx, si                  ; Add the base length back to cx

    ; Draw the right line of the triangle
    mov dx, 80                  ; Calculate y-coordinate for the right line
    mov bx, hecal               ; Set height of triangle
    draw_right_line:
        dec cx       ; Move left one pixel 
        sub dx, ans       ; Move up one pixel
        int 10h      ; Plot pixel
        dec bx       ; Decrease height by 1 pixel
        jnz draw_right_line ; Jump if height is not zero



end