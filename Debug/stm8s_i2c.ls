   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 64 void I2C_DeInit(void)
  32                     ; 65 {
  34                     .text:	section	.text,new
  35  0000               _I2C_DeInit:
  39                     ; 66   I2C->CR1 = I2C_CR1_RESET_VALUE;
  41  0000 725f5210      	clr	21008
  42                     ; 67   I2C->CR2 = I2C_CR2_RESET_VALUE;
  44  0004 725f5211      	clr	21009
  45                     ; 68   I2C->FREQR = I2C_FREQR_RESET_VALUE;
  47  0008 725f5212      	clr	21010
  48                     ; 69   I2C->OARL = I2C_OARL_RESET_VALUE;
  50  000c 725f5213      	clr	21011
  51                     ; 70   I2C->OARH = I2C_OARH_RESET_VALUE;
  53  0010 725f5214      	clr	21012
  54                     ; 71   I2C->ITR = I2C_ITR_RESET_VALUE;
  56  0014 725f521a      	clr	21018
  57                     ; 72   I2C->CCRL = I2C_CCRL_RESET_VALUE;
  59  0018 725f521b      	clr	21019
  60                     ; 73   I2C->CCRH = I2C_CCRH_RESET_VALUE;
  62  001c 725f521c      	clr	21020
  63                     ; 74   I2C->TRISER = I2C_TRISER_RESET_VALUE;
  65  0020 3502521d      	mov	21021,#2
  66                     ; 75 }
  69  0024 81            	ret
 236                     .const:	section	.text
 237  0000               L01:
 238  0000 000186a1      	dc.l	100001
 239  0004               L21:
 240  0004 000f4240      	dc.l	1000000
 241                     ; 99 void I2C_Init(u32 OutputClockFrequencyHz, u16 OwnAddress, I2C_DutyCycle_TypeDef DutyCycle, I2C_Ack_TypeDef Ack, I2C_AddMode_TypeDef AddMode, u8 InputClockFrequencyMHz )
 241                     ; 100 {
 242                     .text:	section	.text,new
 243  0000               _I2C_Init:
 245  0000 5209          	subw	sp,#9
 246       00000009      OFST:	set	9
 249                     ; 101   u16 result = 0x0004;
 251  0002 1e08          	ldw	x,(OFST-1,sp)
 252                     ; 102   u16 tmpval = 0;
 254  0004 1e05          	ldw	x,(OFST-4,sp)
 255                     ; 103   u8 tmpccrh = 0;
 257  0006 0f07          	clr	(OFST-2,sp)
 258                     ; 106   assert_param(IS_I2C_ACK_OK(Ack));
 260                     ; 107   assert_param(IS_I2C_ADDMODE_OK(AddMode));
 262                     ; 108   assert_param(IS_I2C_OWN_ADDRESS_OK(OwnAddress));
 264                     ; 109   assert_param(IS_I2C_INPUT_CLOCK_FREQ_OK(InputClockFrequencyMHz));
 266                     ; 110   assert_param(IS_I2C_OUTPUT_CLOCK_FREQ_OK(OutputClockFrequencyHz));
 268                     ; 115   I2C->FREQR &= (u8)(~I2C_FREQR_FREQ);
 270  0008 c65212        	ld	a,21010
 271  000b a4c0          	and	a,#192
 272  000d c75212        	ld	21010,a
 273                     ; 117   I2C->FREQR |= InputClockFrequencyMHz;
 275  0010 c65212        	ld	a,21010
 276  0013 1a15          	or	a,(OFST+12,sp)
 277  0015 c75212        	ld	21010,a
 278                     ; 121   I2C->CR1 &= (u8)(~I2C_CR1_PE);
 280  0018 72115210      	bres	21008,#0
 281                     ; 124   I2C->CCRH &= (u8)(~(I2C_CCRH_FS | I2C_CCRH_DUTY | I2C_CCRH_CCR));
 283  001c c6521c        	ld	a,21020
 284  001f a430          	and	a,#48
 285  0021 c7521c        	ld	21020,a
 286                     ; 125   I2C->CCRL &= (u8)(~I2C_CCRL_CCR);
 288  0024 725f521b      	clr	21019
 289                     ; 128   if (OutputClockFrequencyHz > I2C_MAX_STANDARD_FREQ) /* FAST MODE */
 291  0028 96            	ldw	x,sp
 292  0029 1c000c        	addw	x,#OFST+3
 293  002c cd0000        	call	c_ltor
 295  002f ae0000        	ldw	x,#L01
 296  0032 cd0000        	call	c_lcmp
 298  0035 2403          	jruge	L61
 299  0037 cc00c4        	jp	L511
 300  003a               L61:
 301                     ; 131     tmpccrh = I2C_CCRH_FS;
 303  003a a680          	ld	a,#128
 304  003c 6b07          	ld	(OFST-2,sp),a
 305                     ; 133     if (DutyCycle == I2C_DUTYCYCLE_2)
 307  003e 0d12          	tnz	(OFST+9,sp)
 308  0040 2630          	jrne	L711
 309                     ; 136       result = (u16) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 3));
 311  0042 96            	ldw	x,sp
 312  0043 1c000c        	addw	x,#OFST+3
 313  0046 cd0000        	call	c_ltor
 315  0049 a603          	ld	a,#3
 316  004b cd0000        	call	c_smul
 318  004e 96            	ldw	x,sp
 319  004f 1c0001        	addw	x,#OFST-8
 320  0052 cd0000        	call	c_rtol
 322  0055 7b15          	ld	a,(OFST+12,sp)
 323  0057 b703          	ld	c_lreg+3,a
 324  0059 3f02          	clr	c_lreg+2
 325  005b 3f01          	clr	c_lreg+1
 326  005d 3f00          	clr	c_lreg
 327  005f ae0004        	ldw	x,#L21
 328  0062 cd0000        	call	c_lmul
 330  0065 96            	ldw	x,sp
 331  0066 1c0001        	addw	x,#OFST-8
 332  0069 cd0000        	call	c_ludv
 334  006c be02          	ldw	x,c_lreg+2
 335  006e 1f08          	ldw	(OFST-1,sp),x
 337  0070 2034          	jra	L121
 338  0072               L711:
 339                     ; 141       result = (u16) ((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz * 25));
 341  0072 96            	ldw	x,sp
 342  0073 1c000c        	addw	x,#OFST+3
 343  0076 cd0000        	call	c_ltor
 345  0079 a619          	ld	a,#25
 346  007b cd0000        	call	c_smul
 348  007e 96            	ldw	x,sp
 349  007f 1c0001        	addw	x,#OFST-8
 350  0082 cd0000        	call	c_rtol
 352  0085 7b15          	ld	a,(OFST+12,sp)
 353  0087 b703          	ld	c_lreg+3,a
 354  0089 3f02          	clr	c_lreg+2
 355  008b 3f01          	clr	c_lreg+1
 356  008d 3f00          	clr	c_lreg
 357  008f ae0004        	ldw	x,#L21
 358  0092 cd0000        	call	c_lmul
 360  0095 96            	ldw	x,sp
 361  0096 1c0001        	addw	x,#OFST-8
 362  0099 cd0000        	call	c_ludv
 364  009c be02          	ldw	x,c_lreg+2
 365  009e 1f08          	ldw	(OFST-1,sp),x
 366                     ; 143       tmpccrh |= I2C_CCRH_DUTY;
 368  00a0 7b07          	ld	a,(OFST-2,sp)
 369  00a2 aa40          	or	a,#64
 370  00a4 6b07          	ld	(OFST-2,sp),a
 371  00a6               L121:
 372                     ; 147     if (result < (u16)0x01)
 374  00a6 1e08          	ldw	x,(OFST-1,sp)
 375  00a8 2605          	jrne	L321
 376                     ; 150       result = (u16)0x0001;
 378  00aa ae0001        	ldw	x,#1
 379  00ad 1f08          	ldw	(OFST-1,sp),x
 380  00af               L321:
 381                     ; 156     tmpval = ((InputClockFrequencyMHz * 3) / 10) + 1;
 383  00af 7b15          	ld	a,(OFST+12,sp)
 384  00b1 97            	ld	xl,a
 385  00b2 a603          	ld	a,#3
 386  00b4 42            	mul	x,a
 387  00b5 a60a          	ld	a,#10
 388  00b7 cd0000        	call	c_sdivx
 390  00ba 5c            	incw	x
 391  00bb 1f05          	ldw	(OFST-4,sp),x
 392                     ; 157     I2C->TRISER = (u8)tmpval;
 394  00bd 7b06          	ld	a,(OFST-3,sp)
 395  00bf c7521d        	ld	21021,a
 397  00c2 2043          	jra	L521
 398  00c4               L511:
 399                     ; 164     result = (u16)((InputClockFrequencyMHz * 1000000) / (OutputClockFrequencyHz << (u8)1));
 401  00c4 96            	ldw	x,sp
 402  00c5 1c000c        	addw	x,#OFST+3
 403  00c8 cd0000        	call	c_ltor
 405  00cb 3803          	sll	c_lreg+3
 406  00cd 3902          	rlc	c_lreg+2
 407  00cf 3901          	rlc	c_lreg+1
 408  00d1 3900          	rlc	c_lreg
 409  00d3 96            	ldw	x,sp
 410  00d4 1c0001        	addw	x,#OFST-8
 411  00d7 cd0000        	call	c_rtol
 413  00da 7b15          	ld	a,(OFST+12,sp)
 414  00dc b703          	ld	c_lreg+3,a
 415  00de 3f02          	clr	c_lreg+2
 416  00e0 3f01          	clr	c_lreg+1
 417  00e2 3f00          	clr	c_lreg
 418  00e4 ae0004        	ldw	x,#L21
 419  00e7 cd0000        	call	c_lmul
 421  00ea 96            	ldw	x,sp
 422  00eb 1c0001        	addw	x,#OFST-8
 423  00ee cd0000        	call	c_ludv
 425  00f1 be02          	ldw	x,c_lreg+2
 426  00f3 1f08          	ldw	(OFST-1,sp),x
 427                     ; 167     if (result < (u16)0x0004)
 429  00f5 1e08          	ldw	x,(OFST-1,sp)
 430  00f7 a30004        	cpw	x,#4
 431  00fa 2405          	jruge	L721
 432                     ; 170       result = (u16)0x0004;
 434  00fc ae0004        	ldw	x,#4
 435  00ff 1f08          	ldw	(OFST-1,sp),x
 436  0101               L721:
 437                     ; 176     I2C->TRISER = (u8)(InputClockFrequencyMHz + 1);
 439  0101 7b15          	ld	a,(OFST+12,sp)
 440  0103 4c            	inc	a
 441  0104 c7521d        	ld	21021,a
 442  0107               L521:
 443                     ; 181   I2C->CCRL = (u8)result;
 445  0107 7b09          	ld	a,(OFST+0,sp)
 446  0109 c7521b        	ld	21019,a
 447                     ; 182   I2C->CCRH = (u8)(((u8)(result >> 8) & I2C_CCRH_CCR) | tmpccrh);
 449  010c 7b08          	ld	a,(OFST-1,sp)
 450  010e a40f          	and	a,#15
 451  0110 1a07          	or	a,(OFST-2,sp)
 452  0112 c7521c        	ld	21020,a
 453                     ; 185   I2C->CR1 |= I2C_CR1_PE;
 455  0115 72105210      	bset	21008,#0
 456                     ; 188   I2C_AcknowledgeConfig(Ack);
 458  0119 7b13          	ld	a,(OFST+10,sp)
 459  011b cd0000        	call	_I2C_AcknowledgeConfig
 461                     ; 191   I2C->OARL = (u8)(OwnAddress);
 463  011e 7b11          	ld	a,(OFST+8,sp)
 464  0120 c75213        	ld	21011,a
 465                     ; 192   I2C->OARH = (u8)((u8)AddMode |
 465                     ; 193                    I2C_OARH_ADDCONF |
 465                     ; 194                    (u8)((OwnAddress & (u16)0x0300) >> (u8)7));
 467  0123 7b10          	ld	a,(OFST+7,sp)
 468  0125 97            	ld	xl,a
 469  0126 7b11          	ld	a,(OFST+8,sp)
 470  0128 9f            	ld	a,xl
 471  0129 a403          	and	a,#3
 472  012b 97            	ld	xl,a
 473  012c 4f            	clr	a
 474  012d 02            	rlwa	x,a
 475  012e a607          	ld	a,#7
 476  0130               L41:
 477  0130 54            	srlw	x
 478  0131 4a            	dec	a
 479  0132 26fc          	jrne	L41
 480  0134 9f            	ld	a,xl
 481  0135 6b04          	ld	(OFST-5,sp),a
 482  0137 7b14          	ld	a,(OFST+11,sp)
 483  0139 aa40          	or	a,#64
 484  013b 1a04          	or	a,(OFST-5,sp)
 485  013d c75214        	ld	21012,a
 486                     ; 195 }
 489  0140 5b09          	addw	sp,#9
 490  0142 81            	ret
 545                     ; 212 void I2C_Cmd(FunctionalState NewState)
 545                     ; 213 {
 546                     .text:	section	.text,new
 547  0000               _I2C_Cmd:
 551                     ; 216   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 553                     ; 218   if (NewState != DISABLE)
 555  0000 4d            	tnz	a
 556  0001 2706          	jreq	L751
 557                     ; 221     I2C->CR1 |= I2C_CR1_PE;
 559  0003 72105210      	bset	21008,#0
 561  0007 2004          	jra	L161
 562  0009               L751:
 563                     ; 226     I2C->CR1 &= (u8)(~I2C_CR1_PE);
 565  0009 72115210      	bres	21008,#0
 566  000d               L161:
 567                     ; 228 }
 570  000d 81            	ret
 605                     ; 245 void I2C_GeneralCallCmd(FunctionalState NewState)
 605                     ; 246 {
 606                     .text:	section	.text,new
 607  0000               _I2C_GeneralCallCmd:
 611                     ; 249   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 613                     ; 251   if (NewState != DISABLE)
 615  0000 4d            	tnz	a
 616  0001 2706          	jreq	L102
 617                     ; 254     I2C->CR1 |= I2C_CR1_ENGC;
 619  0003 721c5210      	bset	21008,#6
 621  0007 2004          	jra	L302
 622  0009               L102:
 623                     ; 259     I2C->CR1 &= (u8)(~I2C_CR1_ENGC);
 625  0009 721d5210      	bres	21008,#6
 626  000d               L302:
 627                     ; 261 }
 630  000d 81            	ret
 665                     ; 278 void I2C_GenerateSTART(FunctionalState NewState)
 665                     ; 279 {
 666                     .text:	section	.text,new
 667  0000               _I2C_GenerateSTART:
 671                     ; 282   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 673                     ; 284   if (NewState != DISABLE)
 675  0000 4d            	tnz	a
 676  0001 2706          	jreq	L322
 677                     ; 287     I2C->CR2 |= I2C_CR2_START;
 679  0003 72105211      	bset	21009,#0
 681  0007 2004          	jra	L522
 682  0009               L322:
 683                     ; 292     I2C->CR2 &= (u8)(~I2C_CR2_START);
 685  0009 72115211      	bres	21009,#0
 686  000d               L522:
 687                     ; 295 }
 690  000d 81            	ret
 725                     ; 312 void I2C_GenerateSTOP(FunctionalState NewState)
 725                     ; 313 {
 726                     .text:	section	.text,new
 727  0000               _I2C_GenerateSTOP:
 731                     ; 316   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 733                     ; 318   if (NewState != DISABLE)
 735  0000 4d            	tnz	a
 736  0001 2706          	jreq	L542
 737                     ; 321     I2C->CR2 |= I2C_CR2_STOP;
 739  0003 72125211      	bset	21009,#1
 741  0007 2004          	jra	L742
 742  0009               L542:
 743                     ; 326     I2C->CR2 &= (u8)(~I2C_CR2_STOP);
 745  0009 72135211      	bres	21009,#1
 746  000d               L742:
 747                     ; 329 }
 750  000d 81            	ret
 786                     ; 346 void I2C_SoftwareResetCmd(FunctionalState NewState)
 786                     ; 347 {
 787                     .text:	section	.text,new
 788  0000               _I2C_SoftwareResetCmd:
 792                     ; 349   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 794                     ; 351   if (NewState != DISABLE)
 796  0000 4d            	tnz	a
 797  0001 2706          	jreq	L762
 798                     ; 354     I2C->CR2 |= I2C_CR2_SWRST;
 800  0003 721e5211      	bset	21009,#7
 802  0007 2004          	jra	L172
 803  0009               L762:
 804                     ; 359     I2C->CR2 &= (u8)(~I2C_CR2_SWRST);
 806  0009 721f5211      	bres	21009,#7
 807  000d               L172:
 808                     ; 361 }
 811  000d 81            	ret
 847                     ; 379 void I2C_StretchClockCmd(FunctionalState NewState)
 847                     ; 380 {
 848                     .text:	section	.text,new
 849  0000               _I2C_StretchClockCmd:
 853                     ; 382   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 855                     ; 384   if (NewState != DISABLE)
 857  0000 4d            	tnz	a
 858  0001 2706          	jreq	L113
 859                     ; 387     I2C->CR1 &= (u8)(~I2C_CR1_NOSTRETCH);
 861  0003 721f5210      	bres	21008,#7
 863  0007 2004          	jra	L313
 864  0009               L113:
 865                     ; 393     I2C->CR1 |= I2C_CR1_NOSTRETCH;
 867  0009 721e5210      	bset	21008,#7
 868  000d               L313:
 869                     ; 395 }
 872  000d 81            	ret
 908                     ; 412 void I2C_AcknowledgeConfig(I2C_Ack_TypeDef Ack)
 908                     ; 413 {
 909                     .text:	section	.text,new
 910  0000               _I2C_AcknowledgeConfig:
 912  0000 88            	push	a
 913       00000000      OFST:	set	0
 916                     ; 416   assert_param(IS_I2C_ACK_OK(Ack));
 918                     ; 418   if (Ack == I2C_ACK_NONE)
 920  0001 4d            	tnz	a
 921  0002 2606          	jrne	L333
 922                     ; 421     I2C->CR2 &= (u8)(~I2C_CR2_ACK);
 924  0004 72155211      	bres	21009,#2
 926  0008 2014          	jra	L533
 927  000a               L333:
 928                     ; 426     I2C->CR2 |= I2C_CR2_ACK;
 930  000a 72145211      	bset	21009,#2
 931                     ; 428     if (Ack == I2C_ACK_CURR)
 933  000e 7b01          	ld	a,(OFST+1,sp)
 934  0010 a101          	cp	a,#1
 935  0012 2606          	jrne	L733
 936                     ; 431       I2C->CR2 &= (u8)(~I2C_CR2_POS);
 938  0014 72175211      	bres	21009,#3
 940  0018 2004          	jra	L533
 941  001a               L733:
 942                     ; 436       I2C->CR2 |= I2C_CR2_POS;
 944  001a 72165211      	bset	21009,#3
 945  001e               L533:
 946                     ; 440 }
 949  001e 84            	pop	a
 950  001f 81            	ret
