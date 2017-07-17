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
  90                     ; 63   TSL_Tick_100ms = 0;
  92  0000 3f02          	clr	_TSL_Tick_100ms
  93                     ; 64   TSL_Tick_10ms = 0;
  95  0002 3f01          	clr	_TSL_Tick_10ms
  96                     ; 65   TSL_Tick_Base = 0;
  98  0004 3f00          	clr	_TSL_Tick_Base
  99                     ; 66   TSL_TickCount_ECS_10ms = 0;
 101  0006 3f03          	clr	_TSL_TickCount_ECS_10ms
 102                     ; 67   TSL_Tick_Flags.whole = 0;
 104  0008 3f00          	clr	_TSL_Tick_Flags
 105                     ; 69   TIMTICK->SR1 = 0;       // clear overflow flag
 107  000a 725f5342      	clr	21314
 108                     ; 71   if ( CLK->CKDIVR == 0x00 ) // Max CPU freq = 16 MHz
 110  000e 725d50c6      	tnz	20678
 111  0012 2606          	jrne	L53
 112                     ; 73     TIMTICK->PSCR = 6;     // Prescaler to divide Fcpu by 64: 4 us clock.
 114  0014 35065345      	mov	21317,#6
 116  0018 2004          	jra	L73
 117  001a               L53:
 118                     ; 78     TIMTICK->PSCR = 7;     // Prescaler to divide Fcpu by 128: x.xx us clock.
 120  001a 35075345      	mov	21317,#7
 121  001e               L73:
 122                     ; 81   TIMTICK->ARR = 124;      // 125 * 4 us = 500 us.
 124  001e 357c5346      	mov	21318,#124
 125                     ; 82   TIMTICK->IER = 0x01;     // Enable interrupt
 127  0022 35015341      	mov	21313,#1
 128                     ; 83   TIMTICK->CR1 = 0x01;     // Start timer
 130  0026 35015340      	mov	21312,#1
 131                     ; 85 }
 134  002a 81            	ret
 160                     ; 98 void TSL_Timer_Check_1sec_Tick(void)
 160                     ; 99 {
 161                     .text:	section	.text,new
 162  0000               _TSL_Timer_Check_1sec_Tick:
 166                     ; 100   if ( TSL_Tick_100ms >= 10 )
 168  0000 b602          	ld	a,_TSL_Tick_100ms
 169  0002 a10a          	cp	a,#10
 170  0004 250a          	jrult	L15
 171                     ; 102     TSL_Tick_100ms -= 10;
 173  0006 b602          	ld	a,_TSL_Tick_100ms
 174  0008 a00a          	sub	a,#10
 175  000a b702          	ld	_TSL_Tick_100ms,a
 176                     ; 103     TSL_Tick_Flags.b.DTO_1sec = 1;  // Tick Flag for Max On Duration set every second.
 178  000c 72100000      	bset	_TSL_Tick_Flags,#0
 179  0010               L15:
 180                     ; 106 }
 183  0010 81            	ret
 210                     ; 119 void TSL_Timer_Check_100ms_Tick(void)
 210                     ; 120 {
 211                     .text:	section	.text,new
 212  0000               _TSL_Timer_Check_100ms_Tick:
 216                     ; 121   if ( TSL_Tick_10ms >= 10 )
 218  0000 b601          	ld	a,_TSL_Tick_10ms
 219  0002 a10a          	cp	a,#10
 220  0004 250b          	jrult	L36
 221                     ; 123     TSL_Tick_10ms -= 10;
 223  0006 b601          	ld	a,_TSL_Tick_10ms
 224  0008 a00a          	sub	a,#10
 225  000a b701          	ld	_TSL_Tick_10ms,a
 226                     ; 124     TSL_Tick_100ms++;
 228  000c 3c02          	inc	_TSL_Tick_100ms
 229                     ; 125     TSL_Timer_Check_1sec_Tick();
 231  000e cd0000        	call	_TSL_Timer_Check_1sec_Tick
 233  0011               L36:
 234                     ; 127 }
 237  0011 81            	ret
 265                     ; 140 void TSL_Timer_Check_10ms_Tick(void)
 265                     ; 141 {
 266                     .text:	section	.text,new
 267  0000               _TSL_Timer_Check_10ms_Tick:
 271                     ; 142   if ( TSL_Tick_Base >= TICK_FACTOR_10MS )
 273  0000 b600          	ld	a,_TSL_Tick_Base
 274  0002 a114          	cp	a,#20
 275  0004 250d          	jrult	L57
 276                     ; 144     TSL_Tick_Base -= TICK_FACTOR_10MS;
 278  0006 b600          	ld	a,_TSL_Tick_Base
 279  0008 a014          	sub	a,#20
 280  000a b700          	ld	_TSL_Tick_Base,a
 281                     ; 145     TSL_Tick_10ms++;
 283  000c 3c01          	inc	_TSL_Tick_10ms
 284                     ; 146     TSL_TickCount_ECS_10ms++;   // Tick Flag for Drift increment every 10 ms.
 286  000e 3c03          	inc	_TSL_TickCount_ECS_10ms
 287                     ; 147     TSL_Timer_Check_100ms_Tick();
 289  0010 cd0000        	call	_TSL_Timer_Check_100ms_Tick
 291  0013               L57:
 292                     ; 149 }
 295  0013 81            	ret
 320                     ; 156 void Sys_Time_Manage(void)
 320                     ; 157 {
 321                     .text:	section	.text,new
 322  0000               _Sys_Time_Manage:
 326                     ; 158 	systime_count[0]++;
 328  0000 ce0000        	ldw	x,_systime_count
 329  0003 1c0001        	addw	x,#1
 330  0006 cf0000        	ldw	_systime_count,x
 331                     ; 159 	if (systime_count[0] >= 4)
 333  0009 ce0000        	ldw	x,_systime_count
 334  000c a30004        	cpw	x,#4
 335  000f 250a          	jrult	L701
 336                     ; 161 		systime_count[0] = 4;
 338  0011 ae0004        	ldw	x,#4
 339  0014 cf0000        	ldw	_systime_count,x
 340                     ; 162 		f_2ms = 1;
 342  0017 72120000      	bset	_Flag1_,#1
 343  001b               L701:
 344                     ; 164 	systime_count[1]++;
 346  001b ce0002        	ldw	x,_systime_count+2
 347  001e 1c0001        	addw	x,#1
 348  0021 cf0002        	ldw	_systime_count+2,x
 349                     ; 165 	if (systime_count[1] >= 200)
 351  0024 ce0002        	ldw	x,_systime_count+2
 352  0027 a300c8        	cpw	x,#200
 353  002a 2508          	jrult	L111
 354                     ; 167 		systime_count[1] = 0;
 356  002c 5f            	clrw	x
 357  002d cf0002        	ldw	_systime_count+2,x
 358                     ; 168 		f_100ms = 1;
 360  0030 72140000      	bset	_Flag1_,#2
 361  0034               L111:
 362                     ; 171 	systime_count[2]++;
 364  0034 ce0004        	ldw	x,_systime_count+4
 365  0037 1c0001        	addw	x,#1
 366  003a cf0004        	ldw	_systime_count+4,x
 367                     ; 172 	if (systime_count[2] >= 600)
 369  003d ce0004        	ldw	x,_systime_count+4
 370  0040 a30258        	cpw	x,#600
 371  0043 2508          	jrult	L311
 372                     ; 174 		systime_count[2] = 0;
 374  0045 5f            	clrw	x
 375  0046 cf0004        	ldw	_systime_count+4,x
 376                     ; 175 		f_300ms = 1;
 378  0049 72160000      	bset	_Flag1_,#3
 379  004d               L311:
 380                     ; 177 	systime_count[3]++;
 382  004d ce0006        	ldw	x,_systime_count+6
 383  0050 1c0001        	addw	x,#1
 384  0053 cf0006        	ldw	_systime_count+6,x
 385                     ; 178 	if (systime_count[3] >= 2000)
 387  0056 ce0006        	ldw	x,_systime_count+6
 388  0059 a307d0        	cpw	x,#2000
 389  005c 2508          	jrult	L511
 390                     ; 180 		systime_count[3] = 0;
 392  005e 5f            	clrw	x
 393  005f cf0006        	ldw	_systime_count+6,x
 394                     ; 181 		f_1s = 1;
 396  0062 72180000      	bset	_Flag1_,#4
 397  0066               L511:
 398                     ; 183 }
 401  0066 81            	ret
 430                     ; 197 @interrupt void TSL_Timer_ISR(void)
 430                     ; 198 {
 431                     .text:	section	.text,new
 432  0000               _TSL_Timer_ISR:
 435  0000 3b0002        	push	c_x+2
 436  0003 be00          	ldw	x,c_x
 437  0005 89            	pushw	x
 438  0006 3b0002        	push	c_y+2
 439  0009 be00          	ldw	x,c_y
 440  000b 89            	pushw	x
 443                     ; 200   TIMTICK->SR1 = 0;      // clear overflow flag
 445  000c 725f5342      	clr	21314
 446                     ; 201 	f_500us = 1;
 448  0010 72100000      	bset	_Flag1_,#0
 449                     ; 202 	Sys_Time_Manage();
 451  0014 cd0000        	call	_Sys_Time_Manage
 453                     ; 203   TSL_Tick_Base++;
 455  0017 3c00          	inc	_TSL_Tick_Base
 456                     ; 204   TSL_Timer_Check_10ms_Tick();
 458  0019 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 460                     ; 206   if (TSL_Tick_Flags.b.User_Start_100ms) /* Application request */
 462  001c b600          	ld	a,_TSL_Tick_Flags
 463  001e a502          	bcp	a,#2
 464  0020 270c          	jreq	L721
 465                     ; 208     TSL_Tick_Flags.b.User_Start_100ms = 0;
 467  0022 72130000      	bres	_TSL_Tick_Flags,#1
 468                     ; 209     TSL_Tick_Flags.b.User_Flag_100ms = 0;
 470  0026 72150000      	bres	_TSL_Tick_Flags,#2
 471                     ; 210     TSL_Tick_User = (TICK_FACTOR_10MS * 10);
 473  002a 35c80004      	mov	_TSL_Tick_User,#200
 474  002e               L721:
 475                     ; 213   if (TSL_Tick_User > 0)
 477  002e 3d04          	tnz	_TSL_Tick_User
 478  0030 270a          	jreq	L131
 479                     ; 215     TSL_Tick_User--;
 481  0032 3a04          	dec	_TSL_Tick_User
 482                     ; 216     if (TSL_Tick_User == 0)
 484  0034 3d04          	tnz	_TSL_Tick_User
 485  0036 2604          	jrne	L131
 486                     ; 218       TSL_Tick_Flags.b.User_Flag_100ms = 1; /* Give information to Application */
 488  0038 72140000      	bset	_TSL_Tick_Flags,#2
 489  003c               L131:
 490                     ; 222 }
 493  003c 85            	popw	x
 494  003d bf00          	ldw	c_y,x
 495  003f 320002        	pop	c_y+2
 496  0042 85            	popw	x
 497  0043 bf00          	ldw	c_x,x
 498  0045 320002        	pop	c_x+2
 499  0048 80            	iret
 535                     ; 237 void TSL_Timer_Adjust(u16 Delay)
 535                     ; 238 {
 536                     .text:	section	.text,new
 537  0000               _TSL_Timer_Adjust:
 539  0000 89            	pushw	x
 540       00000000      OFST:	set	0
 543                     ; 240   disableInterrupts();
 546  0001 9b            sim
 548  0002               L151:
 549                     ; 244     if (Delay > TICK_FACTOR_10MS) /* delay > 10ms */
 551  0002 1e01          	ldw	x,(OFST+1,sp)
 552  0004 a30015        	cpw	x,#21
 553  0007 2512          	jrult	L751
 554                     ; 246       TSL_Tick_Base += TICK_FACTOR_10MS;
 556  0009 b600          	ld	a,_TSL_Tick_Base
 557  000b ab14          	add	a,#20
 558  000d b700          	ld	_TSL_Tick_Base,a
 559                     ; 247       Delay -= TICK_FACTOR_10MS;
 561  000f 1e01          	ldw	x,(OFST+1,sp)
 562  0011 1d0014        	subw	x,#20
 563  0014 1f01          	ldw	(OFST+1,sp),x
 564                     ; 248       TSL_Timer_Check_10ms_Tick();
 566  0016 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 569  0019 200c          	jra	L351
 570  001b               L751:
 571                     ; 252       TSL_Tick_Base++;
 573  001b 3c00          	inc	_TSL_Tick_Base
 574                     ; 253       Delay--;
 576  001d 1e01          	ldw	x,(OFST+1,sp)
 577  001f 1d0001        	subw	x,#1
 578  0022 1f01          	ldw	(OFST+1,sp),x
 579                     ; 254       TSL_Timer_Check_10ms_Tick();
 581  0024 cd0000        	call	_TSL_Timer_Check_10ms_Tick
 583  0027               L351:
 584                     ; 257   while ( Delay );
 586  0027 1e01          	ldw	x,(OFST+1,sp)
 587  0029 26d7          	jrne	L151
 588                     ; 259   enableInterrupts();
 591  002b 9a            rim
 593                     ; 261 }
 597  002c 85            	popw	x
 598  002d 81            	ret
 780                     	xdef	_Sys_Time_Manage
 781                     	xdef	_TSL_Tick_User
 782                     	xref	_Flag1_
 783                     	xref	_systime_count
 784                     	xdef	_TSL_Timer_Check_10ms_Tick
 785                     	xdef	_TSL_Timer_Check_100ms_Tick
 786                     	xdef	_TSL_Timer_Check_1sec_Tick
 787                     	xdef	_TSL_Timer_Adjust
 788                     	xdef	_TSL_Timer_ISR
 789                     	xdef	_TSL_Timer_Init
 790                     	switch	.ubsct
 791  0000               _TSL_Tick_Flags:
 792  0000 00            	ds.b	1
 793                     	xdef	_TSL_Tick_Flags
 794                     	xdef	_TSL_TickCount_ECS_10ms
 795                     	xdef	_TSL_Tick_100ms
 796                     	xdef	_TSL_Tick_10ms
 797                     	xdef	_TSL_Tick_Base
 798                     	xref.b	c_x
 799                     	xref.b	c_y
 819                     	end
