   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  41                     ; 65 void UART2_DeInit(void)
  41                     ; 66 {
  43                     .text:	section	.text,new
  44  0000               _UART2_DeInit:
  46  0000 88            	push	a
  47       00000001      OFST:	set	1
  50                     ; 67   u8 dummy = 0;
  52  0001 0f01          	clr	(OFST+0,sp)
  53                     ; 70   dummy = UART2->SR;
  55  0003 c65240        	ld	a,21056
  56  0006 6b01          	ld	(OFST+0,sp),a
  57                     ; 71   dummy = UART2->DR;
  59  0008 c65241        	ld	a,21057
  60  000b 6b01          	ld	(OFST+0,sp),a
  61                     ; 73   UART2->BRR2 = UART2_BRR2_RESET_VALUE;  /*< Set UART2_BRR2 to reset value 0x00 */
  63  000d 725f5243      	clr	21059
  64                     ; 74   UART2->BRR1 = UART2_BRR1_RESET_VALUE;  /*< Set UART2_BRR1 to reset value 0x00 */
  66  0011 725f5242      	clr	21058
  67                     ; 76   UART2->CR1 = UART2_CR1_RESET_VALUE; /*< Set UART2_CR1 to reset value 0x00  */
  69  0015 725f5244      	clr	21060
  70                     ; 77   UART2->CR2 = UART2_CR2_RESET_VALUE; /*< Set UART2_CR2 to reset value 0x00  */
  72  0019 725f5245      	clr	21061
  73                     ; 78   UART2->CR3 = UART2_CR3_RESET_VALUE;  /*< Set UART2_CR3 to reset value 0x00  */
  75  001d 725f5246      	clr	21062
  76                     ; 79   UART2->CR4 = UART2_CR4_RESET_VALUE;  /*< Set UART2_CR4 to reset value 0x00  */
  78  0021 725f5247      	clr	21063
  79                     ; 80   UART2->CR5 = UART2_CR5_RESET_VALUE; /*< Set UART2_CR5 to reset value 0x00  */
  81  0025 725f5248      	clr	21064
  82                     ; 81 	UART2->CR6 = UART2_CR6_RESET_VALUE; /*< Set UART2_CR6 to reset value 0x00  */
  84  0029 725f5249      	clr	21065
  85                     ; 83 }
  88  002d 84            	pop	a
  89  002e 81            	ret
 407                     .const:	section	.text
 408  0000               L01:
 409  0000 00000064      	dc.l	100
 410                     ; 103 void UART2_Init(u32 BaudRate, UART2_WordLength_TypeDef WordLength, UART2_StopBits_TypeDef StopBits, UART2_Parity_TypeDef Parity, UART2_SyncMode_TypeDef SyncMode, UART2_Mode_TypeDef Mode)
 410                     ; 104 {
 411                     .text:	section	.text,new
 412  0000               _UART2_Init:
 414  0000 5212          	subw	sp,#18
 415       00000012      OFST:	set	18
 418                     ; 105 	u8 BRR2_1, BRR2_2 = 0;
 420  0002 7b0a          	ld	a,(OFST-8,sp)
 421  0004 97            	ld	xl,a
 422                     ; 106 	u32 freq = CLK_GetClockFreq();
 424  0005 cd0000        	call	_CLK_GetClockFreq
 426  0008 96            	ldw	x,sp
 427  0009 1c0005        	addw	x,#OFST-13
 428  000c cd0000        	call	c_rtol
 430                     ; 107 	u32 BaudRate_Mantissa, BaudRate_Mantissa100 = 0;
 432  000f 96            	ldw	x,sp
 433  0010 1c000b        	addw	x,#OFST-7
 434  0013 cd0000        	call	c_ltor
 436                     ; 110   assert_param(IS_UART2_BAUDRATE_OK(BaudRate));
 438                     ; 112   assert_param(IS_UART2_WORDLENGTH_OK(WordLength));
 440                     ; 114   assert_param(IS_UART2_STOPBITS_OK(StopBits));
 442                     ; 116   assert_param(IS_UART2_PARITY_OK(Parity));
 444                     ; 119   assert_param(IS_UART2_MODE_OK((u8)Mode));
 446                     ; 123   assert_param(IS_UART2_SYNCMODE_OK((u8)SyncMode));
 448                     ; 125   UART2->CR1 &= (u8)(~UART2_CR1_M);  /**< Clear the word length bit */
 450  0016 72195244      	bres	21060,#4
 451                     ; 126   UART2->CR1 |= (u8)WordLength; /**< Set the word length bit according to UART2_WordLength value */
 453  001a c65244        	ld	a,21060
 454  001d 1a19          	or	a,(OFST+7,sp)
 455  001f c75244        	ld	21060,a
 456                     ; 128   UART2->CR3 &= (u8)(~UART2_CR3_STOP);  /**< Clear the STOP bits */
 458  0022 c65246        	ld	a,21062
 459  0025 a4cf          	and	a,#207
 460  0027 c75246        	ld	21062,a
 461                     ; 129   UART2->CR3 |= (u8)StopBits;  /**< Set the STOP bits number according to UART2_StopBits value  */
 463  002a c65246        	ld	a,21062
 464  002d 1a1a          	or	a,(OFST+8,sp)
 465  002f c75246        	ld	21062,a
 466                     ; 131   UART2->CR1 &= (u8)(~(UART2_CR1_PCEN | UART2_CR1_PS  ));  /**< Clear the Parity Control bit */
 468  0032 c65244        	ld	a,21060
 469  0035 a4f9          	and	a,#249
 470  0037 c75244        	ld	21060,a
 471                     ; 132   UART2->CR1 |= (u8)Parity;  /**< Set the Parity Control bit to UART2_Parity value */
 473  003a c65244        	ld	a,21060
 474  003d 1a1b          	or	a,(OFST+9,sp)
 475  003f c75244        	ld	21060,a
 476                     ; 134   UART2->BRR1 &= (u8)(~UART2_BRR1_DIVM);  /**< Clear the LSB mantissa of UARTDIV  */
 478  0042 725f5242      	clr	21058
 479                     ; 135   UART2->BRR2 &= (u8)(~UART2_BRR2_DIVM);  /**< Clear the MSB mantissa of UARTDIV  */
 481  0046 c65243        	ld	a,21059
 482  0049 a40f          	and	a,#15
 483  004b c75243        	ld	21059,a
 484                     ; 136   UART2->BRR2 &= (u8)(~UART2_BRR2_DIVF);  /**< Clear the Fraction bits of UARTDIV */
 486  004e c65243        	ld	a,21059
 487  0051 a4f0          	and	a,#240
 488  0053 c75243        	ld	21059,a
 489                     ; 140   BaudRate_Mantissa    = ((u32)CLK_GetClockFreq() / (BaudRate << 4));
 491  0056 96            	ldw	x,sp
 492  0057 1c0015        	addw	x,#OFST+3
 493  005a cd0000        	call	c_ltor
 495  005d a604          	ld	a,#4
 496  005f cd0000        	call	c_llsh
 498  0062 96            	ldw	x,sp
 499  0063 1c0001        	addw	x,#OFST-17
 500  0066 cd0000        	call	c_rtol
 502  0069 cd0000        	call	_CLK_GetClockFreq
 504  006c 96            	ldw	x,sp
 505  006d 1c0001        	addw	x,#OFST-17
 506  0070 cd0000        	call	c_ludv
 508  0073 96            	ldw	x,sp
 509  0074 1c000f        	addw	x,#OFST-3
 510  0077 cd0000        	call	c_rtol
 512                     ; 141   BaudRate_Mantissa100 = (((u32)CLK_GetClockFreq() * 100) / (BaudRate << 4));
 514  007a 96            	ldw	x,sp
 515  007b 1c0015        	addw	x,#OFST+3
 516  007e cd0000        	call	c_ltor
 518  0081 a604          	ld	a,#4
 519  0083 cd0000        	call	c_llsh
 521  0086 96            	ldw	x,sp
 522  0087 1c0001        	addw	x,#OFST-17
 523  008a cd0000        	call	c_rtol
 525  008d cd0000        	call	_CLK_GetClockFreq
 527  0090 a664          	ld	a,#100
 528  0092 cd0000        	call	c_smul
 530  0095 96            	ldw	x,sp
 531  0096 1c0001        	addw	x,#OFST-17
 532  0099 cd0000        	call	c_ludv
 534  009c 96            	ldw	x,sp
 535  009d 1c000b        	addw	x,#OFST-7
 536  00a0 cd0000        	call	c_rtol
 538                     ; 143   BRR2_1 = (u8)((u8)(((BaudRate_Mantissa100 - (BaudRate_Mantissa * 100))
 538                     ; 144                       << 4) / 100) & (u8)0x0F); /**< Set the fraction of UARTDIV  */
 540  00a3 96            	ldw	x,sp
 541  00a4 1c000f        	addw	x,#OFST-3
 542  00a7 cd0000        	call	c_ltor
 544  00aa a664          	ld	a,#100
 545  00ac cd0000        	call	c_smul
 547  00af 96            	ldw	x,sp
 548  00b0 1c0001        	addw	x,#OFST-17
 549  00b3 cd0000        	call	c_rtol
 551  00b6 96            	ldw	x,sp
 552  00b7 1c000b        	addw	x,#OFST-7
 553  00ba cd0000        	call	c_ltor
 555  00bd 96            	ldw	x,sp
 556  00be 1c0001        	addw	x,#OFST-17
 557  00c1 cd0000        	call	c_lsub
 559  00c4 a604          	ld	a,#4
 560  00c6 cd0000        	call	c_llsh
 562  00c9 ae0000        	ldw	x,#L01
 563  00cc cd0000        	call	c_ludv
 565  00cf b603          	ld	a,c_lreg+3
 566  00d1 a40f          	and	a,#15
 567  00d3 6b09          	ld	(OFST-9,sp),a
 568                     ; 145   BRR2_2 = (u8)((BaudRate_Mantissa >> 4) & (u8)0xF0);
 570  00d5 96            	ldw	x,sp
 571  00d6 1c000f        	addw	x,#OFST-3
 572  00d9 cd0000        	call	c_ltor
 574  00dc a604          	ld	a,#4
 575  00de cd0000        	call	c_lursh
 577  00e1 b603          	ld	a,c_lreg+3
 578  00e3 a4f0          	and	a,#240
 579  00e5 b703          	ld	c_lreg+3,a
 580  00e7 3f02          	clr	c_lreg+2
 581  00e9 3f01          	clr	c_lreg+1
 582  00eb 3f00          	clr	c_lreg
 583  00ed b603          	ld	a,c_lreg+3
 584  00ef 6b0a          	ld	(OFST-8,sp),a
 585                     ; 147   UART2->BRR2 = (u8)(BRR2_1 | BRR2_2);
 587  00f1 7b09          	ld	a,(OFST-9,sp)
 588  00f3 1a0a          	or	a,(OFST-8,sp)
 589  00f5 c75243        	ld	21059,a
 590                     ; 148   UART2->BRR1 = (u8)BaudRate_Mantissa;           /**< Set the LSB mantissa of UARTDIV  */
 592  00f8 7b12          	ld	a,(OFST+0,sp)
 593  00fa c75242        	ld	21058,a
 594                     ; 150   UART2->CR2 &= (u8)~(UART2_CR2_TEN | UART2_CR2_REN); /**< Disable the Transmitter and Receiver before seting the LBCL, CPOL and CPHA bits */
 596  00fd c65245        	ld	a,21061
 597  0100 a4f3          	and	a,#243
 598  0102 c75245        	ld	21061,a
 599                     ; 151   UART2->CR3 &= (u8)~(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL); /**< Clear the Clock Polarity, lock Phase, Last Bit Clock pulse */
 601  0105 c65246        	ld	a,21062
 602  0108 a4f8          	and	a,#248
 603  010a c75246        	ld	21062,a
 604                     ; 152   UART2->CR3 |= (u8)((u8)SyncMode & (u8)(UART2_CR3_CPOL | UART2_CR3_CPHA | UART2_CR3_LBCL));  /**< Set the Clock Polarity, lock Phase, Last Bit Clock pulse */
 606  010d 7b1c          	ld	a,(OFST+10,sp)
 607  010f a407          	and	a,#7
 608  0111 ca5246        	or	a,21062
 609  0114 c75246        	ld	21062,a
 610                     ; 154   if ((u8)Mode & (u8)UART2_MODE_TX_ENABLE)
 612  0117 7b1d          	ld	a,(OFST+11,sp)
 613  0119 a504          	bcp	a,#4
 614  011b 2706          	jreq	L771
 615                     ; 156     UART2->CR2 |= (u8)UART2_CR2_TEN;  /**< Set the Transmitter Enable bit */
 617  011d 72165245      	bset	21061,#3
 619  0121 2004          	jra	L102
 620  0123               L771:
 621                     ; 160     UART2->CR2 &= (u8)(~UART2_CR2_TEN);  /**< Clear the Transmitter Disable bit */
 623  0123 72175245      	bres	21061,#3
 624  0127               L102:
 625                     ; 162   if ((u8)Mode & (u8)UART2_MODE_RX_ENABLE)
 627  0127 7b1d          	ld	a,(OFST+11,sp)
 628  0129 a508          	bcp	a,#8
 629  012b 2706          	jreq	L302
 630                     ; 164     UART2->CR2 |= (u8)UART2_CR2_REN;  /**< Set the Receiver Enable bit */
 632  012d 72145245      	bset	21061,#2
 634  0131 2004          	jra	L502
 635  0133               L302:
 636                     ; 168     UART2->CR2 &= (u8)(~UART2_CR2_REN);  /**< Clear the Receiver Disable bit */
 638  0133 72155245      	bres	21061,#2
 639  0137               L502:
 640                     ; 171   if ((u8)SyncMode&(u8)UART2_SYNCMODE_CLOCK_DISABLE)
 642  0137 7b1c          	ld	a,(OFST+10,sp)
 643  0139 a580          	bcp	a,#128
 644  013b 2706          	jreq	L702
 645                     ; 173     UART2->CR3 &= (u8)(~UART2_CR3_CKEN); /**< Clear the Clock Enable bit */
 647  013d 72175246      	bres	21062,#3
 649  0141 200a          	jra	L112
 650  0143               L702:
 651                     ; 178     UART2->CR3 |= (u8)((u8)SyncMode & UART2_CR3_CKEN);
 653  0143 7b1c          	ld	a,(OFST+10,sp)
 654  0145 a408          	and	a,#8
 655  0147 ca5246        	or	a,21062
 656  014a c75246        	ld	21062,a
 657  014d               L112:
 658                     ; 180 }
 661  014d 5b12          	addw	sp,#18
 662  014f 81            	ret
 717                     ; 200 void UART2_Cmd(FunctionalState NewState)
 717                     ; 201 {
 718                     .text:	section	.text,new
 719  0000               _UART2_Cmd:
 723                     ; 203   if (NewState != DISABLE)
 725  0000 4d            	tnz	a
 726  0001 2706          	jreq	L142
 727                     ; 205     UART2->CR1 &= (u8)(~UART2_CR1_UARTD); /**< UART2 Enable */
 729  0003 721b5244      	bres	21060,#5
 731  0007 2004          	jra	L342
 732  0009               L142:
 733                     ; 209     UART2->CR1 |= UART2_CR1_UARTD;  /**< UART2 Disable (for low power consumption) */
 735  0009 721a5244      	bset	21060,#5
 736  000d               L342:
 737                     ; 211 }
 740  000d 81            	ret
 868                     ; 238 void UART2_ITConfig(UART2_IT_TypeDef UART2_IT, FunctionalState NewState)
 868                     ; 239 {
 869                     .text:	section	.text,new
 870  0000               _UART2_ITConfig:
 872  0000 89            	pushw	x
 873  0001 89            	pushw	x
 874       00000002      OFST:	set	2
 877                     ; 240   u8 uartreg, itpos = 0x00;
 879  0002 7b02          	ld	a,(OFST+0,sp)
 880  0004 97            	ld	xl,a
 881                     ; 241   assert_param(IS_UART2_CONFIG_IT_OK(UART2_IT));
 883                     ; 242   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 885                     ; 245   uartreg = (u8)(UART2_IT >> 0x08);
 887  0005 7b03          	ld	a,(OFST+1,sp)
 888  0007 6b01          	ld	(OFST-1,sp),a
 889                     ; 248   itpos = (u8)((u8)1 << (u8)((u8)UART2_IT & (u8)0x0F));
 891  0009 7b04          	ld	a,(OFST+2,sp)
 892  000b a40f          	and	a,#15
 893  000d 5f            	clrw	x
 894  000e 97            	ld	xl,a
 895  000f a601          	ld	a,#1
 896  0011 5d            	tnzw	x
 897  0012 2704          	jreq	L61
 898  0014               L02:
 899  0014 48            	sll	a
 900  0015 5a            	decw	x
 901  0016 26fc          	jrne	L02
 902  0018               L61:
 903  0018 6b02          	ld	(OFST+0,sp),a
 904                     ; 250   if (NewState != DISABLE)
 906  001a 0d07          	tnz	(OFST+5,sp)
 907  001c 273a          	jreq	L123
 908                     ; 253     if (uartreg == 0x01)
 910  001e 7b01          	ld	a,(OFST-1,sp)
 911  0020 a101          	cp	a,#1
 912  0022 260a          	jrne	L323
 913                     ; 255       UART2->CR1 |= itpos;
 915  0024 c65244        	ld	a,21060
 916  0027 1a02          	or	a,(OFST+0,sp)
 917  0029 c75244        	ld	21060,a
 919  002c 2066          	jra	L733
 920  002e               L323:
 921                     ; 257     else if (uartreg == 0x02)
 923  002e 7b01          	ld	a,(OFST-1,sp)
 924  0030 a102          	cp	a,#2
 925  0032 260a          	jrne	L723
 926                     ; 259       UART2->CR2 |= itpos;
 928  0034 c65245        	ld	a,21061
 929  0037 1a02          	or	a,(OFST+0,sp)
 930  0039 c75245        	ld	21061,a
 932  003c 2056          	jra	L733
 933  003e               L723:
 934                     ; 261     else if (uartreg == 0x03)
 936  003e 7b01          	ld	a,(OFST-1,sp)
 937  0040 a103          	cp	a,#3
 938  0042 260a          	jrne	L333
 939                     ; 263       UART2->CR4 |= itpos;
 941  0044 c65247        	ld	a,21063
 942  0047 1a02          	or	a,(OFST+0,sp)
 943  0049 c75247        	ld	21063,a
 945  004c 2046          	jra	L733
 946  004e               L333:
 947                     ; 267       UART2->CR6 |= itpos;
 949  004e c65249        	ld	a,21065
 950  0051 1a02          	or	a,(OFST+0,sp)
 951  0053 c75249        	ld	21065,a
 952  0056 203c          	jra	L733
 953  0058               L123:
 954                     ; 273     if (uartreg == 0x01)
 956  0058 7b01          	ld	a,(OFST-1,sp)
 957  005a a101          	cp	a,#1
 958  005c 260b          	jrne	L143
 959                     ; 275       UART2->CR1 &= (u8)(~itpos);
 961  005e 7b02          	ld	a,(OFST+0,sp)
 962  0060 43            	cpl	a
 963  0061 c45244        	and	a,21060
 964  0064 c75244        	ld	21060,a
 966  0067 202b          	jra	L733
 967  0069               L143:
 968                     ; 277     else if (uartreg == 0x02)
 970  0069 7b01          	ld	a,(OFST-1,sp)
 971  006b a102          	cp	a,#2
 972  006d 260b          	jrne	L543
 973                     ; 279       UART2->CR2 &= (u8)(~itpos);
 975  006f 7b02          	ld	a,(OFST+0,sp)
 976  0071 43            	cpl	a
 977  0072 c45245        	and	a,21061
 978  0075 c75245        	ld	21061,a
 980  0078 201a          	jra	L733
 981  007a               L543:
 982                     ; 281     else if (uartreg == 0x03)
 984  007a 7b01          	ld	a,(OFST-1,sp)
 985  007c a103          	cp	a,#3
 986  007e 260b          	jrne	L153
 987                     ; 283       UART2->CR4 &= (u8)(~itpos);
 989  0080 7b02          	ld	a,(OFST+0,sp)
 990  0082 43            	cpl	a
 991  0083 c45247        	and	a,21063
 992  0086 c75247        	ld	21063,a
 994  0089 2009          	jra	L733
 995  008b               L153:
 996                     ; 287       UART2->CR6 &= (u8)(~itpos);
 998  008b 7b02          	ld	a,(OFST+0,sp)
 999  008d 43            	cpl	a
1000  008e c45249        	and	a,21065
1001  0091 c75249        	ld	21065,a
1002  0094               L733:
1003                     ; 290 }
1006  0094 5b04          	addw	sp,#4
1007  0096 81            	ret
1064                     ; 308 void UART2_IrDAConfig(UART2_IrDAMode_TypeDef UART2_IrDAMode)
1064                     ; 309 {
1065                     .text:	section	.text,new
1066  0000               _UART2_IrDAConfig:
1070                     ; 310   assert_param(IS_UART2_IRDAMODE_OK(UART2_IrDAMode));
1072                     ; 312   if (UART2_IrDAMode != UART2_IRDAMODE_NORMAL)
1074  0000 4d            	tnz	a
1075  0001 2706          	jreq	L304
1076                     ; 314     UART2->CR5 |= UART2_CR5_IRLP;
1078  0003 72145248      	bset	21064,#2
1080  0007 2004          	jra	L504
1081  0009               L304:
1082                     ; 318     UART2->CR5 &= ((u8)~UART2_CR5_IRLP);
1084  0009 72155248      	bres	21064,#2
1085  000d               L504:
1086                     ; 320 }
1089  000d 81            	ret
1124                     ; 339 void UART2_IrDACmd(FunctionalState NewState)
1124                     ; 340 {
1125                     .text:	section	.text,new
1126  0000               _UART2_IrDACmd:
1130                     ; 343   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1132                     ; 345   if (NewState != DISABLE)
1134  0000 4d            	tnz	a
1135  0001 2706          	jreq	L524
1136                     ; 348     UART2->CR5 |= UART2_CR5_IREN;
1138  0003 72125248      	bset	21064,#1
1140  0007 2004          	jra	L724
1141  0009               L524:
1142                     ; 353     UART2->CR5 &= ((u8)~UART2_CR5_IREN);
1144  0009 72135248      	bres	21064,#1
1145  000d               L724:
1146                     ; 355 }
1149  000d 81            	ret
1208                     ; 373 void UART2_LINBreakDetectionConfig(UART2_LINBreakDetectionLength_TypeDef UART2_LINBreakDetectionLength)
1208                     ; 374 {
1209                     .text:	section	.text,new
1210  0000               _UART2_LINBreakDetectionConfig:
1214                     ; 375   assert_param(IS_UART2_LINBREAKDETECTIONLENGTH_OK(UART2_LINBreakDetectionLength));
1216                     ; 377   if (UART2_LINBreakDetectionLength != UART2_LINBREAKDETECTIONLENGTH_10BITS)
1218  0000 4d            	tnz	a
1219  0001 2706          	jreq	L754
1220                     ; 379     UART2->CR4 |= UART2_CR4_LBDL;
1222  0003 721a5247      	bset	21063,#5
1224  0007 2004          	jra	L164
1225  0009               L754:
1226                     ; 383     UART2->CR4 &= ((u8)~UART2_CR4_LBDL);
1228  0009 721b5247      	bres	21063,#5
1229  000d               L164:
1230                     ; 385 }
1233  000d 81            	ret
1354                     ; 407 void UART2_LINConfig(UART2_LinMode_TypeDef UART2_Mode, UART2_LinAutosync_TypeDef UART2_Autosync, UART2_LinDivUp_TypeDef UART2_DivUp)
1354                     ; 408 {
1355                     .text:	section	.text,new
1356  0000               _UART2_LINConfig:
1358  0000 89            	pushw	x
1359       00000000      OFST:	set	0
1362                     ; 409   assert_param(IS_UART2_SLAVE_OK(UART2_Mode));
1364                     ; 411   assert_param(IS_UART2_AUTOSYNC_OK(UART2_Autosync));
1366                     ; 413   assert_param(IS_UART2_DIVUP_OK(UART2_DivUp));
1368                     ; 415   if (UART2_Mode != UART2_LIN_MODE_MASTER)
1370  0001 9e            	ld	a,xh
1371  0002 4d            	tnz	a
1372  0003 2706          	jreq	L145
1373                     ; 417     UART2->CR6 |=  UART2_CR6_LSLV;
1375  0005 721a5249      	bset	21065,#5
1377  0009 2004          	jra	L345
1378  000b               L145:
1379                     ; 421     UART2->CR6 &= ((u8)~UART2_CR6_LSLV);
1381  000b 721b5249      	bres	21065,#5
1382  000f               L345:
1383                     ; 424   if (UART2_Autosync != UART2_LIN_AUTOSYNC_DISABLE)
1385  000f 0d02          	tnz	(OFST+2,sp)
1386  0011 2706          	jreq	L545
1387                     ; 426     UART2->CR6 |=  UART2_CR6_LASE ;
1389  0013 72185249      	bset	21065,#4
1391  0017 2004          	jra	L745
1392  0019               L545:
1393                     ; 430     UART2->CR6 &= ((u8)~ UART2_CR6_LASE );
1395  0019 72195249      	bres	21065,#4
1396  001d               L745:
1397                     ; 433   if (UART2_DivUp != UART2_LIN_DIVUP_LBRR1)
1399  001d 0d05          	tnz	(OFST+5,sp)
1400  001f 2706          	jreq	L155
1401                     ; 435     UART2->CR6 |=  UART2_CR6_LDUM;
1403  0021 721e5249      	bset	21065,#7
1405  0025 2004          	jra	L355
1406  0027               L155:
1407                     ; 439     UART2->CR6 &= ((u8)~ UART2_CR6_LDUM);
1409  0027 721f5249      	bres	21065,#7
1410  002b               L355:
1411                     ; 442 }
1414  002b 85            	popw	x
1415  002c 81            	ret
1450                     ; 462 void UART2_LINCmd(FunctionalState NewState)
1450                     ; 463 {
1451                     .text:	section	.text,new
1452  0000               _UART2_LINCmd:
1456                     ; 464   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1458                     ; 466   if (NewState != DISABLE)
1460  0000 4d            	tnz	a
1461  0001 2706          	jreq	L375
1462                     ; 469     UART2->CR3 |= UART2_CR3_LINEN;
1464  0003 721c5246      	bset	21062,#6
1466  0007 2004          	jra	L575
1467  0009               L375:
1468                     ; 474     UART2->CR3 &= ((u8)~UART2_CR3_LINEN);
1470  0009 721d5246      	bres	21062,#6
1471  000d               L575:
1472                     ; 476 }
1475  000d 81            	ret
1510                     ; 495 void UART2_SmartCardCmd(FunctionalState NewState)
1510                     ; 496 {
1511                     .text:	section	.text,new
1512  0000               _UART2_SmartCardCmd:
1516                     ; 497   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1518                     ; 499   if (NewState != DISABLE)
1520  0000 4d            	tnz	a
1521  0001 2706          	jreq	L516
1522                     ; 502     UART2->CR5 |= UART2_CR5_SCEN;
1524  0003 721a5248      	bset	21064,#5
1526  0007 2004          	jra	L716
1527  0009               L516:
1528                     ; 507     UART2->CR5 &= ((u8)(~UART2_CR5_SCEN));
1530  0009 721b5248      	bres	21064,#5
1531  000d               L716:
1532                     ; 509 }
1535  000d 81            	ret
1571                     ; 529 void UART2_SmartCardNACKCmd(FunctionalState NewState)
1571                     ; 530 {
1572                     .text:	section	.text,new
1573  0000               _UART2_SmartCardNACKCmd:
1577                     ; 531   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1579                     ; 533   if (NewState != DISABLE)
1581  0000 4d            	tnz	a
1582  0001 2706          	jreq	L736
1583                     ; 536     UART2->CR5 |= UART2_CR5_NACK;
1585  0003 72185248      	bset	21064,#4
1587  0007 2004          	jra	L146
1588  0009               L736:
1589                     ; 541     UART2->CR5 &= ((u8)~(UART2_CR5_NACK));
1591  0009 72195248      	bres	21064,#4
1592  000d               L146:
1593                     ; 543 }
1596  000d 81            	ret
1653                     ; 561 void UART2_WakeUpConfig(UART2_WakeUp_TypeDef UART2_WakeUp)
1653                     ; 562 {
1654                     .text:	section	.text,new
1655  0000               _UART2_WakeUpConfig:
1659                     ; 563   assert_param(IS_UART2_WAKEUP_OK(UART2_WakeUp));
1661                     ; 565   UART2->CR1 &= ((u8)~UART2_CR1_WAKE);
1663  0000 72175244      	bres	21060,#3
1664                     ; 566   UART2->CR1 |= (u8)UART2_WakeUp;
1666  0004 ca5244        	or	a,21060
1667  0007 c75244        	ld	21060,a
1668                     ; 567 }
1671  000a 81            	ret
1707                     ; 587 void UART2_ReceiverWakeUpCmd(FunctionalState NewState)
1707                     ; 588 {
1708                     .text:	section	.text,new
1709  0000               _UART2_ReceiverWakeUpCmd:
1713                     ; 589   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1715                     ; 591   if (NewState != DISABLE)
1717  0000 4d            	tnz	a
1718  0001 2706          	jreq	L707
1719                     ; 594     UART2->CR2 |= UART2_CR2_RWU;
1721  0003 72125245      	bset	21061,#1
1723  0007 2004          	jra	L117
1724  0009               L707:
1725                     ; 599     UART2->CR2 &= ((u8)~UART2_CR2_RWU);
1727  0009 72135245      	bres	21061,#1
1728  000d               L117:
1729                     ; 601 }
1732  000d 81            	ret
1755                     ; 619 u8 UART2_ReceiveData8(void)
1755                     ; 620 {
1756                     .text:	section	.text,new
1757  0000               _UART2_ReceiveData8:
1761                     ; 621   return ((u8)UART2->DR);
1763  0000 c65241        	ld	a,21057
1766  0003 81            	ret
1789                     ; 639 u16 UART2_ReceiveData9(void)
1789                     ; 640 {
1790                     .text:	section	.text,new
1791  0000               _UART2_ReceiveData9:
1793  0000 89            	pushw	x
1794       00000002      OFST:	set	2
1797                     ; 641   return (u16)((((u16)UART2->DR) | ((u16)(((u16)((u16)UART2->CR1 & (u16)UART2_CR1_R8)) << 1))) & ((u16)0x01FF));
1799  0001 c65244        	ld	a,21060
1800  0004 5f            	clrw	x
1801  0005 a480          	and	a,#128
1802  0007 5f            	clrw	x
1803  0008 02            	rlwa	x,a
1804  0009 58            	sllw	x
1805  000a 1f01          	ldw	(OFST-1,sp),x
1806  000c c65241        	ld	a,21057
1807  000f 5f            	clrw	x
1808  0010 97            	ld	xl,a
1809  0011 01            	rrwa	x,a
1810  0012 1a02          	or	a,(OFST+0,sp)
1811  0014 01            	rrwa	x,a
1812  0015 1a01          	or	a,(OFST-1,sp)
1813  0017 01            	rrwa	x,a
1814  0018 01            	rrwa	x,a
1815  0019 a4ff          	and	a,#255
1816  001b 01            	rrwa	x,a
1817  001c a401          	and	a,#1
1818  001e 01            	rrwa	x,a
1821  001f 5b02          	addw	sp,#2
1822  0021 81            	ret
1854                     ; 663 void UART2_SendData8(u8 Data)
1854                     ; 664 {
1855                     .text:	section	.text,new
1856  0000               _UART2_SendData8:
1860                     ; 666   UART2->DR = Data;
1862  0000 c75241        	ld	21057,a
1863                     ; 667 }
1866  0003 81            	ret
1898                     ; 686 void UART2_SendData9(u16 Data)
1898                     ; 687 {
1899                     .text:	section	.text,new
1900  0000               _UART2_SendData9:
1902  0000 89            	pushw	x
1903       00000000      OFST:	set	0
1906                     ; 688   UART2->CR1 &= ((u8)~UART2_CR1_T8);                  /**< Clear the transmit data bit 8     */
1908  0001 721d5244      	bres	21060,#6
1909                     ; 689   UART2->CR1 |= (u8)(((u8)(Data >> 2)) & UART2_CR1_T8); /**< Write the transmit data bit [8]   */
1911  0005 54            	srlw	x
1912  0006 54            	srlw	x
1913  0007 9f            	ld	a,xl
1914  0008 a440          	and	a,#64
1915  000a ca5244        	or	a,21060
1916  000d c75244        	ld	21060,a
1917                     ; 690   UART2->DR   = (u8)(Data);                    /**< Write the transmit data bit [0:7] */
1919  0010 7b02          	ld	a,(OFST+2,sp)
1920  0012 c75241        	ld	21057,a
1921                     ; 692 }
1924  0015 85            	popw	x
1925  0016 81            	ret
1948                     ; 707 void UART2_SendBreak(void)
1948                     ; 708 {
1949                     .text:	section	.text,new
1950  0000               _UART2_SendBreak:
1954                     ; 709   UART2->CR2 |= UART2_CR2_SBK;
1956  0000 72105245      	bset	21061,#0
1957                     ; 710 }
1960  0004 81            	ret
1992                     ; 729 void UART2_SetAddress(u8 UART2_Address)
1992                     ; 730 {
1993                     .text:	section	.text,new
1994  0000               _UART2_SetAddress:
1996  0000 88            	push	a
1997       00000000      OFST:	set	0
2000                     ; 732  assert_param(IS_UART2_ADDRESS_OK(UART2_Address));
2002                     ; 735   UART2->CR4 &= ((u8)~UART2_CR4_ADD);
2004  0001 c65247        	ld	a,21063
2005  0004 a4f0          	and	a,#240
2006  0006 c75247        	ld	21063,a
2007                     ; 737   UART2->CR4 |= UART2_Address;
2009  0009 c65247        	ld	a,21063
2010  000c 1a01          	or	a,(OFST+1,sp)
2011  000e c75247        	ld	21063,a
2012                     ; 738 }
2015  0011 84            	pop	a
2016  0012 81            	ret
2048                     ; 756 void UART2_SetGuardTime(u8 UART2_GuardTime)
2048                     ; 757 {
2049                     .text:	section	.text,new
2050  0000               _UART2_SetGuardTime:
2054                     ; 759   UART2->GTR = UART2_GuardTime;
2056  0000 c7524a        	ld	21066,a
2057                     ; 760 }
2060  0003 81            	ret
2092                     ; 794 void UART2_SetPrescaler(u8 UART2_Prescaler)
2092                     ; 795 {
2093                     .text:	section	.text,new
2094  0000               _UART2_SetPrescaler:
2098                     ; 797   UART2->PSCR = UART2_Prescaler;
2100  0000 c7524b        	ld	21067,a
2101                     ; 798 }
2104  0003 81            	ret
2261                     ; 819 FlagStatus UART2_GetFlagStatus(UART2_Flag_TypeDef UART2_FLAG)
2261                     ; 820 {
2262                     .text:	section	.text,new
2263  0000               _UART2_GetFlagStatus:
2265  0000 89            	pushw	x
2266  0001 88            	push	a
2267       00000001      OFST:	set	1
2270                     ; 821   FlagStatus status = RESET;
2272  0002 0f01          	clr	(OFST+0,sp)
2273                     ; 824   assert_param(IS_UART2_FLAG_OK(UART2_FLAG));
2275                     ; 827   if (UART2_FLAG == UART2_FLAG_LBDF)
2277  0004 a30210        	cpw	x,#528
2278  0007 2610          	jrne	L5211
2279                     ; 829     if ((UART2->CR4 & (u8)UART2_FLAG) != (u8)0x00)
2281  0009 9f            	ld	a,xl
2282  000a c45247        	and	a,21063
2283  000d 2706          	jreq	L7211
2284                     ; 832       status = SET;
2286  000f a601          	ld	a,#1
2287  0011 6b01          	ld	(OFST+0,sp),a
2289  0013 2039          	jra	L3311
2290  0015               L7211:
2291                     ; 837       status = RESET;
2293  0015 0f01          	clr	(OFST+0,sp)
2294  0017 2035          	jra	L3311
2295  0019               L5211:
2296                     ; 840   else if (UART2_FLAG == UART2_FLAG_SBK)
2298  0019 1e02          	ldw	x,(OFST+1,sp)
2299  001b a30101        	cpw	x,#257
2300  001e 2611          	jrne	L5311
2301                     ; 842     if ((UART2->CR2 & (u8)UART2_FLAG) != (u8)0x00)
2303  0020 c65245        	ld	a,21061
2304  0023 1503          	bcp	a,(OFST+2,sp)
2305  0025 2706          	jreq	L7311
2306                     ; 845       status = SET;
2308  0027 a601          	ld	a,#1
2309  0029 6b01          	ld	(OFST+0,sp),a
2311  002b 2021          	jra	L3311
2312  002d               L7311:
2313                     ; 850       status = RESET;
2315  002d 0f01          	clr	(OFST+0,sp)
2316  002f 201d          	jra	L3311
2317  0031               L5311:
2318                     ; 853   else if ((UART2_FLAG == UART2_FLAG_LHDF) || (UART2_FLAG == UART2_FLAG_LSF))
2320  0031 1e02          	ldw	x,(OFST+1,sp)
2321  0033 a30302        	cpw	x,#770
2322  0036 2707          	jreq	L7411
2324  0038 1e02          	ldw	x,(OFST+1,sp)
2325  003a a30301        	cpw	x,#769
2326  003d 2614          	jrne	L5411
2327  003f               L7411:
2328                     ; 855     if ((UART2->CR6 & (u8)UART2_FLAG) != (u8)0x00)
2330  003f c65249        	ld	a,21065
2331  0042 1503          	bcp	a,(OFST+2,sp)
2332  0044 2706          	jreq	L1511
2333                     ; 858       status = SET;
2335  0046 a601          	ld	a,#1
2336  0048 6b01          	ld	(OFST+0,sp),a
2338  004a 2002          	jra	L3311
2339  004c               L1511:
2340                     ; 863       status = RESET;
2342  004c 0f01          	clr	(OFST+0,sp)
2343  004e               L3311:
2344                     ; 881   return  status;
2346  004e 7b01          	ld	a,(OFST+0,sp)
2349  0050 5b03          	addw	sp,#3
2350  0052 81            	ret
2351  0053               L5411:
2352                     ; 868     if ((UART2->SR & (u8)UART2_FLAG) != (u8)0x00)
2354  0053 c65240        	ld	a,21056
2355  0056 1503          	bcp	a,(OFST+2,sp)
2356  0058 2706          	jreq	L7511
2357                     ; 871       status = SET;
2359  005a a601          	ld	a,#1
2360  005c 6b01          	ld	(OFST+0,sp),a
2362  005e 20ee          	jra	L3311
2363  0060               L7511:
2364                     ; 876       status = RESET;
2366  0060 0f01          	clr	(OFST+0,sp)
2367  0062 20ea          	jra	L3311
2402                     ; 918 void UART2_ClearFlag(UART2_Flag_TypeDef UART2_FLAG)
2402                     ; 919 {
2403                     .text:	section	.text,new
2404  0000               _UART2_ClearFlag:
2406  0000 89            	pushw	x
2407       00000000      OFST:	set	0
2410                     ; 920   assert_param(IS_UART2_CLEAR_FLAG_OK(UART2_FLAG));
2412                     ; 923   if (UART2_FLAG == UART2_FLAG_RXNE)
2414  0001 a30020        	cpw	x,#32
2415  0004 2606          	jrne	L1021
2416                     ; 925     UART2->SR = (u8)~(UART2_SR_RXNE);
2418  0006 35df5240      	mov	21056,#223
2420  000a 201e          	jra	L3021
2421  000c               L1021:
2422                     ; 928   else if (UART2_FLAG == UART2_FLAG_LBDF)
2424  000c 1e01          	ldw	x,(OFST+1,sp)
2425  000e a30210        	cpw	x,#528
2426  0011 2606          	jrne	L5021
2427                     ; 930     UART2->CR4 &= (u8)(~UART2_CR4_LBDF);
2429  0013 72195247      	bres	21063,#4
2431  0017 2011          	jra	L3021
2432  0019               L5021:
2433                     ; 933   else if (UART2_FLAG == UART2_FLAG_LHDF)
2435  0019 1e01          	ldw	x,(OFST+1,sp)
2436  001b a30302        	cpw	x,#770
2437  001e 2606          	jrne	L1121
2438                     ; 935     UART2->CR6 &= (u8)(~UART2_CR6_LHDF);
2440  0020 72135249      	bres	21065,#1
2442  0024 2004          	jra	L3021
2443  0026               L1121:
2444                     ; 940     UART2->CR6 &= (u8)(~UART2_CR6_LSF);
2446  0026 72115249      	bres	21065,#0
2447  002a               L3021:
2448                     ; 943 }
2451  002a 85            	popw	x
2452  002b 81            	ret
2526                     ; 970 ITStatus UART2_GetITStatus(UART2_IT_TypeDef UART2_IT)
2526                     ; 971 {
2527                     .text:	section	.text,new
2528  0000               _UART2_GetITStatus:
2530  0000 89            	pushw	x
2531  0001 89            	pushw	x
2532       00000002      OFST:	set	2
2535                     ; 972   ITStatus pendingbitstatus = RESET;
2537  0002 7b02          	ld	a,(OFST+0,sp)
2538  0004 97            	ld	xl,a
2539                     ; 973   u8 itpos = 0;
2541  0005 7b01          	ld	a,(OFST-1,sp)
2542  0007 97            	ld	xl,a
2543                     ; 974   u8 itmask1 = 0;
2545  0008 7b02          	ld	a,(OFST+0,sp)
2546  000a 97            	ld	xl,a
2547                     ; 975   u8 itmask2 = 0;
2549  000b 7b02          	ld	a,(OFST+0,sp)
2550  000d 97            	ld	xl,a
2551                     ; 976   u8 enablestatus = 0;
2553  000e 7b02          	ld	a,(OFST+0,sp)
2554  0010 97            	ld	xl,a
2555                     ; 979   assert_param(IS_UART2_GET_IT_OK(UART2_IT));
2557                     ; 982   itpos = (u8)((u8)1 << (u8)((u8)UART2_IT & (u8)0x0F));
2559  0011 7b04          	ld	a,(OFST+2,sp)
2560  0013 a40f          	and	a,#15
2561  0015 5f            	clrw	x
2562  0016 97            	ld	xl,a
2563  0017 a601          	ld	a,#1
2564  0019 5d            	tnzw	x
2565  001a 2704          	jreq	L27
2566  001c               L47:
2567  001c 48            	sll	a
2568  001d 5a            	decw	x
2569  001e 26fc          	jrne	L47
2570  0020               L27:
2571  0020 6b01          	ld	(OFST-1,sp),a
2572                     ; 984   itmask1 = (u8)((u8)UART2_IT >> (u8)4);
2574  0022 7b04          	ld	a,(OFST+2,sp)
2575  0024 4e            	swap	a
2576  0025 a40f          	and	a,#15
2577  0027 6b02          	ld	(OFST+0,sp),a
2578                     ; 986   itmask2 = (u8)((u8)1 << itmask1);
2580  0029 7b02          	ld	a,(OFST+0,sp)
2581  002b 5f            	clrw	x
2582  002c 97            	ld	xl,a
2583  002d a601          	ld	a,#1
2584  002f 5d            	tnzw	x
2585  0030 2704          	jreq	L67
2586  0032               L001:
2587  0032 48            	sll	a
2588  0033 5a            	decw	x
2589  0034 26fc          	jrne	L001
2590  0036               L67:
2591  0036 6b02          	ld	(OFST+0,sp),a
2592                     ; 991   if (UART2_IT == UART2_IT_PE)
2594  0038 1e03          	ldw	x,(OFST+1,sp)
2595  003a a30100        	cpw	x,#256
2596  003d 261c          	jrne	L7421
2597                     ; 994     enablestatus = (u8)((u8)UART2->CR1 & itmask2);
2599  003f c65244        	ld	a,21060
2600  0042 1402          	and	a,(OFST+0,sp)
2601  0044 6b02          	ld	(OFST+0,sp),a
2602                     ; 997     if (((UART2->SR & itpos) != (u8)0x00) && enablestatus)
2604  0046 c65240        	ld	a,21056
2605  0049 1501          	bcp	a,(OFST-1,sp)
2606  004b 270a          	jreq	L1521
2608  004d 0d02          	tnz	(OFST+0,sp)
2609  004f 2706          	jreq	L1521
2610                     ; 1000       pendingbitstatus = SET;
2612  0051 a601          	ld	a,#1
2613  0053 6b02          	ld	(OFST+0,sp),a
2615  0055 2064          	jra	L5521
2616  0057               L1521:
2617                     ; 1005       pendingbitstatus = RESET;
2619  0057 0f02          	clr	(OFST+0,sp)
2620  0059 2060          	jra	L5521
2621  005b               L7421:
2622                     ; 1009   else if (UART2_IT == UART2_IT_LBDF)
2624  005b 1e03          	ldw	x,(OFST+1,sp)
2625  005d a30346        	cpw	x,#838
2626  0060 261c          	jrne	L7521
2627                     ; 1012     enablestatus = (u8)((u8)UART2->CR4 & itmask2);
2629  0062 c65247        	ld	a,21063
2630  0065 1402          	and	a,(OFST+0,sp)
2631  0067 6b02          	ld	(OFST+0,sp),a
2632                     ; 1014     if (((UART2->CR4 & itpos) != (u8)0x00) && enablestatus)
2634  0069 c65247        	ld	a,21063
2635  006c 1501          	bcp	a,(OFST-1,sp)
2636  006e 270a          	jreq	L1621
2638  0070 0d02          	tnz	(OFST+0,sp)
2639  0072 2706          	jreq	L1621
2640                     ; 1017       pendingbitstatus = SET;
2642  0074 a601          	ld	a,#1
2643  0076 6b02          	ld	(OFST+0,sp),a
2645  0078 2041          	jra	L5521
2646  007a               L1621:
2647                     ; 1022       pendingbitstatus = RESET;
2649  007a 0f02          	clr	(OFST+0,sp)
2650  007c 203d          	jra	L5521
2651  007e               L7521:
2652                     ; 1025   else if (UART2_IT == UART2_IT_LHDF)
2654  007e 1e03          	ldw	x,(OFST+1,sp)
2655  0080 a30412        	cpw	x,#1042
2656  0083 261c          	jrne	L7621
2657                     ; 1028     enablestatus = (u8)((u8)UART2->CR6 & itmask2);
2659  0085 c65249        	ld	a,21065
2660  0088 1402          	and	a,(OFST+0,sp)
2661  008a 6b02          	ld	(OFST+0,sp),a
2662                     ; 1030     if (((UART2->CR6 & itpos) != (u8)0x00) && enablestatus)
2664  008c c65249        	ld	a,21065
2665  008f 1501          	bcp	a,(OFST-1,sp)
2666  0091 270a          	jreq	L1721
2668  0093 0d02          	tnz	(OFST+0,sp)
2669  0095 2706          	jreq	L1721
2670                     ; 1033       pendingbitstatus = SET;
2672  0097 a601          	ld	a,#1
2673  0099 6b02          	ld	(OFST+0,sp),a
2675  009b 201e          	jra	L5521
2676  009d               L1721:
2677                     ; 1038       pendingbitstatus = RESET;
2679  009d 0f02          	clr	(OFST+0,sp)
2680  009f 201a          	jra	L5521
2681  00a1               L7621:
2682                     ; 1044     enablestatus = (u8)((u8)UART2->CR2 & itmask2);
2684  00a1 c65245        	ld	a,21061
2685  00a4 1402          	and	a,(OFST+0,sp)
2686  00a6 6b02          	ld	(OFST+0,sp),a
2687                     ; 1046     if (((UART2->SR & itpos) != (u8)0x00) && enablestatus)
2689  00a8 c65240        	ld	a,21056
2690  00ab 1501          	bcp	a,(OFST-1,sp)
2691  00ad 270a          	jreq	L7721
2693  00af 0d02          	tnz	(OFST+0,sp)
2694  00b1 2706          	jreq	L7721
2695                     ; 1049       pendingbitstatus = SET;
2697  00b3 a601          	ld	a,#1
2698  00b5 6b02          	ld	(OFST+0,sp),a
2700  00b7 2002          	jra	L5521
2701  00b9               L7721:
2702                     ; 1054       pendingbitstatus = RESET;
2704  00b9 0f02          	clr	(OFST+0,sp)
2705  00bb               L5521:
2706                     ; 1058   return  pendingbitstatus;
2708  00bb 7b02          	ld	a,(OFST+0,sp)
2711  00bd 5b04          	addw	sp,#4
2712  00bf 81            	ret
2755                     ; 1094 void UART2_ClearITPendingBit(UART2_IT_TypeDef UART2_IT)
2755                     ; 1095 {
2756                     .text:	section	.text,new
2757  0000               _UART2_ClearITPendingBit:
2759  0000 89            	pushw	x
2760  0001 88            	push	a
2761       00000001      OFST:	set	1
2764                     ; 1096   u8 dummy = 0;
2766  0002 0f01          	clr	(OFST+0,sp)
2767                     ; 1097   assert_param(IS_UART2_CLEAR_IT_OK(UART2_IT));
2769                     ; 1100   if (UART2_IT == UART2_IT_RXNE)
2771  0004 a30255        	cpw	x,#597
2772  0007 2606          	jrne	L3231
2773                     ; 1102     UART2->SR = (u8)~(UART2_SR_RXNE);
2775  0009 35df5240      	mov	21056,#223
2777  000d 2011          	jra	L5231
2778  000f               L3231:
2779                     ; 1105   else if (UART2_IT == UART2_IT_LBDF)
2781  000f 1e02          	ldw	x,(OFST+1,sp)
2782  0011 a30346        	cpw	x,#838
2783  0014 2606          	jrne	L7231
2784                     ; 1107     UART2->CR4 &= (u8)~(UART2_CR4_LBDF);
2786  0016 72195247      	bres	21063,#4
2788  001a 2004          	jra	L5231
2789  001c               L7231:
2790                     ; 1112     UART2->CR6 &= (u8)(~UART2_CR6_LHDF);
2792  001c 72135249      	bres	21065,#1
2793  0020               L5231:
2794                     ; 1114 }
2797  0020 5b03          	addw	sp,#3
2798  0022 81            	ret
2811                     	xref	_CLK_GetClockFreq
2812                     	xdef	_UART2_ClearITPendingBit
2813                     	xdef	_UART2_GetITStatus
2814                     	xdef	_UART2_ClearFlag
2815                     	xdef	_UART2_GetFlagStatus
2816                     	xdef	_UART2_SetPrescaler
2817                     	xdef	_UART2_SetGuardTime
2818                     	xdef	_UART2_SetAddress
2819                     	xdef	_UART2_SendBreak
2820                     	xdef	_UART2_SendData9
2821                     	xdef	_UART2_SendData8
2822                     	xdef	_UART2_ReceiveData9
2823                     	xdef	_UART2_ReceiveData8
2824                     	xdef	_UART2_ReceiverWakeUpCmd
2825                     	xdef	_UART2_WakeUpConfig
2826                     	xdef	_UART2_SmartCardNACKCmd
2827                     	xdef	_UART2_SmartCardCmd
2828                     	xdef	_UART2_LINCmd
2829                     	xdef	_UART2_LINConfig
2830                     	xdef	_UART2_LINBreakDetectionConfig
2831                     	xdef	_UART2_IrDACmd
2832                     	xdef	_UART2_IrDAConfig
2833                     	xdef	_UART2_ITConfig
2834                     	xdef	_UART2_Cmd
2835                     	xdef	_UART2_Init
2836                     	xdef	_UART2_DeInit
2837                     	xref.b	c_lreg
2856                     	xref	c_lursh
2857                     	xref	c_lsub
2858                     	xref	c_smul
2859                     	xref	c_ludv
2860                     	xref	c_llsh
2861                     	xref	c_ltor
2862                     	xref	c_rtol
2863                     	end