1022                     ; 459 void I2C_ITConfig(I2C_IT_TypeDef ITName, FunctionalState NewState)
1022                     ; 460 {
1023                     .text:	section	.text,new
1024  0000               _I2C_ITConfig:
1026  0000 89            	pushw	x
1027       00000000      OFST:	set	0
1030                     ; 463   assert_param(IS_I2C_INTERRUPT_OK(ITName));
1032                     ; 464   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1034                     ; 466   if (NewState != DISABLE)
1036  0001 9f            	ld	a,xl
1037  0002 4d            	tnz	a
1038  0003 2709          	jreq	L773
1039                     ; 469     I2C->ITR |= (u8)ITName;
1041  0005 9e            	ld	a,xh
1042  0006 ca521a        	or	a,21018
1043  0009 c7521a        	ld	21018,a
1045  000c 2009          	jra	L104
1046  000e               L773:
1047                     ; 474     I2C->ITR &= (u8)(~(u8)ITName);
1049  000e 7b01          	ld	a,(OFST+1,sp)
1050  0010 43            	cpl	a
1051  0011 c4521a        	and	a,21018
1052  0014 c7521a        	ld	21018,a
1053  0017               L104:
1054                     ; 476 }
1057  0017 85            	popw	x
1058  0018 81            	ret
1094                     ; 493 void I2C_FastModeDutyCycleConfig(I2C_DutyCycle_TypeDef DutyCycle)
1094                     ; 494 {
1095                     .text:	section	.text,new
1096  0000               _I2C_FastModeDutyCycleConfig:
1100                     ; 497   assert_param(IS_I2C_DUTYCYCLE_OK(DutyCycle));
1102                     ; 499   if (DutyCycle == I2C_DUTYCYCLE_16_9)
1104  0000 a140          	cp	a,#64
1105  0002 2606          	jrne	L124
1106                     ; 502     I2C->CCRH |= I2C_CCRH_DUTY;
1108  0004 721c521c      	bset	21020,#6
1110  0008 2004          	jra	L324
1111  000a               L124:
1112                     ; 507     I2C->CCRH &= (u8)(~I2C_CCRH_DUTY);
1114  000a 721d521c      	bres	21020,#6
1115  000e               L324:
1116                     ; 510 }
1119  000e 81            	ret
1293                     ; 531 ErrorStatus I2C_CheckEvent(I2C_Event_TypeDef I2C_Event)
1293                     ; 532 {
1294                     .text:	section	.text,new
1295  0000               _I2C_CheckEvent:
1297  0000 89            	pushw	x
1298  0001 89            	pushw	x
1299       00000002      OFST:	set	2
1302                     ; 534   u8 flag1 = 0;
1304  0002 7b01          	ld	a,(OFST-1,sp)
1305  0004 97            	ld	xl,a
1306                     ; 535   u8 flag2 = 0;
1308  0005 7b02          	ld	a,(OFST+0,sp)
1309  0007 97            	ld	xl,a
1310                     ; 536   ErrorStatus status = ERROR;
1312  0008 7b02          	ld	a,(OFST+0,sp)
1313  000a 97            	ld	xl,a
1314                     ; 539   assert_param(IS_I2C_EVENT_OK(I2C_Event));
1316                     ; 541   flag1 = I2C->SR1;
1318  000b c65217        	ld	a,21015
1319  000e 6b01          	ld	(OFST-1,sp),a
1320                     ; 542   flag2 = I2C->SR2;
1322  0010 c65218        	ld	a,21016
1323  0013 6b02          	ld	(OFST+0,sp),a
1324                     ; 545   if (((u16)I2C_Event & (u16)0x0F00) == 0x0700)
1326  0015 7b03          	ld	a,(OFST+1,sp)
1327  0017 97            	ld	xl,a
1328  0018 7b04          	ld	a,(OFST+2,sp)
1329  001a 9f            	ld	a,xl
1330  001b a40f          	and	a,#15
1331  001d 97            	ld	xl,a
1332  001e 4f            	clr	a
1333  001f 02            	rlwa	x,a
1334  0020 a30700        	cpw	x,#1792
1335  0023 2610          	jrne	L515
1336                     ; 548     if (flag1 & (u8)I2C_Event)
1338  0025 7b04          	ld	a,(OFST+2,sp)
1339  0027 1501          	bcp	a,(OFST-1,sp)
1340  0029 2706          	jreq	L715
1341                     ; 551       status = SUCCESS;
1343  002b a601          	ld	a,#1
1344  002d 6b02          	ld	(OFST+0,sp),a
1346  002f 2012          	jra	L325
1347  0031               L715:
1348                     ; 556       status = ERROR;
1350  0031 0f02          	clr	(OFST+0,sp)
1351  0033 200e          	jra	L325
1352  0035               L515:
1353                     ; 561     if (flag2 & (u8)I2C_Event)
1355  0035 7b04          	ld	a,(OFST+2,sp)
1356  0037 1502          	bcp	a,(OFST+0,sp)
1357  0039 2706          	jreq	L525
1358                     ; 564       status = SUCCESS;
1360  003b a601          	ld	a,#1
1361  003d 6b02          	ld	(OFST+0,sp),a
1363  003f 2002          	jra	L325
1364  0041               L525:
1365                     ; 569       status = ERROR;
1367  0041 0f02          	clr	(OFST+0,sp)
1368  0043               L325:
1369                     ; 574   return status;
1371  0043 7b02          	ld	a,(OFST+0,sp)
1374  0045 5b04          	addw	sp,#4
1375  0047 81            	ret
1398                     ; 594 u8 I2C_ReceiveData(void)
1398                     ; 595 {
1399                     .text:	section	.text,new
1400  0000               _I2C_ReceiveData:
1404                     ; 597   return ((u8)I2C->DR);
1406  0000 c65216        	ld	a,21014
1409  0003 81            	ret
1472                     ; 616 void I2C_Send7bitAddress(u8 Address, I2C_Direction_TypeDef Direction)
1472                     ; 617 {
1473                     .text:	section	.text,new
1474  0000               _I2C_Send7bitAddress:
1476  0000 89            	pushw	x
1477       00000000      OFST:	set	0
1480                     ; 619   assert_param(IS_I2C_ADDRESS_OK(Address));
1482                     ; 620   assert_param(IS_I2C_DIRECTION_OK(Direction));
1484                     ; 623   Address &= (u8)0xFE;
1486  0001 7b01          	ld	a,(OFST+1,sp)
1487  0003 a4fe          	and	a,#254
1488  0005 6b01          	ld	(OFST+1,sp),a
1489                     ; 626   I2C->DR = (u8)(Address | (u8)Direction);
1491  0007 7b01          	ld	a,(OFST+1,sp)
1492  0009 1a02          	or	a,(OFST+2,sp)
1493  000b c75216        	ld	21014,a
1494                     ; 627 }
1497  000e 85            	popw	x
1498  000f 81            	ret
1530                     ; 643 void I2C_SendData(u8 Data)
1530                     ; 644 {
1531                     .text:	section	.text,new
1532  0000               _I2C_SendData:
1536                     ; 646   I2C->DR = Data;
1538  0000 c75216        	ld	21014,a
1539                     ; 647 }
1542  0003 81            	ret
1739                     ; 666 FlagStatus I2C_GetFlagStatus(I2C_Flag_TypeDef Flag)
1739                     ; 667 {
1740                     .text:	section	.text,new
1741  0000               _I2C_GetFlagStatus:
1743  0000 89            	pushw	x
1744  0001 88            	push	a
1745       00000001      OFST:	set	1
1748                     ; 669   FlagStatus bitstatus = RESET;
1750  0002 0f01          	clr	(OFST+0,sp)
1751                     ; 672   assert_param(IS_I2C_FLAG_OK(Flag));
1753                     ; 675   switch ((u16)Flag & (u16)0xF000)
1755  0004 01            	rrwa	x,a
1756  0005 9f            	ld	a,xl
1757  0006 a4f0          	and	a,#240
1758  0008 97            	ld	xl,a
1759  0009 4f            	clr	a
1760  000a 02            	rlwa	x,a
1762                     ; 723     default:
1762                     ; 724       break;
1763  000b 1d1000        	subw	x,#4096
1764  000e 270c          	jreq	L506
1765  0010 1d1000        	subw	x,#4096
1766  0013 2718          	jreq	L706
1767  0015 1d1000        	subw	x,#4096
1768  0018 2724          	jreq	L116
1769  001a 2031          	jra	L517
1770  001c               L506:
1771                     ; 679     case 0x1000:
1771                     ; 680       /* Check the status of the specified I2C flag */
1771                     ; 681       if ((I2C->SR1 & (u8)Flag) != 0)
1773  001c c65217        	ld	a,21015
1774  001f 1503          	bcp	a,(OFST+2,sp)
1775  0021 2706          	jreq	L717
1776                     ; 684         bitstatus = SET;
1778  0023 a601          	ld	a,#1
1779  0025 6b01          	ld	(OFST+0,sp),a
1781  0027 2024          	jra	L517
1782  0029               L717:
1783                     ; 689         bitstatus = RESET;
1785  0029 0f01          	clr	(OFST+0,sp)
1786  002b 2020          	jra	L517
1787  002d               L706:
1788                     ; 694     case 0x2000:
1788                     ; 695       /* Check the status of the specified I2C flag */
1788                     ; 696       if ((I2C->SR2 & (u8)Flag) != 0)
1790  002d c65218        	ld	a,21016
1791  0030 1503          	bcp	a,(OFST+2,sp)
1792  0032 2706          	jreq	L327
1793                     ; 699         bitstatus = SET;
1795  0034 a601          	ld	a,#1
1796  0036 6b01          	ld	(OFST+0,sp),a
1798  0038 2013          	jra	L517
1799  003a               L327:
1800                     ; 704         bitstatus = RESET;
1802  003a 0f01          	clr	(OFST+0,sp)
1803  003c 200f          	jra	L517
1804  003e               L116:
1805                     ; 709     case 0x3000:
1805                     ; 710       /* Check the status of the specified I2C flag */
1805                     ; 711       if ((I2C->SR3 & (u8)Flag) != 0)
1807  003e c65219        	ld	a,21017
1808  0041 1503          	bcp	a,(OFST+2,sp)
1809  0043 2706          	jreq	L727
1810                     ; 714         bitstatus = SET;
1812  0045 a601          	ld	a,#1
1813  0047 6b01          	ld	(OFST+0,sp),a
1815  0049 2002          	jra	L517
1816  004b               L727:
1817                     ; 719         bitstatus = RESET;
1819  004b 0f01          	clr	(OFST+0,sp)
1820  004d               L316:
1821                     ; 723     default:
1821                     ; 724       break;
1823  004d               L517:
1824                     ; 729   return bitstatus;
1826  004d 7b01          	ld	a,(OFST+0,sp)
1829  004f 5b03          	addw	sp,#3
1830  0051 81            	ret
1886                     ; 748 void I2C_ClearFlag(I2C_Flag_TypeDef Flag)
1886                     ; 749 {
1887                     .text:	section	.text,new
1888  0000               _I2C_ClearFlag:
1890  0000 89            	pushw	x
1891  0001 5204          	subw	sp,#4
1892       00000004      OFST:	set	4
1895                     ; 750   u8 tmp1 = 0;
1897  0003 7b02          	ld	a,(OFST-2,sp)
1898  0005 97            	ld	xl,a
1899                     ; 751   u8 tmp2 = 0;
1901  0006 7b01          	ld	a,(OFST-3,sp)
1902  0008 97            	ld	xl,a
1903                     ; 752   u16 tmp3 = 0;
1905  0009 1e03          	ldw	x,(OFST-1,sp)
1906                     ; 755   assert_param(IS_I2C_CLEAR_FLAG_OK(Flag));
1908                     ; 758   tmp3 = ((u16)Flag & (u16)0x0F00);
1910  000b 7b05          	ld	a,(OFST+1,sp)
1911  000d 97            	ld	xl,a
1912  000e 7b06          	ld	a,(OFST+2,sp)
1913  0010 9f            	ld	a,xl
1914  0011 a40f          	and	a,#15
1915  0013 97            	ld	xl,a
1916  0014 4f            	clr	a
1917  0015 02            	rlwa	x,a
1918  0016 1f03          	ldw	(OFST-1,sp),x
1919  0018 01            	rrwa	x,a
1920                     ; 761   if(tmp3 == 0x0100)
1922  0019 1e03          	ldw	x,(OFST-1,sp)
1923  001b a30100        	cpw	x,#256
1924  001e 2608          	jrne	L757
1925                     ; 764       I2C->SR2 = (u8)(~(u8)Flag);
1927  0020 7b06          	ld	a,(OFST+2,sp)
1928  0022 43            	cpl	a
1929  0023 c75218        	ld	21016,a
1931  0026 203a          	jra	L167
1932  0028               L757:
1933                     ; 767   else if(tmp3 == 0x0200)
1935  0028 1e03          	ldw	x,(OFST-1,sp)
1936  002a a30200        	cpw	x,#512
1937  002d 260e          	jrne	L367
1938                     ; 770       tmp1 = I2C->SR1;
1940  002f 7b02          	ld	a,(OFST-2,sp)
1941  0031 97            	ld	xl,a
1942  0032 c65217        	ld	a,21015
1943  0035 97            	ld	xl,a
1944                     ; 772       I2C->CR2 = I2C->CR2;
1946  0036 5552115211    	mov	21009,21009
1948  003b 2025          	jra	L167
1949  003d               L367:
1950                     ; 775   else if(tmp3 == 0x0300)
1952  003d 1e03          	ldw	x,(OFST-1,sp)
1953  003f a30300        	cpw	x,#768
1954  0042 2610          	jrne	L767
1955                     ; 779       tmp1 = I2C->SR1;
1957  0044 7b02          	ld	a,(OFST-2,sp)
1958  0046 97            	ld	xl,a
1959  0047 c65217        	ld	a,21015
1960  004a 97            	ld	xl,a
1961                     ; 781       tmp2 = I2C->SR3;
1963  004b 7b01          	ld	a,(OFST-3,sp)
1964  004d 97            	ld	xl,a
1965  004e c65219        	ld	a,21017
1966  0051 97            	ld	xl,a
1968  0052 200e          	jra	L167
1969  0054               L767:
1970                     ; 788       tmp1 = I2C->SR1;
1972  0054 7b02          	ld	a,(OFST-2,sp)
1973  0056 97            	ld	xl,a
1974  0057 c65217        	ld	a,21015
1975  005a 97            	ld	xl,a
1976                     ; 790       tmp2 = I2C->DR;
1978  005b 7b01          	ld	a,(OFST-3,sp)
1979  005d 97            	ld	xl,a
1980  005e c65216        	ld	a,21014
1981  0061 97            	ld	xl,a
1982  0062               L167:
1983                     ; 792 }
1986  0062 5b06          	addw	sp,#6
1987  0064 81            	ret
2135                     ; 811 ITStatus I2C_GetITStatus(I2C_ITPendingBit_TypeDef ITPendingBit)
2135                     ; 812 {
2136                     .text:	section	.text,new
2137  0000               _I2C_GetITStatus:
2139  0000 89            	pushw	x
2140  0001 88            	push	a
2141       00000001      OFST:	set	1
2144                     ; 813     ITStatus itstatus = RESET;
2146  0002 0f01          	clr	(OFST+0,sp)
2147                     ; 816     assert_param(IS_I2C_ITPENDINGBIT_OK(ITPendingBit));
2149                     ; 819     if (((u16)ITPendingBit & 0xF000) == 0x1000) /* Returns whether the status register to check is SR1 */
2151  0004 01            	rrwa	x,a
2152  0005 9f            	ld	a,xl
2153  0006 a4f0          	and	a,#240
2154  0008 97            	ld	xl,a
2155  0009 4f            	clr	a
2156  000a 02            	rlwa	x,a
2157  000b a31000        	cpw	x,#4096
2158  000e 2611          	jrne	L1501
2159                     ; 822         if ((I2C->SR1 & (u8)ITPendingBit) != 0)
2161  0010 c65217        	ld	a,21015
2162  0013 1503          	bcp	a,(OFST+2,sp)
2163  0015 2706          	jreq	L3501
2164                     ; 825             itstatus = SET;
2166  0017 a601          	ld	a,#1
2167  0019 6b01          	ld	(OFST+0,sp),a
2169  001b 2013          	jra	L7501
2170  001d               L3501:
2171                     ; 830             itstatus = RESET;
2173  001d 0f01          	clr	(OFST+0,sp)
2174  001f 200f          	jra	L7501
2175  0021               L1501:
2176                     ; 836         if ((I2C->SR2 & (u8)ITPendingBit) != 0)
2178  0021 c65218        	ld	a,21016
2179  0024 1503          	bcp	a,(OFST+2,sp)
2180  0026 2706          	jreq	L1601
2181                     ; 839             itstatus = SET;
2183  0028 a601          	ld	a,#1
2184  002a 6b01          	ld	(OFST+0,sp),a
2186  002c 2002          	jra	L7501
2187  002e               L1601:
2188                     ; 844             itstatus = RESET;
2190  002e 0f01          	clr	(OFST+0,sp)
2191  0030               L7501:
2192                     ; 849     return itstatus;
2194  0030 7b01          	ld	a,(OFST+0,sp)
2197  0032 5b03          	addw	sp,#3
2198  0034 81            	ret
2255                     ; 868 void I2C_ClearITPendingBit(I2C_ITPendingBit_TypeDef ITPendingBit)
2255                     ; 869 {
2256                     .text:	section	.text,new
2257  0000               _I2C_ClearITPendingBit:
2259  0000 89            	pushw	x
2260  0001 5204          	subw	sp,#4
2261       00000004      OFST:	set	4
2264                     ; 870   u8 tmp1 = 0;
2266  0003 7b02          	ld	a,(OFST-2,sp)
2267  0005 97            	ld	xl,a
2268                     ; 871   u8 tmp2 = 0;
2270  0006 7b01          	ld	a,(OFST-3,sp)
2271  0008 97            	ld	xl,a
2272                     ; 872   u16 tmp3 = 0;
2274  0009 1e03          	ldw	x,(OFST-1,sp)
2275                     ; 875   assert_param(IS_I2C_ITPENDINGBIT_OK(ITPendingBit));
2277                     ; 878   tmp3 = ((u16)ITPendingBit & (u16)0x0F00);
2279  000b 7b05          	ld	a,(OFST+1,sp)
2280  000d 97            	ld	xl,a
2281  000e 7b06          	ld	a,(OFST+2,sp)
2282  0010 9f            	ld	a,xl
2283  0011 a40f          	and	a,#15
2284  0013 97            	ld	xl,a
2285  0014 4f            	clr	a
2286  0015 02            	rlwa	x,a
2287  0016 1f03          	ldw	(OFST-1,sp),x
2288  0018 01            	rrwa	x,a
2289                     ; 881   if(tmp3 == 0x0100)
2291  0019 1e03          	ldw	x,(OFST-1,sp)
2292  001b a30100        	cpw	x,#256
2293  001e 2608          	jrne	L1111
2294                     ; 884       I2C->SR2 = (u8)(~(u8)ITPendingBit);
2296  0020 7b06          	ld	a,(OFST+2,sp)
2297  0022 43            	cpl	a
2298  0023 c75218        	ld	21016,a
2300  0026 203a          	jra	L3111
2301  0028               L1111:
2302                     ; 887   else if(tmp3 == 0x0200)
2304  0028 1e03          	ldw	x,(OFST-1,sp)
2305  002a a30200        	cpw	x,#512
2306  002d 260e          	jrne	L5111
2307                     ; 890       tmp1 = I2C->SR1;
2309  002f 7b02          	ld	a,(OFST-2,sp)
2310  0031 97            	ld	xl,a
2311  0032 c65217        	ld	a,21015
2312  0035 97            	ld	xl,a
2313                     ; 892       I2C->CR2 = I2C->CR2;
2315  0036 5552115211    	mov	21009,21009
2317  003b 2025          	jra	L3111
2318  003d               L5111:
2319                     ; 895   else if(tmp3 == 0x0300)
2321  003d 1e03          	ldw	x,(OFST-1,sp)
2322  003f a30300        	cpw	x,#768
2323  0042 2610          	jrne	L1211
2324                     ; 899       tmp1 = I2C->SR1;
2326  0044 7b02          	ld	a,(OFST-2,sp)
2327  0046 97            	ld	xl,a
2328  0047 c65217        	ld	a,21015
2329  004a 97            	ld	xl,a
2330                     ; 901       tmp2 = I2C->SR3;
2332  004b 7b01          	ld	a,(OFST-3,sp)
2333  004d 97            	ld	xl,a
2334  004e c65219        	ld	a,21017
2335  0051 97            	ld	xl,a
2337  0052 200e          	jra	L3111
2338  0054               L1211:
2339                     ; 908       tmp1 = I2C->SR1;
2341  0054 7b02          	ld	a,(OFST-2,sp)
2342  0056 97            	ld	xl,a
2343  0057 c65217        	ld	a,21015
2344  005a 97            	ld	xl,a
2345                     ; 910       tmp2 = I2C->DR;
2347  005b 7b01          	ld	a,(OFST-3,sp)
2348  005d 97            	ld	xl,a
2349  005e c65216        	ld	a,21014
2350  0061 97            	ld	xl,a
2351  0062               L3111:
2352                     ; 912 }
2355  0062 5b06          	addw	sp,#6
2356  0064 81            	ret
2369                     	xdef	_I2C_ClearITPendingBit
2370                     	xdef	_I2C_GetITStatus
2371                     	xdef	_I2C_ClearFlag
2372                     	xdef	_I2C_GetFlagStatus
2373                     	xdef	_I2C_SendData
2374                     	xdef	_I2C_Send7bitAddress
2375                     	xdef	_I2C_ReceiveData
2376                     	xdef	_I2C_CheckEvent
2377                     	xdef	_I2C_ITConfig
2378                     	xdef	_I2C_FastModeDutyCycleConfig
2379                     	xdef	_I2C_AcknowledgeConfig
2380                     	xdef	_I2C_StretchClockCmd
2381                     	xdef	_I2C_SoftwareResetCmd
2382                     	xdef	_I2C_GenerateSTOP
2383                     	xdef	_I2C_GenerateSTART
2384                     	xdef	_I2C_GeneralCallCmd
2385                     	xdef	_I2C_Cmd
2386                     	xdef	_I2C_Init
2387                     	xdef	_I2C_DeInit
2388                     	xref.b	c_lreg
2407                     	xref	c_sdivx
2408                     	xref	c_ludv
2409                     	xref	c_rtol
2410                     	xref	c_smul
2411                     	xref	c_lmul
2412                     	xref	c_lcmp
2413                     	xref	c_ltor
2414                     	end
