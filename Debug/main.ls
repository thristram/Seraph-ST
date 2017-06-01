   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 190                     ; 55 void Variable_Init(void)
 190                     ; 56 {
 192                     .text:	section	.text,new
 193  0000               _Variable_Init:
 197                     ; 57 	st1.st_device_status = 0xFF;
 199  0000 35ff0002      	mov	_st1+2,#255
 200                     ; 58 	st1.st_pad1_status = 0x00;
 202  0004 725f0006      	clr	_st1+6
 203                     ; 59 	st1.st_pad2_status = 0x00;
 205  0008 725f0007      	clr	_st1+7
 206                     ; 60 	st1.st_pad3_status = 0x00;
 208  000c 725f0008      	clr	_st1+8
 209                     ; 61 }
 212  0010 81            	ret
 239                     ; 102 void EXTI_Config(void)
 239                     ; 103 {
 240                     .text:	section	.text,new
 241  0000               _EXTI_Config:
 245                     ; 104 	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_IN_PU_IT );
 247  0000 4b60          	push	#96
 248  0002 4b01          	push	#1
 249  0004 ae500f        	ldw	x,#20495
 250  0007 cd0000        	call	_GPIO_Init
 252  000a 85            	popw	x
 253                     ; 105 	EXTI_DeInit();
 255  000b cd0000        	call	_EXTI_DeInit
 257                     ; 106 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);//下降沿触发中断
 259  000e 4f            	clr	a
 260  000f cd0000        	call	_EXTI_SetTLISensitivity
 262                     ; 107 	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOD),EXTI_SENSITIVITY_FALL_ONLY);
 264  0012 ae0002        	ldw	x,#2
 265  0015 a603          	ld	a,#3
 266  0017 95            	ld	xh,a
 267  0018 cd0000        	call	_EXTI_SetExtIntSensitivity
 269                     ; 108 }
 272  001b 81            	ret
 298                     ; 110 @interrupt void PORTD_EXT_ISR(void)
 298                     ; 111 {
 299                     .text:	section	.text,new
 300  0000               _PORTD_EXT_ISR:
 305                     ; 112 	disableInterrupts();//关中断
 308  0000 9b            sim
 310                     ; 113 	isr_flag = 1;
 313  0001 35010003      	mov	_isr_flag,#1
 314                     ; 114 	enableInterrupts();
 317  0005 9a            rim
 319                     ; 115 }
 323  0006 80            	iret
 377                     ; 126 void main(void)
 377                     ; 127 {
 378                     .text:	section	.text,new
 379  0000               _main:
 381  0000 88            	push	a
 382       00000001      OFST:	set	1
 385                     ; 142   unsigned char value = 100;
 387  0001 a664          	ld	a,#100
 388  0003 6b01          	ld	(OFST+0,sp),a
 389                     ; 143   in_range = (value >= 10) && (value <= 20);
 391  0005 72110001      	bres	_in_range
 392                     ; 144   p_valid = ptr;   /* p_valid is true if ptr not 0 */
 394  0009 ce0000        	ldw	x,_ptr
 395  000c 2602          	jrne	L02
 396  000e 2006          	jp	L41
 397  0010               L02:
 398  0010 72100000      	bset	_p_valid
 399  0014 2004          	jra	L61
 400  0016               L41:
 401  0016 72110000      	bres	_p_valid
 402  001a               L61:
 403                     ; 153 	CLK->SWCR |= 0x02; //开启切换
 405  001a 721250c5      	bset	20677,#1
 406                     ; 154   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 408  001e 35b450c4      	mov	20676,#180
 410  0022               L161:
 411                     ; 155   while((CLK->SWCR & 0x01)==0x01);
 413  0022 c650c5        	ld	a,20677
 414  0025 a401          	and	a,#1
 415  0027 a101          	cp	a,#1
 416  0029 27f7          	jreq	L161
 417                     ; 156   CLK->CKDIVR = 0x80;    //不分频
 419  002b 358050c6      	mov	20678,#128
 420                     ; 157   CLK->SWCR  &= ~0x02; //关闭切换
 422  002f 721350c5      	bres	20677,#1
 423                     ; 158 	LED_Init(LED1|LED2|LED3|LED4|LED5);
 425  0033 a63e          	ld	a,#62
 426  0035 cd0000        	call	_LED_Init
 428                     ; 159 	KEY_Init(KEY1|KEY2);
 430  0038 a603          	ld	a,#3
 431  003a cd0000        	call	_KEY_Init
 433                     ; 160 	Variable_Init();
 435  003d cd0000        	call	_Variable_Init
 437                     ; 162 	EXTI_Config();
 439  0040 cd0000        	call	_EXTI_Config
 441                     ; 163 	Init_uart2();
 443  0043 cd0000        	call	_Init_uart2
 445                     ; 164 	init();//init apds9960
 447  0046 cd0000        	call	_init
 449                     ; 165 	GestureTest();
 451  0049 cd0000        	call	_GestureTest
 453                     ; 166 	TSL_Init();
 455  004c cd0000        	call	_TSL_Init
 457                     ; 167 	ExtraCode_Init();	
 459  004f cd0000        	call	_ExtraCode_Init
 461  0052               L561:
 462                     ; 169     Task_2ms();
 464  0052 cd0000        	call	_Task_2ms
 466                     ; 170 		Task_100ms();
 468  0055 cd0000        	call	_Task_100ms
 470                     ; 171 		Task_300ms();
 472  0058 cd0000        	call	_Task_300ms
 474                     ; 172 		Task_1s();
 476  005b cd0000        	call	_Task_1s
 478                     ; 173 		ExtraCode_StateMachine();			 
 480  005e cd0000        	call	_ExtraCode_StateMachine
 482                     ; 174 		TSL_Action();
 484  0061 cd0000        	call	_TSL_Action
 486                     ; 209 		if(isr_flag ==1)
 488  0064 c60003        	ld	a,_isr_flag
 489  0067 a101          	cp	a,#1
 490  0069 26e7          	jrne	L561
 491                     ; 211 			LED_On(LED5);
 493  006b a602          	ld	a,#2
 494  006d cd0000        	call	_LED_On
 496                     ; 212 			handleGesture();
 498  0070 cd0000        	call	_handleGesture
 500                     ; 213 			if((GPIOD->IDR&0x01)==0)
 502  0073 c65010        	ld	a,20496
 503  0076 a501          	bcp	a,#1
 504  0078 2608          	jrne	L371
 505                     ; 215 				init();
 507  007a cd0000        	call	_init
 509                     ; 216 				enableGestureSensor(1);
 511  007d a601          	ld	a,#1
 512  007f cd0000        	call	_enableGestureSensor
 514  0082               L371:
 515                     ; 218 			isr_flag = 0;	
 517  0082 725f0003      	clr	_isr_flag
 518  0086 20ca          	jra	L561
 553                     ; 235 void ExtraCode_Init(void)
 553                     ; 236 {
 554                     .text:	section	.text,new
 555  0000               _ExtraCode_Init:
 557  0000 88            	push	a
 558       00000001      OFST:	set	1
 561                     ; 242   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 563  0001 0f01          	clr	(OFST+0,sp)
 564  0003               L112:
 565                     ; 244     sSCKeyInfo[i].Setting.b.IMPLEMENTED = 1;
 567  0003 7b01          	ld	a,(OFST+0,sp)
 568  0005 97            	ld	xl,a
 569  0006 a60f          	ld	a,#15
 570  0008 42            	mul	x,a
 571  0009 d60002        	ld	a,(_sSCKeyInfo+2,x)
 572  000c aa01          	or	a,#1
 573  000e d70002        	ld	(_sSCKeyInfo+2,x),a
 574                     ; 245     sSCKeyInfo[i].Setting.b.ENABLED = 1;
 576  0011 7b01          	ld	a,(OFST+0,sp)
 577  0013 97            	ld	xl,a
 578  0014 a60f          	ld	a,#15
 579  0016 42            	mul	x,a
 580  0017 d60002        	ld	a,(_sSCKeyInfo+2,x)
 581  001a aa02          	or	a,#2
 582  001c d70002        	ld	(_sSCKeyInfo+2,x),a
 583                     ; 246     sSCKeyInfo[i].DESGroup = 0x01; /* Put 0x00 to disable the DES on these pins */
 585  001f 7b01          	ld	a,(OFST+0,sp)
 586  0021 97            	ld	xl,a
 587  0022 a60f          	ld	a,#15
 588  0024 42            	mul	x,a
 589  0025 a601          	ld	a,#1
 590  0027 d70004        	ld	(_sSCKeyInfo+4,x),a
 591                     ; 242   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 593  002a 0c01          	inc	(OFST+0,sp)
 596  002c 7b01          	ld	a,(OFST+0,sp)
 597  002e a103          	cp	a,#3
 598  0030 25d1          	jrult	L112
 599                     ; 259 	LED_On(LED1);
 601  0032 a608          	ld	a,#8
 602  0034 cd0000        	call	_LED_On
 604                     ; 260 	LED_On(LED2);
 606  0037 a610          	ld	a,#16
 607  0039 cd0000        	call	_LED_On
 609                     ; 261 	LED_On(LED3);
 611  003c a620          	ld	a,#32
 612  003e cd0000        	call	_LED_On
 614                     ; 262   LED_On(LED5);
 616  0041 a602          	ld	a,#2
 617  0043 cd0000        	call	_LED_On
 619                     ; 263   enableInterrupts();
 622  0046 9a            rim
 624                     ; 265 }
 628  0047 84            	pop	a
 629  0048 81            	ret
 659                     ; 278 void ExtraCode_StateMachine(void)
 659                     ; 279 {
 660                     .text:	section	.text,new
 661  0000               _ExtraCode_StateMachine:
 665                     ; 280 	if ((TSL_GlobalSetting.b.CHANGED) && (TSLState == TSL_IDLE_STATE))
 667  0000 b601          	ld	a,_TSL_GlobalSetting+1
 668  0002 a508          	bcp	a,#8
 669  0004 2603          	jrne	L62
 670  0006 cc00f7        	jp	L722
 671  0009               L62:
 673  0009 b600          	ld	a,_TSLState
 674  000b a101          	cp	a,#1
 675  000d 2703          	jreq	L03
 676  000f cc00f7        	jp	L722
 677  0012               L03:
 678                     ; 283 		TSL_GlobalSetting.b.CHANGED = 0;
 680  0012 72170001      	bres	_TSL_GlobalSetting+1,#3
 681                     ; 285     if (sSCKeyInfo[0].Setting.b.DETECTED) /* KEY 1 touched */
 683  0016 c60002        	ld	a,_sSCKeyInfo+2
 684  0019 a504          	bcp	a,#4
 685  001b 2744          	jreq	L132
 686                     ; 287 			LED_Toggle(LED1);
 688  001d a608          	ld	a,#8
 689  001f cd0000        	call	_LED_Toggle
 691                     ; 288 			st_pad1_ctrl = 1;
 693  0022 72120000      	bset	_UART1Flag3_,#1
 694                     ; 289 			if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
 696  0026 725d000d      	tnz	_st1+13
 697  002a 2716          	jreq	L332
 699  002c 725d000e      	tnz	_st1+14
 700  0030 2710          	jreq	L332
 702  0032 725d000f      	tnz	_st1+15
 703  0036 270a          	jreq	L332
 704                     ; 291 				st_pad1_confirm = 1;
 706  0038 72180000      	bset	_UART1Flag3_,#4
 707                     ; 292 				st1.st_ctrl_address = 0x01;
 709  003c 35010003      	mov	_st1+3,#1
 711  0040 2008          	jra	L532
 712  0042               L332:
 713                     ; 296 				st_pad1_confirm = 0;
 715  0042 72190000      	bres	_UART1Flag3_,#4
 716                     ; 297 				st1.st_ctrl_address = 0x00;
 718  0046 725f0003      	clr	_st1+3
 719  004a               L532:
 720                     ; 300 			if (st1.st_pad1_status == 0x00)
 722  004a 725d0006      	tnz	_st1+6
 723  004e 2606          	jrne	L732
 724                     ; 302 				st1.st_pad1_status = 0x63;
 726  0050 35630006      	mov	_st1+6,#99
 728  0054 200b          	jra	L132
 729  0056               L732:
 730                     ; 304 			else if (st1.st_pad1_status == 0x63)
 732  0056 c60006        	ld	a,_st1+6
 733  0059 a163          	cp	a,#99
 734  005b 2604          	jrne	L132
 735                     ; 306 				st1.st_pad1_status = 0x00;
 737  005d 725f0006      	clr	_st1+6
 738  0061               L132:
 739                     ; 310     if (sSCKeyInfo[1].Setting.b.DETECTED) /* KEY 2 touched */
 741  0061 c60011        	ld	a,_sSCKeyInfo+17
 742  0064 a504          	bcp	a,#4
 743  0066 2744          	jreq	L542
 744                     ; 312 			LED_Toggle(LED2);
 746  0068 a610          	ld	a,#16
 747  006a cd0000        	call	_LED_Toggle
 749                     ; 313 			st_pad2_ctrl = 1;
 751  006d 72140000      	bset	_UART1Flag3_,#2
 752                     ; 314 			if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
 754  0071 725d0012      	tnz	_st1+18
 755  0075 2716          	jreq	L742
 757  0077 725d0013      	tnz	_st1+19
 758  007b 2710          	jreq	L742
 760  007d 725d0014      	tnz	_st1+20
 761  0081 270a          	jreq	L742
 762                     ; 316 				st_pad2_confirm = 1;
 764  0083 721a0000      	bset	_UART1Flag3_,#5
 765                     ; 317 				st1.st_ctrl_address = 0x02;
 767  0087 35020003      	mov	_st1+3,#2
 769  008b 2008          	jra	L152
 770  008d               L742:
 771                     ; 321 				st_pad2_confirm = 0;
 773  008d 721b0000      	bres	_UART1Flag3_,#5
 774                     ; 322 				st1.st_ctrl_address = 0x00;
 776  0091 725f0003      	clr	_st1+3
 777  0095               L152:
 778                     ; 324 			if (st1.st_pad2_status == 0x00)
 780  0095 725d0007      	tnz	_st1+7
 781  0099 2606          	jrne	L352
 782                     ; 326 				st1.st_pad2_status = 0x63;
 784  009b 35630007      	mov	_st1+7,#99
 786  009f 200b          	jra	L542
 787  00a1               L352:
 788                     ; 328 			else if (st1.st_pad2_status == 0x63)
 790  00a1 c60007        	ld	a,_st1+7
 791  00a4 a163          	cp	a,#99
 792  00a6 2604          	jrne	L542
 793                     ; 330 				st1.st_pad2_status = 0x00;
 795  00a8 725f0007      	clr	_st1+7
 796  00ac               L542:
 797                     ; 334     if (sSCKeyInfo[2].Setting.b.DETECTED) /* KEY 3 touched */
 799  00ac c60020        	ld	a,_sSCKeyInfo+32
 800  00af a504          	bcp	a,#4
 801  00b1 2744          	jreq	L722
 802                     ; 336       LED_Toggle(LED3);
 804  00b3 a620          	ld	a,#32
 805  00b5 cd0000        	call	_LED_Toggle
 807                     ; 337 			st_pad3_ctrl = 1;
 809  00b8 72160000      	bset	_UART1Flag3_,#3
 810                     ; 338 			if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
 812  00bc 725d0017      	tnz	_st1+23
 813  00c0 2716          	jreq	L362
 815  00c2 725d0018      	tnz	_st1+24
 816  00c6 2710          	jreq	L362
 818  00c8 725d0019      	tnz	_st1+25
 819  00cc 270a          	jreq	L362
 820                     ; 340 				st_pad3_confirm = 1;
 822  00ce 721c0000      	bset	_UART1Flag3_,#6
 823                     ; 341 				st1.st_ctrl_address = 0x04;
 825  00d2 35040003      	mov	_st1+3,#4
 827  00d6 2008          	jra	L562
 828  00d8               L362:
 829                     ; 345 				st_pad3_confirm = 0;
 831  00d8 721d0000      	bres	_UART1Flag3_,#6
 832                     ; 346 				st1.st_ctrl_address = 0x00;
 834  00dc 725f0003      	clr	_st1+3
 835  00e0               L562:
 836                     ; 348 			if (st1.st_pad3_status == 0x00)
 838  00e0 725d0008      	tnz	_st1+8
 839  00e4 2606          	jrne	L762
 840                     ; 350 				st1.st_pad3_status = 0x63;
 842  00e6 35630008      	mov	_st1+8,#99
 844  00ea 200b          	jra	L722
 845  00ec               L762:
 846                     ; 352 			else if (st1.st_pad3_status == 0x63)
 848  00ec c60008        	ld	a,_st1+8
 849  00ef a163          	cp	a,#99
 850  00f1 2604          	jrne	L722
 851                     ; 354 				st1.st_pad3_status = 0x00;
 853  00f3 725f0008      	clr	_st1+8
 854  00f7               L722:
 855                     ; 358 }
 858  00f7 81            	ret
 889                     ; 360 void handleGesture(void) {
 890                     .text:	section	.text,new
 891  0000               _handleGesture:
 895                     ; 361     if ( isGestureAvailable() ) {
 897  0000 cd0000        	call	_isGestureAvailable
 899  0003 4d            	tnz	a
 900  0004 2603          	jrne	L43
 901  0006 cc0189        	jp	L323
 902  0009               L43:
 903                     ; 362 			send_buf[0] = 0x00;
 905  0009 725f0000      	clr	_send_buf
 906                     ; 363 			send_buf[1] = 0x00;
 908  000d 725f0001      	clr	_send_buf+1
 909                     ; 364 			send_buf[2] = 0x00;
 911  0011 725f0002      	clr	_send_buf+2
 912                     ; 365 			send_buf[3] = 0x00;
 914  0015 725f0003      	clr	_send_buf+3
 915                     ; 366 			send_buf[4] = 0x00;
 917  0019 725f0004      	clr	_send_buf+4
 918                     ; 367 			send_buf[5] = 0x08;
 920  001d 35080005      	mov	_send_buf+5,#8
 921                     ; 368 			send_buf[6] = 0x00;//ns_own_meshid_H;
 923  0021 725f0006      	clr	_send_buf+6
 924                     ; 369 			send_buf[7] = 0x00;//ns_own_meshid_L;
 926  0025 725f0007      	clr	_send_buf+7
 927                     ; 370 			send_buf[8] = 0x00;//ns_own_meshid_H;
 929  0029 725f0008      	clr	_send_buf+8
 930                     ; 371 			send_buf[9] = 0x00;//ns_own_meshid_L;
 932  002d 725f0009      	clr	_send_buf+9
 933                     ; 372 			gest_cnt++;					
 935  0031 725c0002      	inc	_gest_cnt
 936                     ; 373     switch ( readGesture() ) {
 938  0035 cd0000        	call	_readGesture
 941                     ; 410       default:
 941                     ; 411         //printf("NONE\n");
 941                     ; 412 				//send_buf[8] = 0x01;
 941                     ; 413 				break;
 942  0038 5a            	decw	x
 943  0039 2603          	jrne	L63
 944  003b cc00e3        	jp	L103
 945  003e               L63:
 946  003e 5a            	decw	x
 947  003f 2603          	jrne	L04
 948  0041 cc0122        	jp	L303
 949  0044               L04:
 950  0044 5a            	decw	x
 951  0045 2713          	jreq	L572
 952  0047 5a            	decw	x
 953  0048 2751          	jreq	L772
 954  004a 5a            	decw	x
 955  004b 2603          	jrne	L24
 956  004d cc0161        	jp	L503
 957  0050               L24:
 958  0050 5a            	decw	x
 959  0051 2603          	jrne	L44
 960  0053 cc0167        	jp	L703
 961  0056               L44:
 962  0056 ac6b016b      	jpf	L723
 963  005a               L572:
 964                     ; 374       case DIR_UP:
 964                     ; 375         //printf("UP\n");
 964                     ; 376 				if(gest_cnt == 1)				st1.st_ges_H |= 0xC0;
 966  005a c60002        	ld	a,_gest_cnt
 967  005d a101          	cp	a,#1
 968  005f 260a          	jrne	L133
 971  0061 c60000        	ld	a,_st1
 972  0064 aac0          	or	a,#192
 973  0066 c70000        	ld	_st1,a
 975  0069 2028          	jra	L333
 976  006b               L133:
 977                     ; 377 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0C;
 979  006b c60002        	ld	a,_gest_cnt
 980  006e a102          	cp	a,#2
 981  0070 260a          	jrne	L533
 984  0072 c60000        	ld	a,_st1
 985  0075 aa0c          	or	a,#12
 986  0077 c70000        	ld	_st1,a
 988  007a 2017          	jra	L333
 989  007c               L533:
 990                     ; 378 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xC0;gest_cnt = 0;gest_detect = 1;}
 992  007c c60002        	ld	a,_gest_cnt
 993  007f a103          	cp	a,#3
 994  0081 2610          	jrne	L333
 997  0083 c60001        	ld	a,_st1+1
 998  0086 aac0          	or	a,#192
 999  0088 c70001        	ld	_st1+1,a
1002  008b 725f0002      	clr	_gest_cnt
1005  008f 72100000      	bset	_UART1Flag2_,#0
1006  0093               L333:
1007                     ; 379 				send_buf[0] = 0x01;
1009  0093 35010000      	mov	_send_buf,#1
1010                     ; 380         break;
1012  0097 ac6b016b      	jpf	L723
1013  009b               L772:
1014                     ; 381       case DIR_DOWN:
1014                     ; 382         //printf("DOWN\n");
1014                     ; 383 				send_buf[1] = 0x01;
1016  009b 35010001      	mov	_send_buf+1,#1
1017                     ; 384 				if(gest_cnt == 1)				st1.st_ges_H |= 0xD0;
1019  009f c60002        	ld	a,_gest_cnt
1020  00a2 a101          	cp	a,#1
1021  00a4 260c          	jrne	L343
1024  00a6 c60000        	ld	a,_st1
1025  00a9 aad0          	or	a,#208
1026  00ab c70000        	ld	_st1,a
1028  00ae ac6b016b      	jpf	L723
1029  00b2               L343:
1030                     ; 385 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0D;
1032  00b2 c60002        	ld	a,_gest_cnt
1033  00b5 a102          	cp	a,#2
1034  00b7 260c          	jrne	L743
1037  00b9 c60000        	ld	a,_st1
1038  00bc aa0d          	or	a,#13
1039  00be c70000        	ld	_st1,a
1041  00c1 ac6b016b      	jpf	L723
1042  00c5               L743:
1043                     ; 386 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xD0;gest_cnt = 0;gest_detect = 1;}
1045  00c5 c60002        	ld	a,_gest_cnt
1046  00c8 a103          	cp	a,#3
1047  00ca 2703          	jreq	L64
1048  00cc cc016b        	jp	L723
1049  00cf               L64:
1052  00cf c60001        	ld	a,_st1+1
1053  00d2 aad0          	or	a,#208
1054  00d4 c70001        	ld	_st1+1,a
1057  00d7 725f0002      	clr	_gest_cnt
1060  00db 72100000      	bset	_UART1Flag2_,#0
1061  00df ac6b016b      	jpf	L723
1062  00e3               L103:
1063                     ; 388       case DIR_LEFT:
1063                     ; 389         //printf("LEFT\n");
1063                     ; 390 				send_buf[2] = 0x01;
1065  00e3 35010002      	mov	_send_buf+2,#1
1066                     ; 391 				if(gest_cnt == 1)		st1.st_ges_H |= 0xE0;
1068  00e7 c60002        	ld	a,_gest_cnt
1069  00ea a101          	cp	a,#1
1070  00ec 260a          	jrne	L553
1073  00ee c60000        	ld	a,_st1
1074  00f1 aae0          	or	a,#224
1075  00f3 c70000        	ld	_st1,a
1077  00f6 2073          	jra	L723
1078  00f8               L553:
1079                     ; 392 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0E;
1081  00f8 c60002        	ld	a,_gest_cnt
1082  00fb a102          	cp	a,#2
1083  00fd 260a          	jrne	L163
1086  00ff c60000        	ld	a,_st1
1087  0102 aa0e          	or	a,#14
1088  0104 c70000        	ld	_st1,a
1090  0107 2062          	jra	L723
1091  0109               L163:
1092                     ; 393 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xE0;gest_cnt = 0;gest_detect = 1;}
1094  0109 c60002        	ld	a,_gest_cnt
1095  010c a103          	cp	a,#3
1096  010e 265b          	jrne	L723
1099  0110 c60001        	ld	a,_st1+1
1100  0113 aae0          	or	a,#224
1101  0115 c70001        	ld	_st1+1,a
1104  0118 725f0002      	clr	_gest_cnt
1107  011c 72100000      	bset	_UART1Flag2_,#0
1108  0120 2049          	jra	L723
1109  0122               L303:
1110                     ; 395       case DIR_RIGHT:
1110                     ; 396         //printf("RIGHT\n");
1110                     ; 397 				if(gest_cnt == 1)		st1.st_ges_H |= 0xF0;
1112  0122 c60002        	ld	a,_gest_cnt
1113  0125 a101          	cp	a,#1
1114  0127 260a          	jrne	L763
1117  0129 c60000        	ld	a,_st1
1118  012c aaf0          	or	a,#240
1119  012e c70000        	ld	_st1,a
1121  0131 2028          	jra	L173
1122  0133               L763:
1123                     ; 398 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0F;
1125  0133 c60002        	ld	a,_gest_cnt
1126  0136 a102          	cp	a,#2
1127  0138 260a          	jrne	L373
1130  013a c60000        	ld	a,_st1
1131  013d aa0f          	or	a,#15
1132  013f c70000        	ld	_st1,a
1134  0142 2017          	jra	L173
1135  0144               L373:
1136                     ; 399 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xF0;gest_cnt = 0;gest_detect = 1;}
1138  0144 c60002        	ld	a,_gest_cnt
1139  0147 a103          	cp	a,#3
1140  0149 2610          	jrne	L173
1143  014b c60001        	ld	a,_st1+1
1144  014e aaf0          	or	a,#240
1145  0150 c70001        	ld	_st1+1,a
1148  0153 725f0002      	clr	_gest_cnt
1151  0157 72100000      	bset	_UART1Flag2_,#0
1152  015b               L173:
1153                     ; 400 				send_buf[3] = 0x01;
1155  015b 35010003      	mov	_send_buf+3,#1
1156                     ; 401         break;
1158  015f 200a          	jra	L723
1159  0161               L503:
1160                     ; 402       case DIR_NEAR:
1160                     ; 403         //printf("NEAR\n");
1160                     ; 404 				send_buf[6] = 0x01;
1162  0161 35010006      	mov	_send_buf+6,#1
1163                     ; 405         break;
1165  0165 2004          	jra	L723
1166  0167               L703:
1167                     ; 406       case DIR_FAR:
1167                     ; 407         //printf("FAR\n");
1167                     ; 408 				send_buf[7] = 0x01;
1169  0167 35010007      	mov	_send_buf+7,#1
1170                     ; 409         break;
1172  016b               L113:
1173                     ; 410       default:
1173                     ; 411         //printf("NONE\n");
1173                     ; 412 				//send_buf[8] = 0x01;
1173                     ; 413 				break;
1175  016b               L723:
1176                     ; 415 		send_buf[8] = st1.st_ges_H;
1178  016b 5500000008    	mov	_send_buf+8,_st1
1179                     ; 416 		send_buf[9] = st1.st_ges_L;
1181  0170 5500010009    	mov	_send_buf+9,_st1+1
1182                     ; 417 		send_buf[10] = Check_Sum(send_buf,send_buf[5]+2);
1184  0175 c60005        	ld	a,_send_buf+5
1185  0178 ab02          	add	a,#2
1186  017a 88            	push	a
1187  017b ae0000        	ldw	x,#_send_buf
1188  017e cd0000        	call	_Check_Sum
1190  0181 5b01          	addw	sp,#1
1191  0183 c7000a        	ld	_send_buf+10,a
1192                     ; 418 		UART2_Send_Data_Start();
1194  0186 cd0000        	call	_UART2_Send_Data_Start
1196  0189               L323:
1197                     ; 420 }
1200  0189 81            	ret
1224                     ; 422 void GestureTest(void)
1224                     ; 423 {
1225                     .text:	section	.text,new
1226  0000               _GestureTest:
1230                     ; 433   if ( enableGestureSensor(1) ) {
1232  0000 a601          	ld	a,#1
1233  0002 cd0000        	call	_enableGestureSensor
1235  0005 4d            	tnz	a
1237  0006               L314:
1238                     ; 440 }
1241  0006 81            	ret
1244                     	switch	.data
1245  0000               L514_ambient_light:
1246  0000 0000          	dc.w	0
1247  0002               L714_red_light:
1248  0002 0000          	dc.w	0
1249  0004               L124_green_light:
1250  0004 0000          	dc.w	0
1251  0006               L324_blue_light:
1252  0006 0000          	dc.w	0
1253  0008               L524_threshold:
1254  0008 0000          	dc.w	0
1330                     ; 442 void LightTest(void)
1330                     ; 443 {
1331                     .text:	section	.text,new
1332  0000               _LightTest:
1336                     ; 450   if ( init() ) {
1338  0000 cd0000        	call	_init
1340  0003 4d            	tnz	a
1341  0004 270a          	jreq	L354
1343                     ; 460   if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
1345  0006 ae000a        	ldw	x,#10
1346  0009 cd0000        	call	_setLightIntLowThreshold
1348  000c 4d            	tnz	a
1349  000d 2607          	jrne	L754
1350                     ; 462 		return;
1353  000f 81            	ret
1354  0010               L354:
1355                     ; 455 		LED_Toggle(LED5);
1357  0010 a602          	ld	a,#2
1358  0012 cd0000        	call	_LED_Toggle
1360                     ; 456 		return;
1363  0015 81            	ret
1364  0016               L754:
1365                     ; 464   if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
1367  0016 ae03e8        	ldw	x,#1000
1368  0019 cd0000        	call	_setLightIntHighThreshold
1370  001c 4d            	tnz	a
1371  001d 2601          	jrne	L164
1372                     ; 466 		return;
1375  001f 81            	ret
1376  0020               L164:
1377                     ; 470   if ( enableLightSensor(0) ) {
1379  0020 4f            	clr	a
1380  0021 cd0000        	call	_enableLightSensor
1382  0024 4d            	tnz	a
1383  0025 270a          	jreq	L364
1385                     ; 478   if ( !getLightIntLowThreshold(&threshold) ) {
1387  0027 ae0008        	ldw	x,#L524_threshold
1388  002a cd0000        	call	_getLightIntLowThreshold
1390  002d 4d            	tnz	a
1391  002e 2602          	jrne	L174
1392                     ; 480 		return;
1395  0030 81            	ret
1396  0031               L364:
1397                     ; 474 		return;
1400  0031 81            	ret
1401  0032               L174:
1402                     ; 484   if ( !getLightIntHighThreshold(&threshold) ) {
1404  0032 ae0008        	ldw	x,#L524_threshold
1405  0035 cd0000        	call	_getLightIntHighThreshold
1407  0038 4d            	tnz	a
1408  0039 2601          	jrne	L574
1409                     ; 486 		return;
1412  003b 81            	ret
1413  003c               L574:
1414                     ; 491 	if ( setAmbientLightIntEnable(0) ) {
1416  003c 4f            	clr	a
1417  003d cd0000        	call	_setAmbientLightIntEnable
1419  0040 4d            	tnz	a
1420  0041 2731          	jreq	L774
1422                     ; 502   delay_ms(200);
1424  0043 ae00c8        	ldw	x,#200
1425  0046 cf0000        	ldw	_TIM3_tout,x
1426  0049               L305:
1430  0049 ce0000        	ldw	x,_TIM3_tout
1431  004c 26fb          	jrne	L305
1432                     ; 508 			if (  !readAmbientLight(&ambient_light) ||
1432                     ; 509 						!readRedLight(&red_light) ||
1432                     ; 510 						!readGreenLight(&green_light) ||
1432                     ; 511 						!readBlueLight(&blue_light) ) {
1435  004e ae0000        	ldw	x,#L514_ambient_light
1436  0051 cd0000        	call	_readAmbientLight
1438  0054 4d            	tnz	a
1439  0055 271e          	jreq	L315
1441  0057 ae0002        	ldw	x,#L714_red_light
1442  005a cd0000        	call	_readRedLight
1444  005d 4d            	tnz	a
1445  005e 2715          	jreq	L315
1447  0060 ae0004        	ldw	x,#L124_green_light
1448  0063 cd0000        	call	_readGreenLight
1450  0066 4d            	tnz	a
1451  0067 270c          	jreq	L315
1453  0069 ae0006        	ldw	x,#L324_blue_light
1454  006c cd0000        	call	_readBlueLight
1456  006f 4d            	tnz	a
1457  0070 2604          	jrne	L115
1458  0072 2001          	jra	L315
1459  0074               L774:
1460                     ; 494 		return;
1463  0074 81            	ret
1464  0075               L315:
1465                     ; 513 				return;
1468  0075 81            	ret
1469  0076               L115:
1470                     ; 519 				send_buf[0] = (u8)(ambient_light>>8);
1472  0076 5500000000    	mov	_send_buf,L514_ambient_light
1473                     ; 520 				send_buf[1] = (u8)ambient_light;
1475  007b 5500010001    	mov	_send_buf+1,L514_ambient_light+1
1476                     ; 521 				send_buf[2] = (u8)(red_light>>8);
1478  0080 5500020002    	mov	_send_buf+2,L714_red_light
1479                     ; 522 				send_buf[3] = (u8)red_light;
1481  0085 5500030003    	mov	_send_buf+3,L714_red_light+1
1482                     ; 523 				send_buf[4] = 0x00;
1484  008a 725f0004      	clr	_send_buf+4
1485                     ; 524 				send_buf[5] = 0x08;
1487  008e 35080005      	mov	_send_buf+5,#8
1488                     ; 525 				send_buf[6] = (u8)(green_light>>8);//ns_own_meshid_H;
1490  0092 5500040006    	mov	_send_buf+6,L124_green_light
1491                     ; 526 				send_buf[7] = (u8)green_light;//ns_own_meshid_L;
1493  0097 5500050007    	mov	_send_buf+7,L124_green_light+1
1494                     ; 527 				send_buf[8] = (u8)(blue_light>>8);//ns_own_meshid_H;
1496  009c 5500060008    	mov	_send_buf+8,L324_blue_light
1497                     ; 528 				send_buf[9] = (u8)blue_light;//ns_own_meshid_L;
1499  00a1 5500070009    	mov	_send_buf+9,L324_blue_light+1
1500                     ; 529 				send_buf[10] = Check_Sum(send_buf,send_buf[5]+2);
1502  00a6 4b0a          	push	#10
1503  00a8 ae0000        	ldw	x,#_send_buf
1504  00ab cd0000        	call	_Check_Sum
1506  00ae 5b01          	addw	sp,#1
1507  00b0 c7000a        	ld	_send_buf+10,a
1508                     ; 530 				UART2_Send_Data_Start();
1510  00b3 cd0000        	call	_UART2_Send_Data_Start
1512                     ; 535 			if ( !clearAmbientLightInt() ) {
1514  00b6 cd0000        	call	_clearAmbientLightInt
1516  00b9 4d            	tnz	a
1517  00ba 2601          	jrne	L325
1518                     ; 537 				return;
1521  00bc 81            	ret
1522  00bd               L325:
1523                     ; 539 			enableGestureSensor(1);
1525  00bd a601          	ld	a,#1
1526  00bf cd0000        	call	_enableGestureSensor
1528                     ; 542 }
1531  00c2 81            	ret
1555                     ; 552 void Task_500us(void)
1555                     ; 553 {
1556                     .text:	section	.text,new
1557  0000               _Task_500us:
1561                     ; 554 	if(f_500us)
1563  0000 c60004        	ld	a,_Flag1_
1564  0003 a501          	bcp	a,#1
1565  0005 2704          	jreq	L535
1566                     ; 556 		f_500us = 0;
1568  0007 72110004      	bres	_Flag1_,#0
1569  000b               L535:
1570                     ; 559 }
1573  000b 81            	ret
1598                     ; 566 void Task_2ms(void)
1598                     ; 567 {
1599                     .text:	section	.text,new
1600  0000               _Task_2ms:
1604                     ; 568 	if(f_2ms)
1606  0000 c60004        	ld	a,_Flag1_
1607  0003 a502          	bcp	a,#2
1608  0005 2707          	jreq	L745
1609                     ; 570 		f_2ms = 0;
1611  0007 72130004      	bres	_Flag1_,#1
1612                     ; 571 		reve_analyze_reply();
1614  000b cd0000        	call	_reve_analyze_reply
1616  000e               L745:
1617                     ; 573 }
1620  000e 81            	ret
1644                     ; 580 void Task_100ms(void)
1644                     ; 581 {
1645                     .text:	section	.text,new
1646  0000               _Task_100ms:
1650                     ; 582 	if(f_100ms)
1652  0000 c60004        	ld	a,_Flag1_
1653  0003 a504          	bcp	a,#4
1654  0005 2704          	jreq	L165
1655                     ; 584 		f_100ms = 0;
1657  0007 72150004      	bres	_Flag1_,#2
1658  000b               L165:
1659                     ; 586 }
1662  000b 81            	ret
1686                     ; 593 void Task_300ms(void)
1686                     ; 594 {
1687                     .text:	section	.text,new
1688  0000               _Task_300ms:
1692                     ; 595 	if(f_300ms)
1694  0000 c60004        	ld	a,_Flag1_
1695  0003 a508          	bcp	a,#8
1696  0005 2704          	jreq	L375
1697                     ; 597 		f_300ms = 0;
1699  0007 72170004      	bres	_Flag1_,#3
1700  000b               L375:
1701                     ; 599 }
1704  000b 81            	ret
1707                     	switch	.data
1708  000a               L575_i:
1709  000a 0000          	dc.w	0
1710  000c               L775_j:
1711  000c 0000          	dc.w	0
1753                     ; 606 void Task_1s(void)
1753                     ; 607 {
1754                     .text:	section	.text,new
1755  0000               _Task_1s:
1759                     ; 610 	if(f_1s)
1761  0000 c60004        	ld	a,_Flag1_
1762  0003 a510          	bcp	a,#16
1763  0005 2744          	jreq	L716
1764                     ; 612 		f_1s = 0;
1766  0007 72190004      	bres	_Flag1_,#4
1767                     ; 613 		i++;
1769  000b ce000a        	ldw	x,L575_i
1770  000e 1c0001        	addw	x,#1
1771  0011 cf000a        	ldw	L575_i,x
1772                     ; 614 		j++;
1774  0014 ce000c        	ldw	x,L775_j
1775  0017 1c0001        	addw	x,#1
1776  001a cf000c        	ldw	L775_j,x
1777                     ; 615 		if(i >= 5)	{i = 0;LightTest();}
1779  001d 9c            	rvf
1780  001e ce000a        	ldw	x,L575_i
1781  0021 a30005        	cpw	x,#5
1782  0024 2f07          	jrslt	L126
1785  0026 5f            	clrw	x
1786  0027 cf000a        	ldw	L575_i,x
1789  002a cd0000        	call	_LightTest
1791  002d               L126:
1792                     ; 616 		LED_Toggle(LED4);
1794  002d a604          	ld	a,#4
1795  002f cd0000        	call	_LED_Toggle
1797                     ; 618 		if(j >= 3)	{j = 0;gest_cnt = 0;st1.st_ges_H = 0x00;st1.st_ges_L = 0x00;}
1799  0032 9c            	rvf
1800  0033 ce000c        	ldw	x,L775_j
1801  0036 a30003        	cpw	x,#3
1802  0039 2f10          	jrslt	L716
1805  003b 5f            	clrw	x
1806  003c cf000c        	ldw	L775_j,x
1809  003f 725f0002      	clr	_gest_cnt
1812  0043 725f0000      	clr	_st1
1815  0047 725f0001      	clr	_st1+1
1816  004b               L716:
1817                     ; 635 }
1820  004b 81            	ret
1853                     ; 638 void LED_Init(u8 LedNum)
1853                     ; 639 {
1854                     .text:	section	.text,new
1855  0000               _LED_Init:
1857  0000 88            	push	a
1858       00000000      OFST:	set	0
1861                     ; 640 	if(LedNum & LED1)//LED1
1863  0001 a508          	bcp	a,#8
1864  0003 270b          	jreq	L146
1865                     ; 642 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED1, GPIO_MODE_OUT_PP_LOW_FAST);
1867  0005 4bc0          	push	#192
1868  0007 4b08          	push	#8
1869  0009 ae500a        	ldw	x,#20490
1870  000c cd0000        	call	_GPIO_Init
1872  000f 85            	popw	x
1873  0010               L146:
1874                     ; 644 	if(LedNum & LED2)//LED2
1876  0010 7b01          	ld	a,(OFST+1,sp)
1877  0012 a510          	bcp	a,#16
1878  0014 270b          	jreq	L346
1879                     ; 646 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED2, GPIO_MODE_OUT_PP_LOW_FAST);
1881  0016 4bc0          	push	#192
1882  0018 4b10          	push	#16
1883  001a ae500a        	ldw	x,#20490
1884  001d cd0000        	call	_GPIO_Init
1886  0020 85            	popw	x
1887  0021               L346:
1888                     ; 648 	if(LedNum & LED3)//LED3
1890  0021 7b01          	ld	a,(OFST+1,sp)
1891  0023 a520          	bcp	a,#32
1892  0025 270b          	jreq	L546
1893                     ; 650 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED3, GPIO_MODE_OUT_PP_LOW_FAST);
1895  0027 4bc0          	push	#192
1896  0029 4b20          	push	#32
1897  002b ae500a        	ldw	x,#20490
1898  002e cd0000        	call	_GPIO_Init
1900  0031 85            	popw	x
1901  0032               L546:
1902                     ; 652 	if(LedNum & LED4)//LED4
1904  0032 7b01          	ld	a,(OFST+1,sp)
1905  0034 a504          	bcp	a,#4
1906  0036 270b          	jreq	L746
1907                     ; 654 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED4, GPIO_MODE_OUT_PP_LOW_FAST);
1909  0038 4bc0          	push	#192
1910  003a 4b04          	push	#4
1911  003c ae500a        	ldw	x,#20490
1912  003f cd0000        	call	_GPIO_Init
1914  0042 85            	popw	x
1915  0043               L746:
1916                     ; 656 	if(LedNum & LED5)//LED5
1918  0043 7b01          	ld	a,(OFST+1,sp)
1919  0045 a502          	bcp	a,#2
1920  0047 270b          	jreq	L156
1921                     ; 658 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED5, GPIO_MODE_OUT_PP_LOW_FAST);
1923  0049 4bc0          	push	#192
1924  004b 4b02          	push	#2
1925  004d ae500a        	ldw	x,#20490
1926  0050 cd0000        	call	_GPIO_Init
1928  0053 85            	popw	x
1929  0054               L156:
1930                     ; 660 }
1933  0054 84            	pop	a
1934  0055 81            	ret
1968                     ; 662 void LED_On(u8 LedNum)
1968                     ; 663 {
1969                     .text:	section	.text,new
1970  0000               _LED_On:
1972  0000 88            	push	a
1973       00000000      OFST:	set	0
1976                     ; 664 	if(LedNum & LED1)//LED1
1978  0001 a508          	bcp	a,#8
1979  0003 2709          	jreq	L766
1980                     ; 666 		GPIO_WriteHigh(LED_PORT, LED1);
1982  0005 4b08          	push	#8
1983  0007 ae500a        	ldw	x,#20490
1984  000a cd0000        	call	_GPIO_WriteHigh
1986  000d 84            	pop	a
1987  000e               L766:
1988                     ; 668 	if(LedNum & LED2)//LED2
1990  000e 7b01          	ld	a,(OFST+1,sp)
1991  0010 a510          	bcp	a,#16
1992  0012 2709          	jreq	L176
1993                     ; 670 		GPIO_WriteHigh(LED_PORT, LED2);
1995  0014 4b10          	push	#16
1996  0016 ae500a        	ldw	x,#20490
1997  0019 cd0000        	call	_GPIO_WriteHigh
1999  001c 84            	pop	a
2000  001d               L176:
2001                     ; 672 	if(LedNum & LED3)//LED3
2003  001d 7b01          	ld	a,(OFST+1,sp)
2004  001f a520          	bcp	a,#32
2005  0021 2709          	jreq	L376
2006                     ; 674 		GPIO_WriteHigh(LED_PORT, LED3);
2008  0023 4b20          	push	#32
2009  0025 ae500a        	ldw	x,#20490
2010  0028 cd0000        	call	_GPIO_WriteHigh
2012  002b 84            	pop	a
2013  002c               L376:
2014                     ; 676 	if(LedNum & LED4)//LED4
2016  002c 7b01          	ld	a,(OFST+1,sp)
2017  002e a504          	bcp	a,#4
2018  0030 2709          	jreq	L576
2019                     ; 678 		GPIO_WriteLow(LED_PORT, LED4);
2021  0032 4b04          	push	#4
2022  0034 ae500a        	ldw	x,#20490
2023  0037 cd0000        	call	_GPIO_WriteLow
2025  003a 84            	pop	a
2026  003b               L576:
2027                     ; 680 	if(LedNum & LED5)//LED5
2029  003b 7b01          	ld	a,(OFST+1,sp)
2030  003d a502          	bcp	a,#2
2031  003f 2709          	jreq	L776
2032                     ; 682 		GPIO_WriteLow(LED_PORT, LED5);
2034  0041 4b02          	push	#2
2035  0043 ae500a        	ldw	x,#20490
2036  0046 cd0000        	call	_GPIO_WriteLow
2038  0049 84            	pop	a
2039  004a               L776:
2040                     ; 684 }
2043  004a 84            	pop	a
2044  004b 81            	ret
2077                     ; 687 void LED_Off(u8 LedNum)
2077                     ; 688 {
2078                     .text:	section	.text,new
2079  0000               _LED_Off:
2081  0000 88            	push	a
2082       00000000      OFST:	set	0
2085                     ; 689 	if(LedNum & LED1)//LED1
2087  0001 a508          	bcp	a,#8
2088  0003 2709          	jreq	L517
2089                     ; 691 		GPIO_WriteLow(LED_PORT, LED1);
2091  0005 4b08          	push	#8
2092  0007 ae500a        	ldw	x,#20490
2093  000a cd0000        	call	_GPIO_WriteLow
2095  000d 84            	pop	a
2096  000e               L517:
2097                     ; 693 	if(LedNum & LED2)//LED2
2099  000e 7b01          	ld	a,(OFST+1,sp)
2100  0010 a510          	bcp	a,#16
2101  0012 2709          	jreq	L717
2102                     ; 695 		GPIO_WriteLow(LED_PORT, LED2);
2104  0014 4b10          	push	#16
2105  0016 ae500a        	ldw	x,#20490
2106  0019 cd0000        	call	_GPIO_WriteLow
2108  001c 84            	pop	a
2109  001d               L717:
2110                     ; 697 	if(LedNum & LED3)//LED3
2112  001d 7b01          	ld	a,(OFST+1,sp)
2113  001f a520          	bcp	a,#32
2114  0021 2709          	jreq	L127
2115                     ; 699 		GPIO_WriteLow(LED_PORT, LED3);
2117  0023 4b20          	push	#32
2118  0025 ae500a        	ldw	x,#20490
2119  0028 cd0000        	call	_GPIO_WriteLow
2121  002b 84            	pop	a
2122  002c               L127:
2123                     ; 701 	if(LedNum & LED4)//LED4
2125  002c 7b01          	ld	a,(OFST+1,sp)
2126  002e a504          	bcp	a,#4
2127  0030 2709          	jreq	L327
2128                     ; 703 		GPIO_WriteLow(LED_PORT, LED4);
2130  0032 4b04          	push	#4
2131  0034 ae500a        	ldw	x,#20490
2132  0037 cd0000        	call	_GPIO_WriteLow
2134  003a 84            	pop	a
2135  003b               L327:
2136                     ; 705 	if(LedNum & LED5)//LED5
2138  003b 7b01          	ld	a,(OFST+1,sp)
2139  003d a502          	bcp	a,#2
2140  003f 2709          	jreq	L527
2141                     ; 707 		GPIO_WriteLow(LED_PORT, LED5);
2143  0041 4b02          	push	#2
2144  0043 ae500a        	ldw	x,#20490
2145  0046 cd0000        	call	_GPIO_WriteLow
2147  0049 84            	pop	a
2148  004a               L527:
2149                     ; 709 }
2152  004a 84            	pop	a
2153  004b 81            	ret
2186                     ; 711 void LED_Toggle(u8 LedNum)
2186                     ; 712 {
2187                     .text:	section	.text,new
2188  0000               _LED_Toggle:
2190  0000 88            	push	a
2191       00000000      OFST:	set	0
2194                     ; 713 	if(LedNum & LED1)//LED1
2196  0001 a508          	bcp	a,#8
2197  0003 2709          	jreq	L347
2198                     ; 715 		GPIO_WriteReverse(LED_PORT, LED1);
2200  0005 4b08          	push	#8
2201  0007 ae500a        	ldw	x,#20490
2202  000a cd0000        	call	_GPIO_WriteReverse
2204  000d 84            	pop	a
2205  000e               L347:
2206                     ; 717 	if(LedNum & LED2)//LED2
2208  000e 7b01          	ld	a,(OFST+1,sp)
2209  0010 a510          	bcp	a,#16
2210  0012 2709          	jreq	L547
2211                     ; 719 		GPIO_WriteReverse(LED_PORT, LED2);
2213  0014 4b10          	push	#16
2214  0016 ae500a        	ldw	x,#20490
2215  0019 cd0000        	call	_GPIO_WriteReverse
2217  001c 84            	pop	a
2218  001d               L547:
2219                     ; 721 	if(LedNum & LED3)//LED3
2221  001d 7b01          	ld	a,(OFST+1,sp)
2222  001f a520          	bcp	a,#32
2223  0021 2709          	jreq	L747
2224                     ; 723 		GPIO_WriteReverse(LED_PORT, LED3);
2226  0023 4b20          	push	#32
2227  0025 ae500a        	ldw	x,#20490
2228  0028 cd0000        	call	_GPIO_WriteReverse
2230  002b 84            	pop	a
2231  002c               L747:
2232                     ; 725 	if(LedNum & LED4)//LED4
2234  002c 7b01          	ld	a,(OFST+1,sp)
2235  002e a504          	bcp	a,#4
2236  0030 2709          	jreq	L157
2237                     ; 727 		GPIO_WriteReverse(LED_PORT, LED4);
2239  0032 4b04          	push	#4
2240  0034 ae500a        	ldw	x,#20490
2241  0037 cd0000        	call	_GPIO_WriteReverse
2243  003a 84            	pop	a
2244  003b               L157:
2245                     ; 729 	if(LedNum & LED5)//LED5
2247  003b 7b01          	ld	a,(OFST+1,sp)
2248  003d a502          	bcp	a,#2
2249  003f 2709          	jreq	L357
2250                     ; 731 		GPIO_WriteReverse(LED_PORT, LED5);
2252  0041 4b02          	push	#2
2253  0043 ae500a        	ldw	x,#20490
2254  0046 cd0000        	call	_GPIO_WriteReverse
2256  0049 84            	pop	a
2257  004a               L357:
2258                     ; 733 }
2261  004a 84            	pop	a
2262  004b 81            	ret
2295                     ; 735 void KEY_Init(u8 KeyNum)
2295                     ; 736 {
2296                     .text:	section	.text,new
2297  0000               _KEY_Init:
2299  0000 88            	push	a
2300       00000000      OFST:	set	0
2303                     ; 737 	if(KeyNum & KEY1)//LED1
2305  0001 a501          	bcp	a,#1
2306  0003 270b          	jreq	L177
2307                     ; 739 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY1, GPIO_MODE_IN_PU_NO_IT);
2309  0005 4b40          	push	#64
2310  0007 4b01          	push	#1
2311  0009 ae5005        	ldw	x,#20485
2312  000c cd0000        	call	_GPIO_Init
2314  000f 85            	popw	x
2315  0010               L177:
2316                     ; 741 	if(KeyNum & KEY2)//LED2
2318  0010 7b01          	ld	a,(OFST+1,sp)
2319  0012 a502          	bcp	a,#2
2320  0014 270b          	jreq	L377
2321                     ; 743 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY2, GPIO_MODE_IN_PU_NO_IT);
2323  0016 4b40          	push	#64
2324  0018 4b02          	push	#2
2325  001a ae5005        	ldw	x,#20485
2326  001d cd0000        	call	_GPIO_Init
2328  0020 85            	popw	x
2329  0021               L377:
2330                     ; 745 }
2333  0021 84            	pop	a
2334  0022 81            	ret
2388                     ; 747 bool KEY_Read(u8 KeyNum)
2388                     ; 748 {
2389                     .text:	section	.text,new
2390  0000               _KEY_Read:
2392  0000 88            	push	a
2393       00000000      OFST:	set	0
2396                     ; 749 	if(KeyNum & KEY1)//LED1
2398  0001 a501          	bcp	a,#1
2399  0003 2713          	jreq	L1201
2400                     ; 751 		if((GPIO_ReadInputData(KEY_PORT) & 0x01) == 0x00)
2402  0005 ae5005        	ldw	x,#20485
2403  0008 cd0000        	call	_GPIO_ReadInputData
2405  000b a501          	bcp	a,#1
2406  000d 2605          	jrne	L3201
2407                     ; 752 			return TRUE;
2409  000f a601          	ld	a,#1
2412  0011 5b01          	addw	sp,#1
2413  0013 81            	ret
2414  0014               L3201:
2415                     ; 754 			return FALSE;
2417  0014 4f            	clr	a
2420  0015 5b01          	addw	sp,#1
2421  0017 81            	ret
2422  0018               L1201:
2423                     ; 756 	if(KeyNum & KEY2)//LED2
2425  0018 7b01          	ld	a,(OFST+1,sp)
2426  001a a502          	bcp	a,#2
2427  001c 2713          	jreq	L7201
2428                     ; 758 		if((GPIO_ReadInputData(KEY_PORT) & 0x02) == 0x00)
2430  001e ae5005        	ldw	x,#20485
2431  0021 cd0000        	call	_GPIO_ReadInputData
2433  0024 a502          	bcp	a,#2
2434  0026 2605          	jrne	L1301
2435                     ; 759 			return TRUE;
2437  0028 a601          	ld	a,#1
2440  002a 5b01          	addw	sp,#1
2441  002c 81            	ret
2442  002d               L1301:
2443                     ; 761 			return FALSE;
2445  002d 4f            	clr	a
2448  002e 5b01          	addw	sp,#1
2449  0030 81            	ret
2450  0031               L7201:
2451                     ; 763 }
2454  0031 5b01          	addw	sp,#1
2455  0033 81            	ret
2501                     ; 768 void delay(u16 Count)
2501                     ; 769 {
2502                     .text:	section	.text,new
2503  0000               _delay:
2505  0000 89            	pushw	x
2506  0001 89            	pushw	x
2507       00000002      OFST:	set	2
2510  0002 2014          	jra	L7501
2511  0004               L5501:
2512                     ; 773     for(i=0;i<100;i++)
2514  0004 0f01          	clr	(OFST-1,sp)
2515  0006               L3601:
2516                     ; 774     for(j=0;j<50;j++);
2518  0006 0f02          	clr	(OFST+0,sp)
2519  0008               L1701:
2523  0008 0c02          	inc	(OFST+0,sp)
2526  000a 7b02          	ld	a,(OFST+0,sp)
2527  000c a132          	cp	a,#50
2528  000e 25f8          	jrult	L1701
2529                     ; 773     for(i=0;i<100;i++)
2531  0010 0c01          	inc	(OFST-1,sp)
2534  0012 7b01          	ld	a,(OFST-1,sp)
2535  0014 a164          	cp	a,#100
2536  0016 25ee          	jrult	L3601
2537  0018               L7501:
2538                     ; 771   while (Count--)//Count形参控制延时次数
2540  0018 1e03          	ldw	x,(OFST+1,sp)
2541  001a 1d0001        	subw	x,#1
2542  001d 1f03          	ldw	(OFST+1,sp),x
2543  001f 1c0001        	addw	x,#1
2544  0022 a30000        	cpw	x,#0
2545  0025 26dd          	jrne	L5501
2546                     ; 776 }
2549  0027 5b04          	addw	sp,#4
2550  0029 81            	ret
2613                     	xdef	_main
2614                     	xdef	_EXTI_Config
2615                     	xdef	_ExtraCode_StateMachine
2616                     	xdef	_ExtraCode_Init
2617                     	switch	.bss
2618  0000               _ptr:
2619  0000 0000          	ds.b	2
2620                     	xdef	_ptr
2621                     .bit:	section	.data,bit
2622  0000               _p_valid:
2623  0000 00            	ds.b	1
2624                     	xdef	_p_valid
2625  0001               _in_range:
2626  0001 00            	ds.b	1
2627                     	xdef	_in_range
2628                     	switch	.bss
2629  0002               _gest_cnt:
2630  0002 00            	ds.b	1
2631                     	xdef	_gest_cnt
2632  0003               _isr_flag:
2633  0003 00            	ds.b	1
2634                     	xdef	_isr_flag
2635                     	xref	_readGesture
2636                     	xref	_isGestureAvailable
2637                     	xref	_readBlueLight
2638                     	xref	_readGreenLight
2639                     	xref	_readRedLight
2640                     	xref	_readAmbientLight
2641                     	xref	_clearAmbientLightInt
2642                     	xref	_setAmbientLightIntEnable
2643                     	xref	_setLightIntHighThreshold
2644                     	xref	_getLightIntHighThreshold
2645                     	xref	_setLightIntLowThreshold
2646                     	xref	_getLightIntLowThreshold
2647                     	xref	_enableGestureSensor
2648                     	xref	_enableLightSensor
2649                     	xref	_init
2650                     	xref	_TIM3_tout
2651                     	xref	_reve_analyze_reply
2652                     	xref	_Check_Sum
2653                     	xref	_UART2_Send_Data_Start
2654                     	xref	_Init_uart2
2655                     	xref	_send_buf
2656                     	xref	_st1
2657                     	xref	_UART1Flag3_
2658                     	xref	_UART1Flag2_
2659                     	xdef	_LightTest
2660                     	xdef	_GestureTest
2661                     	xdef	_handleGesture
2662                     	xdef	_PORTD_EXT_ISR
2663                     	xdef	_Variable_Init
2664                     	xdef	_KEY_Read
2665                     	xdef	_KEY_Init
2666                     	xdef	_LED_Toggle
2667                     	xdef	_LED_Off
2668                     	xdef	_LED_On
2669                     	xdef	_LED_Init
2670                     	xdef	_delay
2671                     	xdef	_Task_1s
2672                     	xdef	_Task_300ms
2673                     	xdef	_Task_100ms
2674                     	xdef	_Task_2ms
2675                     	xdef	_Task_500us
2676  0004               _Flag1_:
2677  0004 00            	ds.b	1
2678                     	xdef	_Flag1_
2679  0005               _systime_count:
2680  0005 000000000000  	ds.b	8
2681                     	xdef	_systime_count
2682  000d               _gusture:
2683  000d 0000          	ds.b	2
2684                     	xdef	_gusture
2685                     	xref	_TSL_Action
2686                     	xref	_TSL_Init
2687                     	xref	_sSCKeyInfo
2688                     	xref.b	_TSL_GlobalSetting
2689                     	xref.b	_TSLState
2690                     	xref	_GPIO_ReadInputData
2691                     	xref	_GPIO_WriteReverse
2692                     	xref	_GPIO_WriteLow
2693                     	xref	_GPIO_WriteHigh
2694                     	xref	_GPIO_Init
2695                     	xref	_EXTI_SetTLISensitivity
2696                     	xref	_EXTI_SetExtIntSensitivity
2697                     	xref	_EXTI_DeInit
2717                     	end
