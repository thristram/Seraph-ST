   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  32                     ; 69 void TIM1_DeInit(void)
  32                     ; 70 {
  34                     .text:	section	.text,new
  35  0000               _TIM1_DeInit:
  39                     ; 71   TIM1->CR1  = TIM1_CR1_RESET_VALUE;
  41  0000 725f5250      	clr	21072
  42                     ; 72   TIM1->CR2  = TIM1_CR2_RESET_VALUE;
  44  0004 725f5251      	clr	21073
  45                     ; 73   TIM1->SMCR = TIM1_SMCR_RESET_VALUE;
  47  0008 725f5252      	clr	21074
  48                     ; 74   TIM1->ETR  = TIM1_ETR_RESET_VALUE;
  50  000c 725f5253      	clr	21075
  51                     ; 75   TIM1->IER  = TIM1_IER_RESET_VALUE;
  53  0010 725f5254      	clr	21076
  54                     ; 76   TIM1->SR2  = TIM1_SR2_RESET_VALUE;
  56  0014 725f5256      	clr	21078
  57                     ; 78   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  59  0018 725f525c      	clr	21084
  60                     ; 79   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  62  001c 725f525d      	clr	21085
  63                     ; 81   TIM1->CCMR1 = 0x01;
  65  0020 35015258      	mov	21080,#1
  66                     ; 82   TIM1->CCMR2 = 0x01;
  68  0024 35015259      	mov	21081,#1
  69                     ; 83   TIM1->CCMR3 = 0x01;
  71  0028 3501525a      	mov	21082,#1
  72                     ; 84   TIM1->CCMR4 = 0x01;
  74  002c 3501525b      	mov	21083,#1
  75                     ; 86   TIM1->CCER1 = TIM1_CCER1_RESET_VALUE;
  77  0030 725f525c      	clr	21084
  78                     ; 87   TIM1->CCER2 = TIM1_CCER2_RESET_VALUE;
  80  0034 725f525d      	clr	21085
  81                     ; 88   TIM1->CCMR1 = TIM1_CCMR1_RESET_VALUE;
  83  0038 725f5258      	clr	21080
  84                     ; 89   TIM1->CCMR2 = TIM1_CCMR2_RESET_VALUE;
  86  003c 725f5259      	clr	21081
  87                     ; 90   TIM1->CCMR3 = TIM1_CCMR3_RESET_VALUE;
  89  0040 725f525a      	clr	21082
  90                     ; 91   TIM1->CCMR4 = TIM1_CCMR4_RESET_VALUE;
  92  0044 725f525b      	clr	21083
  93                     ; 92   TIM1->CNTRH = TIM1_CNTRH_RESET_VALUE;
  95  0048 725f525e      	clr	21086
  96                     ; 93   TIM1->CNTRL = TIM1_CNTRL_RESET_VALUE;
  98  004c 725f525f      	clr	21087
  99                     ; 94   TIM1->PSCRH = TIM1_PSCRH_RESET_VALUE;
 101  0050 725f5260      	clr	21088
 102                     ; 95   TIM1->PSCRL = TIM1_PSCRL_RESET_VALUE;
 104  0054 725f5261      	clr	21089
 105                     ; 96   TIM1->ARRH  = TIM1_ARRH_RESET_VALUE;
 107  0058 35ff5262      	mov	21090,#255
 108                     ; 97   TIM1->ARRL  = TIM1_ARRL_RESET_VALUE;
 110  005c 35ff5263      	mov	21091,#255
 111                     ; 98   TIM1->CCR1H = TIM1_CCR1H_RESET_VALUE;
 113  0060 725f5265      	clr	21093
 114                     ; 99   TIM1->CCR1L = TIM1_CCR1L_RESET_VALUE;
 116  0064 725f5266      	clr	21094
 117                     ; 100   TIM1->CCR2H = TIM1_CCR2H_RESET_VALUE;
 119  0068 725f5267      	clr	21095
 120                     ; 101   TIM1->CCR2L = TIM1_CCR2L_RESET_VALUE;
 122  006c 725f5268      	clr	21096
 123                     ; 102   TIM1->CCR3H = TIM1_CCR3H_RESET_VALUE;
 125  0070 725f5269      	clr	21097
 126                     ; 103   TIM1->CCR3L = TIM1_CCR3L_RESET_VALUE;
 128  0074 725f526a      	clr	21098
 129                     ; 104   TIM1->CCR4H = TIM1_CCR4H_RESET_VALUE;
 131  0078 725f526b      	clr	21099
 132                     ; 105   TIM1->CCR4L = TIM1_CCR4L_RESET_VALUE;
 134  007c 725f526c      	clr	21100
 135                     ; 106   TIM1->OISR  = TIM1_OISR_RESET_VALUE;
 137  0080 725f526f      	clr	21103
 138                     ; 107   TIM1->EGR   = 0x01; /* TIM1_EGR_UG */
 140  0084 35015257      	mov	21079,#1
 141                     ; 108   TIM1->DTR   = TIM1_DTR_RESET_VALUE;
 143  0088 725f526e      	clr	21102
 144                     ; 109   TIM1->BKR   = TIM1_BKR_RESET_VALUE;
 146  008c 725f526d      	clr	21101
 147                     ; 110   TIM1->RCR   = TIM1_RCR_RESET_VALUE;
 149  0090 725f5264      	clr	21092
 150                     ; 111   TIM1->SR1   = TIM1_SR1_RESET_VALUE;
 152  0094 725f5255      	clr	21077
 153                     ; 112 }
 156  0098 81            	ret
 265                     ; 135 void TIM1_TimeBaseInit(u16 TIM1_Prescaler,
 265                     ; 136                        TIM1_CounterMode_TypeDef TIM1_CounterMode,
 265                     ; 137                        u16 TIM1_Period,
 265                     ; 138                        u8 TIM1_RepetitionCounter)
 265                     ; 139 {
 266                     .text:	section	.text,new
 267  0000               _TIM1_TimeBaseInit:
 269  0000 89            	pushw	x
 270       00000000      OFST:	set	0
 273                     ; 142   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
 275                     ; 145   TIM1->ARRH = (u8)(TIM1_Period >> 8);
 277  0001 7b06          	ld	a,(OFST+6,sp)
 278  0003 c75262        	ld	21090,a
 279                     ; 146   TIM1->ARRL = (u8)(TIM1_Period);
 281  0006 7b07          	ld	a,(OFST+7,sp)
 282  0008 c75263        	ld	21091,a
 283                     ; 149   TIM1->PSCRH = (u8)(TIM1_Prescaler >> 8);
 285  000b 9e            	ld	a,xh
 286  000c c75260        	ld	21088,a
 287                     ; 150   TIM1->PSCRL = (u8)(TIM1_Prescaler);
 289  000f 9f            	ld	a,xl
 290  0010 c75261        	ld	21089,a
 291                     ; 153   TIM1->CR1 = (u8)(((TIM1->CR1) & (u8)(~(TIM1_CR1_CMS | TIM1_CR1_DIR))) | (u8)(TIM1_CounterMode));
 293  0013 c65250        	ld	a,21072
 294  0016 a48f          	and	a,#143
 295  0018 1a05          	or	a,(OFST+5,sp)
 296  001a c75250        	ld	21072,a
 297                     ; 156   TIM1->RCR = TIM1_RepetitionCounter;
 299  001d 7b08          	ld	a,(OFST+8,sp)
 300  001f c75264        	ld	21092,a
 301                     ; 158 }
 304  0022 85            	popw	x
 305  0023 81            	ret
 590                     ; 189 void TIM1_OC1Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 590                     ; 190                   TIM1_OutputState_TypeDef TIM1_OutputState,
 590                     ; 191                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 590                     ; 192                   u16 TIM1_Pulse,
 590                     ; 193                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 590                     ; 194                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 590                     ; 195                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 590                     ; 196                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 590                     ; 197 {
 591                     .text:	section	.text,new
 592  0000               _TIM1_OC1Init:
 594  0000 89            	pushw	x
 595  0001 5203          	subw	sp,#3
 596       00000003      OFST:	set	3
 599                     ; 199   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 601                     ; 200   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 603                     ; 201   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 605                     ; 202   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 607                     ; 203   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 609                     ; 204   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 611                     ; 205   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 613                     ; 208   TIM1->CCER1 &= (u8)(~( TIM1_CCER1_CC1E | TIM1_CCER1_CC1NE | TIM1_CCER1_CC1P | TIM1_CCER1_CC1NP));
 615  0003 c6525c        	ld	a,21084
 616  0006 a4f0          	and	a,#240
 617  0008 c7525c        	ld	21084,a
 618                     ; 210   TIM1->CCER1 |= (u8)((TIM1_OutputState & TIM1_CCER1_CC1E  ) | (TIM1_OutputNState & TIM1_CCER1_CC1NE ) | (TIM1_OCPolarity  & TIM1_CCER1_CC1P  ) | (TIM1_OCNPolarity & TIM1_CCER1_CC1NP ));
 620  000b 7b0c          	ld	a,(OFST+9,sp)
 621  000d a408          	and	a,#8
 622  000f 6b03          	ld	(OFST+0,sp),a
 623  0011 7b0b          	ld	a,(OFST+8,sp)
 624  0013 a402          	and	a,#2
 625  0015 6b02          	ld	(OFST-1,sp),a
 626  0017 7b08          	ld	a,(OFST+5,sp)
 627  0019 a404          	and	a,#4
 628  001b 6b01          	ld	(OFST-2,sp),a
 629  001d 9f            	ld	a,xl
 630  001e a401          	and	a,#1
 631  0020 1a01          	or	a,(OFST-2,sp)
 632  0022 1a02          	or	a,(OFST-1,sp)
 633  0024 1a03          	or	a,(OFST+0,sp)
 634  0026 ca525c        	or	a,21084
 635  0029 c7525c        	ld	21084,a
 636                     ; 213   TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
 638  002c c65258        	ld	a,21080
 639  002f a48f          	and	a,#143
 640  0031 1a04          	or	a,(OFST+1,sp)
 641  0033 c75258        	ld	21080,a
 642                     ; 216   TIM1->OISR &= (u8)(~(TIM1_OISR_OIS1 | TIM1_OISR_OIS1N));
 644  0036 c6526f        	ld	a,21103
 645  0039 a4fc          	and	a,#252
 646  003b c7526f        	ld	21103,a
 647                     ; 218   TIM1->OISR |= (u8)(( TIM1_OCIdleState & TIM1_OISR_OIS1 ) | ( TIM1_OCNIdleState & TIM1_OISR_OIS1N ));
 649  003e 7b0e          	ld	a,(OFST+11,sp)
 650  0040 a402          	and	a,#2
 651  0042 6b03          	ld	(OFST+0,sp),a
 652  0044 7b0d          	ld	a,(OFST+10,sp)
 653  0046 a401          	and	a,#1
 654  0048 1a03          	or	a,(OFST+0,sp)
 655  004a ca526f        	or	a,21103
 656  004d c7526f        	ld	21103,a
 657                     ; 221   TIM1->CCR1H = (u8)(TIM1_Pulse >> 8);
 659  0050 7b09          	ld	a,(OFST+6,sp)
 660  0052 c75265        	ld	21093,a
 661                     ; 222   TIM1->CCR1L = (u8)(TIM1_Pulse);
 663  0055 7b0a          	ld	a,(OFST+7,sp)
 664  0057 c75266        	ld	21094,a
 665                     ; 223 }
 668  005a 5b05          	addw	sp,#5
 669  005c 81            	ret
 773                     ; 254 void TIM1_OC2Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 773                     ; 255                   TIM1_OutputState_TypeDef TIM1_OutputState,
 773                     ; 256                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 773                     ; 257                   u16 TIM1_Pulse,
 773                     ; 258                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 773                     ; 259                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 773                     ; 260                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 773                     ; 261                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 773                     ; 262 {
 774                     .text:	section	.text,new
 775  0000               _TIM1_OC2Init:
 777  0000 89            	pushw	x
 778  0001 5203          	subw	sp,#3
 779       00000003      OFST:	set	3
 782                     ; 266   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 784                     ; 267   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 786                     ; 268   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 788                     ; 269   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 790                     ; 270   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 792                     ; 271   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 794                     ; 272   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 796                     ; 275   TIM1->CCER1 &= (u8)(~( TIM1_CCER1_CC2E | TIM1_CCER1_CC2NE | TIM1_CCER1_CC2P | TIM1_CCER1_CC2NP));
 798  0003 c6525c        	ld	a,21084
 799  0006 a40f          	and	a,#15
 800  0008 c7525c        	ld	21084,a
 801                     ; 277   TIM1->CCER1 |= (u8)((TIM1_OutputState & TIM1_CCER1_CC2E  ) | (TIM1_OutputNState & TIM1_CCER1_CC2NE ) | (TIM1_OCPolarity  & TIM1_CCER1_CC2P  ) | (TIM1_OCNPolarity & TIM1_CCER1_CC2NP ));
 803  000b 7b0c          	ld	a,(OFST+9,sp)
 804  000d a480          	and	a,#128
 805  000f 6b03          	ld	(OFST+0,sp),a
 806  0011 7b0b          	ld	a,(OFST+8,sp)
 807  0013 a420          	and	a,#32
 808  0015 6b02          	ld	(OFST-1,sp),a
 809  0017 7b08          	ld	a,(OFST+5,sp)
 810  0019 a440          	and	a,#64
 811  001b 6b01          	ld	(OFST-2,sp),a
 812  001d 9f            	ld	a,xl
 813  001e a410          	and	a,#16
 814  0020 1a01          	or	a,(OFST-2,sp)
 815  0022 1a02          	or	a,(OFST-1,sp)
 816  0024 1a03          	or	a,(OFST+0,sp)
 817  0026 ca525c        	or	a,21084
 818  0029 c7525c        	ld	21084,a
 819                     ; 281   TIM1->CCMR2 = (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
 821  002c c65259        	ld	a,21081
 822  002f a48f          	and	a,#143
 823  0031 1a04          	or	a,(OFST+1,sp)
 824  0033 c75259        	ld	21081,a
 825                     ; 284   TIM1->OISR &= (u8)(~(TIM1_OISR_OIS2 | TIM1_OISR_OIS2N));
 827  0036 c6526f        	ld	a,21103
 828  0039 a4f3          	and	a,#243
 829  003b c7526f        	ld	21103,a
 830                     ; 286   TIM1->OISR |= (u8)((TIM1_OISR_OIS2 & TIM1_OCIdleState) | (TIM1_OISR_OIS2N & TIM1_OCNIdleState));
 832  003e 7b0e          	ld	a,(OFST+11,sp)
 833  0040 a408          	and	a,#8
 834  0042 6b03          	ld	(OFST+0,sp),a
 835  0044 7b0d          	ld	a,(OFST+10,sp)
 836  0046 a404          	and	a,#4
 837  0048 1a03          	or	a,(OFST+0,sp)
 838  004a ca526f        	or	a,21103
 839  004d c7526f        	ld	21103,a
 840                     ; 289   TIM1->CCR2H = (u8)(TIM1_Pulse >> 8);
 842  0050 7b09          	ld	a,(OFST+6,sp)
 843  0052 c75267        	ld	21095,a
 844                     ; 290   TIM1->CCR2L = (u8)(TIM1_Pulse);
 846  0055 7b0a          	ld	a,(OFST+7,sp)
 847  0057 c75268        	ld	21096,a
 848                     ; 292 }
 851  005a 5b05          	addw	sp,#5
 852  005c 81            	ret
 956                     ; 323 void TIM1_OC3Init(TIM1_OCMode_TypeDef TIM1_OCMode,
 956                     ; 324                   TIM1_OutputState_TypeDef TIM1_OutputState,
 956                     ; 325                   TIM1_OutputNState_TypeDef TIM1_OutputNState,
 956                     ; 326                   u16 TIM1_Pulse,
 956                     ; 327                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
 956                     ; 328                   TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity,
 956                     ; 329                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState,
 956                     ; 330                   TIM1_OCNIdleState_TypeDef TIM1_OCNIdleState)
 956                     ; 331 {
 957                     .text:	section	.text,new
 958  0000               _TIM1_OC3Init:
 960  0000 89            	pushw	x
 961  0001 5203          	subw	sp,#3
 962       00000003      OFST:	set	3
 965                     ; 334   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
 967                     ; 335   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
 969                     ; 336   assert_param(IS_TIM1_OUTPUTN_STATE_OK(TIM1_OutputNState));
 971                     ; 337   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
 973                     ; 338   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
 975                     ; 339   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
 977                     ; 340   assert_param(IS_TIM1_OCNIDLE_STATE_OK(TIM1_OCNIdleState));
 979                     ; 343   TIM1->CCER2 &= (u8)(~( TIM1_CCER2_CC3E | TIM1_CCER2_CC3NE | TIM1_CCER2_CC3P | TIM1_CCER2_CC3NP));
 981  0003 c6525d        	ld	a,21085
 982  0006 a4f0          	and	a,#240
 983  0008 c7525d        	ld	21085,a
 984                     ; 345   TIM1->CCER2 |= (u8)((TIM1_OutputState  & TIM1_CCER2_CC3E   ) |                 (TIM1_OutputNState & TIM1_CCER2_CC3NE  ) | (TIM1_OCPolarity   & TIM1_CCER2_CC3P   ) | (TIM1_OCNPolarity  & TIM1_CCER2_CC3NP  ));
 986  000b 7b0c          	ld	a,(OFST+9,sp)
 987  000d a408          	and	a,#8
 988  000f 6b03          	ld	(OFST+0,sp),a
 989  0011 7b0b          	ld	a,(OFST+8,sp)
 990  0013 a402          	and	a,#2
 991  0015 6b02          	ld	(OFST-1,sp),a
 992  0017 7b08          	ld	a,(OFST+5,sp)
 993  0019 a404          	and	a,#4
 994  001b 6b01          	ld	(OFST-2,sp),a
 995  001d 9f            	ld	a,xl
 996  001e a401          	and	a,#1
 997  0020 1a01          	or	a,(OFST-2,sp)
 998  0022 1a02          	or	a,(OFST-1,sp)
 999  0024 1a03          	or	a,(OFST+0,sp)
1000  0026 ca525d        	or	a,21085
1001  0029 c7525d        	ld	21085,a
1002                     ; 350   TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
1004  002c c6525a        	ld	a,21082
1005  002f a48f          	and	a,#143
1006  0031 1a04          	or	a,(OFST+1,sp)
1007  0033 c7525a        	ld	21082,a
1008                     ; 353   TIM1->OISR &= (u8)(~(TIM1_OISR_OIS3 | TIM1_OISR_OIS3N));
1010  0036 c6526f        	ld	a,21103
1011  0039 a4cf          	and	a,#207
1012  003b c7526f        	ld	21103,a
1013                     ; 355   TIM1->OISR |= (u8)((TIM1_OISR_OIS3 & TIM1_OCIdleState) | (TIM1_OISR_OIS3N & TIM1_OCNIdleState));
1015  003e 7b0e          	ld	a,(OFST+11,sp)
1016  0040 a420          	and	a,#32
1017  0042 6b03          	ld	(OFST+0,sp),a
1018  0044 7b0d          	ld	a,(OFST+10,sp)
1019  0046 a410          	and	a,#16
1020  0048 1a03          	or	a,(OFST+0,sp)
1021  004a ca526f        	or	a,21103
1022  004d c7526f        	ld	21103,a
1023                     ; 358   TIM1->CCR3H = (u8)(TIM1_Pulse >> 8);
1025  0050 7b09          	ld	a,(OFST+6,sp)
1026  0052 c75269        	ld	21097,a
1027                     ; 359   TIM1->CCR3L = (u8)(TIM1_Pulse);
1029  0055 7b0a          	ld	a,(OFST+7,sp)
1030  0057 c7526a        	ld	21098,a
1031                     ; 361 }
1034  005a 5b05          	addw	sp,#5
1035  005c 81            	ret
1109                     ; 386 void TIM1_OC4Init(TIM1_OCMode_TypeDef TIM1_OCMode,
1109                     ; 387                   TIM1_OutputState_TypeDef TIM1_OutputState,
1109                     ; 388                   u16 TIM1_Pulse,
1109                     ; 389                   TIM1_OCPolarity_TypeDef TIM1_OCPolarity,
1109                     ; 390                   TIM1_OCIdleState_TypeDef TIM1_OCIdleState)
1109                     ; 391 {
1110                     .text:	section	.text,new
1111  0000               _TIM1_OC4Init:
1113  0000 89            	pushw	x
1114  0001 88            	push	a
1115       00000001      OFST:	set	1
1118                     ; 394   assert_param(IS_TIM1_OC_MODE_OK(TIM1_OCMode));
1120                     ; 395   assert_param(IS_TIM1_OUTPUT_STATE_OK(TIM1_OutputState));
1122                     ; 396   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
1124                     ; 397   assert_param(IS_TIM1_OCIDLE_STATE_OK(TIM1_OCIdleState));
1126                     ; 402   TIM1->CCER2 &= (u8)(~(TIM1_CCER2_CC4E | TIM1_CCER2_CC4P));
1128  0002 c6525d        	ld	a,21085
1129  0005 a4cf          	and	a,#207
1130  0007 c7525d        	ld	21085,a
1131                     ; 404   TIM1->CCER2 |= (u8)((TIM1_OutputState & TIM1_CCER2_CC4E ) |  (TIM1_OCPolarity  & TIM1_CCER2_CC4P ));
1133  000a 7b08          	ld	a,(OFST+7,sp)
1134  000c a420          	and	a,#32
1135  000e 6b01          	ld	(OFST+0,sp),a
1136  0010 9f            	ld	a,xl
1137  0011 a410          	and	a,#16
1138  0013 1a01          	or	a,(OFST+0,sp)
1139  0015 ca525d        	or	a,21085
1140  0018 c7525d        	ld	21085,a
1141                     ; 407   TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_OCM)) | (TIM1_OCMode));
1143  001b c6525b        	ld	a,21083
1144  001e a48f          	and	a,#143
1145  0020 1a02          	or	a,(OFST+1,sp)
1146  0022 c7525b        	ld	21083,a
1147                     ; 410   if (TIM1_OCIdleState != TIM1_OCIDLESTATE_RESET)
1149  0025 0d09          	tnz	(OFST+8,sp)
1150  0027 270a          	jreq	L534
1151                     ; 412     TIM1->OISR |= (u8)(~TIM1_CCER2_CC4P);
1153  0029 c6526f        	ld	a,21103
1154  002c aadf          	or	a,#223
1155  002e c7526f        	ld	21103,a
1157  0031 2004          	jra	L734
1158  0033               L534:
1159                     ; 416     TIM1->OISR &= (u8)(~TIM1_OISR_OIS4);
1161  0033 721d526f      	bres	21103,#6
1162  0037               L734:
1163                     ; 420   TIM1->CCR4H = (u8)(TIM1_Pulse >> 8);
1165  0037 7b06          	ld	a,(OFST+5,sp)
1166  0039 c7526b        	ld	21099,a
1167                     ; 421   TIM1->CCR4L = (u8)(TIM1_Pulse);
1169  003c 7b07          	ld	a,(OFST+6,sp)
1170  003e c7526c        	ld	21100,a
1171                     ; 423 }
1174  0041 5b03          	addw	sp,#3
1175  0043 81            	ret
1380                     ; 451 void TIM1_BDTRConfig(TIM1_OSSIState_TypeDef TIM1_OSSIState,
1380                     ; 452                      TIM1_LockLevel_TypeDef TIM1_LockLevel,
1380                     ; 453                      u8 TIM1_DeadTime,
1380                     ; 454                      TIM1_BreakState_TypeDef TIM1_Break,
1380                     ; 455                      TIM1_BreakPolarity_TypeDef TIM1_BreakPolarity,
1380                     ; 456                      TIM1_AutomaticOutput_TypeDef TIM1_AutomaticOutput)
1380                     ; 457 {
1381                     .text:	section	.text,new
1382  0000               _TIM1_BDTRConfig:
1384  0000 89            	pushw	x
1385       00000000      OFST:	set	0
1388                     ; 461   assert_param(IS_TIM1_OSSI_STATE_OK(TIM1_OSSIState));
1390                     ; 462   assert_param(IS_TIM1_LOCK_LEVEL_OK(TIM1_LockLevel));
1392                     ; 463   assert_param(IS_TIM1_BREAK_STATE_OK(TIM1_Break));
1394                     ; 464   assert_param(IS_TIM1_BREAK_POLARITY_OK(TIM1_BreakPolarity));
1396                     ; 465   assert_param(IS_TIM1_AUTOMATIC_OUTPUT_STATE_OK(TIM1_AutomaticOutput));
1398                     ; 468   TIM1->DTR = (u8)(TIM1_DeadTime);
1400  0001 7b05          	ld	a,(OFST+5,sp)
1401  0003 c7526e        	ld	21102,a
1402                     ; 472   TIM1->BKR  =  (u8)((u8)TIM1_OSSIState       | \
1402                     ; 473                      (u8)TIM1_LockLevel       | \
1402                     ; 474                      (u8)TIM1_Break           | \
1402                     ; 475                      (u8)TIM1_BreakPolarity   | \
1402                     ; 476                      (u8)TIM1_AutomaticOutput);
1404  0006 9f            	ld	a,xl
1405  0007 1a01          	or	a,(OFST+1,sp)
1406  0009 1a06          	or	a,(OFST+6,sp)
1407  000b 1a07          	or	a,(OFST+7,sp)
1408  000d 1a08          	or	a,(OFST+8,sp)
1409  000f c7526d        	ld	21101,a
1410                     ; 478 }
1413  0012 85            	popw	x
1414  0013 81            	ret
1616                     ; 511 void TIM1_ICInit(TIM1_Channel_TypeDef TIM1_Channel,
1616                     ; 512                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1616                     ; 513                  TIM1_ICSelection_TypeDef TIM1_ICSelection,
1616                     ; 514                  TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1616                     ; 515                  u8 TIM1_ICFilter)
1616                     ; 516 {
1617                     .text:	section	.text,new
1618  0000               _TIM1_ICInit:
1620  0000 89            	pushw	x
1621       00000000      OFST:	set	0
1624                     ; 519   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
1626                     ; 520   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1628                     ; 521   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1630                     ; 522   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1632                     ; 523   assert_param(IS_TIM1_IC_FILTER_OK(TIM1_ICFilter));
1634                     ; 525   if (TIM1_Channel == TIM1_CHANNEL_1)
1636  0001 9e            	ld	a,xh
1637  0002 4d            	tnz	a
1638  0003 2614          	jrne	L766
1639                     ; 528     TI1_Config(TIM1_ICPolarity,
1639                     ; 529                TIM1_ICSelection,
1639                     ; 530                TIM1_ICFilter);
1641  0005 7b07          	ld	a,(OFST+7,sp)
1642  0007 88            	push	a
1643  0008 7b06          	ld	a,(OFST+6,sp)
1644  000a 97            	ld	xl,a
1645  000b 7b03          	ld	a,(OFST+3,sp)
1646  000d 95            	ld	xh,a
1647  000e cd0000        	call	L3_TI1_Config
1649  0011 84            	pop	a
1650                     ; 532     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1652  0012 7b06          	ld	a,(OFST+6,sp)
1653  0014 cd0000        	call	_TIM1_SetIC1Prescaler
1656  0017 2046          	jra	L176
1657  0019               L766:
1658                     ; 534   else if (TIM1_Channel == TIM1_CHANNEL_2)
1660  0019 7b01          	ld	a,(OFST+1,sp)
1661  001b a101          	cp	a,#1
1662  001d 2614          	jrne	L376
1663                     ; 537     TI2_Config(TIM1_ICPolarity,
1663                     ; 538                TIM1_ICSelection,
1663                     ; 539                TIM1_ICFilter);
1665  001f 7b07          	ld	a,(OFST+7,sp)
1666  0021 88            	push	a
1667  0022 7b06          	ld	a,(OFST+6,sp)
1668  0024 97            	ld	xl,a
1669  0025 7b03          	ld	a,(OFST+3,sp)
1670  0027 95            	ld	xh,a
1671  0028 cd0000        	call	L5_TI2_Config
1673  002b 84            	pop	a
1674                     ; 541     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1676  002c 7b06          	ld	a,(OFST+6,sp)
1677  002e cd0000        	call	_TIM1_SetIC2Prescaler
1680  0031 202c          	jra	L176
1681  0033               L376:
1682                     ; 543   else if (TIM1_Channel == TIM1_CHANNEL_3)
1684  0033 7b01          	ld	a,(OFST+1,sp)
1685  0035 a102          	cp	a,#2
1686  0037 2614          	jrne	L776
1687                     ; 546     TI3_Config(TIM1_ICPolarity,
1687                     ; 547                TIM1_ICSelection,
1687                     ; 548                TIM1_ICFilter);
1689  0039 7b07          	ld	a,(OFST+7,sp)
1690  003b 88            	push	a
1691  003c 7b06          	ld	a,(OFST+6,sp)
1692  003e 97            	ld	xl,a
1693  003f 7b03          	ld	a,(OFST+3,sp)
1694  0041 95            	ld	xh,a
1695  0042 cd0000        	call	L7_TI3_Config
1697  0045 84            	pop	a
1698                     ; 550     TIM1_SetIC3Prescaler(TIM1_ICPrescaler);
1700  0046 7b06          	ld	a,(OFST+6,sp)
1701  0048 cd0000        	call	_TIM1_SetIC3Prescaler
1704  004b 2012          	jra	L176
1705  004d               L776:
1706                     ; 555     TI4_Config(TIM1_ICPolarity,
1706                     ; 556                TIM1_ICSelection,
1706                     ; 557                TIM1_ICFilter);
1708  004d 7b07          	ld	a,(OFST+7,sp)
1709  004f 88            	push	a
1710  0050 7b06          	ld	a,(OFST+6,sp)
1711  0052 97            	ld	xl,a
1712  0053 7b03          	ld	a,(OFST+3,sp)
1713  0055 95            	ld	xh,a
1714  0056 cd0000        	call	L11_TI4_Config
1716  0059 84            	pop	a
1717                     ; 559     TIM1_SetIC4Prescaler(TIM1_ICPrescaler);
1719  005a 7b06          	ld	a,(OFST+6,sp)
1720  005c cd0000        	call	_TIM1_SetIC4Prescaler
1722  005f               L176:
1723                     ; 562 }
1726  005f 85            	popw	x
1727  0060 81            	ret
1823                     ; 590 void TIM1_PWMIConfig(TIM1_Channel_TypeDef TIM1_Channel,
1823                     ; 591                      TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
1823                     ; 592                      TIM1_ICSelection_TypeDef TIM1_ICSelection,
1823                     ; 593                      TIM1_ICPSC_TypeDef TIM1_ICPrescaler,
1823                     ; 594                      u8 TIM1_ICFilter)
1823                     ; 595 {
1824                     .text:	section	.text,new
1825  0000               _TIM1_PWMIConfig:
1827  0000 89            	pushw	x
1828  0001 89            	pushw	x
1829       00000002      OFST:	set	2
1832                     ; 596   u8 icpolarity = TIM1_ICPOLARITY_RISING;
1834  0002 7b01          	ld	a,(OFST-1,sp)
1835  0004 97            	ld	xl,a
1836                     ; 597   u8 icselection = TIM1_ICSELECTION_DIRECTTI;
1838  0005 7b02          	ld	a,(OFST+0,sp)
1839  0007 97            	ld	xl,a
1840                     ; 600   assert_param(IS_TIM1_PWMI_CHANNEL_OK(TIM1_Channel));
1842                     ; 601   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
1844                     ; 602   assert_param(IS_TIM1_IC_SELECTION_OK(TIM1_ICSelection));
1846                     ; 603   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_ICPrescaler));
1848                     ; 606   if (TIM1_ICPolarity != TIM1_ICPOLARITY_FALLING)
1850  0008 7b04          	ld	a,(OFST+2,sp)
1851  000a a101          	cp	a,#1
1852  000c 2706          	jreq	L157
1853                     ; 608     icpolarity = TIM1_ICPOLARITY_FALLING;
1855  000e a601          	ld	a,#1
1856  0010 6b01          	ld	(OFST-1,sp),a
1858  0012 2002          	jra	L357
1859  0014               L157:
1860                     ; 612     icpolarity = TIM1_ICPOLARITY_RISING;
1862  0014 0f01          	clr	(OFST-1,sp)
1863  0016               L357:
1864                     ; 616   if (TIM1_ICSelection == TIM1_ICSELECTION_DIRECTTI)
1866  0016 7b07          	ld	a,(OFST+5,sp)
1867  0018 a101          	cp	a,#1
1868  001a 2606          	jrne	L557
1869                     ; 618     icselection = TIM1_ICSELECTION_INDIRECTTI;
1871  001c a602          	ld	a,#2
1872  001e 6b02          	ld	(OFST+0,sp),a
1874  0020 2004          	jra	L757
1875  0022               L557:
1876                     ; 622     icselection = TIM1_ICSELECTION_DIRECTTI;
1878  0022 a601          	ld	a,#1
1879  0024 6b02          	ld	(OFST+0,sp),a
1880  0026               L757:
1881                     ; 625   if (TIM1_Channel == TIM1_CHANNEL_1)
1883  0026 0d03          	tnz	(OFST+1,sp)
1884  0028 2626          	jrne	L167
1885                     ; 628     TI1_Config(TIM1_ICPolarity, TIM1_ICSelection,
1885                     ; 629                TIM1_ICFilter);
1887  002a 7b09          	ld	a,(OFST+7,sp)
1888  002c 88            	push	a
1889  002d 7b08          	ld	a,(OFST+6,sp)
1890  002f 97            	ld	xl,a
1891  0030 7b05          	ld	a,(OFST+3,sp)
1892  0032 95            	ld	xh,a
1893  0033 cd0000        	call	L3_TI1_Config
1895  0036 84            	pop	a
1896                     ; 632     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1898  0037 7b08          	ld	a,(OFST+6,sp)
1899  0039 cd0000        	call	_TIM1_SetIC1Prescaler
1901                     ; 635     TI2_Config(icpolarity, icselection, TIM1_ICFilter);
1903  003c 7b09          	ld	a,(OFST+7,sp)
1904  003e 88            	push	a
1905  003f 7b03          	ld	a,(OFST+1,sp)
1906  0041 97            	ld	xl,a
1907  0042 7b02          	ld	a,(OFST+0,sp)
1908  0044 95            	ld	xh,a
1909  0045 cd0000        	call	L5_TI2_Config
1911  0048 84            	pop	a
1912                     ; 638     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1914  0049 7b08          	ld	a,(OFST+6,sp)
1915  004b cd0000        	call	_TIM1_SetIC2Prescaler
1918  004e 2024          	jra	L367
1919  0050               L167:
1920                     ; 643     TI2_Config(TIM1_ICPolarity, TIM1_ICSelection,
1920                     ; 644                TIM1_ICFilter);
1922  0050 7b09          	ld	a,(OFST+7,sp)
1923  0052 88            	push	a
1924  0053 7b08          	ld	a,(OFST+6,sp)
1925  0055 97            	ld	xl,a
1926  0056 7b05          	ld	a,(OFST+3,sp)
1927  0058 95            	ld	xh,a
1928  0059 cd0000        	call	L5_TI2_Config
1930  005c 84            	pop	a
1931                     ; 647     TIM1_SetIC2Prescaler(TIM1_ICPrescaler);
1933  005d 7b08          	ld	a,(OFST+6,sp)
1934  005f cd0000        	call	_TIM1_SetIC2Prescaler
1936                     ; 650     TI1_Config(icpolarity, icselection, TIM1_ICFilter);
1938  0062 7b09          	ld	a,(OFST+7,sp)
1939  0064 88            	push	a
1940  0065 7b03          	ld	a,(OFST+1,sp)
1941  0067 97            	ld	xl,a
1942  0068 7b02          	ld	a,(OFST+0,sp)
1943  006a 95            	ld	xh,a
1944  006b cd0000        	call	L3_TI1_Config
1946  006e 84            	pop	a
1947                     ; 653     TIM1_SetIC1Prescaler(TIM1_ICPrescaler);
1949  006f 7b08          	ld	a,(OFST+6,sp)
1950  0071 cd0000        	call	_TIM1_SetIC1Prescaler
1952  0074               L367:
1953                     ; 655 }
1956  0074 5b04          	addw	sp,#4
1957  0076 81            	ret
2012                     ; 673 void TIM1_Cmd(FunctionalState NewState)
2012                     ; 674 {
2013                     .text:	section	.text,new
2014  0000               _TIM1_Cmd:
2018                     ; 676   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2020                     ; 679   if (NewState != DISABLE)
2022  0000 4d            	tnz	a
2023  0001 2706          	jreq	L3101
2024                     ; 681     TIM1->CR1 |= TIM1_CR1_CEN;
2026  0003 72105250      	bset	21072,#0
2028  0007 2004          	jra	L5101
2029  0009               L3101:
2030                     ; 685     TIM1->CR1 &= (u8)(~TIM1_CR1_CEN);
2032  0009 72115250      	bres	21072,#0
2033  000d               L5101:
2034                     ; 687 }
2037  000d 81            	ret
2073                     ; 705 void TIM1_CtrlPWMOutputs(FunctionalState NewState)
2073                     ; 706 {
2074                     .text:	section	.text,new
2075  0000               _TIM1_CtrlPWMOutputs:
2079                     ; 708   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2081                     ; 712   if (NewState != DISABLE)
2083  0000 4d            	tnz	a
2084  0001 2706          	jreq	L5301
2085                     ; 714     TIM1->BKR |= TIM1_BKR_MOE;
2087  0003 721e526d      	bset	21101,#7
2089  0007 2004          	jra	L7301
2090  0009               L5301:
2091                     ; 718     TIM1->BKR &= (u8)(~TIM1_BKR_MOE);
2093  0009 721f526d      	bres	21101,#7
2094  000d               L7301:
2095                     ; 720 }
2098  000d 81            	ret
2205                     ; 749 void TIM1_ITConfig(TIM1_IT_TypeDef  TIM1_IT, FunctionalState NewState)
2205                     ; 750 {
2206                     .text:	section	.text,new
2207  0000               _TIM1_ITConfig:
2209  0000 89            	pushw	x
2210       00000000      OFST:	set	0
2213                     ; 752   assert_param(IS_TIM1_IT_OK(TIM1_IT));
2215                     ; 753   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2217                     ; 755   if (NewState != DISABLE)
2219  0001 9f            	ld	a,xl
2220  0002 4d            	tnz	a
2221  0003 2709          	jreq	L7011
2222                     ; 758     TIM1->IER |= (u8)TIM1_IT;
2224  0005 9e            	ld	a,xh
2225  0006 ca5254        	or	a,21076
2226  0009 c75254        	ld	21076,a
2228  000c 2009          	jra	L1111
2229  000e               L7011:
2230                     ; 763     TIM1->IER &= (u8)(~(u8)TIM1_IT);
2232  000e 7b01          	ld	a,(OFST+1,sp)
2233  0010 43            	cpl	a
2234  0011 c45254        	and	a,21076
2235  0014 c75254        	ld	21076,a
2236  0017               L1111:
2237                     ; 765 }
2240  0017 85            	popw	x
2241  0018 81            	ret
2265                     ; 783 void TIM1_InternalClockConfig(void)
2265                     ; 784 {
2266                     .text:	section	.text,new
2267  0000               _TIM1_InternalClockConfig:
2271                     ; 786   TIM1->SMCR &= (u8)(~TIM1_SMCR_SMS);
2273  0000 c65252        	ld	a,21074
2274  0003 a4f8          	and	a,#248
2275  0005 c75252        	ld	21074,a
2276                     ; 787 }
2279  0008 81            	ret
2396                     ; 815 void TIM1_ETRClockMode1Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2396                     ; 816                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2396                     ; 817                               u8 ExtTRGFilter)
2396                     ; 818 {
2397                     .text:	section	.text,new
2398  0000               _TIM1_ETRClockMode1Config:
2400  0000 89            	pushw	x
2401       00000000      OFST:	set	0
2404                     ; 820   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2406                     ; 821   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2408                     ; 824   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2410  0001 7b05          	ld	a,(OFST+5,sp)
2411  0003 88            	push	a
2412  0004 9f            	ld	a,xl
2413  0005 97            	ld	xl,a
2414  0006 7b02          	ld	a,(OFST+2,sp)
2415  0008 95            	ld	xh,a
2416  0009 cd0000        	call	_TIM1_ETRConfig
2418  000c 84            	pop	a
2419                     ; 827   TIM1->SMCR = (u8)((TIM1->SMCR & (u8)(~(TIM1_SMCR_SMS | TIM1_SMCR_TS ))) | (u8)(  TIM1_SLAVEMODE_EXTERNAL1 | TIM1_TS_ETRF ));
2421  000d c65252        	ld	a,21074
2422  0010 a488          	and	a,#136
2423  0012 aa77          	or	a,#119
2424  0014 c75252        	ld	21074,a
2425                     ; 828 }
2428  0017 85            	popw	x
2429  0018 81            	ret
2487                     ; 856 void TIM1_ETRClockMode2Config(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2487                     ; 857                               TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2487                     ; 858                               u8 ExtTRGFilter)
2487                     ; 859 {
2488                     .text:	section	.text,new
2489  0000               _TIM1_ETRClockMode2Config:
2491  0000 89            	pushw	x
2492       00000000      OFST:	set	0
2495                     ; 861   assert_param(IS_TIM1_EXT_PRESCALER_OK(TIM1_ExtTRGPrescaler));
2497                     ; 862   assert_param(IS_TIM1_EXT_POLARITY_OK(TIM1_ExtTRGPolarity));
2499                     ; 865   TIM1_ETRConfig(TIM1_ExtTRGPrescaler, TIM1_ExtTRGPolarity, ExtTRGFilter);
2501  0001 7b05          	ld	a,(OFST+5,sp)
2502  0003 88            	push	a
2503  0004 9f            	ld	a,xl
2504  0005 97            	ld	xl,a
2505  0006 7b02          	ld	a,(OFST+2,sp)
2506  0008 95            	ld	xh,a
2507  0009 cd0000        	call	_TIM1_ETRConfig
2509  000c 84            	pop	a
2510                     ; 868   TIM1->ETR |= TIM1_ETR_ECE;
2512  000d 721c5253      	bset	21075,#6
2513                     ; 869 }
2516  0011 85            	popw	x
2517  0012 81            	ret
2573                     ; 897 void TIM1_ETRConfig(TIM1_ExtTRGPSC_TypeDef TIM1_ExtTRGPrescaler,
2573                     ; 898                     TIM1_ExtTRGPolarity_TypeDef TIM1_ExtTRGPolarity,
2573                     ; 899                     u8 ExtTRGFilter)
2573                     ; 900 {
2574                     .text:	section	.text,new
2575  0000               _TIM1_ETRConfig:
2577  0000 89            	pushw	x
2578       00000000      OFST:	set	0
2581                     ; 902   TIM1->ETR |= (u8)((u8)TIM1_ExtTRGPrescaler |
2581                     ; 903                     (u8)TIM1_ExtTRGPolarity  |
2581                     ; 904                     (u8)ExtTRGFilter          );
2583  0001 9f            	ld	a,xl
2584  0002 1a01          	or	a,(OFST+1,sp)
2585  0004 1a05          	or	a,(OFST+5,sp)
2586  0006 ca5253        	or	a,21075
2587  0009 c75253        	ld	21075,a
2588                     ; 905 }
2591  000c 85            	popw	x
2592  000d 81            	ret
2681                     ; 934 void TIM1_TIxExternalClockConfig(TIM1_TIxExternalCLK1Source_TypeDef TIM1_TIxExternalCLKSource,
2681                     ; 935                                  TIM1_ICPolarity_TypeDef TIM1_ICPolarity,
2681                     ; 936                                  u8 ICFilter)
2681                     ; 937 {
2682                     .text:	section	.text,new
2683  0000               _TIM1_TIxExternalClockConfig:
2685  0000 89            	pushw	x
2686       00000000      OFST:	set	0
2689                     ; 939   assert_param(IS_TIM1_TIXCLK_SOURCE_OK(TIM1_TIxExternalCLKSource));
2691                     ; 940   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_ICPolarity));
2693                     ; 941   assert_param(IS_TIM1_IC_FILTER_OK(ICFilter));
2695                     ; 944   if (TIM1_TIxExternalCLKSource == TIM1_TIXEXTERNALCLK1SOURCE_TI2)
2697  0001 9e            	ld	a,xh
2698  0002 a160          	cp	a,#96
2699  0004 260f          	jrne	L1131
2700                     ; 946     TI2_Config(TIM1_ICPolarity, TIM1_ICSELECTION_DIRECTTI, ICFilter);
2702  0006 7b05          	ld	a,(OFST+5,sp)
2703  0008 88            	push	a
2704  0009 ae0001        	ldw	x,#1
2705  000c 7b03          	ld	a,(OFST+3,sp)
2706  000e 95            	ld	xh,a
2707  000f cd0000        	call	L5_TI2_Config
2709  0012 84            	pop	a
2711  0013 200d          	jra	L3131
2712  0015               L1131:
2713                     ; 950     TI1_Config(TIM1_ICPolarity, TIM1_ICSELECTION_DIRECTTI, ICFilter);
2715  0015 7b05          	ld	a,(OFST+5,sp)
2716  0017 88            	push	a
2717  0018 ae0001        	ldw	x,#1
2718  001b 7b03          	ld	a,(OFST+3,sp)
2719  001d 95            	ld	xh,a
2720  001e cd0000        	call	L3_TI1_Config
2722  0021 84            	pop	a
2723  0022               L3131:
2724                     ; 954   TIM1_SelectInputTrigger(TIM1_TIxExternalCLKSource);
2726  0022 7b01          	ld	a,(OFST+1,sp)
2727  0024 cd0000        	call	_TIM1_SelectInputTrigger
2729                     ; 957   TIM1->SMCR |= (u8)(TIM1_SLAVEMODE_EXTERNAL1);
2731  0027 c65252        	ld	a,21074
2732  002a aa07          	or	a,#7
2733  002c c75252        	ld	21074,a
2734                     ; 958 }
2737  002f 85            	popw	x
2738  0030 81            	ret
2809                     ; 979 void TIM1_SelectInputTrigger(TIM1_TS_TypeDef TIM1_InputTriggerSource)
2809                     ; 980 {
2810                     .text:	section	.text,new
2811  0000               _TIM1_SelectInputTrigger:
2813  0000 88            	push	a
2814       00000000      OFST:	set	0
2817                     ; 982   assert_param(IS_TIM1_TRIGGER_SELECTION_OK(TIM1_InputTriggerSource));
2819                     ; 985   TIM1->SMCR = (u8)((TIM1->SMCR & (u8)(~TIM1_SMCR_TS)) | (u8)TIM1_InputTriggerSource);
2821  0001 c65252        	ld	a,21074
2822  0004 a48f          	and	a,#143
2823  0006 1a01          	or	a,(OFST+1,sp)
2824  0008 c75252        	ld	21074,a
2825                     ; 986 }
2828  000b 84            	pop	a
2829  000c 81            	ret
2865                     ; 1005 void TIM1_UpdateDisableConfig(FunctionalState NewState)
2865                     ; 1006 {
2866                     .text:	section	.text,new
2867  0000               _TIM1_UpdateDisableConfig:
2871                     ; 1008   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
2873                     ; 1011   if (NewState != DISABLE)
2875  0000 4d            	tnz	a
2876  0001 2706          	jreq	L5631
2877                     ; 1013     TIM1->CR1 |= TIM1_CR1_UDIS;
2879  0003 72125250      	bset	21072,#1
2881  0007 2004          	jra	L7631
2882  0009               L5631:
2883                     ; 1017     TIM1->CR1 &= (u8)(~TIM1_CR1_UDIS);
2885  0009 72135250      	bres	21072,#1
2886  000d               L7631:
2887                     ; 1019 }
2890  000d 81            	ret
2948                     ; 1038 void TIM1_UpdateRequestConfig(TIM1_UpdateSource_TypeDef TIM1_UpdateSource)
2948                     ; 1039 {
2949                     .text:	section	.text,new
2950  0000               _TIM1_UpdateRequestConfig:
2954                     ; 1041   assert_param(IS_TIM1_UPDATE_SOURCE_OK(TIM1_UpdateSource));
2956                     ; 1044   if (TIM1_UpdateSource != TIM1_UPDATESOURCE_GLOBAL)
2958  0000 4d            	tnz	a
2959  0001 2706          	jreq	L7141
2960                     ; 1046     TIM1->CR1 |= TIM1_CR1_URS;
2962  0003 72145250      	bset	21072,#2
2964  0007 2004          	jra	L1241
2965  0009               L7141:
2966                     ; 1050     TIM1->CR1 &= (u8)(~TIM1_CR1_URS);
2968  0009 72155250      	bres	21072,#2
2969  000d               L1241:
2970                     ; 1052 }
2973  000d 81            	ret
3009                     ; 1070 void TIM1_SelectHallSensor(FunctionalState NewState)
3009                     ; 1071 {
3010                     .text:	section	.text,new
3011  0000               _TIM1_SelectHallSensor:
3015                     ; 1073   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3017                     ; 1076   if (NewState != DISABLE)
3019  0000 4d            	tnz	a
3020  0001 2706          	jreq	L1441
3021                     ; 1078     TIM1->CR2 |= TIM1_CR2_TI1S;
3023  0003 721e5251      	bset	21073,#7
3025  0007 2004          	jra	L3441
3026  0009               L1441:
3027                     ; 1082     TIM1->CR2 &= (u8)(~TIM1_CR2_TI1S);
3029  0009 721f5251      	bres	21073,#7
3030  000d               L3441:
3031                     ; 1084 }
3034  000d 81            	ret
3091                     ; 1104 void TIM1_SelectOnePulseMode(TIM1_OPMode_TypeDef TIM1_OPMode)
3091                     ; 1105 {
3092                     .text:	section	.text,new
3093  0000               _TIM1_SelectOnePulseMode:
3097                     ; 1107   assert_param(IS_TIM1_OPM_MODE_OK(TIM1_OPMode));
3099                     ; 1110   if (TIM1_OPMode != TIM1_OPMODE_REPETITIVE)
3101  0000 4d            	tnz	a
3102  0001 2706          	jreq	L3741
3103                     ; 1112     TIM1->CR1 |= TIM1_CR1_OPM;
3105  0003 72165250      	bset	21072,#3
3107  0007 2004          	jra	L5741
3108  0009               L3741:
3109                     ; 1116     TIM1->CR1 &= (u8)(~TIM1_CR1_OPM);
3111  0009 72175250      	bres	21072,#3
3112  000d               L5741:
3113                     ; 1119 }
3116  000d 81            	ret
3214                     ; 1144 void TIM1_SelectOutputTrigger(TIM1_TRGOSource_TypeDef TIM1_TRGOSource)
3214                     ; 1145 {
3215                     .text:	section	.text,new
3216  0000               _TIM1_SelectOutputTrigger:
3218  0000 88            	push	a
3219       00000000      OFST:	set	0
3222                     ; 1148   assert_param(IS_TIM1_TRGO_SOURCE_OK(TIM1_TRGOSource));
3224                     ; 1150   TIM1->CR2 = (u8)((TIM1->CR2 & (u8)(~TIM1_CR2_MMS    )) | (u8)  TIM1_TRGOSource);
3226  0001 c65251        	ld	a,21073
3227  0004 a48f          	and	a,#143
3228  0006 1a01          	or	a,(OFST+1,sp)
3229  0008 c75251        	ld	21073,a
3230                     ; 1151 }
3233  000b 84            	pop	a
3234  000c 81            	ret
3308                     ; 1172 void TIM1_SelectSlaveMode(TIM1_SlaveMode_TypeDef TIM1_SlaveMode)
3308                     ; 1173 {
3309                     .text:	section	.text,new
3310  0000               _TIM1_SelectSlaveMode:
3312  0000 88            	push	a
3313       00000000      OFST:	set	0
3316                     ; 1176   assert_param(IS_TIM1_SLAVE_MODE_OK(TIM1_SlaveMode));
3318                     ; 1179   TIM1->SMCR = (u8)((TIM1->SMCR &  (u8)(~TIM1_SMCR_SMS)) |  (u8)TIM1_SlaveMode);
3320  0001 c65252        	ld	a,21074
3321  0004 a4f8          	and	a,#248
3322  0006 1a01          	or	a,(OFST+1,sp)
3323  0008 c75252        	ld	21074,a
3324                     ; 1181 }
3327  000b 84            	pop	a
3328  000c 81            	ret
3364                     ; 1198 void TIM1_SelectMasterSlaveMode(FunctionalState NewState)
3364                     ; 1199 {
3365                     .text:	section	.text,new
3366  0000               _TIM1_SelectMasterSlaveMode:
3370                     ; 1201   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3372                     ; 1204   if (NewState != DISABLE)
3374  0000 4d            	tnz	a
3375  0001 2706          	jreq	L7061
3376                     ; 1206     TIM1->SMCR |= TIM1_SMCR_MSM;
3378  0003 721e5252      	bset	21074,#7
3380  0007 2004          	jra	L1161
3381  0009               L7061:
3382                     ; 1210     TIM1->SMCR &= (u8)(~TIM1_SMCR_MSM);
3384  0009 721f5252      	bres	21074,#7
3385  000d               L1161:
3386                     ; 1212 }
3389  000d 81            	ret
3475                     ; 1243 void TIM1_EncoderInterfaceConfig(TIM1_EncoderMode_TypeDef TIM1_EncoderMode,
3475                     ; 1244                                  TIM1_ICPolarity_TypeDef TIM1_IC1Polarity,
3475                     ; 1245                                  TIM1_ICPolarity_TypeDef TIM1_IC2Polarity)
3475                     ; 1246 {
3476                     .text:	section	.text,new
3477  0000               _TIM1_EncoderInterfaceConfig:
3479  0000 89            	pushw	x
3480       00000000      OFST:	set	0
3483                     ; 1250   assert_param(IS_TIM1_ENCODER_MODE_OK(TIM1_EncoderMode));
3485                     ; 1251   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC1Polarity));
3487                     ; 1252   assert_param(IS_TIM1_IC_POLARITY_OK(TIM1_IC2Polarity));
3489                     ; 1255   if (TIM1_IC1Polarity != TIM1_ICPOLARITY_RISING)
3491  0001 9f            	ld	a,xl
3492  0002 4d            	tnz	a
3493  0003 2706          	jreq	L3561
3494                     ; 1257     TIM1->CCER1 |= TIM1_CCER1_CC1P;
3496  0005 7212525c      	bset	21084,#1
3498  0009 2004          	jra	L5561
3499  000b               L3561:
3500                     ; 1261     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1P);
3502  000b 7213525c      	bres	21084,#1
3503  000f               L5561:
3504                     ; 1264   if (TIM1_IC2Polarity != TIM1_ICPOLARITY_RISING)
3506  000f 0d05          	tnz	(OFST+5,sp)
3507  0011 2706          	jreq	L7561
3508                     ; 1266     TIM1->CCER1 |= TIM1_CCER1_CC2P;
3510  0013 721a525c      	bset	21084,#5
3512  0017 2004          	jra	L1661
3513  0019               L7561:
3514                     ; 1270     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2P);
3516  0019 721b525c      	bres	21084,#5
3517  001d               L1661:
3518                     ; 1273   TIM1->SMCR = (u8)((TIM1->SMCR & (u8)(TIM1_SMCR_MSM | TIM1_SMCR_TS)) | (u8) TIM1_EncoderMode);
3520  001d c65252        	ld	a,21074
3521  0020 a4f0          	and	a,#240
3522  0022 1a01          	or	a,(OFST+1,sp)
3523  0024 c75252        	ld	21074,a
3524                     ; 1276   TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_CCxS))  | (u8) CCMR_TIxDirect_Set);
3526  0027 c65258        	ld	a,21080
3527  002a a4fc          	and	a,#252
3528  002c aa01          	or	a,#1
3529  002e c75258        	ld	21080,a
3530                     ; 1277   TIM1->CCMR2 = (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_CCxS)) | (u8) CCMR_TIxDirect_Set);
3532  0031 c65259        	ld	a,21081
3533  0034 a4fc          	and	a,#252
3534  0036 aa01          	or	a,#1
3535  0038 c75259        	ld	21081,a
3536                     ; 1279 }
3539  003b 85            	popw	x
3540  003c 81            	ret
3607                     ; 1303 void TIM1_PrescalerConfig(u16 Prescaler,
3607                     ; 1304                           TIM1_PSCReloadMode_TypeDef TIM1_PSCReloadMode)
3607                     ; 1305 {
3608                     .text:	section	.text,new
3609  0000               _TIM1_PrescalerConfig:
3611  0000 89            	pushw	x
3612       00000000      OFST:	set	0
3615                     ; 1307   assert_param(IS_TIM1_PRESCALER_RELOAD_OK(TIM1_PSCReloadMode));
3617                     ; 1310   TIM1->PSCRH = (u8)(Prescaler >> 8);
3619  0001 9e            	ld	a,xh
3620  0002 c75260        	ld	21088,a
3621                     ; 1311   TIM1->PSCRL = (u8)(Prescaler);
3623  0005 9f            	ld	a,xl
3624  0006 c75261        	ld	21089,a
3625                     ; 1314   TIM1->EGR = TIM1_PSCReloadMode;
3627  0009 7b05          	ld	a,(OFST+5,sp)
3628  000b c75257        	ld	21079,a
3629                     ; 1316 }
3632  000e 85            	popw	x
3633  000f 81            	ret
3669                     ; 1338 void TIM1_CounterModeConfig(TIM1_CounterMode_TypeDef TIM1_CounterMode)
3669                     ; 1339 {
3670                     .text:	section	.text,new
3671  0000               _TIM1_CounterModeConfig:
3673  0000 88            	push	a
3674       00000000      OFST:	set	0
3677                     ; 1341   assert_param(IS_TIM1_COUNTER_MODE_OK(TIM1_CounterMode));
3679                     ; 1345   TIM1->CR1 = (u8)((TIM1->CR1 & (u8)((u8)(~TIM1_CR1_CMS) & (u8)(~TIM1_CR1_DIR))) | (u8)TIM1_CounterMode);
3681  0001 c65250        	ld	a,21072
3682  0004 a48f          	and	a,#143
3683  0006 1a01          	or	a,(OFST+1,sp)
3684  0008 c75250        	ld	21072,a
3685                     ; 1346 }
3688  000b 84            	pop	a
3689  000c 81            	ret
3747                     ; 1367 void TIM1_ForcedOC1Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3747                     ; 1368 {
3748                     .text:	section	.text,new
3749  0000               _TIM1_ForcedOC1Config:
3751  0000 88            	push	a
3752       00000000      OFST:	set	0
3755                     ; 1370   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3757                     ; 1373   TIM1->CCMR1 =  (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_OCM))  | (u8)TIM1_ForcedAction);
3759  0001 c65258        	ld	a,21080
3760  0004 a48f          	and	a,#143
3761  0006 1a01          	or	a,(OFST+1,sp)
3762  0008 c75258        	ld	21080,a
3763                     ; 1374 }
3766  000b 84            	pop	a
3767  000c 81            	ret
3803                     ; 1395 void TIM1_ForcedOC2Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3803                     ; 1396 {
3804                     .text:	section	.text,new
3805  0000               _TIM1_ForcedOC2Config:
3807  0000 88            	push	a
3808       00000000      OFST:	set	0
3811                     ; 1398   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3813                     ; 1401   TIM1->CCMR2  =  (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_ForcedAction);
3815  0001 c65259        	ld	a,21081
3816  0004 a48f          	and	a,#143
3817  0006 1a01          	or	a,(OFST+1,sp)
3818  0008 c75259        	ld	21081,a
3819                     ; 1402 }
3822  000b 84            	pop	a
3823  000c 81            	ret
3859                     ; 1423 void TIM1_ForcedOC3Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3859                     ; 1424 {
3860                     .text:	section	.text,new
3861  0000               _TIM1_ForcedOC3Config:
3863  0000 88            	push	a
3864       00000000      OFST:	set	0
3867                     ; 1426   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3869                     ; 1429   TIM1->CCMR3  =  (u8)((TIM1->CCMR3 & (u8)(~TIM1_CCMR_OCM))  | (u8)TIM1_ForcedAction);
3871  0001 c6525a        	ld	a,21082
3872  0004 a48f          	and	a,#143
3873  0006 1a01          	or	a,(OFST+1,sp)
3874  0008 c7525a        	ld	21082,a
3875                     ; 1430 }
3878  000b 84            	pop	a
3879  000c 81            	ret
3915                     ; 1451 void TIM1_ForcedOC4Config(TIM1_ForcedAction_TypeDef TIM1_ForcedAction)
3915                     ; 1452 {
3916                     .text:	section	.text,new
3917  0000               _TIM1_ForcedOC4Config:
3919  0000 88            	push	a
3920       00000000      OFST:	set	0
3923                     ; 1454   assert_param(IS_TIM1_FORCED_ACTION_OK(TIM1_ForcedAction));
3925                     ; 1457   TIM1->CCMR4  =  (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_ForcedAction);
3927  0001 c6525b        	ld	a,21083
3928  0004 a48f          	and	a,#143
3929  0006 1a01          	or	a,(OFST+1,sp)
3930  0008 c7525b        	ld	21083,a
3931                     ; 1458 }
3934  000b 84            	pop	a
3935  000c 81            	ret
3971                     ; 1476 void TIM1_ARRPreloadConfig(FunctionalState NewState)
3971                     ; 1477 {
3972                     .text:	section	.text,new
3973  0000               _TIM1_ARRPreloadConfig:
3977                     ; 1479   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
3979                     ; 1482   if (NewState != DISABLE)
3981  0000 4d            	tnz	a
3982  0001 2706          	jreq	L1502
3983                     ; 1484     TIM1->CR1 |= TIM1_CR1_ARPE;
3985  0003 721e5250      	bset	21072,#7
3987  0007 2004          	jra	L3502
3988  0009               L1502:
3989                     ; 1488     TIM1->CR1 &= (u8)(~TIM1_CR1_ARPE);
3991  0009 721f5250      	bres	21072,#7
3992  000d               L3502:
3993                     ; 1490 }
3996  000d 81            	ret
4031                     ; 1508 void TIM1_SelectCOM(FunctionalState NewState)
4031                     ; 1509 {
4032                     .text:	section	.text,new
4033  0000               _TIM1_SelectCOM:
4037                     ; 1511   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4039                     ; 1514   if (NewState != DISABLE)
4041  0000 4d            	tnz	a
4042  0001 2706          	jreq	L3702
4043                     ; 1516     TIM1->CR2 |= TIM1_CR2_COMS;
4045  0003 72145251      	bset	21073,#2
4047  0007 2004          	jra	L5702
4048  0009               L3702:
4049                     ; 1520     TIM1->CR2 &= (u8)(~TIM1_CR2_COMS);
4051  0009 72155251      	bres	21073,#2
4052  000d               L5702:
4053                     ; 1522 }
4056  000d 81            	ret
4092                     ; 1539 void TIM1_CCPreloadControl(FunctionalState NewState)
4092                     ; 1540 {
4093                     .text:	section	.text,new
4094  0000               _TIM1_CCPreloadControl:
4098                     ; 1542   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4100                     ; 1545   if (NewState != DISABLE)
4102  0000 4d            	tnz	a
4103  0001 2706          	jreq	L5112
4104                     ; 1547     TIM1->CR2 |= TIM1_CR2_CCPC;
4106  0003 72105251      	bset	21073,#0
4108  0007 2004          	jra	L7112
4109  0009               L5112:
4110                     ; 1551     TIM1->CR2 &= (u8)(~TIM1_CR2_CCPC);
4112  0009 72115251      	bres	21073,#0
4113  000d               L7112:
4114                     ; 1553 }
4117  000d 81            	ret
4153                     ; 1571 void TIM1_OC1PreloadConfig(FunctionalState NewState)
4153                     ; 1572 {
4154                     .text:	section	.text,new
4155  0000               _TIM1_OC1PreloadConfig:
4159                     ; 1574   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4161                     ; 1577   if (NewState != DISABLE)
4163  0000 4d            	tnz	a
4164  0001 2706          	jreq	L7312
4165                     ; 1579     TIM1->CCMR1 |= TIM1_CCMR_OCxPE;
4167  0003 72165258      	bset	21080,#3
4169  0007 2004          	jra	L1412
4170  0009               L7312:
4171                     ; 1583     TIM1->CCMR1 &= (u8)(~TIM1_CCMR_OCxPE);
4173  0009 72175258      	bres	21080,#3
4174  000d               L1412:
4175                     ; 1585 }
4178  000d 81            	ret
4214                     ; 1603 void TIM1_OC2PreloadConfig(FunctionalState NewState)
4214                     ; 1604 {
4215                     .text:	section	.text,new
4216  0000               _TIM1_OC2PreloadConfig:
4220                     ; 1606   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4222                     ; 1609   if (NewState != DISABLE)
4224  0000 4d            	tnz	a
4225  0001 2706          	jreq	L1612
4226                     ; 1611     TIM1->CCMR2 |= TIM1_CCMR_OCxPE;
4228  0003 72165259      	bset	21081,#3
4230  0007 2004          	jra	L3612
4231  0009               L1612:
4232                     ; 1615     TIM1->CCMR2 &= (u8)(~TIM1_CCMR_OCxPE);
4234  0009 72175259      	bres	21081,#3
4235  000d               L3612:
4236                     ; 1617 }
4239  000d 81            	ret
4275                     ; 1635 void TIM1_OC3PreloadConfig(FunctionalState NewState)
4275                     ; 1636 {
4276                     .text:	section	.text,new
4277  0000               _TIM1_OC3PreloadConfig:
4281                     ; 1638   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4283                     ; 1641   if (NewState != DISABLE)
4285  0000 4d            	tnz	a
4286  0001 2706          	jreq	L3022
4287                     ; 1643     TIM1->CCMR3 |= TIM1_CCMR_OCxPE;
4289  0003 7216525a      	bset	21082,#3
4291  0007 2004          	jra	L5022
4292  0009               L3022:
4293                     ; 1647     TIM1->CCMR3 &= (u8)(~TIM1_CCMR_OCxPE);
4295  0009 7217525a      	bres	21082,#3
4296  000d               L5022:
4297                     ; 1649 }
4300  000d 81            	ret
4336                     ; 1668 void TIM1_OC4PreloadConfig(FunctionalState NewState)
4336                     ; 1669 {
4337                     .text:	section	.text,new
4338  0000               _TIM1_OC4PreloadConfig:
4342                     ; 1671   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4344                     ; 1674   if (NewState != DISABLE)
4346  0000 4d            	tnz	a
4347  0001 2706          	jreq	L5222
4348                     ; 1676     TIM1->CCMR4 |= TIM1_CCMR_OCxPE;
4350  0003 7216525b      	bset	21083,#3
4352  0007 2004          	jra	L7222
4353  0009               L5222:
4354                     ; 1680     TIM1->CCMR4 &= (u8)(~TIM1_CCMR_OCxPE);
4356  0009 7217525b      	bres	21083,#3
4357  000d               L7222:
4358                     ; 1682 }
4361  000d 81            	ret
4396                     ; 1699 void TIM1_OC1FastConfig(FunctionalState NewState)
4396                     ; 1700 {
4397                     .text:	section	.text,new
4398  0000               _TIM1_OC1FastConfig:
4402                     ; 1702   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4404                     ; 1705   if (NewState != DISABLE)
4406  0000 4d            	tnz	a
4407  0001 2706          	jreq	L7422
4408                     ; 1707     TIM1->CCMR1 |= TIM1_CCMR_OCxFE;
4410  0003 72145258      	bset	21080,#2
4412  0007 2004          	jra	L1522
4413  0009               L7422:
4414                     ; 1711     TIM1->CCMR1 &= (u8)(~TIM1_CCMR_OCxFE);
4416  0009 72155258      	bres	21080,#2
4417  000d               L1522:
4418                     ; 1713 }
4421  000d 81            	ret
4456                     ; 1732 void TIM1_OC2FastConfig(FunctionalState NewState)
4456                     ; 1733 {
4457                     .text:	section	.text,new
4458  0000               _TIM1_OC2FastConfig:
4462                     ; 1735   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4464                     ; 1738   if (NewState != DISABLE)
4466  0000 4d            	tnz	a
4467  0001 2706          	jreq	L1722
4468                     ; 1740     TIM1->CCMR2 |= TIM1_CCMR_OCxFE;
4470  0003 72145259      	bset	21081,#2
4472  0007 2004          	jra	L3722
4473  0009               L1722:
4474                     ; 1744     TIM1->CCMR2 &= (u8)(~TIM1_CCMR_OCxFE);
4476  0009 72155259      	bres	21081,#2
4477  000d               L3722:
4478                     ; 1746 }
4481  000d 81            	ret
4516                     ; 1764 void TIM1_OC3FastConfig(FunctionalState NewState)
4516                     ; 1765 {
4517                     .text:	section	.text,new
4518  0000               _TIM1_OC3FastConfig:
4522                     ; 1767   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4524                     ; 1770   if (NewState != DISABLE)
4526  0000 4d            	tnz	a
4527  0001 2706          	jreq	L3132
4528                     ; 1772     TIM1->CCMR3 |= TIM1_CCMR_OCxFE;
4530  0003 7214525a      	bset	21082,#2
4532  0007 2004          	jra	L5132
4533  0009               L3132:
4534                     ; 1776     TIM1->CCMR3 &= (u8)(~TIM1_CCMR_OCxFE);
4536  0009 7215525a      	bres	21082,#2
4537  000d               L5132:
4538                     ; 1778 }
4541  000d 81            	ret
4576                     ; 1796 void TIM1_OC4FastConfig(FunctionalState NewState)
4576                     ; 1797 {
4577                     .text:	section	.text,new
4578  0000               _TIM1_OC4FastConfig:
4582                     ; 1799   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
4584                     ; 1802   if (NewState != DISABLE)
4586  0000 4d            	tnz	a
4587  0001 2706          	jreq	L5332
4588                     ; 1804     TIM1->CCMR4 |= TIM1_CCMR_OCxFE;
4590  0003 7214525b      	bset	21083,#2
4592  0007 2004          	jra	L7332
4593  0009               L5332:
4594                     ; 1808     TIM1->CCMR4 &= (u8)(~TIM1_CCMR_OCxFE);
4596  0009 7215525b      	bres	21083,#2
4597  000d               L7332:
4598                     ; 1810 }
4601  000d 81            	ret
4706                     ; 1836 void TIM1_GenerateEvent(TIM1_EventSource_TypeDef TIM1_EventSource)
4706                     ; 1837 {
4707                     .text:	section	.text,new
4708  0000               _TIM1_GenerateEvent:
4712                     ; 1839   assert_param(IS_TIM1_EVENT_SOURCE_OK(TIM1_EventSource));
4714                     ; 1842   TIM1->EGR = (u8)TIM1_EventSource;
4716  0000 c75257        	ld	21079,a
4717                     ; 1843 }
4720  0003 81            	ret
4756                     ; 1863 void TIM1_OC1PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4756                     ; 1864 {
4757                     .text:	section	.text,new
4758  0000               _TIM1_OC1PolarityConfig:
4762                     ; 1866   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4764                     ; 1869   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4766  0000 4d            	tnz	a
4767  0001 2706          	jreq	L1242
4768                     ; 1871     TIM1->CCER1 |= TIM1_CCER1_CC1P;
4770  0003 7212525c      	bset	21084,#1
4772  0007 2004          	jra	L3242
4773  0009               L1242:
4774                     ; 1875     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1P);
4776  0009 7213525c      	bres	21084,#1
4777  000d               L3242:
4778                     ; 1877 }
4781  000d 81            	ret
4817                     ; 1897 void TIM1_OC1NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4817                     ; 1898 {
4818                     .text:	section	.text,new
4819  0000               _TIM1_OC1NPolarityConfig:
4823                     ; 1900   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4825                     ; 1903   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4827  0000 4d            	tnz	a
4828  0001 2706          	jreq	L3442
4829                     ; 1905     TIM1->CCER1 |= TIM1_CCER1_CC1NP;
4831  0003 7216525c      	bset	21084,#3
4833  0007 2004          	jra	L5442
4834  0009               L3442:
4835                     ; 1909     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1NP);
4837  0009 7217525c      	bres	21084,#3
4838  000d               L5442:
4839                     ; 1911 }
4842  000d 81            	ret
4878                     ; 1931 void TIM1_OC2PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
4878                     ; 1932 {
4879                     .text:	section	.text,new
4880  0000               _TIM1_OC2PolarityConfig:
4884                     ; 1934   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
4886                     ; 1937   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
4888  0000 4d            	tnz	a
4889  0001 2706          	jreq	L5642
4890                     ; 1939     TIM1->CCER1 |= TIM1_CCER1_CC2P;
4892  0003 721a525c      	bset	21084,#5
4894  0007 2004          	jra	L7642
4895  0009               L5642:
4896                     ; 1943     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2P);
4898  0009 721b525c      	bres	21084,#5
4899  000d               L7642:
4900                     ; 1945 }
4903  000d 81            	ret
4939                     ; 1964 void TIM1_OC2NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
4939                     ; 1965 {
4940                     .text:	section	.text,new
4941  0000               _TIM1_OC2NPolarityConfig:
4945                     ; 1967   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
4947                     ; 1970   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
4949  0000 4d            	tnz	a
4950  0001 2706          	jreq	L7052
4951                     ; 1972     TIM1->CCER1 |= TIM1_CCER1_CC2NP;
4953  0003 721e525c      	bset	21084,#7
4955  0007 2004          	jra	L1152
4956  0009               L7052:
4957                     ; 1976     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2NP);
4959  0009 721f525c      	bres	21084,#7
4960  000d               L1152:
4961                     ; 1978 }
4964  000d 81            	ret
5000                     ; 1998 void TIM1_OC3PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5000                     ; 1999 {
5001                     .text:	section	.text,new
5002  0000               _TIM1_OC3PolarityConfig:
5006                     ; 2001   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5008                     ; 2004   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5010  0000 4d            	tnz	a
5011  0001 2706          	jreq	L1352
5012                     ; 2006     TIM1->CCER2 |= TIM1_CCER2_CC3P;
5014  0003 7212525d      	bset	21085,#1
5016  0007 2004          	jra	L3352
5017  0009               L1352:
5018                     ; 2010     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3P);
5020  0009 7213525d      	bres	21085,#1
5021  000d               L3352:
5022                     ; 2012 }
5025  000d 81            	ret
5061                     ; 2032 void TIM1_OC3NPolarityConfig(TIM1_OCNPolarity_TypeDef TIM1_OCNPolarity)
5061                     ; 2033 {
5062                     .text:	section	.text,new
5063  0000               _TIM1_OC3NPolarityConfig:
5067                     ; 2035   assert_param(IS_TIM1_OCN_POLARITY_OK(TIM1_OCNPolarity));
5069                     ; 2038   if (TIM1_OCNPolarity != TIM1_OCNPOLARITY_HIGH)
5071  0000 4d            	tnz	a
5072  0001 2706          	jreq	L3552
5073                     ; 2040     TIM1->CCER2 |= TIM1_CCER2_CC3NP;
5075  0003 7216525d      	bset	21085,#3
5077  0007 2004          	jra	L5552
5078  0009               L3552:
5079                     ; 2044     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3NP);
5081  0009 7217525d      	bres	21085,#3
5082  000d               L5552:
5083                     ; 2046 }
5086  000d 81            	ret
5122                     ; 2065 void TIM1_OC4PolarityConfig(TIM1_OCPolarity_TypeDef TIM1_OCPolarity)
5122                     ; 2066 {
5123                     .text:	section	.text,new
5124  0000               _TIM1_OC4PolarityConfig:
5128                     ; 2068   assert_param(IS_TIM1_OC_POLARITY_OK(TIM1_OCPolarity));
5130                     ; 2071   if (TIM1_OCPolarity != TIM1_OCPOLARITY_HIGH)
5132  0000 4d            	tnz	a
5133  0001 2706          	jreq	L5752
5134                     ; 2073     TIM1->CCER2 |= TIM1_CCER2_CC4P;
5136  0003 721a525d      	bset	21085,#5
5138  0007 2004          	jra	L7752
5139  0009               L5752:
5140                     ; 2077     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC4P);
5142  0009 721b525d      	bres	21085,#5
5143  000d               L7752:
5144                     ; 2079 }
5147  000d 81            	ret
5192                     ; 2103 void TIM1_CCxCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5192                     ; 2104 {
5193                     .text:	section	.text,new
5194  0000               _TIM1_CCxCmd:
5196  0000 89            	pushw	x
5197       00000000      OFST:	set	0
5200                     ; 2106   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5202                     ; 2107   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5204                     ; 2109   if (TIM1_Channel == TIM1_CHANNEL_1)
5206  0001 9e            	ld	a,xh
5207  0002 4d            	tnz	a
5208  0003 2610          	jrne	L3262
5209                     ; 2112     if (NewState != DISABLE)
5211  0005 9f            	ld	a,xl
5212  0006 4d            	tnz	a
5213  0007 2706          	jreq	L5262
5214                     ; 2114       TIM1->CCER1 |= TIM1_CCER1_CC1E;
5216  0009 7210525c      	bset	21084,#0
5218  000d 2040          	jra	L1362
5219  000f               L5262:
5220                     ; 2118       TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1E);
5222  000f 7211525c      	bres	21084,#0
5223  0013 203a          	jra	L1362
5224  0015               L3262:
5225                     ; 2122   else if (TIM1_Channel == TIM1_CHANNEL_2)
5227  0015 7b01          	ld	a,(OFST+1,sp)
5228  0017 a101          	cp	a,#1
5229  0019 2610          	jrne	L3362
5230                     ; 2125     if (NewState != DISABLE)
5232  001b 0d02          	tnz	(OFST+2,sp)
5233  001d 2706          	jreq	L5362
5234                     ; 2127       TIM1->CCER1 |= TIM1_CCER1_CC2E;
5236  001f 7218525c      	bset	21084,#4
5238  0023 202a          	jra	L1362
5239  0025               L5362:
5240                     ; 2131       TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2E);
5242  0025 7219525c      	bres	21084,#4
5243  0029 2024          	jra	L1362
5244  002b               L3362:
5245                     ; 2134   else if (TIM1_Channel == TIM1_CHANNEL_3)
5247  002b 7b01          	ld	a,(OFST+1,sp)
5248  002d a102          	cp	a,#2
5249  002f 2610          	jrne	L3462
5250                     ; 2137     if (NewState != DISABLE)
5252  0031 0d02          	tnz	(OFST+2,sp)
5253  0033 2706          	jreq	L5462
5254                     ; 2139       TIM1->CCER2 |= TIM1_CCER2_CC3E;
5256  0035 7210525d      	bset	21085,#0
5258  0039 2014          	jra	L1362
5259  003b               L5462:
5260                     ; 2143       TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3E);
5262  003b 7211525d      	bres	21085,#0
5263  003f 200e          	jra	L1362
5264  0041               L3462:
5265                     ; 2149     if (NewState != DISABLE)
5267  0041 0d02          	tnz	(OFST+2,sp)
5268  0043 2706          	jreq	L3562
5269                     ; 2151       TIM1->CCER2 |= TIM1_CCER2_CC4E;
5271  0045 7218525d      	bset	21085,#4
5273  0049 2004          	jra	L1362
5274  004b               L3562:
5275                     ; 2155       TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC4E);
5277  004b 7219525d      	bres	21085,#4
5278  004f               L1362:
5279                     ; 2158 }
5282  004f 85            	popw	x
5283  0050 81            	ret
5328                     ; 2180 void TIM1_CCxNCmd(TIM1_Channel_TypeDef TIM1_Channel, FunctionalState NewState)
5328                     ; 2181 {
5329                     .text:	section	.text,new
5330  0000               _TIM1_CCxNCmd:
5332  0000 89            	pushw	x
5333       00000000      OFST:	set	0
5336                     ; 2183   assert_param(IS_TIM1_COMPLEMENTARY_CHANNEL_OK(TIM1_Channel));
5338                     ; 2184   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
5340                     ; 2186   if (TIM1_Channel == TIM1_CHANNEL_1)
5342  0001 9e            	ld	a,xh
5343  0002 4d            	tnz	a
5344  0003 2610          	jrne	L1072
5345                     ; 2189     if (NewState != DISABLE)
5347  0005 9f            	ld	a,xl
5348  0006 4d            	tnz	a
5349  0007 2706          	jreq	L3072
5350                     ; 2191       TIM1->CCER1 |= TIM1_CCER1_CC1NE;
5352  0009 7214525c      	bset	21084,#2
5354  000d 202a          	jra	L7072
5355  000f               L3072:
5356                     ; 2195       TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1NE);
5358  000f 7215525c      	bres	21084,#2
5359  0013 2024          	jra	L7072
5360  0015               L1072:
5361                     ; 2198   else if (TIM1_Channel == TIM1_CHANNEL_2)
5363  0015 7b01          	ld	a,(OFST+1,sp)
5364  0017 a101          	cp	a,#1
5365  0019 2610          	jrne	L1172
5366                     ; 2201     if (NewState != DISABLE)
5368  001b 0d02          	tnz	(OFST+2,sp)
5369  001d 2706          	jreq	L3172
5370                     ; 2203       TIM1->CCER1 |= TIM1_CCER1_CC2NE;
5372  001f 721c525c      	bset	21084,#6
5374  0023 2014          	jra	L7072
5375  0025               L3172:
5376                     ; 2207       TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2NE);
5378  0025 721d525c      	bres	21084,#6
5379  0029 200e          	jra	L7072
5380  002b               L1172:
5381                     ; 2213     if (NewState != DISABLE)
5383  002b 0d02          	tnz	(OFST+2,sp)
5384  002d 2706          	jreq	L1272
5385                     ; 2215       TIM1->CCER2 |= TIM1_CCER2_CC3NE;
5387  002f 7214525d      	bset	21085,#2
5389  0033 2004          	jra	L7072
5390  0035               L1272:
5391                     ; 2219       TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3NE);
5393  0035 7215525d      	bres	21085,#2
5394  0039               L7072:
5395                     ; 2222 }
5398  0039 85            	popw	x
5399  003a 81            	ret
5444                     ; 2255 void TIM1_SelectOCxM(TIM1_Channel_TypeDef TIM1_Channel, TIM1_OCMode_TypeDef TIM1_OCMode)
5444                     ; 2256 {
5445                     .text:	section	.text,new
5446  0000               _TIM1_SelectOCxM:
5448  0000 89            	pushw	x
5449       00000000      OFST:	set	0
5452                     ; 2258   assert_param(IS_TIM1_CHANNEL_OK(TIM1_Channel));
5454                     ; 2259   assert_param(IS_TIM1_OCM_OK(TIM1_OCMode));
5456                     ; 2261   if (TIM1_Channel == TIM1_CHANNEL_1)
5458  0001 9e            	ld	a,xh
5459  0002 4d            	tnz	a
5460  0003 2610          	jrne	L7472
5461                     ; 2264     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1E);
5463  0005 7211525c      	bres	21084,#0
5464                     ; 2267     TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
5466  0009 c65258        	ld	a,21080
5467  000c a48f          	and	a,#143
5468  000e 1a02          	or	a,(OFST+2,sp)
5469  0010 c75258        	ld	21080,a
5471  0013 203a          	jra	L1572
5472  0015               L7472:
5473                     ; 2269   else if (TIM1_Channel == TIM1_CHANNEL_2)
5475  0015 7b01          	ld	a,(OFST+1,sp)
5476  0017 a101          	cp	a,#1
5477  0019 2610          	jrne	L3572
5478                     ; 2272     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2E);
5480  001b 7219525c      	bres	21084,#4
5481                     ; 2275     TIM1->CCMR2 = (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
5483  001f c65259        	ld	a,21081
5484  0022 a48f          	and	a,#143
5485  0024 1a02          	or	a,(OFST+2,sp)
5486  0026 c75259        	ld	21081,a
5488  0029 2024          	jra	L1572
5489  002b               L3572:
5490                     ; 2277   else if (TIM1_Channel == TIM1_CHANNEL_3)
5492  002b 7b01          	ld	a,(OFST+1,sp)
5493  002d a102          	cp	a,#2
5494  002f 2610          	jrne	L7572
5495                     ; 2280     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3E);
5497  0031 7211525d      	bres	21085,#0
5498                     ; 2283     TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
5500  0035 c6525a        	ld	a,21082
5501  0038 a48f          	and	a,#143
5502  003a 1a02          	or	a,(OFST+2,sp)
5503  003c c7525a        	ld	21082,a
5505  003f 200e          	jra	L1572
5506  0041               L7572:
5507                     ; 2288     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC4E);
5509  0041 7219525d      	bres	21085,#4
5510                     ; 2291     TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_OCM)) | (u8)TIM1_OCMode);
5512  0045 c6525b        	ld	a,21083
5513  0048 a48f          	and	a,#143
5514  004a 1a02          	or	a,(OFST+2,sp)
5515  004c c7525b        	ld	21083,a
5516  004f               L1572:
5517                     ; 2293 }
5520  004f 85            	popw	x
5521  0050 81            	ret
5555                     ; 2311 void TIM1_SetCounter(u16 Counter)
5555                     ; 2312 {
5556                     .text:	section	.text,new
5557  0000               _TIM1_SetCounter:
5561                     ; 2314   TIM1->CNTRH = (u8)(Counter >> 8);
5563  0000 9e            	ld	a,xh
5564  0001 c7525e        	ld	21086,a
5565                     ; 2315   TIM1->CNTRL = (u8)(Counter);
5567  0004 9f            	ld	a,xl
5568  0005 c7525f        	ld	21087,a
5569                     ; 2317 }
5572  0008 81            	ret
5606                     ; 2335 void TIM1_SetAutoreload(u16 Autoreload)
5606                     ; 2336 {
5607                     .text:	section	.text,new
5608  0000               _TIM1_SetAutoreload:
5612                     ; 2339   TIM1->ARRH = (u8)(Autoreload >> 8);
5614  0000 9e            	ld	a,xh
5615  0001 c75262        	ld	21090,a
5616                     ; 2340   TIM1->ARRL = (u8)(Autoreload);
5618  0004 9f            	ld	a,xl
5619  0005 c75263        	ld	21091,a
5620                     ; 2342 }
5623  0008 81            	ret
5657                     ; 2360 void TIM1_SetCompare1(u16 Compare1)
5657                     ; 2361 {
5658                     .text:	section	.text,new
5659  0000               _TIM1_SetCompare1:
5663                     ; 2363   TIM1->CCR1H = (u8)(Compare1 >> 8);
5665  0000 9e            	ld	a,xh
5666  0001 c75265        	ld	21093,a
5667                     ; 2364   TIM1->CCR1L = (u8)(Compare1);
5669  0004 9f            	ld	a,xl
5670  0005 c75266        	ld	21094,a
5671                     ; 2366 }
5674  0008 81            	ret
5708                     ; 2384 void TIM1_SetCompare2(u16 Compare2)
5708                     ; 2385 {
5709                     .text:	section	.text,new
5710  0000               _TIM1_SetCompare2:
5714                     ; 2387   TIM1->CCR2H = (u8)(Compare2 >> 8);
5716  0000 9e            	ld	a,xh
5717  0001 c75267        	ld	21095,a
5718                     ; 2388   TIM1->CCR2L = (u8)(Compare2);
5720  0004 9f            	ld	a,xl
5721  0005 c75268        	ld	21096,a
5722                     ; 2390 }
5725  0008 81            	ret
5759                     ; 2408 void TIM1_SetCompare3(u16 Compare3)
5759                     ; 2409 {
5760                     .text:	section	.text,new
5761  0000               _TIM1_SetCompare3:
5765                     ; 2411   TIM1->CCR3H = (u8)(Compare3 >> 8);
5767  0000 9e            	ld	a,xh
5768  0001 c75269        	ld	21097,a
5769                     ; 2412   TIM1->CCR3L = (u8)(Compare3);
5771  0004 9f            	ld	a,xl
5772  0005 c7526a        	ld	21098,a
5773                     ; 2414 }
5776  0008 81            	ret
5810                     ; 2432 void TIM1_SetCompare4(u16 Compare4)
5810                     ; 2433 {
5811                     .text:	section	.text,new
5812  0000               _TIM1_SetCompare4:
5816                     ; 2435   TIM1->CCR4H = (u8)(Compare4 >> 8);
5818  0000 9e            	ld	a,xh
5819  0001 c7526b        	ld	21099,a
5820                     ; 2436   TIM1->CCR4L = (u8)(Compare4);
5822  0004 9f            	ld	a,xl
5823  0005 c7526c        	ld	21100,a
5824                     ; 2438 }
5827  0008 81            	ret
5863                     ; 2460 void TIM1_SetIC1Prescaler(TIM1_ICPSC_TypeDef TIM1_IC1Prescaler)
5863                     ; 2461 {
5864                     .text:	section	.text,new
5865  0000               _TIM1_SetIC1Prescaler:
5867  0000 88            	push	a
5868       00000000      OFST:	set	0
5871                     ; 2463   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC1Prescaler));
5873                     ; 2466   TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC1Prescaler);
5875  0001 c65258        	ld	a,21080
5876  0004 a4f3          	and	a,#243
5877  0006 1a01          	or	a,(OFST+1,sp)
5878  0008 c75258        	ld	21080,a
5879                     ; 2468 }
5882  000b 84            	pop	a
5883  000c 81            	ret
5919                     ; 2489 void TIM1_SetIC2Prescaler(TIM1_ICPSC_TypeDef TIM1_IC2Prescaler)
5919                     ; 2490 {
5920                     .text:	section	.text,new
5921  0000               _TIM1_SetIC2Prescaler:
5923  0000 88            	push	a
5924       00000000      OFST:	set	0
5927                     ; 2493   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC2Prescaler));
5929                     ; 2496   TIM1->CCMR2 = (u8)((TIM1->CCMR2 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC2Prescaler);
5931  0001 c65259        	ld	a,21081
5932  0004 a4f3          	and	a,#243
5933  0006 1a01          	or	a,(OFST+1,sp)
5934  0008 c75259        	ld	21081,a
5935                     ; 2497 }
5938  000b 84            	pop	a
5939  000c 81            	ret
5975                     ; 2519 void TIM1_SetIC3Prescaler(TIM1_ICPSC_TypeDef TIM1_IC3Prescaler)
5975                     ; 2520 {
5976                     .text:	section	.text,new
5977  0000               _TIM1_SetIC3Prescaler:
5979  0000 88            	push	a
5980       00000000      OFST:	set	0
5983                     ; 2523   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC3Prescaler));
5985                     ; 2526   TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC3Prescaler);
5987  0001 c6525a        	ld	a,21082
5988  0004 a4f3          	and	a,#243
5989  0006 1a01          	or	a,(OFST+1,sp)
5990  0008 c7525a        	ld	21082,a
5991                     ; 2527 }
5994  000b 84            	pop	a
5995  000c 81            	ret
6031                     ; 2549 void TIM1_SetIC4Prescaler(TIM1_ICPSC_TypeDef TIM1_IC4Prescaler)
6031                     ; 2550 {
6032                     .text:	section	.text,new
6033  0000               _TIM1_SetIC4Prescaler:
6035  0000 88            	push	a
6036       00000000      OFST:	set	0
6039                     ; 2553   assert_param(IS_TIM1_IC_PRESCALER_OK(TIM1_IC4Prescaler));
6041                     ; 2556   TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~TIM1_CCMR_ICxPSC)) | (u8)TIM1_IC4Prescaler);
6043  0001 c6525b        	ld	a,21083
6044  0004 a4f3          	and	a,#243
6045  0006 1a01          	or	a,(OFST+1,sp)
6046  0008 c7525b        	ld	21083,a
6047                     ; 2557 }
6050  000b 84            	pop	a
6051  000c 81            	ret
6103                     ; 2576 u16 TIM1_GetCapture1(void)
6103                     ; 2577 {
6104                     .text:	section	.text,new
6105  0000               _TIM1_GetCapture1:
6107  0000 5204          	subw	sp,#4
6108       00000004      OFST:	set	4
6111                     ; 2580   u16 tmpccr1 = 0;
6113  0002 1e03          	ldw	x,(OFST-1,sp)
6114                     ; 2581   u8 tmpccr1l=0, tmpccr1h=0;
6116  0004 7b01          	ld	a,(OFST-3,sp)
6117  0006 97            	ld	xl,a
6120  0007 7b02          	ld	a,(OFST-2,sp)
6121  0009 97            	ld	xl,a
6122                     ; 2583     tmpccr1h = TIM1->CCR1H;
6124  000a c65265        	ld	a,21093
6125  000d 6b02          	ld	(OFST-2,sp),a
6126                     ; 2584 	tmpccr1l = TIM1->CCR1L;
6128  000f c65266        	ld	a,21094
6129  0012 6b01          	ld	(OFST-3,sp),a
6130                     ; 2586     tmpccr1 = (u16)(tmpccr1l);
6132  0014 7b01          	ld	a,(OFST-3,sp)
6133  0016 5f            	clrw	x
6134  0017 97            	ld	xl,a
6135  0018 1f03          	ldw	(OFST-1,sp),x
6136                     ; 2587     tmpccr1 |= (u16)((u16)tmpccr1h << 8);
6138  001a 7b02          	ld	a,(OFST-2,sp)
6139  001c 5f            	clrw	x
6140  001d 97            	ld	xl,a
6141  001e 4f            	clr	a
6142  001f 02            	rlwa	x,a
6143  0020 01            	rrwa	x,a
6144  0021 1a04          	or	a,(OFST+0,sp)
6145  0023 01            	rrwa	x,a
6146  0024 1a03          	or	a,(OFST-1,sp)
6147  0026 01            	rrwa	x,a
6148  0027 1f03          	ldw	(OFST-1,sp),x
6149                     ; 2589     return (u16)tmpccr1;
6151  0029 1e03          	ldw	x,(OFST-1,sp)
6154  002b 5b04          	addw	sp,#4
6155  002d 81            	ret
6207                     ; 2608 u16 TIM1_GetCapture2(void)
6207                     ; 2609 {
6208                     .text:	section	.text,new
6209  0000               _TIM1_GetCapture2:
6211  0000 5204          	subw	sp,#4
6212       00000004      OFST:	set	4
6215                     ; 2612   u16 tmpccr2 = 0;
6217  0002 1e03          	ldw	x,(OFST-1,sp)
6218                     ; 2613   u8 tmpccr2l=0, tmpccr2h=0;
6220  0004 7b01          	ld	a,(OFST-3,sp)
6221  0006 97            	ld	xl,a
6224  0007 7b02          	ld	a,(OFST-2,sp)
6225  0009 97            	ld	xl,a
6226                     ; 2615     tmpccr2h = TIM1->CCR2H;
6228  000a c65267        	ld	a,21095
6229  000d 6b02          	ld	(OFST-2,sp),a
6230                     ; 2616 	tmpccr2l = TIM1->CCR2L;
6232  000f c65268        	ld	a,21096
6233  0012 6b01          	ld	(OFST-3,sp),a
6234                     ; 2618     tmpccr2 = (u16)(tmpccr2l);
6236  0014 7b01          	ld	a,(OFST-3,sp)
6237  0016 5f            	clrw	x
6238  0017 97            	ld	xl,a
6239  0018 1f03          	ldw	(OFST-1,sp),x
6240                     ; 2619     tmpccr2 |= (u16)((u16)tmpccr2h << 8);
6242  001a 7b02          	ld	a,(OFST-2,sp)
6243  001c 5f            	clrw	x
6244  001d 97            	ld	xl,a
6245  001e 4f            	clr	a
6246  001f 02            	rlwa	x,a
6247  0020 01            	rrwa	x,a
6248  0021 1a04          	or	a,(OFST+0,sp)
6249  0023 01            	rrwa	x,a
6250  0024 1a03          	or	a,(OFST-1,sp)
6251  0026 01            	rrwa	x,a
6252  0027 1f03          	ldw	(OFST-1,sp),x
6253                     ; 2621     return (u16)tmpccr2;
6255  0029 1e03          	ldw	x,(OFST-1,sp)
6258  002b 5b04          	addw	sp,#4
6259  002d 81            	ret
6311                     ; 2640 u16 TIM1_GetCapture3(void)
6311                     ; 2641 {
6312                     .text:	section	.text,new
6313  0000               _TIM1_GetCapture3:
6315  0000 5204          	subw	sp,#4
6316       00000004      OFST:	set	4
6319                     ; 2643     u16 tmpccr3 = 0;
6321  0002 1e03          	ldw	x,(OFST-1,sp)
6322                     ; 2644   u8 tmpccr3l=0, tmpccr3h=0;
6324  0004 7b01          	ld	a,(OFST-3,sp)
6325  0006 97            	ld	xl,a
6328  0007 7b02          	ld	a,(OFST-2,sp)
6329  0009 97            	ld	xl,a
6330                     ; 2646     tmpccr3h = TIM1->CCR3H;
6332  000a c65269        	ld	a,21097
6333  000d 6b02          	ld	(OFST-2,sp),a
6334                     ; 2647 	tmpccr3l = TIM1->CCR3L;
6336  000f c6526a        	ld	a,21098
6337  0012 6b01          	ld	(OFST-3,sp),a
6338                     ; 2649     tmpccr3 = (u16)(tmpccr3l);
6340  0014 7b01          	ld	a,(OFST-3,sp)
6341  0016 5f            	clrw	x
6342  0017 97            	ld	xl,a
6343  0018 1f03          	ldw	(OFST-1,sp),x
6344                     ; 2650     tmpccr3 |= (u16)((u16)tmpccr3h << 8);
6346  001a 7b02          	ld	a,(OFST-2,sp)
6347  001c 5f            	clrw	x
6348  001d 97            	ld	xl,a
6349  001e 4f            	clr	a
6350  001f 02            	rlwa	x,a
6351  0020 01            	rrwa	x,a
6352  0021 1a04          	or	a,(OFST+0,sp)
6353  0023 01            	rrwa	x,a
6354  0024 1a03          	or	a,(OFST-1,sp)
6355  0026 01            	rrwa	x,a
6356  0027 1f03          	ldw	(OFST-1,sp),x
6357                     ; 2652     return (u16)tmpccr3;
6359  0029 1e03          	ldw	x,(OFST-1,sp)
6362  002b 5b04          	addw	sp,#4
6363  002d 81            	ret
6415                     ; 2671 u16 TIM1_GetCapture4(void)
6415                     ; 2672 {
6416                     .text:	section	.text,new
6417  0000               _TIM1_GetCapture4:
6419  0000 5204          	subw	sp,#4
6420       00000004      OFST:	set	4
6423                     ; 2674     u16 tmpccr4 = 0;
6425  0002 1e03          	ldw	x,(OFST-1,sp)
6426                     ; 2675   u8 tmpccr4l=0, tmpccr4h=0;
6428  0004 7b01          	ld	a,(OFST-3,sp)
6429  0006 97            	ld	xl,a
6432  0007 7b02          	ld	a,(OFST-2,sp)
6433  0009 97            	ld	xl,a
6434                     ; 2677     tmpccr4h = TIM1->CCR4H;
6436  000a c6526b        	ld	a,21099
6437  000d 6b02          	ld	(OFST-2,sp),a
6438                     ; 2678 	tmpccr4l = TIM1->CCR4L;
6440  000f c6526c        	ld	a,21100
6441  0012 6b01          	ld	(OFST-3,sp),a
6442                     ; 2680     tmpccr4 = (u16)(tmpccr4l);
6444  0014 7b01          	ld	a,(OFST-3,sp)
6445  0016 5f            	clrw	x
6446  0017 97            	ld	xl,a
6447  0018 1f03          	ldw	(OFST-1,sp),x
6448                     ; 2681     tmpccr4 |= (u16)((u16)tmpccr4h << 8);
6450  001a 7b02          	ld	a,(OFST-2,sp)
6451  001c 5f            	clrw	x
6452  001d 97            	ld	xl,a
6453  001e 4f            	clr	a
6454  001f 02            	rlwa	x,a
6455  0020 01            	rrwa	x,a
6456  0021 1a04          	or	a,(OFST+0,sp)
6457  0023 01            	rrwa	x,a
6458  0024 1a03          	or	a,(OFST-1,sp)
6459  0026 01            	rrwa	x,a
6460  0027 1f03          	ldw	(OFST-1,sp),x
6461                     ; 2683     return (u16)tmpccr4;
6463  0029 1e03          	ldw	x,(OFST-1,sp)
6466  002b 5b04          	addw	sp,#4
6467  002d 81            	ret
6490                     ; 2703 u16 TIM1_GetCounter(void)
6490                     ; 2704 {
6491                     .text:	section	.text,new
6492  0000               _TIM1_GetCounter:
6494  0000 89            	pushw	x
6495       00000002      OFST:	set	2
6498                     ; 2706   return (u16)(((u16)TIM1->CNTRH << 8) | (u16)(TIM1->CNTRL));
6500  0001 c6525f        	ld	a,21087
6501  0004 5f            	clrw	x
6502  0005 97            	ld	xl,a
6503  0006 1f01          	ldw	(OFST-1,sp),x
6504  0008 c6525e        	ld	a,21086
6505  000b 5f            	clrw	x
6506  000c 97            	ld	xl,a
6507  000d 4f            	clr	a
6508  000e 02            	rlwa	x,a
6509  000f 01            	rrwa	x,a
6510  0010 1a02          	or	a,(OFST+0,sp)
6511  0012 01            	rrwa	x,a
6512  0013 1a01          	or	a,(OFST-1,sp)
6513  0015 01            	rrwa	x,a
6516  0016 5b02          	addw	sp,#2
6517  0018 81            	ret
6540                     ; 2726 u16 TIM1_GetPrescaler(void)
6540                     ; 2727 {
6541                     .text:	section	.text,new
6542  0000               _TIM1_GetPrescaler:
6544  0000 89            	pushw	x
6545       00000002      OFST:	set	2
6548                     ; 2729   return (u16)(((u16)TIM1->PSCRH << 8) | (u16)(TIM1->PSCRL));
6550  0001 c65261        	ld	a,21089
6551  0004 5f            	clrw	x
6552  0005 97            	ld	xl,a
6553  0006 1f01          	ldw	(OFST-1,sp),x
6554  0008 c65260        	ld	a,21088
6555  000b 5f            	clrw	x
6556  000c 97            	ld	xl,a
6557  000d 4f            	clr	a
6558  000e 02            	rlwa	x,a
6559  000f 01            	rrwa	x,a
6560  0010 1a02          	or	a,(OFST+0,sp)
6561  0012 01            	rrwa	x,a
6562  0013 1a01          	or	a,(OFST-1,sp)
6563  0015 01            	rrwa	x,a
6566  0016 5b02          	addw	sp,#2
6567  0018 81            	ret
6741                     ; 2761 FlagStatus TIM1_GetFlagStatus(TIM1_FLAG_TypeDef TIM1_FLAG)
6741                     ; 2762 {
6742                     .text:	section	.text,new
6743  0000               _TIM1_GetFlagStatus:
6745  0000 89            	pushw	x
6746  0001 5203          	subw	sp,#3
6747       00000003      OFST:	set	3
6750                     ; 2763   FlagStatus bitstatus = RESET;
6752  0003 7b03          	ld	a,(OFST+0,sp)
6753  0005 97            	ld	xl,a
6754                     ; 2767   assert_param(IS_TIM1_GET_FLAG_OK(TIM1_FLAG));
6756                     ; 2769   tim1_flag_l = (u8)(TIM1_FLAG);
6758  0006 7b05          	ld	a,(OFST+2,sp)
6759  0008 6b02          	ld	(OFST-1,sp),a
6760                     ; 2770   tim1_flag_h = (u8)((u16)TIM1_FLAG >> 8);
6762  000a 7b04          	ld	a,(OFST+1,sp)
6763  000c 6b03          	ld	(OFST+0,sp),a
6764                     ; 2772   if (((TIM1->SR1 & tim1_flag_l) | (TIM1->SR2 & tim1_flag_h)) != 0)
6766  000e c65256        	ld	a,21078
6767  0011 1403          	and	a,(OFST+0,sp)
6768  0013 6b01          	ld	(OFST-2,sp),a
6769  0015 c65255        	ld	a,21077
6770  0018 1402          	and	a,(OFST-1,sp)
6771  001a 1a01          	or	a,(OFST-2,sp)
6772  001c 2706          	jreq	L5443
6773                     ; 2774     bitstatus = SET;
6775  001e a601          	ld	a,#1
6776  0020 6b03          	ld	(OFST+0,sp),a
6778  0022 2002          	jra	L7443
6779  0024               L5443:
6780                     ; 2778     bitstatus = RESET;
6782  0024 0f03          	clr	(OFST+0,sp)
6783  0026               L7443:
6784                     ; 2780   return (FlagStatus)(bitstatus);
6786  0026 7b03          	ld	a,(OFST+0,sp)
6789  0028 5b05          	addw	sp,#5
6790  002a 81            	ret
6825                     ; 2811 void TIM1_ClearFlag(TIM1_FLAG_TypeDef TIM1_FLAG)
6825                     ; 2812 {
6826                     .text:	section	.text,new
6827  0000               _TIM1_ClearFlag:
6829  0000 89            	pushw	x
6830       00000000      OFST:	set	0
6833                     ; 2814   assert_param(IS_TIM1_CLEAR_FLAG_OK(TIM1_FLAG));
6835                     ; 2817   TIM1->SR1 = (u8)(~(u8)(TIM1_FLAG));
6837  0001 9f            	ld	a,xl
6838  0002 43            	cpl	a
6839  0003 c75255        	ld	21077,a
6840                     ; 2818   TIM1->SR2 = (u8)((u8)(~((u8)((u16)TIM1_FLAG >> 8))) & (u8)0x1E);
6842  0006 7b01          	ld	a,(OFST+1,sp)
6843  0008 43            	cpl	a
6844  0009 a41e          	and	a,#30
6845  000b c75256        	ld	21078,a
6846                     ; 2819 }
6849  000e 85            	popw	x
6850  000f 81            	ret
6914                     ; 2847 ITStatus TIM1_GetITStatus(TIM1_IT_TypeDef TIM1_IT)
6914                     ; 2848 {
6915                     .text:	section	.text,new
6916  0000               _TIM1_GetITStatus:
6918  0000 88            	push	a
6919  0001 89            	pushw	x
6920       00000002      OFST:	set	2
6923                     ; 2849   ITStatus bitstatus = RESET;
6925  0002 7b02          	ld	a,(OFST+0,sp)
6926  0004 97            	ld	xl,a
6927                     ; 2851   u8 TIM1_itStatus = 0x0, TIM1_itEnable = 0x0;
6929  0005 7b01          	ld	a,(OFST-1,sp)
6930  0007 97            	ld	xl,a
6933  0008 7b02          	ld	a,(OFST+0,sp)
6934  000a 97            	ld	xl,a
6935                     ; 2854   assert_param(IS_TIM1_GET_IT_OK(TIM1_IT));
6937                     ; 2856   TIM1_itStatus = (u8)(TIM1->SR1 & (u8)TIM1_IT);
6939  000b c65255        	ld	a,21077
6940  000e 1403          	and	a,(OFST+1,sp)
6941  0010 6b01          	ld	(OFST-1,sp),a
6942                     ; 2858   TIM1_itEnable = (u8)(TIM1->IER & (u8)TIM1_IT);
6944  0012 c65254        	ld	a,21076
6945  0015 1403          	and	a,(OFST+1,sp)
6946  0017 6b02          	ld	(OFST+0,sp),a
6947                     ; 2860   if ((TIM1_itStatus != (u8)RESET ) && (TIM1_itEnable != (u8)RESET ))
6949  0019 0d01          	tnz	(OFST-1,sp)
6950  001b 270a          	jreq	L1253
6952  001d 0d02          	tnz	(OFST+0,sp)
6953  001f 2706          	jreq	L1253
6954                     ; 2862     bitstatus = SET;
6956  0021 a601          	ld	a,#1
6957  0023 6b02          	ld	(OFST+0,sp),a
6959  0025 2002          	jra	L3253
6960  0027               L1253:
6961                     ; 2866     bitstatus = RESET;
6963  0027 0f02          	clr	(OFST+0,sp)
6964  0029               L3253:
6965                     ; 2868   return (ITStatus)(bitstatus);
6967  0029 7b02          	ld	a,(OFST+0,sp)
6970  002b 5b03          	addw	sp,#3
6971  002d 81            	ret
7007                     ; 2895 void TIM1_ClearITPendingBit(TIM1_IT_TypeDef TIM1_IT)
7007                     ; 2896 {
7008                     .text:	section	.text,new
7009  0000               _TIM1_ClearITPendingBit:
7013                     ; 2898   assert_param(IS_TIM1_IT_OK(TIM1_IT));
7015                     ; 2901   TIM1->SR1 = (u8)(~(u8)TIM1_IT);
7017  0000 43            	cpl	a
7018  0001 c75255        	ld	21077,a
7019                     ; 2902 }
7022  0004 81            	ret
7074                     ; 2930 static void TI1_Config(u8 TIM1_ICPolarity,
7074                     ; 2931                        u8 TIM1_ICSelection,
7074                     ; 2932                        u8 TIM1_ICFilter)
7074                     ; 2933 {
7075                     .text:	section	.text,new
7076  0000               L3_TI1_Config:
7078  0000 89            	pushw	x
7079  0001 88            	push	a
7080       00000001      OFST:	set	1
7083                     ; 2936   TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1E);
7085  0002 7211525c      	bres	21084,#0
7086                     ; 2939   TIM1->CCMR1 = (u8)((TIM1->CCMR1 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));
7088  0006 7b06          	ld	a,(OFST+5,sp)
7089  0008 97            	ld	xl,a
7090  0009 a610          	ld	a,#16
7091  000b 42            	mul	x,a
7092  000c 9f            	ld	a,xl
7093  000d 1a03          	or	a,(OFST+2,sp)
7094  000f 6b01          	ld	(OFST+0,sp),a
7095  0011 c65258        	ld	a,21080
7096  0014 a40c          	and	a,#12
7097  0016 1a01          	or	a,(OFST+0,sp)
7098  0018 c75258        	ld	21080,a
7099                     ; 2944   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7101  001b 0d02          	tnz	(OFST+1,sp)
7102  001d 2706          	jreq	L1753
7103                     ; 2946     TIM1->CCER1 |= TIM1_CCER1_CC1P;
7105  001f 7212525c      	bset	21084,#1
7107  0023 2004          	jra	L3753
7108  0025               L1753:
7109                     ; 2950     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC1P);
7111  0025 7213525c      	bres	21084,#1
7112  0029               L3753:
7113                     ; 2954   TIM1->CCER1 |=  TIM1_CCER1_CC1E;
7115  0029 7210525c      	bset	21084,#0
7116                     ; 2955 }
7119  002d 5b03          	addw	sp,#3
7120  002f 81            	ret
7172                     ; 2983 static void TI2_Config(u8 TIM1_ICPolarity,
7172                     ; 2984                        u8 TIM1_ICSelection,
7172                     ; 2985                        u8 TIM1_ICFilter)
7172                     ; 2986 {
7173                     .text:	section	.text,new
7174  0000               L5_TI2_Config:
7176  0000 89            	pushw	x
7177  0001 88            	push	a
7178       00000001      OFST:	set	1
7181                     ; 2988   TIM1->CCER1 &=  (u8)(~TIM1_CCER1_CC2E);
7183  0002 7219525c      	bres	21084,#4
7184                     ; 2991   TIM1->CCMR2  = (u8)((TIM1->CCMR2 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));
7186  0006 7b06          	ld	a,(OFST+5,sp)
7187  0008 97            	ld	xl,a
7188  0009 a610          	ld	a,#16
7189  000b 42            	mul	x,a
7190  000c 9f            	ld	a,xl
7191  000d 1a03          	or	a,(OFST+2,sp)
7192  000f 6b01          	ld	(OFST+0,sp),a
7193  0011 c65259        	ld	a,21081
7194  0014 a40c          	and	a,#12
7195  0016 1a01          	or	a,(OFST+0,sp)
7196  0018 c75259        	ld	21081,a
7197                     ; 2993   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7199  001b 0d02          	tnz	(OFST+1,sp)
7200  001d 2706          	jreq	L3263
7201                     ; 2995     TIM1->CCER1 |= TIM1_CCER1_CC2P;
7203  001f 721a525c      	bset	21084,#5
7205  0023 2004          	jra	L5263
7206  0025               L3263:
7207                     ; 2999     TIM1->CCER1 &= (u8)(~TIM1_CCER1_CC2P);
7209  0025 721b525c      	bres	21084,#5
7210  0029               L5263:
7211                     ; 3002   TIM1->CCER1 |=  TIM1_CCER1_CC2E;
7213  0029 7218525c      	bset	21084,#4
7214                     ; 3003 }
7217  002d 5b03          	addw	sp,#3
7218  002f 81            	ret
7270                     ; 3030 static void TI3_Config(u8 TIM1_ICPolarity,
7270                     ; 3031                        u8 TIM1_ICSelection,
7270                     ; 3032                        u8 TIM1_ICFilter)
7270                     ; 3033 {
7271                     .text:	section	.text,new
7272  0000               L7_TI3_Config:
7274  0000 89            	pushw	x
7275  0001 88            	push	a
7276       00000001      OFST:	set	1
7279                     ; 3035   TIM1->CCER2 &=  (u8)(~TIM1_CCER2_CC3E);
7281  0002 7211525d      	bres	21085,#0
7282                     ; 3038   TIM1->CCMR3 = (u8)((TIM1->CCMR3 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    ))) | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));
7284  0006 7b06          	ld	a,(OFST+5,sp)
7285  0008 97            	ld	xl,a
7286  0009 a610          	ld	a,#16
7287  000b 42            	mul	x,a
7288  000c 9f            	ld	a,xl
7289  000d 1a03          	or	a,(OFST+2,sp)
7290  000f 6b01          	ld	(OFST+0,sp),a
7291  0011 c6525a        	ld	a,21082
7292  0014 a40c          	and	a,#12
7293  0016 1a01          	or	a,(OFST+0,sp)
7294  0018 c7525a        	ld	21082,a
7295                     ; 3041   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7297  001b 0d02          	tnz	(OFST+1,sp)
7298  001d 2706          	jreq	L5563
7299                     ; 3043     TIM1->CCER2 |= TIM1_CCER2_CC3P;
7301  001f 7212525d      	bset	21085,#1
7303  0023 2004          	jra	L7563
7304  0025               L5563:
7305                     ; 3047     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC3P);
7307  0025 7213525d      	bres	21085,#1
7308  0029               L7563:
7309                     ; 3050   TIM1->CCER2 |=  TIM1_CCER2_CC3E;
7311  0029 7210525d      	bset	21085,#0
7312                     ; 3051 }
7315  002d 5b03          	addw	sp,#3
7316  002f 81            	ret
7368                     ; 3079 static void TI4_Config(u8 TIM1_ICPolarity,
7368                     ; 3080                        u8 TIM1_ICSelection,
7368                     ; 3081                        u8 TIM1_ICFilter)
7368                     ; 3082 {
7369                     .text:	section	.text,new
7370  0000               L11_TI4_Config:
7372  0000 89            	pushw	x
7373  0001 88            	push	a
7374       00000001      OFST:	set	1
7377                     ; 3085   TIM1->CCER2 &=  (u8)(~TIM1_CCER2_CC4E);
7379  0002 7219525d      	bres	21085,#4
7380                     ; 3088   TIM1->CCMR4 = (u8)((TIM1->CCMR4 & (u8)(~( TIM1_CCMR_CCxS     |        TIM1_CCMR_ICxF    )))  | (u8)(( (TIM1_ICSelection)) | ((u8)( TIM1_ICFilter << 4))));
7382  0006 7b06          	ld	a,(OFST+5,sp)
7383  0008 97            	ld	xl,a
7384  0009 a610          	ld	a,#16
7385  000b 42            	mul	x,a
7386  000c 9f            	ld	a,xl
7387  000d 1a03          	or	a,(OFST+2,sp)
7388  000f 6b01          	ld	(OFST+0,sp),a
7389  0011 c6525b        	ld	a,21083
7390  0014 a40c          	and	a,#12
7391  0016 1a01          	or	a,(OFST+0,sp)
7392  0018 c7525b        	ld	21083,a
7393                     ; 3093   if (TIM1_ICPolarity != TIM1_ICPOLARITY_RISING)
7395  001b 0d02          	tnz	(OFST+1,sp)
7396  001d 2706          	jreq	L7073
7397                     ; 3095     TIM1->CCER2 |= TIM1_CCER2_CC4P;
7399  001f 721a525d      	bset	21085,#5
7401  0023 2004          	jra	L1173
7402  0025               L7073:
7403                     ; 3099     TIM1->CCER2 &= (u8)(~TIM1_CCER2_CC4P);
7405  0025 721b525d      	bres	21085,#5
7406  0029               L1173:
7407                     ; 3103   TIM1->CCER2 |=  TIM1_CCER2_CC4E;
7409  0029 7218525d      	bset	21085,#4
7410                     ; 3104 }
7413  002d 5b03          	addw	sp,#3
7414  002f 81            	ret
7427                     	xdef	_TIM1_ClearITPendingBit
7428                     	xdef	_TIM1_GetITStatus
7429                     	xdef	_TIM1_ClearFlag
7430                     	xdef	_TIM1_GetFlagStatus
7431                     	xdef	_TIM1_GetPrescaler
7432                     	xdef	_TIM1_GetCounter
7433                     	xdef	_TIM1_GetCapture4
7434                     	xdef	_TIM1_GetCapture3
7435                     	xdef	_TIM1_GetCapture2
7436                     	xdef	_TIM1_GetCapture1
7437                     	xdef	_TIM1_SetIC4Prescaler
7438                     	xdef	_TIM1_SetIC3Prescaler
7439                     	xdef	_TIM1_SetIC2Prescaler
7440                     	xdef	_TIM1_SetIC1Prescaler
7441                     	xdef	_TIM1_SetCompare4
7442                     	xdef	_TIM1_SetCompare3
7443                     	xdef	_TIM1_SetCompare2
7444                     	xdef	_TIM1_SetCompare1
7445                     	xdef	_TIM1_SetAutoreload
7446                     	xdef	_TIM1_SetCounter
7447                     	xdef	_TIM1_SelectOCxM
7448                     	xdef	_TIM1_CCxNCmd
7449                     	xdef	_TIM1_CCxCmd
7450                     	xdef	_TIM1_OC4PolarityConfig
7451                     	xdef	_TIM1_OC3NPolarityConfig
7452                     	xdef	_TIM1_OC3PolarityConfig
7453                     	xdef	_TIM1_OC2NPolarityConfig
7454                     	xdef	_TIM1_OC2PolarityConfig
7455                     	xdef	_TIM1_OC1NPolarityConfig
7456                     	xdef	_TIM1_OC1PolarityConfig
7457                     	xdef	_TIM1_GenerateEvent
7458                     	xdef	_TIM1_OC4FastConfig
7459                     	xdef	_TIM1_OC3FastConfig
7460                     	xdef	_TIM1_OC2FastConfig
7461                     	xdef	_TIM1_OC1FastConfig
7462                     	xdef	_TIM1_OC4PreloadConfig
7463                     	xdef	_TIM1_OC3PreloadConfig
7464                     	xdef	_TIM1_OC2PreloadConfig
7465                     	xdef	_TIM1_OC1PreloadConfig
7466                     	xdef	_TIM1_CCPreloadControl
7467                     	xdef	_TIM1_SelectCOM
7468                     	xdef	_TIM1_ARRPreloadConfig
7469                     	xdef	_TIM1_ForcedOC4Config
7470                     	xdef	_TIM1_ForcedOC3Config
7471                     	xdef	_TIM1_ForcedOC2Config
7472                     	xdef	_TIM1_ForcedOC1Config
7473                     	xdef	_TIM1_CounterModeConfig
7474                     	xdef	_TIM1_PrescalerConfig
7475                     	xdef	_TIM1_EncoderInterfaceConfig
7476                     	xdef	_TIM1_SelectMasterSlaveMode
7477                     	xdef	_TIM1_SelectSlaveMode
7478                     	xdef	_TIM1_SelectOutputTrigger
7479                     	xdef	_TIM1_SelectOnePulseMode
7480                     	xdef	_TIM1_SelectHallSensor
7481                     	xdef	_TIM1_UpdateRequestConfig
7482                     	xdef	_TIM1_UpdateDisableConfig
7483                     	xdef	_TIM1_SelectInputTrigger
7484                     	xdef	_TIM1_TIxExternalClockConfig
7485                     	xdef	_TIM1_ETRConfig
7486                     	xdef	_TIM1_ETRClockMode2Config
7487                     	xdef	_TIM1_ETRClockMode1Config
7488                     	xdef	_TIM1_InternalClockConfig
7489                     	xdef	_TIM1_ITConfig
7490                     	xdef	_TIM1_CtrlPWMOutputs
7491                     	xdef	_TIM1_Cmd
7492                     	xdef	_TIM1_PWMIConfig
7493                     	xdef	_TIM1_ICInit
7494                     	xdef	_TIM1_BDTRConfig
7495                     	xdef	_TIM1_OC4Init
7496                     	xdef	_TIM1_OC3Init
7497                     	xdef	_TIM1_OC2Init
7498                     	xdef	_TIM1_OC1Init
7499                     	xdef	_TIM1_TimeBaseInit
7500                     	xdef	_TIM1_DeInit
7519                     	end
