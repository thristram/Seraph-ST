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
 209                     ; 61 	st1.st_ges1_ctrl_H = 0x11;//初始化为无效手势
 211  0010 3511001c      	mov	_st1+28,#17
 212                     ; 62 	st1.st_ges1_ctrl_L = 0x11;
 214  0014 3511001d      	mov	_st1+29,#17
 215                     ; 63 	st1.st_ges2_ctrl_H = 0x11;
 217  0018 35110021      	mov	_st1+33,#17
 218                     ; 64 	st1.st_ges2_ctrl_L = 0x11;
 220  001c 35110022      	mov	_st1+34,#17
 221                     ; 65 	st1.st_ges3_ctrl_H = 0x11;
 223  0020 35110026      	mov	_st1+38,#17
 224                     ; 66 	st1.st_ges3_ctrl_L = 0x11;
 226  0024 35110027      	mov	_st1+39,#17
 227                     ; 67 	st1.st_ges4_ctrl_H = 0x11;
 229  0028 3511002b      	mov	_st1+43,#17
 230                     ; 68 	st1.st_ges4_ctrl_L = 0x11;
 232  002c 3511002c      	mov	_st1+44,#17
 233                     ; 69 }
 236  0030 81            	ret
 263                     ; 110 void EXTI_Config(void)
 263                     ; 111 {
 264                     .text:	section	.text,new
 265  0000               _EXTI_Config:
 269                     ; 112 	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_IN_PU_IT );
 271  0000 4b60          	push	#96
 272  0002 4b01          	push	#1
 273  0004 ae500f        	ldw	x,#20495
 274  0007 cd0000        	call	_GPIO_Init
 276  000a 85            	popw	x
 277                     ; 113 	EXTI_DeInit();
 279  000b cd0000        	call	_EXTI_DeInit
 281                     ; 114 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);//下降沿触发中断
 283  000e 4f            	clr	a
 284  000f cd0000        	call	_EXTI_SetTLISensitivity
 286                     ; 115 	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOD),EXTI_SENSITIVITY_FALL_ONLY);
 288  0012 ae0002        	ldw	x,#2
 289  0015 a603          	ld	a,#3
 290  0017 95            	ld	xh,a
 291  0018 cd0000        	call	_EXTI_SetExtIntSensitivity
 293                     ; 116 }
 296  001b 81            	ret
 322                     ; 118 @interrupt void PORTD_EXT_ISR(void)
 322                     ; 119 {
 323                     .text:	section	.text,new
 324  0000               _PORTD_EXT_ISR:
 329                     ; 120 	disableInterrupts();//关中断
 332  0000 9b            sim
 334                     ; 121 	isr_flag = 1;
 337  0001 35010003      	mov	_isr_flag,#1
 338                     ; 122 	enableInterrupts();
 341  0005 9a            rim
 343                     ; 123 }
 347  0006 80            	iret
 409                     ; 134 void main(void)
 409                     ; 135 {
 410                     .text:	section	.text,new
 411  0000               _main:
 413  0000 88            	push	a
 414       00000001      OFST:	set	1
 417                     ; 150   unsigned char value = 100;
 419  0001 a664          	ld	a,#100
 420  0003 6b01          	ld	(OFST+0,sp),a
 421                     ; 151   in_range = (value >= 10) && (value <= 20);
 423  0005 72110001      	bres	_in_range
 424                     ; 152   p_valid = ptr;   /* p_valid is true if ptr not 0 */
 426  0009 ce0000        	ldw	x,_ptr
 427  000c 2602          	jrne	L02
 428  000e 2006          	jp	L41
 429  0010               L02:
 430  0010 72100000      	bset	_p_valid
 431  0014 2004          	jra	L61
 432  0016               L41:
 433  0016 72110000      	bres	_p_valid
 434  001a               L61:
 435                     ; 161 	CLK->SWCR |= 0x02; //开启切换
 437  001a 721250c5      	bset	20677,#1
 438                     ; 162   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 440  001e 35b450c4      	mov	20676,#180
 442  0022               L161:
 443                     ; 163   while((CLK->SWCR & 0x01)==0x01);
 445  0022 c650c5        	ld	a,20677
 446  0025 a401          	and	a,#1
 447  0027 a101          	cp	a,#1
 448  0029 27f7          	jreq	L161
 449                     ; 164   CLK->CKDIVR = 0x80;    //不分频
 451  002b 358050c6      	mov	20678,#128
 452                     ; 165   CLK->SWCR  &= ~0x02; //关闭切换
 454  002f 721350c5      	bres	20677,#1
 455                     ; 166 	LED_Init(LED1|LED2|LED3|LED4|LED5);
 457  0033 a63e          	ld	a,#62
 458  0035 cd0000        	call	_LED_Init
 460                     ; 167 	KEY_Init(KEY1|KEY2);
 462  0038 a603          	ld	a,#3
 463  003a cd0000        	call	_KEY_Init
 465                     ; 168 	Variable_Init();
 467  003d cd0000        	call	_Variable_Init
 469                     ; 170 	EXTI_Config();
 471  0040 cd0000        	call	_EXTI_Config
 473                     ; 171 	Init_uart2();
 475  0043 cd0000        	call	_Init_uart2
 477                     ; 172 	init();//init apds9960
 479  0046 cd0000        	call	_init
 481                     ; 173 	GestureTest();
 483  0049 cd0000        	call	_GestureTest
 485                     ; 174 	TSL_Init();
 487  004c cd0000        	call	_TSL_Init
 489                     ; 175 	ExtraCode_Init();	
 491  004f cd0000        	call	_ExtraCode_Init
 493  0052               L561:
 494                     ; 178 		if((!receipt_device_info1) && (!device_info_sended) && (rev_bleheartbeat) && (rev_host_mesh))
 496  0052 c60000        	ld	a,_UART1Flag5_
 497  0055 a501          	bcp	a,#1
 498  0057 2633          	jrne	L171
 500  0059 c60004        	ld	a,_Flag1_
 501  005c a540          	bcp	a,#64
 502  005e 262c          	jrne	L171
 504  0060 c60000        	ld	a,_UART1Flag1_
 505  0063 a580          	bcp	a,#128
 506  0065 2725          	jreq	L171
 508  0067 c60000        	ld	a,_UART1Flag2_
 509  006a a540          	bcp	a,#64
 510  006c 271e          	jreq	L171
 511                     ; 180 			device_info_sended = 1;
 513  006e 721c0004      	bset	_Flag1_,#6
 514                     ; 181 			rev_bleheartbeat = 0;
 516  0072 721f0000      	bres	_UART1Flag1_,#7
 517                     ; 182 			send_header_payload_init(0x86,ns_host_meshid_H,ns_host_meshid_L,12,0xB4);
 519  0076 4bb4          	push	#180
 520  0078 4b0c          	push	#12
 521  007a 3b0000        	push	_ns_host_meshid_L
 522  007d c60000        	ld	a,_ns_host_meshid_H
 523  0080 97            	ld	xl,a
 524  0081 a686          	ld	a,#134
 525  0083 95            	ld	xh,a
 526  0084 cd0000        	call	_send_header_payload_init
 528  0087 5b03          	addw	sp,#3
 529                     ; 183 			UART2_Send_Data_Start();
 531  0089 cd0000        	call	_UART2_Send_Data_Start
 533  008c               L171:
 534                     ; 186     Task_2ms();
 536  008c cd0000        	call	_Task_2ms
 538                     ; 187 		Task_100ms();
 540  008f cd0000        	call	_Task_100ms
 542                     ; 188 		Task_300ms();
 544  0092 cd0000        	call	_Task_300ms
 546                     ; 189 		Task_1s();
 548  0095 cd0000        	call	_Task_1s
 550                     ; 190 		ExtraCode_StateMachine();			 
 552  0098 cd0000        	call	_ExtraCode_StateMachine
 554                     ; 191 		TSL_Action();
 556  009b cd0000        	call	_TSL_Action
 558                     ; 226 		if(isr_flag ==1)
 560  009e c60003        	ld	a,_isr_flag
 561  00a1 a101          	cp	a,#1
 562  00a3 26ad          	jrne	L561
 563                     ; 228 			LED_On(LED5);
 565  00a5 a602          	ld	a,#2
 566  00a7 cd0000        	call	_LED_On
 568                     ; 229 			handleGesture();
 570  00aa cd0000        	call	_handleGesture
 572                     ; 230 			if((GPIOD->IDR&0x01)==0)
 574  00ad c65010        	ld	a,20496
 575  00b0 a501          	bcp	a,#1
 576  00b2 2608          	jrne	L571
 577                     ; 232 				init();
 579  00b4 cd0000        	call	_init
 581                     ; 233 				enableGestureSensor(1);
 583  00b7 a601          	ld	a,#1
 584  00b9 cd0000        	call	_enableGestureSensor
 586  00bc               L571:
 587                     ; 235 			isr_flag = 0;	
 589  00bc 725f0003      	clr	_isr_flag
 590  00c0 2090          	jra	L561
 625                     ; 252 void ExtraCode_Init(void)
 625                     ; 253 {
 626                     .text:	section	.text,new
 627  0000               _ExtraCode_Init:
 629  0000 88            	push	a
 630       00000001      OFST:	set	1
 633                     ; 259   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 635  0001 0f01          	clr	(OFST+0,sp)
 636  0003               L312:
 637                     ; 261     sSCKeyInfo[i].Setting.b.IMPLEMENTED = 1;
 639  0003 7b01          	ld	a,(OFST+0,sp)
 640  0005 97            	ld	xl,a
 641  0006 a60f          	ld	a,#15
 642  0008 42            	mul	x,a
 643  0009 d60002        	ld	a,(_sSCKeyInfo+2,x)
 644  000c aa01          	or	a,#1
 645  000e d70002        	ld	(_sSCKeyInfo+2,x),a
 646                     ; 262     sSCKeyInfo[i].Setting.b.ENABLED = 1;
 648  0011 7b01          	ld	a,(OFST+0,sp)
 649  0013 97            	ld	xl,a
 650  0014 a60f          	ld	a,#15
 651  0016 42            	mul	x,a
 652  0017 d60002        	ld	a,(_sSCKeyInfo+2,x)
 653  001a aa02          	or	a,#2
 654  001c d70002        	ld	(_sSCKeyInfo+2,x),a
 655                     ; 263     sSCKeyInfo[i].DESGroup = 0x01; /* Put 0x00 to disable the DES on these pins */
 657  001f 7b01          	ld	a,(OFST+0,sp)
 658  0021 97            	ld	xl,a
 659  0022 a60f          	ld	a,#15
 660  0024 42            	mul	x,a
 661  0025 a601          	ld	a,#1
 662  0027 d70004        	ld	(_sSCKeyInfo+4,x),a
 663                     ; 259   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 665  002a 0c01          	inc	(OFST+0,sp)
 668  002c 7b01          	ld	a,(OFST+0,sp)
 669  002e a103          	cp	a,#3
 670  0030 25d1          	jrult	L312
 671                     ; 276 	LED_On(LED1);
 673  0032 a608          	ld	a,#8
 674  0034 cd0000        	call	_LED_On
 676                     ; 277 	LED_On(LED2);
 678  0037 a610          	ld	a,#16
 679  0039 cd0000        	call	_LED_On
 681                     ; 278 	LED_On(LED3);
 683  003c a620          	ld	a,#32
 684  003e cd0000        	call	_LED_On
 686                     ; 279   LED_On(LED5);
 688  0041 a602          	ld	a,#2
 689  0043 cd0000        	call	_LED_On
 691                     ; 280   enableInterrupts();
 694  0046 9a            rim
 696                     ; 282 }
 700  0047 84            	pop	a
 701  0048 81            	ret
 731                     ; 295 void ExtraCode_StateMachine(void)
 731                     ; 296 {
 732                     .text:	section	.text,new
 733  0000               _ExtraCode_StateMachine:
 737                     ; 297 	if ((TSL_GlobalSetting.b.CHANGED) && (TSLState == TSL_IDLE_STATE))
 739  0000 b601          	ld	a,_TSL_GlobalSetting+1
 740  0002 a508          	bcp	a,#8
 741  0004 2603          	jrne	L62
 742  0006 cc00d9        	jp	L132
 743  0009               L62:
 745  0009 b600          	ld	a,_TSLState
 746  000b a101          	cp	a,#1
 747  000d 2703          	jreq	L03
 748  000f cc00d9        	jp	L132
 749  0012               L03:
 750                     ; 300 		TSL_GlobalSetting.b.CHANGED = 0;
 752  0012 72170001      	bres	_TSL_GlobalSetting+1,#3
 753                     ; 302     if (sSCKeyInfo[0].Setting.b.DETECTED) /* KEY 1 touched */
 755  0016 c60002        	ld	a,_sSCKeyInfo+2
 756  0019 a504          	bcp	a,#4
 757  001b 273a          	jreq	L332
 758                     ; 304 			LED_Toggle(LED1);
 760  001d a608          	ld	a,#8
 761  001f cd0000        	call	_LED_Toggle
 763                     ; 305 			st_pad1_ctrl = 1;
 765  0022 72120000      	bset	_UART1Flag3_,#1
 766                     ; 306 			if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
 768  0026 725d000d      	tnz	_st1+13
 769  002a 2714          	jreq	L532
 771  002c 725d000e      	tnz	_st1+14
 772  0030 270e          	jreq	L532
 774  0032 725d000f      	tnz	_st1+15
 775  0036 2708          	jreq	L532
 776                     ; 308 				st_pad1_confirm = 1;
 778  0038 72180000      	bset	_UART1Flag3_,#4
 779                     ; 309 				st1.st_ctrl_address = 0x01;
 781  003c 35010003      	mov	_st1+3,#1
 782  0040               L532:
 783                     ; 317 			if (st1.st_pad1_status == 0x00)
 785  0040 725d0006      	tnz	_st1+6
 786  0044 2606          	jrne	L732
 787                     ; 319 				st1.st_pad1_status = 0x63;
 789  0046 35630006      	mov	_st1+6,#99
 791  004a 200b          	jra	L332
 792  004c               L732:
 793                     ; 321 			else if (st1.st_pad1_status == 0x63)
 795  004c c60006        	ld	a,_st1+6
 796  004f a163          	cp	a,#99
 797  0051 2604          	jrne	L332
 798                     ; 323 				st1.st_pad1_status = 0x00;
 800  0053 725f0006      	clr	_st1+6
 801  0057               L332:
 802                     ; 327     if (sSCKeyInfo[1].Setting.b.DETECTED) /* KEY 2 touched */
 804  0057 c60011        	ld	a,_sSCKeyInfo+17
 805  005a a504          	bcp	a,#4
 806  005c 273a          	jreq	L542
 807                     ; 329 			LED_Toggle(LED2);
 809  005e a610          	ld	a,#16
 810  0060 cd0000        	call	_LED_Toggle
 812                     ; 330 			st_pad2_ctrl = 1;
 814  0063 72140000      	bset	_UART1Flag3_,#2
 815                     ; 331 			if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
 817  0067 725d0012      	tnz	_st1+18
 818  006b 2714          	jreq	L742
 820  006d 725d0013      	tnz	_st1+19
 821  0071 270e          	jreq	L742
 823  0073 725d0014      	tnz	_st1+20
 824  0077 2708          	jreq	L742
 825                     ; 333 				st_pad2_confirm = 1;
 827  0079 721a0000      	bset	_UART1Flag3_,#5
 828                     ; 334 				st1.st_ctrl_address = 0x02;
 830  007d 35020003      	mov	_st1+3,#2
 831  0081               L742:
 832                     ; 341 			if (st1.st_pad2_status == 0x00)
 834  0081 725d0007      	tnz	_st1+7
 835  0085 2606          	jrne	L152
 836                     ; 343 				st1.st_pad2_status = 0x63;
 838  0087 35630007      	mov	_st1+7,#99
 840  008b 200b          	jra	L542
 841  008d               L152:
 842                     ; 345 			else if (st1.st_pad2_status == 0x63)
 844  008d c60007        	ld	a,_st1+7
 845  0090 a163          	cp	a,#99
 846  0092 2604          	jrne	L542
 847                     ; 347 				st1.st_pad2_status = 0x00;
 849  0094 725f0007      	clr	_st1+7
 850  0098               L542:
 851                     ; 351     if (sSCKeyInfo[2].Setting.b.DETECTED) /* KEY 3 touched */
 853  0098 c60020        	ld	a,_sSCKeyInfo+32
 854  009b a504          	bcp	a,#4
 855  009d 273a          	jreq	L132
 856                     ; 353       LED_Toggle(LED3);
 858  009f a620          	ld	a,#32
 859  00a1 cd0000        	call	_LED_Toggle
 861                     ; 354 			st_pad3_ctrl = 1;
 863  00a4 72160000      	bset	_UART1Flag3_,#3
 864                     ; 355 			if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
 866  00a8 725d0017      	tnz	_st1+23
 867  00ac 2714          	jreq	L162
 869  00ae 725d0018      	tnz	_st1+24
 870  00b2 270e          	jreq	L162
 872  00b4 725d0019      	tnz	_st1+25
 873  00b8 2708          	jreq	L162
 874                     ; 357 				st_pad3_confirm = 1;
 876  00ba 721c0000      	bset	_UART1Flag3_,#6
 877                     ; 358 				st1.st_ctrl_address = 0x04;
 879  00be 35040003      	mov	_st1+3,#4
 880  00c2               L162:
 881                     ; 365 			if (st1.st_pad3_status == 0x00)
 883  00c2 725d0008      	tnz	_st1+8
 884  00c6 2606          	jrne	L362
 885                     ; 367 				st1.st_pad3_status = 0x63;
 887  00c8 35630008      	mov	_st1+8,#99
 889  00cc 200b          	jra	L132
 890  00ce               L362:
 891                     ; 369 			else if (st1.st_pad3_status == 0x63)
 893  00ce c60008        	ld	a,_st1+8
 894  00d1 a163          	cp	a,#99
 895  00d3 2604          	jrne	L132
 896                     ; 371 				st1.st_pad3_status = 0x00;
 898  00d5 725f0008      	clr	_st1+8
 899  00d9               L132:
 900                     ; 375 }
 903  00d9 81            	ret
 931                     ; 377 void handleGesture(void) {
 932                     .text:	section	.text,new
 933  0000               _handleGesture:
 937                     ; 378     if ( isGestureAvailable() ) {
 939  0000 cd0000        	call	_isGestureAvailable
 941  0003 4d            	tnz	a
 942  0004 2603          	jrne	L43
 943  0006 cc0120        	jp	L713
 944  0009               L43:
 945                     ; 389 			gest_cnt++;					
 947  0009 725c0002      	inc	_gest_cnt
 948                     ; 390     switch ( readGesture() ) {
 950  000d cd0000        	call	_readGesture
 953                     ; 427       default:
 953                     ; 428         //printf("NONE\n");
 953                     ; 429 				//send_buf[8] = 0x01;
 953                     ; 430 				break;
 954  0010 5a            	decw	x
 955  0011 2603          	jrne	L63
 956  0013 cc00ac        	jp	L572
 957  0016               L63:
 958  0016 5a            	decw	x
 959  0017 2603          	jrne	L04
 960  0019 cc00e7        	jp	L772
 961  001c               L04:
 962  001c 5a            	decw	x
 963  001d 2707          	jreq	L172
 964  001f 5a            	decw	x
 965  0020 2748          	jreq	L372
 966  0022 ac200120      	jpf	L713
 967  0026               L172:
 968                     ; 391       case DIR_UP:
 968                     ; 392         //printf("UP\n");
 968                     ; 393 				if(gest_cnt == 1)				st1.st_ges_H |= 0xC0;
 970  0026 c60002        	ld	a,_gest_cnt
 971  0029 a101          	cp	a,#1
 972  002b 260c          	jrne	L523
 975  002d c60000        	ld	a,_st1
 976  0030 aac0          	or	a,#192
 977  0032 c70000        	ld	_st1,a
 979  0035 ac200120      	jpf	L713
 980  0039               L523:
 981                     ; 394 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0C;
 983  0039 c60002        	ld	a,_gest_cnt
 984  003c a102          	cp	a,#2
 985  003e 260c          	jrne	L133
 988  0040 c60000        	ld	a,_st1
 989  0043 aa0c          	or	a,#12
 990  0045 c70000        	ld	_st1,a
 992  0048 ac200120      	jpf	L713
 993  004c               L133:
 994                     ; 395 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xC0;gest_cnt = 0;gest_detect = 1;}
 996  004c c60002        	ld	a,_gest_cnt
 997  004f a103          	cp	a,#3
 998  0051 2703          	jreq	L24
 999  0053 cc0120        	jp	L713
1000  0056               L24:
1003  0056 c60001        	ld	a,_st1+1
1004  0059 aac0          	or	a,#192
1005  005b c70001        	ld	_st1+1,a
1008  005e 725f0002      	clr	_gest_cnt
1011  0062 72100000      	bset	_UART1Flag2_,#0
1012  0066 ac200120      	jpf	L713
1013  006a               L372:
1014                     ; 398       case DIR_DOWN:
1014                     ; 399         //printf("DOWN\n");
1014                     ; 400 				//send_buf[1] = 0x01;
1014                     ; 401 				if(gest_cnt == 1)				st1.st_ges_H |= 0xD0;
1016  006a c60002        	ld	a,_gest_cnt
1017  006d a101          	cp	a,#1
1018  006f 260c          	jrne	L733
1021  0071 c60000        	ld	a,_st1
1022  0074 aad0          	or	a,#208
1023  0076 c70000        	ld	_st1,a
1025  0079 ac200120      	jpf	L713
1026  007d               L733:
1027                     ; 402 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0D;
1029  007d c60002        	ld	a,_gest_cnt
1030  0080 a102          	cp	a,#2
1031  0082 260c          	jrne	L343
1034  0084 c60000        	ld	a,_st1
1035  0087 aa0d          	or	a,#13
1036  0089 c70000        	ld	_st1,a
1038  008c ac200120      	jpf	L713
1039  0090               L343:
1040                     ; 403 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xD0;gest_cnt = 0;gest_detect = 1;}
1042  0090 c60002        	ld	a,_gest_cnt
1043  0093 a103          	cp	a,#3
1044  0095 2703          	jreq	L44
1045  0097 cc0120        	jp	L713
1046  009a               L44:
1049  009a c60001        	ld	a,_st1+1
1050  009d aad0          	or	a,#208
1051  009f c70001        	ld	_st1+1,a
1054  00a2 725f0002      	clr	_gest_cnt
1057  00a6 72100000      	bset	_UART1Flag2_,#0
1058  00aa 2074          	jra	L713
1059  00ac               L572:
1060                     ; 405       case DIR_LEFT:
1060                     ; 406         //printf("LEFT\n");
1060                     ; 407 				//send_buf[2] = 0x01;
1060                     ; 408 				if(gest_cnt == 1)		st1.st_ges_H |= 0xE0;
1062  00ac c60002        	ld	a,_gest_cnt
1063  00af a101          	cp	a,#1
1064  00b1 260a          	jrne	L153
1067  00b3 c60000        	ld	a,_st1
1068  00b6 aae0          	or	a,#224
1069  00b8 c70000        	ld	_st1,a
1071  00bb 2063          	jra	L713
1072  00bd               L153:
1073                     ; 409 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0E;
1075  00bd c60002        	ld	a,_gest_cnt
1076  00c0 a102          	cp	a,#2
1077  00c2 260a          	jrne	L553
1080  00c4 c60000        	ld	a,_st1
1081  00c7 aa0e          	or	a,#14
1082  00c9 c70000        	ld	_st1,a
1084  00cc 2052          	jra	L713
1085  00ce               L553:
1086                     ; 410 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xE0;gest_cnt = 0;gest_detect = 1;}
1088  00ce c60002        	ld	a,_gest_cnt
1089  00d1 a103          	cp	a,#3
1090  00d3 264b          	jrne	L713
1093  00d5 c60001        	ld	a,_st1+1
1094  00d8 aae0          	or	a,#224
1095  00da c70001        	ld	_st1+1,a
1098  00dd 725f0002      	clr	_gest_cnt
1101  00e1 72100000      	bset	_UART1Flag2_,#0
1102  00e5 2039          	jra	L713
1103  00e7               L772:
1104                     ; 412       case DIR_RIGHT:
1104                     ; 413         //printf("RIGHT\n");
1104                     ; 414 				if(gest_cnt == 1)		st1.st_ges_H |= 0xF0;
1106  00e7 c60002        	ld	a,_gest_cnt
1107  00ea a101          	cp	a,#1
1108  00ec 260a          	jrne	L363
1111  00ee c60000        	ld	a,_st1
1112  00f1 aaf0          	or	a,#240
1113  00f3 c70000        	ld	_st1,a
1115  00f6 2028          	jra	L713
1116  00f8               L363:
1117                     ; 415 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0F;
1119  00f8 c60002        	ld	a,_gest_cnt
1120  00fb a102          	cp	a,#2
1121  00fd 260a          	jrne	L763
1124  00ff c60000        	ld	a,_st1
1125  0102 aa0f          	or	a,#15
1126  0104 c70000        	ld	_st1,a
1128  0107 2017          	jra	L713
1129  0109               L763:
1130                     ; 416 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xF0;gest_cnt = 0;gest_detect = 1;}
1132  0109 c60002        	ld	a,_gest_cnt
1133  010c a103          	cp	a,#3
1134  010e 2610          	jrne	L713
1137  0110 c60001        	ld	a,_st1+1
1138  0113 aaf0          	or	a,#240
1139  0115 c70001        	ld	_st1+1,a
1142  0118 725f0002      	clr	_gest_cnt
1145  011c 72100000      	bset	_UART1Flag2_,#0
1146  0120               L103:
1147                     ; 419       case DIR_NEAR:
1147                     ; 420         //printf("NEAR\n");
1147                     ; 421 				//send_buf[6] = 0x01;
1147                     ; 422         break;
1149  0120               L303:
1150                     ; 423       case DIR_FAR:
1150                     ; 424         //printf("FAR\n");
1150                     ; 425 				//send_buf[7] = 0x01;
1150                     ; 426         break;
1152  0120               L503:
1153                     ; 427       default:
1153                     ; 428         //printf("NONE\n");
1153                     ; 429 				//send_buf[8] = 0x01;
1153                     ; 430 				break;
1155  0120               L323:
1156  0120               L713:
1157                     ; 437 }
1160  0120 81            	ret
1184                     ; 439 void GestureTest(void)
1184                     ; 440 {
1185                     .text:	section	.text,new
1186  0000               _GestureTest:
1190                     ; 450   if ( enableGestureSensor(1) ) {
1192  0000 a601          	ld	a,#1
1193  0002 cd0000        	call	_enableGestureSensor
1195  0005 4d            	tnz	a
1197  0006               L704:
1198                     ; 457 }
1201  0006 81            	ret
1204                     	switch	.data
1205  0000               L114_ambient_light:
1206  0000 0000          	dc.w	0
1207  0002               L314_red_light:
1208  0002 0000          	dc.w	0
1209  0004               L514_green_light:
1210  0004 0000          	dc.w	0
1211  0006               L714_blue_light:
1212  0006 0000          	dc.w	0
1213  0008               L124_threshold:
1214  0008 0000          	dc.w	0
1287                     ; 459 void LightTest(void)
1287                     ; 460 {
1288                     .text:	section	.text,new
1289  0000               _LightTest:
1293                     ; 467   if ( init() ) {
1295  0000 cd0000        	call	_init
1297  0003 4d            	tnz	a
1298  0004 270a          	jreq	L744
1300                     ; 477   if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
1302  0006 ae000a        	ldw	x,#10
1303  0009 cd0000        	call	_setLightIntLowThreshold
1305  000c 4d            	tnz	a
1306  000d 2607          	jrne	L354
1307                     ; 479 		return;
1310  000f 81            	ret
1311  0010               L744:
1312                     ; 472 		LED_Toggle(LED5);
1314  0010 a602          	ld	a,#2
1315  0012 cd0000        	call	_LED_Toggle
1317                     ; 473 		return;
1320  0015 81            	ret
1321  0016               L354:
1322                     ; 481   if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
1324  0016 ae03e8        	ldw	x,#1000
1325  0019 cd0000        	call	_setLightIntHighThreshold
1327  001c 4d            	tnz	a
1328  001d 2601          	jrne	L554
1329                     ; 483 		return;
1332  001f 81            	ret
1333  0020               L554:
1334                     ; 487   if ( enableLightSensor(0) ) {
1336  0020 4f            	clr	a
1337  0021 cd0000        	call	_enableLightSensor
1339  0024 4d            	tnz	a
1340  0025 270a          	jreq	L754
1342                     ; 495   if ( !getLightIntLowThreshold(&threshold) ) {
1344  0027 ae0008        	ldw	x,#L124_threshold
1345  002a cd0000        	call	_getLightIntLowThreshold
1347  002d 4d            	tnz	a
1348  002e 2602          	jrne	L564
1349                     ; 497 		return;
1352  0030 81            	ret
1353  0031               L754:
1354                     ; 491 		return;
1357  0031 81            	ret
1358  0032               L564:
1359                     ; 501   if ( !getLightIntHighThreshold(&threshold) ) {
1361  0032 ae0008        	ldw	x,#L124_threshold
1362  0035 cd0000        	call	_getLightIntHighThreshold
1364  0038 4d            	tnz	a
1365  0039 2601          	jrne	L174
1366                     ; 503 		return;
1369  003b 81            	ret
1370  003c               L174:
1371                     ; 508 	if ( setAmbientLightIntEnable(0) ) {
1373  003c 4f            	clr	a
1374  003d cd0000        	call	_setAmbientLightIntEnable
1376  0040 4d            	tnz	a
1377  0041 2731          	jreq	L374
1379                     ; 519   delay_ms(200);
1381  0043 ae00c8        	ldw	x,#200
1382  0046 cf0000        	ldw	_TIM3_tout,x
1383  0049               L774:
1387  0049 ce0000        	ldw	x,_TIM3_tout
1388  004c 26fb          	jrne	L774
1389                     ; 525 			if (  !readAmbientLight(&ambient_light) ||
1389                     ; 526 						!readRedLight(&red_light) ||
1389                     ; 527 						!readGreenLight(&green_light) ||
1389                     ; 528 						!readBlueLight(&blue_light) ) {
1392  004e ae0000        	ldw	x,#L114_ambient_light
1393  0051 cd0000        	call	_readAmbientLight
1395  0054 4d            	tnz	a
1396  0055 271e          	jreq	L705
1398  0057 ae0002        	ldw	x,#L314_red_light
1399  005a cd0000        	call	_readRedLight
1401  005d 4d            	tnz	a
1402  005e 2715          	jreq	L705
1404  0060 ae0004        	ldw	x,#L514_green_light
1405  0063 cd0000        	call	_readGreenLight
1407  0066 4d            	tnz	a
1408  0067 270c          	jreq	L705
1410  0069 ae0006        	ldw	x,#L714_blue_light
1411  006c cd0000        	call	_readBlueLight
1413  006f 4d            	tnz	a
1414  0070 2604          	jrne	L515
1415  0072 2001          	jra	L705
1416  0074               L374:
1417                     ; 511 		return;
1420  0074 81            	ret
1421  0075               L705:
1422                     ; 530 				return;
1425  0075 81            	ret
1426  0076               L515:
1427                     ; 556 			if ( !clearAmbientLightInt() ) {
1429  0076 cd0000        	call	_clearAmbientLightInt
1431  0079 4d            	tnz	a
1432  007a 2601          	jrne	L715
1433                     ; 558 				return;
1436  007c 81            	ret
1437  007d               L715:
1438                     ; 560 			enableGestureSensor(1);
1440  007d a601          	ld	a,#1
1441  007f cd0000        	call	_enableGestureSensor
1443                     ; 563 }
1446  0082 81            	ret
1470                     ; 573 void Task_500us(void)
1470                     ; 574 {
1471                     .text:	section	.text,new
1472  0000               _Task_500us:
1476                     ; 575 	if(f_500us)
1478  0000 c60004        	ld	a,_Flag1_
1479  0003 a501          	bcp	a,#1
1480  0005 2704          	jreq	L135
1481                     ; 577 		f_500us = 0;
1483  0007 72110004      	bres	_Flag1_,#0
1484  000b               L135:
1485                     ; 580 }
1488  000b 81            	ret
1513                     ; 587 void Task_2ms(void)
1513                     ; 588 {
1514                     .text:	section	.text,new
1515  0000               _Task_2ms:
1519                     ; 589 	if(f_2ms)
1521  0000 c60004        	ld	a,_Flag1_
1522  0003 a502          	bcp	a,#2
1523  0005 2707          	jreq	L345
1524                     ; 591 		f_2ms = 0;
1526  0007 72130004      	bres	_Flag1_,#1
1527                     ; 592 		reve_analyze_reply();
1529  000b cd0000        	call	_reve_analyze_reply
1531  000e               L345:
1532                     ; 594 }
1535  000e 81            	ret
1559                     ; 601 void Task_100ms(void)
1559                     ; 602 {
1560                     .text:	section	.text,new
1561  0000               _Task_100ms:
1565                     ; 603 	if(f_100ms)
1567  0000 c60004        	ld	a,_Flag1_
1568  0003 a504          	bcp	a,#4
1569  0005 2704          	jreq	L555
1570                     ; 605 		f_100ms = 0;
1572  0007 72150004      	bres	_Flag1_,#2
1573  000b               L555:
1574                     ; 607 }
1577  000b 81            	ret
1601                     ; 614 void Task_300ms(void)
1601                     ; 615 {
1602                     .text:	section	.text,new
1603  0000               _Task_300ms:
1607                     ; 616 	if(f_300ms)
1609  0000 c60004        	ld	a,_Flag1_
1610  0003 a508          	bcp	a,#8
1611  0005 2704          	jreq	L765
1612                     ; 618 		f_300ms = 0;
1614  0007 72170004      	bres	_Flag1_,#3
1615  000b               L765:
1616                     ; 620 }
1619  000b 81            	ret
1622                     	switch	.data
1623  000a               L175_i:
1624  000a 0000          	dc.w	0
1625  000c               L375_j:
1626  000c 0000          	dc.w	0
1668                     ; 627 void Task_1s(void)
1668                     ; 628 {
1669                     .text:	section	.text,new
1670  0000               _Task_1s:
1674                     ; 631 	if(f_1s)
1676  0000 c60004        	ld	a,_Flag1_
1677  0003 a510          	bcp	a,#16
1678  0005 2744          	jreq	L316
1679                     ; 633 		f_1s = 0;
1681  0007 72190004      	bres	_Flag1_,#4
1682                     ; 634 		i++;
1684  000b ce000a        	ldw	x,L175_i
1685  000e 1c0001        	addw	x,#1
1686  0011 cf000a        	ldw	L175_i,x
1687                     ; 635 		j++;
1689  0014 ce000c        	ldw	x,L375_j
1690  0017 1c0001        	addw	x,#1
1691  001a cf000c        	ldw	L375_j,x
1692                     ; 636 		if(i >= 5)	{i = 0;LightTest();}
1694  001d 9c            	rvf
1695  001e ce000a        	ldw	x,L175_i
1696  0021 a30005        	cpw	x,#5
1697  0024 2f07          	jrslt	L516
1700  0026 5f            	clrw	x
1701  0027 cf000a        	ldw	L175_i,x
1704  002a cd0000        	call	_LightTest
1706  002d               L516:
1707                     ; 637 		LED_Toggle(LED4);
1709  002d a604          	ld	a,#4
1710  002f cd0000        	call	_LED_Toggle
1712                     ; 639 		if(j >= 3)	{j = 0;gest_cnt = 0;st1.st_ges_H = 0x00;st1.st_ges_L = 0x00;}
1714  0032 9c            	rvf
1715  0033 ce000c        	ldw	x,L375_j
1716  0036 a30003        	cpw	x,#3
1717  0039 2f10          	jrslt	L316
1720  003b 5f            	clrw	x
1721  003c cf000c        	ldw	L375_j,x
1724  003f 725f0002      	clr	_gest_cnt
1727  0043 725f0000      	clr	_st1
1730  0047 725f0001      	clr	_st1+1
1731  004b               L316:
1732                     ; 656 }
1735  004b 81            	ret
1768                     ; 659 void LED_Init(u8 LedNum)
1768                     ; 660 {
1769                     .text:	section	.text,new
1770  0000               _LED_Init:
1772  0000 88            	push	a
1773       00000000      OFST:	set	0
1776                     ; 661 	if(LedNum & LED1)//LED1
1778  0001 a508          	bcp	a,#8
1779  0003 270b          	jreq	L536
1780                     ; 663 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED1, GPIO_MODE_OUT_PP_LOW_FAST);
1782  0005 4bc0          	push	#192
1783  0007 4b08          	push	#8
1784  0009 ae500a        	ldw	x,#20490
1785  000c cd0000        	call	_GPIO_Init
1787  000f 85            	popw	x
1788  0010               L536:
1789                     ; 665 	if(LedNum & LED2)//LED2
1791  0010 7b01          	ld	a,(OFST+1,sp)
1792  0012 a510          	bcp	a,#16
1793  0014 270b          	jreq	L736
1794                     ; 667 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED2, GPIO_MODE_OUT_PP_LOW_FAST);
1796  0016 4bc0          	push	#192
1797  0018 4b10          	push	#16
1798  001a ae500a        	ldw	x,#20490
1799  001d cd0000        	call	_GPIO_Init
1801  0020 85            	popw	x
1802  0021               L736:
1803                     ; 669 	if(LedNum & LED3)//LED3
1805  0021 7b01          	ld	a,(OFST+1,sp)
1806  0023 a520          	bcp	a,#32
1807  0025 270b          	jreq	L146
1808                     ; 671 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED3, GPIO_MODE_OUT_PP_LOW_FAST);
1810  0027 4bc0          	push	#192
1811  0029 4b20          	push	#32
1812  002b ae500a        	ldw	x,#20490
1813  002e cd0000        	call	_GPIO_Init
1815  0031 85            	popw	x
1816  0032               L146:
1817                     ; 673 	if(LedNum & LED4)//LED4
1819  0032 7b01          	ld	a,(OFST+1,sp)
1820  0034 a504          	bcp	a,#4
1821  0036 270b          	jreq	L346
1822                     ; 675 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED4, GPIO_MODE_OUT_PP_LOW_FAST);
1824  0038 4bc0          	push	#192
1825  003a 4b04          	push	#4
1826  003c ae500a        	ldw	x,#20490
1827  003f cd0000        	call	_GPIO_Init
1829  0042 85            	popw	x
1830  0043               L346:
1831                     ; 677 	if(LedNum & LED5)//LED5
1833  0043 7b01          	ld	a,(OFST+1,sp)
1834  0045 a502          	bcp	a,#2
1835  0047 270b          	jreq	L546
1836                     ; 679 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED5, GPIO_MODE_OUT_PP_LOW_FAST);
1838  0049 4bc0          	push	#192
1839  004b 4b02          	push	#2
1840  004d ae500a        	ldw	x,#20490
1841  0050 cd0000        	call	_GPIO_Init
1843  0053 85            	popw	x
1844  0054               L546:
1845                     ; 681 }
1848  0054 84            	pop	a
1849  0055 81            	ret
1883                     ; 683 void LED_On(u8 LedNum)
1883                     ; 684 {
1884                     .text:	section	.text,new
1885  0000               _LED_On:
1887  0000 88            	push	a
1888       00000000      OFST:	set	0
1891                     ; 685 	if(LedNum & LED1)//LED1
1893  0001 a508          	bcp	a,#8
1894  0003 2709          	jreq	L366
1895                     ; 687 		GPIO_WriteHigh(LED_PORT, LED1);
1897  0005 4b08          	push	#8
1898  0007 ae500a        	ldw	x,#20490
1899  000a cd0000        	call	_GPIO_WriteHigh
1901  000d 84            	pop	a
1902  000e               L366:
1903                     ; 689 	if(LedNum & LED2)//LED2
1905  000e 7b01          	ld	a,(OFST+1,sp)
1906  0010 a510          	bcp	a,#16
1907  0012 2709          	jreq	L566
1908                     ; 691 		GPIO_WriteHigh(LED_PORT, LED2);
1910  0014 4b10          	push	#16
1911  0016 ae500a        	ldw	x,#20490
1912  0019 cd0000        	call	_GPIO_WriteHigh
1914  001c 84            	pop	a
1915  001d               L566:
1916                     ; 693 	if(LedNum & LED3)//LED3
1918  001d 7b01          	ld	a,(OFST+1,sp)
1919  001f a520          	bcp	a,#32
1920  0021 2709          	jreq	L766
1921                     ; 695 		GPIO_WriteHigh(LED_PORT, LED3);
1923  0023 4b20          	push	#32
1924  0025 ae500a        	ldw	x,#20490
1925  0028 cd0000        	call	_GPIO_WriteHigh
1927  002b 84            	pop	a
1928  002c               L766:
1929                     ; 697 	if(LedNum & LED4)//LED4
1931  002c 7b01          	ld	a,(OFST+1,sp)
1932  002e a504          	bcp	a,#4
1933  0030 2709          	jreq	L176
1934                     ; 699 		GPIO_WriteLow(LED_PORT, LED4);
1936  0032 4b04          	push	#4
1937  0034 ae500a        	ldw	x,#20490
1938  0037 cd0000        	call	_GPIO_WriteLow
1940  003a 84            	pop	a
1941  003b               L176:
1942                     ; 701 	if(LedNum & LED5)//LED5
1944  003b 7b01          	ld	a,(OFST+1,sp)
1945  003d a502          	bcp	a,#2
1946  003f 2709          	jreq	L376
1947                     ; 703 		GPIO_WriteLow(LED_PORT, LED5);
1949  0041 4b02          	push	#2
1950  0043 ae500a        	ldw	x,#20490
1951  0046 cd0000        	call	_GPIO_WriteLow
1953  0049 84            	pop	a
1954  004a               L376:
1955                     ; 705 }
1958  004a 84            	pop	a
1959  004b 81            	ret
1992                     ; 708 void LED_Off(u8 LedNum)
1992                     ; 709 {
1993                     .text:	section	.text,new
1994  0000               _LED_Off:
1996  0000 88            	push	a
1997       00000000      OFST:	set	0
2000                     ; 710 	if(LedNum & LED1)//LED1
2002  0001 a508          	bcp	a,#8
2003  0003 2709          	jreq	L117
2004                     ; 712 		GPIO_WriteLow(LED_PORT, LED1);
2006  0005 4b08          	push	#8
2007  0007 ae500a        	ldw	x,#20490
2008  000a cd0000        	call	_GPIO_WriteLow
2010  000d 84            	pop	a
2011  000e               L117:
2012                     ; 714 	if(LedNum & LED2)//LED2
2014  000e 7b01          	ld	a,(OFST+1,sp)
2015  0010 a510          	bcp	a,#16
2016  0012 2709          	jreq	L317
2017                     ; 716 		GPIO_WriteLow(LED_PORT, LED2);
2019  0014 4b10          	push	#16
2020  0016 ae500a        	ldw	x,#20490
2021  0019 cd0000        	call	_GPIO_WriteLow
2023  001c 84            	pop	a
2024  001d               L317:
2025                     ; 718 	if(LedNum & LED3)//LED3
2027  001d 7b01          	ld	a,(OFST+1,sp)
2028  001f a520          	bcp	a,#32
2029  0021 2709          	jreq	L517
2030                     ; 720 		GPIO_WriteLow(LED_PORT, LED3);
2032  0023 4b20          	push	#32
2033  0025 ae500a        	ldw	x,#20490
2034  0028 cd0000        	call	_GPIO_WriteLow
2036  002b 84            	pop	a
2037  002c               L517:
2038                     ; 722 	if(LedNum & LED4)//LED4
2040  002c 7b01          	ld	a,(OFST+1,sp)
2041  002e a504          	bcp	a,#4
2042  0030 2709          	jreq	L717
2043                     ; 724 		GPIO_WriteLow(LED_PORT, LED4);
2045  0032 4b04          	push	#4
2046  0034 ae500a        	ldw	x,#20490
2047  0037 cd0000        	call	_GPIO_WriteLow
2049  003a 84            	pop	a
2050  003b               L717:
2051                     ; 726 	if(LedNum & LED5)//LED5
2053  003b 7b01          	ld	a,(OFST+1,sp)
2054  003d a502          	bcp	a,#2
2055  003f 2709          	jreq	L127
2056                     ; 728 		GPIO_WriteLow(LED_PORT, LED5);
2058  0041 4b02          	push	#2
2059  0043 ae500a        	ldw	x,#20490
2060  0046 cd0000        	call	_GPIO_WriteLow
2062  0049 84            	pop	a
2063  004a               L127:
2064                     ; 730 }
2067  004a 84            	pop	a
2068  004b 81            	ret
2101                     ; 732 void LED_Toggle(u8 LedNum)
2101                     ; 733 {
2102                     .text:	section	.text,new
2103  0000               _LED_Toggle:
2105  0000 88            	push	a
2106       00000000      OFST:	set	0
2109                     ; 734 	if(LedNum & LED1)//LED1
2111  0001 a508          	bcp	a,#8
2112  0003 2709          	jreq	L737
2113                     ; 736 		GPIO_WriteReverse(LED_PORT, LED1);
2115  0005 4b08          	push	#8
2116  0007 ae500a        	ldw	x,#20490
2117  000a cd0000        	call	_GPIO_WriteReverse
2119  000d 84            	pop	a
2120  000e               L737:
2121                     ; 738 	if(LedNum & LED2)//LED2
2123  000e 7b01          	ld	a,(OFST+1,sp)
2124  0010 a510          	bcp	a,#16
2125  0012 2709          	jreq	L147
2126                     ; 740 		GPIO_WriteReverse(LED_PORT, LED2);
2128  0014 4b10          	push	#16
2129  0016 ae500a        	ldw	x,#20490
2130  0019 cd0000        	call	_GPIO_WriteReverse
2132  001c 84            	pop	a
2133  001d               L147:
2134                     ; 742 	if(LedNum & LED3)//LED3
2136  001d 7b01          	ld	a,(OFST+1,sp)
2137  001f a520          	bcp	a,#32
2138  0021 2709          	jreq	L347
2139                     ; 744 		GPIO_WriteReverse(LED_PORT, LED3);
2141  0023 4b20          	push	#32
2142  0025 ae500a        	ldw	x,#20490
2143  0028 cd0000        	call	_GPIO_WriteReverse
2145  002b 84            	pop	a
2146  002c               L347:
2147                     ; 746 	if(LedNum & LED4)//LED4
2149  002c 7b01          	ld	a,(OFST+1,sp)
2150  002e a504          	bcp	a,#4
2151  0030 2709          	jreq	L547
2152                     ; 748 		GPIO_WriteReverse(LED_PORT, LED4);
2154  0032 4b04          	push	#4
2155  0034 ae500a        	ldw	x,#20490
2156  0037 cd0000        	call	_GPIO_WriteReverse
2158  003a 84            	pop	a
2159  003b               L547:
2160                     ; 750 	if(LedNum & LED5)//LED5
2162  003b 7b01          	ld	a,(OFST+1,sp)
2163  003d a502          	bcp	a,#2
2164  003f 2709          	jreq	L747
2165                     ; 752 		GPIO_WriteReverse(LED_PORT, LED5);
2167  0041 4b02          	push	#2
2168  0043 ae500a        	ldw	x,#20490
2169  0046 cd0000        	call	_GPIO_WriteReverse
2171  0049 84            	pop	a
2172  004a               L747:
2173                     ; 754 }
2176  004a 84            	pop	a
2177  004b 81            	ret
2210                     ; 756 void KEY_Init(u8 KeyNum)
2210                     ; 757 {
2211                     .text:	section	.text,new
2212  0000               _KEY_Init:
2214  0000 88            	push	a
2215       00000000      OFST:	set	0
2218                     ; 758 	if(KeyNum & KEY1)//LED1
2220  0001 a501          	bcp	a,#1
2221  0003 270b          	jreq	L567
2222                     ; 760 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY1, GPIO_MODE_IN_PU_NO_IT);
2224  0005 4b40          	push	#64
2225  0007 4b01          	push	#1
2226  0009 ae5005        	ldw	x,#20485
2227  000c cd0000        	call	_GPIO_Init
2229  000f 85            	popw	x
2230  0010               L567:
2231                     ; 762 	if(KeyNum & KEY2)//LED2
2233  0010 7b01          	ld	a,(OFST+1,sp)
2234  0012 a502          	bcp	a,#2
2235  0014 270b          	jreq	L767
2236                     ; 764 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY2, GPIO_MODE_IN_PU_NO_IT);
2238  0016 4b40          	push	#64
2239  0018 4b02          	push	#2
2240  001a ae5005        	ldw	x,#20485
2241  001d cd0000        	call	_GPIO_Init
2243  0020 85            	popw	x
2244  0021               L767:
2245                     ; 766 }
2248  0021 84            	pop	a
2249  0022 81            	ret
2303                     ; 768 bool KEY_Read(u8 KeyNum)
2303                     ; 769 {
2304                     .text:	section	.text,new
2305  0000               _KEY_Read:
2307  0000 88            	push	a
2308       00000000      OFST:	set	0
2311                     ; 770 	if(KeyNum & KEY1)//LED1
2313  0001 a501          	bcp	a,#1
2314  0003 2713          	jreq	L5101
2315                     ; 772 		if((GPIO_ReadInputData(KEY_PORT) & 0x01) == 0x00)
2317  0005 ae5005        	ldw	x,#20485
2318  0008 cd0000        	call	_GPIO_ReadInputData
2320  000b a501          	bcp	a,#1
2321  000d 2605          	jrne	L7101
2322                     ; 773 			return TRUE;
2324  000f a601          	ld	a,#1
2327  0011 5b01          	addw	sp,#1
2328  0013 81            	ret
2329  0014               L7101:
2330                     ; 775 			return FALSE;
2332  0014 4f            	clr	a
2335  0015 5b01          	addw	sp,#1
2336  0017 81            	ret
2337  0018               L5101:
2338                     ; 777 	if(KeyNum & KEY2)//LED2
2340  0018 7b01          	ld	a,(OFST+1,sp)
2341  001a a502          	bcp	a,#2
2342  001c 2713          	jreq	L3201
2343                     ; 779 		if((GPIO_ReadInputData(KEY_PORT) & 0x02) == 0x00)
2345  001e ae5005        	ldw	x,#20485
2346  0021 cd0000        	call	_GPIO_ReadInputData
2348  0024 a502          	bcp	a,#2
2349  0026 2605          	jrne	L5201
2350                     ; 780 			return TRUE;
2352  0028 a601          	ld	a,#1
2355  002a 5b01          	addw	sp,#1
2356  002c 81            	ret
2357  002d               L5201:
2358                     ; 782 			return FALSE;
2360  002d 4f            	clr	a
2363  002e 5b01          	addw	sp,#1
2364  0030 81            	ret
2365  0031               L3201:
2366                     ; 784 }
2369  0031 5b01          	addw	sp,#1
2370  0033 81            	ret
2416                     ; 789 void delay(u16 Count)
2416                     ; 790 {
2417                     .text:	section	.text,new
2418  0000               _delay:
2420  0000 89            	pushw	x
2421  0001 89            	pushw	x
2422       00000002      OFST:	set	2
2425  0002 2014          	jra	L3501
2426  0004               L1501:
2427                     ; 794     for(i=0;i<100;i++)
2429  0004 0f01          	clr	(OFST-1,sp)
2430  0006               L7501:
2431                     ; 795     for(j=0;j<50;j++);
2433  0006 0f02          	clr	(OFST+0,sp)
2434  0008               L5601:
2438  0008 0c02          	inc	(OFST+0,sp)
2441  000a 7b02          	ld	a,(OFST+0,sp)
2442  000c a132          	cp	a,#50
2443  000e 25f8          	jrult	L5601
2444                     ; 794     for(i=0;i<100;i++)
2446  0010 0c01          	inc	(OFST-1,sp)
2449  0012 7b01          	ld	a,(OFST-1,sp)
2450  0014 a164          	cp	a,#100
2451  0016 25ee          	jrult	L7501
2452  0018               L3501:
2453                     ; 792   while (Count--)//Count形参控制延时次数
2455  0018 1e03          	ldw	x,(OFST+1,sp)
2456  001a 1d0001        	subw	x,#1
2457  001d 1f03          	ldw	(OFST+1,sp),x
2458  001f 1c0001        	addw	x,#1
2459  0022 a30000        	cpw	x,#0
2460  0025 26dd          	jrne	L1501
2461                     ; 797 }
2464  0027 5b04          	addw	sp,#4
2465  0029 81            	ret
2528                     	xdef	_main
2529                     	xdef	_EXTI_Config
2530                     	xdef	_ExtraCode_StateMachine
2531                     	xdef	_ExtraCode_Init
2532                     	switch	.bss
2533  0000               _ptr:
2534  0000 0000          	ds.b	2
2535                     	xdef	_ptr
2536                     .bit:	section	.data,bit
2537  0000               _p_valid:
2538  0000 00            	ds.b	1
2539                     	xdef	_p_valid
2540  0001               _in_range:
2541  0001 00            	ds.b	1
2542                     	xdef	_in_range
2543                     	switch	.bss
2544  0002               _gest_cnt:
2545  0002 00            	ds.b	1
2546                     	xdef	_gest_cnt
2547  0003               _isr_flag:
2548  0003 00            	ds.b	1
2549                     	xdef	_isr_flag
2550                     	xref	_readGesture
2551                     	xref	_isGestureAvailable
2552                     	xref	_readBlueLight
2553                     	xref	_readGreenLight
2554                     	xref	_readRedLight
2555                     	xref	_readAmbientLight
2556                     	xref	_clearAmbientLightInt
2557                     	xref	_setAmbientLightIntEnable
2558                     	xref	_setLightIntHighThreshold
2559                     	xref	_getLightIntHighThreshold
2560                     	xref	_setLightIntLowThreshold
2561                     	xref	_getLightIntLowThreshold
2562                     	xref	_enableGestureSensor
2563                     	xref	_enableLightSensor
2564                     	xref	_init
2565                     	xref	_TIM3_tout
2566                     	xref	_send_header_payload_init
2567                     	xref	_reve_analyze_reply
2568                     	xref	_UART2_Send_Data_Start
2569                     	xref	_Init_uart2
2570                     	xref	_ns_host_meshid_L
2571                     	xref	_ns_host_meshid_H
2572                     	xref	_st1
2573                     	xref	_UART1Flag5_
2574                     	xref	_UART1Flag3_
2575                     	xref	_UART1Flag2_
2576                     	xref	_UART1Flag1_
2577                     	xdef	_LightTest
2578                     	xdef	_GestureTest
2579                     	xdef	_handleGesture
2580                     	xdef	_PORTD_EXT_ISR
2581                     	xdef	_Variable_Init
2582                     	xdef	_KEY_Read
2583                     	xdef	_KEY_Init
2584                     	xdef	_LED_Toggle
2585                     	xdef	_LED_Off
2586                     	xdef	_LED_On
2587                     	xdef	_LED_Init
2588                     	xdef	_delay
2589                     	xdef	_Task_1s
2590                     	xdef	_Task_300ms
2591                     	xdef	_Task_100ms
2592                     	xdef	_Task_2ms
2593                     	xdef	_Task_500us
2594  0004               _Flag1_:
2595  0004 00            	ds.b	1
2596                     	xdef	_Flag1_
2597  0005               _systime_count:
2598  0005 000000000000  	ds.b	8
2599                     	xdef	_systime_count
2600  000d               _gusture:
2601  000d 0000          	ds.b	2
2602                     	xdef	_gusture
2603                     	xref	_TSL_Action
2604                     	xref	_TSL_Init
2605                     	xref	_sSCKeyInfo
2606                     	xref.b	_TSL_GlobalSetting
2607                     	xref.b	_TSLState
2608                     	xref	_GPIO_ReadInputData
2609                     	xref	_GPIO_WriteReverse
2610                     	xref	_GPIO_WriteLow
2611                     	xref	_GPIO_WriteHigh
2612                     	xref	_GPIO_Init
2613                     	xref	_EXTI_SetTLISensitivity
2614                     	xref	_EXTI_SetExtIntSensitivity
2615                     	xref	_EXTI_DeInit
2635                     	end
