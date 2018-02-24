   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 145                     	switch	.data
 146  0000               _GESTURE_ISR_FLAG:
 147  0000 00            	dc.b	0
 148  0001               _APDS9960_Light:
 149  0001 0000          	dc.w	0
 150  0003 000000000000  	ds.b	6
 151  0009               _BIT:
 152  0009 01            	dc.b	1
 153  000a 02            	dc.b	2
 154  000b 04            	dc.b	4
 155  000c 08            	dc.b	8
 156  000d 10            	dc.b	16
 157  000e 20            	dc.b	32
 158  000f 40            	dc.b	64
 159  0010 80            	dc.b	128
 160  0011               _DIR_DATA:
 161  0011 00            	dc.b	0
 162  0012 0e            	dc.b	14
 163  0013 0f            	dc.b	15
 164  0014 0c            	dc.b	12
 165  0015 0d            	dc.b	13
 166  0016 01            	dc.b	1
 167  0017 02            	dc.b	2
 168  0018 03            	dc.b	3
 217                     .const:	section	.text
 218  0000               L6:
 219  0000 00004000      	dc.l	16384
 220                     ; 85 void MEEPROM_WriteByte(u16 dLocal_Addr, u8 dLocal_Data)
 220                     ; 86 {
 221                     	scross	off
 222                     .text:	section	.text,new
 223  0000               _MEEPROM_WriteByte:
 225  0000 89            	pushw	x
 226       00000000      OFST:	set	0
 229                     ; 87    FLASH_Unlock(FLASH_MEMTYPE_DATA);
 231  0001 a601          	ld	a,#1
 232  0003 cd0000        	call	_FLASH_Unlock
 235  0006               L321:
 236                     ; 88    while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
 238  0006 a608          	ld	a,#8
 239  0008 cd0000        	call	_FLASH_GetFlagStatus
 241  000b 4d            	tnz	a
 242  000c 27f8          	jreq	L321
 243                     ; 90    FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr, dLocal_Data);
 245  000e 7b05          	ld	a,(OFST+5,sp)
 246  0010 88            	push	a
 247  0011 1e02          	ldw	x,(OFST+2,sp)
 248  0013 cd0000        	call	c_uitolx
 250  0016 ae0000        	ldw	x,#L6
 251  0019 cd0000        	call	c_ladd
 253  001c be02          	ldw	x,c_lreg+2
 254  001e 89            	pushw	x
 255  001f be00          	ldw	x,c_lreg
 256  0021 89            	pushw	x
 257  0022 cd0000        	call	_FLASH_ProgramByte
 259  0025 5b05          	addw	sp,#5
 260                     ; 91    FLASH_Lock(FLASH_MEMTYPE_DATA);
 262  0027 a601          	ld	a,#1
 263  0029 cd0000        	call	_FLASH_Lock
 265                     ; 93 }
 268  002c 85            	popw	x
 269  002d 81            	ret
 309                     ; 99  u8 MEEPROM_ReadByte(u16 dLocal_Addr)
 309                     ; 100  {
 310                     .text:	section	.text,new
 311  0000               _MEEPROM_ReadByte:
 313  0000 88            	push	a
 314       00000001      OFST:	set	1
 317                     ; 102 	 dLocal_1 = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + dLocal_Addr);
 319  0001 cd0000        	call	c_uitolx
 321  0004 ae0000        	ldw	x,#L6
 322  0007 cd0000        	call	c_ladd
 324  000a be02          	ldw	x,c_lreg+2
 325  000c 89            	pushw	x
 326  000d be00          	ldw	x,c_lreg
 327  000f 89            	pushw	x
 328  0010 cd0000        	call	_FLASH_ReadByte
 330  0013 5b04          	addw	sp,#4
 331  0015 6b01          	ld	(OFST+0,sp),a
 332                     ; 103 	 return dLocal_1;
 334  0017 7b01          	ld	a,(OFST+0,sp)
 337  0019 5b01          	addw	sp,#1
 338  001b 81            	ret
 383                     	switch	.const
 384  0004               L61:
 385  0004 00004039      	dc.l	16441
 386  0008               L02:
 387  0008 0000403a      	dc.l	16442
 388  000c               L22:
 389  000c 0000403b      	dc.l	16443
 390  0010               L42:
 391  0010 0000403c      	dc.l	16444
 392  0014               L62:
 393  0014 0000403d      	dc.l	16445
 394  0018               L03:
 395  0018 0000403e      	dc.l	16446
 396  001c               L23:
 397  001c 00004050      	dc.l	16464
 398  0020               L43:
 399  0020 00004051      	dc.l	16465
 400  0024               L63:
 401  0024 0000404e      	dc.l	16462
 402  0028               L04:
 403  0028 0000404f      	dc.l	16463
 404  002c               L24:
 405  002c 00004052      	dc.l	16466
 406  0030               L44:
 407  0030 00004053      	dc.l	16467
 408  0034               L64:
 409  0034 00004054      	dc.l	16468
 410  0038               L05:
 411  0038 00004055      	dc.l	16469
 412  003c               L25:
 413  003c 00004073      	dc.l	16499
 414                     ; 109 void MEEPROM_device_info_read(void)
 414                     ; 110 {
 415                     .text:	section	.text,new
 416  0000               _MEEPROM_device_info_read:
 418  0000 88            	push	a
 419       00000001      OFST:	set	1
 422                     ; 111 	u8 temp = 0, i;
 424  0001 7b01          	ld	a,(OFST+0,sp)
 425  0003 97            	ld	xl,a
 426                     ; 113 	st1.model = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MODEL_ADDRESS);
 428  0004 ae400b        	ldw	x,#16395
 429  0007 89            	pushw	x
 430  0008 ae0000        	ldw	x,#0
 431  000b 89            	pushw	x
 432  000c cd0000        	call	_FLASH_ReadByte
 434  000f 5b04          	addw	sp,#4
 435  0011 c70005        	ld	_st1+5,a
 436                     ; 114 	st1.firmware_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_FW_VERSION_ADDRESS);   
 438  0014 ae400d        	ldw	x,#16397
 439  0017 89            	pushw	x
 440  0018 ae0000        	ldw	x,#0
 441  001b 89            	pushw	x
 442  001c cd0000        	call	_FLASH_ReadByte
 444  001f 5b04          	addw	sp,#4
 445  0021 c70006        	ld	_st1+6,a
 446                     ; 115 	if(st1.firmware_version == 1){	   /* 第一版本，device ID 4个字节  */	   
 448  0024 c60006        	ld	a,_st1+6
 449  0027 a101          	cp	a,#1
 450  0029 2640          	jrne	L361
 451                     ; 116 		   st1.deviceID[0] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 3);
 453  002b ae4004        	ldw	x,#16388
 454  002e 89            	pushw	x
 455  002f ae0000        	ldw	x,#0
 456  0032 89            	pushw	x
 457  0033 cd0000        	call	_FLASH_ReadByte
 459  0036 5b04          	addw	sp,#4
 460  0038 c70000        	ld	_st1,a
 461                     ; 117 		   st1.deviceID[1] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 2);
 463  003b ae4003        	ldw	x,#16387
 464  003e 89            	pushw	x
 465  003f ae0000        	ldw	x,#0
 466  0042 89            	pushw	x
 467  0043 cd0000        	call	_FLASH_ReadByte
 469  0046 5b04          	addw	sp,#4
 470  0048 c70001        	ld	_st1+1,a
 471                     ; 118 		   st1.deviceID[2] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 1);
 473  004b ae4002        	ldw	x,#16386
 474  004e 89            	pushw	x
 475  004f ae0000        	ldw	x,#0
 476  0052 89            	pushw	x
 477  0053 cd0000        	call	_FLASH_ReadByte
 479  0056 5b04          	addw	sp,#4
 480  0058 c70002        	ld	_st1+2,a
 481                     ; 119 		   st1.deviceID[3] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_DEVICEID_ADDRESS + 0);
 483  005b ae4001        	ldw	x,#16385
 484  005e 89            	pushw	x
 485  005f ae0000        	ldw	x,#0
 486  0062 89            	pushw	x
 487  0063 cd0000        	call	_FLASH_ReadByte
 489  0066 5b04          	addw	sp,#4
 490  0068 c70003        	ld	_st1+3,a
 491  006b               L361:
 492                     ; 121 	st1.HW_version = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_HW_VERSION_ADDRESS);
 494  006b ae400f        	ldw	x,#16399
 495  006e 89            	pushw	x
 496  006f ae0000        	ldw	x,#0
 497  0072 89            	pushw	x
 498  0073 cd0000        	call	_FLASH_ReadByte
 500  0076 5b04          	addw	sp,#4
 501  0078 c70007        	ld	_st1+7,a
 502                     ; 123 	temp = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 0);
 504  007b ae4011        	ldw	x,#16401
 505  007e 89            	pushw	x
 506  007f ae0000        	ldw	x,#0
 507  0082 89            	pushw	x
 508  0083 cd0000        	call	_FLASH_ReadByte
 510  0086 5b04          	addw	sp,#4
 511  0088 6b01          	ld	(OFST+0,sp),a
 512                     ; 124 	st1.bash = temp + 256 * FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_BASH_ADDRESS + 1);
 514  008a ae4012        	ldw	x,#16402
 515  008d 89            	pushw	x
 516  008e ae0000        	ldw	x,#0
 517  0091 89            	pushw	x
 518  0092 cd0000        	call	_FLASH_ReadByte
 520  0095 5b04          	addw	sp,#4
 521  0097 5f            	clrw	x
 522  0098 97            	ld	xl,a
 523  0099 4f            	clr	a
 524  009a 02            	rlwa	x,a
 525  009b 01            	rrwa	x,a
 526  009c 1b01          	add	a,(OFST+0,sp)
 527  009e 2401          	jrnc	L41
 528  00a0 5c            	incw	x
 529  00a1               L41:
 530  00a1 c7000c        	ld	_st1+12,a
 531  00a4 9f            	ld	a,xl
 532  00a5 c7000b        	ld	_st1+11,a
 533                     ; 126 	st1.manaYear = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_YEAR_ADDRESS);
 535  00a8 ae4013        	ldw	x,#16403
 536  00ab 89            	pushw	x
 537  00ac ae0000        	ldw	x,#0
 538  00af 89            	pushw	x
 539  00b0 cd0000        	call	_FLASH_ReadByte
 541  00b3 5b04          	addw	sp,#4
 542  00b5 c70008        	ld	_st1+8,a
 543                     ; 127 	st1.manaMonth = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_MONTH_ADDRESS);
 545  00b8 ae4014        	ldw	x,#16404
 546  00bb 89            	pushw	x
 547  00bc ae0000        	ldw	x,#0
 548  00bf 89            	pushw	x
 549  00c0 cd0000        	call	_FLASH_ReadByte
 551  00c3 5b04          	addw	sp,#4
 552  00c5 c70009        	ld	_st1+9,a
 553                     ; 128 	st1.manaDay = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MANA_DAY_ADDRESS);
 555  00c8 ae4015        	ldw	x,#16405
 556  00cb 89            	pushw	x
 557  00cc ae0000        	ldw	x,#0
 558  00cf 89            	pushw	x
 559  00d0 cd0000        	call	_FLASH_ReadByte
 561  00d3 5b04          	addw	sp,#4
 562  00d5 c7000a        	ld	_st1+10,a
 563                     ; 131 	st1.keypad[0].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS);
 565  00d8 ae402d        	ldw	x,#16429
 566  00db 89            	pushw	x
 567  00dc ae0000        	ldw	x,#0
 568  00df 89            	pushw	x
 569  00e0 cd0000        	call	_FLASH_ReadByte
 571  00e3 5b04          	addw	sp,#4
 572  00e5 c70024        	ld	_st1+36,a
 573                     ; 132 	st1.keypad[1].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_STATUS_ADDRESS);
 575  00e8 ae402e        	ldw	x,#16430
 576  00eb 89            	pushw	x
 577  00ec ae0000        	ldw	x,#0
 578  00ef 89            	pushw	x
 579  00f0 cd0000        	call	_FLASH_ReadByte
 581  00f3 5b04          	addw	sp,#4
 582  00f5 c7002f        	ld	_st1+47,a
 583                     ; 133 	st1.keypad[2].status = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH3_STATUS_ADDRESS);
 585  00f8 ae402f        	ldw	x,#16431
 586  00fb 89            	pushw	x
 587  00fc ae0000        	ldw	x,#0
 588  00ff 89            	pushw	x
 589  0100 cd0000        	call	_FLASH_ReadByte
 591  0103 5b04          	addw	sp,#4
 592  0105 c7003a        	ld	_st1+58,a
 593                     ; 135 	ns_host_meshid_H = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MESHID_H_ADDRESS);
 595  0108 ae4031        	ldw	x,#16433
 596  010b 89            	pushw	x
 597  010c ae0000        	ldw	x,#0
 598  010f 89            	pushw	x
 599  0110 cd0000        	call	_FLASH_ReadByte
 601  0113 5b04          	addw	sp,#4
 602  0115 c70000        	ld	_ns_host_meshid_H,a
 603                     ; 136 	ns_host_meshid_L = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_MESHID_L_ADDRESS);
 605  0118 ae4032        	ldw	x,#16434
 606  011b 89            	pushw	x
 607  011c ae0000        	ldw	x,#0
 608  011f 89            	pushw	x
 609  0120 cd0000        	call	_FLASH_ReadByte
 611  0123 5b04          	addw	sp,#4
 612  0125 c70000        	ld	_ns_host_meshid_L,a
 613                     ; 138 	st1.keypad[0].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_TARGET_STATUS_ADDRESS);
 615  0128 ae402d        	ldw	x,#16429
 616  012b 89            	pushw	x
 617  012c ae0000        	ldw	x,#0
 618  012f 89            	pushw	x
 619  0130 cd0000        	call	_FLASH_ReadByte
 621  0133 5b04          	addw	sp,#4
 622  0135 c70025        	ld	_st1+37,a
 623                     ; 139 	st1.keypad[1].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH2_TARGET_STATUS_ADDRESS);
 625  0138 ae402e        	ldw	x,#16430
 626  013b 89            	pushw	x
 627  013c ae0000        	ldw	x,#0
 628  013f 89            	pushw	x
 629  0140 cd0000        	call	_FLASH_ReadByte
 631  0143 5b04          	addw	sp,#4
 632  0145 c70030        	ld	_st1+48,a
 633                     ; 140 	st1.keypad[2].actural_val = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH3_TARGET_STATUS_ADDRESS);
 635  0148 ae402f        	ldw	x,#16431
 636  014b 89            	pushw	x
 637  014c ae0000        	ldw	x,#0
 638  014f 89            	pushw	x
 639  0150 cd0000        	call	_FLASH_ReadByte
 641  0153 5b04          	addw	sp,#4
 642  0155 c7003b        	ld	_st1+59,a
 643                     ; 141 	st1.keypad[0].actural_val_bak = st1.keypad[0].actural_val;
 645  0158 5500250026    	mov	_st1+38,_st1+37
 646                     ; 142 	st1.keypad[1].actural_val_bak = st1.keypad[1].actural_val;
 648  015d 5500300031    	mov	_st1+49,_st1+48
 649                     ; 143 	st1.keypad[2].actural_val_bak = st1.keypad[2].actural_val;
 651  0162 55003b003c    	mov	_st1+60,_st1+59
 652                     ; 147 	for(i = 0; i < KEYPAY_NUMS; i++){
 654  0167 0f01          	clr	(OFST+0,sp)
 655  0169               L561:
 656                     ; 149 		st1.keypad[i].meshid_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDH_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 658  0169 7b01          	ld	a,(OFST+0,sp)
 659  016b 97            	ld	xl,a
 660  016c a60b          	ld	a,#11
 661  016e 42            	mul	x,a
 662  016f 89            	pushw	x
 663  0170 7b03          	ld	a,(OFST+2,sp)
 664  0172 97            	ld	xl,a
 665  0173 a607          	ld	a,#7
 666  0175 42            	mul	x,a
 667  0176 cd0000        	call	c_itolx
 669  0179 ae0004        	ldw	x,#L61
 670  017c cd0000        	call	c_ladd
 672  017f be02          	ldw	x,c_lreg+2
 673  0181 89            	pushw	x
 674  0182 be00          	ldw	x,c_lreg
 675  0184 89            	pushw	x
 676  0185 cd0000        	call	_FLASH_ReadByte
 678  0188 5b04          	addw	sp,#4
 679  018a 85            	popw	x
 680  018b d70027        	ld	(_st1+39,x),a
 681                     ; 150 		if(st1.keypad[i].meshid_h){		
 683  018e 7b01          	ld	a,(OFST+0,sp)
 684  0190 97            	ld	xl,a
 685  0191 a60b          	ld	a,#11
 686  0193 42            	mul	x,a
 687  0194 724d0027      	tnz	(_st1+39,x)
 688  0198 2603          	jrne	L45
 689  019a cc0264        	jp	L371
 690  019d               L45:
 691                     ; 151 			st1.keypad[i].flag.bit.setted = 1;
 693  019d 7b01          	ld	a,(OFST+0,sp)
 694  019f 97            	ld	xl,a
 695  01a0 a60b          	ld	a,#11
 696  01a2 42            	mul	x,a
 697  01a3 d60022        	ld	a,(_st1+34,x)
 698  01a6 aa02          	or	a,#2
 699  01a8 d70022        	ld	(_st1+34,x),a
 700                     ; 153 			st1.keypad[i].meshid_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDL_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 702  01ab 7b01          	ld	a,(OFST+0,sp)
 703  01ad 97            	ld	xl,a
 704  01ae a60b          	ld	a,#11
 705  01b0 42            	mul	x,a
 706  01b1 89            	pushw	x
 707  01b2 7b03          	ld	a,(OFST+2,sp)
 708  01b4 97            	ld	xl,a
 709  01b5 a607          	ld	a,#7
 710  01b7 42            	mul	x,a
 711  01b8 cd0000        	call	c_itolx
 713  01bb ae0008        	ldw	x,#L02
 714  01be cd0000        	call	c_ladd
 716  01c1 be02          	ldw	x,c_lreg+2
 717  01c3 89            	pushw	x
 718  01c4 be00          	ldw	x,c_lreg
 719  01c6 89            	pushw	x
 720  01c7 cd0000        	call	_FLASH_ReadByte
 722  01ca 5b04          	addw	sp,#4
 723  01cc 85            	popw	x
 724  01cd d70028        	ld	(_st1+40,x),a
 725                     ; 154 			st1.keypad[i].action = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_ACTION_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 727  01d0 7b01          	ld	a,(OFST+0,sp)
 728  01d2 97            	ld	xl,a
 729  01d3 a60b          	ld	a,#11
 730  01d5 42            	mul	x,a
 731  01d6 89            	pushw	x
 732  01d7 7b03          	ld	a,(OFST+2,sp)
 733  01d9 97            	ld	xl,a
 734  01da a607          	ld	a,#7
 735  01dc 42            	mul	x,a
 736  01dd cd0000        	call	c_itolx
 738  01e0 ae000c        	ldw	x,#L22
 739  01e3 cd0000        	call	c_ladd
 741  01e6 be02          	ldw	x,c_lreg+2
 742  01e8 89            	pushw	x
 743  01e9 be00          	ldw	x,c_lreg
 744  01eb 89            	pushw	x
 745  01ec cd0000        	call	_FLASH_ReadByte
 747  01ef 5b04          	addw	sp,#4
 748  01f1 85            	popw	x
 749  01f2 d7002a        	ld	(_st1+42,x),a
 750                     ; 155 			st1.keypad[i].boardid = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_BOARDID_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 752  01f5 7b01          	ld	a,(OFST+0,sp)
 753  01f7 97            	ld	xl,a
 754  01f8 a60b          	ld	a,#11
 755  01fa 42            	mul	x,a
 756  01fb 89            	pushw	x
 757  01fc 7b03          	ld	a,(OFST+2,sp)
 758  01fe 97            	ld	xl,a
 759  01ff a607          	ld	a,#7
 760  0201 42            	mul	x,a
 761  0202 cd0000        	call	c_itolx
 763  0205 ae0010        	ldw	x,#L42
 764  0208 cd0000        	call	c_ladd
 766  020b be02          	ldw	x,c_lreg+2
 767  020d 89            	pushw	x
 768  020e be00          	ldw	x,c_lreg
 769  0210 89            	pushw	x
 770  0211 cd0000        	call	_FLASH_ReadByte
 772  0214 5b04          	addw	sp,#4
 773  0216 85            	popw	x
 774  0217 d70029        	ld	(_st1+41,x),a
 775                     ; 156 			st1.keypad[i].value = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_VALUE_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 777  021a 7b01          	ld	a,(OFST+0,sp)
 778  021c 97            	ld	xl,a
 779  021d a60b          	ld	a,#11
 780  021f 42            	mul	x,a
 781  0220 89            	pushw	x
 782  0221 7b03          	ld	a,(OFST+2,sp)
 783  0223 97            	ld	xl,a
 784  0224 a607          	ld	a,#7
 785  0226 42            	mul	x,a
 786  0227 cd0000        	call	c_itolx
 788  022a ae0014        	ldw	x,#L62
 789  022d cd0000        	call	c_ladd
 791  0230 be02          	ldw	x,c_lreg+2
 792  0232 89            	pushw	x
 793  0233 be00          	ldw	x,c_lreg
 794  0235 89            	pushw	x
 795  0236 cd0000        	call	_FLASH_ReadByte
 797  0239 5b04          	addw	sp,#4
 798  023b 85            	popw	x
 799  023c d7002b        	ld	(_st1+43,x),a
 800                     ; 157 			st1.keypad[i].time = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_TIME_ADDRESS + EEPROM_ONEKEY_BYTES_USED * i);
 802  023f 7b01          	ld	a,(OFST+0,sp)
 803  0241 97            	ld	xl,a
 804  0242 a60b          	ld	a,#11
 805  0244 42            	mul	x,a
 806  0245 89            	pushw	x
 807  0246 7b03          	ld	a,(OFST+2,sp)
 808  0248 97            	ld	xl,a
 809  0249 a607          	ld	a,#7
 810  024b 42            	mul	x,a
 811  024c cd0000        	call	c_itolx
 813  024f ae0018        	ldw	x,#L03
 814  0252 cd0000        	call	c_ladd
 816  0255 be02          	ldw	x,c_lreg+2
 817  0257 89            	pushw	x
 818  0258 be00          	ldw	x,c_lreg
 819  025a 89            	pushw	x
 820  025b cd0000        	call	_FLASH_ReadByte
 822  025e 5b04          	addw	sp,#4
 823  0260 85            	popw	x
 824  0261 d7002c        	ld	(_st1+44,x),a
 825  0264               L371:
 826                     ; 147 	for(i = 0; i < KEYPAY_NUMS; i++){
 828  0264 0c01          	inc	(OFST+0,sp)
 831  0266 7b01          	ld	a,(OFST+0,sp)
 832  0268 a103          	cp	a,#3
 833  026a 2403          	jruge	L65
 834  026c cc0169        	jp	L561
 835  026f               L65:
 836                     ; 162 	for(i = 0; i < GESTURE_NUMS; i++){
 838  026f 0f01          	clr	(OFST+0,sp)
 839  0271               L571:
 840                     ; 164 		st1.gesture[i].meshid_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 842  0271 7b01          	ld	a,(OFST+0,sp)
 843  0273 97            	ld	xl,a
 844  0274 a60a          	ld	a,#10
 845  0276 42            	mul	x,a
 846  0277 89            	pushw	x
 847  0278 7b03          	ld	a,(OFST+2,sp)
 848  027a 97            	ld	xl,a
 849  027b a609          	ld	a,#9
 850  027d 42            	mul	x,a
 851  027e cd0000        	call	c_itolx
 853  0281 ae001c        	ldw	x,#L23
 854  0284 cd0000        	call	c_ladd
 856  0287 be02          	ldw	x,c_lreg+2
 857  0289 89            	pushw	x
 858  028a be00          	ldw	x,c_lreg
 859  028c 89            	pushw	x
 860  028d cd0000        	call	_FLASH_ReadByte
 862  0290 5b04          	addw	sp,#4
 863  0292 85            	popw	x
 864  0293 d70047        	ld	(_st1+71,x),a
 865                     ; 165 		if(st1.gesture[i].meshid_h){		
 867  0296 7b01          	ld	a,(OFST+0,sp)
 868  0298 97            	ld	xl,a
 869  0299 a60a          	ld	a,#10
 870  029b 42            	mul	x,a
 871  029c 724d0047      	tnz	(_st1+71,x)
 872  02a0 2603          	jrne	L06
 873  02a2 cc03b6        	jp	L302
 874  02a5               L06:
 875                     ; 166 			st1.gesture[i].flag.bit.setted = 1;
 877  02a5 7b01          	ld	a,(OFST+0,sp)
 878  02a7 97            	ld	xl,a
 879  02a8 a60a          	ld	a,#10
 880  02aa 42            	mul	x,a
 881  02ab d60043        	ld	a,(_st1+67,x)
 882  02ae aa02          	or	a,#2
 883  02b0 d70043        	ld	(_st1+67,x),a
 884                     ; 168 			st1.gesture[i].meshid_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 886  02b3 7b01          	ld	a,(OFST+0,sp)
 887  02b5 97            	ld	xl,a
 888  02b6 a60a          	ld	a,#10
 889  02b8 42            	mul	x,a
 890  02b9 89            	pushw	x
 891  02ba 7b03          	ld	a,(OFST+2,sp)
 892  02bc 97            	ld	xl,a
 893  02bd a609          	ld	a,#9
 894  02bf 42            	mul	x,a
 895  02c0 cd0000        	call	c_itolx
 897  02c3 ae0020        	ldw	x,#L43
 898  02c6 cd0000        	call	c_ladd
 900  02c9 be02          	ldw	x,c_lreg+2
 901  02cb 89            	pushw	x
 902  02cc be00          	ldw	x,c_lreg
 903  02ce 89            	pushw	x
 904  02cf cd0000        	call	_FLASH_ReadByte
 906  02d2 5b04          	addw	sp,#4
 907  02d4 85            	popw	x
 908  02d5 d70048        	ld	(_st1+72,x),a
 909                     ; 169 			st1.gesture[i].ges_h = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 911  02d8 7b01          	ld	a,(OFST+0,sp)
 912  02da 97            	ld	xl,a
 913  02db a60a          	ld	a,#10
 914  02dd 42            	mul	x,a
 915  02de 89            	pushw	x
 916  02df 7b03          	ld	a,(OFST+2,sp)
 917  02e1 97            	ld	xl,a
 918  02e2 a609          	ld	a,#9
 919  02e4 42            	mul	x,a
 920  02e5 cd0000        	call	c_itolx
 922  02e8 ae0024        	ldw	x,#L63
 923  02eb cd0000        	call	c_ladd
 925  02ee be02          	ldw	x,c_lreg+2
 926  02f0 89            	pushw	x
 927  02f1 be00          	ldw	x,c_lreg
 928  02f3 89            	pushw	x
 929  02f4 cd0000        	call	_FLASH_ReadByte
 931  02f7 5b04          	addw	sp,#4
 932  02f9 85            	popw	x
 933  02fa d70045        	ld	(_st1+69,x),a
 934                     ; 170 			st1.gesture[i].ges_l = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 936  02fd 7b01          	ld	a,(OFST+0,sp)
 937  02ff 97            	ld	xl,a
 938  0300 a60a          	ld	a,#10
 939  0302 42            	mul	x,a
 940  0303 89            	pushw	x
 941  0304 7b03          	ld	a,(OFST+2,sp)
 942  0306 97            	ld	xl,a
 943  0307 a609          	ld	a,#9
 944  0309 42            	mul	x,a
 945  030a cd0000        	call	c_itolx
 947  030d ae0028        	ldw	x,#L04
 948  0310 cd0000        	call	c_ladd
 950  0313 be02          	ldw	x,c_lreg+2
 951  0315 89            	pushw	x
 952  0316 be00          	ldw	x,c_lreg
 953  0318 89            	pushw	x
 954  0319 cd0000        	call	_FLASH_ReadByte
 956  031c 5b04          	addw	sp,#4
 957  031e 85            	popw	x
 958  031f d70046        	ld	(_st1+70,x),a
 959                     ; 171 			st1.gesture[i].action = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_ACTION_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 961  0322 7b01          	ld	a,(OFST+0,sp)
 962  0324 97            	ld	xl,a
 963  0325 a60a          	ld	a,#10
 964  0327 42            	mul	x,a
 965  0328 89            	pushw	x
 966  0329 7b03          	ld	a,(OFST+2,sp)
 967  032b 97            	ld	xl,a
 968  032c a609          	ld	a,#9
 969  032e 42            	mul	x,a
 970  032f cd0000        	call	c_itolx
 972  0332 ae002c        	ldw	x,#L24
 973  0335 cd0000        	call	c_ladd
 975  0338 be02          	ldw	x,c_lreg+2
 976  033a 89            	pushw	x
 977  033b be00          	ldw	x,c_lreg
 978  033d 89            	pushw	x
 979  033e cd0000        	call	_FLASH_ReadByte
 981  0341 5b04          	addw	sp,#4
 982  0343 85            	popw	x
 983  0344 d7004a        	ld	(_st1+74,x),a
 984                     ; 172 			st1.gesture[i].boardid = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_BOARDID_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
 986  0347 7b01          	ld	a,(OFST+0,sp)
 987  0349 97            	ld	xl,a
 988  034a a60a          	ld	a,#10
 989  034c 42            	mul	x,a
 990  034d 89            	pushw	x
 991  034e 7b03          	ld	a,(OFST+2,sp)
 992  0350 97            	ld	xl,a
 993  0351 a609          	ld	a,#9
 994  0353 42            	mul	x,a
 995  0354 cd0000        	call	c_itolx
 997  0357 ae0030        	ldw	x,#L44
 998  035a cd0000        	call	c_ladd
1000  035d be02          	ldw	x,c_lreg+2
1001  035f 89            	pushw	x
1002  0360 be00          	ldw	x,c_lreg
1003  0362 89            	pushw	x
1004  0363 cd0000        	call	_FLASH_ReadByte
1006  0366 5b04          	addw	sp,#4
1007  0368 85            	popw	x
1008  0369 d70049        	ld	(_st1+73,x),a
1009                     ; 173 			st1.gesture[i].value = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_VALUE_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);
1011  036c 7b01          	ld	a,(OFST+0,sp)
1012  036e 97            	ld	xl,a
1013  036f a60a          	ld	a,#10
1014  0371 42            	mul	x,a
1015  0372 89            	pushw	x
1016  0373 7b03          	ld	a,(OFST+2,sp)
1017  0375 97            	ld	xl,a
1018  0376 a609          	ld	a,#9
1019  0378 42            	mul	x,a
1020  0379 cd0000        	call	c_itolx
1022  037c ae0034        	ldw	x,#L64
1023  037f cd0000        	call	c_ladd
1025  0382 be02          	ldw	x,c_lreg+2
1026  0384 89            	pushw	x
1027  0385 be00          	ldw	x,c_lreg
1028  0387 89            	pushw	x
1029  0388 cd0000        	call	_FLASH_ReadByte
1031  038b 5b04          	addw	sp,#4
1032  038d 85            	popw	x
1033  038e d7004b        	ld	(_st1+75,x),a
1034                     ; 174 			st1.gesture[i].time = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TIME_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * i);			
1036  0391 7b01          	ld	a,(OFST+0,sp)
1037  0393 97            	ld	xl,a
1038  0394 a60a          	ld	a,#10
1039  0396 42            	mul	x,a
1040  0397 89            	pushw	x
1041  0398 7b03          	ld	a,(OFST+2,sp)
1042  039a 97            	ld	xl,a
1043  039b a609          	ld	a,#9
1044  039d 42            	mul	x,a
1045  039e cd0000        	call	c_itolx
1047  03a1 ae0038        	ldw	x,#L05
1048  03a4 cd0000        	call	c_ladd
1050  03a7 be02          	ldw	x,c_lreg+2
1051  03a9 89            	pushw	x
1052  03aa be00          	ldw	x,c_lreg
1053  03ac 89            	pushw	x
1054  03ad cd0000        	call	_FLASH_ReadByte
1056  03b0 5b04          	addw	sp,#4
1057  03b2 85            	popw	x
1058  03b3 d7004c        	ld	(_st1+76,x),a
1059  03b6               L302:
1060                     ; 162 	for(i = 0; i < GESTURE_NUMS; i++){
1062  03b6 0c01          	inc	(OFST+0,sp)
1065  03b8 7b01          	ld	a,(OFST+0,sp)
1066  03ba a104          	cp	a,#4
1067  03bc 2403          	jruge	L26
1068  03be cc0271        	jp	L571
1069  03c1               L26:
1070                     ; 180 	mpr121_handle.slipLevel = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_NOKEY_SLIPPAD_VALUE);
1072  03c1 ae4072        	ldw	x,#16498
1073  03c4 89            	pushw	x
1074  03c5 ae0000        	ldw	x,#0
1075  03c8 89            	pushw	x
1076  03c9 cd0000        	call	_FLASH_ReadByte
1078  03cc 5b04          	addw	sp,#4
1079  03ce c70013        	ld	_mpr121_handle+19,a
1080                     ; 181 	mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;
1082  03d1 c60013        	ld	a,_mpr121_handle+19
1083  03d4 4c            	inc	a
1084  03d5 c70012        	ld	_mpr121_handle+18,a
1085                     ; 182 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
1087  03d8 0f01          	clr	(OFST+0,sp)
1088  03da               L502:
1089                     ; 183 		mpr121_handle.keylongTouchSlipLevel[i] = FLASH_ReadByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_SLIPPAD_VALUE + i);
1091  03da 7b01          	ld	a,(OFST+0,sp)
1092  03dc 5f            	clrw	x
1093  03dd 97            	ld	xl,a
1094  03de 89            	pushw	x
1095  03df 7b03          	ld	a,(OFST+2,sp)
1096  03e1 b703          	ld	c_lreg+3,a
1097  03e3 3f02          	clr	c_lreg+2
1098  03e5 3f01          	clr	c_lreg+1
1099  03e7 3f00          	clr	c_lreg
1100  03e9 ae003c        	ldw	x,#L25
1101  03ec cd0000        	call	c_ladd
1103  03ef be02          	ldw	x,c_lreg+2
1104  03f1 89            	pushw	x
1105  03f2 be00          	ldw	x,c_lreg
1106  03f4 89            	pushw	x
1107  03f5 cd0000        	call	_FLASH_ReadByte
1109  03f8 5b04          	addw	sp,#4
1110  03fa 85            	popw	x
1111  03fb d7000c        	ld	(_mpr121_handle+12,x),a
1112                     ; 182 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
1114  03fe 0c01          	inc	(OFST+0,sp)
1117  0400 7b01          	ld	a,(OFST+0,sp)
1118  0402 a103          	cp	a,#3
1119  0404 25d4          	jrult	L502
1120                     ; 188 }
1123  0406 84            	pop	a
1124  0407 81            	ret
1161                     ; 193 void MEEPROM_default_info_set(void)
1161                     ; 194 {	
1162                     .text:	section	.text,new
1163  0000               _MEEPROM_default_info_set:
1165  0000 88            	push	a
1166       00000001      OFST:	set	1
1169                     ; 197 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
1171  0001 a601          	ld	a,#1
1172  0003 cd0000        	call	_FLASH_Unlock
1175  0006               L132:
1176                     ; 198 	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
1178  0006 a608          	ld	a,#8
1179  0008 cd0000        	call	_FLASH_GetFlagStatus
1181  000b 4d            	tnz	a
1182  000c 27f8          	jreq	L132
1183                     ; 200 	for(i = EEPROM_USER_START_ADDRESS; i <= EEPROM_USER_END_ADDRESS; i++){
1185  000e a62d          	ld	a,#45
1186  0010 6b01          	ld	(OFST+0,sp),a
1187  0012               L532:
1188                     ; 201 		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + i, 0);
1190  0012 4b00          	push	#0
1191  0014 7b02          	ld	a,(OFST+1,sp)
1192  0016 b703          	ld	c_lreg+3,a
1193  0018 3f02          	clr	c_lreg+2
1194  001a 3f01          	clr	c_lreg+1
1195  001c 3f00          	clr	c_lreg
1196  001e ae0000        	ldw	x,#L6
1197  0021 cd0000        	call	c_ladd
1199  0024 be02          	ldw	x,c_lreg+2
1200  0026 89            	pushw	x
1201  0027 be00          	ldw	x,c_lreg
1202  0029 89            	pushw	x
1203  002a cd0000        	call	_FLASH_ProgramByte
1205  002d 5b05          	addw	sp,#5
1206                     ; 200 	for(i = EEPROM_USER_START_ADDRESS; i <= EEPROM_USER_END_ADDRESS; i++){
1208  002f 0c01          	inc	(OFST+0,sp)
1211  0031 7b01          	ld	a,(OFST+0,sp)
1212  0033 a179          	cp	a,#121
1213  0035 25db          	jrult	L532
1214                     ; 204 	FLASH_Lock(FLASH_MEMTYPE_DATA);
1216  0037 a601          	ld	a,#1
1217  0039 cd0000        	call	_FLASH_Lock
1219                     ; 206 }
1222  003c 84            	pop	a
1223  003d 81            	ret
1260                     ; 212 void MEEPROM_Init(void)
1260                     ; 213 {
1261                     .text:	section	.text,new
1262  0000               _MEEPROM_Init:
1264  0000 88            	push	a
1265       00000001      OFST:	set	1
1268                     ; 214 	u8 temp = 0;
1270  0001 0f01          	clr	(OFST+0,sp)
1271                     ; 216 	FLASH_DeInit();
1273  0003 cd0000        	call	_FLASH_DeInit
1275                     ; 217 	temp = MEEPROM_ReadByte(EEPROM_INIT_ADDRESS);
1277  0006 5f            	clrw	x
1278  0007 cd0000        	call	_MEEPROM_ReadByte
1280  000a 6b01          	ld	(OFST+0,sp),a
1281                     ; 220 	if(temp != EEPROM_INIT_FLAG) {	   
1283  000c 0d01          	tnz	(OFST+0,sp)
1284  000e 270a          	jreq	L752
1285                     ; 221 		   MEEPROM_WriteByte(EEPROM_INIT_ADDRESS, EEPROM_INIT_FLAG);
1287  0010 4b00          	push	#0
1288  0012 5f            	clrw	x
1289  0013 cd0000        	call	_MEEPROM_WriteByte
1291  0016 84            	pop	a
1292                     ; 222 		   MEEPROM_default_info_set();
1294  0017 cd0000        	call	_MEEPROM_default_info_set
1296  001a               L752:
1297                     ; 225 	MEEPROM_device_info_read();
1299  001a cd0000        	call	_MEEPROM_device_info_read
1301                     ; 227 }
1304  001d 84            	pop	a
1305  001e 81            	ret
1308                     	switch	.data
1309  0019               L162_id:
1310  0019 00            	dc.b	0
1341                     ; 234 u8 sicp_get_message_id(void)
1341                     ; 235 {
1342                     .text:	section	.text,new
1343  0000               _sicp_get_message_id:
1347                     ; 238 	id++;
1349  0000 725c0019      	inc	L162_id
1350                     ; 240 	if(id == 0) {
1352  0004 725d0019      	tnz	L162_id
1353  0008 2604          	jrne	L772
1354                     ; 241 		id = 1;
1356  000a 35010019      	mov	L162_id,#1
1357  000e               L772:
1358                     ; 244 	return id;
1360  000e c60019        	ld	a,L162_id
1363  0011 81            	ret
1399                     ; 252 void keypad_action(void)
1399                     ; 253 {
1400                     .text:	section	.text,new
1401  0000               _keypad_action:
1403  0000 88            	push	a
1404       00000001      OFST:	set	1
1407                     ; 260 	for(i = 0; i < KEYPAY_NUMS; i++) {
1409  0001 0f01          	clr	(OFST+0,sp)
1410  0003               L513:
1411                     ; 262 		if(st1.keypad[i].flag.bit.detected) {		//按键触发标志
1413  0003 7b01          	ld	a,(OFST+0,sp)
1414  0005 97            	ld	xl,a
1415  0006 a60b          	ld	a,#11
1416  0008 42            	mul	x,a
1417  0009 d60022        	ld	a,(_st1+34,x)
1418  000c a501          	bcp	a,#1
1419  000e 2744          	jreq	L323
1420                     ; 264 			st1.keypad[i].flag.bit.detected = 0;
1422  0010 7b01          	ld	a,(OFST+0,sp)
1423  0012 97            	ld	xl,a
1424  0013 a60b          	ld	a,#11
1425  0015 42            	mul	x,a
1426  0016 d60022        	ld	a,(_st1+34,x)
1427  0019 a4fe          	and	a,#254
1428  001b d70022        	ld	(_st1+34,x),a
1429                     ; 266 			if(st1.keypad[i].flag.bit.setted) {	//已设置按键指令
1431  001e 7b01          	ld	a,(OFST+0,sp)
1432  0020 97            	ld	xl,a
1433  0021 a60b          	ld	a,#11
1434  0023 42            	mul	x,a
1435  0024 d60022        	ld	a,(_st1+34,x)
1436  0027 a502          	bcp	a,#2
1437  0029 270b          	jreq	L523
1438                     ; 268 				send_action_ctrl(i, KEYPAD_CTRL);
1440  002b ae0001        	ldw	x,#1
1441  002e 7b01          	ld	a,(OFST+0,sp)
1442  0030 95            	ld	xh,a
1443  0031 cd0000        	call	_send_action_ctrl
1446  0034 2009          	jra	L723
1447  0036               L523:
1448                     ; 274 				send_action_without_setted(i, KEYPAD_CTRL);
1450  0036 ae0001        	ldw	x,#1
1451  0039 7b01          	ld	a,(OFST+0,sp)
1452  003b 95            	ld	xh,a
1453  003c cd0000        	call	_send_action_without_setted
1455  003f               L723:
1456                     ; 278 			MEEPROM_WriteByte(EEPROM_CH1_STATUS_ADDRESS + i, st1.keypad[i].status);		//保存状态
1458  003f 7b01          	ld	a,(OFST+0,sp)
1459  0041 97            	ld	xl,a
1460  0042 a60b          	ld	a,#11
1461  0044 42            	mul	x,a
1462  0045 d60024        	ld	a,(_st1+36,x)
1463  0048 88            	push	a
1464  0049 7b02          	ld	a,(OFST+1,sp)
1465  004b 5f            	clrw	x
1466  004c 97            	ld	xl,a
1467  004d 1c002d        	addw	x,#45
1468  0050 cd0000        	call	_MEEPROM_WriteByte
1470  0053 84            	pop	a
1471  0054               L323:
1472                     ; 260 	for(i = 0; i < KEYPAY_NUMS; i++) {
1474  0054 0c01          	inc	(OFST+0,sp)
1477  0056 7b01          	ld	a,(OFST+0,sp)
1478  0058 a103          	cp	a,#3
1479  005a 25a7          	jrult	L513
1480                     ; 286 }
1483  005c 84            	pop	a
1484  005d 81            	ret
1511                     ; 292 void gesture_exti_config(void)
1511                     ; 293 {
1512                     .text:	section	.text,new
1513  0000               _gesture_exti_config:
1517                     ; 295 	GPIO_Init(GPIOE, GPIO_PIN_3, GPIO_MODE_IN_PU_IT );
1519  0000 4b60          	push	#96
1520  0002 4b08          	push	#8
1521  0004 ae5014        	ldw	x,#20500
1522  0007 cd0000        	call	_GPIO_Init
1524  000a 85            	popw	x
1525                     ; 298 	EXTI_SetTLISensitivity(EXTI_TLISENSITIVITY_FALL_ONLY);		//下降沿触发中断
1527  000b 4f            	clr	a
1528  000c cd0000        	call	_EXTI_SetTLISensitivity
1530                     ; 299 	EXTI_SetExtIntSensitivity((EXTI_PORT_GPIOE), EXTI_SENSITIVITY_FALL_ONLY);
1532  000f ae0002        	ldw	x,#2
1533  0012 a604          	ld	a,#4
1534  0014 95            	ld	xh,a
1535  0015 cd0000        	call	_EXTI_SetExtIntSensitivity
1537                     ; 301 }
1540  0018 81            	ret
1564                     ; 306 void gesture_led_init(void)
1564                     ; 307 {
1565                     .text:	section	.text,new
1566  0000               _gesture_led_init:
1570                     ; 309   	GPIO_Init(GESTURE_LED_PORT, (GPIO_Pin_TypeDef)GESTURE_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
1572  0000 4bc0          	push	#192
1573  0002 4b10          	push	#16
1574  0004 ae500a        	ldw	x,#20490
1575  0007 cd0000        	call	_GPIO_Init
1577  000a 85            	popw	x
1578                     ; 311 }
1581  000b 81            	ret
1584                     	switch	.data
1585  001a               L153_ledShowCnt:
1586  001a 00            	dc.b	0
1587  001b               L353_ledStatusOld:
1588  001b 00            	dc.b	0
1626                     ; 317 void gesture_led_show(void)
1626                     ; 318 {
1627                     .text:	section	.text,new
1628  0000               _gesture_led_show:
1632                     ; 322 	ledShowCnt++;
1634  0000 725c001a      	inc	L153_ledShowCnt
1635                     ; 324 	if(st1.ges_led_ctrl != ledStatusOld){
1637  0004 c6001d        	ld	a,_st1+29
1638  0007 c1001b        	cp	a,L353_ledStatusOld
1639  000a 2709          	jreq	L373
1640                     ; 325 		ledStatusOld = st1.ges_led_ctrl;
1642  000c 55001d001b    	mov	L353_ledStatusOld,_st1+29
1643                     ; 326 		ledShowCnt = 0;
1645  0011 725f001a      	clr	L153_ledShowCnt
1646  0015               L373:
1647                     ; 329 	if(st1.ges_led_ctrl == 1){
1649  0015 c6001d        	ld	a,_st1+29
1650  0018 a101          	cp	a,#1
1651  001a 2616          	jrne	L573
1652                     ; 331 		if(ledShowCnt < 1){		/* 亮 200ms */
1654  001c 725d001a      	tnz	L153_ledShowCnt
1655  0020 2606          	jrne	L773
1656                     ; 333 			GESTURE_LED_ON;
1658  0022 7218500a      	bset	20490,#4
1660  0026 202c          	jra	L304
1661  0028               L773:
1662                     ; 335 			GESTURE_LED_OFF;
1664  0028 7219500a      	bres	20490,#4
1665                     ; 336 			st1.ges_led_ctrl = 0;
1667  002c 725f001d      	clr	_st1+29
1668  0030 2022          	jra	L304
1669  0032               L573:
1670                     ; 339 	}else if(st1.ges_led_ctrl == 0xff){
1672  0032 c6001d        	ld	a,_st1+29
1673  0035 a1ff          	cp	a,#255
1674  0037 2617          	jrne	L504
1675                     ; 341 		if(ledShowCnt < 30){		/* */
1677  0039 c6001a        	ld	a,L153_ledShowCnt
1678  003c a11e          	cp	a,#30
1679  003e 2406          	jruge	L704
1680                     ; 342 			GESTURE_LED_ON;
1682  0040 7218500a      	bset	20490,#4
1684  0044 200e          	jra	L304
1685  0046               L704:
1686                     ; 344 			GESTURE_LED_OFF;
1688  0046 7219500a      	bres	20490,#4
1689                     ; 345 			st1.ges_led_ctrl = 0;
1691  004a 725f001d      	clr	_st1+29
1692  004e 2004          	jra	L304
1693  0050               L504:
1694                     ; 350 		GESTURE_LED_OFF;
1696  0050 7219500a      	bres	20490,#4
1697  0054               L304:
1698                     ; 356 }
1701  0054 81            	ret
1726                     ; 361 void gesture_timeout_check(void)
1726                     ; 362 {
1727                     .text:	section	.text,new
1728  0000               _gesture_timeout_check:
1732                     ; 364 	if(st1.ges_cnt){		//正在检测手势
1734  0000 725d001e      	tnz	_st1+30
1735  0004 271b          	jreq	L524
1736                     ; 365 		st1.ges_timer++;
1738  0006 725c001f      	inc	_st1+31
1739                     ; 366 		if(st1.ges_timer >= 30){		//3s
1741  000a c6001f        	ld	a,_st1+31
1742  000d a11e          	cp	a,#30
1743  000f 2510          	jrult	L524
1744                     ; 367 			st1.ges_timer = 0;
1746  0011 725f001f      	clr	_st1+31
1747                     ; 368 			st1.ges_cnt = 0;
1749  0015 725f001e      	clr	_st1+30
1750                     ; 369 			st1.ges_h = 0;
1752  0019 725f0020      	clr	_st1+32
1753                     ; 370 			st1.ges_l = 0;
1755  001d 725f0021      	clr	_st1+33
1756  0021               L524:
1757                     ; 374 }
1760  0021 81            	ret
1796                     ; 381 void gesture_action(void)
1796                     ; 382 {
1797                     .text:	section	.text,new
1798  0000               _gesture_action:
1800  0000 88            	push	a
1801       00000001      OFST:	set	1
1804                     ; 385 	num = get_gesture_num(st1.ges_h, st1.ges_l, GET_SETTED_NUM);		//判断是否已保存过相同手势
1806  0001 4b01          	push	#1
1807  0003 c60021        	ld	a,_st1+33
1808  0006 97            	ld	xl,a
1809  0007 c60020        	ld	a,_st1+32
1810  000a 95            	ld	xh,a
1811  000b cd0000        	call	_get_gesture_num
1813  000e 5b01          	addw	sp,#1
1814  0010 6b01          	ld	(OFST+0,sp),a
1815                     ; 387 	if(num != GET_GESTURE_ERROR){		//有相同手势
1817  0012 7b01          	ld	a,(OFST+0,sp)
1818  0014 a1ff          	cp	a,#255
1819  0016 270b          	jreq	L544
1820                     ; 389 		send_action_ctrl(num, GESTURE_CTRL);
1822  0018 ae0002        	ldw	x,#2
1823  001b 7b01          	ld	a,(OFST+0,sp)
1824  001d 95            	ld	xh,a
1825  001e cd0000        	call	_send_action_ctrl
1828  0021 2009          	jra	L744
1829  0023               L544:
1830                     ; 395 		send_action_without_setted(num, GESTURE_CTRL);
1832  0023 ae0002        	ldw	x,#2
1833  0026 7b01          	ld	a,(OFST+0,sp)
1834  0028 95            	ld	xh,a
1835  0029 cd0000        	call	_send_action_without_setted
1837  002c               L744:
1838                     ; 403 }
1841  002c 84            	pop	a
1842  002d 81            	ret
1883                     ; 408 void gesture_analyze(u8 motion)
1883                     ; 409 {
1884                     .text:	section	.text,new
1885  0000               _gesture_analyze:
1887  0000 88            	push	a
1888  0001 88            	push	a
1889       00000001      OFST:	set	1
1892                     ; 410 	u8 reset = 0;
1894  0002 0f01          	clr	(OFST+0,sp)
1895                     ; 412 	st1.ges_cnt++;
1897  0004 725c001e      	inc	_st1+30
1898                     ; 414 	if((st1.ges_led_ctrl != 0xff) && motion){		/* 上次的保持时间已经结束 */
1900  0008 c6001d        	ld	a,_st1+29
1901  000b a1ff          	cp	a,#255
1902  000d 275a          	jreq	L764
1904  000f 0d02          	tnz	(OFST+1,sp)
1905  0011 2756          	jreq	L764
1906                     ; 416 		st1.ges_led_ctrl = 1;
1908  0013 3501001d      	mov	_st1+29,#1
1909                     ; 418 		if(st1.ges_cnt == 1) {
1911  0017 c6001e        	ld	a,_st1+30
1912  001a a101          	cp	a,#1
1913  001c 2613          	jrne	L174
1914                     ; 420 			st1.ges_timer = 0;
1916  001e 725f001f      	clr	_st1+31
1917                     ; 422 			st1.ges_h |= motion << 4;
1919  0022 7b02          	ld	a,(OFST+1,sp)
1920  0024 97            	ld	xl,a
1921  0025 a610          	ld	a,#16
1922  0027 42            	mul	x,a
1923  0028 9f            	ld	a,xl
1924  0029 ca0020        	or	a,_st1+32
1925  002c c70020        	ld	_st1+32,a
1927  002f 203c          	jra	L505
1928  0031               L174:
1929                     ; 424 		} else if(st1.ges_cnt == 2) {
1931  0031 c6001e        	ld	a,_st1+30
1932  0034 a102          	cp	a,#2
1933  0036 260a          	jrne	L574
1934                     ; 427 			st1.ges_h |= motion;
1936  0038 c60020        	ld	a,_st1+32
1937  003b 1a02          	or	a,(OFST+1,sp)
1938  003d c70020        	ld	_st1+32,a
1940  0040 202b          	jra	L505
1941  0042               L574:
1942                     ; 429 		} else if(st1.ges_cnt == 3) {
1944  0042 c6001e        	ld	a,_st1+30
1945  0045 a103          	cp	a,#3
1946  0047 261a          	jrne	L105
1947                     ; 432 			st1.ges_l |= motion << 4;
1949  0049 7b02          	ld	a,(OFST+1,sp)
1950  004b 97            	ld	xl,a
1951  004c a610          	ld	a,#16
1952  004e 42            	mul	x,a
1953  004f 9f            	ld	a,xl
1954  0050 ca0021        	or	a,_st1+33
1955  0053 c70021        	ld	_st1+33,a
1956                     ; 434 			st1.ges_led_ctrl = 0xff;
1958  0056 35ff001d      	mov	_st1+29,#255
1959                     ; 435 			gesture_action();
1961  005a cd0000        	call	_gesture_action
1963                     ; 436 			reset = 1;
1965  005d a601          	ld	a,#1
1966  005f 6b01          	ld	(OFST+0,sp),a
1968  0061 200a          	jra	L505
1969  0063               L105:
1970                     ; 439 			reset = 1;
1972  0063 a601          	ld	a,#1
1973  0065 6b01          	ld	(OFST+0,sp),a
1974  0067 2004          	jra	L505
1975  0069               L764:
1976                     ; 443 		reset = 1;
1978  0069 a601          	ld	a,#1
1979  006b 6b01          	ld	(OFST+0,sp),a
1980  006d               L505:
1981                     ; 446 	if(reset == 1){
1983  006d 7b01          	ld	a,(OFST+0,sp)
1984  006f a101          	cp	a,#1
1985  0071 2610          	jrne	L705
1986                     ; 447 		st1.ges_timer = 0;
1988  0073 725f001f      	clr	_st1+31
1989                     ; 448 		st1.ges_cnt = 0;
1991  0077 725f001e      	clr	_st1+30
1992                     ; 449 		st1.ges_l = 0;
1994  007b 725f0021      	clr	_st1+33
1995                     ; 450 		st1.ges_h = 0;
1997  007f 725f0020      	clr	_st1+32
1998  0083               L705:
1999                     ; 453 }
2002  0083 85            	popw	x
2003  0084 81            	ret
2006                     	switch	.data
2007  001c               L115_status:
2008  001c 04            	dc.b	4
2103                     ; 460 void gesture_detect(void)
2103                     ; 461 {
2104                     .text:	section	.text,new
2105  0000               _gesture_detect:
2107  0000 89            	pushw	x
2108       00000002      OFST:	set	2
2111                     ; 463 	u8 ret, motion = 0;
2113  0001 0f01          	clr	(OFST-1,sp)
2114                     ; 465 	switch(status){
2116  0003 c6001c        	ld	a,L115_status
2118                     ; 525 			break;
2119  0006 4a            	dec	a
2120  0007 2723          	jreq	L515
2121  0009 4a            	dec	a
2122  000a 2746          	jreq	L715
2123  000c 4a            	dec	a
2124  000d 274e          	jreq	L125
2125  000f 4a            	dec	a
2126  0010 270a          	jreq	L315
2127  0012               L325:
2128                     ; 522 		default:
2128                     ; 523 			status = GESTURE_IDLE;
2130  0012 3504001c      	mov	L115_status,#4
2131                     ; 524 			GESTURE_ISR_FLAG = 0;
2133  0016 725f0000      	clr	_GESTURE_ISR_FLAG
2134                     ; 525 			break;
2136  001a 2079          	jra	L765
2137  001c               L315:
2138                     ; 467 		case GESTURE_IDLE:
2138                     ; 468 			if(GESTURE_ISR_FLAG){		//有中断
2140  001c 725d0000      	tnz	_GESTURE_ISR_FLAG
2141  0020 2773          	jreq	L765
2142                     ; 469 				status = GESTURE_CHECK;			
2144  0022 3501001c      	mov	L115_status,#1
2145                     ; 470 				GESTURE_ISR_FLAG = 0;
2147  0026 725f0000      	clr	_GESTURE_ISR_FLAG
2148  002a 2069          	jra	L765
2149  002c               L515:
2150                     ; 474 		case GESTURE_CHECK:
2150                     ; 475 			 /* Make sure that power and gesture is on and data is valid */
2150                     ; 476 			if(isGestureAvailable() && (getMode() & 0x41)){
2152  002c cd0000        	call	_isGestureAvailable
2154  002f 4d            	tnz	a
2155  0030 2716          	jreq	L375
2157  0032 cd0000        	call	_getMode
2159  0035 a541          	bcp	a,#65
2160  0037 270f          	jreq	L375
2161                     ; 477 				resetGestureParameters();
2163  0039 cd0000        	call	_resetGestureParameters
2165                     ; 479 				GestureTimeOut = 30;
2167  003c ae001e        	ldw	x,#30
2168  003f cf0000        	ldw	_GestureTimeOut,x
2169                     ; 481 				status = GESTURE_WAIT;
2171  0042 3502001c      	mov	L115_status,#2
2173  0046 204d          	jra	L765
2174  0048               L375:
2175                     ; 484 				status = GESTURE_IDLE;
2177  0048 3504001c      	mov	L115_status,#4
2178                     ; 485 				GESTURE_ISR_FLAG = 0;
2180  004c 725f0000      	clr	_GESTURE_ISR_FLAG
2181  0050 2043          	jra	L765
2182  0052               L715:
2183                     ; 490 		case GESTURE_WAIT:			 /* Wait some time to collect next batch of FIFO data */
2183                     ; 491 			if(GestureTimeOut == 0){
2185  0052 ce0000        	ldw	x,_GestureTimeOut
2186  0055 263e          	jrne	L765
2187                     ; 492 				status = GESTURE_GET;
2189  0057 3503001c      	mov	L115_status,#3
2190  005b 2038          	jra	L765
2191  005d               L125:
2192                     ; 496 		case GESTURE_GET:
2192                     ; 497 
2192                     ; 498 			ret = gesture_read_data(&motion);
2194  005d 96            	ldw	x,sp
2195  005e 1c0001        	addw	x,#OFST-1
2196  0061 cd0000        	call	_gesture_read_data
2198  0064 6b02          	ld	(OFST+0,sp),a
2199                     ; 499 			if(ret == 1){				//结束
2201  0066 7b02          	ld	a,(OFST+0,sp)
2202  0068 a101          	cp	a,#1
2203  006a 260f          	jrne	L106
2204                     ; 501 				status = GESTURE_IDLE;
2206  006c 3504001c      	mov	L115_status,#4
2207                     ; 502 				GESTURE_ISR_FLAG = 0;
2209  0070 725f0000      	clr	_GESTURE_ISR_FLAG
2210                     ; 504 				gesture_analyze(motion);
2212  0074 7b01          	ld	a,(OFST-1,sp)
2213  0076 cd0000        	call	_gesture_analyze
2216  0079 201a          	jra	L765
2217  007b               L106:
2218                     ; 511 			}else if(ret == 0xff){		//未结束
2220  007b 7b02          	ld	a,(OFST+0,sp)
2221  007d a1ff          	cp	a,#255
2222  007f 260c          	jrne	L506
2223                     ; 513 				GestureTimeOut = 30;			/* 30 */			
2225  0081 ae001e        	ldw	x,#30
2226  0084 cf0000        	ldw	_GestureTimeOut,x
2227                     ; 514 				status = GESTURE_WAIT;	
2229  0087 3502001c      	mov	L115_status,#2
2231  008b 2008          	jra	L765
2232  008d               L506:
2233                     ; 517 				status = GESTURE_IDLE;
2235  008d 3504001c      	mov	L115_status,#4
2236                     ; 518 				GESTURE_ISR_FLAG = 0;
2238  0091 725f0000      	clr	_GESTURE_ISR_FLAG
2239  0095               L765:
2240                     ; 529 }
2243  0095 85            	popw	x
2244  0096 81            	ret
2247                     	switch	.data
2248  001d               L116_ambient_light:
2249  001d 0000          	dc.w	0
2250  001f               L316_red_light:
2251  001f 0000          	dc.w	0
2252  0021               L516_green_light:
2253  0021 0000          	dc.w	0
2254  0023               L716_blue_light:
2255  0023 0000          	dc.w	0
2256  0025               L126_threshold:
2257  0025 0000          	dc.w	0
2328                     ; 535 void gesture_lightCheck(void)
2328                     ; 536 {
2329                     .text:	section	.text,new
2330  0000               _gesture_lightCheck:
2334                     ; 545 	if ( !init() ) {
2336  0000 cd0000        	call	_init
2338  0003 4d            	tnz	a
2339  0004 2601          	jrne	L746
2340                     ; 546 		return;
2343  0006 81            	ret
2344  0007               L746:
2345                     ; 551 	if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
2347  0007 ae000a        	ldw	x,#10
2348  000a cd0000        	call	_setLightIntLowThreshold
2350  000d 4d            	tnz	a
2351  000e 2601          	jrne	L156
2352                     ; 553 		return;
2355  0010 81            	ret
2356  0011               L156:
2357                     ; 555 	if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
2359  0011 ae03e8        	ldw	x,#1000
2360  0014 cd0000        	call	_setLightIntHighThreshold
2362  0017 4d            	tnz	a
2363  0018 2601          	jrne	L356
2364                     ; 557 		return;
2367  001a 81            	ret
2368  001b               L356:
2369                     ; 561 	if ( enableLightSensor(0) ) {
2371  001b 4f            	clr	a
2372  001c cd0000        	call	_enableLightSensor
2374  001f 4d            	tnz	a
2375  0020 270a          	jreq	L556
2377                     ; 569 	if ( !getLightIntLowThreshold(&threshold) ) {
2379  0022 ae0025        	ldw	x,#L126_threshold
2380  0025 cd0000        	call	_getLightIntLowThreshold
2382  0028 4d            	tnz	a
2383  0029 2602          	jrne	L366
2384                     ; 571 		return;
2387  002b 81            	ret
2388  002c               L556:
2389                     ; 565 		return;
2392  002c 81            	ret
2393  002d               L366:
2394                     ; 575 	if ( !getLightIntHighThreshold(&threshold) ) {
2396  002d ae0025        	ldw	x,#L126_threshold
2397  0030 cd0000        	call	_getLightIntHighThreshold
2399  0033 4d            	tnz	a
2400  0034 2601          	jrne	L566
2401                     ; 577 		return;
2404  0036 81            	ret
2405  0037               L566:
2406                     ; 580 	if ( !setAmbientLightIntEnable(0) ) {
2408  0037 4f            	clr	a
2409  0038 cd0000        	call	_setAmbientLightIntEnable
2411  003b 4d            	tnz	a
2412  003c 2601          	jrne	L766
2413                     ; 581 		return;
2416  003e 81            	ret
2417  003f               L766:
2418                     ; 585 	if (  !readAmbientLight(&ambient_light) ||
2418                     ; 586 	        !readRedLight(&red_light) ||
2418                     ; 587 	        !readGreenLight(&green_light) ||
2418                     ; 588 	        !readBlueLight(&blue_light) ) {
2420  003f ae001d        	ldw	x,#L116_ambient_light
2421  0042 cd0000        	call	_readAmbientLight
2423  0045 4d            	tnz	a
2424  0046 271b          	jreq	L376
2426  0048 ae001f        	ldw	x,#L316_red_light
2427  004b cd0000        	call	_readRedLight
2429  004e 4d            	tnz	a
2430  004f 2712          	jreq	L376
2432  0051 ae0021        	ldw	x,#L516_green_light
2433  0054 cd0000        	call	_readGreenLight
2435  0057 4d            	tnz	a
2436  0058 2709          	jreq	L376
2438  005a ae0023        	ldw	x,#L716_blue_light
2439  005d cd0000        	call	_readBlueLight
2441  0060 4d            	tnz	a
2442  0061 2601          	jrne	L176
2443  0063               L376:
2444                     ; 590 		return;
2447  0063 81            	ret
2448  0064               L176:
2449                     ; 594 	if ( !clearAmbientLightInt() ) {
2451  0064 cd0000        	call	_clearAmbientLightInt
2453  0067 4d            	tnz	a
2454  0068 2601          	jrne	L107
2455                     ; 596 		return;
2458  006a 81            	ret
2459  006b               L107:
2460                     ; 598 	enableGestureSensor(1);
2462  006b a601          	ld	a,#1
2463  006d cd0000        	call	_enableGestureSensor
2465                     ; 600 }
2468  0070 81            	ret
2471                     	switch	.data
2472  0027               L307_threshold:
2473  0027 0000          	dc.w	0
2516                     ; 606 void APDS9960_Light_init(void)
2516                     ; 607 {
2517                     .text:	section	.text,new
2518  0000               _APDS9960_Light_init:
2522                     ; 611 	if ( !setLightIntLowThreshold(LIGHT_INT_LOW) ) {
2524  0000 ae000a        	ldw	x,#10
2525  0003 cd0000        	call	_setLightIntLowThreshold
2527  0006 4d            	tnz	a
2528  0007 2601          	jrne	L127
2529                     ; 613 		return;
2532  0009 81            	ret
2533  000a               L127:
2534                     ; 615 	if ( !setLightIntHighThreshold(LIGHT_INT_HIGH) ) {
2536  000a ae03e8        	ldw	x,#1000
2537  000d cd0000        	call	_setLightIntHighThreshold
2539  0010 4d            	tnz	a
2540  0011 2601          	jrne	L327
2541                     ; 617 		return;
2544  0013 81            	ret
2545  0014               L327:
2546                     ; 621 	if ( enableLightSensor(0) ) {
2548  0014 4f            	clr	a
2549  0015 cd0000        	call	_enableLightSensor
2551  0018 4d            	tnz	a
2552  0019 270a          	jreq	L527
2554                     ; 629 	if ( !getLightIntLowThreshold(&threshold) ) {
2556  001b ae0027        	ldw	x,#L307_threshold
2557  001e cd0000        	call	_getLightIntLowThreshold
2559  0021 4d            	tnz	a
2560  0022 2602          	jrne	L337
2561                     ; 631 		return;
2564  0024 81            	ret
2565  0025               L527:
2566                     ; 625 		return;
2569  0025 81            	ret
2570  0026               L337:
2571                     ; 635 	if ( !getLightIntHighThreshold(&threshold) ) {
2573  0026 ae0027        	ldw	x,#L307_threshold
2574  0029 cd0000        	call	_getLightIntHighThreshold
2576  002c 4d            	tnz	a
2577  002d 2601          	jrne	L537
2578                     ; 637 		return;
2581  002f 81            	ret
2582  0030               L537:
2583                     ; 640 	if ( !setAmbientLightIntEnable(0) ) {
2585  0030 4f            	clr	a
2586  0031 cd0000        	call	_setAmbientLightIntEnable
2588  0034 4d            	tnz	a
2589  0035 2601          	jrne	L737
2590                     ; 641 		return;
2593  0037 81            	ret
2594  0038               L737:
2595                     ; 645 	if (  !readAmbientLight(&APDS9960_Light.ambient) ||
2595                     ; 646 			!readRedLight(&APDS9960_Light.red) ||
2595                     ; 647 			!readGreenLight(&APDS9960_Light.green) ||
2595                     ; 648 			!readBlueLight(&APDS9960_Light.blue) ) {
2597  0038 ae0001        	ldw	x,#_APDS9960_Light
2598  003b cd0000        	call	_readAmbientLight
2600  003e 4d            	tnz	a
2601  003f 271b          	jreq	L347
2603  0041 ae0003        	ldw	x,#_APDS9960_Light+2
2604  0044 cd0000        	call	_readRedLight
2606  0047 4d            	tnz	a
2607  0048 2712          	jreq	L347
2609  004a ae0005        	ldw	x,#_APDS9960_Light+4
2610  004d cd0000        	call	_readGreenLight
2612  0050 4d            	tnz	a
2613  0051 2709          	jreq	L347
2615  0053 ae0007        	ldw	x,#_APDS9960_Light+6
2616  0056 cd0000        	call	_readBlueLight
2618  0059 4d            	tnz	a
2619  005a 2601          	jrne	L147
2620  005c               L347:
2621                     ; 649 		return;
2624  005c 81            	ret
2625  005d               L147:
2626                     ; 653 	if ( !clearAmbientLightInt() ) {
2628  005d cd0000        	call	_clearAmbientLightInt
2630  0060 4d            	tnz	a
2631  0061 2601          	jrne	L157
2632                     ; 655 		return;
2635  0063 81            	ret
2636  0064               L157:
2637                     ; 660 }
2640  0064 81            	ret
2671                     ; 665 void APDS9960_Light_read(void)
2671                     ; 666 {
2672                     .text:	section	.text,new
2673  0000               _APDS9960_Light_read:
2677                     ; 669 	if (  !readAmbientLight(&APDS9960_Light.ambient) ||
2677                     ; 670 			!readRedLight(&APDS9960_Light.red) ||
2677                     ; 671 			!readGreenLight(&APDS9960_Light.green) ||
2677                     ; 672 			!readBlueLight(&APDS9960_Light.blue) ) {
2679  0000 ae0001        	ldw	x,#_APDS9960_Light
2680  0003 cd0000        	call	_readAmbientLight
2682  0006 4d            	tnz	a
2683  0007 271b          	jreq	L567
2685  0009 ae0003        	ldw	x,#_APDS9960_Light+2
2686  000c cd0000        	call	_readRedLight
2688  000f 4d            	tnz	a
2689  0010 2712          	jreq	L567
2691  0012 ae0005        	ldw	x,#_APDS9960_Light+4
2692  0015 cd0000        	call	_readGreenLight
2694  0018 4d            	tnz	a
2695  0019 2709          	jreq	L567
2697  001b ae0007        	ldw	x,#_APDS9960_Light+6
2698  001e cd0000        	call	_readBlueLight
2700  0021 4d            	tnz	a
2701  0022 2601          	jrne	L367
2702  0024               L567:
2703                     ; 673 		return;
2706  0024 81            	ret
2707  0025               L367:
2708                     ; 677 	if ( !clearAmbientLightInt() ) {
2710  0025 cd0000        	call	_clearAmbientLightInt
2712  0028 4d            	tnz	a
2713  0029 2601          	jrne	L377
2714                     ; 678 		return;
2717  002b 81            	ret
2718  002c               L377:
2719                     ; 682 	BLE_uart.txBuf[0] = (u8)(APDS9960_Light.ambient >> 8);
2721  002c 5500010024    	mov	_BLE_uart+36,_APDS9960_Light
2722                     ; 683 	BLE_uart.txBuf[1] = (u8)APDS9960_Light.ambient;
2724  0031 5500020025    	mov	_BLE_uart+37,_APDS9960_Light+1
2725                     ; 684 	BLE_uart.txBuf[2] = (u8)(APDS9960_Light.red >> 8);
2727  0036 5500030026    	mov	_BLE_uart+38,_APDS9960_Light+2
2728                     ; 685 	BLE_uart.txBuf[3] = (u8)APDS9960_Light.red;
2730  003b 5500040027    	mov	_BLE_uart+39,_APDS9960_Light+3
2731                     ; 686 	BLE_uart.txBuf[4] = (u8)(APDS9960_Light.green >> 8);
2733  0040 5500050028    	mov	_BLE_uart+40,_APDS9960_Light+4
2734                     ; 687 	BLE_uart.txBuf[5] = (u8)APDS9960_Light.green;
2736  0045 5500060029    	mov	_BLE_uart+41,_APDS9960_Light+5
2737                     ; 688 	BLE_uart.txBuf[6] = (u8)(APDS9960_Light.blue >> 8);
2739  004a 550007002a    	mov	_BLE_uart+42,_APDS9960_Light+6
2740                     ; 689 	BLE_uart.txBuf[7] = (u8)APDS9960_Light.blue;
2742  004f 550008002b    	mov	_BLE_uart+43,_APDS9960_Light+7
2743                     ; 691 	BLE_uart.txCnt = 1;
2745  0054 35010001      	mov	_BLE_uart+1,#1
2746                     ; 692 	BLE_uart.txLen = 8;
2748  0058 35080000      	mov	_BLE_uart,#8
2749                     ; 694 	BLE_UART->DR = BLE_uart.txBuf[0];
2751  005c 5500245231    	mov	21041,_BLE_uart+36
2753  0061               L1001:
2754                     ; 696 	while(BLE_uart.txCnt);		//等待发送结束 
2756  0061 725d0001      	tnz	_BLE_uart+1
2757  0065 26fa          	jrne	L1001
2758                     ; 698 }
2761  0067 81            	ret
2793                     ; 700 void KEYPAD_LED_REVERSE(u8 i)
2793                     ; 701 {
2794                     .text:	section	.text,new
2795  0000               _KEYPAD_LED_REVERSE:
2797  0000 88            	push	a
2798       00000000      OFST:	set	0
2801                     ; 702 	if(i == 0) KEYPAD1_LED_REVERSE; 
2803  0001 4d            	tnz	a
2804  0002 2608          	jrne	L1201
2807  0004 c6500a        	ld	a,20490
2808  0007 a808          	xor	a,	#8
2809  0009 c7500a        	ld	20490,a
2810  000c               L1201:
2811                     ; 703 	if(i == 1) KEYPAD2_LED_REVERSE; 
2813  000c 7b01          	ld	a,(OFST+1,sp)
2814  000e a101          	cp	a,#1
2815  0010 2608          	jrne	L3201
2818  0012 c6500a        	ld	a,20490
2819  0015 a804          	xor	a,	#4
2820  0017 c7500a        	ld	20490,a
2821  001a               L3201:
2822                     ; 704 	if(i == 2) KEYPAD3_LED_REVERSE;
2824  001a 7b01          	ld	a,(OFST+1,sp)
2825  001c a102          	cp	a,#2
2826  001e 2608          	jrne	L5201
2829  0020 c6500a        	ld	a,20490
2830  0023 a802          	xor	a,	#2
2831  0025 c7500a        	ld	20490,a
2832  0028               L5201:
2833                     ; 706 }
2836  0028 84            	pop	a
2837  0029 81            	ret
2869                     ; 707 void KEYPAD_LED_ON(u8 i)
2869                     ; 708 {
2870                     .text:	section	.text,new
2871  0000               _KEYPAD_LED_ON:
2873  0000 88            	push	a
2874       00000000      OFST:	set	0
2877                     ; 709 	if(i == 0) KEYPAD1_LED_ON; 
2879  0001 4d            	tnz	a
2880  0002 2604          	jrne	L3401
2883  0004 7216500a      	bset	20490,#3
2884  0008               L3401:
2885                     ; 710 	if(i == 1) KEYPAD2_LED_ON; 
2887  0008 7b01          	ld	a,(OFST+1,sp)
2888  000a a101          	cp	a,#1
2889  000c 2604          	jrne	L5401
2892  000e 7214500a      	bset	20490,#2
2893  0012               L5401:
2894                     ; 711 	if(i == 2) KEYPAD3_LED_ON;
2896  0012 7b01          	ld	a,(OFST+1,sp)
2897  0014 a102          	cp	a,#2
2898  0016 2604          	jrne	L7401
2901  0018 7212500a      	bset	20490,#1
2902  001c               L7401:
2903                     ; 713 }
2906  001c 84            	pop	a
2907  001d 81            	ret
2939                     ; 714 void KEYPAD_LED_OFF(u8 i)
2939                     ; 715 {
2940                     .text:	section	.text,new
2941  0000               _KEYPAD_LED_OFF:
2943  0000 88            	push	a
2944       00000000      OFST:	set	0
2947                     ; 716 	if(i == 0) KEYPAD1_LED_OFF; 
2949  0001 4d            	tnz	a
2950  0002 2604          	jrne	L5601
2953  0004 7217500a      	bres	20490,#3
2954  0008               L5601:
2955                     ; 717 	if(i == 1) KEYPAD2_LED_OFF; 
2957  0008 7b01          	ld	a,(OFST+1,sp)
2958  000a a101          	cp	a,#1
2959  000c 2604          	jrne	L7601
2962  000e 7215500a      	bres	20490,#2
2963  0012               L7601:
2964                     ; 718 	if(i == 2) KEYPAD3_LED_OFF;
2966  0012 7b01          	ld	a,(OFST+1,sp)
2967  0014 a102          	cp	a,#2
2968  0016 2604          	jrne	L1701
2971  0018 7213500a      	bres	20490,#1
2972  001c               L1701:
2973                     ; 720 }
2976  001c 84            	pop	a
2977  001d 81            	ret
3012                     ; 724 void keypad_led_show(void)
3012                     ; 725 {
3013                     .text:	section	.text,new
3014  0000               _keypad_led_show:
3016  0000 88            	push	a
3017       00000001      OFST:	set	1
3020                     ; 728 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
3022  0001 0f01          	clr	(OFST+0,sp)
3023  0003               L7011:
3024                     ; 730 		if(mpr121_handle.keyLEDStatus[i] == 0){
3026  0003 7b01          	ld	a,(OFST+0,sp)
3027  0005 5f            	clrw	x
3028  0006 97            	ld	xl,a
3029  0007 724d0009      	tnz	(_mpr121_handle+9,x)
3030  000b 2607          	jrne	L5111
3031                     ; 731 			KEYPAD_LED_OFF(i);
3033  000d 7b01          	ld	a,(OFST+0,sp)
3034  000f cd0000        	call	_KEYPAD_LED_OFF
3037  0012 2070          	jra	L7111
3038  0014               L5111:
3039                     ; 733 		}else if(mpr121_handle.keyLEDStatus[i] == 1){
3041  0014 7b01          	ld	a,(OFST+0,sp)
3042  0016 5f            	clrw	x
3043  0017 97            	ld	xl,a
3044  0018 d60009        	ld	a,(_mpr121_handle+9,x)
3045  001b a101          	cp	a,#1
3046  001d 2607          	jrne	L1211
3047                     ; 734 			KEYPAD_LED_ON(i);
3049  001f 7b01          	ld	a,(OFST+0,sp)
3050  0021 cd0000        	call	_KEYPAD_LED_ON
3053  0024 205e          	jra	L7111
3054  0026               L1211:
3055                     ; 736 		}else if(mpr121_handle.keyLEDStatus[i] == 2){
3057  0026 7b01          	ld	a,(OFST+0,sp)
3058  0028 5f            	clrw	x
3059  0029 97            	ld	xl,a
3060  002a d60009        	ld	a,(_mpr121_handle+9,x)
3061  002d a102          	cp	a,#2
3062  002f 261a          	jrne	L5211
3063                     ; 737 			if(mpr121_handle.keyLEDCnt[i] >= MPR121_KEYPAD_RELEASE_LED_DELAY){
3065  0031 7b01          	ld	a,(OFST+0,sp)
3066  0033 5f            	clrw	x
3067  0034 97            	ld	xl,a
3068  0035 d60006        	ld	a,(_mpr121_handle+6,x)
3069  0038 a102          	cp	a,#2
3070  003a 2548          	jrult	L7111
3071                     ; 738 				KEYPAD_LED_OFF(i);
3073  003c 7b01          	ld	a,(OFST+0,sp)
3074  003e cd0000        	call	_KEYPAD_LED_OFF
3076                     ; 739 				mpr121_handle.keyLEDStatus[i] = 0;				
3078  0041 7b01          	ld	a,(OFST+0,sp)
3079  0043 5f            	clrw	x
3080  0044 97            	ld	xl,a
3081  0045 724f0009      	clr	(_mpr121_handle+9,x)
3082  0049 2039          	jra	L7111
3083  004b               L5211:
3084                     ; 742 		}else if(mpr121_handle.keyLEDStatus[i] == 3){			/* 长按等待，时间由longTouch控制  */
3086  004b 7b01          	ld	a,(OFST+0,sp)
3087  004d 5f            	clrw	x
3088  004e 97            	ld	xl,a
3089  004f d60009        	ld	a,(_mpr121_handle+9,x)
3090  0052 a103          	cp	a,#3
3091  0054 2626          	jrne	L3311
3092                     ; 743 			if(((mpr121_handle.keyLEDCnt[i] /3) % 2) == 0){		/* 每0.5s一个单位，先灭再亮 */
3094  0056 7b01          	ld	a,(OFST+0,sp)
3095  0058 5f            	clrw	x
3096  0059 97            	ld	xl,a
3097  005a d60006        	ld	a,(_mpr121_handle+6,x)
3098  005d 5f            	clrw	x
3099  005e 97            	ld	xl,a
3100  005f a603          	ld	a,#3
3101  0061 cd0000        	call	c_sdivx
3103  0064 a602          	ld	a,#2
3104  0066 cd0000        	call	c_smodx
3106  0069 a30000        	cpw	x,#0
3107  006c 2607          	jrne	L5311
3108                     ; 744 				KEYPAD_LED_OFF(i);
3110  006e 7b01          	ld	a,(OFST+0,sp)
3111  0070 cd0000        	call	_KEYPAD_LED_OFF
3114  0073 200f          	jra	L7111
3115  0075               L5311:
3116                     ; 746 				KEYPAD_LED_ON(i);
3118  0075 7b01          	ld	a,(OFST+0,sp)
3119  0077 cd0000        	call	_KEYPAD_LED_ON
3121  007a 2008          	jra	L7111
3122  007c               L3311:
3123                     ; 750 			mpr121_handle.keyLEDStatus[i] = 0;				
3125  007c 7b01          	ld	a,(OFST+0,sp)
3126  007e 5f            	clrw	x
3127  007f 97            	ld	xl,a
3128  0080 724f0009      	clr	(_mpr121_handle+9,x)
3129  0084               L7111:
3130                     ; 728 	for(i = 0; i < MPR121_KEYPAD_NUMS; i++){
3132  0084 0c01          	inc	(OFST+0,sp)
3135  0086 7b01          	ld	a,(OFST+0,sp)
3136  0088 a103          	cp	a,#3
3137  008a 2403cc0003    	jrult	L7011
3138                     ; 756 }
3141  008f 84            	pop	a
3142  0090 81            	ret
3166                     ; 761 void keypad_led_init(void)
3166                     ; 762 {
3167                     .text:	section	.text,new
3168  0000               _keypad_led_init:
3172                     ; 764   	GPIO_Init(KEYPAD1_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD1_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3174  0000 4bc0          	push	#192
3175  0002 4b08          	push	#8
3176  0004 ae500a        	ldw	x,#20490
3177  0007 cd0000        	call	_GPIO_Init
3179  000a 85            	popw	x
3180                     ; 765   	GPIO_Init(KEYPAD2_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD2_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3182  000b 4bc0          	push	#192
3183  000d 4b04          	push	#4
3184  000f ae500a        	ldw	x,#20490
3185  0012 cd0000        	call	_GPIO_Init
3187  0015 85            	popw	x
3188                     ; 766   	GPIO_Init(KEYPAD3_LED_PORT, (GPIO_Pin_TypeDef)KEYPAD3_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3190  0016 4bc0          	push	#192
3191  0018 4b02          	push	#2
3192  001a ae500a        	ldw	x,#20490
3193  001d cd0000        	call	_GPIO_Init
3195  0020 85            	popw	x
3196                     ; 768 }
3199  0021 81            	ret
3231                     ; 771 void SLIPPAD_LED_ON(u8 i)
3231                     ; 772 {
3232                     .text:	section	.text,new
3233  0000               _SLIPPAD_LED_ON:
3235  0000 88            	push	a
3236       00000000      OFST:	set	0
3239                     ; 773 	if(i == 1) SLIPPAD_LED1_ON; 
3241  0001 a101          	cp	a,#1
3242  0003 2604          	jrne	L7611
3245  0005 721c5014      	bset	20500,#6
3246  0009               L7611:
3247                     ; 774 	if(i == 2) SLIPPAD_LED2_ON; 
3249  0009 7b01          	ld	a,(OFST+1,sp)
3250  000b a102          	cp	a,#2
3251  000d 2604          	jrne	L1711
3254  000f 721e5014      	bset	20500,#7
3255  0013               L1711:
3256                     ; 775 	if(i == 3) SLIPPAD_LED3_ON; 
3258  0013 7b01          	ld	a,(OFST+1,sp)
3259  0015 a103          	cp	a,#3
3260  0017 2604          	jrne	L3711
3263  0019 72105005      	bset	20485,#0
3264  001d               L3711:
3265                     ; 776 	if(i == 4) SLIPPAD_LED4_ON; 
3267  001d 7b01          	ld	a,(OFST+1,sp)
3268  001f a104          	cp	a,#4
3269  0021 2604          	jrne	L5711
3272  0023 72125005      	bset	20485,#1
3273  0027               L5711:
3274                     ; 777 	if(i == 5) SLIPPAD_LED5_ON; 
3276  0027 7b01          	ld	a,(OFST+1,sp)
3277  0029 a105          	cp	a,#5
3278  002b 2604          	jrne	L7711
3281  002d 72145005      	bset	20485,#2
3282  0031               L7711:
3283                     ; 778 	if(i == 6) SLIPPAD_LED6_ON; 
3285  0031 7b01          	ld	a,(OFST+1,sp)
3286  0033 a106          	cp	a,#6
3287  0035 2604          	jrne	L1021
3290  0037 72165005      	bset	20485,#3
3291  003b               L1021:
3292                     ; 779 	if(i == 7) SLIPPAD_LED7_ON; 
3294  003b 7b01          	ld	a,(OFST+1,sp)
3295  003d a107          	cp	a,#7
3296  003f 2604          	jrne	L3021
3299  0041 72185005      	bset	20485,#4
3300  0045               L3021:
3301                     ; 780 	if(i == 8) SLIPPAD_LED8_ON; 
3303  0045 7b01          	ld	a,(OFST+1,sp)
3304  0047 a108          	cp	a,#8
3305  0049 2604          	jrne	L5021
3308  004b 721a5005      	bset	20485,#5
3309  004f               L5021:
3310                     ; 782 }
3313  004f 84            	pop	a
3314  0050 81            	ret
3346                     ; 783 void SLIPPAD_LED_OFF(u8 i)
3346                     ; 784 {
3347                     .text:	section	.text,new
3348  0000               _SLIPPAD_LED_OFF:
3350  0000 88            	push	a
3351       00000000      OFST:	set	0
3354                     ; 785 	if(i == 1) SLIPPAD_LED1_OFF; 
3356  0001 a101          	cp	a,#1
3357  0003 2604          	jrne	L3221
3360  0005 721d5014      	bres	20500,#6
3361  0009               L3221:
3362                     ; 786 	if(i == 2) SLIPPAD_LED2_OFF; 
3364  0009 7b01          	ld	a,(OFST+1,sp)
3365  000b a102          	cp	a,#2
3366  000d 2604          	jrne	L5221
3369  000f 721f5014      	bres	20500,#7
3370  0013               L5221:
3371                     ; 787 	if(i == 3) SLIPPAD_LED3_OFF; 
3373  0013 7b01          	ld	a,(OFST+1,sp)
3374  0015 a103          	cp	a,#3
3375  0017 2604          	jrne	L7221
3378  0019 72115005      	bres	20485,#0
3379  001d               L7221:
3380                     ; 788 	if(i == 4) SLIPPAD_LED4_OFF; 
3382  001d 7b01          	ld	a,(OFST+1,sp)
3383  001f a104          	cp	a,#4
3384  0021 2604          	jrne	L1321
3387  0023 72135005      	bres	20485,#1
3388  0027               L1321:
3389                     ; 789 	if(i == 5) SLIPPAD_LED5_OFF; 
3391  0027 7b01          	ld	a,(OFST+1,sp)
3392  0029 a105          	cp	a,#5
3393  002b 2604          	jrne	L3321
3396  002d 72155005      	bres	20485,#2
3397  0031               L3321:
3398                     ; 790 	if(i == 6) SLIPPAD_LED6_OFF; 
3400  0031 7b01          	ld	a,(OFST+1,sp)
3401  0033 a106          	cp	a,#6
3402  0035 2604          	jrne	L5321
3405  0037 72175005      	bres	20485,#3
3406  003b               L5321:
3407                     ; 791 	if(i == 7) SLIPPAD_LED7_OFF; 
3409  003b 7b01          	ld	a,(OFST+1,sp)
3410  003d a107          	cp	a,#7
3411  003f 2604          	jrne	L7321
3414  0041 72195005      	bres	20485,#4
3415  0045               L7321:
3416                     ; 792 	if(i == 8) SLIPPAD_LED8_OFF; 
3418  0045 7b01          	ld	a,(OFST+1,sp)
3419  0047 a108          	cp	a,#8
3420  0049 2604          	jrne	L1421
3423  004b 721b5005      	bres	20485,#5
3424  004f               L1421:
3425                     ; 794 }
3428  004f 84            	pop	a
3429  0050 81            	ret
3471                     ; 798 void slippad_led_show(void)
3471                     ; 799 {
3472                     .text:	section	.text,new
3473  0000               _slippad_led_show:
3475  0000 88            	push	a
3476       00000001      OFST:	set	1
3479                     ; 802 	onoff = 1;		/* 开启  */
3481  0001 a601          	ld	a,#1
3482  0003 6b01          	ld	(OFST+0,sp),a
3483                     ; 804 	if(mpr121_handle.longTouchSlipConfirm){		/* 屏蔽按键时闪烁 */
3485  0005 725d0016      	tnz	_mpr121_handle+22
3486  0009 2734          	jreq	L1621
3487                     ; 805 		if(mpr121_handle.longTouchHoldCnt < MPR121_LONG_TOUCH_CONFIRM_CNT){
3489  000b c60014        	ld	a,_mpr121_handle+20
3490  000e a114          	cp	a,#20
3491  0010 2418          	jruge	L3621
3492                     ; 806 			if(((mpr121_handle.longTouchHoldCnt /3) % 2) == 0){		/* 每0.5s一个单位，先灭再亮 */
3494  0012 c60014        	ld	a,_mpr121_handle+20
3495  0015 5f            	clrw	x
3496  0016 97            	ld	xl,a
3497  0017 a603          	ld	a,#3
3498  0019 cd0000        	call	c_sdivx
3500  001c a602          	ld	a,#2
3501  001e cd0000        	call	c_smodx
3503  0021 a30000        	cpw	x,#0
3504  0024 2619          	jrne	L1621
3505                     ; 807 				onoff = 0;
3507  0026 0f01          	clr	(OFST+0,sp)
3508  0028 2015          	jra	L1621
3509  002a               L3621:
3510                     ; 811 			mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;				/* 滑动LED 恢复原滑动值 */		
3512  002a c60013        	ld	a,_mpr121_handle+19
3513  002d 4c            	inc	a
3514  002e c70012        	ld	_mpr121_handle+18,a
3515                     ; 812 			mpr121_handle.keyLEDStatus[mpr121_handle.longTouchSlipConfirm -1] = 0;	/* 按键LED */		
3517  0031 c60016        	ld	a,_mpr121_handle+22
3518  0034 5f            	clrw	x
3519  0035 97            	ld	xl,a
3520  0036 5a            	decw	x
3521  0037 724f0009      	clr	(_mpr121_handle+9,x)
3522                     ; 813 			mpr121_handle.longTouchSlipConfirm = 0;		/* 结束屏蔽 */
3524  003b 725f0016      	clr	_mpr121_handle+22
3525  003f               L1621:
3526                     ; 817 	if(onoff){
3528  003f 0d01          	tnz	(OFST+0,sp)
3529  0041 2732          	jreq	L1721
3530                     ; 819 		if(mpr121_handle.slipValue == 1){			/* 关闭 */
3532  0043 c60012        	ld	a,_mpr121_handle+18
3533  0046 a101          	cp	a,#1
3534  0048 2606          	jrne	L3721
3535                     ; 820 			SLIPPAD_LED0_ON;
3537  004a 721a5014      	bset	20500,#5
3539  004e 2004          	jra	L5721
3540  0050               L3721:
3541                     ; 822 			SLIPPAD_LED0_OFF;
3543  0050 721b5014      	bres	20500,#5
3544  0054               L5721:
3545                     ; 825 		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){
3547  0054 a601          	ld	a,#1
3548  0056 6b01          	ld	(OFST+0,sp),a
3549  0058               L7721:
3550                     ; 827 			if(i < mpr121_handle.slipValue){
3552  0058 7b01          	ld	a,(OFST+0,sp)
3553  005a c10012        	cp	a,_mpr121_handle+18
3554  005d 2407          	jruge	L5031
3555                     ; 828 				SLIPPAD_LED_ON(i);
3557  005f 7b01          	ld	a,(OFST+0,sp)
3558  0061 cd0000        	call	_SLIPPAD_LED_ON
3561  0064 2005          	jra	L7031
3562  0066               L5031:
3563                     ; 830 				SLIPPAD_LED_OFF(i);
3565  0066 7b01          	ld	a,(OFST+0,sp)
3566  0068 cd0000        	call	_SLIPPAD_LED_OFF
3568  006b               L7031:
3569                     ; 825 		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){
3571  006b 0c01          	inc	(OFST+0,sp)
3574  006d 7b01          	ld	a,(OFST+0,sp)
3575  006f a109          	cp	a,#9
3576  0071 25e5          	jrult	L7721
3578  0073 2015          	jra	L1131
3579  0075               L1721:
3580                     ; 835 		SLIPPAD_LED0_OFF;		
3582  0075 721b5014      	bres	20500,#5
3583                     ; 836 		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){		
3585  0079 a601          	ld	a,#1
3586  007b 6b01          	ld	(OFST+0,sp),a
3587  007d               L3131:
3588                     ; 837 			SLIPPAD_LED_OFF(i);
3590  007d 7b01          	ld	a,(OFST+0,sp)
3591  007f cd0000        	call	_SLIPPAD_LED_OFF
3593                     ; 836 		for(i = 1; i < MPR121_SLIPPAD_LEVELS_NUM; i++){		
3595  0082 0c01          	inc	(OFST+0,sp)
3598  0084 7b01          	ld	a,(OFST+0,sp)
3599  0086 a109          	cp	a,#9
3600  0088 25f3          	jrult	L3131
3601  008a               L1131:
3602                     ; 841 }
3605  008a 84            	pop	a
3606  008b 81            	ret
3630                     ; 846 void slippad_led_init(void)
3630                     ; 847 {
3631                     .text:	section	.text,new
3632  0000               _slippad_led_init:
3636                     ; 849 	GPIO_Init(SLIPPAD_LED8_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED8_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3638  0000 4bc0          	push	#192
3639  0002 4b20          	push	#32
3640  0004 ae5005        	ldw	x,#20485
3641  0007 cd0000        	call	_GPIO_Init
3643  000a 85            	popw	x
3644                     ; 850 	GPIO_Init(SLIPPAD_LED7_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED7_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3646  000b 4bc0          	push	#192
3647  000d 4b10          	push	#16
3648  000f ae5005        	ldw	x,#20485
3649  0012 cd0000        	call	_GPIO_Init
3651  0015 85            	popw	x
3652                     ; 851 	GPIO_Init(SLIPPAD_LED6_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED6_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3654  0016 4bc0          	push	#192
3655  0018 4b08          	push	#8
3656  001a ae5005        	ldw	x,#20485
3657  001d cd0000        	call	_GPIO_Init
3659  0020 85            	popw	x
3660                     ; 852 	GPIO_Init(SLIPPAD_LED5_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED5_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3662  0021 4bc0          	push	#192
3663  0023 4b04          	push	#4
3664  0025 ae5005        	ldw	x,#20485
3665  0028 cd0000        	call	_GPIO_Init
3667  002b 85            	popw	x
3668                     ; 853 	GPIO_Init(SLIPPAD_LED4_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED4_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3670  002c 4bc0          	push	#192
3671  002e 4b02          	push	#2
3672  0030 ae5005        	ldw	x,#20485
3673  0033 cd0000        	call	_GPIO_Init
3675  0036 85            	popw	x
3676                     ; 854 	GPIO_Init(SLIPPAD_LED3_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED3_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3678  0037 4bc0          	push	#192
3679  0039 4b01          	push	#1
3680  003b ae5005        	ldw	x,#20485
3681  003e cd0000        	call	_GPIO_Init
3683  0041 85            	popw	x
3684                     ; 855 	GPIO_Init(SLIPPAD_LED2_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED2_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3686  0042 4bc0          	push	#192
3687  0044 4b80          	push	#128
3688  0046 ae5014        	ldw	x,#20500
3689  0049 cd0000        	call	_GPIO_Init
3691  004c 85            	popw	x
3692                     ; 856 	GPIO_Init(SLIPPAD_LED1_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED1_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3694  004d 4bc0          	push	#192
3695  004f 4b40          	push	#64
3696  0051 ae5014        	ldw	x,#20500
3697  0054 cd0000        	call	_GPIO_Init
3699  0057 85            	popw	x
3700                     ; 857 	GPIO_Init(SLIPPAD_LED0_PORT, (GPIO_Pin_TypeDef)SLIPPAD_LED0_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3702  0058 4bc0          	push	#192
3703  005a 4b20          	push	#32
3704  005c ae5014        	ldw	x,#20500
3705  005f cd0000        	call	_GPIO_Init
3707  0062 85            	popw	x
3708                     ; 859 }
3711  0063 81            	ret
3735                     ; 867 void Task_2ms(void)
3735                     ; 868 {
3736                     .text:	section	.text,new
3737  0000               _Task_2ms:
3741                     ; 869 	if(f_2ms) {
3743  0000 c60000        	ld	a,_baseTimeFlag
3744  0003 a501          	bcp	a,#1
3745  0005 2704          	jreq	L1431
3746                     ; 870 		f_2ms = 0;
3748  0007 72110000      	bres	_baseTimeFlag,#0
3749  000b               L1431:
3750                     ; 873 }
3753  000b 81            	ret
3781                     ; 879 void Task_100ms(void)
3781                     ; 880 {
3782                     .text:	section	.text,new
3783  0000               _Task_100ms:
3787                     ; 881 	if(f_100ms) {
3789  0000 c60000        	ld	a,_baseTimeFlag
3790  0003 a502          	bcp	a,#2
3791  0005 2710          	jreq	L3531
3792                     ; 882 		f_100ms = 0;
3794  0007 72130000      	bres	_baseTimeFlag,#1
3795                     ; 884 		gesture_timeout_check();
3797  000b cd0000        	call	_gesture_timeout_check
3799                     ; 885 		gesture_led_show();
3801  000e cd0000        	call	_gesture_led_show
3803                     ; 887 		MPR121_keyPad_hold_time_count();
3805  0011 cd0000        	call	_MPR121_keyPad_hold_time_count
3807                     ; 889 		MPR121_keyPad_slipPad_post();
3809  0014 cd0000        	call	_MPR121_keyPad_slipPad_post
3811  0017               L3531:
3812                     ; 892 }
3815  0017 81            	ret
3818                     	switch	.data
3819  0029               L5531_cnt_5s:
3820  0029 00            	dc.b	0
3853                     ; 898 void Task_1s(void)
3853                     ; 899 {
3854                     .text:	section	.text,new
3855  0000               _Task_1s:
3859                     ; 902 	if(f_1s) {
3861  0000 c60000        	ld	a,_baseTimeFlag
3862  0003 a504          	bcp	a,#4
3863  0005 272c          	jreq	L3731
3864                     ; 904 		f_1s = 0;
3866  0007 72150000      	bres	_baseTimeFlag,#2
3867                     ; 906 		SYSTEM_LED_REVERSE;
3869  000b c6500f        	ld	a,20495
3870  000e a880          	xor	a,	#128
3871  0010 c7500f        	ld	20495,a
3872                     ; 908 		if(rev_ssbroadcast == 0){		/* 还没发送deviceinfo */
3874  0013 c60000        	ld	a,_UART1Flag4_
3875  0016 a502          	bcp	a,#2
3876  0018 260a          	jrne	L5731
3877                     ; 909 			if(send_device_info_active()){
3879  001a cd0000        	call	_send_device_info_active
3881  001d 4d            	tnz	a
3882  001e 2704          	jreq	L5731
3883                     ; 910 				rev_ssbroadcast = 1;
3885  0020 72120000      	bset	_UART1Flag4_,#1
3886  0024               L5731:
3887                     ; 920 		cnt_5s++;
3889  0024 725c0029      	inc	L5531_cnt_5s
3890                     ; 921 		if(cnt_5s >= 5) {
3892  0028 c60029        	ld	a,L5531_cnt_5s
3893  002b a105          	cp	a,#5
3894  002d 2504          	jrult	L3731
3895                     ; 922 			cnt_5s = 0;
3897  002f 725f0029      	clr	L5531_cnt_5s
3898  0033               L3731:
3899                     ; 928 }
3902  0033 81            	ret
3925                     ; 935 void system_clock_set(void)
3925                     ; 936 {
3926                     .text:	section	.text,new
3927  0000               _system_clock_set:
3931                     ; 939 	CLK->SWCR |= 0x02; //开启切换
3933  0000 721250c5      	bset	20677,#1
3934                     ; 941 	CLK->SWR   = 0xb4;		 //选择时钟为外部16M
3936  0004 35b450c4      	mov	20676,#180
3938  0008               L7141:
3939                     ; 942 	while((CLK->SWCR & 0x01) == 0x01);
3941  0008 c650c5        	ld	a,20677
3942  000b a401          	and	a,#1
3943  000d a101          	cp	a,#1
3944  000f 27f7          	jreq	L7141
3945                     ; 943 	CLK->CKDIVR = 0x80;    //不分频
3947  0011 358050c6      	mov	20678,#128
3948                     ; 945 	CLK->SWCR  &= ~0x02; //关闭切换
3950  0015 721350c5      	bres	20677,#1
3951                     ; 947 }
3954  0019 81            	ret
3978                     ; 953 void system_led_init(void)
3978                     ; 954 {
3979                     .text:	section	.text,new
3980  0000               _system_led_init:
3984                     ; 956   	GPIO_Init(SYSTEM_LED_PORT, (GPIO_Pin_TypeDef)SYSTEM_LED_PIN, GPIO_MODE_OUT_PP_LOW_FAST); 
3986  0000 4bc0          	push	#192
3987  0002 4b80          	push	#128
3988  0004 ae500f        	ldw	x,#20495
3989  0007 cd0000        	call	_GPIO_Init
3991  000a 85            	popw	x
3992                     ; 958 }
3995  000b 81            	ret
4024                     ; 964 void system_variable_init(void)
4024                     ; 965 {
4025                     .text:	section	.text,new
4026  0000               _system_variable_init:
4030                     ; 967 	memset(&st1, 0, sizeof(st1));
4032  0000 ae007d        	ldw	x,#125
4033  0003               L651:
4034  0003 724fffff      	clr	(_st1-1,x)
4035  0007 5a            	decw	x
4036  0008 26f9          	jrne	L651
4037                     ; 969 	st1.HWTtest = 0;
4039  000a 725f001b      	clr	_st1+27
4040                     ; 971 	rev_ssbroadcast = 0;
4042  000e 72130000      	bres	_UART1Flag4_,#1
4043                     ; 973 	ns_own_meshid_H = 0;
4045  0012 725f0000      	clr	_ns_own_meshid_H
4046                     ; 974 	ns_own_meshid_L = 0;
4048  0016 725f0000      	clr	_ns_own_meshid_L
4049                     ; 976 }
4052  001a 81            	ret
4077                     ; 982 void system_interrupt_priority_set(void)
4077                     ; 983 {
4078                     .text:	section	.text,new
4079  0000               _system_interrupt_priority_set:
4083                     ; 998 	enableInterrupts();
4086  0000 9a            rim
4088                     ; 1000 }
4092  0001 81            	ret
4116                     ; 1006 @interrupt void PORTE_EXT_ISR(void)
4116                     ; 1007 {
4117                     .text:	section	.text,new
4118  0000               _PORTE_EXT_ISR:
4123                     ; 1010 	GESTURE_ISR_FLAG = 1;
4125  0000 35010000      	mov	_GESTURE_ISR_FLAG,#1
4126                     ; 1012 }
4129  0004 80            	iret
4153                     ; 1016 @interrupt void PORTA_EXT_ISR(void)
4153                     ; 1017 {
4154                     .text:	section	.text,new
4155  0000               _PORTA_EXT_ISR:
4160                     ; 1020 	MPR121_ISR_FLAG = 1;
4162  0000 35010000      	mov	_MPR121_ISR_FLAG,#1
4163                     ; 1022 }
4166  0004 80            	iret
4192                     ; 1027 void LED_detect(void)
4192                     ; 1028 {
4193                     .text:	section	.text,new
4194  0000               _LED_detect:
4198                     ; 1029 	SYSTEM_LED_ON;
4200  0000 721e500f      	bset	20495,#7
4201                     ; 1030 	GESTURE_LED_ON;
4203  0004 7218500a      	bset	20490,#4
4204                     ; 1031 	mpr121_handle.slipValue = 9;
4206  0008 35090012      	mov	_mpr121_handle+18,#9
4207                     ; 1032 	slippad_led_show();
4209  000c cd0000        	call	_slippad_led_show
4211                     ; 1033 	SLIPPAD_LED0_ON;
4213  000f 721a5014      	bset	20500,#5
4214                     ; 1035 	KEYPAD1_LED_ON;	
4216  0013 7216500a      	bset	20490,#3
4217                     ; 1036 	KEYPAD2_LED_ON;
4219  0017 7214500a      	bset	20490,#2
4220                     ; 1037 	KEYPAD3_LED_ON;
4222  001b 7212500a      	bset	20490,#1
4223                     ; 1039 	delay_ms(1000); /* 点亮所有的灯 */
4225  001f ae03e8        	ldw	x,#1000
4226  0022 cf0000        	ldw	_I2CTimeOut,x
4227  0025               L3051:
4231  0025 ce0000        	ldw	x,_I2CTimeOut
4232  0028 26fb          	jrne	L3051
4233                     ; 1041 	SYSTEM_LED_OFF;
4236  002a 721f500f      	bres	20495,#7
4237                     ; 1042 	GESTURE_LED_OFF;
4239  002e 7219500a      	bres	20490,#4
4240                     ; 1043 	mpr121_handle.slipValue = 1;
4242  0032 35010012      	mov	_mpr121_handle+18,#1
4243                     ; 1044 	slippad_led_show();
4245  0036 cd0000        	call	_slippad_led_show
4247                     ; 1045 	SLIPPAD_LED0_OFF;
4249  0039 721b5014      	bres	20500,#5
4250                     ; 1047 	KEYPAD1_LED_OFF; 
4252  003d 7217500a      	bres	20490,#3
4253                     ; 1048 	KEYPAD2_LED_OFF;
4255  0041 7215500a      	bres	20490,#2
4256                     ; 1049 	KEYPAD3_LED_OFF;
4258  0045 7213500a      	bres	20490,#1
4259                     ; 1051 }
4262  0049 81            	ret
4318                     ; 1061 void main(void)
4318                     ; 1062 {
4319                     .text:	section	.text,new
4320  0000               _main:
4322  0000 88            	push	a
4323       00000001      OFST:	set	1
4326                     ; 1063 	u8 ret = 0;
4328  0001 0f01          	clr	(OFST+0,sp)
4329                     ; 1065 	system_clock_set();
4331  0003 cd0000        	call	_system_clock_set
4333                     ; 1066 	system_led_init();
4335  0006 cd0000        	call	_system_led_init
4337                     ; 1067 	timer2_init();
4339  0009 cd0000        	call	_timer2_init
4341                     ; 1068 	EXTI_DeInit();
4343  000c cd0000        	call	_EXTI_DeInit
4345                     ; 1070 	system_variable_init();
4347  000f cd0000        	call	_system_variable_init
4349                     ; 1073 	gesture_exti_config();
4351  0012 cd0000        	call	_gesture_exti_config
4353                     ; 1075 	ret = init();
4355  0015 cd0000        	call	_init
4357  0018 6b01          	ld	(OFST+0,sp),a
4358                     ; 1076 	if(ret){
4360  001a 0d01          	tnz	(OFST+0,sp)
4361                     ; 1087 	enableGestureSensor(1); 		// Start running the APDS-9960 gesture sensor engine
4363  001c a601          	ld	a,#1
4364  001e cd0000        	call	_enableGestureSensor
4366                     ; 1089 	gesture_led_init();
4368  0021 cd0000        	call	_gesture_led_init
4370                     ; 1096 	MPR121_init();
4372  0024 cd0000        	call	_MPR121_init
4374                     ; 1098 	MPR121_exti_config();
4376  0027 cd0000        	call	_MPR121_exti_config
4378                     ; 1100 	slippad_led_init();
4380  002a cd0000        	call	_slippad_led_init
4382                     ; 1101 	keypad_led_init();
4384  002d cd0000        	call	_keypad_led_init
4386                     ; 1105 	BLE_uart_init();
4388  0030 cd0000        	call	_BLE_uart_init
4390                     ; 1107 	system_interrupt_priority_set();
4392  0033 cd0000        	call	_system_interrupt_priority_set
4394                     ; 1109 	LED_detect();
4396  0036 cd0000        	call	_LED_detect
4398                     ; 1111 	MEEPROM_Init();
4400  0039 cd0000        	call	_MEEPROM_Init
4402  003c               L7251:
4403                     ; 1115 		Task_100ms();
4405  003c cd0000        	call	_Task_100ms
4407                     ; 1116 		Task_1s();
4409  003f cd0000        	call	_Task_1s
4411                     ; 1118 		recv_analyze_reply();
4413  0042 cd0000        	call	_recv_analyze_reply
4415                     ; 1121 		gesture_detect();
4417  0045 cd0000        	call	_gesture_detect
4419                     ; 1124 		MPR121_detect();
4421  0048 cd0000        	call	_MPR121_detect
4423                     ; 1125 		keypad_led_show();
4425  004b cd0000        	call	_keypad_led_show
4427                     ; 1126 		slippad_led_show();
4429  004e cd0000        	call	_slippad_led_show
4432  0051 20e9          	jra	L7251
4521                     	xdef	_main
4522                     	xdef	_LED_detect
4523                     	xdef	_system_interrupt_priority_set
4524                     	xdef	_system_variable_init
4525                     	xdef	_system_led_init
4526                     	xdef	_system_clock_set
4527                     	xdef	_Task_1s
4528                     	xdef	_Task_100ms
4529                     	xdef	_Task_2ms
4530                     	xdef	_slippad_led_init
4531                     	xdef	_slippad_led_show
4532                     	xdef	_SLIPPAD_LED_OFF
4533                     	xdef	_SLIPPAD_LED_ON
4534                     	xdef	_keypad_led_init
4535                     	xdef	_keypad_led_show
4536                     	xdef	_KEYPAD_LED_OFF
4537                     	xdef	_KEYPAD_LED_ON
4538                     	xdef	_KEYPAD_LED_REVERSE
4539                     	xdef	_APDS9960_Light_read
4540                     	xdef	_APDS9960_Light_init
4541                     	xdef	_gesture_lightCheck
4542                     	xdef	_gesture_detect
4543                     	xdef	_gesture_analyze
4544                     	xdef	_gesture_action
4545                     	xdef	_gesture_timeout_check
4546                     	xdef	_gesture_led_show
4547                     	xdef	_gesture_led_init
4548                     	xdef	_gesture_exti_config
4549                     	xdef	_keypad_action
4550                     	xdef	_MEEPROM_Init
4551                     	xdef	_MEEPROM_default_info_set
4552                     	xdef	_MEEPROM_device_info_read
4553                     	xdef	_DIR_DATA
4554                     	xdef	_APDS9960_Light
4555                     	xdef	_GESTURE_ISR_FLAG
4556                     	xdef	_MEEPROM_ReadByte
4557                     	xdef	_MEEPROM_WriteByte
4558                     	xdef	_PORTA_EXT_ISR
4559                     	xdef	_PORTE_EXT_ISR
4560                     	xdef	_sicp_get_message_id
4561                     	xdef	_BIT
4562                     	switch	.bss
4563  0000               _baseTimeFlag:
4564  0000 00            	ds.b	1
4565                     	xdef	_baseTimeFlag
4566                     	xref	_timer2_init
4567                     	xref	_MPR121_detect
4568                     	xref	_MPR121_keyPad_slipPad_post
4569                     	xref	_MPR121_keyPad_hold_time_count
4570                     	xref	_MPR121_exti_config
4571                     	xref	_MPR121_init
4572                     	xref	_mpr121_handle
4573                     	xref	_MPR121_ISR_FLAG
4574                     	xref	_gesture_read_data
4575                     	xref	_isGestureAvailable
4576                     	xref	_readBlueLight
4577                     	xref	_readGreenLight
4578                     	xref	_readRedLight
4579                     	xref	_readAmbientLight
4580                     	xref	_clearAmbientLightInt
4581                     	xref	_setAmbientLightIntEnable
4582                     	xref	_setLightIntHighThreshold
4583                     	xref	_getLightIntHighThreshold
4584                     	xref	_setLightIntLowThreshold
4585                     	xref	_getLightIntLowThreshold
4586                     	xref	_enableGestureSensor
4587                     	xref	_enableLightSensor
4588                     	xref	_getMode
4589                     	xref	_init
4590                     	xref	_resetGestureParameters
4591                     	xref	_I2CTimeOut
4592                     	xref	_GestureTimeOut
4593                     	xref	_GPIO_Init
4594                     	xref	_EXTI_SetTLISensitivity
4595                     	xref	_EXTI_SetExtIntSensitivity
4596                     	xref	_EXTI_DeInit
4597                     	xref	_send_device_info_active
4598                     	xref	_send_action_ctrl
4599                     	xref	_send_action_without_setted
4600                     	xref	_get_gesture_num
4601                     	xref	_recv_analyze_reply
4602                     	xref	_BLE_uart_init
4603                     	xref	_BLE_uart
4604                     	xref	_ns_host_meshid_L
4605                     	xref	_ns_host_meshid_H
4606                     	xref	_ns_own_meshid_L
4607                     	xref	_ns_own_meshid_H
4608                     	xref	_st1
4609                     	xref	_UART1Flag4_
4610                     	xref	_memset
4611                     	xref	_FLASH_GetFlagStatus
4612                     	xref	_FLASH_ReadByte
4613                     	xref	_FLASH_ProgramByte
4614                     	xref	_FLASH_DeInit
4615                     	xref	_FLASH_Lock
4616                     	xref	_FLASH_Unlock
4617                     	xref.b	c_lreg
4637                     	xref	c_smodx
4638                     	xref	c_sdivx
4639                     	xref	c_itolx
4640                     	xref	c_ladd
4641                     	xref	c_uitolx
4642                     	end
