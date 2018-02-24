   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 63 void TIM2_DeInit(void)
  32                     ; 64 {
  34                     .text:	section	.text,new
  35  0000               _TIM2_DeInit:
  39                     ; 66   TIM2->CR1 = (u8)TIM2_CR1_RESET_VALUE;
  41  0000 725f5300      	clr	21248
  42                     ; 67   TIM2->IER = (u8)TIM2_IER_RESET_VALUE;
  44  0004 725f5301      	clr	21249
  45                     ; 68   TIM2->SR2 = (u8)TIM2_SR2_RESET_VALUE;
  47  0008 725f5303      	clr	21251
  48                     ; 71   TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
  50  000c 725f5308      	clr	21256
  51                     ; 72   TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;
  53  0010 725f5309      	clr	21257
  54                     ; 76   TIM2->CCER1 = (u8)TIM2_CCER1_RESET_VALUE;
  56  0014 725f5308      	clr	21256
  57                     ; 77   TIM2->CCER2 = (u8)TIM2_CCER2_RESET_VALUE;
  59  0018 725f5309      	clr	21257
  60                     ; 78   TIM2->CCMR1 = (u8)TIM2_CCMR1_RESET_VALUE;
  62  001c 725f5305      	clr	21253
  63                     ; 79   TIM2->CCMR2 = (u8)TIM2_CCMR2_RESET_VALUE;
  65  0020 725f5306      	clr	21254
  66                     ; 80   TIM2->CCMR3 = (u8)TIM2_CCMR3_RESET_VALUE;
  68  0024 725f5307      	clr	21255
  69                     ; 81   TIM2->CNTRH = (u8)TIM2_CNTRH_RESET_VALUE;
  71  0028 725f530a      	clr	21258
  72                     ; 82   TIM2->CNTRL = (u8)TIM2_CNTRL_RESET_VALUE;
  74  002c 725f530b      	clr	21259
  75                     ; 83   TIM2->PSCR = (u8)TIM2_PSCR_RESET_VALUE;
  77  0030 725f530c      	clr	21260
  78                     ; 84   TIM2->ARRH  = (u8)TIM2_ARRH_RESET_VALUE;
  80  0034 35ff530d      	mov	21261,#255
  81                     ; 85   TIM2->ARRL  = (u8)TIM2_ARRL_RESET_VALUE;
  83  0038 35ff530e      	mov	21262,#255
  84                     ; 86   TIM2->CCR1H = (u8)TIM2_CCR1H_RESET_VALUE;
  86  003c 725f530f      	clr	21263
  87                     ; 87   TIM2->CCR1L = (u8)TIM2_CCR1L_RESET_VALUE;
  89  0040 725f5310      	clr	21264
  90                     ; 88   TIM2->CCR2H = (u8)TIM2_CCR2H_RESET_VALUE;
  92  0044 725f5311      	clr	21265
  93                     ; 89   TIM2->CCR2L = (u8)TIM2_CCR2L_RESET_VALUE;
  95  0048 725f5312      	clr	21266
  96                     ; 90   TIM2->CCR3H = (u8)TIM2_CCR3H_RESET_VALUE;
  98  004c 725f5313      	clr	21267
  99                     ; 91   TIM2->CCR3L = (u8)TIM2_CCR3L_RESET_VALUE;
 101  0050 725f5314      	clr	21268
 102                     ; 92   TIM2->SR1 = (u8)TIM2_SR1_RESET_VALUE;
 104  0054 725f5302      	clr	21250
 105                     ; 93 }
 108  0058 81            	ret
 274                     ; 113 void TIM2_TimeBaseInit( TIM2_Prescaler_TypeDef TIM2_Prescaler,
 274                     ; 114                         u16 TIM2_Period)
 274                     ; 115 {
 275                     .text:	section	.text,new
 276  0000               _TIM2_TimeBaseInit:
 278  0000 88            	push	a
 279       00000000      OFST:	set	0
 282                     ; 117   TIM2->PSCR = (u8)(TIM2_Prescaler);
 284  0001 c7530c        	ld	21260,a
 285                     ; 119   TIM2->ARRH = (u8)(TIM2_Period >> 8);
 287  0004 7b04          	ld	a,(OFST+4,sp)
 288  0006 c7530d        	ld	21261,a
 289                     ; 120   TIM2->ARRL = (u8)(TIM2_Period);
 291  0009 7b05          	ld	a,(OFST+5,sp)
 292  000b c7530e        	ld	21262,a
 293                     ; 121 }
 296  000e 84            	pop	a
 297  000f 81            	ret
 452                     ; 145 void TIM2_OC1Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 452                     ; 146                   TIM2_OutputState_TypeDef TIM2_OutputState,
 452                     ; 147                   u16 TIM2_Pulse,
 452                     ; 148                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 452                     ; 149 {
 453                     .text:	section	.text,new
 454  0000               _TIM2_OC1Init:
 456  0000 89            	pushw	x
 457  0001 88            	push	a
 458       00000001      OFST:	set	1
 461                     ; 151   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 463                     ; 152   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 465                     ; 153   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 467                     ; 156   TIM2->CCER1 &= (u8)(~( TIM2_CCER1_CC1E | TIM2_CCER1_CC1P));
 469  0002 c65308        	ld	a,21256
 470  0005 a4fc          	and	a,#252
 471  0007 c75308        	ld	21256,a
 472                     ; 158   TIM2->CCER1 |= (u8)((TIM2_OutputState  & TIM2_CCER1_CC1E   ) | (TIM2_OCPolarity   & TIM2_CCER1_CC1P   ));
 474  000a 7b08          	ld	a,(OFST+7,sp)
 475  000c a402          	and	a,#2
 476  000e 6b01          	ld	(OFST+0,sp),a
 477  0010 9f            	ld	a,xl
 478  0011 a401          	and	a,#1
 479  0013 1a01          	or	a,(OFST+0,sp)
 480  0015 ca5308        	or	a,21256
 481  0018 c75308        	ld	21256,a
 482                     ; 161   TIM2->CCMR1 = (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
 484  001b c65305        	ld	a,21253
 485  001e a48f          	and	a,#143
 486  0020 1a02          	or	a,(OFST+1,sp)
 487  0022 c75305        	ld	21253,a
 488                     ; 164   TIM2->CCR1H = (u8)(TIM2_Pulse >> 8);
 490  0025 7b06          	ld	a,(OFST+5,sp)
 491  0027 c7530f        	ld	21263,a
 492                     ; 165   TIM2->CCR1L = (u8)(TIM2_Pulse);
 494  002a 7b07          	ld	a,(OFST+6,sp)
 495  002c c75310        	ld	21264,a
 496                     ; 166 }
 499  002f 5b03          	addw	sp,#3
 500  0031 81            	ret
 562                     ; 190 void TIM2_OC2Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 562                     ; 191                   TIM2_OutputState_TypeDef TIM2_OutputState,
 562                     ; 192                   u16 TIM2_Pulse,
 562                     ; 193                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 562                     ; 194 {
 563                     .text:	section	.text,new
 564  0000               _TIM2_OC2Init:
 566  0000 89            	pushw	x
 567  0001 88            	push	a
 568       00000001      OFST:	set	1
 571                     ; 196   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 573                     ; 197   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 575                     ; 198   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 577                     ; 202   TIM2->CCER1 &= (u8)(~( TIM2_CCER1_CC2E |  TIM2_CCER1_CC2P ));
 579  0002 c65308        	ld	a,21256
 580  0005 a4cf          	and	a,#207
 581  0007 c75308        	ld	21256,a
 582                     ; 204   TIM2->CCER1 |= (u8)((TIM2_OutputState  & TIM2_CCER1_CC2E   ) | \
 582                     ; 205                       (TIM2_OCPolarity   & TIM2_CCER1_CC2P   ));
 584  000a 7b08          	ld	a,(OFST+7,sp)
 585  000c a420          	and	a,#32
 586  000e 6b01          	ld	(OFST+0,sp),a
 587  0010 9f            	ld	a,xl
 588  0011 a410          	and	a,#16
 589  0013 1a01          	or	a,(OFST+0,sp)
 590  0015 ca5308        	or	a,21256
 591  0018 c75308        	ld	21256,a
 592                     ; 209   TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
 594  001b c65306        	ld	a,21254
 595  001e a48f          	and	a,#143
 596  0020 1a02          	or	a,(OFST+1,sp)
 597  0022 c75306        	ld	21254,a
 598                     ; 213   TIM2->CCR2H = (u8)(TIM2_Pulse >> 8);
 600  0025 7b06          	ld	a,(OFST+5,sp)
 601  0027 c75311        	ld	21265,a
 602                     ; 214   TIM2->CCR2L = (u8)(TIM2_Pulse);
 604  002a 7b07          	ld	a,(OFST+6,sp)
 605  002c c75312        	ld	21266,a
 606                     ; 215 }
 609  002f 5b03          	addw	sp,#3
 610  0031 81            	ret
 672                     ; 239 void TIM2_OC3Init(TIM2_OCMode_TypeDef TIM2_OCMode,
 672                     ; 240                   TIM2_OutputState_TypeDef TIM2_OutputState,
 672                     ; 241                   u16 TIM2_Pulse,
 672                     ; 242                   TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
 672                     ; 243 {
 673                     .text:	section	.text,new
 674  0000               _TIM2_OC3Init:
 676  0000 89            	pushw	x
 677  0001 88            	push	a
 678       00000001      OFST:	set	1
 681                     ; 245   assert_param(IS_TIM2_OC_MODE_OK(TIM2_OCMode));
 683                     ; 246   assert_param(IS_TIM2_OUTPUT_STATE_OK(TIM2_OutputState));
 685                     ; 247   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
 687                     ; 249   TIM2->CCER2 &= (u8)(~( TIM2_CCER2_CC3E  | TIM2_CCER2_CC3P));
 689  0002 c65309        	ld	a,21257
 690  0005 a4fc          	and	a,#252
 691  0007 c75309        	ld	21257,a
 692                     ; 251   TIM2->CCER2 |= (u8)((TIM2_OutputState  & TIM2_CCER2_CC3E   ) |  (TIM2_OCPolarity   & TIM2_CCER2_CC3P   ));
 694  000a 7b08          	ld	a,(OFST+7,sp)
 695  000c a402          	and	a,#2
 696  000e 6b01          	ld	(OFST+0,sp),a
 697  0010 9f            	ld	a,xl
 698  0011 a401          	and	a,#1
 699  0013 1a01          	or	a,(OFST+0,sp)
 700  0015 ca5309        	or	a,21257
 701  0018 c75309        	ld	21257,a
 702                     ; 254   TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
 704  001b c65307        	ld	a,21255
 705  001e a48f          	and	a,#143
 706  0020 1a02          	or	a,(OFST+1,sp)
 707  0022 c75307        	ld	21255,a
 708                     ; 257   TIM2->CCR3H = (u8)(TIM2_Pulse >> 8);
 710  0025 7b06          	ld	a,(OFST+5,sp)
 711  0027 c75313        	ld	21267,a
 712                     ; 258   TIM2->CCR3L = (u8)(TIM2_Pulse);
 714  002a 7b07          	ld	a,(OFST+6,sp)
 715  002c c75314        	ld	21268,a
 716                     ; 260 }
 719  002f 5b03          	addw	sp,#3
 720  0031 81            	ret
 911                     ; 291 void TIM2_ICInit(TIM2_Channel_TypeDef TIM2_Channel,
 911                     ; 292                  TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
 911                     ; 293                  TIM2_ICSelection_TypeDef TIM2_ICSelection,
 911                     ; 294                  TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
 911                     ; 295                  u8 TIM2_ICFilter)
 911                     ; 296 {
 912                     .text:	section	.text,new
 913  0000               _TIM2_ICInit:
 915  0000 89            	pushw	x
 916       00000000      OFST:	set	0
 919                     ; 298   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
 921                     ; 299   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
 923                     ; 300   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
 925                     ; 301   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
 927                     ; 302   assert_param(IS_TIM2_IC_FILTER_OK(TIM2_ICFilter));
 929                     ; 304   if (TIM2_Channel == TIM2_CHANNEL_1)
 931  0001 9e            	ld	a,xh
 932  0002 4d            	tnz	a
 933  0003 2614          	jrne	L763
 934                     ; 307     TI1_Config(TIM2_ICPolarity,
 934                     ; 308                TIM2_ICSelection,
 934                     ; 309                TIM2_ICFilter);
 936  0005 7b07          	ld	a,(OFST+7,sp)
 937  0007 88            	push	a
 938  0008 7b06          	ld	a,(OFST+6,sp)
 939  000a 97            	ld	xl,a
 940  000b 7b03          	ld	a,(OFST+3,sp)
 941  000d 95            	ld	xh,a
 942  000e cd0000        	call	L3_TI1_Config
 944  0011 84            	pop	a
 945                     ; 312     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
 947  0012 7b06          	ld	a,(OFST+6,sp)
 948  0014 cd0000        	call	_TIM2_SetIC1Prescaler
 951  0017 202c          	jra	L173
 952  0019               L763:
 953                     ; 314   else if (TIM2_Channel == TIM2_CHANNEL_2)
 955  0019 7b01          	ld	a,(OFST+1,sp)
 956  001b a101          	cp	a,#1
 957  001d 2614          	jrne	L373
 958                     ; 317     TI2_Config(TIM2_ICPolarity,
 958                     ; 318                TIM2_ICSelection,
 958                     ; 319                TIM2_ICFilter);
 960  001f 7b07          	ld	a,(OFST+7,sp)
 961  0021 88            	push	a
 962  0022 7b06          	ld	a,(OFST+6,sp)
 963  0024 97            	ld	xl,a
 964  0025 7b03          	ld	a,(OFST+3,sp)
 965  0027 95            	ld	xh,a
 966  0028 cd0000        	call	L5_TI2_Config
 968  002b 84            	pop	a
 969                     ; 322     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
 971  002c 7b06          	ld	a,(OFST+6,sp)
 972  002e cd0000        	call	_TIM2_SetIC2Prescaler
 975  0031 2012          	jra	L173
 976  0033               L373:
 977                     ; 327     TI3_Config(TIM2_ICPolarity,
 977                     ; 328                TIM2_ICSelection,
 977                     ; 329                TIM2_ICFilter);
 979  0033 7b07          	ld	a,(OFST+7,sp)
 980  0035 88            	push	a
 981  0036 7b06          	ld	a,(OFST+6,sp)
 982  0038 97            	ld	xl,a
 983  0039 7b03          	ld	a,(OFST+3,sp)
 984  003b 95            	ld	xh,a
 985  003c cd0000        	call	L7_TI3_Config
 987  003f 84            	pop	a
 988                     ; 332     TIM2_SetIC3Prescaler(TIM2_ICPrescaler);
 990  0040 7b06          	ld	a,(OFST+6,sp)
 991  0042 cd0000        	call	_TIM2_SetIC3Prescaler
 993  0045               L173:
 994                     ; 334 }
 997  0045 85            	popw	x
 998  0046 81            	ret
1088                     ; 363 void TIM2_PWMIConfig(TIM2_Channel_TypeDef TIM2_Channel,
1088                     ; 364                      TIM2_ICPolarity_TypeDef TIM2_ICPolarity,
1088                     ; 365                      TIM2_ICSelection_TypeDef TIM2_ICSelection,
1088                     ; 366                      TIM2_ICPSC_TypeDef TIM2_ICPrescaler,
1088                     ; 367                      u8 TIM2_ICFilter)
1088                     ; 368 {
1089                     .text:	section	.text,new
1090  0000               _TIM2_PWMIConfig:
1092  0000 89            	pushw	x
1093  0001 89            	pushw	x
1094       00000002      OFST:	set	2
1097                     ; 369   u8 icpolarity = (u8)TIM2_ICPOLARITY_RISING;
1099  0002 7b01          	ld	a,(OFST-1,sp)
1100  0004 97            	ld	xl,a
1101                     ; 370   u8 icselection = (u8)TIM2_ICSELECTION_DIRECTTI;
1103  0005 7b02          	ld	a,(OFST+0,sp)
1104  0007 97            	ld	xl,a
1105                     ; 373   assert_param(IS_TIM2_PWMI_CHANNEL_OK(TIM2_Channel));
1107                     ; 374   assert_param(IS_TIM2_IC_POLARITY_OK(TIM2_ICPolarity));
1109                     ; 375   assert_param(IS_TIM2_IC_SELECTION_OK(TIM2_ICSelection));
1111                     ; 376   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_ICPrescaler));
1113                     ; 379   if (TIM2_ICPolarity != TIM2_ICPOLARITY_FALLING)
1115  0008 7b04          	ld	a,(OFST+2,sp)
1116  000a a144          	cp	a,#68
1117  000c 2706          	jreq	L734
1118                     ; 381     icpolarity = (u8)TIM2_ICPOLARITY_FALLING;
1120  000e a644          	ld	a,#68
1121  0010 6b01          	ld	(OFST-1,sp),a
1123  0012 2002          	jra	L144
1124  0014               L734:
1125                     ; 385     icpolarity = (u8)TIM2_ICPOLARITY_RISING;
1127  0014 0f01          	clr	(OFST-1,sp)
1128  0016               L144:
1129                     ; 389   if (TIM2_ICSelection == TIM2_ICSELECTION_DIRECTTI)
1131  0016 7b07          	ld	a,(OFST+5,sp)
1132  0018 a101          	cp	a,#1
1133  001a 2606          	jrne	L344
1134                     ; 391     icselection = (u8)TIM2_ICSELECTION_INDIRECTTI;
1136  001c a602          	ld	a,#2
1137  001e 6b02          	ld	(OFST+0,sp),a
1139  0020 2004          	jra	L544
1140  0022               L344:
1141                     ; 395     icselection = (u8)TIM2_ICSELECTION_DIRECTTI;
1143  0022 a601          	ld	a,#1
1144  0024 6b02          	ld	(OFST+0,sp),a
1145  0026               L544:
1146                     ; 398   if (TIM2_Channel == TIM2_CHANNEL_1)
1148  0026 0d03          	tnz	(OFST+1,sp)
1149  0028 2626          	jrne	L744
1150                     ; 401     TI1_Config(TIM2_ICPolarity, TIM2_ICSelection,
1150                     ; 402                TIM2_ICFilter);
1152  002a 7b09          	ld	a,(OFST+7,sp)
1153  002c 88            	push	a
1154  002d 7b08          	ld	a,(OFST+6,sp)
1155  002f 97            	ld	xl,a
1156  0030 7b05          	ld	a,(OFST+3,sp)
1157  0032 95            	ld	xh,a
1158  0033 cd0000        	call	L3_TI1_Config
1160  0036 84            	pop	a
1161                     ; 405     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1163  0037 7b08          	ld	a,(OFST+6,sp)
1164  0039 cd0000        	call	_TIM2_SetIC1Prescaler
1166                     ; 408     TI2_Config(icpolarity, icselection, TIM2_ICFilter);
1168  003c 7b09          	ld	a,(OFST+7,sp)
1169  003e 88            	push	a
1170  003f 7b03          	ld	a,(OFST+1,sp)
1171  0041 97            	ld	xl,a
1172  0042 7b02          	ld	a,(OFST+0,sp)
1173  0044 95            	ld	xh,a
1174  0045 cd0000        	call	L5_TI2_Config
1176  0048 84            	pop	a
1177                     ; 411     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1179  0049 7b08          	ld	a,(OFST+6,sp)
1180  004b cd0000        	call	_TIM2_SetIC2Prescaler
1183  004e 2024          	jra	L154
1184  0050               L744:
1185                     ; 416     TI2_Config(TIM2_ICPolarity, TIM2_ICSelection,
1185                     ; 417                TIM2_ICFilter);
1187  0050 7b09          	ld	a,(OFST+7,sp)
1188  0052 88            	push	a
1189  0053 7b08          	ld	a,(OFST+6,sp)
1190  0055 97            	ld	xl,a
1191  0056 7b05          	ld	a,(OFST+3,sp)
1192  0058 95            	ld	xh,a
1193  0059 cd0000        	call	L5_TI2_Config
1195  005c 84            	pop	a
1196                     ; 420     TIM2_SetIC2Prescaler(TIM2_ICPrescaler);
1198  005d 7b08          	ld	a,(OFST+6,sp)
1199  005f cd0000        	call	_TIM2_SetIC2Prescaler
1201                     ; 423     TI1_Config(icpolarity, icselection, TIM2_ICFilter);
1203  0062 7b09          	ld	a,(OFST+7,sp)
1204  0064 88            	push	a
1205  0065 7b03          	ld	a,(OFST+1,sp)
1206  0067 97            	ld	xl,a
1207  0068 7b02          	ld	a,(OFST+0,sp)
1208  006a 95            	ld	xh,a
1209  006b cd0000        	call	L3_TI1_Config
1211  006e 84            	pop	a
1212                     ; 426     TIM2_SetIC1Prescaler(TIM2_ICPrescaler);
1214  006f 7b08          	ld	a,(OFST+6,sp)
1215  0071 cd0000        	call	_TIM2_SetIC1Prescaler
1217  0074               L154:
1218                     ; 428 }
1221  0074 5b04          	addw	sp,#4
1222  0076 81            	ret
1277                     ; 446 void TIM2_Cmd(FunctionalState NewState)
1277                     ; 447 {
1278                     .text:	section	.text,new
1279  0000               _TIM2_Cmd:
1283                     ; 449   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1285                     ; 452   if (NewState != DISABLE)
1287  0000 4d            	tnz	a
1288  0001 2706          	jreq	L105
1289                     ; 454     TIM2->CR1 |= TIM2_CR1_CEN;
1291  0003 72105300      	bset	21248,#0
1293  0007 2004          	jra	L305
1294  0009               L105:
1295                     ; 458     TIM2->CR1 &= (u8)(~TIM2_CR1_CEN);
1297  0009 72115300      	bres	21248,#0
1298  000d               L305:
1299                     ; 460 }
1302  000d 81            	ret
1381                     ; 485 void TIM2_ITConfig(TIM2_IT_TypeDef TIM2_IT, FunctionalState NewState)
1381                     ; 486 {
1382                     .text:	section	.text,new
1383  0000               _TIM2_ITConfig:
1385  0000 89            	pushw	x
1386       00000000      OFST:	set	0
1389                     ; 488   assert_param(IS_TIM2_IT_OK(TIM2_IT));
1391                     ; 489   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1393                     ; 491   if (NewState != DISABLE)
1395  0001 9f            	ld	a,xl
1396  0002 4d            	tnz	a
1397  0003 2709          	jreq	L345
1398                     ; 494     TIM2->IER |= TIM2_IT;
1400  0005 9e            	ld	a,xh
1401  0006 ca5301        	or	a,21249
1402  0009 c75301        	ld	21249,a
1404  000c 2009          	jra	L545
1405  000e               L345:
1406                     ; 499     TIM2->IER &= (u8)(~TIM2_IT);
1408  000e 7b01          	ld	a,(OFST+1,sp)
1409  0010 43            	cpl	a
1410  0011 c45301        	and	a,21249
1411  0014 c75301        	ld	21249,a
1412  0017               L545:
1413                     ; 501 }
1416  0017 85            	popw	x
1417  0018 81            	ret
1453                     ; 519 void TIM2_UpdateDisableConfig(FunctionalState NewState)
1453                     ; 520 {
1454                     .text:	section	.text,new
1455  0000               _TIM2_UpdateDisableConfig:
1459                     ; 522   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1461                     ; 525   if (NewState != DISABLE)
1463  0000 4d            	tnz	a
1464  0001 2706          	jreq	L565
1465                     ; 527     TIM2->CR1 |= TIM2_CR1_UDIS;
1467  0003 72125300      	bset	21248,#1
1469  0007 2004          	jra	L765
1470  0009               L565:
1471                     ; 531     TIM2->CR1 &= (u8)(~TIM2_CR1_UDIS);
1473  0009 72135300      	bres	21248,#1
1474  000d               L765:
1475                     ; 533 }
1478  000d 81            	ret
1536                     ; 552 void TIM2_UpdateRequestConfig(TIM2_UpdateSource_TypeDef TIM2_UpdateSource)
1536                     ; 553 {
1537                     .text:	section	.text,new
1538  0000               _TIM2_UpdateRequestConfig:
1542                     ; 555   assert_param(IS_TIM2_UPDATE_SOURCE_OK(TIM2_UpdateSource));
1544                     ; 558   if (TIM2_UpdateSource != TIM2_UPDATESOURCE_GLOBAL)
1546  0000 4d            	tnz	a
1547  0001 2706          	jreq	L716
1548                     ; 560     TIM2->CR1 |= TIM2_CR1_URS;
1550  0003 72145300      	bset	21248,#2
1552  0007 2004          	jra	L126
1553  0009               L716:
1554                     ; 564     TIM2->CR1 &= (u8)(~TIM2_CR1_URS);
1556  0009 72155300      	bres	21248,#2
1557  000d               L126:
1558                     ; 566 }
1561  000d 81            	ret
1618                     ; 586 void TIM2_SelectOnePulseMode(TIM2_OPMode_TypeDef TIM2_OPMode)
1618                     ; 587 {
1619                     .text:	section	.text,new
1620  0000               _TIM2_SelectOnePulseMode:
1624                     ; 589   assert_param(IS_TIM2_OPM_MODE_OK(TIM2_OPMode));
1626                     ; 592   if (TIM2_OPMode != TIM2_OPMODE_REPETITIVE)
1628  0000 4d            	tnz	a
1629  0001 2706          	jreq	L156
1630                     ; 594     TIM2->CR1 |= TIM2_CR1_OPM;
1632  0003 72165300      	bset	21248,#3
1634  0007 2004          	jra	L356
1635  0009               L156:
1636                     ; 598     TIM2->CR1 &= (u8)(~TIM2_CR1_OPM);
1638  0009 72175300      	bres	21248,#3
1639  000d               L356:
1640                     ; 601 }
1643  000d 81            	ret
1711                     ; 641 void TIM2_PrescalerConfig(TIM2_Prescaler_TypeDef Prescaler,
1711                     ; 642                           TIM2_PSCReloadMode_TypeDef TIM2_PSCReloadMode)
1711                     ; 643 {
1712                     .text:	section	.text,new
1713  0000               _TIM2_PrescalerConfig:
1717                     ; 645   assert_param(IS_TIM2_PRESCALER_RELOAD_OK(TIM2_PSCReloadMode));
1719                     ; 646   assert_param(IS_TIM2_PRESCALER_OK(Prescaler));
1721                     ; 649   TIM2->PSCR = Prescaler;
1723  0000 9e            	ld	a,xh
1724  0001 c7530c        	ld	21260,a
1725                     ; 652   TIM2->EGR = TIM2_PSCReloadMode;
1727  0004 9f            	ld	a,xl
1728  0005 c75304        	ld	21252,a
1729                     ; 653 }
1732  0008 81            	ret
1790                     ; 673 void TIM2_ForcedOC1Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1790                     ; 674 {
1791                     .text:	section	.text,new
1792  0000               _TIM2_ForcedOC1Config:
1794  0000 88            	push	a
1795       00000000      OFST:	set	0
1798                     ; 676   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1800                     ; 679   TIM2->CCMR1  =  (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_OCM))  | (u8)TIM2_ForcedAction);
1802  0001 c65305        	ld	a,21253
1803  0004 a48f          	and	a,#143
1804  0006 1a01          	or	a,(OFST+1,sp)
1805  0008 c75305        	ld	21253,a
1806                     ; 680 }
1809  000b 84            	pop	a
1810  000c 81            	ret
1846                     ; 700 void TIM2_ForcedOC2Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1846                     ; 701 {
1847                     .text:	section	.text,new
1848  0000               _TIM2_ForcedOC2Config:
1850  0000 88            	push	a
1851       00000000      OFST:	set	0
1854                     ; 703   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1856                     ; 706   TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~TIM2_CCMR_OCM))  | (u8)TIM2_ForcedAction);
1858  0001 c65306        	ld	a,21254
1859  0004 a48f          	and	a,#143
1860  0006 1a01          	or	a,(OFST+1,sp)
1861  0008 c75306        	ld	21254,a
1862                     ; 707 }
1865  000b 84            	pop	a
1866  000c 81            	ret
1902                     ; 727 void TIM2_ForcedOC3Config(TIM2_ForcedAction_TypeDef TIM2_ForcedAction)
1902                     ; 728 {
1903                     .text:	section	.text,new
1904  0000               _TIM2_ForcedOC3Config:
1906  0000 88            	push	a
1907       00000000      OFST:	set	0
1910                     ; 730   assert_param(IS_TIM2_FORCED_ACTION_OK(TIM2_ForcedAction));
1912                     ; 733   TIM2->CCMR3  =  (u8)((TIM2->CCMR3 & (u8)(~TIM2_CCMR_OCM))  | (u8)TIM2_ForcedAction);
1914  0001 c65307        	ld	a,21255
1915  0004 a48f          	and	a,#143
1916  0006 1a01          	or	a,(OFST+1,sp)
1917  0008 c75307        	ld	21255,a
1918                     ; 734 }
1921  000b 84            	pop	a
1922  000c 81            	ret
1958                     ; 752 void TIM2_ARRPreloadConfig(FunctionalState NewState)
1958                     ; 753 {
1959                     .text:	section	.text,new
1960  0000               _TIM2_ARRPreloadConfig:
1964                     ; 755   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
1966                     ; 758   if (NewState != DISABLE)
1968  0000 4d            	tnz	a
1969  0001 2706          	jreq	L7001
1970                     ; 760     TIM2->CR1 |= TIM2_CR1_ARPE;
1972  0003 721e5300      	bset	21248,#7
1974  0007 2004          	jra	L1101
1975  0009               L7001:
1976                     ; 764     TIM2->CR1 &= (u8)(~TIM2_CR1_ARPE);
1978  0009 721f5300      	bres	21248,#7
1979  000d               L1101:
1980                     ; 766 }
1983  000d 81            	ret
2019                     ; 784 void TIM2_OC1PreloadConfig(FunctionalState NewState)
2019                     ; 785 {
2020                     .text:	section	.text,new
2021  0000               _TIM2_OC1PreloadConfig:
2025                     ; 787   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2027                     ; 790   if (NewState != DISABLE)
2029  0000 4d            	tnz	a
2030  0001 2706          	jreq	L1301
2031                     ; 792     TIM2->CCMR1 |= TIM2_CCMR_OCxPE;
2033  0003 72165305      	bset	21253,#3
2035  0007 2004          	jra	L3301
2036  0009               L1301:
2037                     ; 796     TIM2->CCMR1 &= (u8)(~TIM2_CCMR_OCxPE);
2039  0009 72175305      	bres	21253,#3
2040  000d               L3301:
2041                     ; 798 }
2044  000d 81            	ret
2080                     ; 816 void TIM2_OC2PreloadConfig(FunctionalState NewState)
2080                     ; 817 {
2081                     .text:	section	.text,new
2082  0000               _TIM2_OC2PreloadConfig:
2086                     ; 819   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2088                     ; 822   if (NewState != DISABLE)
2090  0000 4d            	tnz	a
2091  0001 2706          	jreq	L3501
2092                     ; 824     TIM2->CCMR2 |= TIM2_CCMR_OCxPE;
2094  0003 72165306      	bset	21254,#3
2096  0007 2004          	jra	L5501
2097  0009               L3501:
2098                     ; 828     TIM2->CCMR2 &= (u8)(~TIM2_CCMR_OCxPE);
2100  0009 72175306      	bres	21254,#3
2101  000d               L5501:
2102                     ; 830 }
2105  000d 81            	ret
2141                     ; 848 void TIM2_OC3PreloadConfig(FunctionalState NewState)
2141                     ; 849 {
2142                     .text:	section	.text,new
2143  0000               _TIM2_OC3PreloadConfig:
2147                     ; 851   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2149                     ; 854   if (NewState != DISABLE)
2151  0000 4d            	tnz	a
2152  0001 2706          	jreq	L5701
2153                     ; 856     TIM2->CCMR3 |= TIM2_CCMR_OCxPE;
2155  0003 72165307      	bset	21255,#3
2157  0007 2004          	jra	L7701
2158  0009               L5701:
2159                     ; 860     TIM2->CCMR3 &= (u8)(~TIM2_CCMR_OCxPE);
2161  0009 72175307      	bres	21255,#3
2162  000d               L7701:
2163                     ; 862 }
2166  000d 81            	ret
2239                     ; 884 void TIM2_GenerateEvent(TIM2_EventSource_TypeDef TIM2_EventSource)
2239                     ; 885 {
2240                     .text:	section	.text,new
2241  0000               _TIM2_GenerateEvent:
2245                     ; 887   assert_param(IS_TIM2_EVENT_SOURCE_OK(TIM2_EventSource));
2247                     ; 890   TIM2->EGR = TIM2_EventSource;
2249  0000 c75304        	ld	21252,a
2250                     ; 891 }
2253  0003 81            	ret
2289                     ; 911 void TIM2_OC1PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2289                     ; 912 {
2290                     .text:	section	.text,new
2291  0000               _TIM2_OC1PolarityConfig:
2295                     ; 914   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2297                     ; 917   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2299  0000 4d            	tnz	a
2300  0001 2706          	jreq	L1511
2301                     ; 919     TIM2->CCER1 |= TIM2_CCER1_CC1P;
2303  0003 72125308      	bset	21256,#1
2305  0007 2004          	jra	L3511
2306  0009               L1511:
2307                     ; 923     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P);
2309  0009 72135308      	bres	21256,#1
2310  000d               L3511:
2311                     ; 925 }
2314  000d 81            	ret
2350                     ; 945 void TIM2_OC2PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2350                     ; 946 {
2351                     .text:	section	.text,new
2352  0000               _TIM2_OC2PolarityConfig:
2356                     ; 948   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2358                     ; 951   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2360  0000 4d            	tnz	a
2361  0001 2706          	jreq	L3711
2362                     ; 953     TIM2->CCER1 |= TIM2_CCER1_CC2P;
2364  0003 721a5308      	bset	21256,#5
2366  0007 2004          	jra	L5711
2367  0009               L3711:
2368                     ; 957     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P);
2370  0009 721b5308      	bres	21256,#5
2371  000d               L5711:
2372                     ; 959 }
2375  000d 81            	ret
2411                     ; 979 void TIM2_OC3PolarityConfig(TIM2_OCPolarity_TypeDef TIM2_OCPolarity)
2411                     ; 980 {
2412                     .text:	section	.text,new
2413  0000               _TIM2_OC3PolarityConfig:
2417                     ; 982   assert_param(IS_TIM2_OC_POLARITY_OK(TIM2_OCPolarity));
2419                     ; 985   if (TIM2_OCPolarity != TIM2_OCPOLARITY_HIGH)
2421  0000 4d            	tnz	a
2422  0001 2706          	jreq	L5121
2423                     ; 987     TIM2->CCER2 |= TIM2_CCER2_CC3P;
2425  0003 72125309      	bset	21257,#1
2427  0007 2004          	jra	L7121
2428  0009               L5121:
2429                     ; 991     TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P);
2431  0009 72135309      	bres	21257,#1
2432  000d               L7121:
2433                     ; 993 }
2436  000d 81            	ret
2481                     ; 1016 void TIM2_CCxCmd(TIM2_Channel_TypeDef TIM2_Channel, FunctionalState NewState)
2481                     ; 1017 {
2482                     .text:	section	.text,new
2483  0000               _TIM2_CCxCmd:
2485  0000 89            	pushw	x
2486       00000000      OFST:	set	0
2489                     ; 1019   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2491                     ; 1020   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2493                     ; 1022   if (TIM2_Channel == TIM2_CHANNEL_1)
2495  0001 9e            	ld	a,xh
2496  0002 4d            	tnz	a
2497  0003 2610          	jrne	L3421
2498                     ; 1025     if (NewState != DISABLE)
2500  0005 9f            	ld	a,xl
2501  0006 4d            	tnz	a
2502  0007 2706          	jreq	L5421
2503                     ; 1027       TIM2->CCER1 |= TIM2_CCER1_CC1E;
2505  0009 72105308      	bset	21256,#0
2507  000d 202a          	jra	L1521
2508  000f               L5421:
2509                     ; 1031       TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);
2511  000f 72115308      	bres	21256,#0
2512  0013 2024          	jra	L1521
2513  0015               L3421:
2514                     ; 1035   else if (TIM2_Channel == TIM2_CHANNEL_2)
2516  0015 7b01          	ld	a,(OFST+1,sp)
2517  0017 a101          	cp	a,#1
2518  0019 2610          	jrne	L3521
2519                     ; 1038     if (NewState != DISABLE)
2521  001b 0d02          	tnz	(OFST+2,sp)
2522  001d 2706          	jreq	L5521
2523                     ; 1040       TIM2->CCER1 |= TIM2_CCER1_CC2E;
2525  001f 72185308      	bset	21256,#4
2527  0023 2014          	jra	L1521
2528  0025               L5521:
2529                     ; 1044       TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);
2531  0025 72195308      	bres	21256,#4
2532  0029 200e          	jra	L1521
2533  002b               L3521:
2534                     ; 1050     if (NewState != DISABLE)
2536  002b 0d02          	tnz	(OFST+2,sp)
2537  002d 2706          	jreq	L3621
2538                     ; 1052       TIM2->CCER2 |= TIM2_CCER2_CC3E;
2540  002f 72105309      	bset	21257,#0
2542  0033 2004          	jra	L1521
2543  0035               L3621:
2544                     ; 1056       TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E);
2546  0035 72115309      	bres	21257,#0
2547  0039               L1521:
2548                     ; 1059 }
2551  0039 85            	popw	x
2552  003a 81            	ret
2597                     ; 1090 void TIM2_SelectOCxM(TIM2_Channel_TypeDef TIM2_Channel, TIM2_OCMode_TypeDef TIM2_OCMode)
2597                     ; 1091 {
2598                     .text:	section	.text,new
2599  0000               _TIM2_SelectOCxM:
2601  0000 89            	pushw	x
2602       00000000      OFST:	set	0
2605                     ; 1093   assert_param(IS_TIM2_CHANNEL_OK(TIM2_Channel));
2607                     ; 1094   assert_param(IS_TIM2_OCM_OK(TIM2_OCMode));
2609                     ; 1096   if (TIM2_Channel == TIM2_CHANNEL_1)
2611  0001 9e            	ld	a,xh
2612  0002 4d            	tnz	a
2613  0003 2610          	jrne	L1131
2614                     ; 1099     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);
2616  0005 72115308      	bres	21256,#0
2617                     ; 1102     TIM2->CCMR1 = (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
2619  0009 c65305        	ld	a,21253
2620  000c a48f          	and	a,#143
2621  000e 1a02          	or	a,(OFST+2,sp)
2622  0010 c75305        	ld	21253,a
2624  0013 2024          	jra	L3131
2625  0015               L1131:
2626                     ; 1104   else if (TIM2_Channel == TIM2_CHANNEL_2)
2628  0015 7b01          	ld	a,(OFST+1,sp)
2629  0017 a101          	cp	a,#1
2630  0019 2610          	jrne	L5131
2631                     ; 1107     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);
2633  001b 72195308      	bres	21256,#4
2634                     ; 1110     TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
2636  001f c65306        	ld	a,21254
2637  0022 a48f          	and	a,#143
2638  0024 1a02          	or	a,(OFST+2,sp)
2639  0026 c75306        	ld	21254,a
2641  0029 200e          	jra	L3131
2642  002b               L5131:
2643                     ; 1115     TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3E);
2645  002b 72115309      	bres	21257,#0
2646                     ; 1118     TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~TIM2_CCMR_OCM)) | (u8)TIM2_OCMode);
2648  002f c65307        	ld	a,21255
2649  0032 a48f          	and	a,#143
2650  0034 1a02          	or	a,(OFST+2,sp)
2651  0036 c75307        	ld	21255,a
2652  0039               L3131:
2653                     ; 1120 }
2656  0039 85            	popw	x
2657  003a 81            	ret
2689                     ; 1138 void TIM2_SetCounter(u16 Counter)
2689                     ; 1139 {
2690                     .text:	section	.text,new
2691  0000               _TIM2_SetCounter:
2695                     ; 1141   TIM2->CNTRH = (u8)(Counter >> 8);
2697  0000 9e            	ld	a,xh
2698  0001 c7530a        	ld	21258,a
2699                     ; 1142   TIM2->CNTRL = (u8)(Counter);
2701  0004 9f            	ld	a,xl
2702  0005 c7530b        	ld	21259,a
2703                     ; 1144 }
2706  0008 81            	ret
2738                     ; 1162 void TIM2_SetAutoreload(u16 Autoreload)
2738                     ; 1163 {
2739                     .text:	section	.text,new
2740  0000               _TIM2_SetAutoreload:
2744                     ; 1166   TIM2->ARRH = (u8)(Autoreload >> 8);
2746  0000 9e            	ld	a,xh
2747  0001 c7530d        	ld	21261,a
2748                     ; 1167   TIM2->ARRL = (u8)(Autoreload);
2750  0004 9f            	ld	a,xl
2751  0005 c7530e        	ld	21262,a
2752                     ; 1169 }
2755  0008 81            	ret
2787                     ; 1187 void TIM2_SetCompare1(u16 Compare1)
2787                     ; 1188 {
2788                     .text:	section	.text,new
2789  0000               _TIM2_SetCompare1:
2793                     ; 1190   TIM2->CCR1H = (u8)(Compare1 >> 8);
2795  0000 9e            	ld	a,xh
2796  0001 c7530f        	ld	21263,a
2797                     ; 1191   TIM2->CCR1L = (u8)(Compare1);
2799  0004 9f            	ld	a,xl
2800  0005 c75310        	ld	21264,a
2801                     ; 1193 }
2804  0008 81            	ret
2836                     ; 1211 void TIM2_SetCompare2(u16 Compare2)
2836                     ; 1212 {
2837                     .text:	section	.text,new
2838  0000               _TIM2_SetCompare2:
2842                     ; 1214   TIM2->CCR2H = (u8)(Compare2 >> 8);
2844  0000 9e            	ld	a,xh
2845  0001 c75311        	ld	21265,a
2846                     ; 1215   TIM2->CCR2L = (u8)(Compare2);
2848  0004 9f            	ld	a,xl
2849  0005 c75312        	ld	21266,a
2850                     ; 1217 }
2853  0008 81            	ret
2885                     ; 1235 void TIM2_SetCompare3(u16 Compare3)
2885                     ; 1236 {
2886                     .text:	section	.text,new
2887  0000               _TIM2_SetCompare3:
2891                     ; 1238   TIM2->CCR3H = (u8)(Compare3 >> 8);
2893  0000 9e            	ld	a,xh
2894  0001 c75313        	ld	21267,a
2895                     ; 1239   TIM2->CCR3L = (u8)(Compare3);
2897  0004 9f            	ld	a,xl
2898  0005 c75314        	ld	21268,a
2899                     ; 1241 }
2902  0008 81            	ret
2938                     ; 1263 void TIM2_SetIC1Prescaler(TIM2_ICPSC_TypeDef TIM2_IC1Prescaler)
2938                     ; 1264 {
2939                     .text:	section	.text,new
2940  0000               _TIM2_SetIC1Prescaler:
2942  0000 88            	push	a
2943       00000000      OFST:	set	0
2946                     ; 1266   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC1Prescaler));
2948                     ; 1269   TIM2->CCMR1 = (u8)((TIM2->CCMR1 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC1Prescaler);
2950  0001 c65305        	ld	a,21253
2951  0004 a4f3          	and	a,#243
2952  0006 1a01          	or	a,(OFST+1,sp)
2953  0008 c75305        	ld	21253,a
2954                     ; 1270 }
2957  000b 84            	pop	a
2958  000c 81            	ret
2994                     ; 1291 void TIM2_SetIC2Prescaler(TIM2_ICPSC_TypeDef TIM2_IC2Prescaler)
2994                     ; 1292 {
2995                     .text:	section	.text,new
2996  0000               _TIM2_SetIC2Prescaler:
2998  0000 88            	push	a
2999       00000000      OFST:	set	0
3002                     ; 1294   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC2Prescaler));
3004                     ; 1297   TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC2Prescaler);
3006  0001 c65306        	ld	a,21254
3007  0004 a4f3          	and	a,#243
3008  0006 1a01          	or	a,(OFST+1,sp)
3009  0008 c75306        	ld	21254,a
3010                     ; 1298 }
3013  000b 84            	pop	a
3014  000c 81            	ret
3050                     ; 1319 void TIM2_SetIC3Prescaler(TIM2_ICPSC_TypeDef TIM2_IC3Prescaler)
3050                     ; 1320 {
3051                     .text:	section	.text,new
3052  0000               _TIM2_SetIC3Prescaler:
3054  0000 88            	push	a
3055       00000000      OFST:	set	0
3058                     ; 1323   assert_param(IS_TIM2_IC_PRESCALER_OK(TIM2_IC3Prescaler));
3060                     ; 1325   TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~TIM2_CCMR_ICxPSC)) | (u8)TIM2_IC3Prescaler);
3062  0001 c65307        	ld	a,21255
3063  0004 a4f3          	and	a,#243
3064  0006 1a01          	or	a,(OFST+1,sp)
3065  0008 c75307        	ld	21255,a
3066                     ; 1326 }
3069  000b 84            	pop	a
3070  000c 81            	ret
3116                     ; 1344 u16 TIM2_GetCapture1(void)
3116                     ; 1345 {
3117                     .text:	section	.text,new
3118  0000               _TIM2_GetCapture1:
3120  0000 5204          	subw	sp,#4
3121       00000004      OFST:	set	4
3124                     ; 1347    u16 tmpccr1 = 0;
3126  0002 1e03          	ldw	x,(OFST-1,sp)
3127                     ; 1348    u8 tmpccr1l=0, tmpccr1h=0;
3129  0004 7b01          	ld	a,(OFST-3,sp)
3130  0006 97            	ld	xl,a
3133  0007 7b02          	ld	a,(OFST-2,sp)
3134  0009 97            	ld	xl,a
3135                     ; 1350     tmpccr1h = TIM2->CCR1H;
3137  000a c6530f        	ld	a,21263
3138  000d 6b02          	ld	(OFST-2,sp),a
3139                     ; 1351 	tmpccr1l = TIM2->CCR1L;
3141  000f c65310        	ld	a,21264
3142  0012 6b01          	ld	(OFST-3,sp),a
3143                     ; 1353     tmpccr1 = (u16)(tmpccr1l);
3145  0014 7b01          	ld	a,(OFST-3,sp)
3146  0016 5f            	clrw	x
3147  0017 97            	ld	xl,a
3148  0018 1f03          	ldw	(OFST-1,sp),x
3149                     ; 1354     tmpccr1 |= (u16)((u16)tmpccr1h << 8);
3151  001a 7b02          	ld	a,(OFST-2,sp)
3152  001c 5f            	clrw	x
3153  001d 97            	ld	xl,a
3154  001e 4f            	clr	a
3155  001f 02            	rlwa	x,a
3156  0020 01            	rrwa	x,a
3157  0021 1a04          	or	a,(OFST+0,sp)
3158  0023 01            	rrwa	x,a
3159  0024 1a03          	or	a,(OFST-1,sp)
3160  0026 01            	rrwa	x,a
3161  0027 1f03          	ldw	(OFST-1,sp),x
3162                     ; 1356     return (u16)tmpccr1;
3164  0029 1e03          	ldw	x,(OFST-1,sp)
3167  002b 5b04          	addw	sp,#4
3168  002d 81            	ret
3214                     ; 1375 u16 TIM2_GetCapture2(void)
3214                     ; 1376 {
3215                     .text:	section	.text,new
3216  0000               _TIM2_GetCapture2:
3218  0000 5204          	subw	sp,#4
3219       00000004      OFST:	set	4
3222                     ; 1378    u16 tmpccr2 = 0;
3224  0002 1e03          	ldw	x,(OFST-1,sp)
3225                     ; 1379    u8 tmpccr2l=0, tmpccr2h=0;
3227  0004 7b01          	ld	a,(OFST-3,sp)
3228  0006 97            	ld	xl,a
3231  0007 7b02          	ld	a,(OFST-2,sp)
3232  0009 97            	ld	xl,a
3233                     ; 1381     tmpccr2h = TIM2->CCR2H;
3235  000a c65311        	ld	a,21265
3236  000d 6b02          	ld	(OFST-2,sp),a
3237                     ; 1382 	tmpccr2l = TIM2->CCR2L;
3239  000f c65312        	ld	a,21266
3240  0012 6b01          	ld	(OFST-3,sp),a
3241                     ; 1384     tmpccr2 = (u16)(tmpccr2l);
3243  0014 7b01          	ld	a,(OFST-3,sp)
3244  0016 5f            	clrw	x
3245  0017 97            	ld	xl,a
3246  0018 1f03          	ldw	(OFST-1,sp),x
3247                     ; 1385     tmpccr2 |= (u16)((u16)tmpccr2h << 8);
3249  001a 7b02          	ld	a,(OFST-2,sp)
3250  001c 5f            	clrw	x
3251  001d 97            	ld	xl,a
3252  001e 4f            	clr	a
3253  001f 02            	rlwa	x,a
3254  0020 01            	rrwa	x,a
3255  0021 1a04          	or	a,(OFST+0,sp)
3256  0023 01            	rrwa	x,a
3257  0024 1a03          	or	a,(OFST-1,sp)
3258  0026 01            	rrwa	x,a
3259  0027 1f03          	ldw	(OFST-1,sp),x
3260                     ; 1387     return (u16)tmpccr2;
3262  0029 1e03          	ldw	x,(OFST-1,sp)
3265  002b 5b04          	addw	sp,#4
3266  002d 81            	ret
3312                     ; 1406 u16 TIM2_GetCapture3(void)
3312                     ; 1407 {
3313                     .text:	section	.text,new
3314  0000               _TIM2_GetCapture3:
3316  0000 5204          	subw	sp,#4
3317       00000004      OFST:	set	4
3320                     ; 1409     u16 tmpccr3 = 0;
3322  0002 1e03          	ldw	x,(OFST-1,sp)
3323                     ; 1410     u8 tmpccr3l=0, tmpccr3h=0;
3325  0004 7b01          	ld	a,(OFST-3,sp)
3326  0006 97            	ld	xl,a
3329  0007 7b02          	ld	a,(OFST-2,sp)
3330  0009 97            	ld	xl,a
3331                     ; 1412     tmpccr3h = TIM2->CCR3H;
3333  000a c65313        	ld	a,21267
3334  000d 6b02          	ld	(OFST-2,sp),a
3335                     ; 1413 	tmpccr3l = TIM2->CCR3L;
3337  000f c65314        	ld	a,21268
3338  0012 6b01          	ld	(OFST-3,sp),a
3339                     ; 1415     tmpccr3 = (u16)(tmpccr3l);
3341  0014 7b01          	ld	a,(OFST-3,sp)
3342  0016 5f            	clrw	x
3343  0017 97            	ld	xl,a
3344  0018 1f03          	ldw	(OFST-1,sp),x
3345                     ; 1416     tmpccr3 |= (u16)((u16)tmpccr3h << 8);
3347  001a 7b02          	ld	a,(OFST-2,sp)
3348  001c 5f            	clrw	x
3349  001d 97            	ld	xl,a
3350  001e 4f            	clr	a
3351  001f 02            	rlwa	x,a
3352  0020 01            	rrwa	x,a
3353  0021 1a04          	or	a,(OFST+0,sp)
3354  0023 01            	rrwa	x,a
3355  0024 1a03          	or	a,(OFST-1,sp)
3356  0026 01            	rrwa	x,a
3357  0027 1f03          	ldw	(OFST-1,sp),x
3358                     ; 1418     return (u16)tmpccr3;
3360  0029 1e03          	ldw	x,(OFST-1,sp)
3363  002b 5b04          	addw	sp,#4
3364  002d 81            	ret
3387                     ; 1437 u16 TIM2_GetCounter(void)
3387                     ; 1438 {
3388                     .text:	section	.text,new
3389  0000               _TIM2_GetCounter:
3391  0000 89            	pushw	x
3392       00000002      OFST:	set	2
3395                     ; 1440   return (u16)(((u16)TIM2->CNTRH << 8) | (u16)(TIM2->CNTRL));
3397  0001 c6530b        	ld	a,21259
3398  0004 5f            	clrw	x
3399  0005 97            	ld	xl,a
3400  0006 1f01          	ldw	(OFST-1,sp),x
3401  0008 c6530a        	ld	a,21258
3402  000b 5f            	clrw	x
3403  000c 97            	ld	xl,a
3404  000d 4f            	clr	a
3405  000e 02            	rlwa	x,a
3406  000f 01            	rrwa	x,a
3407  0010 1a02          	or	a,(OFST+0,sp)
3408  0012 01            	rrwa	x,a
3409  0013 1a01          	or	a,(OFST-1,sp)
3410  0015 01            	rrwa	x,a
3413  0016 5b02          	addw	sp,#2
3414  0018 81            	ret
3438                     ; 1460 TIM2_Prescaler_TypeDef TIM2_GetPrescaler(void)
3438                     ; 1461 {
3439                     .text:	section	.text,new
3440  0000               _TIM2_GetPrescaler:
3444                     ; 1463   return (TIM2_Prescaler_TypeDef)(TIM2->PSCR);
3446  0000 c6530c        	ld	a,21260
3449  0003 81            	ret
3584                     ; 1490 FlagStatus TIM2_GetFlagStatus(TIM2_FLAG_TypeDef TIM2_FLAG)
3584                     ; 1491 {
3585                     .text:	section	.text,new
3586  0000               _TIM2_GetFlagStatus:
3588  0000 89            	pushw	x
3589  0001 5203          	subw	sp,#3
3590       00000003      OFST:	set	3
3593                     ; 1492   FlagStatus bitstatus = RESET;
3595  0003 7b03          	ld	a,(OFST+0,sp)
3596  0005 97            	ld	xl,a
3597                     ; 1496   assert_param(IS_TIM2_GET_FLAG_OK(TIM2_FLAG));
3599                     ; 1498   tim2_flag_l = (u8)(TIM2_FLAG);
3601  0006 7b05          	ld	a,(OFST+2,sp)
3602  0008 6b02          	ld	(OFST-1,sp),a
3603                     ; 1499   tim2_flag_h = (u8)(TIM2_FLAG >> 8);
3605  000a 7b04          	ld	a,(OFST+1,sp)
3606  000c 6b03          	ld	(OFST+0,sp),a
3607                     ; 1501   if (((TIM2->SR1 & tim2_flag_l) | (TIM2->SR2 & tim2_flag_h)) != (u8)RESET )
3609  000e c65303        	ld	a,21251
3610  0011 1403          	and	a,(OFST+0,sp)
3611  0013 6b01          	ld	(OFST-2,sp),a
3612  0015 c65302        	ld	a,21250
3613  0018 1402          	and	a,(OFST-1,sp)
3614  001a 1a01          	or	a,(OFST-2,sp)
3615  001c 2706          	jreq	L7461
3616                     ; 1503     bitstatus = SET;
3618  001e a601          	ld	a,#1
3619  0020 6b03          	ld	(OFST+0,sp),a
3621  0022 2002          	jra	L1561
3622  0024               L7461:
3623                     ; 1507     bitstatus = RESET;
3625  0024 0f03          	clr	(OFST+0,sp)
3626  0026               L1561:
3627                     ; 1509   return (FlagStatus)bitstatus;
3629  0026 7b03          	ld	a,(OFST+0,sp)
3632  0028 5b05          	addw	sp,#5
3633  002a 81            	ret
3668                     ; 1535 void TIM2_ClearFlag(TIM2_FLAG_TypeDef TIM2_FLAG)
3668                     ; 1536 {
3669                     .text:	section	.text,new
3670  0000               _TIM2_ClearFlag:
3672  0000 89            	pushw	x
3673       00000000      OFST:	set	0
3676                     ; 1538   assert_param(IS_TIM2_CLEAR_FLAG_OK(TIM2_FLAG));
3678                     ; 1541   TIM2->SR1 = (u8)(~((u8)(TIM2_FLAG)));
3680  0001 9f            	ld	a,xl
3681  0002 43            	cpl	a
3682  0003 c75302        	ld	21250,a
3683                     ; 1542   TIM2->SR2 = (u8)(~((u8)(TIM2_FLAG >> 8)));
3685  0006 7b01          	ld	a,(OFST+1,sp)
3686  0008 43            	cpl	a
3687  0009 c75303        	ld	21251,a
3688                     ; 1543 }
3691  000c 85            	popw	x
3692  000d 81            	ret
3752                     ; 1567 ITStatus TIM2_GetITStatus(TIM2_IT_TypeDef TIM2_IT)
3752                     ; 1568 {
3753                     .text:	section	.text,new
3754  0000               _TIM2_GetITStatus:
3756  0000 88            	push	a
3757  0001 89            	pushw	x
3758       00000002      OFST:	set	2
3761                     ; 1569   ITStatus bitstatus = RESET;
3763  0002 7b02          	ld	a,(OFST+0,sp)
3764  0004 97            	ld	xl,a
3765                     ; 1571   u8 TIM2_itStatus = 0x0, TIM2_itEnable = 0x0;
3767  0005 7b01          	ld	a,(OFST-1,sp)
3768  0007 97            	ld	xl,a
3771  0008 7b02          	ld	a,(OFST+0,sp)
3772  000a 97            	ld	xl,a
3773                     ; 1574   assert_param(IS_TIM2_GET_IT_OK(TIM2_IT));
3775                     ; 1576   TIM2_itStatus = (u8)(TIM2->SR1 & TIM2_IT);
3777  000b c65302        	ld	a,21250
3778  000e 1403          	and	a,(OFST+1,sp)
3779  0010 6b01          	ld	(OFST-1,sp),a
3780                     ; 1578   TIM2_itEnable = (u8)(TIM2->IER & TIM2_IT);
3782  0012 c65301        	ld	a,21249
3783  0015 1403          	and	a,(OFST+1,sp)
3784  0017 6b02          	ld	(OFST+0,sp),a
3785                     ; 1580   if ((TIM2_itStatus != (u8)RESET ) && (TIM2_itEnable != (u8)RESET ))
3787  0019 0d01          	tnz	(OFST-1,sp)
3788  001b 270a          	jreq	L7171
3790  001d 0d02          	tnz	(OFST+0,sp)
3791  001f 2706          	jreq	L7171
3792                     ; 1582     bitstatus = SET;
3794  0021 a601          	ld	a,#1
3795  0023 6b02          	ld	(OFST+0,sp),a
3797  0025 2002          	jra	L1271
3798  0027               L7171:
3799                     ; 1586     bitstatus = RESET;
3801  0027 0f02          	clr	(OFST+0,sp)
3802  0029               L1271:
3803                     ; 1588   return (ITStatus)(bitstatus);
3805  0029 7b02          	ld	a,(OFST+0,sp)
3808  002b 5b03          	addw	sp,#3
3809  002d 81            	ret
3845                     ; 1611 void TIM2_ClearITPendingBit(TIM2_IT_TypeDef TIM2_IT)
3845                     ; 1612 {
3846                     .text:	section	.text,new
3847  0000               _TIM2_ClearITPendingBit:
3851                     ; 1614   assert_param(IS_TIM2_IT_OK(TIM2_IT));
3853                     ; 1617   TIM2->SR1 = (u8)(~TIM2_IT);
3855  0000 43            	cpl	a
3856  0001 c75302        	ld	21250,a
3857                     ; 1618 }
3860  0004 81            	ret
3906                     ; 1646 static void TI1_Config(u8 TIM2_ICPolarity,
3906                     ; 1647                        u8 TIM2_ICSelection,
3906                     ; 1648                        u8 TIM2_ICFilter)
3906                     ; 1649 {
3907                     .text:	section	.text,new
3908  0000               L3_TI1_Config:
3910  0000 89            	pushw	x
3911  0001 88            	push	a
3912       00000001      OFST:	set	1
3915                     ; 1651   TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1E);
3917  0002 72115308      	bres	21256,#0
3918                     ; 1654   TIM2->CCMR1  = (u8)((TIM2->CCMR1 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));
3920  0006 7b06          	ld	a,(OFST+5,sp)
3921  0008 97            	ld	xl,a
3922  0009 a610          	ld	a,#16
3923  000b 42            	mul	x,a
3924  000c 9f            	ld	a,xl
3925  000d 1a03          	or	a,(OFST+2,sp)
3926  000f 6b01          	ld	(OFST+0,sp),a
3927  0011 c65305        	ld	a,21253
3928  0014 a40c          	and	a,#12
3929  0016 1a01          	or	a,(OFST+0,sp)
3930  0018 c75305        	ld	21253,a
3931                     ; 1657   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
3933  001b 0d02          	tnz	(OFST+1,sp)
3934  001d 2706          	jreq	L1671
3935                     ; 1659     TIM2->CCER1 |= TIM2_CCER1_CC1P;
3937  001f 72125308      	bset	21256,#1
3939  0023 2004          	jra	L3671
3940  0025               L1671:
3941                     ; 1663     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC1P);
3943  0025 72135308      	bres	21256,#1
3944  0029               L3671:
3945                     ; 1666   TIM2->CCER1 |= TIM2_CCER1_CC1E;
3947  0029 72105308      	bset	21256,#0
3948                     ; 1667 }
3951  002d 5b03          	addw	sp,#3
3952  002f 81            	ret
3998                     ; 1695 static void TI2_Config(u8 TIM2_ICPolarity,
3998                     ; 1696                        u8 TIM2_ICSelection,
3998                     ; 1697                        u8 TIM2_ICFilter)
3998                     ; 1698 {
3999                     .text:	section	.text,new
4000  0000               L5_TI2_Config:
4002  0000 89            	pushw	x
4003  0001 88            	push	a
4004       00000001      OFST:	set	1
4007                     ; 1700   TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2E);
4009  0002 72195308      	bres	21256,#4
4010                     ; 1703   TIM2->CCMR2 = (u8)((TIM2->CCMR2 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));
4012  0006 7b06          	ld	a,(OFST+5,sp)
4013  0008 97            	ld	xl,a
4014  0009 a610          	ld	a,#16
4015  000b 42            	mul	x,a
4016  000c 9f            	ld	a,xl
4017  000d 1a03          	or	a,(OFST+2,sp)
4018  000f 6b01          	ld	(OFST+0,sp),a
4019  0011 c65306        	ld	a,21254
4020  0014 a40c          	and	a,#12
4021  0016 1a01          	or	a,(OFST+0,sp)
4022  0018 c75306        	ld	21254,a
4023                     ; 1707   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4025  001b 0d02          	tnz	(OFST+1,sp)
4026  001d 2706          	jreq	L5002
4027                     ; 1709     TIM2->CCER1 |= TIM2_CCER1_CC2P;
4029  001f 721a5308      	bset	21256,#5
4031  0023 2004          	jra	L7002
4032  0025               L5002:
4033                     ; 1713     TIM2->CCER1 &= (u8)(~TIM2_CCER1_CC2P);
4035  0025 721b5308      	bres	21256,#5
4036  0029               L7002:
4037                     ; 1717   TIM2->CCER1 |= TIM2_CCER1_CC2E;
4039  0029 72185308      	bset	21256,#4
4040                     ; 1719 }
4043  002d 5b03          	addw	sp,#3
4044  002f 81            	ret
4090                     ; 1744 static void TI3_Config(u8 TIM2_ICPolarity, u8 TIM2_ICSelection,
4090                     ; 1745                        u8 TIM2_ICFilter)
4090                     ; 1746 {
4091                     .text:	section	.text,new
4092  0000               L7_TI3_Config:
4094  0000 89            	pushw	x
4095  0001 88            	push	a
4096       00000001      OFST:	set	1
4099                     ; 1748   TIM2->CCER2 &=  (u8)(~TIM2_CCER2_CC3E);
4101  0002 72115309      	bres	21257,#0
4102                     ; 1751   TIM2->CCMR3 = (u8)((TIM2->CCMR3 & (u8)(~( TIM2_CCMR_CCxS     |        TIM2_CCMR_ICxF    ))) | (u8)(( (TIM2_ICSelection)) | ((u8)( TIM2_ICFilter << 4))));
4104  0006 7b06          	ld	a,(OFST+5,sp)
4105  0008 97            	ld	xl,a
4106  0009 a610          	ld	a,#16
4107  000b 42            	mul	x,a
4108  000c 9f            	ld	a,xl
4109  000d 1a03          	or	a,(OFST+2,sp)
4110  000f 6b01          	ld	(OFST+0,sp),a
4111  0011 c65307        	ld	a,21255
4112  0014 a40c          	and	a,#12
4113  0016 1a01          	or	a,(OFST+0,sp)
4114  0018 c75307        	ld	21255,a
4115                     ; 1755   if (TIM2_ICPolarity != TIM2_ICPOLARITY_RISING)
4117  001b 0d02          	tnz	(OFST+1,sp)
4118  001d 2706          	jreq	L1302
4119                     ; 1757     TIM2->CCER2 |= TIM2_CCER2_CC3P;
4121  001f 72125309      	bset	21257,#1
4123  0023 2004          	jra	L3302
4124  0025               L1302:
4125                     ; 1761     TIM2->CCER2 &= (u8)(~TIM2_CCER2_CC3P);
4127  0025 72135309      	bres	21257,#1
4128  0029               L3302:
4129                     ; 1764   TIM2->CCER2 |= TIM2_CCER2_CC3E;
4131  0029 72105309      	bset	21257,#0
4132                     ; 1765 }
4135  002d 5b03          	addw	sp,#3
4136  002f 81            	ret
4149                     	xdef	_TIM2_ClearITPendingBit
4150                     	xdef	_TIM2_GetITStatus
4151                     	xdef	_TIM2_ClearFlag
4152                     	xdef	_TIM2_GetFlagStatus
4153                     	xdef	_TIM2_GetPrescaler
4154                     	xdef	_TIM2_GetCounter
4155                     	xdef	_TIM2_GetCapture3
4156                     	xdef	_TIM2_GetCapture2
4157                     	xdef	_TIM2_GetCapture1
4158                     	xdef	_TIM2_SetIC3Prescaler
4159                     	xdef	_TIM2_SetIC2Prescaler
4160                     	xdef	_TIM2_SetIC1Prescaler
4161                     	xdef	_TIM2_SetCompare3
4162                     	xdef	_TIM2_SetCompare2
4163                     	xdef	_TIM2_SetCompare1
4164                     	xdef	_TIM2_SetAutoreload
4165                     	xdef	_TIM2_SetCounter
4166                     	xdef	_TIM2_SelectOCxM
4167                     	xdef	_TIM2_CCxCmd
4168                     	xdef	_TIM2_OC3PolarityConfig
4169                     	xdef	_TIM2_OC2PolarityConfig
4170                     	xdef	_TIM2_OC1PolarityConfig
4171                     	xdef	_TIM2_GenerateEvent
4172                     	xdef	_TIM2_OC3PreloadConfig
4173                     	xdef	_TIM2_OC2PreloadConfig
4174                     	xdef	_TIM2_OC1PreloadConfig
4175                     	xdef	_TIM2_ARRPreloadConfig
4176                     	xdef	_TIM2_ForcedOC3Config
4177                     	xdef	_TIM2_ForcedOC2Config
4178                     	xdef	_TIM2_ForcedOC1Config
4179                     	xdef	_TIM2_PrescalerConfig
4180                     	xdef	_TIM2_SelectOnePulseMode
4181                     	xdef	_TIM2_UpdateRequestConfig
4182                     	xdef	_TIM2_UpdateDisableConfig
4183                     	xdef	_TIM2_ITConfig
4184                     	xdef	_TIM2_Cmd
4185                     	xdef	_TIM2_PWMIConfig
4186                     	xdef	_TIM2_ICInit
4187                     	xdef	_TIM2_OC3Init
4188                     	xdef	_TIM2_OC2Init
4189                     	xdef	_TIM2_OC1Init
4190                     	xdef	_TIM2_TimeBaseInit
4191                     	xdef	_TIM2_DeInit
4210                     	end
