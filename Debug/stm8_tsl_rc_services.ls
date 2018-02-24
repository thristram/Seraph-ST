   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  70                     ; 51 void TSL_SetStructPointer(void)
  70                     ; 52 {
  72                     .text:	section	.text,new
  73  0000               _TSL_SetStructPointer:
  77                     ; 53   pKeyStruct = &sSCKeyInfo[KeyIndex];
  79  0000 b600          	ld	a,_KeyIndex
  80  0002 97            	ld	xl,a
  81  0003 a60f          	ld	a,#15
  82  0005 42            	mul	x,a
  83  0006 1c0000        	addw	x,#_sSCKeyInfo
  84  0009 bf00          	ldw	_pKeyStruct,x
  85                     ; 54 }
  88  000b 81            	ret
 114                     ; 67 void TSL_DeltaCalculation(void)
 114                     ; 68 {
 115                     .text:	section	.text,new
 116  0000               _TSL_DeltaCalculation:
 120                     ; 69   Delta = (s16)(pKeyStruct->Channel.LastMeas - pKeyStruct->Channel.Reference);
 122  0000 be00          	ldw	x,_pKeyStruct
 123  0002 ee05          	ldw	x,(5,x)
 124  0004 90be00        	ldw	y,_pKeyStruct
 125  0007 90ee08        	ldw	y,(8,y)
 126  000a 90bf00        	ldw	c_x,y
 127  000d 72b00000      	subw	x,c_x
 128  0011 bf00          	ldw	_Delta,x
 129                     ; 70 }
 132  0013 81            	ret
 158                     ; 84 void TSL_SCKey_SetIdleState(void)
 158                     ; 85 {
 159                     .text:	section	.text,new
 160  0000               _TSL_SCKey_SetIdleState:
 164                     ; 86   pKeyStruct->Setting.b.CHANGED = 1;
 166  0000 be00          	ldw	x,_pKeyStruct
 167  0002 e602          	ld	a,(2,x)
 168  0004 aa08          	or	a,#8
 169  0006 e702          	ld	(2,x),a
 170                     ; 87   TSL_SCKey_BackToIdleState();
 172  0008 cd0000        	call	_TSL_SCKey_BackToIdleState
 174                     ; 88 }
 177  000b 81            	ret
 202                     ; 102 void TSL_SCKey_BackToIdleState(void)
 202                     ; 103 {
 203                     .text:	section	.text,new
 204  0000               _TSL_SCKey_BackToIdleState:
 208                     ; 104   pKeyStruct->State.whole = IDLE_STATE;
 210  0000 a602          	ld	a,#2
 211  0002 92c700        	ld	[_pKeyStruct.w],a
 212                     ; 105   pKeyStruct->Setting.b.DETECTED = 0;
 214  0005 be00          	ldw	x,_pKeyStruct
 215  0007 e602          	ld	a,(2,x)
 216  0009 a4fb          	and	a,#251
 217  000b e702          	ld	(2,x),a
 218                     ; 106   pKeyStruct->Setting.b.LOCKED = 0;
 220  000d be00          	ldw	x,_pKeyStruct
 221  000f e602          	ld	a,(2,x)
 222  0011 a47f          	and	a,#127
 223  0013 e702          	ld	(2,x),a
 224                     ; 107   pKeyStruct->Setting.b.ERROR = 0;
 226  0015 be00          	ldw	x,_pKeyStruct
 227  0017 e602          	ld	a,(2,x)
 228  0019 a4df          	and	a,#223
 229  001b e702          	ld	(2,x),a
 230                     ; 108 }
 233  001d 81            	ret
 259                     ; 122 void TSL_SCKey_SetPreDetectState(void)
 259                     ; 123 {
 260                     .text:	section	.text,new
 261  0000               _TSL_SCKey_SetPreDetectState:
 265                     ; 124   pKeyStruct->State.whole = PRE_DETECTED_STATE;
 267  0000 a614          	ld	a,#20
 268  0002 92c700        	ld	[_pKeyStruct.w],a
 269                     ; 125   pKeyStruct->Channel.IntegratorCounter = DetectionIntegrator;
 271  0005 be00          	ldw	x,_pKeyStruct
 272  0007 c60000        	ld	a,_DetectionIntegrator
 273  000a e70a          	ld	(10,x),a
 274                     ; 126 }
 277  000c 81            	ret
 303                     ; 140 void TSL_SCKey_SetDetectedState(void)
 303                     ; 141 {
 304                     .text:	section	.text,new
 305  0000               _TSL_SCKey_SetDetectedState:
 309                     ; 142   pKeyStruct->State.whole = DETECTED_STATE;
 311  0000 a604          	ld	a,#4
 312  0002 92c700        	ld	[_pKeyStruct.w],a
 313                     ; 143   pKeyStruct->Setting.b.DETECTED = 1;
 315  0005 be00          	ldw	x,_pKeyStruct
 316  0007 e602          	ld	a,(2,x)
 317  0009 aa04          	or	a,#4
 318  000b e702          	ld	(2,x),a
 319                     ; 144   pKeyStruct->Setting.b.CHANGED = 1;
 321  000d be00          	ldw	x,_pKeyStruct
 322  000f e602          	ld	a,(2,x)
 323  0011 aa08          	or	a,#8
 324  0013 e702          	ld	(2,x),a
 325                     ; 145   pKeyStruct->Counter = DetectionTimeout;
 327  0015 be00          	ldw	x,_pKeyStruct
 328  0017 c60000        	ld	a,_DetectionTimeout
 329  001a e703          	ld	(3,x),a
 330                     ; 146 }
 333  001c 81            	ret
 359                     ; 160 void TSL_SCKey_SetPostDetectState(void)
 359                     ; 161 {
 360                     .text:	section	.text,new
 361  0000               _TSL_SCKey_SetPostDetectState:
 365                     ; 162   pKeyStruct->State.whole = POST_DETECTED_STATE;
 367  0000 a624          	ld	a,#36
 368  0002 92c700        	ld	[_pKeyStruct.w],a
 369                     ; 163   pKeyStruct->Channel.IntegratorCounter = EndDetectionIntegrator;
 371  0005 be00          	ldw	x,_pKeyStruct
 372  0007 c60000        	ld	a,_EndDetectionIntegrator
 373  000a e70a          	ld	(10,x),a
 374                     ; 164 }
 377  000c 81            	ret
 402                     ; 178 void TSL_SCKey_BackToDetectedState(void)
 402                     ; 179 {
 403                     .text:	section	.text,new
 404  0000               _TSL_SCKey_BackToDetectedState:
 408                     ; 180   pKeyStruct->State.whole = DETECTED_STATE;
 410  0000 a604          	ld	a,#4
 411  0002 92c700        	ld	[_pKeyStruct.w],a
 412                     ; 181 }
 415  0005 81            	ret
 441                     ; 195 void TSL_SCKey_SetPreRecalibrationState(void)
 441                     ; 196 {
 442                     .text:	section	.text,new
 443  0000               _TSL_SCKey_SetPreRecalibrationState:
 447                     ; 197   pKeyStruct->State.whole = PRE_CALIBRATION_STATE;
 449  0000 a611          	ld	a,#17
 450  0002 92c700        	ld	[_pKeyStruct.w],a
 451                     ; 198   pKeyStruct->Channel.IntegratorCounter = RecalibrationIntegrator;
 453  0005 be00          	ldw	x,_pKeyStruct
 454  0007 c60000        	ld	a,_RecalibrationIntegrator
 455  000a e70a          	ld	(10,x),a
 456                     ; 199 }
 459  000c 81            	ret
 484                     ; 213 void TSL_SCKey_SetCalibrationState(void)
 484                     ; 214 {
 485                     .text:	section	.text,new
 486  0000               _TSL_SCKey_SetCalibrationState:
 490                     ; 215   pKeyStruct->State.whole = CALIBRATION_STATE;
 492  0000 a601          	ld	a,#1
 493  0002 92c700        	ld	[_pKeyStruct.w],a
 494                     ; 216   pKeyStruct->Setting.b.DETECTED = 0;
 496  0005 be00          	ldw	x,_pKeyStruct
 497  0007 e602          	ld	a,(2,x)
 498  0009 a4fb          	and	a,#251
 499  000b e702          	ld	(2,x),a
 500                     ; 217   pKeyStruct->Setting.b.CHANGED = 1;
 502  000d be00          	ldw	x,_pKeyStruct
 503  000f e602          	ld	a,(2,x)
 504  0011 aa08          	or	a,#8
 505  0013 e702          	ld	(2,x),a
 506                     ; 218   pKeyStruct->Setting.b.LOCKED = 0;
 508  0015 be00          	ldw	x,_pKeyStruct
 509  0017 e602          	ld	a,(2,x)
 510  0019 a47f          	and	a,#127
 511  001b e702          	ld	(2,x),a
 512                     ; 219   pKeyStruct->Setting.b.ERROR = 0;
 514  001d be00          	ldw	x,_pKeyStruct
 515  001f e602          	ld	a,(2,x)
 516  0021 a4df          	and	a,#223
 517  0023 e702          	ld	(2,x),a
 518                     ; 220   pKeyStruct->Counter = SCKEY_CALIBRATION_COUNT_DEFAULT;
 520  0025 be00          	ldw	x,_pKeyStruct
 521  0027 a608          	ld	a,#8
 522  0029 e703          	ld	(3,x),a
 523                     ; 221   pKeyStruct->Channel.Reference = 0;
 525  002b be00          	ldw	x,_pKeyStruct
 526  002d 905f          	clrw	y
 527  002f ef08          	ldw	(8,x),y
 528                     ; 222 }
 531  0031 81            	ret
 556                     ; 236 void TSL_SCKey_SetErrorState(void)
 556                     ; 237 {
 557                     .text:	section	.text,new
 558  0000               _TSL_SCKey_SetErrorState:
 562                     ; 238   pKeyStruct->State.whole = ERROR_STATE;
 564  0000 a608          	ld	a,#8
 565  0002 92c700        	ld	[_pKeyStruct.w],a
 566                     ; 239   pKeyStruct->Setting.b.DETECTED = 0;
 568  0005 be00          	ldw	x,_pKeyStruct
 569  0007 e602          	ld	a,(2,x)
 570  0009 a4fb          	and	a,#251
 571  000b e702          	ld	(2,x),a
 572                     ; 240   pKeyStruct->Setting.b.CHANGED = 1;
 574  000d be00          	ldw	x,_pKeyStruct
 575  000f e602          	ld	a,(2,x)
 576  0011 aa08          	or	a,#8
 577  0013 e702          	ld	(2,x),a
 578                     ; 241   pKeyStruct->Setting.b.LOCKED = 0;
 580  0015 be00          	ldw	x,_pKeyStruct
 581  0017 e602          	ld	a,(2,x)
 582  0019 a47f          	and	a,#127
 583  001b e702          	ld	(2,x),a
 584                     ; 242   pKeyStruct->Setting.b.ERROR = 1;
 586  001d be00          	ldw	x,_pKeyStruct
 587  001f e602          	ld	a,(2,x)
 588  0021 aa20          	or	a,#32
 589  0023 e702          	ld	(2,x),a
 590                     ; 243 }
 593  0025 81            	ret
 618                     ; 257 void TSL_SCKey_SetDisabledState(void)
 618                     ; 258 {
 619                     .text:	section	.text,new
 620  0000               _TSL_SCKey_SetDisabledState:
 624                     ; 259   pKeyStruct->State.whole = DISABLED_STATE;
 626  0000 a680          	ld	a,#128
 627  0002 92c700        	ld	[_pKeyStruct.w],a
 628                     ; 260   pKeyStruct->Setting.b.DETECTED = 0;
 630  0005 be00          	ldw	x,_pKeyStruct
 631  0007 e602          	ld	a,(2,x)
 632  0009 a4fb          	and	a,#251
 633  000b e702          	ld	(2,x),a
 634                     ; 261   pKeyStruct->Setting.b.CHANGED = 1;
 636  000d be00          	ldw	x,_pKeyStruct
 637  000f e602          	ld	a,(2,x)
 638  0011 aa08          	or	a,#8
 639  0013 e702          	ld	(2,x),a
 640                     ; 262   pKeyStruct->Setting.b.LOCKED = 0;
 642  0015 be00          	ldw	x,_pKeyStruct
 643  0017 e602          	ld	a,(2,x)
 644  0019 a47f          	and	a,#127
 645  001b e702          	ld	(2,x),a
 646                     ; 263   pKeyStruct->Setting.b.ERROR = 0;
 648  001d be00          	ldw	x,_pKeyStruct
 649  001f e602          	ld	a,(2,x)
 650  0021 a4df          	and	a,#223
 651  0023 e702          	ld	(2,x),a
 652                     ; 264 }
 655  0025 81            	ret
 732                     ; 280 void TSL_ECS(void)
 732                     ; 281 {
 733                     .text:	section	.text,new
 734  0000               _TSL_ECS:
 736  0000 520b          	subw	sp,#11
 737       0000000b      OFST:	set	11
 740                     ; 287   disableInterrupts();
 743  0002 9b            sim
 745                     ; 288   Local_TickECS10ms = TSL_TickCount_ECS_10ms;
 748  0003 450000        	mov	_Local_TickECS10ms,_TSL_TickCount_ECS_10ms
 749                     ; 289   TSL_TickCount_ECS_10ms = 0;
 751  0006 3f00          	clr	_TSL_TickCount_ECS_10ms
 752                     ; 290   enableInterrupts();
 755  0008 9a            rim
 759  0009 ac1f011f      	jpf	L312
 760  000d               L112:
 761                     ; 294     ECSTimeStepCounter--;
 763  000d 3a00          	dec	_ECSTimeStepCounter
 764                     ; 295     ECSTempoPrescaler--;
 766  000f 725a0000      	dec	_ECSTempoPrescaler
 767                     ; 296     if ( !ECSTempoPrescaler )
 769  0013 725d0000      	tnz	_ECSTempoPrescaler
 770  0017 260e          	jrne	L712
 771                     ; 298       ECSTempoPrescaler = 10;
 773  0019 350a0000      	mov	_ECSTempoPrescaler,#10
 774                     ; 299       if ( ECSTempoCounter )
 776  001d 725d0000      	tnz	_ECSTempoCounter
 777  0021 2704          	jreq	L712
 778                     ; 300         ECSTempoCounter--;
 780  0023 725a0000      	dec	_ECSTempoCounter
 781  0027               L712:
 782                     ; 303     K_Filter = ECS_K_Slow;   // Default case !
 784  0027 c60000        	ld	a,_ECS_K_Slow
 785  002a 6b05          	ld	(OFST-6,sp),a
 786                     ; 304     ECS_Fast_Enable = 1;
 788  002c a601          	ld	a,#1
 789  002e 6b07          	ld	(OFST-4,sp),a
 790                     ; 305     ECS_Fast_Direction = 0;
 792  0030 0f06          	clr	(OFST-5,sp)
 793                     ; 306     for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
 795  0032 3f00          	clr	_KeyIndex
 796  0034               L322:
 797                     ; 308       TSL_SetStructPointer();
 799  0034 cd0000        	call	_TSL_SetStructPointer
 801                     ; 310       if ( pKeyStruct->State.whole & (PRE_DETECTED_STATE | DETECTED_STATE | POST_DETECTED_STATE) )
 803  0037 92c600        	ld	a,[_pKeyStruct.w]
 804  003a a534          	bcp	a,#52
 805  003c 2707          	jreq	L132
 806                     ; 312         ECSTempoCounter = ECSTemporization;    // Restart temporization counter ...
 808  003e 5500000000    	mov	_ECSTempoCounter,_ECSTemporization
 809                     ; 313         break;           // Out from the for loop
 811  0043 203b          	jra	L722
 812  0045               L132:
 813                     ; 315       if ( pKeyStruct->State.whole == IDLE_STATE )
 815  0045 92c600        	ld	a,[_pKeyStruct.w]
 816  0048 a102          	cp	a,#2
 817  004a 262c          	jrne	L332
 818                     ; 317         TSL_DeltaCalculation();
 820  004c cd0000        	call	_TSL_DeltaCalculation
 822                     ; 318         if ( Delta == 0 )  // No Fast ECS !
 824  004f be00          	ldw	x,_Delta
 825  0051 2604          	jrne	L532
 826                     ; 319           ECS_Fast_Enable = 0;
 828  0053 0f07          	clr	(OFST-4,sp)
 830  0055 2021          	jra	L332
 831  0057               L532:
 832                     ; 322           if ( Delta < 0 )
 834  0057 9c            	rvf
 835  0058 be00          	ldw	x,_Delta
 836  005a 2e0f          	jrsge	L142
 837                     ; 324             if ( ECS_Fast_Direction > 0 )  // No Fast ECS !
 839  005c 9c            	rvf
 840  005d 0d06          	tnz	(OFST-5,sp)
 841  005f 2d04          	jrsle	L342
 842                     ; 325               ECS_Fast_Enable = 0;
 844  0061 0f07          	clr	(OFST-4,sp)
 846  0063 2013          	jra	L332
 847  0065               L342:
 848                     ; 327               ECS_Fast_Direction = -1;
 850  0065 a6ff          	ld	a,#255
 851  0067 6b06          	ld	(OFST-5,sp),a
 852  0069 200d          	jra	L332
 853  006b               L142:
 854                     ; 331             if ( ECS_Fast_Direction < 0 )  // No Fast ECS !
 856  006b 9c            	rvf
 857  006c 0d06          	tnz	(OFST-5,sp)
 858  006e 2e04          	jrsge	L152
 859                     ; 332               ECS_Fast_Enable = 0;
 861  0070 0f07          	clr	(OFST-4,sp)
 863  0072 2004          	jra	L332
 864  0074               L152:
 865                     ; 334               ECS_Fast_Direction = + 1;
 867  0074 a601          	ld	a,#1
 868  0076 6b06          	ld	(OFST-5,sp),a
 869  0078               L332:
 870                     ; 306     for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
 872  0078 3c00          	inc	_KeyIndex
 875  007a b600          	ld	a,_KeyIndex
 876  007c a103          	cp	a,#3
 877  007e 25b4          	jrult	L322
 878  0080               L722:
 879                     ; 385     if ( !ECSTimeStepCounter && !ECSTempoCounter )
 881  0080 3d00          	tnz	_ECSTimeStepCounter
 882  0082 2703          	jreq	L63
 883  0084 cc011f        	jp	L312
 884  0087               L63:
 886  0087 725d0000      	tnz	_ECSTempoCounter
 887  008b 2703          	jreq	L04
 888  008d cc011f        	jp	L312
 889  0090               L04:
 890                     ; 387       ECSTimeStepCounter = ECSTimeStep;
 892  0090 5500000000    	mov	_ECSTimeStepCounter,_ECSTimeStep
 893                     ; 389       if (ECS_Fast_Enable)
 895  0095 0d07          	tnz	(OFST-4,sp)
 896  0097 2705          	jreq	L752
 897                     ; 391         K_Filter = ECS_K_Fast;
 899  0099 c60000        	ld	a,_ECS_K_Fast
 900  009c 6b05          	ld	(OFST-6,sp),a
 901  009e               L752:
 902                     ; 394       K_Filter_Complement = (u8)((0xFF ^ K_Filter) + 1);
 904  009e 7b05          	ld	a,(OFST-6,sp)
 905  00a0 a8ff          	xor	a,#255
 906  00a2 4c            	inc	a
 907  00a3 6b07          	ld	(OFST-4,sp),a
 908                     ; 396       if ( K_Filter )
 910  00a5 0d05          	tnz	(OFST-6,sp)
 911  00a7 2602          	jrne	L24
 912  00a9 2074          	jp	L312
 913  00ab               L24:
 914                     ; 399         for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
 916  00ab 3f00          	clr	_KeyIndex
 917  00ad               L362:
 918                     ; 401           TSL_SetStructPointer();
 920  00ad cd0000        	call	_TSL_SetStructPointer
 922                     ; 402           if ( pKeyStruct->State.whole == IDLE_STATE )
 924  00b0 92c600        	ld	a,[_pKeyStruct.w]
 925  00b3 a102          	cp	a,#2
 926  00b5 2660          	jrne	L172
 927                     ; 404             IIR_Result = ((u32)(pKeyStruct->Channel.Reference) << 8) + pKeyStruct->Channel.ECSRefRest;
 929  00b7 be00          	ldw	x,_pKeyStruct
 930  00b9 ee08          	ldw	x,(8,x)
 931  00bb 90ae0100      	ldw	y,#256
 932  00bf cd0000        	call	c_umul
 934  00c2 be00          	ldw	x,_pKeyStruct
 935  00c4 e60b          	ld	a,(11,x)
 936  00c6 cd0000        	call	c_ladc
 938  00c9 96            	ldw	x,sp
 939  00ca 1c0008        	addw	x,#OFST-3
 940  00cd cd0000        	call	c_rtol
 942                     ; 405             IIR_Result = K_Filter_Complement * IIR_Result;
 944  00d0 7b07          	ld	a,(OFST-4,sp)
 945  00d2 b703          	ld	c_lreg+3,a
 946  00d4 3f02          	clr	c_lreg+2
 947  00d6 3f01          	clr	c_lreg+1
 948  00d8 3f00          	clr	c_lreg
 949  00da 96            	ldw	x,sp
 950  00db 1c0008        	addw	x,#OFST-3
 951  00de cd0000        	call	c_lgmul
 953                     ; 406             IIR_Result += K_Filter * ((u32)(pKeyStruct->Channel.LastMeas) << 8);
 955  00e1 7b05          	ld	a,(OFST-6,sp)
 956  00e3 b703          	ld	c_lreg+3,a
 957  00e5 3f02          	clr	c_lreg+2
 958  00e7 3f01          	clr	c_lreg+1
 959  00e9 3f00          	clr	c_lreg
 960  00eb 96            	ldw	x,sp
 961  00ec 1c0001        	addw	x,#OFST-10
 962  00ef cd0000        	call	c_rtol
 964  00f2 be00          	ldw	x,_pKeyStruct
 965  00f4 ee05          	ldw	x,(5,x)
 966  00f6 90ae0100      	ldw	y,#256
 967  00fa cd0000        	call	c_umul
 969  00fd 96            	ldw	x,sp
 970  00fe 1c0001        	addw	x,#OFST-10
 971  0101 cd0000        	call	c_lmul
 973  0104 96            	ldw	x,sp
 974  0105 1c0008        	addw	x,#OFST-3
 975  0108 cd0000        	call	c_lgadd
 977                     ; 407             pKeyStruct->Channel.Reference = (u16)(IIR_Result >> 16);
 979  010b be00          	ldw	x,_pKeyStruct
 980  010d 1608          	ldw	y,(OFST-3,sp)
 981  010f ef08          	ldw	(8,x),y
 982                     ; 408             pKeyStruct->Channel.ECSRefRest = (u8)(IIR_Result >> 8);
 984  0111 7b0a          	ld	a,(OFST-1,sp)
 985  0113 be00          	ldw	x,_pKeyStruct
 986  0115 e70b          	ld	(11,x),a
 987  0117               L172:
 988                     ; 399         for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
 990  0117 3c00          	inc	_KeyIndex
 993  0119 b600          	ld	a,_KeyIndex
 994  011b a103          	cp	a,#3
 995  011d 258e          	jrult	L362
 996  011f               L312:
 997                     ; 292   while ( Local_TickECS10ms-- )
 999  011f b600          	ld	a,_Local_TickECS10ms
1000  0121 3a00          	dec	_Local_TickECS10ms
1001  0123 4d            	tnz	a
1002  0124 2703          	jreq	L44
1003  0126 cc000d        	jp	L112
1004  0129               L44:
1005                     ; 431 }
1008  0129 5b0b          	addw	sp,#11
1009  012b 81            	ret
1051                     ; 445 void TSL_SCKey_DES(void)
1051                     ; 446 {
1052                     .text:	section	.text,new
1053  0000               _TSL_SCKey_DES:
1055  0000 89            	pushw	x
1056       00000002      OFST:	set	2
1059                     ; 450   if ( pKeyStruct->Setting.b.LOCKED )
1061  0001 be00          	ldw	x,_pKeyStruct
1062  0003 e602          	ld	a,(2,x)
1063  0005 a580          	bcp	a,#128
1064  0007 262c          	jrne	L05
1065                     ; 451     return;
1067                     ; 453   DESGroupMask = pKeyStruct->DESGroup;
1069  0009 be00          	ldw	x,_pKeyStruct
1070  000b e604          	ld	a,(4,x)
1071  000d 6b01          	ld	(OFST-1,sp),a
1072                     ; 455   for ( KeyToCheck = 0; KeyToCheck < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyToCheck++ )
1074  000f 0f02          	clr	(OFST+0,sp)
1075  0011               L513:
1076                     ; 457     if ( KeyToCheck != KeyIndex )
1078  0011 7b02          	ld	a,(OFST+0,sp)
1079  0013 b100          	cp	a,_KeyIndex
1080  0015 2720          	jreq	L323
1081                     ; 460       if ( sSCKeyInfo[KeyToCheck].DESGroup & DESGroupMask )
1083  0017 7b02          	ld	a,(OFST+0,sp)
1084  0019 97            	ld	xl,a
1085  001a a60f          	ld	a,#15
1086  001c 42            	mul	x,a
1087  001d d60004        	ld	a,(_sSCKeyInfo+4,x)
1088  0020 1501          	bcp	a,(OFST-1,sp)
1089  0022 2713          	jreq	L323
1090                     ; 462         if ( sSCKeyInfo[KeyToCheck].Setting.b.LOCKED )
1092  0024 7b02          	ld	a,(OFST+0,sp)
1093  0026 97            	ld	xl,a
1094  0027 a60f          	ld	a,#15
1095  0029 42            	mul	x,a
1096  002a d60002        	ld	a,(_sSCKeyInfo+2,x)
1097  002d a580          	bcp	a,#128
1098  002f 2706          	jreq	L323
1099                     ; 464           goto ExitToIdle;
1100                     ; 487 ExitToIdle:   // The DES is verified at PRE DETECT state only !
1100                     ; 488   pKeyStruct->Channel.IntegratorCounter++;  // Increment integrator to never allow DETECT state
1102  0031 be00          	ldw	x,_pKeyStruct
1103  0033 6c0a          	inc	(10,x)
1104                     ; 489   return;
1105  0035               L05:
1108  0035 85            	popw	x
1109  0036 81            	ret
1110  0037               L323:
1111                     ; 455   for ( KeyToCheck = 0; KeyToCheck < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyToCheck++ )
1113  0037 0c02          	inc	(OFST+0,sp)
1116  0039 7b02          	ld	a,(OFST+0,sp)
1117  003b a103          	cp	a,#3
1118  003d 25d2          	jrult	L513
1119                     ; 484   pKeyStruct->Setting.b.LOCKED = 1;
1121  003f be00          	ldw	x,_pKeyStruct
1122  0041 e602          	ld	a,(2,x)
1123  0043 aa80          	or	a,#128
1124  0045 e702          	ld	(2,x),a
1125                     ; 485   return;
1127  0047 20ec          	jra	L05
1155                     ; 503 void TSL_SCKey_DetectionTimeout(void)
1155                     ; 504 {
1156                     .text:	section	.text,new
1157  0000               _TSL_SCKey_DetectionTimeout:
1161                     ; 505   if ( Local_TickFlag.b.DTO_1sec )
1163  0000 b600          	ld	a,_Local_TickFlag
1164  0002 a501          	bcp	a,#1
1165  0004 2713          	jreq	L143
1166                     ; 507     if ( DetectionTimeout )
1168  0006 725d0000      	tnz	_DetectionTimeout
1169  000a 270d          	jreq	L143
1170                     ; 509       pKeyStruct->Counter--;
1172  000c be00          	ldw	x,_pKeyStruct
1173  000e 6a03          	dec	(3,x)
1174                     ; 510       if ( !pKeyStruct->Counter )
1176  0010 be00          	ldw	x,_pKeyStruct
1177  0012 6d03          	tnz	(3,x)
1178  0014 2603          	jrne	L143
1179                     ; 512         TSL_SCKey_SetCalibrationState( );
1181  0016 cd0000        	call	_TSL_SCKey_SetCalibrationState
1183  0019               L143:
1184                     ; 516 }
1187  0019 81            	ret
1200                     	xdef	_TSL_SCKey_DetectionTimeout
1201                     	xdef	_TSL_SCKey_DES
1202                     	xdef	_TSL_ECS
1203                     	xdef	_TSL_SCKey_SetDisabledState
1204                     	xdef	_TSL_SCKey_SetErrorState
1205                     	xdef	_TSL_SCKey_SetPreRecalibrationState
1206                     	xdef	_TSL_SCKey_BackToDetectedState
1207                     	xdef	_TSL_SCKey_SetPostDetectState
1208                     	xdef	_TSL_SCKey_SetDetectedState
1209                     	xdef	_TSL_SCKey_SetPreDetectState
1210                     	xdef	_TSL_SCKey_BackToIdleState
1211                     	xdef	_TSL_SCKey_SetIdleState
1212                     	xdef	_TSL_DeltaCalculation
1213                     	xdef	_TSL_SetStructPointer
1214                     	xref	_ECSTempoPrescaler
1215                     	xref	_ECSTempoCounter
1216                     	xref.b	_ECSTimeStepCounter
1217                     	xref.b	_Local_TickFlag
1218                     	xref.b	_Local_TickECS10ms
1219                     	xref.b	_Delta
1220                     	xref.b	_KeyIndex
1221                     	xdef	_TSL_SCKey_SetCalibrationState
1222                     	xref	_ECS_K_Slow
1223                     	xref	_ECS_K_Fast
1224                     	xref	_ECSTemporization
1225                     	xref	_ECSTimeStep
1226                     	xref	_RecalibrationIntegrator
1227                     	xref	_EndDetectionIntegrator
1228                     	xref	_DetectionIntegrator
1229                     	xref	_DetectionTimeout
1230                     	xref	_sSCKeyInfo
1231                     	xref.b	_pKeyStruct
1232                     	xref.b	_TSL_TickCount_ECS_10ms
1233                     	xref.b	c_lreg
1234                     	xref.b	c_x
1253                     	xref	c_lgadd
1254                     	xref	c_lmul
1255                     	xref	c_lgmul
1256                     	xref	c_rtol
1257                     	xref	c_ladc
1258                     	xref	c_umul
1259                     	end
