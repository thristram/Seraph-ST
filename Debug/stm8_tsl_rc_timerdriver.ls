   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  38                     	bsct
  39  0000               _TSL_Tick_Base:
  40  0000 00            	dc.b	0
  41  0001               _TSL_Tick_10ms:
  42  0001 00            	dc.b	0
  43  0002               _TSL_Tick_100ms:
  44  0002 00            	dc.b	0
  45  0003               _TSL_TickCount_ECS_10ms:
  46  0003 00            	dc.b	0
  47  0004               _TSL_Tick_User:
  48  0004 00            	dc.b	0
  83                     ; 60 void TSL_Timer_Init(void)
  83                     ; 61 {
  85                     .text:	section	.text,new
  86  0000               _TSL_Timer_Init:
  90                     ; 63 	TSL_Tick_100ms = 0;
  92  0000 3f02          	clr	_TSL_Tick_100ms
  93                     ; 64 	TSL_Tick_10ms = 0;
  95  0002 3f01          	clr	_TSL_Tick_10ms
  96                     ; 65 	TSL_Tick_Base = 0;
  98  0004 3f00          	clr	_TSL_Tick_Base
  99                     ; 66 	TSL_TickCount_ECS_10ms = 0;
 101  0006 3f03          	clr	_TSL_TickCount_ECS_10ms
 102                     ; 67 	TSL_Tick_Flags.whole = 0;
 104  0008 3f00          	clr	_TSL_Tick_Flags
 105                     ; 69 	TIMTICK->SR1 = 0;       // clear overflow flag
 107  000a 725f5342      	clr	21314
 108                     ; 71 	if ( CLK->CKDIVR == 0x00 ) // Max CPU freq = 16 MHz
 110  000e 725d50c6      	tnz	20678
 111  0012 2606          	jrne	L53
 112                     ; 73 		TIMTICK->PSCR = 6;     // Prescaler to divide Fcpu by 64: 4 us clock.
 114  0014 35065345      	mov	21317,#6
 116  0018 2004          	jra	L73
 117  001a               L53:
 118                     ; 78 		TIMTICK->PSCR = 7;     // Prescaler to divide Fcpu by 128: x.xx us clock.
 120  001a 35075345      	mov	21317,#7
 121  001e               L73:
 122                     ; 81 	TIMTICK->ARR = 124;      // 125 * 4 us = 500 us.
 124  001e 357c5346      	mov	21318,#124
 125                     ; 82 	TIMTICK->IER = 0x01;     // Enable interrupt
 127  0022 35015341      	mov	21313,#1
 128                     ; 83 	TIMTICK->CR1 = 0x01;     // Start timer
 130  0026 35015340      	mov	21312,#1
 131                     ; 85 }
 134  002a 81            	ret
 160                     ; 98 void TSL_Timer_Check_1sec_Tick(void)
 160                     ; 99 {
 161                     .text:	section	.text,new
 162  0000               _TSL_Timer_Check_1sec_Tick:
 166                     ; 100 	if ( TSL_Tick_100ms >= 10 )
 168  0000 b602          	ld	a,_TSL_Tick_100ms
 169  0002 a10a          	cp	a,#10
 170  0004 250a          	jrult	L15
 171                     ; 102 		TSL_Tick_100ms -= 10;
 173  0006 b602          	ld	a,_TSL_Tick_100ms
 174  0008 a00a          	sub	a,#10
 175  000a b702          	ld	_TSL_Tick_100ms,a
 176                     ; 103 		TSL_Tick_Flags.b.DTO_1sec = 1;  // Tick Flag for Max On Duration set every second.
 178  000c 72100000      	bset	_TSL_Tick_Flags,#0
 179  0010               L15:
 180                     ; 106 }
 183  0010 81            	ret
 210                     ; 119 void TSL_Timer_Check_100ms_Tick(void)
 210                     ; 120 {
 211                     .text:	section	.text,new
 212  0000               _TSL_Timer_Check_100ms_Tick:
 216                     ; 121 	if ( TSL_Tick_10ms >= 10 )
 218  0000 b601          	ld	a,_TSL_Tick_10ms
 219  0002 a10a          	cp	a,#10
 220  0004 250b          	jrult	L36
 221                     ; 123 		TSL_Tick_10ms -= 10;
 223  0006 b601          	ld	a,_TSL_Tick_10ms
 224  0008 a00a          	sub	a,#10
 225  000a b701          	ld	_TSL_Tick_10ms,a
 226                     ; 124 		TSL_Tick_100ms++;
 228  000c 3c02          	inc	_TSL_Tick_100ms
 229                     ; 125 		TSL_Timer_Check_1sec_Tick();
 231  000e cd0000        	call	_TSL_Timer_Check_1sec_Tick
 233  0011               L36:
 234                     ; 127 }
 237  0011 81            	ret
 265                     ; 140 void TSL_Timer_Check_10ms_Tick(void)
 265                     ; 141 {
 266                     .text:	section	.text,new
 267  0000               _TSL_Timer_Check_10ms_Tick:
 271                     ; 142 	if ( TSL_Tick_Base >= TICK_FACTOR_10MS )
 273  0000 b600          	ld	a,_TSL_Tick_Base
 274  0002 a114          	cp	a,#20
 275  0004 250d          	jrult	L57
 276                     ; 144 		TSL_Tick_Base -= TICK_FACTOR_10MS;
 278  0006 b600          	ld	a,_TSL_Tick_Base
 279  0008 a014          	sub	a,#20
 280  000a b700          	ld	_TSL_Tick_Base,a
 281                     ; 145 		TSL_Tick_10ms++;
 283  000c 3c01          	inc	_TSL_Tick_10ms
 284                     ; 146 		TSL_TickCount_ECS_10ms++;   // Tick Flag for Drift increment every 10 ms.
 286  000e 3c03          	inc	_TSL_TickCount_ECS_10ms
 287                     ; 147 		TSL_Timer_Check_100ms_Tick();
 289  0010 cd0000        	call	_TSL_Timer_Check_100ms_Tick
 291  0013               L57:
 292                     ; 149 }
 295  0013 81            	ret
 298                     	switch	.data
 299  0000               L77_cnt_2ms:
 300  0000 00            	dc.b	0
 301  0001               L101_cnt_100ms:
 302  0001 00            	dc.b	0
 303  0002               L301_cnt_1s:
 304  0002 0000          	dc.w	0
 349                     ; 156 void Sys_Time_Manage(void)
 349                     ; 157 {
 350                     .text:	section	.text,new
 351  0000               _Sys_Time_Manage:
 355                     ; 162 	cnt_2ms++;
 357  0000 725c0000      	inc	L77_cnt_2ms
 358                     ; 163 	if(cnt_2ms >= 4){
 360  0004 c60000        	ld	a,L77_cnt_2ms
 361  0007 a104          	cp	a,#4
 362  0009 2508          	jrult	L521
 363                     ; 164 		cnt_2ms = 0;
 365  000b 725f0000      	clr	L77_cnt_2ms
 366                     ; 165 		f_2ms = 1;		
 368  000f 72120000      	bset	_Flag1_,#1
 369  0013               L521:
 370                     ; 168 	cnt_100ms++;
 372  0013 725c0001      	inc	L101_cnt_100ms
 373                     ; 169 	if(cnt_100ms >= 200){
 375  0017 c60001        	ld	a,L101_cnt_100ms
 376  001a a1c8          	cp	a,#200
 377  001c 2508          	jrult	L721
 378                     ; 170 		cnt_100ms = 0;
 380  001e 725f0001      	clr	L101_cnt_100ms
 381                     ; 171 		f_100ms = 1;		
 383  0022 72140000      	bset	_Flag1_,#2
 384  0026               L721:
 385                     ; 174 	cnt_1s++;
 387  0026 ce0002        	ldw	x,L301_cnt_1s
 388  0029 1c0001        	addw	x,#1
 389  002c cf0002        	ldw	L301_cnt_1s,x
 390                     ; 175 	if(cnt_1s >= 2000){
 392  002f ce0002        	ldw	x,L301_cnt_1s
 393  0032 a307d0        	cpw	x,#2000
 394  0035 2508          	jrult	L131
 395                     ; 176 		cnt_1s = 0;
 397  0037 5f            	clrw	x
 398  0038 cf0002        	ldw	L301_cnt_1s,x
 399                     ; 177 		f_1s = 1;		
 401  003b 72180000      	bset	_Flag1_,#4
 402  003f               L131:
 403                     ; 180 }
 406  003f 81            	ret
 435                     ; 194 @interrupt void TSL_Timer_ISR(void)
 435                     ; 195 {
 436                     .text:	section	.text,new
 437  0000               _TSL_Timer_ISR:
 440  0000 3b0002        	push	c_x+2
 441  0003 be00          	ldw	x,c_x
 442  0005 89            	pushw	x
 443  0006 3b0002        	push	c_y+2
 444  0009 be00          	ldw	x,c_y
 445  000b 89            	pushw	x
 448                     ; 197 	TIMTICK->SR1 = 0;      // clear overflow flag
 450  000c 725f5342      	clr	21314
 451                     ; 199 	f_500us = 1;
 453  0010 72100000      	bset	_Flag1_,#0
 454                     ; 200 	Sys_Time_Manage();
 456  0014 cd0000        	call	_Sys_Time_Manage
 458                     ; 201 	TSL_Tick_Base++;
 460  0017 3c00          	inc	_TSL_Tick_Base
 461                     ; 202 	TSL_Timer_Check_10ms_Tick();
 463  0019 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 465                     ; 204 	if (TSL_Tick_Flags.b.User_Start_100ms) 		/* Application request */
 467  001c b600          	ld	a,_TSL_Tick_Flags
 468  001e a502          	bcp	a,#2
 469  0020 270c          	jreq	L341
 470                     ; 206 		TSL_Tick_Flags.b.User_Start_100ms = 0;
 472  0022 72130000      	bres	_TSL_Tick_Flags,#1
 473                     ; 207 		TSL_Tick_Flags.b.User_Flag_100ms = 0;
 475  0026 72150000      	bres	_TSL_Tick_Flags,#2
 476                     ; 208 		TSL_Tick_User = (TICK_FACTOR_10MS * 10);
 478  002a 35c80004      	mov	_TSL_Tick_User,#200
 479  002e               L341:
 480                     ; 211 	if (TSL_Tick_User > 0)
 482  002e 3d04          	tnz	_TSL_Tick_User
 483  0030 270a          	jreq	L541
 484                     ; 213 		TSL_Tick_User--;
 486  0032 3a04          	dec	_TSL_Tick_User
 487                     ; 214 		if (TSL_Tick_User == 0)
 489  0034 3d04          	tnz	_TSL_Tick_User
 490  0036 2604          	jrne	L541
 491                     ; 216 			TSL_Tick_Flags.b.User_Flag_100ms = 1; /* Give information to Application */
 493  0038 72140000      	bset	_TSL_Tick_Flags,#2
 494  003c               L541:
 495                     ; 220 }
 498  003c 85            	popw	x
 499  003d bf00          	ldw	c_y,x
 500  003f 320002        	pop	c_y+2
 501  0042 85            	popw	x
 502  0043 bf00          	ldw	c_x,x
 503  0045 320002        	pop	c_x+2
 504  0048 80            	iret
 540                     ; 235 void TSL_Timer_Adjust(u16 Delay)
 540                     ; 236 {
 541                     .text:	section	.text,new
 542  0000               _TSL_Timer_Adjust:
 544  0000 89            	pushw	x
 545       00000000      OFST:	set	0
 548                     ; 238 	disableInterrupts();
 551  0001 9b            sim
 553  0002               L561:
 554                     ; 242 		if (Delay > TICK_FACTOR_10MS) 			/* delay > 10ms */
 556  0002 1e01          	ldw	x,(OFST+1,sp)
 557  0004 a30015        	cpw	x,#21
 558  0007 2512          	jrult	L371
 559                     ; 244 			TSL_Tick_Base += TICK_FACTOR_10MS;
 561  0009 b600          	ld	a,_TSL_Tick_Base
 562  000b ab14          	add	a,#20
 563  000d b700          	ld	_TSL_Tick_Base,a
 564                     ; 245 			Delay -= TICK_FACTOR_10MS;
 566  000f 1e01          	ldw	x,(OFST+1,sp)
 567  0011 1d0014        	subw	x,#20
 568  0014 1f01          	ldw	(OFST+1,sp),x
 569                     ; 246 			TSL_Timer_Check_10ms_Tick();
 571  0016 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 574  0019 200c          	jra	L761
 575  001b               L371:
 576                     ; 250 			TSL_Tick_Base++;
 578  001b 3c00          	inc	_TSL_Tick_Base
 579                     ; 251 			Delay--;
 581  001d 1e01          	ldw	x,(OFST+1,sp)
 582  001f 1d0001        	subw	x,#1
 583  0022 1f01          	ldw	(OFST+1,sp),x
 584                     ; 252 			TSL_Timer_Check_10ms_Tick();
 586  0024 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 588  0027               L761:
 589                     ; 255 	while ( Delay );
 591  0027 1e01          	ldw	x,(OFST+1,sp)
 592  0029 26d7          	jrne	L561
 593                     ; 257 	enableInterrupts();
 596  002b 9a            rim
 598                     ; 259 }
 602  002c 85            	popw	x
 603  002d 81            	ret
 785                     	xdef	_Sys_Time_Manage
 786                     	xdef	_TSL_Tick_User
 787                     	xref	_Flag1_
 788                     	xdef	_TSL_Timer_Check_10ms_Tick
 789                     	xdef	_TSL_Timer_Check_100ms_Tick
 790                     	xdef	_TSL_Timer_Check_1sec_Tick
 791                     	xdef	_TSL_Timer_Adjust
 792                     	xdef	_TSL_Timer_ISR
 793                     	xdef	_TSL_Timer_Init
 794                     	switch	.ubsct
 795  0000               _TSL_Tick_Flags:
 796  0000 00            	ds.b	1
 797                     	xdef	_TSL_Tick_Flags
 798                     	xdef	_TSL_TickCount_ECS_10ms
 799                     	xdef	_TSL_Tick_100ms
 800                     	xdef	_TSL_Tick_10ms
 801                     	xdef	_TSL_Tick_Base
 802                     	xref.b	c_x
 803                     	xref.b	c_y
 823                     	end
