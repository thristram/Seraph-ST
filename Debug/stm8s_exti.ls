   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 63 void EXTI_DeInit(void)
  32                     ; 64 {
  34                     .text:	section	.text,new
  35  0000               _EXTI_DeInit:
  39                     ; 65   EXTI->CR1 = EXTI_CR1_RESET_VALUE;
  41  0000 725f50a0      	clr	20640
  42                     ; 66   EXTI->CR2 = EXTI_CR2_RESET_VALUE;
  44  0004 725f50a1      	clr	20641
  45                     ; 67 }
  48  0008 81            	ret
 173                     ; 86 void EXTI_SetExtIntSensitivity(EXTI_Port_TypeDef Port, EXTI_Sensitivity_TypeDef SensitivityValue)
 173                     ; 87 {
 174                     .text:	section	.text,new
 175  0000               _EXTI_SetExtIntSensitivity:
 177  0000 89            	pushw	x
 178       00000000      OFST:	set	0
 181                     ; 90   assert_param(IS_EXTI_PORT_OK(Port));
 183                     ; 91   assert_param(IS_EXTI_SENSITIVITY_OK(SensitivityValue));
 185                     ; 94   switch (Port)
 187  0001 9e            	ld	a,xh
 189                     ; 116     default:
 189                     ; 117       break;
 190  0002 4d            	tnz	a
 191  0003 270e          	jreq	L12
 192  0005 4a            	dec	a
 193  0006 271d          	jreq	L32
 194  0008 4a            	dec	a
 195  0009 272e          	jreq	L52
 196  000b 4a            	dec	a
 197  000c 2742          	jreq	L72
 198  000e 4a            	dec	a
 199  000f 2756          	jreq	L13
 200  0011 2064          	jra	L311
 201  0013               L12:
 202                     ; 96     case EXTI_PORT_GPIOA:
 202                     ; 97       EXTI->CR1 &= (u8)(~EXTI_CR1_PAIS);
 204  0013 c650a0        	ld	a,20640
 205  0016 a4fc          	and	a,#252
 206  0018 c750a0        	ld	20640,a
 207                     ; 98       EXTI->CR1 |= (u8)(SensitivityValue);
 209  001b c650a0        	ld	a,20640
 210  001e 1a02          	or	a,(OFST+2,sp)
 211  0020 c750a0        	ld	20640,a
 212                     ; 99       break;
 214  0023 2052          	jra	L311
 215  0025               L32:
 216                     ; 100     case EXTI_PORT_GPIOB:
 216                     ; 101       EXTI->CR1 &= (u8)(~EXTI_CR1_PBIS);
 218  0025 c650a0        	ld	a,20640
 219  0028 a4f3          	and	a,#243
 220  002a c750a0        	ld	20640,a
 221                     ; 102       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 2);
 223  002d 7b02          	ld	a,(OFST+2,sp)
 224  002f 48            	sll	a
 225  0030 48            	sll	a
 226  0031 ca50a0        	or	a,20640
 227  0034 c750a0        	ld	20640,a
 228                     ; 103       break;
 230  0037 203e          	jra	L311
 231  0039               L52:
 232                     ; 104     case EXTI_PORT_GPIOC:
 232                     ; 105       EXTI->CR1 &= (u8)(~EXTI_CR1_PCIS);
 234  0039 c650a0        	ld	a,20640
 235  003c a4cf          	and	a,#207
 236  003e c750a0        	ld	20640,a
 237                     ; 106       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 4);
 239  0041 7b02          	ld	a,(OFST+2,sp)
 240  0043 97            	ld	xl,a
 241  0044 a610          	ld	a,#16
 242  0046 42            	mul	x,a
 243  0047 9f            	ld	a,xl
 244  0048 ca50a0        	or	a,20640
 245  004b c750a0        	ld	20640,a
 246                     ; 107       break;
 248  004e 2027          	jra	L311
 249  0050               L72:
 250                     ; 108     case EXTI_PORT_GPIOD:
 250                     ; 109       EXTI->CR1 &= (u8)(~EXTI_CR1_PDIS);
 252  0050 c650a0        	ld	a,20640
 253  0053 a43f          	and	a,#63
 254  0055 c750a0        	ld	20640,a
 255                     ; 110       EXTI->CR1 |= (u8)((u8)(SensitivityValue) << 6);
 257  0058 7b02          	ld	a,(OFST+2,sp)
 258  005a 97            	ld	xl,a
 259  005b a640          	ld	a,#64
 260  005d 42            	mul	x,a
 261  005e 9f            	ld	a,xl
 262  005f ca50a0        	or	a,20640
 263  0062 c750a0        	ld	20640,a
 264                     ; 111       break;
 266  0065 2010          	jra	L311
 267  0067               L13:
 268                     ; 112     case EXTI_PORT_GPIOE:
 268                     ; 113       EXTI->CR2 &= (u8)(~EXTI_CR2_PEIS);
 270  0067 c650a1        	ld	a,20641
 271  006a a4fc          	and	a,#252
 272  006c c750a1        	ld	20641,a
 273                     ; 114       EXTI->CR2 |= (u8)(SensitivityValue);
 275  006f c650a1        	ld	a,20641
 276  0072 1a02          	or	a,(OFST+2,sp)
 277  0074 c750a1        	ld	20641,a
 278                     ; 115       break;
 280  0077               L33:
 281                     ; 116     default:
 281                     ; 117       break;
 283  0077               L311:
 284                     ; 119 }
 287  0077 85            	popw	x
 288  0078 81            	ret
 346                     ; 134 void EXTI_SetTLISensitivity(EXTI_TLISensitivity_TypeDef SensitivityValue)
 346                     ; 135 {
 347                     .text:	section	.text,new
 348  0000               _EXTI_SetTLISensitivity:
 352                     ; 138   assert_param(IS_EXTI_TLISENSITIVITY_OK(SensitivityValue));
 354                     ; 141   EXTI->CR2 &= (u8)(~EXTI_CR2_TLIS);
 356  0000 721550a1      	bres	20641,#2
 357                     ; 142   EXTI->CR2 |= (u8)(SensitivityValue);
 359  0004 ca50a1        	or	a,20641
 360  0007 c750a1        	ld	20641,a
 361                     ; 144 }
 364  000a 81            	ret
 408                     ; 161 EXTI_Sensitivity_TypeDef EXTI_GetExtIntSensitivity(EXTI_Port_TypeDef Port)
 408                     ; 162 {
 409                     .text:	section	.text,new
 410  0000               _EXTI_GetExtIntSensitivity:
 412  0000 88            	push	a
 413       00000001      OFST:	set	1
 416                     ; 164   u8 value = 0;
 418  0001 0f01          	clr	(OFST+0,sp)
 419                     ; 167   assert_param(IS_EXTI_PORT_OK(Port));
 421                     ; 169   switch (Port)
 424                     ; 186     default:
 424                     ; 187       break;
 425  0003 4d            	tnz	a
 426  0004 270e          	jreq	L341
 427  0006 4a            	dec	a
 428  0007 2714          	jreq	L541
 429  0009 4a            	dec	a
 430  000a 271c          	jreq	L741
 431  000c 4a            	dec	a
 432  000d 2725          	jreq	L151
 433  000f 4a            	dec	a
 434  0010 2730          	jreq	L351
 435  0012 2035          	jra	L102
 436  0014               L341:
 437                     ; 171     case EXTI_PORT_GPIOA:
 437                     ; 172       value = (u8)(EXTI->CR1 & EXTI_CR1_PAIS);
 439  0014 c650a0        	ld	a,20640
 440  0017 a403          	and	a,#3
 441  0019 6b01          	ld	(OFST+0,sp),a
 442                     ; 173       break;
 444  001b 202c          	jra	L102
 445  001d               L541:
 446                     ; 174     case EXTI_PORT_GPIOB:
 446                     ; 175       value = (u8)((EXTI->CR1 & EXTI_CR1_PBIS) >> 2);
 448  001d c650a0        	ld	a,20640
 449  0020 a40c          	and	a,#12
 450  0022 44            	srl	a
 451  0023 44            	srl	a
 452  0024 6b01          	ld	(OFST+0,sp),a
 453                     ; 176       break;
 455  0026 2021          	jra	L102
 456  0028               L741:
 457                     ; 177     case EXTI_PORT_GPIOC:
 457                     ; 178       value = (u8)((EXTI->CR1 & EXTI_CR1_PCIS) >> 4);
 459  0028 c650a0        	ld	a,20640
 460  002b a430          	and	a,#48
 461  002d 4e            	swap	a
 462  002e a40f          	and	a,#15
 463  0030 6b01          	ld	(OFST+0,sp),a
 464                     ; 179       break;
 466  0032 2015          	jra	L102
 467  0034               L151:
 468                     ; 180     case EXTI_PORT_GPIOD:
 468                     ; 181       value = (u8)((EXTI->CR1 & EXTI_CR1_PDIS) >> 6);
 470  0034 c650a0        	ld	a,20640
 471  0037 a4c0          	and	a,#192
 472  0039 4e            	swap	a
 473  003a 44            	srl	a
 474  003b 44            	srl	a
 475  003c a403          	and	a,#3
 476  003e 6b01          	ld	(OFST+0,sp),a
 477                     ; 182       break;
 479  0040 2007          	jra	L102
 480  0042               L351:
 481                     ; 183     case EXTI_PORT_GPIOE:
 481                     ; 184       value = (u8)(EXTI->CR2 & EXTI_CR2_PEIS);
 483  0042 c650a1        	ld	a,20641
 484  0045 a403          	and	a,#3
 485  0047 6b01          	ld	(OFST+0,sp),a
 486                     ; 185       break;
 488  0049               L551:
 489                     ; 186     default:
 489                     ; 187       break;
 491  0049               L102:
 492                     ; 190   return((EXTI_Sensitivity_TypeDef)value);
 494  0049 7b01          	ld	a,(OFST+0,sp)
 497  004b 5b01          	addw	sp,#1
 498  004d 81            	ret
 532                     ; 210 EXTI_TLISensitivity_TypeDef EXTI_GetTLISensitivity(void)
 532                     ; 211 {
 533                     .text:	section	.text,new
 534  0000               _EXTI_GetTLISensitivity:
 536  0000 88            	push	a
 537       00000001      OFST:	set	1
 540                     ; 216   value = (u8)(EXTI->CR2 & EXTI_CR2_TLIS);
 542  0001 c650a1        	ld	a,20641
 543  0004 a404          	and	a,#4
 544  0006 6b01          	ld	(OFST+0,sp),a
 545                     ; 218   return((EXTI_TLISensitivity_TypeDef)value);
 547  0008 7b01          	ld	a,(OFST+0,sp)
 550  000a 5b01          	addw	sp,#1
 551  000c 81            	ret
 564                     	xdef	_EXTI_GetTLISensitivity
 565                     	xdef	_EXTI_GetExtIntSensitivity
 566                     	xdef	_EXTI_SetTLISensitivity
 567                     	xdef	_EXTI_SetExtIntSensitivity
 568                     	xdef	_EXTI_DeInit
 587                     	end
