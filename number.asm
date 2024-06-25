
; ------------------- onboard LCD registers ----------------- 
command_write:  equ  50h 
command_read: equ  52h 
data_write:   equ  51h 
data_read:   equ  53h 
busy:   equ  80h 
;-------------------------------------------------------------------- 
  ORG 8100H 
  CALL init_lcd 
  LXI H,0000H 
  CALL goto_xy 
  LXI H,DATA1  
  CALL  put_str_lcd 
check:   LXI H,0001H 
  CALL goto_xy 
  LXI H,DATA2  
  CALL  put_str_lcd 
  CALL DELAY 
  LXI H,0001H 
  CALL goto_xy 
  LXI H,CLEARDAT 
  CALL  put_str_lcd 
  CALL DELAY 
  JMP  check 
  HLT 
DELAY: MVI C,0C0H 
INL:  MVI B,0FFH 
DLY1: DCR B 
  JNZ DLY1 
  DCR  C 
  JNZ INL 
  RET 
; --------------------- LCD driver routines ----------------- 
lcd_ready:  push psw 
lcd_ready1:  in command_read 
  ani busy 
  jnz lcd_ready1 ; wait until lcd ready 
  pop psw 
  ret 
 
clear_lcd:  call lcd_ready 
  mvi a,1 
  out command_write 
exit_clear:  ret 
 
init_lcd:  call lcd_ready 
  mvi a,38h 
  out command_write 
  call lcd_ready 
  mvi a, 0ch 
  out command_write 
  call clear_lcd 
  ret 
; print ASCII text on LCD 
; entry: HL pointer with 0 for end of string 
 
put_str_lcd:   
mov a,m  ; get A from [HL] 
  cpi 0 
  jnz put_str_lcd1 
  ret 
 
put_str_lcd1: 
  call lcd_ready 
  out data_write 
  inx h 
  jp put_str_lcd 

; goto_xy set cursor location on lcd 
; entry: HL: H = x, L = y 
 
goto_xy:  call lcd_ready 
  mov a,l 
  cpi 0 
  jnz goto_xy1 
  mov a,h 
  adi 80h 
  out command_write 
  ret 
 
goto_xy1:  cpi 1 
  jnz goto_xy2 
  mov a,h 
  adi 0c0h 
  out command_write 
  ret 
 
goto_xy2:  cpi 2 
  jnz goto_xy3 
  mov a,h 
  adi 094h 
  out command_write 
  ret 
goto_xy3:  cpi 3 
  jnz goto_xy4 
  mov a,h 
  adi 0d4h 
  out command_write 
  ret 
 
goto_xy4:  ret 
 
put_ch_lcd:  call lcd_ready 
  out data_write 
  ret 
 
DATA1:   DFB  4DH,69H,63H,72H,6FH,50H,20H,53H 
	 DFB 79H,73H,74H,65H,6DH,00H; asci for”MicroP System”   
DATA2:   DFB  "System Ready!!",0;  
CLEARDAT:  DFB  "                  ",0 