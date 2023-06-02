.model small ; version 108 - final 
.stack 100h
.data
message2 db '                                      _      _         _   ',13,10,  
    db '                     ___ __ _ _ _  __| |  __| |___  __| |__',13,10,
    db '                    (_-</ _, | , \/ _` | / _| / _ \/ _| / /',13,10,
    db '                    /__/\__,_|_||_\__,_| \__|_\___/\__|_\_\',13,10,'$'

    message5 db '                               write 1-10 number: $'
    message db '                                Write the length of the base of the triangle: $'
    message1 db '                               Write the length of the height of the triangle: $'
    message3 db '                               the base value cant be 0! try again $'
    message4 db '                               the height value cant be 0! try again $'
    base dw ?
    height dw ?
    ycord2 dw ?
    cheight dw ?
    base10r dw ?
    height10u dw ?
    color dw ?
    message6 db '                               choose a color - click: 5 for pink, 6 for orange, 7 for white   $'
   
.code       
    mov ax, @data
    mov ds, ax
 
 
 
   ; hodada 1
    mov ah, 09h         ; Set the function code for printing a string
    lea dx, message2    ; Load the offset of the message2 string into DX
    int 21h             ; Call the interrupt to display the message2 string
    
    
    
    ;hodada 2
    mov ah, 09h         ; Set the function code for printing a string
    lea dx, message5    ; Load the offset of the message5 string into DX
    int 21h             ; Call the interrupt to display the message2 string
    
    

start:
      ;color:
    
     ; mevakesh et habasis (Asks for the base)
    mov ah, 09h      ; Set the function code for printing a string
    lea dx, message6   ; Load the offset of the message string into DX
    int 21h           ; Call the interrupt to display the message string

    ; kore et hakelet (Reads the input character)
    mov ah, 01h      ; Set the function code for reading a character
    int 21h          ; Call the interrupt to read a character from the keyboard
    sub al, 30h      ; Subtract 30h to convert the ASCII digit to a numerical value
    mov bl, al       ; Move the numerical value to BL for further processing
    mov ah, 00h      ; Clear AH
    mov al, 1       ; Set AL to 10 for multiplication
    mul bl           
    mov color, ax    
    
    
    
    
    
    
    
    
    
    
    
    
    ; mevakesh et habasis (Asks for the base)
    mov ah, 09h      ; Set the function code for printing a string
    lea dx, message   ; Load the offset of the message string into DX
    int 21h           ; Call the interrupt to display the message string

    ; kore et hakelet (Reads the input character)
    mov ah, 01h      ; Set the function code for reading a character
    int 21h          ; Call the interrupt to read a character from the keyboard
    sub al, 30h      ; Subtract 30h to convert the ASCII digit to a numerical value
    mov bl, al       ; Move the numerical value to BL for further processing
    mov ah, 00h      ; Clear AH
    mov al, 10       ; Set AL to 10 for multiplication
    mul bl           ; Multiply BL by 10, result in AX
    mov base, ax     ; Store the multiplied value in the base variable

    ; mevakesh et hagova (Asks for the height)
    mov ah, 09h      ; Set the function code for printing a string
    lea dx, message1  ; Load the offset of the message1 string into DX
    int 21h           ; Call the interrupt to display the message1 string

    ; kore et hakelet (Reads the input character)
    mov ah, 01h      ; Set the function code for reading a character
    int 21h          ; Call the interrupt to read a character from the keyboard
    sub al, 30h      ; Subtract 30h to convert the ASCII digit to a numerical value
    mov bl, al       ; Move the numerical value to BL for further processing
    mov ah, 00h      ; Clear AH
    mov al, 10       ; Set AL to 10 for multiplication
    mul bl           ; Multiply BL by 10, result in AX
    mov height, ax   ; Store the multiplied value in the height variable



    ;shgiat 0
    xor ax, ax       ; menake et ax
    mov ax, base     ; machnis le-ax et base 
    cmp ax, 0        ; mashve le-0
    jle note1ca      ; holech le-label le-note1ca, less or equal
    
    ;shgiat 0
    xor ax, ax       ; menake et ax
    mov ax, height   ; machnis le-ax et height
    cmp ax, 0        ; mashve le-0
    jle note2ca      ; holech le-label le-note1ca

; Continue with the rest of the code if base > 0 and height > 0

    jmp exit2

note1ca:
call note1 
   

note2ca:
call note2
    



