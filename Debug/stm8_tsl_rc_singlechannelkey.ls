   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  69                     ; 46 void TSL_SCKey_Init(void)
  69                     ; 47 {
  71                     .text:	section	.text,new
  72  0000               _TSL_SCKey_Init:
  76                     ; 49   for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
  78  0000 3f00          	clr	_KeyIndex
  79  0002               L53:
  80                     ; 51     TSL_SetStructPointer();
  82  0002 cd0000        	call	_TSL_SetStructPointer
  84                     ; 52     pKeyStruct->State.whole = DISABLED_STATE;
  86  0005 a680          	ld	a,#128
  87  0007 92c700        	ld	[_pKeyStruct.w],a
  88                     ; 53     pKeyStruct->DetectThreshold = SCKEY_DETECTTHRESHOLD_DEFAULT;
  90  000a be00          	ldw	x,_pKeyStruct
  91  000c a61e          	ld	a,#30
  92  000e e70c          	ld	(12,x),a
  93                     ; 54     pKeyStruct->EndDetectThreshold = SCKEY_ENDDETECTTHRESHOLD_DEFAULT;
  95  0010 be00          	ldw	x,_pKeyStruct
  96  0012 a612          	ld	a,#18
  97  0014 e70d          	ld	(13,x),a
  98                     ; 55     pKeyStruct->RecalibrationThreshold = SCKEY_RECALIBRATIONTHRESHOLD_DEFAULT;
 100  0016 be00          	ldw	x,_pKeyStruct
 101  0018 a6ee          	ld	a,#238
 102  001a e70e          	ld	(14,x),a
 103                     ; 49   for ( KeyIndex = 0; KeyIndex < NUMBER_OF_SINGLE_CHANNEL_KEYS; KeyIndex++ )
 105  001c 3c00          	inc	_KeyIndex
 108  001e b600          	ld	a,_KeyIndex
 109  0020 a103          	cp	a,#3
 110  0022 25de          	jrult	L53
 111                     ; 57 }
 114  0024 81            	ret
 145                     ; 70 void TSL_SCKEY_P1_Acquisition(void)
 145                     ; 71 {
 146                     .text:	section	.text,new
 147  0000               _TSL_SCKEY_P1_Acquisition:
 151                     ; 73   sTouchIO.PORT_ADDR = (GPIO_TypeDef *) (SCKEY_P1_PORT_ADDR);
 153  0000 ae500f        	ldw	x,#20495
 154  0003 bf00          	ldw	_sTouchIO,x
 155                     ; 74   for ( KeyIndex = 0; KeyIndex < SCKEY_P1_KEY_COUNT; KeyIndex++ )
 157  0005 3f00          	clr	_KeyIndex
 158  0007               L35:
 159                     ; 76     TSL_SetStructPointer();
 161  0007 cd0000        	call	_TSL_SetStructPointer
 163                     ; 77     if ( (pKeyStruct->State.whole != ERROR_STATE) && (pKeyStruct->State.whole != DISABLED_STATE) )
 165  000a 92c600        	ld	a,[_pKeyStruct.w]
 166  000d a108          	cp	a,#8
 167  000f 2737          	jreq	L16
 169  0011 92c600        	ld	a,[_pKeyStruct.w]
 170  0014 a180          	cp	a,#128
 171  0016 2730          	jreq	L16
 172                     ; 79       sTouchIO.AcqMask = Table_SCKEY_BITS[KeyIndex];
 174  0018 b600          	ld	a,_KeyIndex
 175  001a 5f            	clrw	x
 176  001b 97            	ld	xl,a
 177  001c d60000        	ld	a,(_Table_SCKEY_BITS,x)
 178  001f b702          	ld	_sTouchIO+2,a
 179                     ; 80       sTouchIO.DriveMask = (u8)(sTouchIO.AcqMask | SCKEY_P1_DRIVEN_SHIELD_MASK);
 181  0021 b602          	ld	a,_sTouchIO+2
 182  0023 aa80          	or	a,#128
 183  0025 b703          	ld	_sTouchIO+3,a
 184                     ; 81       sTouchIO.Measurement = &sSCKeyInfo[KeyIndex].Channel.LastMeas;
 186  0027 b600          	ld	a,_KeyIndex
 187  0029 97            	ld	xl,a
 188  002a a60f          	ld	a,#15
 189  002c 42            	mul	x,a
 190  002d 1c0005        	addw	x,#_sSCKeyInfo+5
 191  0030 bf04          	ldw	_sTouchIO+4,x
 192                     ; 82       sTouchIO.RejectedNb = &sSCKeyInfo[KeyIndex].Channel.LastMeasRejectNb;
 194  0032 b600          	ld	a,_KeyIndex
 195  0034 97            	ld	xl,a
 196  0035 a60f          	ld	a,#15
 197  0037 42            	mul	x,a
 198  0038 1c0007        	addw	x,#_sSCKeyInfo+7
 199  003b bf06          	ldw	_sTouchIO+6,x
 200                     ; 83       sTouchIO.Type = SCKEY_TYPE;
 202  003d 3f08          	clr	_sTouchIO+8
 203                     ; 84       TSL_IO_Acquisition(SCKEY_ACQ_NUM, SCKEY_ADJUST_LEVEL);
 205  003f ae0002        	ldw	x,#2
 206  0042 a603          	ld	a,#3
 207  0044 95            	ld	xh,a
 208  0045 cd0000        	call	_TSL_IO_Acquisition
 210  0048               L16:
 211                     ; 74   for ( KeyIndex = 0; KeyIndex < SCKEY_P1_KEY_COUNT; KeyIndex++ )
 213  0048 3c00          	inc	_KeyIndex
 216  004a b600          	ld	a,_KeyIndex
 217  004c a103          	cp	a,#3
 218  004e 25b7          	jrult	L35
 219                     ; 87 }
 222  0050 81            	ret
 260                     ; 164 void TSL_SCKey_Process(void)
 260                     ; 165 {
 261                     .text:	section	.text,new
 262  0000               _TSL_SCKey_Process:
 266                     ; 167   TSL_SetStructPointer();
 268  0000 cd0000        	call	_TSL_SetStructPointer
 270                     ; 169   TSL_DeltaCalculation();
 272  0003 cd0000        	call	_TSL_DeltaCalculation
 274                     ; 171   switch ( pKeyStruct->State.whole )
 276  0006 92c600        	ld	a,[_pKeyStruct.w]
 278                     ; 222       break;
 279  0009 4a            	dec	a
 280  000a 2752          	jreq	L57
 281  000c 4a            	dec	a
 282  000d 271a          	jreq	L36
 283  000f a002          	sub	a,#2
 284  0011 272e          	jreq	L76
 285  0013 a004          	sub	a,#4
 286  0015 275a          	jreq	L77
 287  0017 a009          	sub	a,#9
 288  0019 273e          	jreq	L37
 289  001b a003          	sub	a,#3
 290  001d 271d          	jreq	L56
 291  001f a010          	sub	a,#16
 292  0021 2731          	jreq	L17
 293  0023 a05c          	sub	a,#92
 294  0025 274f          	jreq	L101
 295  0027               L721:
 297  0027 20fe          	jra	L721
 298  0029               L36:
 299                     ; 174     case IDLE_STATE:
 299                     ; 175       if ( TSL_SCKey_CheckErrorCondition() )
 301  0029 cd0000        	call	_TSL_SCKey_CheckErrorCondition
 303  002c 4d            	tnz	a
 304  002d 2705          	jreq	L121
 305                     ; 177         TSL_SCKey_SetErrorState();
 307  002f cd0000        	call	_TSL_SCKey_SetErrorState
 309                     ; 178         break;
 311  0032 2045          	jra	L711
 312  0034               L121:
 313                     ; 180       TSL_SCKey_IdleTreatment( );
 315  0034 cd0000        	call	_TSL_SCKey_IdleTreatment
 317                     ; 181       TSL_SCKey_CheckDisabled( );
 319  0037 cd0000        	call	_TSL_SCKey_CheckDisabled
 321                     ; 182       break;
 323  003a 203d          	jra	L711
 324  003c               L56:
 325                     ; 184     case PRE_DETECTED_STATE:
 325                     ; 185       TSL_SCKey_PreDetectTreatment( );
 327  003c cd0000        	call	_TSL_SCKey_PreDetectTreatment
 329                     ; 186       break;
 331  003f 2038          	jra	L711
 332  0041               L76:
 333                     ; 188     case DETECTED_STATE:
 333                     ; 189       if ( TSL_SCKey_CheckErrorCondition() )
 335  0041 cd0000        	call	_TSL_SCKey_CheckErrorCondition
 337  0044 4d            	tnz	a
 338  0045 2705          	jreq	L321
 339                     ; 191         TSL_SCKey_SetErrorState();
 341  0047 cd0000        	call	_TSL_SCKey_SetErrorState
 343                     ; 192         break;
 345  004a 202d          	jra	L711
 346  004c               L321:
 347                     ; 194       TSL_SCKey_DetectedTreatment( );
 349  004c cd0000        	call	_TSL_SCKey_DetectedTreatment
 351                     ; 195       TSL_SCKey_CheckDisabled( );
 353  004f cd0000        	call	_TSL_SCKey_CheckDisabled
 355                     ; 196       break;
 357  0052 2025          	jra	L711
 358  0054               L17:
 359                     ; 198     case POST_DETECTED_STATE:
 359                     ; 199       TSL_SCKey_PostDetectTreatment( );
 361  0054 cd0000        	call	_TSL_SCKey_PostDetectTreatment
 363                     ; 200       break;
 365  0057 2020          	jra	L711
 366  0059               L37:
 367                     ; 202     case PRE_CALIBRATION_STATE:
 367                     ; 203       TSL_SCKey_PreRecalibrationTreatment( );
 369  0059 cd0000        	call	_TSL_SCKey_PreRecalibrationTreatment
 371                     ; 204       break;
 373  005c 201b          	jra	L711
 374  005e               L57:
 375                     ; 206     case CALIBRATION_STATE:
 375                     ; 207       if ( TSL_SCKey_CheckErrorCondition() )
 377  005e cd0000        	call	_TSL_SCKey_CheckErrorCondition
 379  0061 4d            	tnz	a
 380  0062 2705          	jreq	L521
 381                     ; 209         TSL_SCKey_SetErrorState();
 383  0064 cd0000        	call	_TSL_SCKey_SetErrorState
 385                     ; 210         break;
 387  0067 2010          	jra	L711
 388  0069               L521:
 389                     ; 212       TSL_SCKey_CalibrationTreatment( );
 391  0069 cd0000        	call	_TSL_SCKey_CalibrationTreatment
 393                     ; 213       TSL_SCKey_CheckDisabled( );
 395  006c cd0000        	call	_TSL_SCKey_CheckDisabled
 397                     ; 214       break;
 399  006f 2008          	jra	L711
 400  0071               L77:
 401                     ; 216     case ERROR_STATE:
 401                     ; 217       TSL_SCKey_CheckDisabled( );
 403  0071 cd0000        	call	_TSL_SCKey_CheckDisabled
 405                     ; 218       break;
 407  0074 2003          	jra	L711
 408  0076               L101:
 409                     ; 220     case DISABLED_STATE:
 409                     ; 221       TSL_SCKey_CheckEnabled( );
 411  0076 cd0000        	call	_TSL_SCKey_CheckEnabled
 413                     ; 222       break;
 415  0079               L711:
 416                     ; 232   TSL_TempGlobalSetting.whole |= pKeyStruct->Setting.whole;
 418  0079 be00          	ldw	x,_pKeyStruct
 419  007b ee01          	ldw	x,(1,x)
 420  007d 01            	rrwa	x,a
 421  007e ba01          	or	a,_TSL_TempGlobalSetting+1
 422  0080 01            	rrwa	x,a
 423  0081 ba00          	or	a,_TSL_TempGlobalSetting
 424  0083 01            	rrwa	x,a
 425  0084 bf00          	ldw	_TSL_TempGlobalSetting,x
 426                     ; 233   TSL_TempGlobalState.whole |= pKeyStruct->State.whole;
 428  0086 b600          	ld	a,_TSL_TempGlobalState
 429  0088 92ca00        	or	a,[_pKeyStruct.w]
 430  008b b700          	ld	_TSL_TempGlobalState,a
 431                     ; 234   pKeyStruct->Setting.b.CHANGED = 0;
 433  008d be00          	ldw	x,_pKeyStruct
 434  008f e602          	ld	a,(2,x)
 435  0091 a4f7          	and	a,#247
 436  0093 e702          	ld	(2,x),a
 437                     ; 236 }
 440  0095 81            	ret
 470                     ; 249 void TSL_SCKey_IdleTreatment(void)
 470                     ; 250 {
 471                     .text:	section	.text,new
 472  0000               _TSL_SCKey_IdleTreatment:
 476                     ; 252   if (pKeyStruct->Channel.LastMeasRejectNb > MAX_REJECTED_MEASUREMENTS)
 478  0000 be00          	ldw	x,_pKeyStruct
 479  0002 e607          	ld	a,(7,x)
 480  0004 a115          	cp	a,#21
 481  0006 2501          	jrult	L341
 482                     ; 254     return;
 485  0008 81            	ret
 486  0009               L341:
 487                     ; 258   if ( Delta <= pKeyStruct->RecalibrationThreshold )
 489  0009 9c            	rvf
 490  000a be00          	ldw	x,_pKeyStruct
 491  000c e60e          	ld	a,(14,x)
 492  000e 5f            	clrw	x
 493  000f 4d            	tnz	a
 494  0010 2a01          	jrpl	L41
 495  0012 53            	cplw	x
 496  0013               L41:
 497  0013 97            	ld	xl,a
 498  0014 b300          	cpw	x,_Delta
 499  0016 2f04          	jrslt	L541
 500                     ; 260     TSL_SCKey_SetPreRecalibrationState( );
 502  0018 cd0000        	call	_TSL_SCKey_SetPreRecalibrationState
 504                     ; 261     return;
 507  001b 81            	ret
 508  001c               L541:
 509                     ; 266 	if ( Delta >= pKeyStruct->DetectThreshold )
 511  001c 9c            	rvf
 512  001d be00          	ldw	x,_pKeyStruct
 513  001f e60c          	ld	a,(12,x)
 514  0021 5f            	clrw	x
 515  0022 4d            	tnz	a
 516  0023 2a01          	jrpl	L61
 517  0025 53            	cplw	x
 518  0026               L61:
 519  0026 97            	ld	xl,a
 520  0027 b300          	cpw	x,_Delta
 521  0029 2c10          	jrsgt	L741
 522                     ; 271     TSL_SCKey_SetPreDetectState( );
 524  002b cd0000        	call	_TSL_SCKey_SetPreDetectState
 526                     ; 272     if ( !DetectionIntegrator )
 528  002e 725d0000      	tnz	_DetectionIntegrator
 529  0032 2607          	jrne	L741
 530                     ; 274       pKeyStruct->Channel.IntegratorCounter++;
 532  0034 be00          	ldw	x,_pKeyStruct
 533  0036 6c0a          	inc	(10,x)
 534                     ; 275       TSL_SCKey_PreDetectTreatment( );
 536  0038 cd0000        	call	_TSL_SCKey_PreDetectTreatment
 538  003b               L741:
 539                     ; 279 }
 542  003b 81            	ret
 571                     ; 292 void TSL_SCKey_PreDetectTreatment(void)
 571                     ; 293 {
 572                     .text:	section	.text,new
 573  0000               _TSL_SCKey_PreDetectTreatment:
 577                     ; 296   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 577                     ; 297       (Delta >= pKeyStruct->DetectThreshold))
 579  0000 be00          	ldw	x,_pKeyStruct
 580  0002 e607          	ld	a,(7,x)
 581  0004 a115          	cp	a,#21
 582  0006 2421          	jruge	L361
 584  0008 9c            	rvf
 585  0009 be00          	ldw	x,_pKeyStruct
 586  000b e60c          	ld	a,(12,x)
 587  000d 5f            	clrw	x
 588  000e 4d            	tnz	a
 589  000f 2a01          	jrpl	L22
 590  0011 53            	cplw	x
 591  0012               L22:
 592  0012 97            	ld	xl,a
 593  0013 b300          	cpw	x,_Delta
 594  0015 2c12          	jrsgt	L361
 595                     ; 303     TSL_SCKey_DES( );
 597  0017 cd0000        	call	_TSL_SCKey_DES
 599                     ; 304     pKeyStruct->Channel.IntegratorCounter--;
 601  001a be00          	ldw	x,_pKeyStruct
 602  001c 6a0a          	dec	(10,x)
 603                     ; 305     if ( !pKeyStruct->Channel.IntegratorCounter )
 605  001e be00          	ldw	x,_pKeyStruct
 606  0020 6d0a          	tnz	(10,x)
 607  0022 2609          	jrne	L761
 608                     ; 307       TSL_SCKey_SetDetectedState( );
 610  0024 cd0000        	call	_TSL_SCKey_SetDetectedState
 612  0027 2004          	jra	L761
 613  0029               L361:
 614                     ; 312     TSL_SCKey_BackToIdleState( );
 616  0029 cd0000        	call	_TSL_SCKey_BackToIdleState
 618                     ; 313     return;
 621  002c 81            	ret
 622  002d               L761:
 623                     ; 316 }
 626  002d 81            	ret
 656                     ; 329 void TSL_SCKey_DetectedTreatment(void)
 656                     ; 330 {
 657                     .text:	section	.text,new
 658  0000               _TSL_SCKey_DetectedTreatment:
 662                     ; 333   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 662                     ; 334       (Delta <= pKeyStruct->EndDetectThreshold))
 664  0000 be00          	ldw	x,_pKeyStruct
 665  0002 e607          	ld	a,(7,x)
 666  0004 a115          	cp	a,#21
 667  0006 2420          	jruge	L102
 669  0008 9c            	rvf
 670  0009 be00          	ldw	x,_pKeyStruct
 671  000b e60d          	ld	a,(13,x)
 672  000d 5f            	clrw	x
 673  000e 4d            	tnz	a
 674  000f 2a01          	jrpl	L62
 675  0011 53            	cplw	x
 676  0012               L62:
 677  0012 97            	ld	xl,a
 678  0013 b300          	cpw	x,_Delta
 679  0015 2f11          	jrslt	L102
 680                     ; 340     TSL_SCKey_SetPostDetectState( );
 682  0017 cd0000        	call	_TSL_SCKey_SetPostDetectState
 684                     ; 341     if ( !EndDetectionIntegrator )
 686  001a 725d0000      	tnz	_EndDetectionIntegrator
 687  001e 2607          	jrne	L302
 688                     ; 343       pKeyStruct->Channel.IntegratorCounter++;
 690  0020 be00          	ldw	x,_pKeyStruct
 691  0022 6c0a          	inc	(10,x)
 692                     ; 344       TSL_SCKey_PostDetectTreatment( );
 694  0024 cd0000        	call	_TSL_SCKey_PostDetectTreatment
 696  0027               L302:
 697                     ; 346     return;
 700  0027 81            	ret
 701  0028               L102:
 702                     ; 349   TSL_SCKey_DetectionTimeout( );
 704  0028 cd0000        	call	_TSL_SCKey_DetectionTimeout
 706                     ; 351 }
 709  002b 81            	ret
 737                     ; 364 void TSL_SCKey_PostDetectTreatment(void)
 737                     ; 365 {
 738                     .text:	section	.text,new
 739  0000               _TSL_SCKey_PostDetectTreatment:
 743                     ; 368   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 743                     ; 369       (Delta <= pKeyStruct->EndDetectThreshold))
 745  0000 be00          	ldw	x,_pKeyStruct
 746  0002 e607          	ld	a,(7,x)
 747  0004 a115          	cp	a,#21
 748  0006 241e          	jruge	L512
 750  0008 9c            	rvf
 751  0009 be00          	ldw	x,_pKeyStruct
 752  000b e60d          	ld	a,(13,x)
 753  000d 5f            	clrw	x
 754  000e 4d            	tnz	a
 755  000f 2a01          	jrpl	L23
 756  0011 53            	cplw	x
 757  0012               L23:
 758  0012 97            	ld	xl,a
 759  0013 b300          	cpw	x,_Delta
 760  0015 2f0f          	jrslt	L512
 761                     ; 375     pKeyStruct->Channel.IntegratorCounter--;
 763  0017 be00          	ldw	x,_pKeyStruct
 764  0019 6a0a          	dec	(10,x)
 765                     ; 376     if ( !pKeyStruct->Channel.IntegratorCounter )
 767  001b be00          	ldw	x,_pKeyStruct
 768  001d 6d0a          	tnz	(10,x)
 769  001f 2608          	jrne	L122
 770                     ; 378       TSL_SCKey_SetIdleState( );
 772  0021 cd0000        	call	_TSL_SCKey_SetIdleState
 774  0024 2003          	jra	L122
 775  0026               L512:
 776                     ; 384     TSL_SCKey_BackToDetectedState( );
 778  0026 cd0000        	call	_TSL_SCKey_BackToDetectedState
 780  0029               L122:
 781                     ; 386 }
 784  0029 81            	ret
 812                     ; 399 void TSL_SCKey_PreRecalibrationTreatment(void)
 812                     ; 400 {
 813                     .text:	section	.text,new
 814  0000               _TSL_SCKey_PreRecalibrationTreatment:
 818                     ; 402   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 818                     ; 403      (Delta <= pKeyStruct->RecalibrationThreshold))
 820  0000 be00          	ldw	x,_pKeyStruct
 821  0002 e607          	ld	a,(7,x)
 822  0004 a115          	cp	a,#21
 823  0006 241e          	jruge	L332
 825  0008 9c            	rvf
 826  0009 be00          	ldw	x,_pKeyStruct
 827  000b e60e          	ld	a,(14,x)
 828  000d 5f            	clrw	x
 829  000e 4d            	tnz	a
 830  000f 2a01          	jrpl	L63
 831  0011 53            	cplw	x
 832  0012               L63:
 833  0012 97            	ld	xl,a
 834  0013 b300          	cpw	x,_Delta
 835  0015 2f0f          	jrslt	L332
 836                     ; 405     pKeyStruct->Channel.IntegratorCounter--;
 838  0017 be00          	ldw	x,_pKeyStruct
 839  0019 6a0a          	dec	(10,x)
 840                     ; 406     if ( !pKeyStruct->Channel.IntegratorCounter )
 842  001b be00          	ldw	x,_pKeyStruct
 843  001d 6d0a          	tnz	(10,x)
 844  001f 2608          	jrne	L732
 845                     ; 408       TSL_SCKey_SetCalibrationState( );
 847  0021 cd0000        	call	_TSL_SCKey_SetCalibrationState
 849  0024 2003          	jra	L732
 850  0026               L332:
 851                     ; 413     TSL_SCKey_BackToIdleState( );
 853  0026 cd0000        	call	_TSL_SCKey_BackToIdleState
 855  0029               L732:
 856                     ; 416 }
 859  0029 81            	ret
 885                     ; 429 void TSL_SCKey_CalibrationTreatment(void)
 885                     ; 430 {
 886                     .text:	section	.text,new
 887  0000               _TSL_SCKey_CalibrationTreatment:
 891                     ; 432   if (pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS)
 893  0000 be00          	ldw	x,_pKeyStruct
 894  0002 e607          	ld	a,(7,x)
 895  0004 a115          	cp	a,#21
 896  0006 242e          	jruge	L152
 897                     ; 434     pKeyStruct->Channel.Reference += pKeyStruct->Channel.LastMeas;
 899  0008 be00          	ldw	x,_pKeyStruct
 900  000a 90be00        	ldw	y,_pKeyStruct
 901  000d 90ee05        	ldw	y,(5,y)
 902  0010 90bf00        	ldw	c_y,y
 903  0013 9093          	ldw	y,x
 904  0015 90ee08        	ldw	y,(8,y)
 905  0018 72b90000      	addw	y,c_y
 906  001c ef08          	ldw	(8,x),y
 907                     ; 435     pKeyStruct->Counter--;
 909  001e be00          	ldw	x,_pKeyStruct
 910  0020 6a03          	dec	(3,x)
 911                     ; 436     if ( !pKeyStruct->Counter )
 913  0022 be00          	ldw	x,_pKeyStruct
 914  0024 6d03          	tnz	(3,x)
 915  0026 260e          	jrne	L152
 916                     ; 439       pKeyStruct->Channel.Reference = (pKeyStruct->Channel.Reference >> 3);
 918  0028 be00          	ldw	x,_pKeyStruct
 919  002a a603          	ld	a,#3
 920  002c               L24:
 921  002c 6408          	srl	(8,x)
 922  002e 6609          	rrc	(9,x)
 923  0030 4a            	dec	a
 924  0031 26f9          	jrne	L24
 925                     ; 440       TSL_SCKey_SetIdleState( );
 927  0033 cd0000        	call	_TSL_SCKey_SetIdleState
 929  0036               L152:
 930                     ; 444 }
 933  0036 81            	ret
 959                     ; 457 void TSL_SCKey_CheckDisabled(void)
 959                     ; 458 {
 960                     .text:	section	.text,new
 961  0000               _TSL_SCKey_CheckDisabled:
 965                     ; 460   if ( !pKeyStruct->Setting.b.ENABLED )
 967  0000 be00          	ldw	x,_pKeyStruct
 968  0002 e602          	ld	a,(2,x)
 969  0004 a502          	bcp	a,#2
 970  0006 2603          	jrne	L562
 971                     ; 462     TSL_SCKey_SetDisabledState( );
 973  0008 cd0000        	call	_TSL_SCKey_SetDisabledState
 975  000b               L562:
 976                     ; 465 }
 979  000b 81            	ret
