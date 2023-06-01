.model small ; version 106
.stack 100h
.data
    message2 db 'start words... $'
    message db '                              Write the length of the base of the triangle: $'
    message1 db '                               Write the length of the height of the triangle: $'
    base dw ?
    height dw ?
    hecal dw ?
    bacal dw ?
    hecal1 dw ?
    ans dw ?
    pow_val dw ?
    base_pow dw ?
    height_pow dw ?
    height_pow_deg dw ?
    height_pow_2 dw ?
    other dw ?
    re dw ?
    cheight dw ?
    base10r dw ?
    height10u dw ?
.code       
    mov ax, @data
    mov ds, ax
 
 
    
      start:
    ; mevakesh et habasis
    mov ah, 09h
    lea dx, message2
    int 21h
    
 
 
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
    mov al, 10 ; multiply by 10
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
    mov al, 10 ; multiply by 10
    mul bl ; machpil et BL by 10
    mov height, ax ; shomer et hatotzaa be-base
    
    
    
    
   ; xor ax, ax
 
    
    ; Compare base and height
    ;mov ax, base
    ;cmp 0, ax

    ; Jump back to start if base > height
     ;jg start
     ;jmp exit2

;call_note: 
 ;   call note
    
    

;exit2:
   
    xor ax, ax
    mov ax, height
    mov cheight, ax
    
    
    
;mov ax, cheight   ; Move the dividend value to AX
;cwd                ; Sign-extend AX into DX:AX for signed division

;mov bx, base    ; Move the divisor value to BX
;div bx             ; Divide DX:AX by BX (quotient in AX, remainder in DX)
;mov ans, ax 
    

   ;devide by 10 height             
mov ax, height     ; Move the value of height to AX
mov dx, 0          ; Clear DX to prepare for division
mov bx, 10         ; Move the divisor (10) to BX

div bx             ; Divide DX:AX by BX (result in AX, remainder in DX)

mov height10u, ax     ; Move the quotient back to height
               

 
 
 
   ;devide by 10 base             
mov ax, base     ; Move the value of height to AX
mov dx, 0          ; Clear DX to prepare for division
mov bx, 10         ; Move the divisor (10) to BX

div bx             ; Divide DX:AX by BX (result in AX, remainder in DX)

mov base10r, ax     ; Move the quotient back to height



 
    
    
     ;xor ax, ax 
     ;shr height, 1
     ;mov ax, height
     ;mov re, ax    
                
                   
                   
    
     ; Set video mode
    mov ah, 00h
    mov al, 13h
    int 10h

    ; hagdarot rishoniot
    mov ah, 0ch   ; Set pixel color and position
    mov al, 10    ; Blue color

    ; metzayer et habasis
    mov bx, 0         ; Start with zero length
    mov bx, base
    mov dx, 100        ; nekudat ha-y
    mov cx, 30        ; nekudat ha-x
    
    call draw_base 
    
 
   ; Calculate the y-coordinate for the right line based on the current value of cx
    mov si, 100                  ; Store the current value of cx in si
    mov cx, cheight                ; Subtract the base length from cx
    sub si, cx
    mov other, si 
    
   
     
     
    ; metzayer et habasis
    mov bx, 0         ; Start with zero length
    mov bx, base
    mov dx, other        ; nekudat ha-y
    mov cx, 30        ; nekudat ha-x 
    
    
     call draw_base
     
     
      
      
      

 

      
      
      
     mov dx, 100 
      
      
      
      
          ; Draw the left line of the triangle
    mov cx, 30                    ; Set x-coordinate to 30
    mov bx, 10                ; Set height of triangle
          
          
          
    call draw_left_line
    
 
    
       ; Calculate the x-coordinate for the right line based on the current value of cx
    mov si, 30                  ; Store the current value of cx in si
    mov cx, base                ; Subtract the base length from cx
    add cx, si                  ; Add the base length back to cx

    ; Draw the right line of the triangle
    mov dx, 100                  ; Calculate y-coordinate for the right line
    mov bx, 10               ; Set height of triangle 
    
    call draw_right_line 
      
      
      
      
      
      
      
      
      
      
     
     
     
     exit:
mov ax, 4c00h
int 21H     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
 
 
 

;note proc
   
 ;   mov ah, 09h
  ;  lea dx, message3
   ; int 21h
    ;jmp start    
;ret
;note endp     
 
 
 
 
;bx: line lenght
;cx: x cord
;dx: y cord
draw_base proc
    
next_pixel:    
    mov al, 10      ; Blue color
    mov ah, 0ch     ; Set pixel color and position
    int 10h         ; Plot pixel

    ;inc ax          ; Move right one pixel
    inc cx          ; Increase length by 1 pixel
    
    dec bx
    cmp bx, 0
    jne next_pixel
    
    ret             
draw_base endp
;drawing 










draw_left_line proc
draw_left_line_lab:
        add cx, base10r        ; Move right one pixel
        sub dx, height10u       ; Move up one pixel
        int 10h      ; Plot pixel                                         
        dec bx       ; Decrease height by 1 pixel
        jnz draw_left_line_lab ; Jump if height is not zero
        
        ret   
draw_left_line endp



draw_right_line proc
draw_right_line_lab:    
        sub cx, base10r       ; Move left one pixel 
        sub dx, height10u       ; Move up one pixel
        int 10h      ; Plot pixel
        dec bx       ; Decrease height by 1 pixel
        jnz draw_right_line_lab ; Jump if height is not zero

        ret         
draw_right_line endp

end