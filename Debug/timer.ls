   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 21 void Init_Time3(void)
  32                     ; 22 {
  34                     .text:	section	.text,new
  35  0000               _Init_Time3:
  39                     ; 24 	TIM3->PSCR = 0x06;//分频值 16M/2^6 = 250K
  41  0000 3506532a      	mov	21290,#6
  42                     ; 25 	TIM3->IER = 0x01;//使能触发中断
  44  0004 35015321      	mov	21281,#1
  45                     ; 26 	TIM3->CNTRH = 0;
  47  0008 725f5328      	clr	21288
  48                     ; 27 	TIM3->CNTRL = 250;//250*(1/250K) = 0.001s
  50  000c 35fa5329      	mov	21289,#250
  51                     ; 28 	TIM3->CNTRH = 0;
  53  0010 725f5328      	clr	21288
  54                     ; 29 	TIM3->CNTRL = 250;//自动重装的值
  56  0014 35fa5329      	mov	21289,#250
  57                     ; 31 }
  60  0018 81            	ret
  86                     ; 33 @interrupt void Tim3_UPD_OVF_BRK_ISR(void)
  86                     ; 34 {
  87                     .text:	section	.text,new
  88  0000               _Tim3_UPD_OVF_BRK_ISR:
  91  0000 3b0002        	push	c_x+2
  92  0003 be00          	ldw	x,c_x
  93  0005 89            	pushw	x
  94  0006 3b0002        	push	c_y+2
  95  0009 be00          	ldw	x,c_y
  96  000b 89            	pushw	x
  99                     ; 35 	f_1ms = 1;
 101  000c 72100000      	bset	_Flag1_,#0
 102                     ; 36 	Sys_Time_Manage();
 104  0010 cd0000        	call	_Sys_Time_Manage
 106                     ; 37 	TIM3->SR1 = 0x00;//清除中断标志
 108  0013 725f5322      	clr	21282
 109                     ; 38 }
 112  0017 85            	popw	x
 113  0018 bf00          	ldw	c_y,x
 114  001a 320002        	pop	c_y+2
 115  001d 85            	popw	x
 116  001e bf00          	ldw	c_x,x
 117  0020 320002        	pop	c_x+2
 118  0023 80            	iret
 143                     ; 47 void Sys_Time_Manage(void)
 143                     ; 48 {
 144                     .text:	section	.text,new
 145  0000               _Sys_Time_Manage:
 149                     ; 49 	systime_count[0]++;
 151  0000 be00          	ldw	x,_systime_count
 152  0002 1c0001        	addw	x,#1
 153  0005 bf00          	ldw	_systime_count,x
 154                     ; 50 	if (systime_count[0] >= 100)
 156  0007 be00          	ldw	x,_systime_count
 157  0009 a30064        	cpw	x,#100
 158  000c 2507          	jrult	L14
 159                     ; 52 		systime_count[0] = 0;
 161  000e 5f            	clrw	x
 162  000f bf00          	ldw	_systime_count,x
 163                     ; 53 		f_100ms = 1;
 165  0011 72120000      	bset	_Flag1_,#1
 166  0015               L14:
 167                     ; 55 	systime_count[1]++;
 169  0015 be02          	ldw	x,_systime_count+2
 170  0017 1c0001        	addw	x,#1
 171  001a bf02          	ldw	_systime_count+2,x
 172                     ; 56 	if (systime_count[1] >= 300)
 174  001c be02          	ldw	x,_systime_count+2
 175  001e a3012c        	cpw	x,#300
 176  0021 2507          	jrult	L34
 177                     ; 58 		systime_count[1] = 0;
 179  0023 5f            	clrw	x
 180  0024 bf02          	ldw	_systime_count+2,x
 181                     ; 59 		f_300ms = 1;
 183  0026 72140000      	bset	_Flag1_,#2
 184  002a               L34:
 185                     ; 61 	systime_count[2]++;
 187  002a be04          	ldw	x,_systime_count+4
 188  002c 1c0001        	addw	x,#1
 189  002f bf04          	ldw	_systime_count+4,x
 190                     ; 62 	if (systime_count[2] >= 1000)
 192  0031 be04          	ldw	x,_systime_count+4
 193  0033 a303e8        	cpw	x,#1000
 194  0036 2507          	jrult	L54
 195                     ; 64 		systime_count[2] = 0;
 197  0038 5f            	clrw	x
 198  0039 bf04          	ldw	_systime_count+4,x
 199                     ; 65 		f_1s = 1;
 201  003b 72160000      	bset	_Flag1_,#3
 202  003f               L54:
 203                     ; 67 }
 206  003f 81            	ret
 219                     	xdef	_Tim3_UPD_OVF_BRK_ISR
 220                     	xdef	_Sys_Time_Manage
 221                     	xdef	_Init_Time3
 222                     	xref.b	_Flag1_
 223                     	xref.b	_systime_count
 224                     	xref.b	c_x
 225                     	xref.b	c_y
 244                     	end
