   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     .const:	section	.text
   5  0000               _HSIDivFactor:
   6  0000 01            	dc.b	1
   7  0001 02            	dc.b	2
   8  0002 04            	dc.b	4
   9  0003 08            	dc.b	8
  10  0004               _CLKPrescTable:
  11  0004 01            	dc.b	1
  12  0005 02            	dc.b	2
  13  0006 04            	dc.b	4
  14  0007 08            	dc.b	8
  15  0008 0a            	dc.b	10
  16  0009 10            	dc.b	16
  17  000a 14            	dc.b	20
  18  000b 28            	dc.b	40
  47                     ; 83 void CLK_DeInit(void)
  47                     ; 84 {
  49                     .text:	section	.text,new
  50  0000               _CLK_DeInit:
  54                     ; 86   CLK->ICKR = CLK_ICKR_RESET_VALUE;
  56  0000 350150c0      	mov	20672,#1
  57                     ; 87   CLK->ECKR = CLK_ECKR_RESET_VALUE;
  59  0004 725f50c1      	clr	20673
  60                     ; 88   CLK->SWR  = CLK_SWR_RESET_VALUE;
  62  0008 35e150c4      	mov	20676,#225
  63                     ; 89   CLK->SWCR = CLK_SWCR_RESET_VALUE;
  65  000c 725f50c5      	clr	20677
  66                     ; 90   CLK->CKDIVR = CLK_CKDIVR_RESET_VALUE;
  68  0010 351850c6      	mov	20678,#24
  69                     ; 91   CLK->PCKENR1 = CLK_PCKENR1_RESET_VALUE;
  71  0014 35ff50c7      	mov	20679,#255
  72                     ; 92   CLK->PCKENR2 = CLK_PCKENR2_RESET_VALUE;
  74  0018 35ff50ca      	mov	20682,#255
  75                     ; 93   CLK->CSSR = CLK_CSSR_RESET_VALUE;
  77  001c 725f50c8      	clr	20680
  78                     ; 95   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  80  0020 725f50c9      	clr	20681
  82  0024               L52:
  83                     ; 96   while (CLK->CCOR & CLK_CCOR_CCOEN)
  85  0024 c650c9        	ld	a,20681
  86  0027 a501          	bcp	a,#1
  87  0029 26f9          	jrne	L52
  88                     ; 98   CLK->CCOR = CLK_CCOR_RESET_VALUE;
  90  002b 725f50c9      	clr	20681
  91                     ; 100   CLK->CANCCR = CLK_CANCCR_RESET_VALUE;
  93  002f 725f50cb      	clr	20683
  94                     ; 101   CLK->HSITRIMR = CLK_HSITRIMR_RESET_VALUE;
  96  0033 725f50cc      	clr	20684
  97                     ; 102   CLK->SWIMCCR = CLK_SWIMCCR_RESET_VALUE;
  99  0037 725f50cd      	clr	20685
 100                     ; 104 }
 103  003b 81            	ret
 159                     ; 123 void CLK_FastHaltWakeUpCmd(FunctionalState NewState)
 159                     ; 124 {
 160                     .text:	section	.text,new
 161  0000               _CLK_FastHaltWakeUpCmd:
 165                     ; 127   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 167                     ; 129   if (NewState != DISABLE)
 169  0000 4d            	tnz	a
 170  0001 2706          	jreq	L75
 171                     ; 132     CLK->ICKR |= CLK_ICKR_FHWU;
 173  0003 721450c0      	bset	20672,#2
 175  0007 2004          	jra	L16
 176  0009               L75:
 177                     ; 137     CLK->ICKR &= (u8)(~CLK_ICKR_FHWU);
 179  0009 721550c0      	bres	20672,#2
 180  000d               L16:
 181                     ; 140 }
 184  000d 81            	ret
 219                     ; 154 void CLK_HSECmd(FunctionalState CLK_NewState)
 219                     ; 155 {
 220                     .text:	section	.text,new
 221  0000               _CLK_HSECmd:
 225                     ; 158   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 227                     ; 160   if (CLK_NewState != DISABLE)
 229  0000 4d            	tnz	a
 230  0001 2706          	jreq	L101
 231                     ; 163     CLK->ECKR |= CLK_ECKR_HSEEN;
 233  0003 721050c1      	bset	20673,#0
 235  0007 2004          	jra	L301
 236  0009               L101:
 237                     ; 168     CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
 239  0009 721150c1      	bres	20673,#0
 240  000d               L301:
 241                     ; 171 }
 244  000d 81            	ret
 279                     ; 185 void CLK_HSICmd(FunctionalState CLK_NewState)
 279                     ; 186 {
 280                     .text:	section	.text,new
 281  0000               _CLK_HSICmd:
 285                     ; 189   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 287                     ; 191   if (CLK_NewState != DISABLE)
 289  0000 4d            	tnz	a
 290  0001 2706          	jreq	L321
 291                     ; 194     CLK->ICKR |= CLK_ICKR_HSIEN;
 293  0003 721050c0      	bset	20672,#0
 295  0007 2004          	jra	L521
 296  0009               L321:
 297                     ; 199     CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
 299  0009 721150c0      	bres	20672,#0
 300  000d               L521:
 301                     ; 202 }
 304  000d 81            	ret
 339                     ; 216 void CLK_LSICmd(FunctionalState CLK_NewState)
 339                     ; 217 {
 340                     .text:	section	.text,new
 341  0000               _CLK_LSICmd:
 345                     ; 220   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 347                     ; 222   if (CLK_NewState != DISABLE)
 349  0000 4d            	tnz	a
 350  0001 2706          	jreq	L541
 351                     ; 225     CLK->ICKR |= CLK_ICKR_LSIEN;
 353  0003 721650c0      	bset	20672,#3
 355  0007 2004          	jra	L741
 356  0009               L541:
 357                     ; 230     CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
 359  0009 721750c0      	bres	20672,#3
 360  000d               L741:
 361                     ; 233 }
 364  000d 81            	ret
 399                     ; 248 void CLK_CCOCmd(FunctionalState CLK_NewState)
 399                     ; 249 {
 400                     .text:	section	.text,new
 401  0000               _CLK_CCOCmd:
 405                     ; 252   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 407                     ; 254   if (CLK_NewState != DISABLE)
 409  0000 4d            	tnz	a
 410  0001 2706          	jreq	L761
 411                     ; 257     CLK->CCOR |= CLK_CCOR_CCOEN;
 413  0003 721050c9      	bset	20681,#0
 415  0007 2004          	jra	L171
 416  0009               L761:
 417                     ; 262     CLK->CCOR &= (u8)(~CLK_CCOR_CCOEN);
 419  0009 721150c9      	bres	20681,#0
 420  000d               L171:
 421                     ; 265 }
 424  000d 81            	ret
 459                     ; 281 void CLK_ClockSwitchCmd(FunctionalState CLK_NewState)
 459                     ; 282 {
 460                     .text:	section	.text,new
 461  0000               _CLK_ClockSwitchCmd:
 465                     ; 285   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 467                     ; 287   if (CLK_NewState != DISABLE )
 469  0000 4d            	tnz	a
 470  0001 2706          	jreq	L112
 471                     ; 290     CLK->SWCR |= CLK_SWCR_SWEN;
 473  0003 721250c5      	bset	20677,#1
 475  0007 2004          	jra	L312
 476  0009               L112:
 477                     ; 295     CLK->SWCR &= (u8)(~CLK_SWCR_SWEN);
 479  0009 721350c5      	bres	20677,#1
 480  000d               L312:
 481                     ; 298 }
 484  000d 81            	ret
 520                     ; 315 void CLK_SlowActiveHaltWakeUpCmd(FunctionalState NewState)
 520                     ; 316 {
 521                     .text:	section	.text,new
 522  0000               _CLK_SlowActiveHaltWakeUpCmd:
 526                     ; 319   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 528                     ; 321   if (NewState != DISABLE)
 530  0000 4d            	tnz	a
 531  0001 2706          	jreq	L332
 532                     ; 324     CLK->ICKR |= CLK_ICKR_SWUAH;
 534  0003 721a50c0      	bset	20672,#5
 536  0007 2004          	jra	L532
 537  0009               L332:
 538                     ; 329     CLK->ICKR &= (u8)(~CLK_ICKR_SWUAH);
 540  0009 721b50c0      	bres	20672,#5
 541  000d               L532:
 542                     ; 332 }
 545  000d 81            	ret
 680                     ; 349 void CLK_PeripheralClockConfig(CLK_Peripheral_TypeDef CLK_Peripheral, FunctionalState CLK_NewState)
 680                     ; 350 {
 681                     .text:	section	.text,new
 682  0000               _CLK_PeripheralClockConfig:
 684  0000 89            	pushw	x
 685       00000000      OFST:	set	0
 688                     ; 353   assert_param(IS_FUNCTIONALSTATE_OK(CLK_NewState));
 690                     ; 354   assert_param(IS_CLK_PERIPHERAL_OK(CLK_Peripheral));
 692                     ; 356   if (((u8)CLK_Peripheral & (u8)0x10) == 0x00)
 694  0001 9e            	ld	a,xh
 695  0002 a510          	bcp	a,#16
 696  0004 2633          	jrne	L313
 697                     ; 358     if (CLK_NewState != DISABLE)
 699  0006 0d02          	tnz	(OFST+2,sp)
 700  0008 2717          	jreq	L513
 701                     ; 361       CLK->PCKENR1 |= (u8)((u8)1 << ((u8)CLK_Peripheral & (u8)0x0F));
 703  000a 7b01          	ld	a,(OFST+1,sp)
 704  000c a40f          	and	a,#15
 705  000e 5f            	clrw	x
 706  000f 97            	ld	xl,a
 707  0010 a601          	ld	a,#1
 708  0012 5d            	tnzw	x
 709  0013 2704          	jreq	L62
 710  0015               L03:
 711  0015 48            	sll	a
 712  0016 5a            	decw	x
 713  0017 26fc          	jrne	L03
 714  0019               L62:
 715  0019 ca50c7        	or	a,20679
 716  001c c750c7        	ld	20679,a
 718  001f 2049          	jra	L123
 719  0021               L513:
 720                     ; 366       CLK->PCKENR1 &= (u8)(~(u8)(((u8)1 << ((u8)CLK_Peripheral & (u8)0x0F))));
 722  0021 7b01          	ld	a,(OFST+1,sp)
 723  0023 a40f          	and	a,#15
 724  0025 5f            	clrw	x
 725  0026 97            	ld	xl,a
 726  0027 a601          	ld	a,#1
 727  0029 5d            	tnzw	x
 728  002a 2704          	jreq	L23
 729  002c               L43:
 730  002c 48            	sll	a
 731  002d 5a            	decw	x
 732  002e 26fc          	jrne	L43
 733  0030               L23:
 734  0030 43            	cpl	a
 735  0031 c450c7        	and	a,20679
 736  0034 c750c7        	ld	20679,a
 737  0037 2031          	jra	L123
 738  0039               L313:
 739                     ; 371     if (CLK_NewState != DISABLE)
 741  0039 0d02          	tnz	(OFST+2,sp)
 742  003b 2717          	jreq	L323
 743                     ; 374       CLK->PCKENR2 |= (u8)((u8)1 << ((u8)CLK_Peripheral & (u8)0x0F));
 745  003d 7b01          	ld	a,(OFST+1,sp)
 746  003f a40f          	and	a,#15
 747  0041 5f            	clrw	x
 748  0042 97            	ld	xl,a
 749  0043 a601          	ld	a,#1
 750  0045 5d            	tnzw	x
 751  0046 2704          	jreq	L63
 752  0048               L04:
 753  0048 48            	sll	a
 754  0049 5a            	decw	x
 755  004a 26fc          	jrne	L04
 756  004c               L63:
 757  004c ca50ca        	or	a,20682
 758  004f c750ca        	ld	20682,a
 760  0052 2016          	jra	L123
 761  0054               L323:
 762                     ; 379       CLK->PCKENR2 &= (u8)(~(u8)(((u8)1 << ((u8)CLK_Peripheral & (u8)0x0F))));
 764  0054 7b01          	ld	a,(OFST+1,sp)
 765  0056 a40f          	and	a,#15
 766  0058 5f            	clrw	x
 767  0059 97            	ld	xl,a
 768  005a a601          	ld	a,#1
 769  005c 5d            	tnzw	x
 770  005d 2704          	jreq	L24
 771  005f               L44:
 772  005f 48            	sll	a
 773  0060 5a            	decw	x
 774  0061 26fc          	jrne	L44
 775  0063               L24:
 776  0063 43            	cpl	a
 777  0064 c450ca        	and	a,20682
 778  0067 c750ca        	ld	20682,a
 779  006a               L123:
 780                     ; 383 }
 783  006a 85            	popw	x
 784  006b 81            	ret
 970                     ; 405 ErrorStatus CLK_ClockSwitchConfig(CLK_SwitchMode_TypeDef CLK_SwitchMode, CLK_Source_TypeDef CLK_NewClock, FunctionalState CLK_SwitchIT, CLK_CurrentClockState_TypeDef CLK_CurrentClockState)
 970                     ; 406 {
 971                     .text:	section	.text,new
 972  0000               _CLK_ClockSwitchConfig:
 974  0000 89            	pushw	x
 975  0001 5204          	subw	sp,#4
 976       00000004      OFST:	set	4
 979                     ; 409   u16 DownCounter = CLK_TIMEOUT;
 981  0003 ae0491        	ldw	x,#1169
 982  0006 1f03          	ldw	(OFST-1,sp),x
 983                     ; 410   ErrorStatus Swif = ERROR;
 985  0008 7b02          	ld	a,(OFST-2,sp)
 986  000a 97            	ld	xl,a
 987                     ; 413   assert_param(IS_CLK_SOURCE_OK(CLK_NewClock));
 989                     ; 414   assert_param(IS_CLK_SWITCHMODE_OK(CLK_SwitchMode));
 991                     ; 415   assert_param(IS_FUNCTIONALSTATE_OK(CLK_SwitchIT));
 993                     ; 416   assert_param(IS_CLK_CURRENTCLOCKSTATE_OK(CLK_CurrentClockState));
 995                     ; 419   clock_master = (CLK_Source_TypeDef)CLK->CMSR;
 997  000b c650c3        	ld	a,20675
 998  000e 6b01          	ld	(OFST-3,sp),a
 999                     ; 422   if (CLK_SwitchMode == CLK_SWITCHMODE_AUTO)
1001  0010 7b05          	ld	a,(OFST+1,sp)
1002  0012 a101          	cp	a,#1
1003  0014 2639          	jrne	L534
1004                     ; 426     CLK->SWCR |= CLK_SWCR_SWEN;
1006  0016 721250c5      	bset	20677,#1
1007                     ; 429     if (CLK_SwitchIT != DISABLE)
1009  001a 0d09          	tnz	(OFST+5,sp)
1010  001c 2706          	jreq	L734
1011                     ; 431       CLK->SWCR |= CLK_SWCR_SWIEN;
1013  001e 721450c5      	bset	20677,#2
1015  0022 2004          	jra	L144
1016  0024               L734:
1017                     ; 435       CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
1019  0024 721550c5      	bres	20677,#2
1020  0028               L144:
1021                     ; 439     CLK->SWR = (u8)CLK_NewClock;
1023  0028 7b06          	ld	a,(OFST+2,sp)
1024  002a c750c4        	ld	20676,a
1026  002d 2007          	jra	L744
1027  002f               L344:
1028                     ; 443       DownCounter--;
1030  002f 1e03          	ldw	x,(OFST-1,sp)
1031  0031 1d0001        	subw	x,#1
1032  0034 1f03          	ldw	(OFST-1,sp),x
1033  0036               L744:
1034                     ; 441     while (((CLK->SWCR & CLK_SWCR_SWBSY) && (DownCounter != 0)))
1036  0036 c650c5        	ld	a,20677
1037  0039 a501          	bcp	a,#1
1038  003b 2704          	jreq	L354
1040  003d 1e03          	ldw	x,(OFST-1,sp)
1041  003f 26ee          	jrne	L344
1042  0041               L354:
1043                     ; 446     if (DownCounter != 0)
1045  0041 1e03          	ldw	x,(OFST-1,sp)
1046  0043 2706          	jreq	L554
1047                     ; 448       Swif = SUCCESS;
1049  0045 a601          	ld	a,#1
1050  0047 6b02          	ld	(OFST-2,sp),a
1052  0049 201b          	jra	L164
1053  004b               L554:
1054                     ; 452       Swif = ERROR;
1056  004b 0f02          	clr	(OFST-2,sp)
1057  004d 2017          	jra	L164
1058  004f               L534:
1059                     ; 460     if (CLK_SwitchIT != DISABLE)
1061  004f 0d09          	tnz	(OFST+5,sp)
1062  0051 2706          	jreq	L364
1063                     ; 462       CLK->SWCR |= CLK_SWCR_SWIEN;
1065  0053 721450c5      	bset	20677,#2
1067  0057 2004          	jra	L564
1068  0059               L364:
1069                     ; 466       CLK->SWCR &= (u8)(~CLK_SWCR_SWIEN);
1071  0059 721550c5      	bres	20677,#2
1072  005d               L564:
1073                     ; 470     CLK->SWR = (u8)CLK_NewClock;
1075  005d 7b06          	ld	a,(OFST+2,sp)
1076  005f c750c4        	ld	20676,a
1077                     ; 474     Swif = SUCCESS;
1079  0062 a601          	ld	a,#1
1080  0064 6b02          	ld	(OFST-2,sp),a
1081  0066               L164:
1082                     ; 479   if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSI))
1084  0066 0d0a          	tnz	(OFST+6,sp)
1085  0068 260c          	jrne	L764
1087  006a 7b01          	ld	a,(OFST-3,sp)
1088  006c a1e1          	cp	a,#225
1089  006e 2606          	jrne	L764
1090                     ; 481     CLK->ICKR &= (u8)(~CLK_ICKR_HSIEN);
1092  0070 721150c0      	bres	20672,#0
1094  0074 201e          	jra	L174
1095  0076               L764:
1096                     ; 483   else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_LSI))
1098  0076 0d0a          	tnz	(OFST+6,sp)
1099  0078 260c          	jrne	L374
1101  007a 7b01          	ld	a,(OFST-3,sp)
1102  007c a1d2          	cp	a,#210
1103  007e 2606          	jrne	L374
1104                     ; 485     CLK->ICKR &= (u8)(~CLK_ICKR_LSIEN);
1106  0080 721750c0      	bres	20672,#3
1108  0084 200e          	jra	L174
1109  0086               L374:
1110                     ; 487   else if ((CLK_CurrentClockState == CLK_CURRENTCLOCKSTATE_DISABLE) && ( clock_master == CLK_SOURCE_HSE))
1112  0086 0d0a          	tnz	(OFST+6,sp)
1113  0088 260a          	jrne	L174
1115  008a 7b01          	ld	a,(OFST-3,sp)
1116  008c a1b4          	cp	a,#180
1117  008e 2604          	jrne	L174
1118                     ; 489     CLK->ECKR &= (u8)(~CLK_ECKR_HSEEN);
1120  0090 721150c1      	bres	20673,#0
1121  0094               L174:
1122                     ; 492   return(Swif);
1124  0094 7b02          	ld	a,(OFST-2,sp)
1127  0096 5b06          	addw	sp,#6
1128  0098 81            	ret
1266                     ; 509 void CLK_HSIPrescalerConfig(CLK_Prescaler_TypeDef HSIPrescaler)
1266                     ; 510 {
1267                     .text:	section	.text,new
1268  0000               _CLK_HSIPrescalerConfig:
1270  0000 88            	push	a
1271       00000000      OFST:	set	0
1274                     ; 513   assert_param(IS_CLK_HSIPRESCALER_OK(HSIPrescaler));
1276                     ; 516   CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
1278  0001 c650c6        	ld	a,20678
1279  0004 a4e7          	and	a,#231
1280  0006 c750c6        	ld	20678,a
1281                     ; 519   CLK->CKDIVR |= (u8)HSIPrescaler;
1283  0009 c650c6        	ld	a,20678
1284  000c 1a01          	or	a,(OFST+1,sp)
1285  000e c750c6        	ld	20678,a
1286                     ; 521 }
1289  0011 84            	pop	a
1290  0012 81            	ret
1425                     ; 539 void CLK_CCOConfig(CLK_Output_TypeDef CLK_CCO)
1425                     ; 540 {
1426                     .text:	section	.text,new
1427  0000               _CLK_CCOConfig:
1429  0000 88            	push	a
1430       00000000      OFST:	set	0
1433                     ; 543   assert_param(IS_CLK_OUTPUT_OK(CLK_CCO));
1435                     ; 546   CLK->CCOR &= (u8)(~CLK_CCOR_CCOSEL);
1437  0001 c650c9        	ld	a,20681
1438  0004 a4e1          	and	a,#225
1439  0006 c750c9        	ld	20681,a
1440                     ; 549   CLK->CCOR |= (u8)CLK_CCO;
1442  0009 c650c9        	ld	a,20681
1443  000c 1a01          	or	a,(OFST+1,sp)
1444  000e c750c9        	ld	20681,a
1445                     ; 552   CLK->CCOR |= CLK_CCOR_CCOEN;
1447  0011 721050c9      	bset	20681,#0
1448                     ; 554 }
1451  0015 84            	pop	a
1452  0016 81            	ret
1517                     ; 571 void CLK_ITConfig(CLK_IT_TypeDef CLK_IT, FunctionalState IT_NewState)
1517                     ; 572 {
1518                     .text:	section	.text,new
1519  0000               _CLK_ITConfig:
1521  0000 89            	pushw	x
1522       00000000      OFST:	set	0
1525                     ; 575   assert_param(IS_FUNCTIONALSTATE_OK(IT_NewState));
1527                     ; 576   assert_param(IS_CLK_IT_OK(CLK_IT));
1529                     ; 578   if (IT_NewState != DISABLE)
1531  0001 9f            	ld	a,xl
1532  0002 4d            	tnz	a
1533  0003 2719          	jreq	L576
1534                     ; 580     switch (CLK_IT)
1536  0005 9e            	ld	a,xh
1538                     ; 588       default:
1538                     ; 589         break;
1539  0006 a00c          	sub	a,#12
1540  0008 270a          	jreq	L136
1541  000a a010          	sub	a,#16
1542  000c 2624          	jrne	L307
1543                     ; 582       case CLK_IT_SWIF: /* Enable the clock switch interrupt */
1543                     ; 583         CLK->SWCR |= CLK_SWCR_SWIEN;
1545  000e 721450c5      	bset	20677,#2
1546                     ; 584         break;
1548  0012 201e          	jra	L307
1549  0014               L136:
1550                     ; 585       case CLK_IT_CSSD: /* Enable the clock security system detection interrupt */
1550                     ; 586         CLK->CSSR |= CLK_CSSR_CSSDIE;
1552  0014 721450c8      	bset	20680,#2
1553                     ; 587         break;
1555  0018 2018          	jra	L307
1556  001a               L336:
1557                     ; 588       default:
1557                     ; 589         break;
1559  001a 2016          	jra	L307
1560  001c               L107:
1562  001c 2014          	jra	L307
1563  001e               L576:
1564                     ; 594     switch (CLK_IT)
1566  001e 7b01          	ld	a,(OFST+1,sp)
1568                     ; 602       default:
1568                     ; 603         break;
1569  0020 a00c          	sub	a,#12
1570  0022 270a          	jreq	L736
1571  0024 a010          	sub	a,#16
1572  0026 260a          	jrne	L307
1573                     ; 596       case CLK_IT_SWIF: /* Disable the clock switch interrupt */
1573                     ; 597         CLK->SWCR  &= (u8)(~CLK_SWCR_SWIEN);
1575  0028 721550c5      	bres	20677,#2
1576                     ; 598         break;
1578  002c 2004          	jra	L307
1579  002e               L736:
1580                     ; 599       case CLK_IT_CSSD: /* Disable the clock security system detection interrupt */
1580                     ; 600         CLK->CSSR &= (u8)(~CLK_CSSR_CSSDIE);
1582  002e 721550c8      	bres	20680,#2
1583                     ; 601         break;
1584  0032               L307:
1585                     ; 607 }
1588  0032 85            	popw	x
1589  0033 81            	ret
1590  0034               L146:
1591                     ; 602       default:
1591                     ; 603         break;
1593  0034 20fc          	jra	L307
1594  0036               L707:
1595  0036 20fa          	jra	L307
1630                     ; 623 void CLK_SYSCLKConfig(CLK_Prescaler_TypeDef ClockPrescaler)
1630                     ; 624 {
1631                     .text:	section	.text,new
1632  0000               _CLK_SYSCLKConfig:
1634  0000 88            	push	a
1635       00000000      OFST:	set	0
1638                     ; 627   assert_param(IS_CLK_PRESCALER_OK(ClockPrescaler));
1640                     ; 629   if (((u8)ClockPrescaler & (u8)0x80) == 0x00) /* Bit7 = 0 means HSI divider */
1642  0001 a580          	bcp	a,#128
1643  0003 2614          	jrne	L727
1644                     ; 631     CLK->CKDIVR &= (u8)(~CLK_CKDIVR_HSIDIV);
1646  0005 c650c6        	ld	a,20678
1647  0008 a4e7          	and	a,#231
1648  000a c750c6        	ld	20678,a
1649                     ; 632     CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_HSIDIV);
1651  000d 7b01          	ld	a,(OFST+1,sp)
1652  000f a418          	and	a,#24
1653  0011 ca50c6        	or	a,20678
1654  0014 c750c6        	ld	20678,a
1656  0017 2012          	jra	L137
1657  0019               L727:
1658                     ; 636     CLK->CKDIVR &= (u8)(~CLK_CKDIVR_CPUDIV);
1660  0019 c650c6        	ld	a,20678
1661  001c a4f8          	and	a,#248
1662  001e c750c6        	ld	20678,a
1663                     ; 637     CLK->CKDIVR |= (u8)((u8)ClockPrescaler & (u8)CLK_CKDIVR_CPUDIV);
1665  0021 7b01          	ld	a,(OFST+1,sp)
1666  0023 a407          	and	a,#7
1667  0025 ca50c6        	or	a,20678
1668  0028 c750c6        	ld	20678,a
1669  002b               L137:
1670                     ; 640 }
1673  002b 84            	pop	a
1674  002c 81            	ret
1730                     ; 654 void CLK_SWIMConfig(CLK_SWIMDivider_TypeDef CLK_SWIMDivider)
1730                     ; 655 {
1731                     .text:	section	.text,new
1732  0000               _CLK_SWIMConfig:
1736                     ; 658   assert_param(IS_CLK_SWIMDIVIDER_OK(CLK_SWIMDivider));
1738                     ; 660   if (CLK_SWIMDivider != CLK_SWIMDIVIDER_2)
1740  0000 4d            	tnz	a
1741  0001 2706          	jreq	L167
1742                     ; 663     CLK->SWIMCCR |= CLK_SWIMCCR_SWIMDIV;
1744  0003 721050cd      	bset	20685,#0
1746  0007 2004          	jra	L367
1747  0009               L167:
1748                     ; 668     CLK->SWIMCCR &= (u8)(~CLK_SWIMCCR_SWIMDIV);
1750  0009 721150cd      	bres	20685,#0
1751  000d               L367:
1752                     ; 671 }
1755  000d 81            	ret
1852                     ; 686 void CLK_CANConfig(CLK_CANDivider_TypeDef CLK_CANDivider)
1852                     ; 687 {
1853                     .text:	section	.text,new
1854  0000               _CLK_CANConfig:
1856  0000 88            	push	a
1857       00000000      OFST:	set	0
1860                     ; 690   assert_param(IS_CLK_CANDIVIDER_OK(CLK_CANDivider));
1862                     ; 693   CLK->CANCCR &= (u8)(~CLK_CANCCR_CANDIV);
1864  0001 c650cb        	ld	a,20683
1865  0004 a4f8          	and	a,#248
1866  0006 c750cb        	ld	20683,a
1867                     ; 696   CLK->CANCCR |= (u8)CLK_CANDivider;
1869  0009 c650cb        	ld	a,20683
1870  000c 1a01          	or	a,(OFST+1,sp)
1871  000e c750cb        	ld	20683,a
1872                     ; 698 }
1875  0011 84            	pop	a
1876  0012 81            	ret
1900                     ; 715 void CLK_ClockSecuritySystemEnable(void)
1900                     ; 716 {
1901                     .text:	section	.text,new
1902  0000               _CLK_ClockSecuritySystemEnable:
1906                     ; 718   CLK->CSSR |= CLK_CSSR_CSSEN;
1908  0000 721050c8      	bset	20680,#0
1909                     ; 719 }
1912  0004 81            	ret
1937                     ; 736 CLK_Source_TypeDef CLK_GetSYSCLKSource(void)
1937                     ; 737 {
1938                     .text:	section	.text,new
1939  0000               _CLK_GetSYSCLKSource:
1943                     ; 738   return((CLK_Source_TypeDef)CLK->CMSR);
1945  0000 c650c3        	ld	a,20675
1948  0003 81            	ret
2005                     ; 756 u32 CLK_GetClockFreq(void)
2005                     ; 757 {
2006                     .text:	section	.text,new
2007  0000               _CLK_GetClockFreq:
2009  0000 5209          	subw	sp,#9
2010       00000009      OFST:	set	9
2013                     ; 759   u32 clockfrequency = 0;
2015  0002 96            	ldw	x,sp
2016  0003 1c0005        	addw	x,#OFST-4
2017  0006 cd0000        	call	c_ltor
2019                     ; 760   CLK_Source_TypeDef clocksource = CLK_SOURCE_HSI;
2021  0009 7b09          	ld	a,(OFST+0,sp)
2022  000b 97            	ld	xl,a
2023                     ; 761   u8 tmp = 0, presc = 0;
2025  000c 7b09          	ld	a,(OFST+0,sp)
2026  000e 97            	ld	xl,a
2029  000f 7b09          	ld	a,(OFST+0,sp)
2030  0011 97            	ld	xl,a
2031                     ; 764   clocksource = (CLK_Source_TypeDef)CLK->CMSR;
2033  0012 c650c3        	ld	a,20675
2034  0015 6b09          	ld	(OFST+0,sp),a
2035                     ; 766   if (clocksource == CLK_SOURCE_HSI)
2037  0017 7b09          	ld	a,(OFST+0,sp)
2038  0019 a1e1          	cp	a,#225
2039  001b 2642          	jrne	L3701
2040                     ; 768     tmp = (u8)(CLK->CKDIVR & CLK_CKDIVR_HSIDIV);
2042  001d c650c6        	ld	a,20678
2043  0020 a418          	and	a,#24
2044  0022 6b09          	ld	(OFST+0,sp),a
2045                     ; 769     tmp = (u8)(tmp >> 3);
2047  0024 7b09          	ld	a,(OFST+0,sp)
2048  0026 44            	srl	a
2049  0027 44            	srl	a
2050  0028 44            	srl	a
2051  0029 6b09          	ld	(OFST+0,sp),a
2052                     ; 770     presc = HSIDivFactor[tmp];
2054  002b 7b09          	ld	a,(OFST+0,sp)
2055  002d 5f            	clrw	x
2056  002e 97            	ld	xl,a
2057  002f d60000        	ld	a,(_HSIDivFactor,x)
2058  0032 6b09          	ld	(OFST+0,sp),a
2059                     ; 771     clockfrequency = HSI_VALUE / presc;
2061  0034 7b09          	ld	a,(OFST+0,sp)
2062  0036 b703          	ld	c_lreg+3,a
2063  0038 3f02          	clr	c_lreg+2
2064  003a 3f01          	clr	c_lreg+1
2065  003c 3f00          	clr	c_lreg
2066  003e 96            	ldw	x,sp
2067  003f 1c0001        	addw	x,#OFST-8
2068  0042 cd0000        	call	c_rtol
2070  0045 ae2400        	ldw	x,#9216
2071  0048 bf02          	ldw	c_lreg+2,x
2072  004a ae00f4        	ldw	x,#244
2073  004d bf00          	ldw	c_lreg,x
2074  004f 96            	ldw	x,sp
2075  0050 1c0001        	addw	x,#OFST-8
2076  0053 cd0000        	call	c_ludv
2078  0056 96            	ldw	x,sp
2079  0057 1c0005        	addw	x,#OFST-4
2080  005a cd0000        	call	c_rtol
2083  005d 201c          	jra	L5701
2084  005f               L3701:
2085                     ; 773   else if ( clocksource == CLK_SOURCE_LSI)
2087  005f 7b09          	ld	a,(OFST+0,sp)
2088  0061 a1d2          	cp	a,#210
2089  0063 260c          	jrne	L7701
2090                     ; 775     clockfrequency = LSI_VALUE;
2092  0065 aef400        	ldw	x,#62464
2093  0068 1f07          	ldw	(OFST-2,sp),x
2094  006a ae0001        	ldw	x,#1
2095  006d 1f05          	ldw	(OFST-4,sp),x
2097  006f 200a          	jra	L5701
2098  0071               L7701:
2099                     ; 779     clockfrequency = HSE_VALUE;
2101  0071 ae2400        	ldw	x,#9216
2102  0074 1f07          	ldw	(OFST-2,sp),x
2103  0076 ae00f4        	ldw	x,#244
2104  0079 1f05          	ldw	(OFST-4,sp),x
2105  007b               L5701:
2106                     ; 782   return((u32)clockfrequency);
2108  007b 96            	ldw	x,sp
2109  007c 1c0005        	addw	x,#OFST-4
2110  007f cd0000        	call	c_ltor
2114  0082 5b09          	addw	sp,#9
2115  0084 81            	ret
2214                     ; 800 void CLK_AdjustHSICalibrationValue(CLK_HSITrimValue_TypeDef CLK_HSICalibrationValue)
2214                     ; 801 {
2215                     .text:	section	.text,new
2216  0000               _CLK_AdjustHSICalibrationValue:
2218  0000 88            	push	a
2219       00000000      OFST:	set	0
2222                     ; 804   assert_param(IS_CLK_HSITRIMVALUE_OK(CLK_HSICalibrationValue));
2224                     ; 807   CLK->HSITRIMR = (u8)((CLK->HSITRIMR & (u8)(~CLK_HSITRIMR_HSITRIM))|((u8)CLK_HSICalibrationValue));
2226  0001 c650cc        	ld	a,20684
2227  0004 a4f8          	and	a,#248
2228  0006 1a01          	or	a,(OFST+1,sp)
2229  0008 c750cc        	ld	20684,a
2230                     ; 809 }
2233  000b 84            	pop	a
2234  000c 81            	ret
2258                     ; 828 void CLK_SYSCLKEmergencyClear(void)
2258                     ; 829 {
2259                     .text:	section	.text,new
2260  0000               _CLK_SYSCLKEmergencyClear:
2264                     ; 830   CLK->SWCR &= (u8)(~CLK_SWCR_SWBSY);
2266  0000 721150c5      	bres	20677,#0
2267                     ; 831 }
2270  0004 81            	ret
2419                     ; 847 FlagStatus CLK_GetFlagStatus(CLK_Flag_TypeDef CLK_FLAG)
2419                     ; 848 {
2420                     .text:	section	.text,new
2421  0000               _CLK_GetFlagStatus:
2423  0000 89            	pushw	x
2424  0001 5203          	subw	sp,#3
2425       00000003      OFST:	set	3
2428                     ; 850   u16 statusreg = 0;
2430  0003 1e01          	ldw	x,(OFST-2,sp)
2431                     ; 851   u8 tmpreg = 0;
2433  0005 7b03          	ld	a,(OFST+0,sp)
2434  0007 97            	ld	xl,a
2435                     ; 852   FlagStatus bitstatus = RESET;
2437  0008 7b03          	ld	a,(OFST+0,sp)
2438  000a 97            	ld	xl,a
2439                     ; 855   assert_param(IS_CLK_FLAG_OK(CLK_FLAG));
2441                     ; 858   statusreg = (u16)((u16)CLK_FLAG & (u16)0xFF00);
2443  000b 7b04          	ld	a,(OFST+1,sp)
2444  000d 97            	ld	xl,a
2445  000e 7b05          	ld	a,(OFST+2,sp)
2446  0010 9f            	ld	a,xl
2447  0011 a4ff          	and	a,#255
2448  0013 97            	ld	xl,a
2449  0014 4f            	clr	a
2450  0015 02            	rlwa	x,a
2451  0016 1f01          	ldw	(OFST-2,sp),x
2452  0018 01            	rrwa	x,a
2453                     ; 861   if (statusreg == 0x0100) /* The flag to check is in ICKRregister */
2455  0019 1e01          	ldw	x,(OFST-2,sp)
2456  001b a30100        	cpw	x,#256
2457  001e 2607          	jrne	L1421
2458                     ; 863     tmpreg = CLK->ICKR;
2460  0020 c650c0        	ld	a,20672
2461  0023 6b03          	ld	(OFST+0,sp),a
2463  0025 202f          	jra	L3421
2464  0027               L1421:
2465                     ; 865   else if (statusreg == 0x0200) /* The flag to check is in ECKRregister */
2467  0027 1e01          	ldw	x,(OFST-2,sp)
2468  0029 a30200        	cpw	x,#512
2469  002c 2607          	jrne	L5421
2470                     ; 867     tmpreg = CLK->ECKR;
2472  002e c650c1        	ld	a,20673
2473  0031 6b03          	ld	(OFST+0,sp),a
2475  0033 2021          	jra	L3421
2476  0035               L5421:
2477                     ; 869   else if (statusreg == 0x0300) /* The flag to check is in SWIC register */
2479  0035 1e01          	ldw	x,(OFST-2,sp)
2480  0037 a30300        	cpw	x,#768
2481  003a 2607          	jrne	L1521
2482                     ; 871     tmpreg = CLK->SWCR;
2484  003c c650c5        	ld	a,20677
2485  003f 6b03          	ld	(OFST+0,sp),a
2487  0041 2013          	jra	L3421
2488  0043               L1521:
2489                     ; 873   else if (statusreg == 0x0400) /* The flag to check is in CSS register */
2491  0043 1e01          	ldw	x,(OFST-2,sp)
2492  0045 a30400        	cpw	x,#1024
2493  0048 2607          	jrne	L5521
2494                     ; 875     tmpreg = CLK->CSSR;
2496  004a c650c8        	ld	a,20680
2497  004d 6b03          	ld	(OFST+0,sp),a
2499  004f 2005          	jra	L3421
2500  0051               L5521:
2501                     ; 879     tmpreg = CLK->CCOR;
2503  0051 c650c9        	ld	a,20681
2504  0054 6b03          	ld	(OFST+0,sp),a
2505  0056               L3421:
2506                     ; 882   if ((tmpreg & (u8)CLK_FLAG) != (u8)RESET)
2508  0056 7b05          	ld	a,(OFST+2,sp)
2509  0058 1503          	bcp	a,(OFST+0,sp)
2510  005a 2706          	jreq	L1621
2511                     ; 884     bitstatus = SET;
2513  005c a601          	ld	a,#1
2514  005e 6b03          	ld	(OFST+0,sp),a
2516  0060 2002          	jra	L3621
2517  0062               L1621:
2518                     ; 888     bitstatus = RESET;
2520  0062 0f03          	clr	(OFST+0,sp)
2521  0064               L3621:
2522                     ; 892   return((FlagStatus)bitstatus);
2524  0064 7b03          	ld	a,(OFST+0,sp)
2527  0066 5b05          	addw	sp,#5
2528  0068 81            	ret
2574                     ; 913 ITStatus CLK_GetITStatus(CLK_IT_TypeDef CLK_IT)
2574                     ; 914 {
2575                     .text:	section	.text,new
2576  0000               _CLK_GetITStatus:
2578  0000 88            	push	a
2579  0001 88            	push	a
2580       00000001      OFST:	set	1
2583                     ; 916   ITStatus bitstatus = RESET;
2585  0002 0f01          	clr	(OFST+0,sp)
2586                     ; 919   assert_param(IS_CLK_IT_OK(CLK_IT));
2588                     ; 921   if (CLK_IT == CLK_IT_SWIF)
2590  0004 a11c          	cp	a,#28
2591  0006 2611          	jrne	L7031
2592                     ; 924     if ((CLK->SWCR & (u8)CLK_IT) == (u8)0x0C)
2594  0008 c450c5        	and	a,20677
2595  000b a10c          	cp	a,#12
2596  000d 2606          	jrne	L1131
2597                     ; 926       bitstatus = SET;
2599  000f a601          	ld	a,#1
2600  0011 6b01          	ld	(OFST+0,sp),a
2602  0013 2015          	jra	L5131
2603  0015               L1131:
2604                     ; 930       bitstatus = RESET;
2606  0015 0f01          	clr	(OFST+0,sp)
2607  0017 2011          	jra	L5131
2608  0019               L7031:
2609                     ; 936     if ((CLK->CSSR & (u8)CLK_IT) == (u8)0x0C)
2611  0019 c650c8        	ld	a,20680
2612  001c 1402          	and	a,(OFST+1,sp)
2613  001e a10c          	cp	a,#12
2614  0020 2606          	jrne	L7131
2615                     ; 938       bitstatus = SET;
2617  0022 a601          	ld	a,#1
2618  0024 6b01          	ld	(OFST+0,sp),a
2620  0026 2002          	jra	L5131
2621  0028               L7131:
2622                     ; 942       bitstatus = RESET;
2624  0028 0f01          	clr	(OFST+0,sp)
2625  002a               L5131:
2626                     ; 947   return bitstatus;
2628  002a 7b01          	ld	a,(OFST+0,sp)
2631  002c 85            	popw	x
2632  002d 81            	ret
2668                     ; 966 void CLK_ClearITPendingBit(CLK_IT_TypeDef CLK_IT)
2668                     ; 967 {
2669                     .text:	section	.text,new
2670  0000               _CLK_ClearITPendingBit:
2674                     ; 970   assert_param(IS_CLK_IT_OK(CLK_IT));
2676                     ; 972   if (CLK_IT == (u8)CLK_IT_CSSD)
2678  0000 a10c          	cp	a,#12
2679  0002 2606          	jrne	L1431
2680                     ; 975     CLK->CSSR &= (u8)(~CLK_CSSR_CSSD);
2682  0004 721750c8      	bres	20680,#3
2684  0008 2004          	jra	L3431
2685  000a               L1431:
2686                     ; 980     CLK->SWCR &= (u8)(~CLK_SWCR_SWIF);
2688  000a 721750c5      	bres	20677,#3
2689  000e               L3431:
2690                     ; 983 }
2693  000e 81            	ret
2728                     	xdef	_CLKPrescTable
2729                     	xdef	_HSIDivFactor
2730                     	xdef	_CLK_ClearITPendingBit
2731                     	xdef	_CLK_GetITStatus
2732                     	xdef	_CLK_GetFlagStatus
2733                     	xdef	_CLK_GetSYSCLKSource
2734                     	xdef	_CLK_GetClockFreq
2735                     	xdef	_CLK_AdjustHSICalibrationValue
2736                     	xdef	_CLK_SYSCLKEmergencyClear
2737                     	xdef	_CLK_ClockSecuritySystemEnable
2738                     	xdef	_CLK_CANConfig
2739                     	xdef	_CLK_SWIMConfig
2740                     	xdef	_CLK_SYSCLKConfig
2741                     	xdef	_CLK_ITConfig
2742                     	xdef	_CLK_CCOConfig
2743                     	xdef	_CLK_HSIPrescalerConfig
2744                     	xdef	_CLK_ClockSwitchConfig
2745                     	xdef	_CLK_PeripheralClockConfig
2746                     	xdef	_CLK_SlowActiveHaltWakeUpCmd
2747                     	xdef	_CLK_FastHaltWakeUpCmd
2748                     	xdef	_CLK_ClockSwitchCmd
2749                     	xdef	_CLK_CCOCmd
2750                     	xdef	_CLK_LSICmd
2751                     	xdef	_CLK_HSICmd
2752                     	xdef	_CLK_HSECmd
2753                     	xdef	_CLK_DeInit
2754                     	xref.b	c_lreg
2773                     	xref	c_ludv
2774                     	xref	c_rtol
2775                     	xref	c_ltor
2776                     	end
