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
 233                     ; 84 }
 236  0030 81            	ret
 263                     ; 125 void EXTI_Config(void)
 263                     ; 126 {
 264                     .text:	section	.text,new
 265  0000               _EXTI_Config:
 269                     ; 127 	GPIO_Init(GPIOD,GPIO_PIN_0,GPIO_MODE_IN_PU_IT );
 271  0000 4b60          	push	#96
 272  0002 4b01          	push	#1
 273  0004 ae500f        	ldw	x,#20495
 274  0007 cd0000        	call	_GPIO_Init
 276  000a 85            	popw	x
 277                     ; 128 	EXTI_DeInit();
 279  000b cd0000        	call	_EXTI_DeInit
 281                     ; 129 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);//下降沿触发中断
 283  000e 4f            	clr	a
 284  000f cd0000        	call	_EXTI_SetTLISensitivity
 286                     ; 130 	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOD),EXTI_SENSITIVITY_FALL_ONLY);
 288  0012 ae0002        	ldw	x,#2
 289  0015 a603          	ld	a,#3
 290  0017 95            	ld	xh,a
 291  0018 cd0000        	call	_EXTI_SetExtIntSensitivity
 293                     ; 131 }
 296  001b 81            	ret
 322                     ; 133 @interrupt void PORTD_EXT_ISR(void)
 322                     ; 134 {
 323                     .text:	section	.text,new
 324  0000               _PORTD_EXT_ISR:
 329                     ; 135 	disableInterrupts();//关中断
 332  0000 9b            sim
 334                     ; 136 	isr_flag = 1;
 337  0001 35010003      	mov	_isr_flag,#1
 338                     ; 137 	enableInterrupts();
 341  0005 9a            rim
 343                     ; 138 }
 347  0006 80            	iret
 410                     ; 149 void main(void)
 410                     ; 150 {
 411                     .text:	section	.text,new
 412  0000               _main:
 414  0000 88            	push	a
 415       00000001      OFST:	set	1
 418                     ; 165   unsigned char value = 100;
 420  0001 a664          	ld	a,#100
 421  0003 6b01          	ld	(OFST+0,sp),a
 422                     ; 166   in_range = (value >= 10) && (value <= 20);
 424  0005 72110001      	bres	_in_range
 425                     ; 167   p_valid = ptr;   /* p_valid is true if ptr not 0 */
 427  0009 ce0000        	ldw	x,_ptr
 428  000c 2602          	jrne	L02
 429  000e 2006          	jp	L41
 430  0010               L02:
 431  0010 72100000      	bset	_p_valid
 432  0014 2004          	jra	L61
 433  0016               L41:
 434  0016 72110000      	bres	_p_valid
 435  001a               L61:
 436                     ; 176 	CLK->SWCR |= 0x02; //开启切换
 438  001a 721250c5      	bset	20677,#1
 439                     ; 177   CLK->SWR   = 0xb4;       //选择时钟为外部8M
 441  001e 35b450c4      	mov	20676,#180
 443  0022               L161:
 444                     ; 178   while((CLK->SWCR & 0x01)==0x01);
 446  0022 c650c5        	ld	a,20677
 447  0025 a401          	and	a,#1
 448  0027 a101          	cp	a,#1
 449  0029 27f7          	jreq	L161
 450                     ; 179   CLK->CKDIVR = 0x80;    //不分频
 452  002b 358050c6      	mov	20678,#128
 453                     ; 180   CLK->SWCR  &= ~0x02; //关闭切换
 455  002f 721350c5      	bres	20677,#1
 456                     ; 181 	LED_Init(LED1|LED2|LED3|LED4|LED5);
 458  0033 a63e          	ld	a,#62
 459  0035 cd0000        	call	_LED_Init
 461                     ; 182 	KEY_Init(KEY1|KEY2);
 463  0038 a603          	ld	a,#3
 464  003a cd0000        	call	_KEY_Init
 466                     ; 183 	Variable_Init();
 468  003d cd0000        	call	_Variable_Init
 470                     ; 185 	EXTI_Config();
 472  0040 cd0000        	call	_EXTI_Config
 474                     ; 186 	Init_uart2();
 476  0043 cd0000        	call	_Init_uart2
 478                     ; 187 	init();//init apds9960
 480  0046 cd0000        	call	_init
 482                     ; 188 	GestureTest();
 484  0049 cd0000        	call	_GestureTest
 486                     ; 189 	TSL_Init();
 488  004c cd0000        	call	_TSL_Init
 490                     ; 190 	ExtraCode_Init();	
 492  004f cd0000        	call	_ExtraCode_Init
 494  0052               L561:
 495                     ; 193 		if((!receipt_device_info1) && (!device_info_sended) && (rev_bleheartbeat) && (rev_host_mesh))
 497  0052 c60000        	ld	a,_UART1Flag5_
 498  0055 a501          	bcp	a,#1
 499  0057 2639          	jrne	L171
 501  0059 c60004        	ld	a,_Flag1_
 502  005c a540          	bcp	a,#64
 503  005e 2632          	jrne	L171
 505  0060 c60000        	ld	a,_UART1Flag1_
 506  0063 a580          	bcp	a,#128
 507  0065 272b          	jreq	L171
 509  0067 c60000        	ld	a,_UART1Flag2_
 510  006a a540          	bcp	a,#64
 511  006c 2724          	jreq	L171
 512                     ; 195 			device_info_sended = 1;
 514  006e 721c0004      	bset	_Flag1_,#6
 515                     ; 196 			rev_bleheartbeat = 0;
 517  0072 721f0000      	bres	_UART1Flag1_,#7
 518                     ; 197 			delay(200);
 520  0076 ae00c8        	ldw	x,#200
 521  0079 cd0000        	call	_delay
 523                     ; 198 			send_header_payload_init(0x86,ns_host_meshid_H,ns_host_meshid_L,12,0xB4);
 525  007c 4bb4          	push	#180
 526  007e 4b0c          	push	#12
 527  0080 3b0000        	push	_ns_host_meshid_L
 528  0083 c60000        	ld	a,_ns_host_meshid_H
 529  0086 97            	ld	xl,a
 530  0087 a686          	ld	a,#134
 531  0089 95            	ld	xh,a
 532  008a cd0000        	call	_send_header_payload_init
 534  008d 5b03          	addw	sp,#3
 535                     ; 199 			UART2_Send_Data_Start();
 537  008f cd0000        	call	_UART2_Send_Data_Start
 539  0092               L171:
 540                     ; 202     Task_2ms();
 542  0092 cd0000        	call	_Task_2ms
 544                     ; 203 		Task_100ms();
 546  0095 cd0000        	call	_Task_100ms
 548                     ; 204 		Task_300ms();
 550  0098 cd0000        	call	_Task_300ms
 552                     ; 205 		Task_1s();
 554  009b cd0000        	call	_Task_1s
 556                     ; 206 		ExtraCode_StateMachine();			 
 558  009e cd0000        	call	_ExtraCode_StateMachine
 560                     ; 207 		TSL_Action();
 562  00a1 cd0000        	call	_TSL_Action
 564                     ; 242 		if(isr_flag ==1)
 566  00a4 c60003        	ld	a,_isr_flag
 567  00a7 a101          	cp	a,#1
 568  00a9 26a7          	jrne	L561
 569                     ; 244 			LED_On(LED5);
 571  00ab a602          	ld	a,#2
 572  00ad cd0000        	call	_LED_On
 574                     ; 245 			handleGesture();
 576  00b0 cd0000        	call	_handleGesture
 578                     ; 246 			if((GPIOD->IDR&0x01)==0)
 580  00b3 c65010        	ld	a,20496
 581  00b6 a501          	bcp	a,#1
 582  00b8 2608          	jrne	L571
 583                     ; 248 				init();
 585  00ba cd0000        	call	_init
 587                     ; 249 				enableGestureSensor(1);
 589  00bd a601          	ld	a,#1
 590  00bf cd0000        	call	_enableGestureSensor
 592  00c2               L571:
 593                     ; 251 			isr_flag = 0;	
 595  00c2 725f0003      	clr	_isr_flag
 596  00c6 208a          	jra	L561
 631                     ; 268 void ExtraCode_Init(void)
 631                     ; 269 {
 632                     .text:	section	.text,new
 633  0000               _ExtraCode_Init:
 635  0000 88            	push	a
 636       00000001      OFST:	set	1
 639                     ; 275   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 641  0001 0f01          	clr	(OFST+0,sp)
 642  0003               L312:
 643                     ; 277     sSCKeyInfo[i].Setting.b.IMPLEMENTED = 1;
 645  0003 7b01          	ld	a,(OFST+0,sp)
 646  0005 97            	ld	xl,a
 647  0006 a60f          	ld	a,#15
 648  0008 42            	mul	x,a
 649  0009 d60002        	ld	a,(_sSCKeyInfo+2,x)
 650  000c aa01          	or	a,#1
 651  000e d70002        	ld	(_sSCKeyInfo+2,x),a
 652                     ; 278     sSCKeyInfo[i].Setting.b.ENABLED = 1;
 654  0011 7b01          	ld	a,(OFST+0,sp)
 655  0013 97            	ld	xl,a
 656  0014 a60f          	ld	a,#15
 657  0016 42            	mul	x,a
 658  0017 d60002        	ld	a,(_sSCKeyInfo+2,x)
 659  001a aa02          	or	a,#2
 660  001c d70002        	ld	(_sSCKeyInfo+2,x),a
 661                     ; 279     sSCKeyInfo[i].DESGroup = 0x01; /* Put 0x00 to disable the DES on these pins */
 663  001f 7b01          	ld	a,(OFST+0,sp)
 664  0021 97            	ld	xl,a
 665  0022 a60f          	ld	a,#15
 666  0024 42            	mul	x,a
 667  0025 a601          	ld	a,#1
 668  0027 d70004        	ld	(_sSCKeyInfo+4,x),a
 669                     ; 275   for (i = 0; i < NUMBER_OF_SINGLE_CHANNEL_KEYS; i++)
 671  002a 0c01          	inc	(OFST+0,sp)
 674  002c 7b01          	ld	a,(OFST+0,sp)
 675  002e a103          	cp	a,#3
 676  0030 25d1          	jrult	L312
 677                     ; 292 	LED_On(LED1);
 679  0032 a608          	ld	a,#8
 680  0034 cd0000        	call	_LED_On
 682                     ; 293 	LED_On(LED2);
 684  0037 a610          	ld	a,#16
 685  0039 cd0000        	call	_LED_On
 687                     ; 294 	LED_On(LED3);
 689  003c a620          	ld	a,#32
 690  003e cd0000        	call	_LED_On
 692                     ; 295   LED_On(LED5);
 694  0041 a602          	ld	a,#2
 695  0043 cd0000        	call	_LED_On
 697                     ; 296   enableInterrupts();
 700  0046 9a            rim
 702                     ; 298 }
 706  0047 84            	pop	a
 707  0048 81            	ret
 737                     ; 311 void ExtraCode_StateMachine(void)
 737                     ; 312 {
 738                     .text:	section	.text,new
 739  0000               _ExtraCode_StateMachine:
 743                     ; 313 	if ((TSL_GlobalSetting.b.CHANGED) && (TSLState == TSL_IDLE_STATE))
 745  0000 b601          	ld	a,_TSL_GlobalSetting+1
 746  0002 a508          	bcp	a,#8
 747  0004 2603          	jrne	L62
 748  0006 cc00d9        	jp	L132
 749  0009               L62:
 751  0009 b600          	ld	a,_TSLState
 752  000b a101          	cp	a,#1
 753  000d 2703          	jreq	L03
 754  000f cc00d9        	jp	L132
 755  0012               L03:
 756                     ; 316 		TSL_GlobalSetting.b.CHANGED = 0;
 758  0012 72170001      	bres	_TSL_GlobalSetting+1,#3
 759                     ; 318     if (sSCKeyInfo[0].Setting.b.DETECTED) /* KEY 1 touched */
 761  0016 c60002        	ld	a,_sSCKeyInfo+2
 762  0019 a504          	bcp	a,#4
 763  001b 273a          	jreq	L332
 764                     ; 320 			LED_Toggle(LED1);
 766  001d a608          	ld	a,#8
 767  001f cd0000        	call	_LED_Toggle
 769                     ; 321 			st_pad1_ctrl = 1;
 771  0022 72120000      	bset	_UART1Flag3_,#1
 772                     ; 322 			if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
 774  0026 725d000d      	tnz	_st1+13
 775  002a 2714          	jreq	L532
 777  002c 725d000e      	tnz	_st1+14
 778  0030 270e          	jreq	L532
 780  0032 725d000f      	tnz	_st1+15
 781  0036 2708          	jreq	L532
 782                     ; 324 				st_pad1_confirm = 1;
 784  0038 72180000      	bset	_UART1Flag3_,#4
 785                     ; 325 				st1.st_ctrl_address = 0x01;
 787  003c 35010003      	mov	_st1+3,#1
 788  0040               L532:
 789                     ; 333 			if (st1.st_pad1_status == 0x00)
 791  0040 725d0006      	tnz	_st1+6
 792  0044 2606          	jrne	L732
 793                     ; 335 				st1.st_pad1_status = 0x63;
 795  0046 35630006      	mov	_st1+6,#99
 797  004a 200b          	jra	L332
 798  004c               L732:
 799                     ; 337 			else if (st1.st_pad1_status == 0x63)
 801  004c c60006        	ld	a,_st1+6
 802  004f a163          	cp	a,#99
 803  0051 2604          	jrne	L332
 804                     ; 339 				st1.st_pad1_status = 0x00;
 806  0053 725f0006      	clr	_st1+6
 807  0057               L332:
 808                     ; 343     if (sSCKeyInfo[1].Setting.b.DETECTED) /* KEY 2 touched */
 810  0057 c60011        	ld	a,_sSCKeyInfo+17
 811  005a a504          	bcp	a,#4
 812  005c 273a          	jreq	L542
 813                     ; 345 			LED_Toggle(LED2);
 815  005e a610          	ld	a,#16
 816  0060 cd0000        	call	_LED_Toggle
 818                     ; 346 			st_pad2_ctrl = 1;
 820  0063 72140000      	bset	_UART1Flag3_,#2
 821                     ; 347 			if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
 823  0067 725d0012      	tnz	_st1+18
 824  006b 2714          	jreq	L742
 826  006d 725d0013      	tnz	_st1+19
 827  0071 270e          	jreq	L742
 829  0073 725d0014      	tnz	_st1+20
 830  0077 2708          	jreq	L742
 831                     ; 349 				st_pad2_confirm = 1;
 833  0079 721a0000      	bset	_UART1Flag3_,#5
 834                     ; 350 				st1.st_ctrl_address = 0x02;
 836  007d 35020003      	mov	_st1+3,#2
 837  0081               L742:
 838                     ; 357 			if (st1.st_pad2_status == 0x00)
 840  0081 725d0007      	tnz	_st1+7
 841  0085 2606          	jrne	L152
 842                     ; 359 				st1.st_pad2_status = 0x63;
 844  0087 35630007      	mov	_st1+7,#99
 846  008b 200b          	jra	L542
 847  008d               L152:
 848                     ; 361 			else if (st1.st_pad2_status == 0x63)
 850  008d c60007        	ld	a,_st1+7
 851  0090 a163          	cp	a,#99
 852  0092 2604          	jrne	L542
 853                     ; 363 				st1.st_pad2_status = 0x00;
 855  0094 725f0007      	clr	_st1+7
 856  0098               L542:
 857                     ; 367     if (sSCKeyInfo[2].Setting.b.DETECTED) /* KEY 3 touched */
 859  0098 c60020        	ld	a,_sSCKeyInfo+32
 860  009b a504          	bcp	a,#4
 861  009d 273a          	jreq	L132
 862                     ; 369       LED_Toggle(LED3);
 864  009f a620          	ld	a,#32
 865  00a1 cd0000        	call	_LED_Toggle
 867                     ; 370 			st_pad3_ctrl = 1;
 869  00a4 72160000      	bset	_UART1Flag3_,#3
 870                     ; 371 			if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
 872  00a8 725d0017      	tnz	_st1+23
 873  00ac 2714          	jreq	L162
 875  00ae 725d0018      	tnz	_st1+24
 876  00b2 270e          	jreq	L162
 878  00b4 725d0019      	tnz	_st1+25
 879  00b8 2708          	jreq	L162
 880                     ; 373 				st_pad3_confirm = 1;
 882  00ba 721c0000      	bset	_UART1Flag3_,#6
 883                     ; 374 				st1.st_ctrl_address = 0x04;
 885  00be 35040003      	mov	_st1+3,#4
 886  00c2               L162:
 887                     ; 381 			if (st1.st_pad3_status == 0x00)
 889  00c2 725d0008      	tnz	_st1+8
 890  00c6 2606          	jrne	L362
 891                     ; 383 				st1.st_pad3_status = 0x63;
 893  00c8 35630008      	mov	_st1+8,#99
 895  00cc 200b          	jra	L132
 896  00ce               L362:
 897                     ; 385 			else if (st1.st_pad3_status == 0x63)
 899  00ce c60008        	ld	a,_st1+8
 900  00d1 a163          	cp	a,#99
 901  00d3 2604          	jrne	L132
 902                     ; 387 				st1.st_pad3_status = 0x00;
 904  00d5 725f0008      	clr	_st1+8
 905  00d9               L132:
 906                     ; 391 }
 909  00d9 81            	ret
 937                     ; 393 void handleGesture(void) {
 938                     .text:	section	.text,new
 939  0000               _handleGesture:
 943                     ; 394     if ( isGestureAvailable() ) {
 945  0000 cd0000        	call	_isGestureAvailable
 947  0003 4d            	tnz	a
 948  0004 2603          	jrne	L43
 949  0006 cc0120        	jp	L713
 950  0009               L43:
 951                     ; 405 			gest_cnt++;					
 953  0009 725c0002      	inc	_gest_cnt
 954                     ; 406     switch ( readGesture() ) {
 956  000d cd0000        	call	_readGesture
 959                     ; 443       default:
 959                     ; 444         //printf("NONE\n");
 959                     ; 445 				//send_buf[8] = 0x01;
 959                     ; 446 				break;
 960  0010 5a            	decw	x
 961  0011 2603          	jrne	L63
 962  0013 cc00ac        	jp	L572
 963  0016               L63:
 964  0016 5a            	decw	x
 965  0017 2603          	jrne	L04
 966  0019 cc00e7        	jp	L772
 967  001c               L04:
 968  001c 5a            	decw	x
 969  001d 2707          	jreq	L172
 970  001f 5a            	decw	x
 971  0020 2748          	jreq	L372
 972  0022 ac200120      	jpf	L713
 973  0026               L172:
 974                     ; 407       case DIR_UP:
 974                     ; 408         //printf("UP\n");
 974                     ; 409 				if(gest_cnt == 1)				st1.st_ges_H |= 0xC0;
 976  0026 c60002        	ld	a,_gest_cnt
 977  0029 a101          	cp	a,#1
 978  002b 260c          	jrne	L523
 981  002d c60000        	ld	a,_st1
 982  0030 aac0          	or	a,#192
 983  0032 c70000        	ld	_st1,a
 985  0035 ac200120      	jpf	L713
 986  0039               L523:
 987                     ; 410 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0C;
 989  0039 c60002        	ld	a,_gest_cnt
 990  003c a102          	cp	a,#2
 991  003e 260c          	jrne	L133
 994  0040 c60000        	ld	a,_st1
 995  0043 aa0c          	or	a,#12
 996  0045 c70000        	ld	_st1,a
 998  0048 ac200120      	jpf	L713
 999  004c               L133:
1000                     ; 411 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xC0;gest_cnt = 0;gest_detect = 1;}
1002  004c c60002        	ld	a,_gest_cnt
1003  004f a103          	cp	a,#3
1004  0051 2703          	jreq	L24
1005  0053 cc0120        	jp	L713
1006  0056               L24:
1009  0056 c60001        	ld	a,_st1+1
1010  0059 aac0          	or	a,#192
1011  005b c70001        	ld	_st1+1,a
1014  005e 725f0002      	clr	_gest_cnt
1017  0062 72100000      	bset	_UART1Flag2_,#0
1018  0066 ac200120      	jpf	L713
1019  006a               L372:
1020                     ; 414       case DIR_DOWN:
1020                     ; 415         //printf("DOWN\n");
1020                     ; 416 				//send_buf[1] = 0x01;
1020                     ; 417 				if(gest_cnt == 1)				st1.st_ges_H |= 0xD0;
1022  006a c60002        	ld	a,_gest_cnt
1023  006d a101          	cp	a,#1
1024  006f 260c          	jrne	L733
1027  0071 c60000        	ld	a,_st1
1028  0074 aad0          	or	a,#208
1029  0076 c70000        	ld	_st1,a
1031  0079 ac200120      	jpf	L713
1032  007d               L733:
1033                     ; 418 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0D;
1035  007d c60002        	ld	a,_gest_cnt
1036  0080 a102          	cp	a,#2
1037  0082 260c          	jrne	L343
1040  0084 c60000        	ld	a,_st1
1041  0087 aa0d          	or	a,#13
1042  0089 c70000        	ld	_st1,a
1044  008c ac200120      	jpf	L713
1045  0090               L343:
1046                     ; 419 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xD0;gest_cnt = 0;gest_detect = 1;}
1048  0090 c60002        	ld	a,_gest_cnt
1049  0093 a103          	cp	a,#3
1050  0095 2703          	jreq	L44
1051  0097 cc0120        	jp	L713
1052  009a               L44:
1055  009a c60001        	ld	a,_st1+1
1056  009d aad0          	or	a,#208
1057  009f c70001        	ld	_st1+1,a
1060  00a2 725f0002      	clr	_gest_cnt
1063  00a6 72100000      	bset	_UART1Flag2_,#0
1064  00aa 2074          	jra	L713
1065  00ac               L572:
1066                     ; 421       case DIR_LEFT:
1066                     ; 422         //printf("LEFT\n");
1066                     ; 423 				//send_buf[2] = 0x01;
1066                     ; 424 				if(gest_cnt == 1)		st1.st_ges_H |= 0xE0;
1068  00ac c60002        	ld	a,_gest_cnt
1069  00af a101          	cp	a,#1
1070  00b1 260a          	jrne	L153
1073  00b3 c60000        	ld	a,_st1
1074  00b6 aae0          	or	a,#224
1075  00b8 c70000        	ld	_st1,a
1077  00bb 2063          	jra	L713
1078  00bd               L153:
1079                     ; 425 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0E;
1081  00bd c60002        	ld	a,_gest_cnt
1082  00c0 a102          	cp	a,#2
1083  00c2 260a          	jrne	L553
1086  00c4 c60000        	ld	a,_st1
1087  00c7 aa0e          	or	a,#14
1088  00c9 c70000        	ld	_st1,a
1090  00cc 2052          	jra	L713
1091  00ce               L553:
1092                     ; 426 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xE0;gest_cnt = 0;gest_detect = 1;}
1094  00ce c60002        	ld	a,_gest_cnt
1095  00d1 a103          	cp	a,#3
1096  00d3 264b          	jrne	L713
1099  00d5 c60001        	ld	a,_st1+1
1100  00d8 aae0          	or	a,#224
1101  00da c70001        	ld	_st1+1,a
1104  00dd 725f0002      	clr	_gest_cnt
1107  00e1 72100000      	bset	_UART1Flag2_,#0
1108  00e5 2039          	jra	L713
1109  00e7               L772:
1110                     ; 428       case DIR_RIGHT:
1110                     ; 429         //printf("RIGHT\n");
1110                     ; 430 				if(gest_cnt == 1)		st1.st_ges_H |= 0xF0;
1112  00e7 c60002        	ld	a,_gest_cnt
1113  00ea a101          	cp	a,#1
1114  00ec 260a          	jrne	L363
1117  00ee c60000        	ld	a,_st1
1118  00f1 aaf0          	or	a,#240
1119  00f3 c70000        	ld	_st1,a
1121  00f6 2028          	jra	L713
1122  00f8               L363:
1123                     ; 431 				else if(gest_cnt == 2)	st1.st_ges_H |= 0x0F;
1125  00f8 c60002        	ld	a,_gest_cnt
1126  00fb a102          	cp	a,#2
1127  00fd 260a          	jrne	L763
1130  00ff c60000        	ld	a,_st1
1131  0102 aa0f          	or	a,#15
1132  0104 c70000        	ld	_st1,a
1134  0107 2017          	jra	L713
1135  0109               L763:
1136                     ; 432 				else if(gest_cnt == 3)	{st1.st_ges_L |= 0xF0;gest_cnt = 0;gest_detect = 1;}
1138  0109 c60002        	ld	a,_gest_cnt
1139  010c a103          	cp	a,#3
1140  010e 2610          	jrne	L713
1143  0110 c60001        	ld	a,_st1+1
1144  0113 aaf0          	or	a,#240
1145  0115 c70001        	ld	_st1+1,a
1148  0118 725f0002      	clr	_gest_cnt
1151  011c 72100000      	bset	_UART1Flag2_,#0
1152  0120               L103:
1153                     ; 435       case DIR_NEAR:
1153                     ; 436         //printf("NEAR\n");
1153                     ; 437 				//send_buf[6] = 0x01;
1153                     ; 438         break;
1155  0120               L303:
1156                     ; 439       case DIR_FAR:
1156                     ; 440         //printf("FAR\n");
1156                     ; 441 				//send_buf[7] = 0x01;
1156                     ; 442         break;
1158  0120               L503:
1159                     ; 443       default:
1159                     ; 444         //printf("NONE\n");
1159                     ; 445 				//send_buf[8] = 0x01;
1159                     ; 446 				break;
1161  0120               L323:
1162  0120               L713:
1163                     ; 453 }
1166  0120 81            	ret
1190                     ; 455 void GestureTest(void)
1190                     ; 456 {
1191                     .text:	section	.text,new
1192  0000               _GestureTest:
1196                     ; 466   if ( enableGestureSensor(1) ) {
1198  0000 a601          	ld	a,#1
1199  0002 cd0000        	call	_enableGestureSensor
1201  0005 4d            	tnz	a
1203  0006               L704:
1204                     ; 473 }
1207  0006 81            	ret
1210                     	switch	.data
1211  0000               L114_ambient_light:
1212  0000 0000          	dc.w	0
1213  0002               L314_red_light:
1214  0002 0000          	dc.w	0
1215  0004               L514_green_light:
1216  0004 0000          	dc.w	0
1217  0006               L714_blue_light:
1218  0006 0000          	dc.w	0
1219  0008               L124_threshold:
1220  0008 0000          	dc.w	0
1293                     ; 475 void LightTest(void)
1293                     ; 476 {
1294                     .text:	section	.text,new
1295  0000               _LightTest:
1299                     ; 483   if ( init() ) {
1301  0000 cd0000        	call	_init
1303  0003 4d            	tnz	a
1304  0004 270a          	jreq	L744
1306                     ; 493   if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
1308  0006 ae000a        	ldw	x,#10
1309  0009 cd0000        	call	_setLightIntLowThreshold
1311  000c 4d            	tnz	a
1312  000d 2607          	jrne	L354
1313                     ; 495 		return;
1316  000f 81            	ret
1317  0010               L744:
1318                     ; 488 		LED_Toggle(LED5);
1320  0010 a602          	ld	a,#2
1321  0012 cd0000        	call	_LED_Toggle
1323                     ; 489 		return;
1326  0015 81            	ret
1327  0016               L354:
1328                     ; 497   if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
1330  0016 ae03e8        	ldw	x,#1000
1331  0019 cd0000        	call	_setLightIntHighThreshold
1333  001c 4d            	tnz	a
1334  001d 2601          	jrne	L554
1335                     ; 499 		return;
1338  001f 81            	ret
1339  0020               L554:
1340                     ; 503   if ( enableLightSensor(0) ) {
1342  0020 4f            	clr	a
1343  0021 cd0000        	call	_enableLightSensor
1345  0024 4d            	tnz	a
1346  0025 270a          	jreq	L754
1348                     ; 511   if ( !getLightIntLowThreshold(&threshold) ) {
1350  0027 ae0008        	ldw	x,#L124_threshold
1351  002a cd0000        	call	_getLightIntLowThreshold
1353  002d 4d            	tnz	a
1354  002e 2602          	jrne	L564
1355                     ; 513 		return;
1358  0030 81            	ret
1359  0031               L754:
1360                     ; 507 		return;
1363  0031 81            	ret
1364  0032               L564:
1365                     ; 517   if ( !getLightIntHighThreshold(&threshold) ) {
1367  0032 ae0008        	ldw	x,#L124_threshold
1368  0035 cd0000        	call	_getLightIntHighThreshold
1370  0038 4d            	tnz	a
1371  0039 2601          	jrne	L174
1372                     ; 519 		return;
1375  003b 81            	ret
1376  003c               L174:
1377                     ; 524 	if ( setAmbientLightIntEnable(0) ) {
1379  003c 4f            	clr	a
1380  003d cd0000        	call	_setAmbientLightIntEnable
1382  0040 4d            	tnz	a
1383  0041 2731          	jreq	L374
1385                     ; 535   delay_ms(200);
1387  0043 ae00c8        	ldw	x,#200
1388  0046 cf0000        	ldw	_TIM3_tout,x
1389  0049               L774:
1393  0049 ce0000        	ldw	x,_TIM3_tout
1394  004c 26fb          	jrne	L774
1395                     ; 541 			if (  !readAmbientLight(&ambient_light) ||
1395                     ; 542 						!readRedLight(&red_light) ||
1395                     ; 543 						!readGreenLight(&green_light) ||
1395                     ; 544 						!readBlueLight(&blue_light) ) {
1398  004e ae0000        	ldw	x,#L114_ambient_light
1399  0051 cd0000        	call	_readAmbientLight
1401  0054 4d            	tnz	a
1402  0055 271e          	jreq	L705
1404  0057 ae0002        	ldw	x,#L314_red_light
1405  005a cd0000        	call	_readRedLight
1407  005d 4d            	tnz	a
1408  005e 2715          	jreq	L705
1410  0060 ae0004        	ldw	x,#L514_green_light
1411  0063 cd0000        	call	_readGreenLight
1413  0066 4d            	tnz	a
1414  0067 270c          	jreq	L705
1416  0069 ae0006        	ldw	x,#L714_blue_light
1417  006c cd0000        	call	_readBlueLight
1419  006f 4d            	tnz	a
1420  0070 2604          	jrne	L515
1421  0072 2001          	jra	L705
1422  0074               L374:
1423                     ; 527 		return;
1426  0074 81            	ret
1427  0075               L705:
1428                     ; 546 				return;
1431  0075 81            	ret
1432  0076               L515:
1433                     ; 572 			if ( !clearAmbientLightInt() ) {
1435  0076 cd0000        	call	_clearAmbientLightInt
1437  0079 4d            	tnz	a
1438  007a 2601          	jrne	L715
1439                     ; 574 				return;
1442  007c 81            	ret
1443  007d               L715:
1444                     ; 576 			enableGestureSensor(1);
1446  007d a601          	ld	a,#1
1447  007f cd0000        	call	_enableGestureSensor
1449                     ; 579 }
1452  0082 81            	ret
1476                     ; 589 void Task_500us(void)
1476                     ; 590 {
1477                     .text:	section	.text,new
1478  0000               _Task_500us:
1482                     ; 591 	if(f_500us)
1484  0000 c60004        	ld	a,_Flag1_
1485  0003 a501          	bcp	a,#1
1486  0005 2704          	jreq	L135
1487                     ; 593 		f_500us = 0;
1489  0007 72110004      	bres	_Flag1_,#0
1490  000b               L135:
1491                     ; 596 }
1494  000b 81            	ret
1519                     ; 603 void Task_2ms(void)
1519                     ; 604 {
1520                     .text:	section	.text,new
1521  0000               _Task_2ms:
1525                     ; 605 	if(f_2ms)
1527  0000 c60004        	ld	a,_Flag1_
1528  0003 a502          	bcp	a,#2
1529  0005 2707          	jreq	L345
1530                     ; 607 		f_2ms = 0;
1532  0007 72130004      	bres	_Flag1_,#1
1533                     ; 608 		reve_analyze_reply();
1535  000b cd0000        	call	_reve_analyze_reply
1537  000e               L345:
1538                     ; 610 }
1541  000e 81            	ret
1565                     ; 617 void Task_100ms(void)
1565                     ; 618 {
1566                     .text:	section	.text,new
1567  0000               _Task_100ms:
1571                     ; 619 	if(f_100ms)
1573  0000 c60004        	ld	a,_Flag1_
1574  0003 a504          	bcp	a,#4
1575  0005 2704          	jreq	L555
1576                     ; 621 		f_100ms = 0;
1578  0007 72150004      	bres	_Flag1_,#2
1579  000b               L555:
1580                     ; 623 }
1583  000b 81            	ret
1607                     ; 630 void Task_300ms(void)
1607                     ; 631 {
1608                     .text:	section	.text,new
1609  0000               _Task_300ms:
1613                     ; 632 	if(f_300ms)
1615  0000 c60004        	ld	a,_Flag1_
1616  0003 a508          	bcp	a,#8
1617  0005 2704          	jreq	L765
1618                     ; 634 		f_300ms = 0;
1620  0007 72170004      	bres	_Flag1_,#3
1621  000b               L765:
1622                     ; 636 }
1625  000b 81            	ret
1628                     	switch	.data
1629  000a               L175_i:
1630  000a 0000          	dc.w	0
1631  000c               L375_j:
1632  000c 0000          	dc.w	0
1674                     ; 643 void Task_1s(void)
1674                     ; 644 {
1675                     .text:	section	.text,new
1676  0000               _Task_1s:
1680                     ; 647 	if(f_1s)
1682  0000 c60004        	ld	a,_Flag1_
1683  0003 a510          	bcp	a,#16
1684  0005 2744          	jreq	L316
1685                     ; 649 		f_1s = 0;
1687  0007 72190004      	bres	_Flag1_,#4
1688                     ; 650 		i++;
1690  000b ce000a        	ldw	x,L175_i
1691  000e 1c0001        	addw	x,#1
1692  0011 cf000a        	ldw	L175_i,x
1693                     ; 651 		j++;
1695  0014 ce000c        	ldw	x,L375_j
1696  0017 1c0001        	addw	x,#1
1697  001a cf000c        	ldw	L375_j,x
1698                     ; 652 		if(i >= 5)	{i = 0;LightTest();}
1700  001d 9c            	rvf
1701  001e ce000a        	ldw	x,L175_i
1702  0021 a30005        	cpw	x,#5
1703  0024 2f07          	jrslt	L516
1706  0026 5f            	clrw	x
1707  0027 cf000a        	ldw	L175_i,x
1710  002a cd0000        	call	_LightTest
1712  002d               L516:
1713                     ; 653 		LED_Toggle(LED4);
1715  002d a604          	ld	a,#4
1716  002f cd0000        	call	_LED_Toggle
1718                     ; 655 		if(j >= 3)	{j = 0;gest_cnt = 0;st1.st_ges_H = 0x00;st1.st_ges_L = 0x00;}
1720  0032 9c            	rvf
1721  0033 ce000c        	ldw	x,L375_j
1722  0036 a30003        	cpw	x,#3
1723  0039 2f10          	jrslt	L316
1726  003b 5f            	clrw	x
1727  003c cf000c        	ldw	L375_j,x
1730  003f 725f0002      	clr	_gest_cnt
1733  0043 725f0000      	clr	_st1
1736  0047 725f0001      	clr	_st1+1
1737  004b               L316:
1738                     ; 672 }
1741  004b 81            	ret
1774                     ; 675 void LED_Init(u8 LedNum)
1774                     ; 676 {
1775                     .text:	section	.text,new
1776  0000               _LED_Init:
1778  0000 88            	push	a
1779       00000000      OFST:	set	0
1782                     ; 677 	if(LedNum & LED1)//LED1
1784  0001 a508          	bcp	a,#8
1785  0003 270b          	jreq	L536
1786                     ; 679 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED1, GPIO_MODE_OUT_PP_LOW_FAST);
1788  0005 4bc0          	push	#192
1789  0007 4b08          	push	#8
1790  0009 ae500a        	ldw	x,#20490
1791  000c cd0000        	call	_GPIO_Init
1793  000f 85            	popw	x
1794  0010               L536:
1795                     ; 681 	if(LedNum & LED2)//LED2
1797  0010 7b01          	ld	a,(OFST+1,sp)
1798  0012 a510          	bcp	a,#16
1799  0014 270b          	jreq	L736
1800                     ; 683 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED2, GPIO_MODE_OUT_PP_LOW_FAST);
1802  0016 4bc0          	push	#192
1803  0018 4b10          	push	#16
1804  001a ae500a        	ldw	x,#20490
1805  001d cd0000        	call	_GPIO_Init
1807  0020 85            	popw	x
1808  0021               L736:
1809                     ; 685 	if(LedNum & LED3)//LED3
1811  0021 7b01          	ld	a,(OFST+1,sp)
1812  0023 a520          	bcp	a,#32
1813  0025 270b          	jreq	L146
1814                     ; 687 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED3, GPIO_MODE_OUT_PP_LOW_FAST);
1816  0027 4bc0          	push	#192
1817  0029 4b20          	push	#32
1818  002b ae500a        	ldw	x,#20490
1819  002e cd0000        	call	_GPIO_Init
1821  0031 85            	popw	x
1822  0032               L146:
1823                     ; 689 	if(LedNum & LED4)//LED4
1825  0032 7b01          	ld	a,(OFST+1,sp)
1826  0034 a504          	bcp	a,#4
1827  0036 270b          	jreq	L346
1828                     ; 691 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED4, GPIO_MODE_OUT_PP_LOW_FAST);
1830  0038 4bc0          	push	#192
1831  003a 4b04          	push	#4
1832  003c ae500a        	ldw	x,#20490
1833  003f cd0000        	call	_GPIO_Init
1835  0042 85            	popw	x
1836  0043               L346:
1837                     ; 693 	if(LedNum & LED5)//LED5
1839  0043 7b01          	ld	a,(OFST+1,sp)
1840  0045 a502          	bcp	a,#2
1841  0047 270b          	jreq	L546
1842                     ; 695 		GPIO_Init(LED_PORT, (GPIO_Pin_TypeDef)LED5, GPIO_MODE_OUT_PP_LOW_FAST);
1844  0049 4bc0          	push	#192
1845  004b 4b02          	push	#2
1846  004d ae500a        	ldw	x,#20490
1847  0050 cd0000        	call	_GPIO_Init
1849  0053 85            	popw	x
1850  0054               L546:
1851                     ; 697 }
1854  0054 84            	pop	a
1855  0055 81            	ret
1889                     ; 699 void LED_On(u8 LedNum)
1889                     ; 700 {
1890                     .text:	section	.text,new
1891  0000               _LED_On:
1893  0000 88            	push	a
1894       00000000      OFST:	set	0
1897                     ; 701 	if(LedNum & LED1)//LED1
1899  0001 a508          	bcp	a,#8
1900  0003 2709          	jreq	L366
1901                     ; 703 		GPIO_WriteHigh(LED_PORT, LED1);
1903  0005 4b08          	push	#8
1904  0007 ae500a        	ldw	x,#20490
1905  000a cd0000        	call	_GPIO_WriteHigh
1907  000d 84            	pop	a
1908  000e               L366:
1909                     ; 705 	if(LedNum & LED2)//LED2
1911  000e 7b01          	ld	a,(OFST+1,sp)
1912  0010 a510          	bcp	a,#16
1913  0012 2709          	jreq	L566
1914                     ; 707 		GPIO_WriteHigh(LED_PORT, LED2);
1916  0014 4b10          	push	#16
1917  0016 ae500a        	ldw	x,#20490
1918  0019 cd0000        	call	_GPIO_WriteHigh
1920  001c 84            	pop	a
1921  001d               L566:
1922                     ; 709 	if(LedNum & LED3)//LED3
1924  001d 7b01          	ld	a,(OFST+1,sp)
1925  001f a520          	bcp	a,#32
1926  0021 2709          	jreq	L766
1927                     ; 711 		GPIO_WriteHigh(LED_PORT, LED3);
1929  0023 4b20          	push	#32
1930  0025 ae500a        	ldw	x,#20490
1931  0028 cd0000        	call	_GPIO_WriteHigh
1933  002b 84            	pop	a
1934  002c               L766:
1935                     ; 713 	if(LedNum & LED4)//LED4
1937  002c 7b01          	ld	a,(OFST+1,sp)
1938  002e a504          	bcp	a,#4
1939  0030 2709          	jreq	L176
1940                     ; 715 		GPIO_WriteLow(LED_PORT, LED4);
1942  0032 4b04          	push	#4
1943  0034 ae500a        	ldw	x,#20490
1944  0037 cd0000        	call	_GPIO_WriteLow
1946  003a 84            	pop	a
1947  003b               L176:
1948                     ; 717 	if(LedNum & LED5)//LED5
1950  003b 7b01          	ld	a,(OFST+1,sp)
1951  003d a502          	bcp	a,#2
1952  003f 2709          	jreq	L376
1953                     ; 719 		GPIO_WriteLow(LED_PORT, LED5);
1955  0041 4b02          	push	#2
1956  0043 ae500a        	ldw	x,#20490
1957  0046 cd0000        	call	_GPIO_WriteLow
1959  0049 84            	pop	a
1960  004a               L376:
1961                     ; 721 }
1964  004a 84            	pop	a
1965  004b 81            	ret
1998                     ; 724 void LED_Off(u8 LedNum)
1998                     ; 725 {
1999                     .text:	section	.text,new
2000  0000               _LED_Off:
2002  0000 88            	push	a
2003       00000000      OFST:	set	0
2006                     ; 726 	if(LedNum & LED1)//LED1
2008  0001 a508          	bcp	a,#8
2009  0003 2709          	jreq	L117
2010                     ; 728 		GPIO_WriteLow(LED_PORT, LED1);
2012  0005 4b08          	push	#8
2013  0007 ae500a        	ldw	x,#20490
2014  000a cd0000        	call	_GPIO_WriteLow
2016  000d 84            	pop	a
2017  000e               L117:
2018                     ; 730 	if(LedNum & LED2)//LED2
2020  000e 7b01          	ld	a,(OFST+1,sp)
2021  0010 a510          	bcp	a,#16
2022  0012 2709          	jreq	L317
2023                     ; 732 		GPIO_WriteLow(LED_PORT, LED2);
2025  0014 4b10          	push	#16
2026  0016 ae500a        	ldw	x,#20490
2027  0019 cd0000        	call	_GPIO_WriteLow
2029  001c 84            	pop	a
2030  001d               L317:
2031                     ; 734 	if(LedNum & LED3)//LED3
2033  001d 7b01          	ld	a,(OFST+1,sp)
2034  001f a520          	bcp	a,#32
2035  0021 2709          	jreq	L517
2036                     ; 736 		GPIO_WriteLow(LED_PORT, LED3);
2038  0023 4b20          	push	#32
2039  0025 ae500a        	ldw	x,#20490
2040  0028 cd0000        	call	_GPIO_WriteLow
2042  002b 84            	pop	a
2043  002c               L517:
2044                     ; 738 	if(LedNum & LED4)//LED4
2046  002c 7b01          	ld	a,(OFST+1,sp)
2047  002e a504          	bcp	a,#4
2048  0030 2709          	jreq	L717
2049                     ; 740 		GPIO_WriteLow(LED_PORT, LED4);
2051  0032 4b04          	push	#4
2052  0034 ae500a        	ldw	x,#20490
2053  0037 cd0000        	call	_GPIO_WriteLow
2055  003a 84            	pop	a
2056  003b               L717:
2057                     ; 742 	if(LedNum & LED5)//LED5
2059  003b 7b01          	ld	a,(OFST+1,sp)
2060  003d a502          	bcp	a,#2
2061  003f 2709          	jreq	L127
2062                     ; 744 		GPIO_WriteLow(LED_PORT, LED5);
2064  0041 4b02          	push	#2
2065  0043 ae500a        	ldw	x,#20490
2066  0046 cd0000        	call	_GPIO_WriteLow
2068  0049 84            	pop	a
2069  004a               L127:
2070                     ; 746 }
2073  004a 84            	pop	a
2074  004b 81            	ret
2107                     ; 748 void LED_Toggle(u8 LedNum)
2107                     ; 749 {
2108                     .text:	section	.text,new
2109  0000               _LED_Toggle:
2111  0000 88            	push	a
2112       00000000      OFST:	set	0
2115                     ; 750 	if(LedNum & LED1)//LED1
2117  0001 a508          	bcp	a,#8
2118  0003 2709          	jreq	L737
2119                     ; 752 		GPIO_WriteReverse(LED_PORT, LED1);
2121  0005 4b08          	push	#8
2122  0007 ae500a        	ldw	x,#20490
2123  000a cd0000        	call	_GPIO_WriteReverse
2125  000d 84            	pop	a
2126  000e               L737:
2127                     ; 754 	if(LedNum & LED2)//LED2
2129  000e 7b01          	ld	a,(OFST+1,sp)
2130  0010 a510          	bcp	a,#16
2131  0012 2709          	jreq	L147
2132                     ; 756 		GPIO_WriteReverse(LED_PORT, LED2);
2134  0014 4b10          	push	#16
2135  0016 ae500a        	ldw	x,#20490
2136  0019 cd0000        	call	_GPIO_WriteReverse
2138  001c 84            	pop	a
2139  001d               L147:
2140                     ; 758 	if(LedNum & LED3)//LED3
2142  001d 7b01          	ld	a,(OFST+1,sp)
2143  001f a520          	bcp	a,#32
2144  0021 2709          	jreq	L347
2145                     ; 760 		GPIO_WriteReverse(LED_PORT, LED3);
2147  0023 4b20          	push	#32
2148  0025 ae500a        	ldw	x,#20490
2149  0028 cd0000        	call	_GPIO_WriteReverse
2151  002b 84            	pop	a
2152  002c               L347:
2153                     ; 762 	if(LedNum & LED4)//LED4
2155  002c 7b01          	ld	a,(OFST+1,sp)
2156  002e a504          	bcp	a,#4
2157  0030 2709          	jreq	L547
2158                     ; 764 		GPIO_WriteReverse(LED_PORT, LED4);
2160  0032 4b04          	push	#4
2161  0034 ae500a        	ldw	x,#20490
2162  0037 cd0000        	call	_GPIO_WriteReverse
2164  003a 84            	pop	a
2165  003b               L547:
2166                     ; 766 	if(LedNum & LED5)//LED5
2168  003b 7b01          	ld	a,(OFST+1,sp)
2169  003d a502          	bcp	a,#2
2170  003f 2709          	jreq	L747
2171                     ; 768 		GPIO_WriteReverse(LED_PORT, LED5);
2173  0041 4b02          	push	#2
2174  0043 ae500a        	ldw	x,#20490
2175  0046 cd0000        	call	_GPIO_WriteReverse
2177  0049 84            	pop	a
2178  004a               L747:
2179                     ; 770 }
2182  004a 84            	pop	a
2183  004b 81            	ret
2216                     ; 772 void KEY_Init(u8 KeyNum)
2216                     ; 773 {
2217                     .text:	section	.text,new
2218  0000               _KEY_Init:
2220  0000 88            	push	a
2221       00000000      OFST:	set	0
2224                     ; 774 	if(KeyNum & KEY1)//LED1
2226  0001 a501          	bcp	a,#1
2227  0003 270b          	jreq	L567
2228                     ; 776 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY1, GPIO_MODE_IN_PU_NO_IT);
2230  0005 4b40          	push	#64
2231  0007 4b01          	push	#1
2232  0009 ae5005        	ldw	x,#20485
2233  000c cd0000        	call	_GPIO_Init
2235  000f 85            	popw	x
2236  0010               L567:
2237                     ; 778 	if(KeyNum & KEY2)//LED2
2239  0010 7b01          	ld	a,(OFST+1,sp)
2240  0012 a502          	bcp	a,#2
2241  0014 270b          	jreq	L767
2242                     ; 780 		GPIO_Init(KEY_PORT, (GPIO_Pin_TypeDef)KEY2, GPIO_MODE_IN_PU_NO_IT);
2244  0016 4b40          	push	#64
2245  0018 4b02          	push	#2
2246  001a ae5005        	ldw	x,#20485
2247  001d cd0000        	call	_GPIO_Init
2249  0020 85            	popw	x
2250  0021               L767:
2251                     ; 782 }
2254  0021 84            	pop	a
2255  0022 81            	ret
2309                     ; 784 bool KEY_Read(u8 KeyNum)
2309                     ; 785 {
2310                     .text:	section	.text,new
2311  0000               _KEY_Read:
2313  0000 88            	push	a
2314       00000000      OFST:	set	0
2317                     ; 786 	if(KeyNum & KEY1)//LED1
2319  0001 a501          	bcp	a,#1
2320  0003 2713          	jreq	L5101
2321                     ; 788 		if((GPIO_ReadInputData(KEY_PORT) & 0x01) == 0x00)
2323  0005 ae5005        	ldw	x,#20485
2324  0008 cd0000        	call	_GPIO_ReadInputData
2326  000b a501          	bcp	a,#1
2327  000d 2605          	jrne	L7101
2328                     ; 789 			return TRUE;
2330  000f a601          	ld	a,#1
2333  0011 5b01          	addw	sp,#1
2334  0013 81            	ret
2335  0014               L7101:
2336                     ; 791 			return FALSE;
2338  0014 4f            	clr	a
2341  0015 5b01          	addw	sp,#1
2342  0017 81            	ret
2343  0018               L5101:
2344                     ; 793 	if(KeyNum & KEY2)//LED2
2346  0018 7b01          	ld	a,(OFST+1,sp)
2347  001a a502          	bcp	a,#2
2348  001c 2713          	jreq	L3201
2349                     ; 795 		if((GPIO_ReadInputData(KEY_PORT) & 0x02) == 0x00)
2351  001e ae5005        	ldw	x,#20485
2352  0021 cd0000        	call	_GPIO_ReadInputData
2354  0024 a502          	bcp	a,#2
2355  0026 2605          	jrne	L5201
2356                     ; 796 			return TRUE;
2358  0028 a601          	ld	a,#1
2361  002a 5b01          	addw	sp,#1
2362  002c 81            	ret
2363  002d               L5201:
2364                     ; 798 			return FALSE;
2366  002d 4f            	clr	a
2369  002e 5b01          	addw	sp,#1
2370  0030 81            	ret
2371  0031               L3201:
2372                     ; 800 }
2375  0031 5b01          	addw	sp,#1
2376  0033 81            	ret
2422                     ; 805 void delay(u16 Count)
2422                     ; 806 {
2423                     .text:	section	.text,new
2424  0000               _delay:
2426  0000 89            	pushw	x
2427  0001 89            	pushw	x
2428       00000002      OFST:	set	2
2431  0002 2014          	jra	L3501
2432  0004               L1501:
2433                     ; 810     for(i=0;i<100;i++)
2435  0004 0f01          	clr	(OFST-1,sp)
2436  0006               L7501:
2437                     ; 811     for(j=0;j<50;j++);
2439  0006 0f02          	clr	(OFST+0,sp)
2440  0008               L5601:
2444  0008 0c02          	inc	(OFST+0,sp)
2447  000a 7b02          	ld	a,(OFST+0,sp)
2448  000c a132          	cp	a,#50
2449  000e 25f8          	jrult	L5601
2450                     ; 810     for(i=0;i<100;i++)
2452  0010 0c01          	inc	(OFST-1,sp)
2455  0012 7b01          	ld	a,(OFST-1,sp)
2456  0014 a164          	cp	a,#100
2457  0016 25ee          	jrult	L7501
2458  0018               L3501:
2459                     ; 808   while (Count--)//Count形参控制延时次数
2461  0018 1e03          	ldw	x,(OFST+1,sp)
2462  001a 1d0001        	subw	x,#1
2463  001d 1f03          	ldw	(OFST+1,sp),x
2464  001f 1c0001        	addw	x,#1
2465  0022 a30000        	cpw	x,#0
2466  0025 26dd          	jrne	L1501
2467                     ; 813 }
2470  0027 5b04          	addw	sp,#4
2471  0029 81            	ret
2534                     	xdef	_main
2535                     	xdef	_EXTI_Config
2536                     	xdef	_ExtraCode_StateMachine
2537                     	xdef	_ExtraCode_Init
2538                     	switch	.bss
2539  0000               _ptr:
2540  0000 0000          	ds.b	2
2541                     	xdef	_ptr
2542                     .bit:	section	.data,bit
2543  0000               _p_valid:
2544  0000 00            	ds.b	1
2545                     	xdef	_p_valid
2546  0001               _in_range:
2547  0001 00            	ds.b	1
2548                     	xdef	_in_range
2549                     	switch	.bss
2550  0002               _gest_cnt:
2551  0002 00            	ds.b	1
2552                     	xdef	_gest_cnt
2553  0003               _isr_flag:
2554  0003 00            	ds.b	1
2555                     	xdef	_isr_flag
2556                     	xref	_readGesture
2557                     	xref	_isGestureAvailable
2558                     	xref	_readBlueLight
2559                     	xref	_readGreenLight
2560                     	xref	_readRedLight
2561                     	xref	_readAmbientLight
2562                     	xref	_clearAmbientLightInt
2563                     	xref	_setAmbientLightIntEnable
2564                     	xref	_setLightIntHighThreshold
2565                     	xref	_getLightIntHighThreshold
2566                     	xref	_setLightIntLowThreshold
2567                     	xref	_getLightIntLowThreshold
2568                     	xref	_enableGestureSensor
2569                     	xref	_enableLightSensor
2570                     	xref	_init
2571                     	xref	_TIM3_tout
2572                     	xref	_send_header_payload_init
2573                     	xref	_reve_analyze_reply
2574                     	xref	_UART2_Send_Data_Start
2575                     	xref	_Init_uart2
2576                     	xref	_ns_host_meshid_L
2577                     	xref	_ns_host_meshid_H
2578                     	xref	_st1
2579                     	xref	_UART1Flag5_
2580                     	xref	_UART1Flag3_
2581                     	xref	_UART1Flag2_
2582                     	xref	_UART1Flag1_
2583                     	xdef	_LightTest
2584                     	xdef	_GestureTest
2585                     	xdef	_handleGesture
2586                     	xdef	_PORTD_EXT_ISR
2587                     	xdef	_Variable_Init
2588                     	xdef	_KEY_Read
2589                     	xdef	_KEY_Init
2590                     	xdef	_LED_Toggle
2591                     	xdef	_LED_Off
2592                     	xdef	_LED_On
2593                     	xdef	_LED_Init
2594                     	xdef	_delay
2595                     	xdef	_Task_1s
2596                     	xdef	_Task_300ms
2597                     	xdef	_Task_100ms
2598                     	xdef	_Task_2ms
2599                     	xdef	_Task_500us
2600  0004               _Flag1_:
2601  0004 00            	ds.b	1
2602                     	xdef	_Flag1_
2603  0005               _systime_count:
2604  0005 000000000000  	ds.b	8
2605                     	xdef	_systime_count
2606  000d               _gusture:
2607  000d 0000          	ds.b	2
2608                     	xdef	_gusture
2609                     	xref	_TSL_Action
2610                     	xref	_TSL_Init
2611                     	xref	_sSCKeyInfo
2612                     	xref.b	_TSL_GlobalSetting
2613                     	xref.b	_TSLState
2614                     	xref	_GPIO_ReadInputData
2615                     	xref	_GPIO_WriteReverse
2616                     	xref	_GPIO_WriteLow
2617                     	xref	_GPIO_WriteHigh
2618                     	xref	_GPIO_Init
2619                     	xref	_EXTI_SetTLISensitivity
2620                     	xref	_EXTI_SetExtIntSensitivity
2621                     	xref	_EXTI_DeInit
2641                     	end