1005                     ; 478 void TSL_SCKey_CheckEnabled(void)
1005                     ; 479 {
1006                     .text:	section	.text,new
1007  0000               _TSL_SCKey_CheckEnabled:
1011                     ; 481   if ( pKeyStruct->Setting.b.ENABLED && pKeyStruct->Setting.b.IMPLEMENTED )
1013  0000 be00          	ldw	x,_pKeyStruct
1014  0002 e602          	ld	a,(2,x)
1015  0004 a502          	bcp	a,#2
1016  0006 270b          	jreq	L772
1018  0008 be00          	ldw	x,_pKeyStruct
1019  000a e602          	ld	a,(2,x)
1020  000c a501          	bcp	a,#1
1021  000e 2703          	jreq	L772
1022                     ; 483     TSL_SCKey_SetCalibrationState( );
1024  0010 cd0000        	call	_TSL_SCKey_SetCalibrationState
1026  0013               L772:
1027                     ; 486 }
1030  0013 81            	ret
1055                     ; 499 u8 TSL_SCKey_CheckErrorCondition(void)
1055                     ; 500 {
1056                     .text:	section	.text,new
1057  0000               _TSL_SCKey_CheckErrorCondition:
1061                     ; 502   if ( (pKeyStruct->Channel.LastMeas < SCKEY_MIN_ACQUISITION)
1061                     ; 503        || (pKeyStruct->Channel.LastMeas > SCKEY_MAX_ACQUISITION) )
1063  0000 be00          	ldw	x,_pKeyStruct
1064  0002 9093          	ldw	y,x
1065  0004 90ee05        	ldw	y,(5,y)
1066  0007 90a30096      	cpw	y,#150
1067  000b 250d          	jrult	L313
1069  000d be00          	ldw	x,_pKeyStruct
1070  000f 9093          	ldw	y,x
1071  0011 90ee05        	ldw	y,(5,y)
1072  0014 90a30bb9      	cpw	y,#3001
1073  0018 2503          	jrult	L113
1074  001a               L313:
1075                     ; 505     return 0xFF;  // Error case !
1077  001a a6ff          	ld	a,#255
1080  001c 81            	ret
1081  001d               L113:
1082                     ; 508   return 0;
1084  001d 4f            	clr	a
1087  001e 81            	ret
1100                     	xref	_TSL_SCKey_DetectionTimeout
1101                     	xref	_TSL_SCKey_DES
1102                     	xref	_TSL_SCKey_SetDisabledState
1103                     	xref	_TSL_SCKey_SetErrorState
1104                     	xref	_TSL_SCKey_SetPreRecalibrationState
1105                     	xref	_TSL_SCKey_BackToDetectedState
1106                     	xref	_TSL_SCKey_SetPostDetectState
1107                     	xref	_TSL_SCKey_SetDetectedState
1108                     	xref	_TSL_SCKey_SetPreDetectState
1109                     	xref	_TSL_SCKey_BackToIdleState
1110                     	xref	_TSL_SCKey_SetIdleState
1111                     	xref	_TSL_DeltaCalculation
1112                     	xref	_TSL_SetStructPointer
1113                     	xref.b	_TSL_TempGlobalState
1114                     	xref.b	_TSL_TempGlobalSetting
1115                     	xref.b	_Delta
1116                     	xref.b	_KeyIndex
1117                     	xref	_TSL_IO_Acquisition
1118                     	xref	_Table_SCKEY_BITS
1119                     	xref.b	_sTouchIO
1120                     	xref	_TSL_SCKey_SetCalibrationState
1121                     	xref	_EndDetectionIntegrator
1122                     	xref	_DetectionIntegrator
1123                     	xref	_sSCKeyInfo
1124                     	xref.b	_pKeyStruct
1125                     	xdef	_TSL_SCKey_CheckErrorCondition
1126                     	xdef	_TSL_SCKey_CheckEnabled
1127                     	xdef	_TSL_SCKey_CheckDisabled
1128                     	xdef	_TSL_SCKey_CalibrationTreatment
1129                     	xdef	_TSL_SCKey_PreRecalibrationTreatment
1130                     	xdef	_TSL_SCKey_PostDetectTreatment
1131                     	xdef	_TSL_SCKey_DetectedTreatment
1132                     	xdef	_TSL_SCKey_PreDetectTreatment
1133                     	xdef	_TSL_SCKey_IdleTreatment
1134                     	xdef	_TSL_SCKey_Process
1135                     	xdef	_TSL_SCKEY_P1_Acquisition
1136                     	xdef	_TSL_SCKey_Init
1137                     	xref.b	c_y
1156                     	end
