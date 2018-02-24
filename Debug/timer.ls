   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  36                     ; 26 void timer2_init(void)
  36                     ; 27 {    
  38                     .text:	section	.text,new
  39  0000               _timer2_init:
  43                     ; 28 	TIM2_TimeBaseInit(TIM2_PRESCALER_64, 2500);
  45  0000 ae09c4        	ldw	x,#2500
  46  0003 89            	pushw	x
  47  0004 a606          	ld	a,#6
  48  0006 cd0000        	call	_TIM2_TimeBaseInit
  50  0009 85            	popw	x
  51                     ; 29 	TIM2_ClearFlag(TIM2_FLAG_UPDATE);
  53  000a ae0001        	ldw	x,#1
  54  000d cd0000        	call	_TIM2_ClearFlag
  56                     ; 30 	TIM2_ITConfig(TIM2_IT_UPDATE, ENABLE);	
  58  0010 ae0001        	ldw	x,#1
  59  0013 a601          	ld	a,#1
  60  0015 95            	ld	xh,a
  61  0016 cd0000        	call	_TIM2_ITConfig
  63                     ; 31 	TIM2_Cmd(ENABLE);	
  65  0019 a601          	ld	a,#1
  66  001b cd0000        	call	_TIM2_Cmd
  68                     ; 33 }
  71  001e 81            	ret
  74                     	switch	.data
  75  0000               L12_cnt_1s:
  76  0000 00            	dc.b	0
  77  0001               L32_cnt_100ms:
  78  0001 00            	dc.b	0
 116                     ; 38 @far @interrupt void timer2_ISR(void) 
 116                     ; 39 {
 118                     .text:	section	.text,new
 119  0000               f_timer2_ISR:
 124                     ; 45 	TIM2->SR1 = 0;
 126  0000 725f5302      	clr	21250
 127                     ; 47 	cnt_100ms++;
 129  0004 725c0001      	inc	L32_cnt_100ms
 130                     ; 48 	cnt_1s++;
 132  0008 725c0000      	inc	L12_cnt_1s
 133                     ; 50 	if(cnt_100ms >= 10){			/* 100ms */
 135  000c c60001        	ld	a,L32_cnt_100ms
 136  000f a10a          	cp	a,#10
 137  0011 2508          	jrult	L34
 138                     ; 51 		cnt_100ms = 0;
 140  0013 725f0001      	clr	L32_cnt_100ms
 141                     ; 52 		f_100ms = 1;
 143  0017 72120000      	bset	_baseTimeFlag,#1
 144  001b               L34:
 145                     ; 55 	if(cnt_1s >= 100){			/* 1s */
 147  001b c60000        	ld	a,L12_cnt_1s
 148  001e a164          	cp	a,#100
 149  0020 2508          	jrult	L54
 150                     ; 56 		cnt_1s = 0;
 152  0022 725f0000      	clr	L12_cnt_1s
 153                     ; 57 		f_1s = 1;
 155  0026 72140000      	bset	_baseTimeFlag,#2
 156  002a               L54:
 157                     ; 60 }
 160  002a 80            	iret
 172                     	xref	_TIM2_ClearFlag
 173                     	xref	_TIM2_ITConfig
 174                     	xref	_TIM2_Cmd
 175                     	xref	_TIM2_TimeBaseInit
 176                     	xdef	f_timer2_ISR
 177                     	xdef	_timer2_init
 178                     	xref	_baseTimeFlag
 197                     	end
