   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	switch	.data
   5  0000               _MPR121_ISR_FLAG:
   6  0000 00            	dc.b	0
   7  0001               _mpr121_handle:
   8  0001 00            	dc.b	0
   9  0002 0000          	ds.b	2
  10  0004 000000000000  	ds.b	26
  74                     ; 30 uint8_t MPR121_WriteDataByte(uint8_t reg, uint8_t val)
  74                     ; 31 {
  76                     .text:	section	.text,new
  77  0000               _MPR121_WriteDataByte:
  79  0000 5203          	subw	sp,#3
  80       00000003      OFST:	set	3
  83                     ; 35 	buffer[0] = reg;
  85  0002 9e            	ld	a,xh
  86  0003 6b02          	ld	(OFST-1,sp),a
  87                     ; 36 	buffer[1] = val;
  89  0005 9f            	ld	a,xl
  90  0006 6b03          	ld	(OFST+0,sp),a
  91                     ; 37 	ret = I2C_WriteBytes(MPR121_I2C_ADDR, buffer, 2, 10);
  93  0008 4b0a          	push	#10
  94  000a 4b02          	push	#2
  95  000c 96            	ldw	x,sp
  96  000d 1c0004        	addw	x,#OFST+1
  97  0010 89            	pushw	x
  98  0011 ae005a        	ldw	x,#90
  99  0014 cd0000        	call	_I2C_WriteBytes
 101  0017 5b04          	addw	sp,#4
 102  0019 6b01          	ld	(OFST-2,sp),a
 103                     ; 38 	if(ret != IIC_SUCCESS) {
 105  001b 0d01          	tnz	(OFST-2,sp)
 106  001d 2703          	jreq	L53
 107                     ; 39 		return 0;
 109  001f 4f            	clr	a
 111  0020 2002          	jra	L6
 112  0022               L53:
 113                     ; 41 	return 1;
 115  0022 a601          	ld	a,#1
 117  0024               L6:
 119  0024 5b03          	addw	sp,#3
 120  0026 81            	ret
 171                     ; 52 uint8_t MPR121_ReadDataByte(uint8_t reg, uint8_t *val)
 171                     ; 53 {
 172                     .text:	section	.text,new
 173  0000               _MPR121_ReadDataByte:
 175  0000 88            	push	a
 176  0001 88            	push	a
 177       00000001      OFST:	set	1
 180                     ; 55 	ret = I2C_WriteReadBytes(MPR121_I2C_ADDR, &reg, 1, val, 1, 10);
 182  0002 4b0a          	push	#10
 183  0004 4b01          	push	#1
 184  0006 1e07          	ldw	x,(OFST+6,sp)
 185  0008 89            	pushw	x
 186  0009 4b01          	push	#1
 187  000b 96            	ldw	x,sp
 188  000c 1c0007        	addw	x,#OFST+6
 189  000f 89            	pushw	x
 190  0010 ae005a        	ldw	x,#90
 191  0013 cd0000        	call	_I2C_WriteReadBytes
 193  0016 5b07          	addw	sp,#7
 194  0018 6b01          	ld	(OFST+0,sp),a
 195                     ; 56 	if(ret != IIC_SUCCESS) {
 197  001a 0d01          	tnz	(OFST+0,sp)
 198  001c 2703          	jreq	L16
 199                     ; 57 		return 0;
 201  001e 4f            	clr	a
 203  001f 2002          	jra	L21
 204  0021               L16:
 205                     ; 59 	return 1;
 207  0021 a601          	ld	a,#1
 209  0023               L21:
 211  0023 85            	popw	x
 212  0024 81            	ret
 270                     ; 75 int MPR121_ReadDataBlock(uint8_t reg, uint8_t *val, unsigned int len)
 270                     ; 76 {
 271                     .text:	section	.text,new
 272  0000               _MPR121_ReadDataBlock:
 274  0000 88            	push	a
 275  0001 88            	push	a
 276       00000001      OFST:	set	1
 279                     ; 78 	ret = I2C_WriteReadBytes(MPR121_I2C_ADDR, &reg, 1, val, len, 100);
 281  0002 4b64          	push	#100
 282  0004 7b09          	ld	a,(OFST+8,sp)
 283  0006 88            	push	a
 284  0007 1e07          	ldw	x,(OFST+6,sp)
 285  0009 89            	pushw	x
 286  000a 4b01          	push	#1
 287  000c 96            	ldw	x,sp
 288  000d 1c0007        	addw	x,#OFST+6
 289  0010 89            	pushw	x
 290  0011 ae005a        	ldw	x,#90
 291  0014 cd0000        	call	_I2C_WriteReadBytes
 293  0017 5b07          	addw	sp,#7
 294  0019 6b01          	ld	(OFST+0,sp),a
 295                     ; 79 	if(ret != IIC_SUCCESS) {
 297  001b 0d01          	tnz	(OFST+0,sp)
 298  001d 2703          	jreq	L701
 299                     ; 80 		return 0;
 301  001f 5f            	clrw	x
 303  0020 2002          	jra	L61
 304  0022               L701:
 305                     ; 82 	return len;
 307  0022 1e07          	ldw	x,(OFST+6,sp)
 309  0024               L61:
 311  0024 5b02          	addw	sp,#2
 312  0026 81            	ret
 336                     ; 89 void MPR121_init(void)
 336                     ; 90 {  
 337                     .text:	section	.text,new
 338  0000               _MPR121_init:
 342                     ; 93 	MPR121_WriteDataByte(MHD_R, 0x01);
 344  0000 ae0001        	ldw	x,#1
 345  0003 a62b          	ld	a,#43
 346  0005 95            	ld	xh,a
 347  0006 cd0000        	call	_MPR121_WriteDataByte
 349                     ; 94 	MPR121_WriteDataByte(NHD_R, 0x01);
 351  0009 ae0001        	ldw	x,#1
 352  000c a62c          	ld	a,#44
 353  000e 95            	ld	xh,a
 354  000f cd0000        	call	_MPR121_WriteDataByte
 356                     ; 95 	MPR121_WriteDataByte(NCL_R, 0x00);
 358  0012 5f            	clrw	x
 359  0013 a62d          	ld	a,#45
 360  0015 95            	ld	xh,a
 361  0016 cd0000        	call	_MPR121_WriteDataByte
 363                     ; 96 	MPR121_WriteDataByte(FDL_R, 0x00);
 365  0019 5f            	clrw	x
 366  001a a62e          	ld	a,#46
 367  001c 95            	ld	xh,a
 368  001d cd0000        	call	_MPR121_WriteDataByte
 370                     ; 100 	MPR121_WriteDataByte(MHD_F, 0x01);
 372  0020 ae0001        	ldw	x,#1
 373  0023 a62f          	ld	a,#47
 374  0025 95            	ld	xh,a
 375  0026 cd0000        	call	_MPR121_WriteDataByte
 377                     ; 101 	MPR121_WriteDataByte(NHD_F, 0x01);
 379  0029 ae0001        	ldw	x,#1
 380  002c a630          	ld	a,#48
 381  002e 95            	ld	xh,a
 382  002f cd0000        	call	_MPR121_WriteDataByte
 384                     ; 102 	MPR121_WriteDataByte(NCL_F, 0xFF);
 386  0032 ae00ff        	ldw	x,#255
 387  0035 a631          	ld	a,#49
 388  0037 95            	ld	xh,a
 389  0038 cd0000        	call	_MPR121_WriteDataByte
 391                     ; 103 	MPR121_WriteDataByte(FDL_F, 0x02);
 393  003b ae0002        	ldw	x,#2
 394  003e a632          	ld	a,#50
 395  0040 95            	ld	xh,a
 396  0041 cd0000        	call	_MPR121_WriteDataByte
 398                     ; 107 	MPR121_WriteDataByte(ELE0_T, TOU_THRESH);
 400  0044 ae000b        	ldw	x,#11
 401  0047 a641          	ld	a,#65
 402  0049 95            	ld	xh,a
 403  004a cd0000        	call	_MPR121_WriteDataByte
 405                     ; 108 	MPR121_WriteDataByte(ELE0_R, REL_THRESH);
 407  004d ae0007        	ldw	x,#7
 408  0050 a642          	ld	a,#66
 409  0052 95            	ld	xh,a
 410  0053 cd0000        	call	_MPR121_WriteDataByte
 412                     ; 109 	MPR121_WriteDataByte(ELE1_T, TOU_THRESH);
 414  0056 ae000b        	ldw	x,#11
 415  0059 a643          	ld	a,#67
 416  005b 95            	ld	xh,a
 417  005c cd0000        	call	_MPR121_WriteDataByte
 419                     ; 110 	MPR121_WriteDataByte(ELE1_R, REL_THRESH);
 421  005f ae0007        	ldw	x,#7
 422  0062 a644          	ld	a,#68
 423  0064 95            	ld	xh,a
 424  0065 cd0000        	call	_MPR121_WriteDataByte
 426                     ; 111 	MPR121_WriteDataByte(ELE2_T, TOU_THRESH);
 428  0068 ae000b        	ldw	x,#11
 429  006b a645          	ld	a,#69
 430  006d 95            	ld	xh,a
 431  006e cd0000        	call	_MPR121_WriteDataByte
 433                     ; 112 	MPR121_WriteDataByte(ELE2_R, REL_THRESH);
 435  0071 ae0007        	ldw	x,#7
 436  0074 a646          	ld	a,#70
 437  0076 95            	ld	xh,a
 438  0077 cd0000        	call	_MPR121_WriteDataByte
 440                     ; 113 	MPR121_WriteDataByte(ELE3_T, TOU_THRESH);
 442  007a ae000b        	ldw	x,#11
 443  007d a647          	ld	a,#71
 444  007f 95            	ld	xh,a
 445  0080 cd0000        	call	_MPR121_WriteDataByte
 447                     ; 114 	MPR121_WriteDataByte(ELE3_R, REL_THRESH);
 449  0083 ae0007        	ldw	x,#7
 450  0086 a648          	ld	a,#72
 451  0088 95            	ld	xh,a
 452  0089 cd0000        	call	_MPR121_WriteDataByte
 454                     ; 115 	MPR121_WriteDataByte(ELE4_T, TOU_THRESH);
 456  008c ae000b        	ldw	x,#11
 457  008f a649          	ld	a,#73
 458  0091 95            	ld	xh,a
 459  0092 cd0000        	call	_MPR121_WriteDataByte
 461                     ; 116 	MPR121_WriteDataByte(ELE4_R, REL_THRESH);
 463  0095 ae0007        	ldw	x,#7
 464  0098 a64a          	ld	a,#74
 465  009a 95            	ld	xh,a
 466  009b cd0000        	call	_MPR121_WriteDataByte
 468                     ; 117 	MPR121_WriteDataByte(ELE5_T, TOU_THRESH);
 470  009e ae000b        	ldw	x,#11
 471  00a1 a64b          	ld	a,#75
 472  00a3 95            	ld	xh,a
 473  00a4 cd0000        	call	_MPR121_WriteDataByte
 475                     ; 118 	MPR121_WriteDataByte(ELE5_R, REL_THRESH);
 477  00a7 ae0007        	ldw	x,#7
 478  00aa a64c          	ld	a,#76
 479  00ac 95            	ld	xh,a
 480  00ad cd0000        	call	_MPR121_WriteDataByte
 482                     ; 119 	MPR121_WriteDataByte(ELE6_T, TOU_THRESH);
 484  00b0 ae000b        	ldw	x,#11
 485  00b3 a64d          	ld	a,#77
 486  00b5 95            	ld	xh,a
 487  00b6 cd0000        	call	_MPR121_WriteDataByte
 489                     ; 120 	MPR121_WriteDataByte(ELE6_R, REL_THRESH);
 491  00b9 ae0007        	ldw	x,#7
 492  00bc a64e          	ld	a,#78
 493  00be 95            	ld	xh,a
 494  00bf cd0000        	call	_MPR121_WriteDataByte
 496                     ; 121 	MPR121_WriteDataByte(ELE7_T, TOU_THRESH);
 498  00c2 ae000b        	ldw	x,#11
 499  00c5 a64f          	ld	a,#79
 500  00c7 95            	ld	xh,a
 501  00c8 cd0000        	call	_MPR121_WriteDataByte
 503                     ; 122 	MPR121_WriteDataByte(ELE7_R, REL_THRESH);
 505  00cb ae0007        	ldw	x,#7
 506  00ce a650          	ld	a,#80
 507  00d0 95            	ld	xh,a
 508  00d1 cd0000        	call	_MPR121_WriteDataByte
 510                     ; 123 	MPR121_WriteDataByte(ELE8_T, TOU_THRESH);
 512  00d4 ae000b        	ldw	x,#11
 513  00d7 a651          	ld	a,#81
 514  00d9 95            	ld	xh,a
 515  00da cd0000        	call	_MPR121_WriteDataByte
 517                     ; 124 	MPR121_WriteDataByte(ELE8_R, REL_THRESH);
 519  00dd ae0007        	ldw	x,#7
 520  00e0 a652          	ld	a,#82
 521  00e2 95            	ld	xh,a
 522  00e3 cd0000        	call	_MPR121_WriteDataByte
 524                     ; 125 	MPR121_WriteDataByte(ELE9_T, TOU_THRESH);
 526  00e6 ae000b        	ldw	x,#11
 527  00e9 a653          	ld	a,#83
 528  00eb 95            	ld	xh,a
 529  00ec cd0000        	call	_MPR121_WriteDataByte
 531                     ; 126 	MPR121_WriteDataByte(ELE9_R, REL_THRESH);
 533  00ef ae0007        	ldw	x,#7
 534  00f2 a654          	ld	a,#84
 535  00f4 95            	ld	xh,a
 536  00f5 cd0000        	call	_MPR121_WriteDataByte
 538                     ; 127 	MPR121_WriteDataByte(ELE10_T, TOU_THRESH);
 540  00f8 ae000b        	ldw	x,#11
 541  00fb a655          	ld	a,#85
 542  00fd 95            	ld	xh,a
 543  00fe cd0000        	call	_MPR121_WriteDataByte
 545                     ; 128 	MPR121_WriteDataByte(ELE10_R, REL_THRESH);
 547  0101 ae0007        	ldw	x,#7
 548  0104 a656          	ld	a,#86
 549  0106 95            	ld	xh,a
 550  0107 cd0000        	call	_MPR121_WriteDataByte
 552                     ; 129 	MPR121_WriteDataByte(ELE11_T, TOU_THRESH);
 554  010a ae000b        	ldw	x,#11
 555  010d a657          	ld	a,#87
 556  010f 95            	ld	xh,a
 557  0110 cd0000        	call	_MPR121_WriteDataByte
 559                     ; 130 	MPR121_WriteDataByte(ELE11_R, REL_THRESH);
 561  0113 ae0007        	ldw	x,#7
 562  0116 a658          	ld	a,#88
 563  0118 95            	ld	xh,a
 564  0119 cd0000        	call	_MPR121_WriteDataByte
 566                     ; 135 	MPR121_WriteDataByte(FIL_CFG, 0x04);
 568  011c ae0004        	ldw	x,#4
 569  011f a65d          	ld	a,#93
 570  0121 95            	ld	xh,a
 571  0122 cd0000        	call	_MPR121_WriteDataByte
 573                     ; 141 	MPR121_WriteDataByte(ELE_CFG, 0x0C);		// Enables all 12 Electrodes
 575  0125 ae000c        	ldw	x,#12
 576  0128 a65e          	ld	a,#94
 577  012a 95            	ld	xh,a
 578  012b cd0000        	call	_MPR121_WriteDataByte
 580                     ; 146 	MPR121_WriteDataByte(ATO_CFG0, 0x0B);
 582  012e ae000b        	ldw	x,#11
 583  0131 a67b          	ld	a,#123
 584  0133 95            	ld	xh,a
 585  0134 cd0000        	call	_MPR121_WriteDataByte
 587                     ; 147 	MPR121_WriteDataByte(ATO_CFGU, 0xC9);		// USL = (Vdd-0.7)/vdd*256 = 0xC9 @3.3V   
 589  0137 ae00c9        	ldw	x,#201
 590  013a a67d          	ld	a,#125
 591  013c 95            	ld	xh,a
 592  013d cd0000        	call	_MPR121_WriteDataByte
 594                     ; 148 	MPR121_WriteDataByte(ATO_CFGL, 0x82);		// LSL = 0.65*USL = 0x82 @3.3V
 596  0140 ae0082        	ldw	x,#130
 597  0143 a67e          	ld	a,#126
 598  0145 95            	ld	xh,a
 599  0146 cd0000        	call	_MPR121_WriteDataByte
 601                     ; 149 	MPR121_WriteDataByte(ATO_CFGT, 0xB5);		// Target = 0.9*USL = 0xB5 @3.3V
 603  0149 ae00b5        	ldw	x,#181
 604  014c a67f          	ld	a,#127
 605  014e 95            	ld	xh,a
 606  014f cd0000        	call	_MPR121_WriteDataByte
 608                     ; 151 }
 611  0152 81            	ret
 639                     ; 158 void MPR121_exti_config(void)
 639                     ; 159 {
 640                     .text:	section	.text,new
 641  0000               _MPR121_exti_config:
 645                     ; 160 	disableInterrupts();
 648  0000 9b            sim
 650                     ; 162 	GPIO_Init(GPIOA, GPIO_PIN_6, GPIO_MODE_IN_PU_IT );
 653  0001 4b60          	push	#96
 654  0003 4b40          	push	#64
 655  0005 ae5000        	ldw	x,#20480
 656  0008 cd0000        	call	_GPIO_Init
 658  000b 85            	popw	x
 659                     ; 165 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);		//下降沿触发中断
 661  000c 4f            	clr	a
 662  000d cd0000        	call	_EXTI_SetTLISensitivity
 664                     ; 166 	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOA), EXTI_SENSITIVITY_FALL_ONLY);
 666  0010 ae0002        	ldw	x,#2
 667  0013 4f            	clr	a
 668  0014 95            	ld	xh,a
 669  0015 cd0000        	call	_EXTI_SetExtIntSensitivity
 671                     ; 168 	enableInterrupts();
 674  0018 9a            rim
 676                     ; 169 }
 680  0019 81            	ret
 721                     ; 173 void MPR121_uart_send_until_finish(uint8_t s0, uint8_t s1)
 721                     ; 174 {
 722                     .text:	section	.text,new
 723  0000               _MPR121_uart_send_until_finish:
 727                     ; 175 	BLE_uart.txBuf[1] = s0;
 729  0000 9e            	ld	a,xh
 730  0001 c70025        	ld	_BLE_uart+37,a
 731                     ; 177 	BLE_uart.txCnt = 1;
 733  0004 35010001      	mov	_BLE_uart+1,#1
 734                     ; 178 	BLE_uart.txLen = 2;
 736  0008 35020000      	mov	_BLE_uart,#2
 737                     ; 180 	BLE_UART->DR = s1;
 739  000c 9f            	ld	a,xl
 740  000d c75231        	ld	21041,a
 742  0010               L351:
 743                     ; 182 	while(BLE_uart.txCnt);		//等待发送结束 
 745  0010 725d0001      	tnz	_BLE_uart+1
 746  0014 26fa          	jrne	L351
 747                     ; 184 }
 750  0016 81            	ret
 753                     	switch	.data
 754  001e               L751_longTouchIntervalCnt:
 755  001e 00            	dc.b	0
 810                     ; 193 void MPR121_keyPad_hold_time_count(void)
 810                     ; 194 {
 811                     .text:	section	.text,new
 812  0000               _MPR121_keyPad_hold_time_count:
 814  0000 5203          	subw	sp,#3
 815       00000003      OFST:	set	3
 818                     ; 196 	u8 longTouchKeyNum = 0;	
 820  0002 0f01          	clr	(OFST-2,sp)
 821                     ; 199 	if(mpr121_handle.longTouchKey){				/* 长按等待滑动调光 */
 823  0004 725d0016      	tnz	_mpr121_handle+21
 824  0008 2724          	jreq	L302
 825                     ; 200 		mpr121_handle.longTouchHoldCnt++;
 827  000a 725c0015      	inc	_mpr121_handle+20
 828                     ; 201 		if(mpr121_handle.longTouchHoldCnt >= MPR121_LONG_TOUCH_HOLD_CNT){		/* 等待超时 */
 830  000e c60015        	ld	a,_mpr121_handle+20
 831  0011 a164          	cp	a,#100
 832  0013 2519          	jrult	L302
 833                     ; 202 			mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* 按键LED */
 835  0015 c60016        	ld	a,_mpr121_handle+21
 836  0018 5f            	clrw	x
 837  0019 97            	ld	xl,a
 838  001a 5a            	decw	x
 839  001b 724f000a      	clr	(_mpr121_handle+9,x)
 840                     ; 203 			mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* 滑动LED */
 842  001f c60014        	ld	a,_mpr121_handle+19
 843  0022 4c            	inc	a
 844  0023 c70013        	ld	_mpr121_handle+18,a
 845                     ; 204 			mpr121_handle.longTouchHoldCnt = 0;
 847  0026 725f0015      	clr	_mpr121_handle+20
 848                     ; 205 			mpr121_handle.longTouchKey = 0;
 850  002a 725f0016      	clr	_mpr121_handle+21
 851  002e               L302:
 852                     ; 209 	if(mpr121_handle.longTouchSlipConfirm){			/* 按键功能屏蔽计数 */
 854  002e 725d0017      	tnz	_mpr121_handle+22
 855  0032 2704          	jreq	L702
 856                     ; 210 		mpr121_handle.longTouchHoldCnt++;
 858  0034 725c0015      	inc	_mpr121_handle+20
 859  0038               L702:
 860                     ; 214 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
 862  0038 0f03          	clr	(OFST+0,sp)
 863  003a               L112:
 864                     ; 216 		if((mpr121_handle.keyTouch.byte & BIT[i])){			/* 按键维持时间计数 */
 866  003a 7b03          	ld	a,(OFST+0,sp)
 867  003c 5f            	clrw	x
 868  003d 97            	ld	xl,a
 869  003e d60000        	ld	a,(_BIT,x)
 870  0041 c50018        	bcp	a,_mpr121_handle+23
 871  0044 2708          	jreq	L712
 872                     ; 217 			mpr121_handle.keyHoldCnt[i]++;
 874  0046 7b03          	ld	a,(OFST+0,sp)
 875  0048 5f            	clrw	x
 876  0049 97            	ld	xl,a
 877  004a 724c0001      	inc	(_mpr121_handle,x)
 878  004e               L712:
 879                     ; 220 		if(mpr121_handle.keyWaitCnt[i]){			/* 长按后时间计数 */
 881  004e 7b03          	ld	a,(OFST+0,sp)
 882  0050 5f            	clrw	x
 883  0051 97            	ld	xl,a
 884  0052 724d0004      	tnz	(_mpr121_handle+3,x)
 885  0056 2706          	jreq	L122
 886                     ; 222 			longTouchKeyNum++;
 888  0058 0c01          	inc	(OFST-2,sp)
 889                     ; 223 			j = i;
 891  005a 7b03          	ld	a,(OFST+0,sp)
 892  005c 6b02          	ld	(OFST-1,sp),a
 893  005e               L122:
 894                     ; 226 		if((mpr121_handle.keyLEDStatus[i] == 2) || (mpr121_handle.keyLEDStatus[i] == 3)){			/* led计数  */
 896  005e 7b03          	ld	a,(OFST+0,sp)
 897  0060 5f            	clrw	x
 898  0061 97            	ld	xl,a
 899  0062 d6000a        	ld	a,(_mpr121_handle+9,x)
 900  0065 a102          	cp	a,#2
 901  0067 270b          	jreq	L522
 903  0069 7b03          	ld	a,(OFST+0,sp)
 904  006b 5f            	clrw	x
 905  006c 97            	ld	xl,a
 906  006d d6000a        	ld	a,(_mpr121_handle+9,x)
 907  0070 a103          	cp	a,#3
 908  0072 2608          	jrne	L322
 909  0074               L522:
 910                     ; 227 			mpr121_handle.keyLEDCnt[i]++;
 912  0074 7b03          	ld	a,(OFST+0,sp)
 913  0076 5f            	clrw	x
 914  0077 97            	ld	xl,a
 915  0078 724c0007      	inc	(_mpr121_handle+6,x)
 916  007c               L322:
 917                     ; 214 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
 919  007c 0c03          	inc	(OFST+0,sp)
 922  007e 7b03          	ld	a,(OFST+0,sp)
 923  0080 a103          	cp	a,#3
 924  0082 25b6          	jrult	L112
 925                     ; 232 	if(longTouchKeyNum){				/* 有长按键 */
 927  0084 0d01          	tnz	(OFST-2,sp)
 928  0086 2603          	jrne	L03
 929  0088 cc012c        	jp	L722
 930  008b               L03:
 931                     ; 234 		if(longTouchKeyNum == 1){		/* 只有一个长按键  */
 933  008b 7b01          	ld	a,(OFST-2,sp)
 934  008d a101          	cp	a,#1
 935  008f 2666          	jrne	L132
 936                     ; 235 			longTouchIntervalCnt++;
 938  0091 725c001e      	inc	L751_longTouchIntervalCnt
 939                     ; 236 			if(longTouchIntervalCnt >= MPR121_MULTI_LONG_TOUCH_INTERVAL){  	/* 一个按键维持300ms */
 941  0095 c6001e        	ld	a,L751_longTouchIntervalCnt
 942  0098 a103          	cp	a,#3
 943  009a 25ec          	jrult	L722
 944                     ; 237 				longTouchIntervalCnt = 0;				
 946  009c 725f001e      	clr	L751_longTouchIntervalCnt
 947                     ; 238 				mpr121_handle.keyWaitCnt[j] = 0;	
 949  00a0 7b02          	ld	a,(OFST-1,sp)
 950  00a2 5f            	clrw	x
 951  00a3 97            	ld	xl,a
 952  00a4 724f0004      	clr	(_mpr121_handle+3,x)
 953                     ; 240 				if(mpr121_handle.longTouchKey){			/* 原先还有长按启动功能时，先关闭原先的长按led显示 */
 955  00a8 725d0016      	tnz	_mpr121_handle+21
 956  00ac 270a          	jreq	L532
 957                     ; 241 					mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* 按键LED */
 959  00ae c60016        	ld	a,_mpr121_handle+21
 960  00b1 5f            	clrw	x
 961  00b2 97            	ld	xl,a
 962  00b3 5a            	decw	x
 963  00b4 724f000a      	clr	(_mpr121_handle+9,x)
 964  00b8               L532:
 965                     ; 244 				if(mpr121_handle.keylongTouchSlipLevel[j] == MPR121_LONG_TOUCH_INVALID){		/* 长按启动滑动功能无效 */
 967  00b8 7b02          	ld	a,(OFST-1,sp)
 968  00ba 5f            	clrw	x
 969  00bb 97            	ld	xl,a
 970  00bc d6000d        	ld	a,(_mpr121_handle+12,x)
 971  00bf a10a          	cp	a,#10
 972  00c1 260c          	jrne	L732
 973                     ; 245 					mpr121_handle.longTouchSlipConfirm = j + 1;
 975  00c3 7b02          	ld	a,(OFST-1,sp)
 976  00c5 4c            	inc	a
 977  00c6 c70017        	ld	_mpr121_handle+22,a
 978                     ; 246 					mpr121_handle.longTouchKey = 0;
 980  00c9 725f0016      	clr	_mpr121_handle+21
 982  00cd 2006          	jra	L142
 983  00cf               L732:
 984                     ; 248 					mpr121_handle.longTouchKey = j + 1;				
 986  00cf 7b02          	ld	a,(OFST-1,sp)
 987  00d1 4c            	inc	a
 988  00d2 c70016        	ld	_mpr121_handle+21,a
 989  00d5               L142:
 990                     ; 250 				mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[j] + 1;		/* 滑动LED */
 992  00d5 7b02          	ld	a,(OFST-1,sp)
 993  00d7 5f            	clrw	x
 994  00d8 97            	ld	xl,a
 995  00d9 d6000d        	ld	a,(_mpr121_handle+12,x)
 996  00dc 4c            	inc	a
 997  00dd c70013        	ld	_mpr121_handle+18,a
 998                     ; 251 				mpr121_handle.keyLEDStatus[j] = 3;									/* 按键LED */
1000  00e0 7b02          	ld	a,(OFST-1,sp)
1001  00e2 5f            	clrw	x
1002  00e3 97            	ld	xl,a
1003  00e4 a603          	ld	a,#3
1004  00e6 d7000a        	ld	(_mpr121_handle+9,x),a
1005                     ; 252 				mpr121_handle.keyLEDCnt[j] = 0;
1007  00e9 7b02          	ld	a,(OFST-1,sp)
1008  00eb 5f            	clrw	x
1009  00ec 97            	ld	xl,a
1010  00ed 724f0007      	clr	(_mpr121_handle+6,x)
1011                     ; 253 				mpr121_handle.longTouchHoldCnt = 0;
1013  00f1 725f0015      	clr	_mpr121_handle+20
1014  00f5 2035          	jra	L722
1015  00f7               L132:
1016                     ; 259 			for(i = 0; i < MPR121_KEYPAD_NUMS; i++){			/* 清零 */
1018  00f7 0f03          	clr	(OFST+0,sp)
1019  00f9               L542:
1020                     ; 260 				mpr121_handle.keyWaitCnt[i] = 0;	
1022  00f9 7b03          	ld	a,(OFST+0,sp)
1023  00fb 5f            	clrw	x
1024  00fc 97            	ld	xl,a
1025  00fd 724f0004      	clr	(_mpr121_handle+3,x)
1026                     ; 259 			for(i = 0; i < MPR121_KEYPAD_NUMS; i++){			/* 清零 */
1028  0101 0c03          	inc	(OFST+0,sp)
1031  0103 7b03          	ld	a,(OFST+0,sp)
1032  0105 a103          	cp	a,#3
1033  0107 25f0          	jrult	L542
1034                     ; 262 			if(mpr121_handle.longTouchKey){ 			/* 原先还有长按启动功能时，先关闭原先的长按led显示 */
1036  0109 725d0016      	tnz	_mpr121_handle+21
1037  010d 2711          	jreq	L352
1038                     ; 263 				mpr121_handle.keyLEDStatus[mpr121_handle.longTouchKey -1] = 0;	/* 按键LED */			
1040  010f c60016        	ld	a,_mpr121_handle+21
1041  0112 5f            	clrw	x
1042  0113 97            	ld	xl,a
1043  0114 5a            	decw	x
1044  0115 724f000a      	clr	(_mpr121_handle+9,x)
1045                     ; 264 				mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* 滑动LED */
1047  0119 c60014        	ld	a,_mpr121_handle+19
1048  011c 4c            	inc	a
1049  011d c70013        	ld	_mpr121_handle+18,a
1050  0120               L352:
1051                     ; 266 			mpr121_handle.longTouchKey = 0;
1053  0120 725f0016      	clr	_mpr121_handle+21
1054                     ; 267 			mpr121_handle.longTouchHoldCnt = 0;
1056  0124 725f0015      	clr	_mpr121_handle+20
1057                     ; 268 			longTouchIntervalCnt = 0;
1059  0128 725f001e      	clr	L751_longTouchIntervalCnt
1060  012c               L722:
1061                     ; 274 }
1064  012c 5b03          	addw	sp,#3
1065  012e 81            	ret
1118                     ; 279 void MPR121_keyPad_slipPad_post_data(u8 cmd, u8 key, u8 value)
1118                     ; 280 {
1119                     .text:	section	.text,new
1120  0000               _MPR121_keyPad_slipPad_post_data:
1122  0000 89            	pushw	x
1123       00000000      OFST:	set	0
1126                     ; 282 	BLE_uart.txBuf[0] = 0xEE;
1128  0001 35ee0024      	mov	_BLE_uart+36,#238
1129                     ; 283 	BLE_uart.txBuf[1] = 0xEE;
1131  0005 35ee0025      	mov	_BLE_uart+37,#238
1132                     ; 284 	BLE_uart.txBuf[2] = sicp_get_message_id();
1134  0009 cd0000        	call	_sicp_get_message_id
1136  000c c70026        	ld	_BLE_uart+38,a
1137                     ; 285 	BLE_uart.txBuf[3] = ns_host_meshid_H;
1139  000f 5500000027    	mov	_BLE_uart+39,_ns_host_meshid_H
1140                     ; 286 	BLE_uart.txBuf[4] = ns_host_meshid_L;
1142  0014 5500000028    	mov	_BLE_uart+40,_ns_host_meshid_L
1143                     ; 287 	BLE_uart.txBuf[5] = 7;
1145  0019 35070029      	mov	_BLE_uart+41,#7
1146                     ; 288 	BLE_uart.txBuf[6] = cmd;
1148  001d 7b01          	ld	a,(OFST+1,sp)
1149  001f c7002a        	ld	_BLE_uart+42,a
1150                     ; 289 	BLE_uart.txBuf[7] = key;
1152  0022 7b02          	ld	a,(OFST+2,sp)
1153  0024 c7002b        	ld	_BLE_uart+43,a
1154                     ; 290 	BLE_uart.txBuf[8] = value;
1156  0027 7b05          	ld	a,(OFST+5,sp)
1157  0029 c7002c        	ld	_BLE_uart+44,a
1158                     ; 292 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
1160  002c 4b07          	push	#7
1161  002e ae0026        	ldw	x,#_BLE_uart+38
1162  0031 cd0000        	call	_Check_Sum
1164  0034 5b01          	addw	sp,#1
1165  0036 c7002d        	ld	_BLE_uart+45,a
1166                     ; 294 	BLE_uart_send_until_finish();
1168  0039 cd0000        	call	_BLE_uart_send_until_finish
1170                     ; 296 }
1173  003c 85            	popw	x
1174  003d 81            	ret
1210                     ; 302 void MPR121_slipPad_or_longTouch_value_save(u8 which)
1210                     ; 303 {
1211                     .text:	section	.text,new
1212  0000               _MPR121_slipPad_or_longTouch_value_save:
1214  0000 88            	push	a
1215       00000000      OFST:	set	0
1218                     ; 304 	if(which == 0){
1220  0001 4d            	tnz	a
1221  0002 260c          	jrne	L113
1222                     ; 305 		MEEPROM_WriteByte(EEPROM_NOKEY_SLIPPAD_VALUE, mpr121_handle.slipLevel);
1224  0004 3b0014        	push	_mpr121_handle+19
1225  0007 ae0072        	ldw	x,#114
1226  000a cd0000        	call	_MEEPROM_WriteByte
1228  000d 84            	pop	a
1230  000e 2015          	jra	L313
1231  0010               L113:
1232                     ; 307 		which--;
1234  0010 0a01          	dec	(OFST+1,sp)
1235                     ; 308 		MEEPROM_WriteByte(EEPROM_KEY1_SLIPPAD_VALUE + which, mpr121_handle.keylongTouchSlipLevel[which]);
1237  0012 7b01          	ld	a,(OFST+1,sp)
1238  0014 5f            	clrw	x
1239  0015 97            	ld	xl,a
1240  0016 d6000d        	ld	a,(_mpr121_handle+12,x)
1241  0019 88            	push	a
1242  001a 7b02          	ld	a,(OFST+2,sp)
1243  001c 5f            	clrw	x
1244  001d 97            	ld	xl,a
1245  001e 1c0073        	addw	x,#115
1246  0021 cd0000        	call	_MEEPROM_WriteByte
1248  0024 84            	pop	a
1249  0025               L313:
1250                     ; 310 }
1253  0025 84            	pop	a
1254  0026 81            	ret
1298                     ; 315 void MPR121_keyPad_slipPad_post(void)
1298                     ; 316 {
1299                     .text:	section	.text,new
1300  0000               _MPR121_keyPad_slipPad_post:
1302  0000 89            	pushw	x
1303       00000002      OFST:	set	2
1306                     ; 317 	u8	level = 0;
1308  0001 7b01          	ld	a,(OFST-1,sp)
1309  0003 97            	ld	xl,a
1310                     ; 318 	u8	which = 0;
1312  0004 7b02          	ld	a,(OFST+0,sp)
1313  0006 97            	ld	xl,a
1314                     ; 321 	if(mpr121_handle.keyComfirm){
1316  0007 725d001a      	tnz	_mpr121_handle+25
1317  000b 2716          	jreq	L333
1318                     ; 323 		MPR121_keyPad_slipPad_post_data(0x35, mpr121_handle.keyComfirm, mpr121_handle.keyValue);
1320  000d 3b001b        	push	_mpr121_handle+26
1321  0010 c6001a        	ld	a,_mpr121_handle+25
1322  0013 97            	ld	xl,a
1323  0014 a635          	ld	a,#53
1324  0016 95            	ld	xh,a
1325  0017 cd0000        	call	_MPR121_keyPad_slipPad_post_data
1327  001a 84            	pop	a
1328                     ; 325 		mpr121_handle.keyComfirm = 0;
1330  001b 725f001a      	clr	_mpr121_handle+25
1331                     ; 326 		mpr121_handle.keyValue = 0;
1333  001f 725f001b      	clr	_mpr121_handle+26
1334  0023               L333:
1335                     ; 331 	if(mpr121_handle.slipConfirm){
1337  0023 725d0012      	tnz	_mpr121_handle+17
1338  0027 2749          	jreq	L533
1339                     ; 333 		if(mpr121_handle.slipConfirm == 0xff){			
1341  0029 c60012        	ld	a,_mpr121_handle+17
1342  002c a1ff          	cp	a,#255
1343  002e 260d          	jrne	L733
1344                     ; 334 			mpr121_handle.slipConfirm = 0;					
1346  0030 725f0012      	clr	_mpr121_handle+17
1347                     ; 335 			level = mpr121_handle.slipLevel;
1349  0034 c60014        	ld	a,_mpr121_handle+19
1350  0037 6b01          	ld	(OFST-1,sp),a
1351                     ; 336 			which = 0;
1353  0039 0f02          	clr	(OFST+0,sp)
1355  003b 201e          	jra	L143
1356  003d               L733:
1357                     ; 338 			which = mpr121_handle.slipConfirm;
1359  003d c60012        	ld	a,_mpr121_handle+17
1360  0040 6b02          	ld	(OFST+0,sp),a
1361                     ; 339 			mpr121_handle.slipConfirm--;
1363  0042 725a0012      	dec	_mpr121_handle+17
1364                     ; 340 			level = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.slipConfirm];
1366  0046 c60012        	ld	a,_mpr121_handle+17
1367  0049 5f            	clrw	x
1368  004a 97            	ld	xl,a
1369  004b d6000d        	ld	a,(_mpr121_handle+12,x)
1370  004e 6b01          	ld	(OFST-1,sp),a
1371                     ; 341 			mpr121_handle.slipConfirm = BIT[mpr121_handle.slipConfirm];
1373  0050 c60012        	ld	a,_mpr121_handle+17
1374  0053 5f            	clrw	x
1375  0054 97            	ld	xl,a
1376  0055 d60000        	ld	a,(_BIT,x)
1377  0058 c70012        	ld	_mpr121_handle+17,a
1378  005b               L143:
1379                     ; 343 		MPR121_keyPad_slipPad_post_data(0x36, mpr121_handle.slipConfirm, level);
1381  005b 7b01          	ld	a,(OFST-1,sp)
1382  005d 88            	push	a
1383  005e c60012        	ld	a,_mpr121_handle+17
1384  0061 97            	ld	xl,a
1385  0062 a636          	ld	a,#54
1386  0064 95            	ld	xh,a
1387  0065 cd0000        	call	_MPR121_keyPad_slipPad_post_data
1389  0068 84            	pop	a
1390                     ; 344 		mpr121_handle.slipConfirm = 0;
1392  0069 725f0012      	clr	_mpr121_handle+17
1393                     ; 346 		MPR121_slipPad_or_longTouch_value_save(which);		/* 等发送完成后再进行保存 */			
1395  006d 7b02          	ld	a,(OFST+0,sp)
1396  006f cd0000        	call	_MPR121_slipPad_or_longTouch_value_save
1398  0072               L533:
1399                     ; 349 }
1402  0072 85            	popw	x
1403  0073 81            	ret
1452                     ; 355 void MPR121_slipPad_level_analyze(u8 slipPad)
1452                     ; 356 {
1453                     .text:	section	.text,new
1454  0000               _MPR121_slipPad_level_analyze:
1456  0000 88            	push	a
1457  0001 89            	pushw	x
1458       00000002      OFST:	set	2
1461                     ; 359 	num = 0;
1463  0002 0f01          	clr	(OFST-1,sp)
1464                     ; 362 	for(i = 0; i < MPR121_SLIPPAD_NUMS; i++){
1466  0004 0f02          	clr	(OFST+0,sp)
1467  0006               L363:
1468                     ; 363 		if((slipPad & BIT[i])){
1470  0006 7b02          	ld	a,(OFST+0,sp)
1471  0008 5f            	clrw	x
1472  0009 97            	ld	xl,a
1473  000a d60000        	ld	a,(_BIT,x)
1474  000d 1503          	bcp	a,(OFST+1,sp)
1475  000f 2702          	jreq	L173
1476                     ; 364 			num++;
1478  0011 0c01          	inc	(OFST-1,sp)
1479  0013               L173:
1480                     ; 362 	for(i = 0; i < MPR121_SLIPPAD_NUMS; i++){
1482  0013 0c02          	inc	(OFST+0,sp)
1485  0015 7b02          	ld	a,(OFST+0,sp)
1486  0017 a105          	cp	a,#5
1487  0019 25eb          	jrult	L363
1488                     ; 368 	if(num >= 3){			/* 有3个按键或以上 */
1490  001b 7b01          	ld	a,(OFST-1,sp)
1491  001d a103          	cp	a,#3
1492  001f 2521          	jrult	L373
1493                     ; 369 		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){			
1495  0021 a605          	ld	a,#5
1496  0023 6b02          	ld	(OFST+0,sp),a
1497  0025               L573:
1498                     ; 370 			if((slipPad & BIT[i -1])){		
1500  0025 7b02          	ld	a,(OFST+0,sp)
1501  0027 5f            	clrw	x
1502  0028 97            	ld	xl,a
1503  0029 5a            	decw	x
1504  002a d60000        	ld	a,(_BIT,x)
1505  002d 1503          	bcp	a,(OFST+1,sp)
1506  002f 2709          	jreq	L304
1507                     ; 371 				mpr121_handle.slipValue = ((i -1) * 2) + 1;
1509  0031 7b02          	ld	a,(OFST+0,sp)
1510  0033 48            	sll	a
1511  0034 4a            	dec	a
1512  0035 c70013        	ld	_mpr121_handle+18,a
1513                     ; 372 				break;
1515  0038 204e          	jra	L504
1516  003a               L304:
1517                     ; 369 		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){			
1519  003a 0a02          	dec	(OFST+0,sp)
1522  003c 0d02          	tnz	(OFST+0,sp)
1523  003e 26e5          	jrne	L573
1524  0040 2046          	jra	L504
1525  0042               L373:
1526                     ; 376 	else if(num > 0){		/* 1、2个按键*/
1528  0042 0d01          	tnz	(OFST-1,sp)
1529  0044 2742          	jreq	L504
1530                     ; 378 		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){
1532  0046 a605          	ld	a,#5
1533  0048 6b02          	ld	(OFST+0,sp),a
1534  004a               L114:
1535                     ; 379 			if((slipPad & BIT[i -1])){	
1537  004a 7b02          	ld	a,(OFST+0,sp)
1538  004c 5f            	clrw	x
1539  004d 97            	ld	xl,a
1540  004e 5a            	decw	x
1541  004f d60000        	ld	a,(_BIT,x)
1542  0052 1503          	bcp	a,(OFST+1,sp)
1543  0054 272c          	jreq	L714
1544                     ; 380 				if(i > 1){			/* 不是最底下的一个按键 */
1546  0056 7b02          	ld	a,(OFST+0,sp)
1547  0058 a102          	cp	a,#2
1548  005a 2520          	jrult	L124
1549                     ; 381 					if((slipPad & BIT[i -2])){	/* 有两个相邻的按键同时按下，去中间的值 */
1551  005c 7b02          	ld	a,(OFST+0,sp)
1552  005e 5f            	clrw	x
1553  005f 97            	ld	xl,a
1554  0060 5a            	decw	x
1555  0061 5a            	decw	x
1556  0062 d60000        	ld	a,(_BIT,x)
1557  0065 1503          	bcp	a,(OFST+1,sp)
1558  0067 270a          	jreq	L324
1559                     ; 382 						mpr121_handle.slipValue = (i -1) * 2;
1561  0069 7b02          	ld	a,(OFST+0,sp)
1562  006b 48            	sll	a
1563  006c a002          	sub	a,#2
1564  006e c70013        	ld	_mpr121_handle+18,a
1566  0071 2015          	jra	L504
1567  0073               L324:
1568                     ; 384 						mpr121_handle.slipValue = ((i -1) * 2) + 1;
1570  0073 7b02          	ld	a,(OFST+0,sp)
1571  0075 48            	sll	a
1572  0076 4a            	dec	a
1573  0077 c70013        	ld	_mpr121_handle+18,a
1574  007a 200c          	jra	L504
1575  007c               L124:
1576                     ; 387 					mpr121_handle.slipValue = 1;
1578  007c 35010013      	mov	_mpr121_handle+18,#1
1579  0080 2006          	jra	L504
1580  0082               L714:
1581                     ; 378 		for(i = MPR121_SLIPPAD_NUMS; i > 0; i--){
1583  0082 0a02          	dec	(OFST+0,sp)
1586  0084 0d02          	tnz	(OFST+0,sp)
1587  0086 26c2          	jrne	L114
1588  0088               L504:
1589                     ; 397 }
1592  0088 5b03          	addw	sp,#3
1593  008a 81            	ret
1629                     ; 402 void MPR121_analyze(void)
1629                     ; 403 {
1630                     .text:	section	.text,new
1631  0000               _MPR121_analyze:
1633  0000 88            	push	a
1634       00000001      OFST:	set	1
1637                     ; 407 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
1639  0001 0f01          	clr	(OFST+0,sp)
1640  0003               L744:
1641                     ; 409 		if((mpr121_handle.keyTouch.byte & BIT[i] ) && ((mpr121_handle.keyRelease & BIT[i]) == 0)){	/* 按键开始按压 */ /* 注意括号 */
1643  0003 7b01          	ld	a,(OFST+0,sp)
1644  0005 5f            	clrw	x
1645  0006 97            	ld	xl,a
1646  0007 d60000        	ld	a,(_BIT,x)
1647  000a c50018        	bcp	a,_mpr121_handle+23
1648  000d 2731          	jreq	L554
1650  000f 7b01          	ld	a,(OFST+0,sp)
1651  0011 5f            	clrw	x
1652  0012 97            	ld	xl,a
1653  0013 d60000        	ld	a,(_BIT,x)
1654  0016 c50019        	bcp	a,_mpr121_handle+24
1655  0019 2625          	jrne	L554
1656                     ; 410 			if(mpr121_handle.longTouchSlipConfirm == 0){			/* 按键功能没有屏蔽 */
1658  001b 725d0017      	tnz	_mpr121_handle+22
1659  001f 260d          	jrne	L754
1660                     ; 411 				mpr121_handle.keyLEDStatus[i] = 1;
1662  0021 7b01          	ld	a,(OFST+0,sp)
1663  0023 5f            	clrw	x
1664  0024 97            	ld	xl,a
1665  0025 a601          	ld	a,#1
1666  0027 d7000a        	ld	(_mpr121_handle+9,x),a
1668  002a ace600e6      	jpf	L364
1669  002e               L754:
1670                     ; 413 				mpr121_handle.keyTouch.byte &= ~BIT[i];			/* 取消 */
1672  002e 7b01          	ld	a,(OFST+0,sp)
1673  0030 5f            	clrw	x
1674  0031 97            	ld	xl,a
1675  0032 d60000        	ld	a,(_BIT,x)
1676  0035 43            	cpl	a
1677  0036 c40018        	and	a,_mpr121_handle+23
1678  0039 c70018        	ld	_mpr121_handle+23,a
1679  003c ace600e6      	jpf	L364
1680  0040               L554:
1681                     ; 416 		else if(((mpr121_handle.keyTouch.byte & BIT[i]) == 0) && (mpr121_handle.keyRelease & BIT[i])){	/* 按键释放 */ /* 注意括号 */
1683  0040 7b01          	ld	a,(OFST+0,sp)
1684  0042 5f            	clrw	x
1685  0043 97            	ld	xl,a
1686  0044 d60000        	ld	a,(_BIT,x)
1687  0047 c50018        	bcp	a,_mpr121_handle+23
1688  004a 2703          	jreq	L44
1689  004c cc00e6        	jp	L364
1690  004f               L44:
1692  004f 7b01          	ld	a,(OFST+0,sp)
1693  0051 5f            	clrw	x
1694  0052 97            	ld	xl,a
1695  0053 d60000        	ld	a,(_BIT,x)
1696  0056 c50019        	bcp	a,_mpr121_handle+24
1697  0059 27f1          	jreq	L364
1698                     ; 418 			if(mpr121_handle.longTouchSlipConfirm == 0){			/* 按键功能没有屏蔽 */
1700  005b 725d0017      	tnz	_mpr121_handle+22
1701  005f 2662          	jrne	L764
1702                     ; 420 				mpr121_handle.keyComfirm |= BIT[i];
1704  0061 7b01          	ld	a,(OFST+0,sp)
1705  0063 5f            	clrw	x
1706  0064 97            	ld	xl,a
1707  0065 c6001a        	ld	a,_mpr121_handle+25
1708  0068 da0000        	or	a,(_BIT,x)
1709  006b c7001a        	ld	_mpr121_handle+25,a
1710                     ; 422 				if(mpr121_handle.keyHoldCnt[i] < MPR121_KEYPAD_HOLD_CNT){	/* 短按 */	
1712  006e 7b01          	ld	a,(OFST+0,sp)
1713  0070 5f            	clrw	x
1714  0071 97            	ld	xl,a
1715  0072 d60001        	ld	a,(_mpr121_handle,x)
1716  0075 a114          	cp	a,#20
1717  0077 242e          	jruge	L174
1718                     ; 423 					mpr121_handle.keyValue |= BIT[i];
1720  0079 7b01          	ld	a,(OFST+0,sp)
1721  007b 5f            	clrw	x
1722  007c 97            	ld	xl,a
1723  007d c6001b        	ld	a,_mpr121_handle+26
1724  0080 da0000        	or	a,(_BIT,x)
1725  0083 c7001b        	ld	_mpr121_handle+26,a
1726                     ; 425 					if(mpr121_handle.longTouchKey == i + 1){ 			/* 该按键正在启动滑动功能，则取消该功能 */				
1728  0086 c60016        	ld	a,_mpr121_handle+21
1729  0089 5f            	clrw	x
1730  008a 97            	ld	xl,a
1731  008b 7b01          	ld	a,(OFST+0,sp)
1732  008d 905f          	clrw	y
1733  008f 9097          	ld	yl,a
1734  0091 905c          	incw	y
1735  0093 bf01          	ldw	c_x+1,x
1736  0095 90b301        	cpw	y,c_x+1
1737  0098 2616          	jrne	L574
1738                     ; 426 						mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;			/* 滑动LED */
1740  009a c60014        	ld	a,_mpr121_handle+19
1741  009d 4c            	inc	a
1742  009e c70013        	ld	_mpr121_handle+18,a
1743                     ; 427 						mpr121_handle.longTouchKey = 0; 	
1745  00a1 725f0016      	clr	_mpr121_handle+21
1746  00a5 2009          	jra	L574
1747  00a7               L174:
1748                     ; 430 					mpr121_handle.keyWaitCnt[i] = 1;		/* 长按计数开始 */
1750  00a7 7b01          	ld	a,(OFST+0,sp)
1751  00a9 5f            	clrw	x
1752  00aa 97            	ld	xl,a
1753  00ab a601          	ld	a,#1
1754  00ad d70004        	ld	(_mpr121_handle+3,x),a
1755  00b0               L574:
1756                     ; 433 				mpr121_handle.keyLEDStatus[i] = 2;			/* 按键LED */
1758  00b0 7b01          	ld	a,(OFST+0,sp)
1759  00b2 5f            	clrw	x
1760  00b3 97            	ld	xl,a
1761  00b4 a602          	ld	a,#2
1762  00b6 d7000a        	ld	(_mpr121_handle+9,x),a
1763                     ; 434 				mpr121_handle.keyLEDCnt[i] = 0;
1765  00b9 7b01          	ld	a,(OFST+0,sp)
1766  00bb 5f            	clrw	x
1767  00bc 97            	ld	xl,a
1768  00bd 724f0007      	clr	(_mpr121_handle+6,x)
1770  00c1 201b          	jra	L774
1771  00c3               L764:
1772                     ; 437 				if((mpr121_handle.longTouchSlipConfirm -1) != i){					
1774  00c3 c60017        	ld	a,_mpr121_handle+22
1775  00c6 5f            	clrw	x
1776  00c7 97            	ld	xl,a
1777  00c8 5a            	decw	x
1778  00c9 7b01          	ld	a,(OFST+0,sp)
1779  00cb 905f          	clrw	y
1780  00cd 9097          	ld	yl,a
1781  00cf 90bf01        	ldw	c_y+1,y
1782  00d2 b301          	cpw	x,c_y+1
1783  00d4 2708          	jreq	L774
1784                     ; 438 					mpr121_handle.keyLEDStatus[i] = 0;			/* */
1786  00d6 7b01          	ld	a,(OFST+0,sp)
1787  00d8 5f            	clrw	x
1788  00d9 97            	ld	xl,a
1789  00da 724f000a      	clr	(_mpr121_handle+9,x)
1790  00de               L774:
1791                     ; 442 			mpr121_handle.keyHoldCnt[i] = 0;
1793  00de 7b01          	ld	a,(OFST+0,sp)
1794  00e0 5f            	clrw	x
1795  00e1 97            	ld	xl,a
1796  00e2 724f0001      	clr	(_mpr121_handle,x)
1798  00e6               L364:
1799                     ; 407 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
1801  00e6 0c01          	inc	(OFST+0,sp)
1804  00e8 7b01          	ld	a,(OFST+0,sp)
1805  00ea a103          	cp	a,#3
1806  00ec 2403          	jruge	L64
1807  00ee cc0003        	jp	L744
1808  00f1               L64:
1809                     ; 450 	mpr121_handle.keyRelease = mpr121_handle.keyTouch.byte;
1811  00f1 5500180019    	mov	_mpr121_handle+24,_mpr121_handle+23
1812                     ; 453 	if((mpr121_handle.slipTouch.byte == 0) && (mpr121_handle.slipRelease != 0)){		/* 滑动释放 */
1814  00f6 725d0010      	tnz	_mpr121_handle+15
1815  00fa 265b          	jrne	L505
1817  00fc 725d0011      	tnz	_mpr121_handle+16
1818  0100 2755          	jreq	L505
1819                     ; 454 		MPR121_slipPad_level_analyze(mpr121_handle.slipRelease);
1821  0102 c60011        	ld	a,_mpr121_handle+16
1822  0105 cd0000        	call	_MPR121_slipPad_level_analyze
1824                     ; 456 		if((mpr121_handle.slipValue < 1) || (mpr121_handle.slipValue > 9)){
1826  0108 725d0013      	tnz	_mpr121_handle+18
1827  010c 2707          	jreq	L115
1829  010e c60013        	ld	a,_mpr121_handle+18
1830  0111 a10a          	cp	a,#10
1831  0113 2504          	jrult	L705
1832  0115               L115:
1833                     ; 457 			mpr121_handle.slipValue = 1;
1835  0115 35010013      	mov	_mpr121_handle+18,#1
1836  0119               L705:
1837                     ; 460 		if(mpr121_handle.longTouchKey){			/* 有长按功能 */
1839  0119 725d0016      	tnz	_mpr121_handle+21
1840  011d 272b          	jreq	L315
1841                     ; 461 			mpr121_handle.slipConfirm = mpr121_handle.longTouchKey;
1843  011f 5500160012    	mov	_mpr121_handle+17,_mpr121_handle+21
1844                     ; 462 			mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchKey -1] = mpr121_handle.slipValue -1;
1846  0124 c60016        	ld	a,_mpr121_handle+21
1847  0127 5f            	clrw	x
1848  0128 97            	ld	xl,a
1849  0129 5a            	decw	x
1850  012a c60013        	ld	a,_mpr121_handle+18
1851  012d 4a            	dec	a
1852  012e d7000d        	ld	(_mpr121_handle+12,x),a
1853                     ; 466 			mpr121_handle.keyLEDCnt[mpr121_handle.longTouchKey -1] = 0;			/* 重新开始先灭再亮，与滑动LED保持一致 */
1855  0131 c60016        	ld	a,_mpr121_handle+21
1856  0134 5f            	clrw	x
1857  0135 97            	ld	xl,a
1858  0136 5a            	decw	x
1859  0137 724f0007      	clr	(_mpr121_handle+6,x)
1860                     ; 467 			mpr121_handle.longTouchSlipConfirm = mpr121_handle.longTouchKey;
1862  013b 5500160017    	mov	_mpr121_handle+22,_mpr121_handle+21
1863                     ; 468 			mpr121_handle.longTouchHoldCnt = 0;
1865  0140 725f0015      	clr	_mpr121_handle+20
1866                     ; 469 			mpr121_handle.longTouchKey = 0;
1868  0144 725f0016      	clr	_mpr121_handle+21
1870  0148 2019          	jra	L715
1871  014a               L315:
1872                     ; 471 			mpr121_handle.slipConfirm = 0xff;
1874  014a 35ff0012      	mov	_mpr121_handle+17,#255
1875                     ; 472 			mpr121_handle.slipLevel = mpr121_handle.slipValue -1;
1877  014e c60013        	ld	a,_mpr121_handle+18
1878  0151 4a            	dec	a
1879  0152 c70014        	ld	_mpr121_handle+19,a
1880  0155 200c          	jra	L715
1881  0157               L505:
1882                     ; 475 		if(mpr121_handle.slipTouch.byte){			/* 正在滑动 */
1884  0157 725d0010      	tnz	_mpr121_handle+15
1885  015b 2706          	jreq	L715
1886                     ; 476 			MPR121_slipPad_level_analyze(mpr121_handle.slipTouch.byte);
1888  015d c60010        	ld	a,_mpr121_handle+15
1889  0160 cd0000        	call	_MPR121_slipPad_level_analyze
1891  0163               L715:
1892                     ; 479 	mpr121_handle.slipRelease = mpr121_handle.slipTouch.byte;
1894  0163 5500100011    	mov	_mpr121_handle+16,_mpr121_handle+15
1895                     ; 481 	MPR121_keyPad_slipPad_post();
1897  0168 cd0000        	call	_MPR121_keyPad_slipPad_post
1899                     ; 483 }
1902  016b 84            	pop	a
1903  016c 81            	ret
1930                     ; 489 void MPR121_detect(void)
1930                     ; 490 {	
1931                     .text:	section	.text,new
1932  0000               _MPR121_detect:
1936                     ; 491 	if(MPR121_ISR_FLAG){			/* 有按键中断 */
1938  0000 725d0000      	tnz	_MPR121_ISR_FLAG
1939  0004 2752          	jreq	L335
1940                     ; 493 		MPR121_ISR_FLAG = 0;
1942  0006 725f0000      	clr	_MPR121_ISR_FLAG
1943                     ; 495 		mpr121_handle.ts0.byte = 0;
1945  000a 725f001c      	clr	_mpr121_handle+27
1946                     ; 496 		mpr121_handle.ts1.byte = 0;
1948  000e 725f001d      	clr	_mpr121_handle+28
1949                     ; 498 		if(MPR121_ReadDataByte(ELE_TOUCH_STATUS1, &mpr121_handle.ts1.byte)){
1951  0012 ae001d        	ldw	x,#_mpr121_handle+28
1952  0015 89            	pushw	x
1953  0016 a601          	ld	a,#1
1954  0018 cd0000        	call	_MPR121_ReadDataByte
1956  001b 85            	popw	x
1957  001c 4d            	tnz	a
1958  001d 2739          	jreq	L335
1959                     ; 500 			if(mpr121_handle.ts1.bit.ovcf){			/* over current was detected on REXT pin */
1961  001f c6001d        	ld	a,_mpr121_handle+28
1962  0022 a580          	bcp	a,#128
1963  0024 2632          	jrne	L335
1965                     ; 504 				if(MPR121_ReadDataByte(ELE_TOUCH_STATUS0, &mpr121_handle.ts0.byte)){
1967  0026 ae001c        	ldw	x,#_mpr121_handle+27
1968  0029 89            	pushw	x
1969  002a 4f            	clr	a
1970  002b cd0000        	call	_MPR121_ReadDataByte
1972  002e 85            	popw	x
1973  002f 4d            	tnz	a
1974  0030 2726          	jreq	L335
1975                     ; 510 						mpr121_handle.keyTouch.bit.keyPad0 = mpr121_handle.ts1.bit.ele11;
1977                     	btst		_mpr121_handle+28,#3
1978  0037 90110018      	bccm	_mpr121_handle+23,#0
1979                     ; 511 						mpr121_handle.keyTouch.bit.keyPad1 = mpr121_handle.ts1.bit.ele10;
1981                     	btst		_mpr121_handle+28,#2
1982  0040 90130018      	bccm	_mpr121_handle+23,#1
1983                     ; 512 						mpr121_handle.keyTouch.bit.keyPad2 = mpr121_handle.ts1.bit.ele9;
1985                     	btst		_mpr121_handle+28,#1
1986  0049 90150018      	bccm	_mpr121_handle+23,#2
1987                     ; 514 						mpr121_handle.slipTouch.byte = mpr121_handle.ts0.byte & 0x1f;
1989  004d c6001c        	ld	a,_mpr121_handle+27
1990  0050 a41f          	and	a,#31
1991  0052 c70010        	ld	_mpr121_handle+15,a
1992                     ; 518 						MPR121_analyze();
1994  0055 cd0000        	call	_MPR121_analyze
1996  0058               L335:
1997                     ; 529 }
2000  0058 81            	ret
2647                     	xdef	_MPR121_analyze
2648                     	xdef	_MPR121_slipPad_level_analyze
2649                     	xdef	_MPR121_keyPad_slipPad_post_data
2650                     	xdef	_MPR121_uart_send_until_finish
2651                     	xref	_MEEPROM_WriteByte
2652                     	xref	_sicp_get_message_id
2653                     	xref	_BIT
2654                     	xref	_BLE_uart_send_until_finish
2655                     	xref	_Check_Sum
2656                     	xref	_BLE_uart
2657                     	xref	_ns_host_meshid_L
2658                     	xref	_ns_host_meshid_H
2659                     	xdef	_MPR121_detect
2660                     	xdef	_MPR121_keyPad_slipPad_post
2661                     	xdef	_MPR121_keyPad_hold_time_count
2662                     	xdef	_MPR121_slipPad_or_longTouch_value_save
2663                     	xdef	_MPR121_exti_config
2664                     	xdef	_MPR121_init
2665                     	xdef	_MPR121_ReadDataBlock
2666                     	xdef	_MPR121_ReadDataByte
2667                     	xdef	_MPR121_WriteDataByte
2668                     	xdef	_mpr121_handle
2669                     	xdef	_MPR121_ISR_FLAG
2670                     	xref	_I2C_WriteReadBytes
2671                     	xref	_I2C_WriteBytes
2672                     	xref	_GPIO_Init
2673                     	xref	_EXTI_SetTLISensitivity
2674                     	xref	_EXTI_SetExtIntSensitivity
2675                     	xref.b	c_x
2676                     	xref.b	c_y
2695                     	end
