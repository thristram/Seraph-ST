   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  41                     ; 64 void UART1_DeInit(void)
  41                     ; 65 {
  43                     .text:	section	.text,new
  44  0000               _UART1_DeInit:
  46  0000 88            	push	a
  47       00000001      OFST:	set	1
  50                     ; 66   u8 dummy = 0;
  52  0001 0f01          	clr	(OFST+0,sp)
  53                     ; 70   dummy = UART1->SR;
  55  0003 c65230        	ld	a,21040
  56  0006 6b01          	ld	(OFST+0,sp),a
  57                     ; 71   dummy = UART1->DR;
  59  0008 c65231        	ld	a,21041
  60  000b 6b01          	ld	(OFST+0,sp),a
  61                     ; 73   UART1->BRR2 = UART1_BRR2_RESET_VALUE;  /*< Set UART1_BRR2 to reset value 0x00 */
  63  000d 725f5233      	clr	21043
  64                     ; 74   UART1->BRR1 = UART1_BRR1_RESET_VALUE;  /*< Set UART1_BRR1 to reset value 0x00 */
  66  0011 725f5232      	clr	21042
  67                     ; 76   UART1->CR1 = UART1_CR1_RESET_VALUE; /*< Set UART1_CR1 to reset value 0x00  */
  69  0015 725f5234      	clr	21044
  70                     ; 77   UART1->CR2 = UART1_CR2_RESET_VALUE; /*< Set UART1_CR2 to reset value 0x00  */
  72  0019 725f5235      	clr	21045
  73                     ; 78   UART1->CR3 = UART1_CR3_RESET_VALUE;  /*< Set UART1_CR3 to reset value 0x00  */
  75  001d 725f5236      	clr	21046
  76                     ; 79   UART1->CR4 = UART1_CR4_RESET_VALUE;  /*< Set UART1_CR4 to reset value 0x00  */
  78  0021 725f5237      	clr	21047
  79                     ; 80   UART1->CR5 = UART1_CR5_RESET_VALUE; /*< Set UART1_CR5 to reset value 0x00  */
  81  0025 725f5238      	clr	21048
  82                     ; 82   UART1->GTR = UART1_GTR_RESET_VALUE;
  84  0029 725f5239      	clr	21049
  85                     ; 83   UART1->PSCR = UART1_PSCR_RESET_VALUE;
  87  002d 725f523a      	clr	21050
  88                     ; 84 }
  91  0031 84            	pop	a
  92  0032 81            	ret
 389                     .const:	section	.text
 390  0000               L01:
 391  0000 00000064      	dc.l	100
 392                     ; 104 void UART1_Init(u32 BaudRate, UART1_WordLength_TypeDef WordLength, UART1_StopBits_TypeDef StopBits, UART1_Parity_TypeDef Parity, UART1_SyncMode_TypeDef SyncMode, UART1_Mode_TypeDef Mode)
 392                     ; 105 {
 393                     .text:	section	.text,new
 394  0000               _UART1_Init:
 396  0000 520c          	subw	sp,#12
 397       0000000c      OFST:	set	12
 400                     ; 106   u32 BaudRate_Mantissa, BaudRate_Mantissa100 = 0;
 402  0002 96            	ldw	x,sp
 403  0003 1c0005        	addw	x,#OFST-7
 404  0006 cd0000        	call	c_ltor
 406                     ; 109   assert_param(IS_UART1_BAUDRATE_OK(BaudRate));
 408                     ; 111   assert_param(IS_UART1_WORDLENGTH_OK(WordLength));
 410                     ; 113   assert_param(IS_UART1_STOPBITS_OK(StopBits));
 412                     ; 115   assert_param(IS_UART1_PARITY_OK(Parity));
 414                     ; 118   assert_param(IS_UART1_MODE_OK((u8)Mode));
 416                     ; 122   assert_param(IS_UART1_SYNCMODE_OK((u8)SyncMode));
 418                     ; 124   UART1->CR1 &= (u8)(~UART1_CR1_M);  /**< Clear the word length bit */
 420  0009 72195234      	bres	21044,#4
 421                     ; 125   UART1->CR1 |= (u8)WordLength; /**< Set the word length bit according to UART1_WordLength value */
 423  000d c65234        	ld	a,21044
 424  0010 1a13          	or	a,(OFST+7,sp)
 425  0012 c75234        	ld	21044,a
 426                     ; 127   UART1->CR3 &= (u8)(~UART1_CR3_STOP);  /**< Clear the STOP bits */
 428  0015 c65236        	ld	a,21046
 429  0018 a4cf          	and	a,#207
 430  001a c75236        	ld	21046,a
 431                     ; 128   UART1->CR3 |= (u8)StopBits;  /**< Set the STOP bits number according to UART1_StopBits value  */
 433  001d c65236        	ld	a,21046
 434  0020 1a14          	or	a,(OFST+8,sp)
 435  0022 c75236        	ld	21046,a
 436                     ; 130   UART1->CR1 &= (u8)(~(UART1_CR1_PCEN | UART1_CR1_PS  ));  /**< Clear the Parity Control bit */
 438  0025 c65234        	ld	a,21044
 439  0028 a4f9          	and	a,#249
 440  002a c75234        	ld	21044,a
 441                     ; 131   UART1->CR1 |= (u8)Parity;  /**< Set the Parity Control bit to UART1_Parity value */
 443  002d c65234        	ld	a,21044
 444  0030 1a15          	or	a,(OFST+9,sp)
 445  0032 c75234        	ld	21044,a
 446                     ; 133   UART1->BRR1 &= (u8)(~UART1_BRR1_DIVM);  /**< Clear the LSB mantissa of UART1DIV  */
 448  0035 725f5232      	clr	21042
 449                     ; 134   UART1->BRR2 &= (u8)(~UART1_BRR2_DIVM);  /**< Clear the MSB mantissa of UART1DIV  */
 451  0039 c65233        	ld	a,21043
 452  003c a40f          	and	a,#15
 453  003e c75233        	ld	21043,a
 454                     ; 135   UART1->BRR2 &= (u8)(~UART1_BRR2_DIVF);  /**< Clear the Fraction bits of UART1DIV */
 456  0041 c65233        	ld	a,21043
 457  0044 a4f0          	and	a,#240
 458  0046 c75233        	ld	21043,a
 459                     ; 138   BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (BaudRate << 4));
 461  0049 96            	ldw	x,sp
 462  004a 1c000f        	addw	x,#OFST+3
 463  004d cd0000        	call	c_ltor
 465  0050 a604          	ld	a,#4
 466  0052 cd0000        	call	c_llsh
 468  0055 96            	ldw	x,sp
 469  0056 1c0001        	addw	x,#OFST-11
 470  0059 cd0000        	call	c_rtol
 472  005c cd0000        	call	_CLK_GetClockFreq
 474  005f 96            	ldw	x,sp
 475  0060 1c0001        	addw	x,#OFST-11
 476  0063 cd0000        	call	c_ludv
 478  0066 96            	ldw	x,sp
 479  0067 1c0009        	addw	x,#OFST-3
 480  006a cd0000        	call	c_rtol
 482                     ; 139   BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 484  006d 96            	ldw	x,sp
 485  006e 1c000f        	addw	x,#OFST+3
 486  0071 cd0000        	call	c_ltor
 488  0074 a604          	ld	a,#4
 489  0076 cd0000        	call	c_llsh
 491  0079 96            	ldw	x,sp
 492  007a 1c0001        	addw	x,#OFST-11
 493  007d cd0000        	call	c_rtol
 495  0080 cd0000        	call	_CLK_GetClockFreq
 497  0083 a664          	ld	a,#100
 498  0085 cd0000        	call	c_smul
 500  0088 96            	ldw	x,sp
 501  0089 1c0001        	addw	x,#OFST-11
 502  008c cd0000        	call	c_ludv
 504  008f 96            	ldw	x,sp
 505  0090 1c0005        	addw	x,#OFST-7
 506  0093 cd0000        	call	c_rtol
 508                     ; 140   UART1->BRR2 |= (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100)) << 4) / 100) & (u8)0x0F); /**< Set the fraction of UART1DIV  */
 510  0096 96            	ldw	x,sp
 511  0097 1c0009        	addw	x,#OFST-3
 512  009a cd0000        	call	c_ltor
 514  009d a664          	ld	a,#100
 515  009f cd0000        	call	c_smul
 517  00a2 96            	ldw	x,sp
 518  00a3 1c0001        	addw	x,#OFST-11
 519  00a6 cd0000        	call	c_rtol
 521  00a9 96            	ldw	x,sp
 522  00aa 1c0005        	addw	x,#OFST-7
 523  00ad cd0000        	call	c_ltor
 525  00b0 96            	ldw	x,sp
 526  00b1 1c0001        	addw	x,#OFST-11
 527  00b4 cd0000        	call	c_lsub
 529  00b7 a604          	ld	a,#4
 530  00b9 cd0000        	call	c_llsh
 532  00bc ae0000        	ldw	x,#L01
 533  00bf cd0000        	call	c_ludv
 535  00c2 b603          	ld	a,c_lreg+3
 536  00c4 a40f          	and	a,#15
 537  00c6 ca5233        	or	a,21043
 538  00c9 c75233        	ld	21043,a
 539                     ; 141   UART1->BRR2 |= (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0); /**< Set the MSB mantissa of UART1DIV  */
 541  00cc 96            	ldw	x,sp
 542  00cd 1c0009        	addw	x,#OFST-3
 543  00d0 cd0000        	call	c_ltor
 545  00d3 a604          	ld	a,#4
 546  00d5 cd0000        	call	c_lursh
 548  00d8 b603          	ld	a,c_lreg+3
 549  00da a4f0          	and	a,#240
 550  00dc b703          	ld	c_lreg+3,a
 551  00de 3f02          	clr	c_lreg+2
 552  00e0 3f01          	clr	c_lreg+1
 553  00e2 3f00          	clr	c_lreg
 554  00e4 b603          	ld	a,c_lreg+3
 555  00e6 ca5233        	or	a,21043
 556  00e9 c75233        	ld	21043,a
 557                     ; 142   UART1->BRR1 |= (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of UART1DIV  */
 559  00ec c65232        	ld	a,21042
 560  00ef 1a0c          	or	a,(OFST+0,sp)
 561  00f1 c75232        	ld	21042,a
 562                     ; 144   UART1->CR2 &= (u8)~(UART1_CR2_TEN | UART1_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
 564  00f4 c65235        	ld	a,21045
 565  00f7 a4f3          	and	a,#243
 566  00f9 c75235        	ld	21045,a
 567                     ; 145   UART1->CR3 &= (u8)~(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
 569  00fc c65236        	ld	a,21046
 570  00ff a4f8          	and	a,#248
 571  0101 c75236        	ld	21046,a
 572                     ; 146   UART1->CR3 |= (u8)((u8)SyncMode & (u8)(UART1_CR3_CPOL | UART1_CR3_CPHA | UART1_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */
 574  0104 7b16          	ld	a,(OFST+10,sp)
 575  0106 a407          	and	a,#7
 576  0108 ca5236        	or	a,21046
 577  010b c75236        	ld	21046,a
 578                     ; 148   if ((u8)Mode & (u8)UART1_MODE_TX_ENABLE)
 580  010e 7b17          	ld	a,(OFST+11,sp)
 581  0110 a504          	bcp	a,#4
 582  0112 2706          	jreq	L171
 583                     ; 150     UART1->CR2 |= (u8)UART1_CR2_TEN;  /**< Set the Transmitter Enable bit */
 585  0114 72165235      	bset	21045,#3
 587  0118 2004          	jra	L371
 588  011a               L171:
 589                     ; 154     UART1->CR2 &= (u8)(~UART1_CR2_TEN);  /**< Clear the Transmitter Disable bit */
 591  011a 72175235      	bres	21045,#3
 592  011e               L371:
 593                     ; 156   if ((u8)Mode & (u8)UART1_MODE_RX_ENABLE)
 595  011e 7b17          	ld	a,(OFST+11,sp)
 596  0120 a508          	bcp	a,#8
 597  0122 2706          	jreq	L571
 598                     ; 158     UART1->CR2 |= (u8)UART1_CR2_REN;  /**< Set the Receiver Enable bit */
 600  0124 72145235      	bset	21045,#2
 602  0128 2004          	jra	L771
 603  012a               L571:
 604                     ; 162     UART1->CR2 &= (u8)(~UART1_CR2_REN);  /**< Clear the Receiver Disable bit */
 606  012a 72155235      	bres	21045,#2
 607  012e               L771:
 608                     ; 165   if ((u8)SyncMode&(u8)UART1_SYNCMODE_CLOCK_DISABLE)
 610  012e 7b16          	ld	a,(OFST+10,sp)
 611  0130 a580          	bcp	a,#128
 612  0132 2706          	jreq	L102
 613                     ; 167     UART1->CR3 &= (u8)(~UART1_CR3_CKEN); /**< Clear the Clock Enable bit */
 615  0134 72175236      	bres	21046,#3
 617  0138 200a          	jra	L302
 618  013a               L102:
 619                     ; 172     UART1->CR3 |= (u8)((u8)SyncMode & UART1_CR3_CKEN);
 621  013a 7b16          	ld	a,(OFST+10,sp)
 622  013c a408          	and	a,#8
 623  013e ca5236        	or	a,21046
 624  0141 c75236        	ld	21046,a
 625  0144               L302:
 626                     ; 174 }
 629  0144 5b0c          	addw	sp,#12
 630  0146 81            	ret
 685                     ; 195 void UART1_Cmd(FunctionalState NewState)
 685                     ; 196 {
 686                     .text:	section	.text,new
 687  0000               _UART1_Cmd:
 691                     ; 197   if (NewState != DISABLE)
 693  0000 4d            	tnz	a
 694  0001 2706          	jreq	L332
 695                     ; 199     UART1->CR1 &= (u8)(~UART1_CR1_UARTD); /**< UART1 Enable */
 697  0003 721b5234      	bres	21044,#5
 699  0007 2004          	jra	L532
 700  0009               L332:
 701                     ; 203     UART1->CR1 |= UART1_CR1_UARTD;  /**< UART1 Disable (for low power consumption) */
 703  0009 721a5234      	bset	21044,#5
 704  000d               L532:
 705                     ; 205 }
 708  000d 81            	ret
 829                     ; 231 void UART1_ITConfig(UART1_IT_TypeDef UART1_IT, FunctionalState NewState)
 829                     ; 232 {
 830                     .text:	section	.text,new
 831  0000               _UART1_ITConfig:
 833  0000 89            	pushw	x
 834  0001 89            	pushw	x
 835       00000002      OFST:	set	2
 838                     ; 233   u8 uartreg, itpos = 0x00;
 840  0002 7b02          	ld	a,(OFST+0,sp)
 841  0004 97            	ld	xl,a
 842                     ; 234   assert_param(IS_UART1_CONFIG_IT_OK(UART1_IT));
 844                     ; 235   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 846                     ; 238   uartreg = (u8)(UART1_IT >> (u8)0x08);
 848  0005 7b03          	ld	a,(OFST+1,sp)
 849  0007 6b01          	ld	(OFST-1,sp),a
 850                     ; 240   itpos = (u8)((u8)1 << (u8)((u8)UART1_IT & (u8)0x0F));
 852  0009 7b04          	ld	a,(OFST+2,sp)
 853  000b a40f          	and	a,#15
 854  000d 5f            	clrw	x
 855  000e 97            	ld	xl,a
 856  000f a601          	ld	a,#1
 857  0011 5d            	tnzw	x
 858  0012 2704          	jreq	L61
 859  0014               L02:
 860  0014 48            	sll	a
 861  0015 5a            	decw	x
 862  0016 26fc          	jrne	L02
 863  0018               L61:
 864  0018 6b02          	ld	(OFST+0,sp),a
 865                     ; 242   if (NewState != DISABLE)
 867  001a 0d07          	tnz	(OFST+5,sp)
 868  001c 272a          	jreq	L113
 869                     ; 245     if (uartreg == 0x01)
 871  001e 7b01          	ld	a,(OFST-1,sp)
 872  0020 a101          	cp	a,#1
 873  0022 260a          	jrne	L313
 874                     ; 247       UART1->CR1 |= itpos;
 876  0024 c65234        	ld	a,21044
 877  0027 1a02          	or	a,(OFST+0,sp)
 878  0029 c75234        	ld	21044,a
 880  002c 2045          	jra	L323
 881  002e               L313:
 882                     ; 249     else if (uartreg == 0x02)
 884  002e 7b01          	ld	a,(OFST-1,sp)
 885  0030 a102          	cp	a,#2
 886  0032 260a          	jrne	L713
 887                     ; 251       UART1->CR2 |= itpos;
 889  0034 c65235        	ld	a,21045
 890  0037 1a02          	or	a,(OFST+0,sp)
 891  0039 c75235        	ld	21045,a
 893  003c 2035          	jra	L323
 894  003e               L713:
 895                     ; 255       UART1->CR4 |= itpos;
 897  003e c65237        	ld	a,21047
 898  0041 1a02          	or	a,(OFST+0,sp)
 899  0043 c75237        	ld	21047,a
 900  0046 202b          	jra	L323
 901  0048               L113:
 902                     ; 261     if (uartreg == 0x01)
 904  0048 7b01          	ld	a,(OFST-1,sp)
 905  004a a101          	cp	a,#1
 906  004c 260b          	jrne	L523
 907                     ; 263       UART1->CR1 &= (u8)(~itpos);
 909  004e 7b02          	ld	a,(OFST+0,sp)
 910  0050 43            	cpl	a
 911  0051 c45234        	and	a,21044
 912  0054 c75234        	ld	21044,a
 914  0057 201a          	jra	L323
 915  0059               L523:
 916                     ; 265     else if (uartreg == 0x02)
 918  0059 7b01          	ld	a,(OFST-1,sp)
 919  005b a102          	cp	a,#2
 920  005d 260b          	jrne	L133
 921                     ; 267       UART1->CR2 &= (u8)(~itpos);
 923  005f 7b02          	ld	a,(OFST+0,sp)
 924  0061 43            	cpl	a
 925  0062 c45235        	and	a,21045
 926  0065 c75235        	ld	21045,a
 928  0068 2009          	jra	L323
 929  006a               L133:
 930                     ; 271       UART1->CR4 &= (u8)(~itpos);
 932  006a 7b02          	ld	a,(OFST+0,sp)
 933  006c 43            	cpl	a
 934  006d c45237        	and	a,21047
 935  0070 c75237        	ld	21047,a
 936  0073               L323:
 937                     ; 275 }
 940  0073 5b04          	addw	sp,#4
 941  0075 81            	ret
 977                     ; 292 void UART1_HalfDuplexCmd(FunctionalState NewState)
 977                     ; 293 {
 978                     .text:	section	.text,new
 979  0000               _UART1_HalfDuplexCmd:
 983                     ; 294   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 985                     ; 296   if (NewState != DISABLE)
 987  0000 4d            	tnz	a
 988  0001 2706          	jreq	L353
 989                     ; 298     UART1->CR5 |= UART1_CR5_HDSEL;  /**< UART1 Half Duplex Enable  */
 991  0003 72165238      	bset	21048,#3
 993  0007 2004          	jra	L553
 994  0009               L353:
 995                     ; 302     UART1->CR5 &= (u8)~UART1_CR5_HDSEL; /**< UART1 Half Duplex Disable */
 997  0009 72175238      	bres	21048,#3
 998  000d               L553:
 999                     ; 304 }
1002  000d 81            	ret
1059                     ; 323 void UART1_IrDAConfig(UART1_IrDAMode_TypeDef UART1_IrDAMode)
1059                     ; 324 {
1060                     .text:	section	.text,new
1061  0000               _UART1_IrDAConfig:
1065                     ; 325   assert_param(IS_UART1_IRDAMODE_OK(UART1_IrDAMode));
1067                     ; 327   if (UART1_IrDAMode != UART1_IRDAMODE_NORMAL)
1069  0000 4d            	tnz	a
1070  0001 2706          	jreq	L504
1071                     ; 329     UART1->CR5 |= UART1_CR5_IRLP;
1073  0003 72145238      	bset	21048,#2
1075  0007 2004          	jra	L704
1076  0009               L504:
1077                     ; 333     UART1->CR5 &= ((u8)~UART1_CR5_IRLP);
1079  0009 72155238      	bres	21048,#2
1080  000d               L704:
1081                     ; 335 }
1084  000d 81            	ret
1119                     ; 354 void UART1_IrDACmd(FunctionalState NewState)
1119                     ; 355 {
1120                     .text:	section	.text,new
1121  0000               _UART1_IrDACmd:
1125                     ; 358   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1127                     ; 360   if (NewState != DISABLE)
1129  0000 4d            	tnz	a
1130  0001 2706          	jreq	L724
1131                     ; 363     UART1->CR5 |= UART1_CR5_IREN;
1133  0003 72125238      	bset	21048,#1
1135  0007 2004          	jra	L134
1136  0009               L724:
1137                     ; 368     UART1->CR5 &= ((u8)~UART1_CR5_IREN);
1139  0009 72135238      	bres	21048,#1
1140  000d               L134:
1141                     ; 370 }
1144  000d 81            	ret
1203                     ; 388 void UART1_LINBreakDetectionConfig(UART1_LINBreakDetectionLength_TypeDef UART1_LINBreakDetectionLength)
1203                     ; 389 {
1204                     .text:	section	.text,new
1205  0000               _UART1_LINBreakDetectionConfig:
1209                     ; 390   assert_param(IS_UART1_LINBREAKDETECTIONLENGTH_OK(UART1_LINBreakDetectionLength));
1211                     ; 392   if (UART1_LINBreakDetectionLength != UART1_LINBREAKDETECTIONLENGTH_10BITS)
1213  0000 4d            	tnz	a
1214  0001 2706          	jreq	L164
1215                     ; 394     UART1->CR4 |= UART1_CR4_LBDL;
1217  0003 721a5237      	bset	21047,#5
1219  0007 2004          	jra	L364
1220  0009               L164:
1221                     ; 398     UART1->CR4 &= ((u8)~UART1_CR4_LBDL);
1223  0009 721b5237      	bres	21047,#5
1224  000d               L364:
1225                     ; 400 }
1228  000d 81            	ret
1263                     ; 418 void UART1_LINCmd(FunctionalState NewState)
1263                     ; 419 {
1264                     .text:	section	.text,new
1265  0000               _UART1_LINCmd:
1269                     ; 420   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1271                     ; 422   if (NewState != DISABLE)
1273  0000 4d            	tnz	a
1274  0001 2706          	jreq	L305
1275                     ; 425     UART1->CR3 |= UART1_CR3_LINEN;
1277  0003 721c5236      	bset	21046,#6
1279  0007 2004          	jra	L505
1280  0009               L305:
1281                     ; 430     UART1->CR3 &= ((u8)~UART1_CR3_LINEN);
1283  0009 721d5236      	bres	21046,#6
1284  000d               L505:
1285                     ; 432 }
1288  000d 81            	ret
1323                     ; 451 void UART1_SmartCardCmd(FunctionalState NewState)
1323                     ; 452 {
1324                     .text:	section	.text,new
1325  0000               _UART1_SmartCardCmd:
1329                     ; 453   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1331                     ; 455   if (NewState != DISABLE)
1333  0000 4d            	tnz	a
1334  0001 2706          	jreq	L525
1335                     ; 458     UART1->CR5 |= UART1_CR5_SCEN;
1337  0003 721a5238      	bset	21048,#5
1339  0007 2004          	jra	L725
1340  0009               L525:
1341                     ; 463     UART1->CR5 &= ((u8)(~UART1_CR5_SCEN));
1343  0009 721b5238      	bres	21048,#5
1344  000d               L725:
1345                     ; 465 }
1348  000d 81            	ret
1384                     ; 485 void UART1_SmartCardNACKCmd(FunctionalState NewState)
1384                     ; 486 {
1385                     .text:	section	.text,new
1386  0000               _UART1_SmartCardNACKCmd:
1390                     ; 487   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1392                     ; 489   if (NewState != DISABLE)
1394  0000 4d            	tnz	a
1395  0001 2706          	jreq	L745
1396                     ; 492     UART1->CR5 |= UART1_CR5_NACK;
1398  0003 72185238      	bset	21048,#4
1400  0007 2004          	jra	L155
1401  0009               L745:
1402                     ; 497     UART1->CR5 &= ((u8)~(UART1_CR5_NACK));
1404  0009 72195238      	bres	21048,#4
1405  000d               L155:
1406                     ; 499 }
1409  000d 81            	ret
1466                     ; 518 void UART1_WakeUpConfig(UART1_WakeUp_TypeDef UART1_WakeUp)
1466                     ; 519 {
1467                     .text:	section	.text,new
1468  0000               _UART1_WakeUpConfig:
1472                     ; 520   assert_param(IS_UART1_WAKEUP_OK(UART1_WakeUp));
1474                     ; 522   UART1->CR1 &= ((u8)~UART1_CR1_WAKE);
1476  0000 72175234      	bres	21044,#3
1477                     ; 523   UART1->CR1 |= (u8)UART1_WakeUp;
1479  0004 ca5234        	or	a,21044
1480  0007 c75234        	ld	21044,a
1481                     ; 524 }
1484  000a 81            	ret
1520                     ; 541 void UART1_ReceiverWakeUpCmd(FunctionalState NewState)
1520                     ; 542 {
1521                     .text:	section	.text,new
1522  0000               _UART1_ReceiverWakeUpCmd:
1526                     ; 543   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1528                     ; 545   if (NewState != DISABLE)
1530  0000 4d            	tnz	a
1531  0001 2706          	jreq	L716
1532                     ; 548     UART1->CR2 |= UART1_CR2_RWU;
1534  0003 72125235      	bset	21045,#1
1536  0007 2004          	jra	L126
1537  0009               L716:
1538                     ; 553     UART1->CR2 &= ((u8)~UART1_CR2_RWU);
1540  0009 72135235      	bres	21045,#1
1541  000d               L126:
1542                     ; 555 }
1545  000d 81            	ret
1568                     ; 572 u8 UART1_ReceiveData8(void)
1568                     ; 573 {
1569                     .text:	section	.text,new
1570  0000               _UART1_ReceiveData8:
1574                     ; 574   return ((u8)UART1->DR);
1576  0000 c65231        	ld	a,21041
1579  0003 81            	ret
1602                     ; 593 u16 UART1_ReceiveData9(void)
1602                     ; 594 {
1603                     .text:	section	.text,new
1604  0000               _UART1_ReceiveData9:
1606  0000 89            	pushw	x
1607       00000002      OFST:	set	2
1610                     ; 595   return (u16)( (((u16) UART1->DR) | ((u16)(((u16)( (u16)UART1->CR1 & (u16)UART1_CR1_R8)) << 1))) & ((u16)0x01FF));
1612  0001 c65234        	ld	a,21044
1613  0004 5f            	clrw	x
1614  0005 a480          	and	a,#128
1615  0007 5f            	clrw	x
1616  0008 02            	rlwa	x,a
1617  0009 58            	sllw	x
1618  000a 1f01          	ldw	(OFST-1,sp),x
1619  000c c65231        	ld	a,21041
1620  000f 5f            	clrw	x
1621  0010 97            	ld	xl,a
1622  0011 01            	rrwa	x,a
1623  0012 1a02          	or	a,(OFST+0,sp)
1624  0014 01            	rrwa	x,a
1625  0015 1a01          	or	a,(OFST-1,sp)
1626  0017 01            	rrwa	x,a
1627  0018 01            	rrwa	x,a
1628  0019 a4ff          	and	a,#255
1629  001b 01            	rrwa	x,a
1630  001c a401          	and	a,#1
1631  001e 01            	rrwa	x,a
1634  001f 5b02          	addw	sp,#2
1635  0021 81            	ret
1667                     ; 615 void UART1_SendData8(u8 Data)
1667                     ; 616 {
1668                     .text:	section	.text,new
1669  0000               _UART1_SendData8:
1673                     ; 618   UART1->DR = Data;
1675  0000 c75231        	ld	21041,a
1676                     ; 619 }
1679  0003 81            	ret
1711                     ; 638 void UART1_SendData9(u16 Data)
1711                     ; 639 {
1712                     .text:	section	.text,new
1713  0000               _UART1_SendData9:
1715  0000 89            	pushw	x
1716       00000000      OFST:	set	0
1719                     ; 641   UART1->CR1 &= ((u8)~UART1_CR1_T8);
1721  0001 721d5234      	bres	21044,#6
1722                     ; 643   UART1->CR1 |= (u8)(((u8)(Data >> 2)) & UART1_CR1_T8);
1724  0005 54            	srlw	x
1725  0006 54            	srlw	x
1726  0007 9f            	ld	a,xl
1727  0008 a440          	and	a,#64
1728  000a ca5234        	or	a,21044
1729  000d c75234        	ld	21044,a
1730                     ; 645   UART1->DR   = (u8)(Data);
1732  0010 7b02          	ld	a,(OFST+2,sp)
1733  0012 c75231        	ld	21041,a
1734                     ; 646 }
1737  0015 85            	popw	x
1738  0016 81            	ret
1761                     ; 662 void UART1_SendBreak(void)
1761                     ; 663 {
1762                     .text:	section	.text,new
1763  0000               _UART1_SendBreak:
1767                     ; 664   UART1->CR2 |= UART1_CR2_SBK;
1769  0000 72105235      	bset	21045,#0
1770                     ; 665 }
1773  0004 81            	ret
1805                     ; 685 void UART1_SetAddress(u8 UART1_Address)
1805                     ; 686 {
1806                     .text:	section	.text,new
1807  0000               _UART1_SetAddress:
1809  0000 88            	push	a
1810       00000000      OFST:	set	0
1813                     ; 688   assert_param(IS_UART1_ADDRESS_OK(UART1_Address));
1815                     ; 691   UART1->CR4 &= ((u8)~UART1_CR4_ADD);
1817  0001 c65237        	ld	a,21047
1818  0004 a4f0          	and	a,#240
1819  0006 c75237        	ld	21047,a
1820                     ; 693   UART1->CR4 |= UART1_Address;
1822  0009 c65237        	ld	a,21047
1823  000c 1a01          	or	a,(OFST+1,sp)
1824  000e c75237        	ld	21047,a
1825                     ; 694 }
1828  0011 84            	pop	a
1829  0012 81            	ret
1861                     ; 713 void UART1_SetGuardTime(u8 UART1_GuardTime)
1861                     ; 714 {
1862                     .text:	section	.text,new
1863  0000               _UART1_SetGuardTime:
1867                     ; 716   UART1->GTR = UART1_GuardTime;
1869  0000 c75239        	ld	21049,a
1870                     ; 717 }
1873  0003 81            	ret
1905                     ; 751 void UART1_SetPrescaler(u8 UART1_Prescaler)
1905                     ; 752 {
1906                     .text:	section	.text,new
1907  0000               _UART1_SetPrescaler:
1911                     ; 754   UART1->PSCR = UART1_Prescaler;
1913  0000 c7523a        	ld	21050,a
1914                     ; 755 }
1917  0003 81            	ret
2060                     ; 775 FlagStatus UART1_GetFlagStatus(UART1_Flag_TypeDef UART1_FLAG)
2060                     ; 776 {
2061                     .text:	section	.text,new
2062  0000               _UART1_GetFlagStatus:
2064  0000 89            	pushw	x
2065  0001 88            	push	a
2066       00000001      OFST:	set	1
2069                     ; 777   FlagStatus status = RESET;
2071  0002 0f01          	clr	(OFST+0,sp)
2072                     ; 780   assert_param(IS_UART1_FLAG_OK(UART1_FLAG));
2074                     ; 784   if (UART1_FLAG == UART1_FLAG_LBDF)
2076  0004 a30210        	cpw	x,#528
2077  0007 2610          	jrne	L1301
2078                     ; 786     if ((UART1->CR4 & (u8)UART1_FLAG) != (u8)0x00)
2080  0009 9f            	ld	a,xl
2081  000a c45237        	and	a,21047
2082  000d 2706          	jreq	L3301
2083                     ; 789       status = SET;
2085  000f a601          	ld	a,#1
2086  0011 6b01          	ld	(OFST+0,sp),a
2088  0013 202b          	jra	L7301
2089  0015               L3301:
2090                     ; 794       status = RESET;
2092  0015 0f01          	clr	(OFST+0,sp)
2093  0017 2027          	jra	L7301
2094  0019               L1301:
2095                     ; 797   else if (UART1_FLAG == UART1_FLAG_SBK)
2097  0019 1e02          	ldw	x,(OFST+1,sp)
2098  001b a30101        	cpw	x,#257
2099  001e 2611          	jrne	L1401
2100                     ; 799     if ((UART1->CR2 & (u8)UART1_FLAG) != (u8)0x00)
2102  0020 c65235        	ld	a,21045
2103  0023 1503          	bcp	a,(OFST+2,sp)
2104  0025 2706          	jreq	L3401
2105                     ; 802       status = SET;
2107  0027 a601          	ld	a,#1
2108  0029 6b01          	ld	(OFST+0,sp),a
2110  002b 2013          	jra	L7301
2111  002d               L3401:
2112                     ; 807       status = RESET;
2114  002d 0f01          	clr	(OFST+0,sp)
2115  002f 200f          	jra	L7301
2116  0031               L1401:
2117                     ; 812     if ((UART1->SR & (u8)UART1_FLAG) != (u8)0x00)
2119  0031 c65230        	ld	a,21040
2120  0034 1503          	bcp	a,(OFST+2,sp)
2121  0036 2706          	jreq	L1501
2122                     ; 815       status = SET;
2124  0038 a601          	ld	a,#1
2125  003a 6b01          	ld	(OFST+0,sp),a
2127  003c 2002          	jra	L7301
2128  003e               L1501:
2129                     ; 820       status = RESET;
2131  003e 0f01          	clr	(OFST+0,sp)
2132  0040               L7301:
2133                     ; 824   return status;
2135  0040 7b01          	ld	a,(OFST+0,sp)
2138  0042 5b03          	addw	sp,#3
2139  0044 81            	ret
2174                     ; 859 void UART1_ClearFlag(UART1_Flag_TypeDef UART1_FLAG)
2174                     ; 860 {
2175                     .text:	section	.text,new
2176  0000               _UART1_ClearFlag:
2180                     ; 861   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_FLAG));
2182                     ; 864   if (UART1_FLAG == UART1_FLAG_RXNE)
2184  0000 a30020        	cpw	x,#32
2185  0003 2606          	jrne	L3701
2186                     ; 866     UART1->SR = (u8)~(UART1_SR_RXNE);
2188  0005 35df5230      	mov	21040,#223
2190  0009 2004          	jra	L5701
2191  000b               L3701:
2192                     ; 871     UART1->CR4 &= (u8)~(UART1_CR4_LBDF);
2194  000b 72195237      	bres	21047,#4
2195  000f               L5701:
2196                     ; 873 }
2199  000f 81            	ret
2273                     ; 900 ITStatus UART1_GetITStatus(UART1_IT_TypeDef UART1_IT)
2273                     ; 901 {
2274                     .text:	section	.text,new
2275  0000               _UART1_GetITStatus:
2277  0000 89            	pushw	x
2278  0001 89            	pushw	x
2279       00000002      OFST:	set	2
2282                     ; 902   ITStatus pendingbitstatus = RESET;
2284  0002 7b02          	ld	a,(OFST+0,sp)
2285  0004 97            	ld	xl,a
2286                     ; 903   u8 itpos = 0;
2288  0005 7b01          	ld	a,(OFST-1,sp)
2289  0007 97            	ld	xl,a
2290                     ; 904   u8 itmask1 = 0;
2292  0008 7b02          	ld	a,(OFST+0,sp)
2293  000a 97            	ld	xl,a
2294                     ; 905   u8 itmask2 = 0;
2296  000b 7b02          	ld	a,(OFST+0,sp)
2297  000d 97            	ld	xl,a
2298                     ; 906   u8 enablestatus = 0;
2300  000e 7b02          	ld	a,(OFST+0,sp)
2301  0010 97            	ld	xl,a
2302                     ; 909   assert_param(IS_UART1_GET_IT_OK(UART1_IT));
2304                     ; 912   itpos = (u8)((u8)1 << (u8)((u8)UART1_IT & (u8)0x0F));
2306  0011 7b04          	ld	a,(OFST+2,sp)
2307  0013 a40f          	and	a,#15
2308  0015 5f            	clrw	x
2309  0016 97            	ld	xl,a
2310  0017 a601          	ld	a,#1
2311  0019 5d            	tnzw	x
2312  001a 2704          	jreq	L27
2313  001c               L47:
2314  001c 48            	sll	a
2315  001d 5a            	decw	x
2316  001e 26fc          	jrne	L47
2317  0020               L27:
2318  0020 6b01          	ld	(OFST-1,sp),a
2319                     ; 914   itmask1 = (u8)((u8)UART1_IT >> (u8)4);
2321  0022 7b04          	ld	a,(OFST+2,sp)
2322  0024 4e            	swap	a
2323  0025 a40f          	and	a,#15
2324  0027 6b02          	ld	(OFST+0,sp),a
2325                     ; 916   itmask2 = (u8)((u8)1 << itmask1);
2327  0029 7b02          	ld	a,(OFST+0,sp)
2328  002b 5f            	clrw	x
2329  002c 97            	ld	xl,a
2330  002d a601          	ld	a,#1
2331  002f 5d            	tnzw	x
2332  0030 2704          	jreq	L67
2333  0032               L001:
2334  0032 48            	sll	a
2335  0033 5a            	decw	x
2336  0034 26fc          	jrne	L001
2337  0036               L67:
2338  0036 6b02          	ld	(OFST+0,sp),a
2339                     ; 920   if (UART1_IT == UART1_IT_PE)
2341  0038 1e03          	ldw	x,(OFST+1,sp)
2342  003a a30100        	cpw	x,#256
2343  003d 261c          	jrne	L1311
2344                     ; 923     enablestatus = (u8)((u8)UART1->CR1 & itmask2);
2346  003f c65234        	ld	a,21044
2347  0042 1402          	and	a,(OFST+0,sp)
2348  0044 6b02          	ld	(OFST+0,sp),a
2349                     ; 926     if (((UART1->SR & itpos) != (u8)0x00) && enablestatus)
2351  0046 c65230        	ld	a,21040
2352  0049 1501          	bcp	a,(OFST-1,sp)
2353  004b 270a          	jreq	L3311
2355  004d 0d02          	tnz	(OFST+0,sp)
2356  004f 2706          	jreq	L3311
2357                     ; 929       pendingbitstatus = SET;
2359  0051 a601          	ld	a,#1
2360  0053 6b02          	ld	(OFST+0,sp),a
2362  0055 2041          	jra	L7311
2363  0057               L3311:
2364                     ; 934       pendingbitstatus = RESET;
2366  0057 0f02          	clr	(OFST+0,sp)
2367  0059 203d          	jra	L7311
2368  005b               L1311:
2369                     ; 938   else if (UART1_IT == UART1_IT_LBDF)
2371  005b 1e03          	ldw	x,(OFST+1,sp)
2372  005d a30346        	cpw	x,#838
2373  0060 261c          	jrne	L1411
2374                     ; 941     enablestatus = (u8)((u8)UART1->CR4 & itmask2);
2376  0062 c65237        	ld	a,21047
2377  0065 1402          	and	a,(OFST+0,sp)
2378  0067 6b02          	ld	(OFST+0,sp),a
2379                     ; 943     if (((UART1->CR4 & itpos) != (u8)0x00) && enablestatus)
2381  0069 c65237        	ld	a,21047
2382  006c 1501          	bcp	a,(OFST-1,sp)
2383  006e 270a          	jreq	L3411
2385  0070 0d02          	tnz	(OFST+0,sp)
2386  0072 2706          	jreq	L3411
2387                     ; 946       pendingbitstatus = SET;
2389  0074 a601          	ld	a,#1
2390  0076 6b02          	ld	(OFST+0,sp),a
2392  0078 201e          	jra	L7311
2393  007a               L3411:
2394                     ; 951       pendingbitstatus = RESET;
2396  007a 0f02          	clr	(OFST+0,sp)
2397  007c 201a          	jra	L7311
2398  007e               L1411:
2399                     ; 957     enablestatus = (u8)((u8)UART1->CR2 & itmask2);
2401  007e c65235        	ld	a,21045
2402  0081 1402          	and	a,(OFST+0,sp)
2403  0083 6b02          	ld	(OFST+0,sp),a
2404                     ; 959     if (((UART1->SR & itpos) != (u8)0x00) && enablestatus)
2406  0085 c65230        	ld	a,21040
2407  0088 1501          	bcp	a,(OFST-1,sp)
2408  008a 270a          	jreq	L1511
2410  008c 0d02          	tnz	(OFST+0,sp)
2411  008e 2706          	jreq	L1511
2412                     ; 962       pendingbitstatus = SET;
2414  0090 a601          	ld	a,#1
2415  0092 6b02          	ld	(OFST+0,sp),a
2417  0094 2002          	jra	L7311
2418  0096               L1511:
2419                     ; 967       pendingbitstatus = RESET;
2421  0096 0f02          	clr	(OFST+0,sp)
2422  0098               L7311:
2423                     ; 972   return  pendingbitstatus;
2425  0098 7b02          	ld	a,(OFST+0,sp)
2428  009a 5b04          	addw	sp,#4
2429  009c 81            	ret
2465                     ; 1006 void UART1_ClearITPendingBit(UART1_IT_TypeDef UART1_IT)
2465                     ; 1007 {
2466                     .text:	section	.text,new
2467  0000               _UART1_ClearITPendingBit:
2471                     ; 1008   assert_param(IS_UART1_CLEAR_FLAG_OK(UART1_IT));
2473                     ; 1011   if (UART1_IT == UART1_IT_RXNE)
2475  0000 a30255        	cpw	x,#597
2476  0003 2606          	jrne	L3711
2477                     ; 1013     UART1->SR = (u8)~(UART1_SR_RXNE);
2479  0005 35df5230      	mov	21040,#223
2481  0009 2004          	jra	L5711
2482  000b               L3711:
2483                     ; 1018     UART1->CR4 &= (u8)~(UART1_CR4_LBDF);
2485  000b 72195237      	bres	21047,#4
2486  000f               L5711:
2487                     ; 1020 }
2490  000f 81            	ret
2503                     	xref	_CLK_GetClockFreq
2504                     	xdef	_UART1_ClearITPendingBit
2505                     	xdef	_UART1_GetITStatus
2506                     	xdef	_UART1_ClearFlag
2507                     	xdef	_UART1_GetFlagStatus
2508                     	xdef	_UART1_SetPrescaler
2509                     	xdef	_UART1_SetGuardTime
2510                     	xdef	_UART1_SetAddress
2511                     	xdef	_UART1_SendBreak
2512                     	xdef	_UART1_SendData9
2513                     	xdef	_UART1_SendData8
2514                     	xdef	_UART1_ReceiveData9
2515                     	xdef	_UART1_ReceiveData8
2516                     	xdef	_UART1_ReceiverWakeUpCmd
2517                     	xdef	_UART1_WakeUpConfig
2518                     	xdef	_UART1_SmartCardNACKCmd
2519                     	xdef	_UART1_SmartCardCmd
2520                     	xdef	_UART1_LINCmd
2521                     	xdef	_UART1_LINBreakDetectionConfig
2522                     	xdef	_UART1_IrDACmd
2523                     	xdef	_UART1_IrDAConfig
2524                     	xdef	_UART1_HalfDuplexCmd
2525                     	xdef	_UART1_ITConfig
2526                     	xdef	_UART1_Cmd
2527                     	xdef	_UART1_Init
2528                     	xdef	_UART1_DeInit
2529                     	xref.b	c_lreg
2548                     	xref	c_lursh
2549                     	xref	c_lsub
2550                     	xref	c_smul
2551                     	xref	c_ludv
2552                     	xref	c_rtol
2553                     	xref	c_llsh
2554                     	xref	c_ltor
2555                     	end