exit2:
    ;in order to save original height
    xor ax, ax       ; menke et ax
    mov ax, height   ; machnis le-ax et height
    mov cheight, ax  ; machnis le-cheight et ax
    
    
    
   ;devide height by 10              
    mov ax, height     ; Move the value of height to AX
    mov dx, 0          ; Clear DX to prepare for division
    mov bx, 10         ; Move the divisor (10) to BX
    div bx             ; Divide DX:AX by BX (result in AX, remainder in DX)
    mov height10u, ax  ; Move the quotient back to height10u
               

 
   ;devide base by 10              
    mov ax, base       ; Move the value of height to AX
    mov dx, 0          ; Clear DX to prepare for division
    mov bx, 10         ; Move the divisor (10) to BX
    div bx             ; Divide DX:AX by BX (result in AX, remainder in DX)
    mov base10r, ax    ; Move the quotient back to base10r


       
       
       
                         
    ; Set video mode
    mov ah, 00h        ; Video function: Set video mode
    mov al, 13h        ; Video mode: Mode 13h (320x200, 256-color graphics)
    int 10h            ; Trigger software interrupt to set video mode
    
    
    ; hagdarot rishoniot
    mov ah, 0ch        ; Set pixel color and position
    mov al, 10         ; green color
    
    
    ; metzayer et habasis
    mov bx, 0         ; Start with zero length
    mov bx, base      ; mispar hazarot
    mov dx, 100       ; nekudat ha-y
    mov cx, 30        ; nekudat ha-x
    
call draw_base 
    
    
    
    
   ; Calculate the y-coordinate for the right line 
    mov si, 100       ; machnis le-si et nekudat ha-y harishona           
    mov cx, cheight   ; machnis le-cx et cheight             
    sub si, cx        ; machsir benehem 
    mov ycord2, si    ; shomer be-ycord2 et nekudat ha-y hachadasha
   
          
    ; metzayer et habasis
    mov bx, 0         ; Start with zero length
    mov bx, base      ; mispar hazarot
    mov dx, ycord2    ; nekudat ha-y
    mov cx, 30        ; nekudat ha-x 
    
    
call draw_base


      
    mov dx, 100       ; nekudat ha-y 
    ; Draw the left line of the triangle
    mov cx, 30        ; Set x-coordinate to 30
    mov bx, 10        ; Set height of triangle
          
                
call draw_left_line
    
 
     
     
       ; Calculate the x-coordinate for the right line 
    mov si, 30         ; Store the current value of x cord in si
    mov cx, base       ; Store the base in cx
    add cx, si         ; Add the base length and the original x cord 

    ; Draw the right line of the triangle
    mov dx, 100              ; Calculate y-coordinate for the right line
    mov bx, 10               ; Set height of triangle 
    
call draw_right_line 
      
      

     
    exit:
mov ax, 4c00h
int 21H     
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    
 
 
;The base is equal to 0 
note1 proc
   
    mov ah, 09h
    lea dx, message3
    int 21h
    jmp start    
ret
note1 endp     
;write an error message on the base 
;return to the beginning of the code in order to type numbers again 
 
 

;The height is equal to 0
note2 proc
   
    mov ah, 09h
    lea dx, message4 
    int 21h
    jmp start    
ret
note2 endp
;write an error message on the height
;return to the beginning of the code in order to type numbers again

 
 
;bx: line lenght
;cx: x cord
;dx: y cord
draw_base proc
    
next_pixel:    
    mov ax, color
    mov ah, 0ch     ; Set pixel color and position
    int 10h         ; Plot pixel    
    inc cx          ; Increase length by 1 pixel - it increases the x-coordinate for the next pixel    
    dec bx          ; morid et hahazarot
    cmp bx, 0       ; bodek im siyem
    jne next_pixel  ;("not equal")
    
ret             
draw_base endp
;drawing 


  
  

;bx: number of repetitions of the function
;cx: how many pixels to draw to the right
;dx: how many pixels to draw up 
draw_left_line proc
draw_left_line_lab:
    add cx, base10r        ; Move right pixeles as the number of base/10 
    sub dx, height10u      ; Move up one pixeles as the number of height/10
    int 10h      ; Plot pixel                                         
    dec bx       ; Decrease et mispar hahazarot
    jnz draw_left_line_lab  
        
ret   
draw_left_line endp
;drawing

 
 

;bx: number of repetitions of the function
;cx: how many pixels to draw to the right
;dx: how many pixels to draw up
draw_right_line proc
draw_right_line_lab:    
    sub cx, base10r         ; Move left pixeles as the number of base/10 
    sub dx, height10u       ; Move up one pixeles as the number of height/10
    int 10h      ; Plot pixel
    dec bx       ; Decrease et mispar hahazarot
    jnz draw_right_line_lab 

ret         
draw_right_line endp
;drawing





end
