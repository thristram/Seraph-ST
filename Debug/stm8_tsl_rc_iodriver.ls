   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  38                     .const:	section	.text
  39  0000               _Table_SCKEY_BITS:
  40  0000 04            	dc.b	4
  41  0001 08            	dc.b	8
  42  0002 10            	dc.b	16
  73                     ; 221 void TSL_IO_SW_Burst_TestSyncShift(void)
  73                     ; 222 {
  75                     .TSL_IO_ALCODE:	section	.text,new
  76  0000               _TSL_IO_SW_Burst_TestSyncShift:
  80                     ; 225   ld a, _SamplingShifter
  83  0000 b601          ld a, _SamplingShifter
  85                     ; 227 ShiftLoopVih:
  88  0002               ShiftLoopVih:
  90                     ; 228   dec a        // 1 cycle
  93  0002 4a            dec a        // 1 cycle
  95                     ; 229   jrne ShiftLoopVih
  98  0003 26fd          jrne ShiftLoopVih
 100                     ; 232 }
 103  0005 81            	ret
 127                     ; 248 void TSL_IO_SW_Burst_Wait_Vil(void)
 127                     ; 249 {
 128                     .TSL_IO_ALCODE:	section	.text,new
 129  0000               _TSL_IO_SW_Burst_Wait_Vil:
 133                     ; 252   nop
 136  0000 9d            nop
 138                     ; 253   ld a, _AcquisitionBitMask
 141  0001 b600          ld a, _AcquisitionBitMask
 143                     ; 254   ldw x, _sTouchIO   // Input data register ...
 146  0003 be08          ldw x, _sTouchIO   // Input data register ...
 148                     ; 255   incw x
 151  0005 5c            incw x
 153                     ; 257 WaitForVil:
 156  0006               WaitForVil:
 158                     ; 258   bcp a, (x)  // 1 cycles
 161  0006 f5            bcp a, (x)  // 1 cycles
 163                     ; 259   jreq EndWaitForVil
 166  0007 270a          jreq EndWaitForVil
 168                     ; 260   ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
 171  0009 90ce530a      ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
 173                     ; 261   cpw y, #0x0E00    // 2 cycles; Timeout compare
 176  000d 90a30e00      cpw y, #0x0E00    // 2 cycles; Timeout compare
 178                     ; 262   jrult WaitForVil
 181  0011 25f3          jrult WaitForVil
 183                     ; 263 EndWaitForVil:
 186  0013               EndWaitForVil:
 188                     ; 266 }
 191  0013 81            	ret
 215                     ; 282 void TSL_IO_SW_Burst_Wait_Vih(void)
 215                     ; 283 {
 216                     .TSL_IO_ALCODE:	section	.text,new
 217  0000               _TSL_IO_SW_Burst_Wait_Vih:
 221                     ; 286   nop
 224  0000 9d            nop
 226                     ; 287   ld a, _AcquisitionBitMask
 229  0001 b600          ld a, _AcquisitionBitMask
 231                     ; 288   ldw x, _sTouchIO   // Input data register ...
 234  0003 be08          ldw x, _sTouchIO   // Input data register ...
 236                     ; 289   incw x
 239  0005 5c            incw x
 241                     ; 291 WaitForVih:
 244  0006               WaitForVih:
 246                     ; 292   bcp a, (x)  // 1 cycles
 249  0006 f5            bcp a, (x)  // 1 cycles
 251                     ; 293   jrne EndWaitForVih
 254  0007 260a          jrne EndWaitForVih
 256                     ; 294   ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
 259  0009 90ce530a      ldw y, _TIMACQ_CNTR // 2 cycles; hw counter also used for timeout ...
 261                     ; 295   cpw y, #0x0E00    // 2 cycles; Timeout compare
 264  000d 90a30e00      cpw y, #0x0E00    // 2 cycles; Timeout compare
 266                     ; 296   jrult WaitForVih
 269  0011 25f3          jrult WaitForVih
 271                     ; 297 EndWaitForVih:
 274  0013               EndWaitForVih:
 276                     ; 299 }
 279  0013 81            	ret
 282                     	switch	.bss
 283  0000               L55_SpreadCounter:
 284  0000 00            	ds.b	1
 322                     ; 324 void TSL_IO_SW_Spread_Spectrum(void)
 322                     ; 325 {
 323                     .text:	section	.text,new
 324  0000               _TSL_IO_SW_Spread_Spectrum:
 326  0000 88            	push	a
 327       00000001      OFST:	set	1
 330                     ; 329   SpreadCounter++;
 332  0001 725c0000      	inc	L55_SpreadCounter
 333                     ; 331   if (SpreadCounter == SPREAD_COUNTER_MAX)
 335  0005 c60000        	ld	a,L55_SpreadCounter
 336  0008 a114          	cp	a,#20
 337  000a 2604          	jrne	L57
 338                     ; 333     SpreadCounter = SPREAD_COUNTER_MIN;
 340  000c 725f0000      	clr	L55_SpreadCounter
 341  0010               L57:
 342                     ; 336   for (i = SpreadCounter; i; i--);
 344  0010 c60000        	ld	a,L55_SpreadCounter
 345  0013 6b01          	ld	(OFST+0,sp),a
 347  0015 2002          	jra	L301
 348  0017               L77:
 352  0017 0a01          	dec	(OFST+0,sp)
 353  0019               L301:
 356  0019 0d01          	tnz	(OFST+0,sp)
 357  001b 26fa          	jrne	L77
 358                     ; 338 }
 361  001d 84            	pop	a
 362  001e 81            	ret
 386                     ; 354 void TSL_IO_Init(void)
 386                     ; 355 {
 387                     .text:	section	.text,new
 388  0000               _TSL_IO_Init:
 392                     ; 358   ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->CR1 |= LOADREF_BIT;
 394  0000 72165008      	bset	20488,#3
 395                     ; 359   ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->DDR |= LOADREF_BIT;
 397  0004 72165007      	bset	20487,#3
 398                     ; 360   ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);
 400  0008 72175005      	bres	20485,#3
 401                     ; 373   ((GPIO_TypeDef *)(GPIOD_BaseAddress))->CR1 |= GPIOD_ELECTRODES_MASK;
 403  000c c65012        	ld	a,20498
 404  000f aa2c          	or	a,#44
 405  0011 c75012        	ld	20498,a
 406                     ; 391   TSL_IO_Clamp();
 408  0014 cd0000        	call	_TSL_IO_Clamp
 410                     ; 394   TIMACQ->PSCR = 0;
 412  0017 725f530c      	clr	21260
 413                     ; 395   TIMACQ->CR1 = 0x01;
 415  001b 35015300      	mov	21248,#1
 416                     ; 397 }
 419  001f 81            	ret
 442                     ; 410 void TSL_IO_Clamp(void)
 442                     ; 411 {
 443                     .text:	section	.text,new
 444  0000               _TSL_IO_Clamp:
 448                     ; 414   ((GPIO_TypeDef *)(LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);
 450  0000 72175005      	bres	20485,#3
 451                     ; 430   ((GPIO_TypeDef *)(GPIOD_BaseAddress))->ODR &= (u8)(~GPIOD_ELECTRODES_MASK);
 453  0004 c6500f        	ld	a,20495
 454  0007 a4d3          	and	a,#211
 455  0009 c7500f        	ld	20495,a
 456                     ; 431   ((GPIO_TypeDef *)(GPIOD_BaseAddress))->DDR |= GPIOD_ELECTRODES_MASK;
 458  000c c65011        	ld	a,20497
 459  000f aa2c          	or	a,#44
 460  0011 c75011        	ld	20497,a
 461                     ; 454 }
 464  0014 81            	ret
 488                     ; 467 void TSL_IO_SW_Burst_Start_Timer(void)
 488                     ; 468 {
 489                     .text:	section	.text,new
 490  0000               _TSL_IO_SW_Burst_Start_Timer:
 494                     ; 470   TIMACQ->EGR |= 0x01;
 496  0000 72105304      	bset	21252,#0
 497                     ; 472 }
 500  0004 81            	ret
 524                     ; 485 void TSL_IO_SW_Burst_Stop_Timer(void)
 524                     ; 486 {
 525                     .text:	section	.text,new
 526  0000               _TSL_IO_SW_Burst_Stop_Timer:
 530                     ; 489   ld a, _TIMACQ_CNTR
 533  0000 c6530a        ld a, _TIMACQ_CNTR
 535                     ; 490   ld _CounterStop, a
 538  0003 b702          ld _CounterStop, a
 540                     ; 491   ld a, _TIMACQ_CNTR + 1
 543  0005 c6530b        ld a, _TIMACQ_CNTR + 1
 545                     ; 492   ld _CounterStop + 1, a
 548  0008 b703          ld _CounterStop + 1, a
 550                     ; 495 }
 553  000a 81            	ret
 669                     ; 508 void TSL_IO_Acquisition(u8 AcqNumber, u8 AdjustmentLevel)
 669                     ; 509 {
 670                     .text:	section	.text,new
 671  0000               _TSL_IO_Acquisition:
 673  0000 89            	pushw	x
 674  0001 520f          	subw	sp,#15
 675       0000000f      OFST:	set	15
 678                     ; 516   AcquisitionBitMask = sTouchIO.AcqMask;
 680  0003 450a00        	mov	_AcquisitionBitMask,_sTouchIO+2
 681                     ; 518   MinMeasurement = 0;
 683  0006 5f            	clrw	x
 684  0007 1f04          	ldw	(OFST-11,sp),x
 685                     ; 519   MaxMeasurement = 0;
 687  0009 5f            	clrw	x
 688  000a 1f02          	ldw	(OFST-13,sp),x
 689                     ; 520   FinalMeasurementValue = 0;
 691  000c ae0000        	ldw	x,#0
 692  000f bf06          	ldw	_FinalMeasurementValue+2,x
 693  0011 ae0000        	ldw	x,#0
 694  0014 bf04          	ldw	_FinalMeasurementValue,x
 695                     ; 521   RejectionCounter = 0;
 697  0016 0f08          	clr	(OFST-7,sp)
 698                     ; 526   if (IT_Sync_Flags.one_acquisition_sync_enable)
 700  0018 c60000        	ld	a,_IT_Sync_Flags
 701  001b a501          	bcp	a,#1
 702  001d 270b          	jreq	L502
 703                     ; 528     IT_Sync_Flags.start = 0;
 705  001f 72170000      	bres	_IT_Sync_Flags,#3
 707  0023               L312:
 708                     ; 529 		while (IT_Sync_Flags.start == 0);
 710  0023 c60000        	ld	a,_IT_Sync_Flags
 711  0026 a508          	bcp	a,#8
 712  0028 27f9          	jreq	L312
 713  002a               L502:
 714                     ; 534   for ( AcqLoopIndex = 0; AcqLoopIndex < AcqNumber; AcqLoopIndex++ )
 716  002a 0f01          	clr	(OFST-14,sp)
 718  002c ac6b016b      	jpf	L322
 719  0030               L712:
 720                     ; 539 		if (IT_Sync_Flags.one_measure_sync_enable)
 722  0030 c60000        	ld	a,_IT_Sync_Flags
 723  0033 a502          	bcp	a,#2
 724  0035 270b          	jreq	L142
 725                     ; 541       IT_Sync_Flags.start = 0;
 727  0037 72170000      	bres	_IT_Sync_Flags,#3
 729  003b               L532:
 730                     ; 542 			while (IT_Sync_Flags.start == 0);
 732  003b c60000        	ld	a,_IT_Sync_Flags
 733  003e a508          	bcp	a,#8
 734  0040 27f9          	jreq	L532
 735  0042               L142:
 736                     ; 549       MeasRejected = 0;
 738  0042 0f09          	clr	(OFST-6,sp)
 739                     ; 550       CumulatedMeasurement = 0;
 741  0044 5f            	clrw	x
 742  0045 1f06          	ldw	(OFST-9,sp),x
 743                     ; 552       for ( SamplingShifter = SAMPLING_SHIFTER_LOOP_START;
 745  0047 35010001      	mov	_SamplingShifter,#1
 746  004b               L742:
 747                     ; 557         disableInterrupts();       
 750  004b 9b            sim
 752                     ; 558         sTouchIO.PORT_ADDR->ODR &= (u8)(~sTouchIO.DriveMask);
 755  004c b60b          	ld	a,_sTouchIO+3
 756  004e 43            	cpl	a
 757  004f 92c408        	and	a,[_sTouchIO.w]
 758  0052 92c708        	ld	[_sTouchIO.w],a
 759                     ; 559         sTouchIO.PORT_ADDR->DDR |= sTouchIO.DriveMask;
 761  0055 be08          	ldw	x,_sTouchIO
 762  0057 e602          	ld	a,(2,x)
 763  0059 ba0b          	or	a,_sTouchIO+3
 764  005b e702          	ld	(2,x),a
 765                     ; 560         sTouchIO.PORT_ADDR->CR1 &= (u8)(~sTouchIO.DriveMask);
 767  005d be08          	ldw	x,_sTouchIO
 768  005f b60b          	ld	a,_sTouchIO+3
 769  0061 43            	cpl	a
 770  0062 e403          	and	a,(3,x)
 771  0064 e703          	ld	(3,x),a
 772                     ; 561         ((GPIO_TypeDef *) (LOADREF_PORT_ADDR))->ODR |= LOADREF_BIT;				
 774  0066 72165005      	bset	20485,#3
 775                     ; 562 				enableInterrupts();
 778  006a 9a            rim
 780                     ; 567         if (IT_Sync_Flags.one_charge_sync_enable)
 783  006b c60000        	ld	a,_IT_Sync_Flags
 784  006e a504          	bcp	a,#4
 785  0070 270b          	jreq	L552
 786                     ; 569           IT_Sync_Flags.start = 0;
 788  0072 72170000      	bres	_IT_Sync_Flags,#3
 790  0076               L362:
 791                     ; 570 					while (IT_Sync_Flags.start == 0);
 793  0076 c60000        	ld	a,_IT_Sync_Flags
 794  0079 a508          	bcp	a,#8
 795  007b 27f9          	jreq	L362
 796  007d               L552:
 797                     ; 575         TSL_IO_SW_Spread_Spectrum();
 799  007d cd0000        	call	_TSL_IO_SW_Spread_Spectrum
 801                     ; 578         disableInterrupts();
 804  0080 9b            sim
 806                     ; 579         TSL_IO_SW_Burst_Start_Timer();
 809  0081 cd0000        	call	_TSL_IO_SW_Burst_Start_Timer
 811                     ; 580         sTouchIO.PORT_ADDR->DDR &= (u8)(~sTouchIO.DriveMask);
 813  0084 be08          	ldw	x,_sTouchIO
 814  0086 b60b          	ld	a,_sTouchIO+3
 815  0088 43            	cpl	a
 816  0089 e402          	and	a,(2,x)
 817  008b e702          	ld	(2,x),a
 818                     ; 581         TSL_IO_SW_Burst_TestSyncShift();
 820  008d cd0000        	call	_TSL_IO_SW_Burst_TestSyncShift
 822                     ; 582         TSL_IO_SW_Burst_Wait_Vih();
 824  0090 cd0000        	call	_TSL_IO_SW_Burst_Wait_Vih
 826                     ; 583         TSL_IO_SW_Burst_Stop_Timer();
 828  0093 cd0000        	call	_TSL_IO_SW_Burst_Stop_Timer
 830                     ; 585         Measurement = CounterStop;
 832  0096 be02          	ldw	x,_CounterStop
 833  0098 1f0e          	ldw	(OFST-1,sp),x
 834                     ; 588         sTouchIO.PORT_ADDR->ODR |= sTouchIO.DriveMask;
 836  009a 92c608        	ld	a,[_sTouchIO.w]
 837  009d ba0b          	or	a,_sTouchIO+3
 838  009f 92c708        	ld	[_sTouchIO.w],a
 839                     ; 589         sTouchIO.PORT_ADDR->DDR |= sTouchIO.DriveMask;
 841  00a2 be08          	ldw	x,_sTouchIO
 842  00a4 e602          	ld	a,(2,x)
 843  00a6 ba0b          	or	a,_sTouchIO+3
 844  00a8 e702          	ld	(2,x),a
 845                     ; 590         sTouchIO.PORT_ADDR->CR1 |= sTouchIO.DriveMask;
 847  00aa be08          	ldw	x,_sTouchIO
 848  00ac e603          	ld	a,(3,x)
 849  00ae ba0b          	or	a,_sTouchIO+3
 850  00b0 e703          	ld	(3,x),a
 851                     ; 591         ((GPIO_TypeDef *) (LOADREF_PORT_ADDR))->ODR &= (u8)(~LOADREF_BIT);
 853  00b2 72175005      	bres	20485,#3
 854                     ; 592 				enableInterrupts();
 857  00b6 9a            rim
 859                     ; 597 				if (IT_Sync_Flags.one_charge_sync_enable)
 862  00b7 c60000        	ld	a,_IT_Sync_Flags
 863  00ba a504          	bcp	a,#4
 864  00bc 270b          	jreq	L762
 865                     ; 599           IT_Sync_Flags.start = 0;
 867  00be 72170000      	bres	_IT_Sync_Flags,#3
 869  00c2               L572:
 870                     ; 600 				  while (IT_Sync_Flags.start == 0);
 872  00c2 c60000        	ld	a,_IT_Sync_Flags
 873  00c5 a508          	bcp	a,#8
 874  00c7 27f9          	jreq	L572
 875  00c9               L762:
 876                     ; 605         TSL_IO_SW_Spread_Spectrum();
 878  00c9 cd0000        	call	_TSL_IO_SW_Spread_Spectrum
 880                     ; 608         disableInterrupts();
 883  00cc 9b            sim
 885                     ; 609         TSL_IO_SW_Burst_Start_Timer();
 888  00cd cd0000        	call	_TSL_IO_SW_Burst_Start_Timer
 890                     ; 610         sTouchIO.PORT_ADDR->CR1 &= (u8)(~sTouchIO.DriveMask);
 892  00d0 be08          	ldw	x,_sTouchIO
 893  00d2 b60b          	ld	a,_sTouchIO+3
 894  00d4 43            	cpl	a
 895  00d5 e403          	and	a,(3,x)
 896  00d7 e703          	ld	(3,x),a
 897                     ; 611         sTouchIO.PORT_ADDR->DDR &= (u8)(~sTouchIO.DriveMask);
 899  00d9 be08          	ldw	x,_sTouchIO
 900  00db b60b          	ld	a,_sTouchIO+3
 901  00dd 43            	cpl	a
 902  00de e402          	and	a,(2,x)
 903  00e0 e702          	ld	(2,x),a
 904                     ; 612         TSL_IO_SW_Burst_TestSyncShift();
 906  00e2 cd0000        	call	_TSL_IO_SW_Burst_TestSyncShift
 908                     ; 613         TSL_IO_SW_Burst_Wait_Vil();
 910  00e5 cd0000        	call	_TSL_IO_SW_Burst_Wait_Vil
 912                     ; 614         TSL_IO_SW_Burst_Stop_Timer();
 914  00e8 cd0000        	call	_TSL_IO_SW_Burst_Stop_Timer
 916                     ; 616         Measurement += CounterStop;
 918  00eb 1e0e          	ldw	x,(OFST-1,sp)
 919  00ed 72bb0002      	addw	x,_CounterStop
 920  00f1 1f0e          	ldw	(OFST-1,sp),x
 921                     ; 618         CumulatedMeasurement += Measurement;
 923  00f3 1e06          	ldw	x,(OFST-9,sp)
 924  00f5 72fb0e        	addw	x,(OFST-1,sp)
 925  00f8 1f06          	ldw	(OFST-9,sp),x
 926                     ; 621         if (SamplingShifter == SAMPLING_SHIFTER_LOOP_START)
 928  00fa b601          	ld	a,_SamplingShifter
 929  00fc a101          	cp	a,#1
 930  00fe 262e          	jrne	L103
 931                     ; 623           tmpval = (u32)((u32)Measurement * MAX_MEAS_COEFF);
 933  0100 1e0e          	ldw	x,(OFST-1,sp)
 934  0102 90ae011a      	ldw	y,#282
 935  0106 cd0000        	call	c_umul
 937  0109 96            	ldw	x,sp
 938  010a 1c000a        	addw	x,#OFST-5
 939  010d cd0000        	call	c_rtol
 941                     ; 624           MaxMeasurement = (u16)((u16)(tmpval >> 8) + NB_CYCLES_VIHVIL_LOOP);
 943  0110 1e0b          	ldw	x,(OFST-4,sp)
 944  0112 1c0008        	addw	x,#8
 945  0115 1f02          	ldw	(OFST-13,sp),x
 946                     ; 625           tmpval = (u32)((u32)Measurement * MIN_MEAS_COEFF);
 948  0117 1e0e          	ldw	x,(OFST-1,sp)
 949  0119 a6e6          	ld	a,#230
 950  011b cd0000        	call	c_cmulx
 952  011e 96            	ldw	x,sp
 953  011f 1c000a        	addw	x,#OFST-5
 954  0122 cd0000        	call	c_rtol
 956                     ; 626           MinMeasurement = (u16)((u16)(tmpval >> 8) - NB_CYCLES_VIHVIL_LOOP);
 958  0125 1e0b          	ldw	x,(OFST-4,sp)
 959  0127 1d0008        	subw	x,#8
 960  012a 1f04          	ldw	(OFST-11,sp),x
 962  012c 201f          	jra	L303
 963  012e               L103:
 964                     ; 630           if ((Measurement < MinMeasurement) || (Measurement > MaxMeasurement))
 966  012e 1e0e          	ldw	x,(OFST-1,sp)
 967  0130 1304          	cpw	x,(OFST-11,sp)
 968  0132 2506          	jrult	L703
 970  0134 1e0e          	ldw	x,(OFST-1,sp)
 971  0136 1302          	cpw	x,(OFST-13,sp)
 972  0138 2313          	jrule	L303
 973  013a               L703:
 974                     ; 632             MeasRejected++;
 976  013a 0c09          	inc	(OFST-6,sp)
 977                     ; 633             RejectionCounter++;
 979  013c 0c08          	inc	(OFST-7,sp)
 980                     ; 634             break; // Out from 'for SamplingShifter' loop !!!
 981  013e               L342:
 982                     ; 641     while (MeasRejected && (RejectionCounter <= MAX_REJECTED_MEASUREMENTS));
 984  013e 0d09          	tnz	(OFST-6,sp)
 985  0140 2718          	jreq	L113
 987  0142 7b08          	ld	a,(OFST-7,sp)
 988  0144 a115          	cp	a,#21
 989  0146 2403          	jruge	L62
 990  0148 cc0042        	jp	L142
 991  014b               L62:
 992  014b 200d          	jra	L113
 993  014d               L303:
 994                     ; 553             SamplingShifter < (SAMPLING_SHIFTER_NB_LOOPS + SAMPLING_SHIFTER_LOOP_START);
 994                     ; 554             SamplingShifter++ )
 996  014d 3c01          	inc	_SamplingShifter
 997                     ; 552       for ( SamplingShifter = SAMPLING_SHIFTER_LOOP_START;
 997                     ; 553             SamplingShifter < (SAMPLING_SHIFTER_NB_LOOPS + SAMPLING_SHIFTER_LOOP_START);
 999  014f b601          	ld	a,_SamplingShifter
1000  0151 a109          	cp	a,#9
1001  0153 2403          	jruge	L03
1002  0155 cc004b        	jp	L742
1003  0158               L03:
1004  0158 20e4          	jra	L342
1005  015a               L113:
1006                     ; 643     if (MeasRejected == 0)
1008  015a 0d09          	tnz	(OFST-6,sp)
1009  015c 2616          	jrne	L522
1010                     ; 645       FinalMeasurementValue += CumulatedMeasurement;
1012  015e 1e06          	ldw	x,(OFST-9,sp)
1013  0160 cd0000        	call	c_uitolx
1015  0163 ae0004        	ldw	x,#_FinalMeasurementValue
1016  0166 cd0000        	call	c_lgadd
1019                     ; 534   for ( AcqLoopIndex = 0; AcqLoopIndex < AcqNumber; AcqLoopIndex++ )
1021  0169 0c01          	inc	(OFST-14,sp)
1022  016b               L322:
1025  016b 7b01          	ld	a,(OFST-14,sp)
1026  016d 1110          	cp	a,(OFST+1,sp)
1027  016f 2403          	jruge	L23
1028  0171 cc0030        	jp	L712
1029  0174               L23:
1030  0174               L522:
1031                     ; 654   TSL_IO_Clamp(); // To avoid consumption
1033  0174 cd0000        	call	_TSL_IO_Clamp
1035                     ; 655   enableInterrupts();
1038  0177 9a            rim
1040                     ; 657   *sTouchIO.RejectedNb = RejectionCounter;
1043  0178 7b08          	ld	a,(OFST-7,sp)
1044  017a 92c70e        	ld	[_sTouchIO+6.w],a
1045                     ; 659   if (RejectionCounter <= MAX_REJECTED_MEASUREMENTS)
1047  017d 7b08          	ld	a,(OFST-7,sp)
1048  017f a115          	cp	a,#21
1049  0181 2420          	jruge	L713
1050                     ; 661     FinalMeasurementValue = (u32)(FinalMeasurementValue >> 3); /* Division by SAMPLING_SHIFTER_NB_LOOPS */
1052  0183 ae0004        	ldw	x,#_FinalMeasurementValue
1053  0186 a603          	ld	a,#3
1054  0188 cd0000        	call	c_lgursh
1057  018b 2008          	jra	L323
1058  018d               L123:
1059                     ; 664       FinalMeasurementValue = (u32)(FinalMeasurementValue >> 1);
1061  018d 3404          	srl	_FinalMeasurementValue
1062  018f 3605          	rrc	_FinalMeasurementValue+1
1063  0191 3606          	rrc	_FinalMeasurementValue+2
1064  0193 3607          	rrc	_FinalMeasurementValue+3
1065  0195               L323:
1066                     ; 662     while ( AdjustmentLevel-- )
1068  0195 7b11          	ld	a,(OFST+2,sp)
1069  0197 0a11          	dec	(OFST+2,sp)
1070  0199 4d            	tnz	a
1071  019a 26f1          	jrne	L123
1072                     ; 666     *sTouchIO.Measurement = (u16)FinalMeasurementValue;
1074  019c be06          	ldw	x,_FinalMeasurementValue+2
1075  019e 92cf0c        	ldw	[_sTouchIO+4.w],x
1077  01a1 2008          	jra	L723
1078  01a3               L713:
1079                     ; 674       pKeyStruct->Setting.b.NOISE = 1; /* Warning: Application layer must reset this flag */
1081  01a3 be00          	ldw	x,_pKeyStruct
1082  01a5 e602          	ld	a,(2,x)
1083  01a7 aa40          	or	a,#64
1084  01a9 e702          	ld	(2,x),a
1085  01ab               L723:
1086                     ; 684 }
1089  01ab 5b11          	addw	sp,#17
1090  01ad 81            	ret
1297                     	xdef	_TSL_IO_SW_Spread_Spectrum
1298                     	switch	.ubsct
1299  0000               _AcquisitionBitMask:
1300  0000 00            	ds.b	1
1301                     	xdef	_AcquisitionBitMask
1302  0001               _SamplingShifter:
1303  0001 00            	ds.b	1
1304                     	xdef	_SamplingShifter
1305  0002               _CounterStop:
1306  0002 0000          	ds.b	2
1307                     	xdef	_CounterStop
1308  0004               _FinalMeasurementValue:
1309  0004 00000000      	ds.b	4
1310                     	xdef	_FinalMeasurementValue
1311                     	xref	_IT_Sync_Flags
1312                     	xref.b	_pKeyStruct
1313                     	xdef	_TSL_IO_SW_Burst_Stop_Timer
1314                     	xdef	_TSL_IO_SW_Burst_Start_Timer
1315                     	xdef	_TSL_IO_SW_Burst_Wait_Vih
1316                     	xdef	_TSL_IO_SW_Burst_Wait_Vil
1317                     	xdef	_TSL_IO_SW_Burst_TestSyncShift
1318                     	xdef	_TSL_IO_Acquisition
1319                     	xdef	_TSL_IO_Clamp
1320                     	xdef	_TSL_IO_Init
1321                     	xdef	_Table_SCKEY_BITS
1322  0008               _sTouchIO:
1323  0008 000000000000  	ds.b	9
1324                     	xdef	_sTouchIO
1344                     	xref	c_lgursh
1345                     	xref	c_lgadd
1346                     	xref	c_uitolx
1347                     	xref	c_cmulx
1348                     	xref	c_rtol
1349                     	xref	c_umul
1350                     	end
