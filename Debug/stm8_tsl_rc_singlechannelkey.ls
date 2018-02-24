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
  91  000c a63c          	ld	a,#60
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
 167  000f 2734          	jreq	L16
 169  0011 92c600        	ld	a,[_pKeyStruct.w]
 170  0014 a180          	cp	a,#128
 171  0016 272d          	jreq	L16
 172                     ; 79       sTouchIO.AcqMask = Table_SCKEY_BITS[KeyIndex];
 174  0018 b600          	ld	a,_KeyIndex
 175  001a 5f            	clrw	x
 176  001b 97            	ld	xl,a
 177  001c d60000        	ld	a,(_Table_SCKEY_BITS,x)
 178  001f b702          	ld	_sTouchIO+2,a
 179                     ; 80       sTouchIO.DriveMask = (u8)(sTouchIO.AcqMask | SCKEY_P1_DRIVEN_SHIELD_MASK);
 181  0021 450203        	mov	_sTouchIO+3,_sTouchIO+2
 182                     ; 81       sTouchIO.Measurement = &sSCKeyInfo[KeyIndex].Channel.LastMeas;
 184  0024 b600          	ld	a,_KeyIndex
 185  0026 97            	ld	xl,a
 186  0027 a60f          	ld	a,#15
 187  0029 42            	mul	x,a
 188  002a 1c0005        	addw	x,#_sSCKeyInfo+5
 189  002d bf04          	ldw	_sTouchIO+4,x
 190                     ; 82       sTouchIO.RejectedNb = &sSCKeyInfo[KeyIndex].Channel.LastMeasRejectNb;
 192  002f b600          	ld	a,_KeyIndex
 193  0031 97            	ld	xl,a
 194  0032 a60f          	ld	a,#15
 195  0034 42            	mul	x,a
 196  0035 1c0007        	addw	x,#_sSCKeyInfo+7
 197  0038 bf06          	ldw	_sTouchIO+6,x
 198                     ; 83       sTouchIO.Type = SCKEY_TYPE;
 200  003a 3f08          	clr	_sTouchIO+8
 201                     ; 84       TSL_IO_Acquisition(SCKEY_ACQ_NUM, SCKEY_ADJUST_LEVEL);
 203  003c ae0002        	ldw	x,#2
 204  003f a603          	ld	a,#3
 205  0041 95            	ld	xh,a
 206  0042 cd0000        	call	_TSL_IO_Acquisition
 208  0045               L16:
 209                     ; 74   for ( KeyIndex = 0; KeyIndex < SCKEY_P1_KEY_COUNT; KeyIndex++ )
 211  0045 3c00          	inc	_KeyIndex
 214  0047 b600          	ld	a,_KeyIndex
 215  0049 a103          	cp	a,#3
 216  004b 25ba          	jrult	L35
 217                     ; 87 }
 220  004d 81            	ret
 258                     ; 164 void TSL_SCKey_Process(void)
 258                     ; 165 {
 259                     .text:	section	.text,new
 260  0000               _TSL_SCKey_Process:
 264                     ; 167   TSL_SetStructPointer();
 266  0000 cd0000        	call	_TSL_SetStructPointer
 268                     ; 169   TSL_DeltaCalculation();
 270  0003 cd0000        	call	_TSL_DeltaCalculation
 272                     ; 171   switch ( pKeyStruct->State.whole )
 274  0006 92c600        	ld	a,[_pKeyStruct.w]
 276                     ; 222       break;
 277  0009 4a            	dec	a
 278  000a 2752          	jreq	L57
 279  000c 4a            	dec	a
 280  000d 271a          	jreq	L36
 281  000f a002          	sub	a,#2
 282  0011 272e          	jreq	L76
 283  0013 a004          	sub	a,#4
 284  0015 275a          	jreq	L77
 285  0017 a009          	sub	a,#9
 286  0019 273e          	jreq	L37
 287  001b a003          	sub	a,#3
 288  001d 271d          	jreq	L56
 289  001f a010          	sub	a,#16
 290  0021 2731          	jreq	L17
 291  0023 a05c          	sub	a,#92
 292  0025 274f          	jreq	L101
 293  0027               L721:
 295  0027 20fe          	jra	L721
 296  0029               L36:
 297                     ; 174     case IDLE_STATE:
 297                     ; 175       if ( TSL_SCKey_CheckErrorCondition() )
 299  0029 cd0000        	call	_TSL_SCKey_CheckErrorCondition
 301  002c 4d            	tnz	a
 302  002d 2705          	jreq	L121
 303                     ; 177         TSL_SCKey_SetErrorState();
 305  002f cd0000        	call	_TSL_SCKey_SetErrorState
 307                     ; 178         break;
 309  0032 2045          	jra	L711
 310  0034               L121:
 311                     ; 180       TSL_SCKey_IdleTreatment( );
 313  0034 cd0000        	call	_TSL_SCKey_IdleTreatment
 315                     ; 181       TSL_SCKey_CheckDisabled( );
 317  0037 cd0000        	call	_TSL_SCKey_CheckDisabled
 319                     ; 182       break;
 321  003a 203d          	jra	L711
 322  003c               L56:
 323                     ; 184     case PRE_DETECTED_STATE:
 323                     ; 185       TSL_SCKey_PreDetectTreatment( );
 325  003c cd0000        	call	_TSL_SCKey_PreDetectTreatment
 327                     ; 186       break;
 329  003f 2038          	jra	L711
 330  0041               L76:
 331                     ; 188     case DETECTED_STATE:
 331                     ; 189       if ( TSL_SCKey_CheckErrorCondition() )
 333  0041 cd0000        	call	_TSL_SCKey_CheckErrorCondition
 335  0044 4d            	tnz	a
 336  0045 2705          	jreq	L321
 337                     ; 191         TSL_SCKey_SetErrorState();
 339  0047 cd0000        	call	_TSL_SCKey_SetErrorState
 341                     ; 192         break;
 343  004a 202d          	jra	L711
 344  004c               L321:
 345                     ; 194       TSL_SCKey_DetectedTreatment( );
 347  004c cd0000        	call	_TSL_SCKey_DetectedTreatment
 349                     ; 195       TSL_SCKey_CheckDisabled( );
 351  004f cd0000        	call	_TSL_SCKey_CheckDisabled
 353                     ; 196       break;
 355  0052 2025          	jra	L711
 356  0054               L17:
 357                     ; 198     case POST_DETECTED_STATE:
 357                     ; 199       TSL_SCKey_PostDetectTreatment( );
 359  0054 cd0000        	call	_TSL_SCKey_PostDetectTreatment
 361                     ; 200       break;
 363  0057 2020          	jra	L711
 364  0059               L37:
 365                     ; 202     case PRE_CALIBRATION_STATE:
 365                     ; 203       TSL_SCKey_PreRecalibrationTreatment( );
 367  0059 cd0000        	call	_TSL_SCKey_PreRecalibrationTreatment
 369                     ; 204       break;
 371  005c 201b          	jra	L711
 372  005e               L57:
 373                     ; 206     case CALIBRATION_STATE:
 373                     ; 207       if ( TSL_SCKey_CheckErrorCondition() )
 375  005e cd0000        	call	_TSL_SCKey_CheckErrorCondition
 377  0061 4d            	tnz	a
 378  0062 2705          	jreq	L521
 379                     ; 209         TSL_SCKey_SetErrorState();
 381  0064 cd0000        	call	_TSL_SCKey_SetErrorState
 383                     ; 210         break;
 385  0067 2010          	jra	L711
 386  0069               L521:
 387                     ; 212       TSL_SCKey_CalibrationTreatment( );
 389  0069 cd0000        	call	_TSL_SCKey_CalibrationTreatment
 391                     ; 213       TSL_SCKey_CheckDisabled( );
 393  006c cd0000        	call	_TSL_SCKey_CheckDisabled
 395                     ; 214       break;
 397  006f 2008          	jra	L711
 398  0071               L77:
 399                     ; 216     case ERROR_STATE:
 399                     ; 217       TSL_SCKey_CheckDisabled( );
 401  0071 cd0000        	call	_TSL_SCKey_CheckDisabled
 403                     ; 218       break;
 405  0074 2003          	jra	L711
 406  0076               L101:
 407                     ; 220     case DISABLED_STATE:
 407                     ; 221       TSL_SCKey_CheckEnabled( );
 409  0076 cd0000        	call	_TSL_SCKey_CheckEnabled
 411                     ; 222       break;
 413  0079               L711:
 414                     ; 232   TSL_TempGlobalSetting.whole |= pKeyStruct->Setting.whole;
 416  0079 be00          	ldw	x,_pKeyStruct
 417  007b ee01          	ldw	x,(1,x)
 418  007d 01            	rrwa	x,a
 419  007e ba01          	or	a,_TSL_TempGlobalSetting+1
 420  0080 01            	rrwa	x,a
 421  0081 ba00          	or	a,_TSL_TempGlobalSetting
 422  0083 01            	rrwa	x,a
 423  0084 bf00          	ldw	_TSL_TempGlobalSetting,x
 424                     ; 233   TSL_TempGlobalState.whole |= pKeyStruct->State.whole;
 426  0086 b600          	ld	a,_TSL_TempGlobalState
 427  0088 92ca00        	or	a,[_pKeyStruct.w]
 428  008b b700          	ld	_TSL_TempGlobalState,a
 429                     ; 236 }
 432  008d 81            	ret
 462                     ; 249 void TSL_SCKey_IdleTreatment(void)
 462                     ; 250 {
 463                     .text:	section	.text,new
 464  0000               _TSL_SCKey_IdleTreatment:
 468                     ; 252   if (pKeyStruct->Channel.LastMeasRejectNb > MAX_REJECTED_MEASUREMENTS)
 470  0000 be00          	ldw	x,_pKeyStruct
 471  0002 e607          	ld	a,(7,x)
 472  0004 a115          	cp	a,#21
 473  0006 2501          	jrult	L341
 474                     ; 254     return;
 477  0008 81            	ret
 478  0009               L341:
 479                     ; 258   if ( Delta <= pKeyStruct->RecalibrationThreshold )
 481  0009 9c            	rvf
 482  000a be00          	ldw	x,_pKeyStruct
 483  000c e60e          	ld	a,(14,x)
 484  000e 5f            	clrw	x
 485  000f 4d            	tnz	a
 486  0010 2a01          	jrpl	L41
 487  0012 53            	cplw	x
 488  0013               L41:
 489  0013 97            	ld	xl,a
 490  0014 b300          	cpw	x,_Delta
 491  0016 2f04          	jrslt	L541
 492                     ; 260     TSL_SCKey_SetPreRecalibrationState( );
 494  0018 cd0000        	call	_TSL_SCKey_SetPreRecalibrationState
 496                     ; 261     return;
 499  001b 81            	ret
 500  001c               L541:
 501                     ; 266 	if ( Delta >= pKeyStruct->DetectThreshold )
 503  001c 9c            	rvf
 504  001d be00          	ldw	x,_pKeyStruct
 505  001f e60c          	ld	a,(12,x)
 506  0021 5f            	clrw	x
 507  0022 4d            	tnz	a
 508  0023 2a01          	jrpl	L61
 509  0025 53            	cplw	x
 510  0026               L61:
 511  0026 97            	ld	xl,a
 512  0027 b300          	cpw	x,_Delta
 513  0029 2c10          	jrsgt	L741
 514                     ; 271     TSL_SCKey_SetPreDetectState( );
 516  002b cd0000        	call	_TSL_SCKey_SetPreDetectState
 518                     ; 272     if ( !DetectionIntegrator )
 520  002e 725d0000      	tnz	_DetectionIntegrator
 521  0032 2607          	jrne	L741
 522                     ; 274       pKeyStruct->Channel.IntegratorCounter++;
 524  0034 be00          	ldw	x,_pKeyStruct
 525  0036 6c0a          	inc	(10,x)
 526                     ; 275       TSL_SCKey_PreDetectTreatment( );
 528  0038 cd0000        	call	_TSL_SCKey_PreDetectTreatment
 530  003b               L741:
 531                     ; 279 }
 534  003b 81            	ret
 563                     ; 292 void TSL_SCKey_PreDetectTreatment(void)
 563                     ; 293 {
 564                     .text:	section	.text,new
 565  0000               _TSL_SCKey_PreDetectTreatment:
 569                     ; 296   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 569                     ; 297       (Delta >= pKeyStruct->DetectThreshold))
 571  0000 be00          	ldw	x,_pKeyStruct
 572  0002 e607          	ld	a,(7,x)
 573  0004 a115          	cp	a,#21
 574  0006 2421          	jruge	L361
 576  0008 9c            	rvf
 577  0009 be00          	ldw	x,_pKeyStruct
 578  000b e60c          	ld	a,(12,x)
 579  000d 5f            	clrw	x
 580  000e 4d            	tnz	a
 581  000f 2a01          	jrpl	L22
 582  0011 53            	cplw	x
 583  0012               L22:
 584  0012 97            	ld	xl,a
 585  0013 b300          	cpw	x,_Delta
 586  0015 2c12          	jrsgt	L361
 587                     ; 303     TSL_SCKey_DES( );
 589  0017 cd0000        	call	_TSL_SCKey_DES
 591                     ; 304     pKeyStruct->Channel.IntegratorCounter--;
 593  001a be00          	ldw	x,_pKeyStruct
 594  001c 6a0a          	dec	(10,x)
 595                     ; 305     if ( !pKeyStruct->Channel.IntegratorCounter )
 597  001e be00          	ldw	x,_pKeyStruct
 598  0020 6d0a          	tnz	(10,x)
 599  0022 2609          	jrne	L761
 600                     ; 307       TSL_SCKey_SetDetectedState( );
 602  0024 cd0000        	call	_TSL_SCKey_SetDetectedState
 604  0027 2004          	jra	L761
 605  0029               L361:
 606                     ; 312     TSL_SCKey_BackToIdleState( );
 608  0029 cd0000        	call	_TSL_SCKey_BackToIdleState
 610                     ; 313     return;
 613  002c 81            	ret
 614  002d               L761:
 615                     ; 316 }
 618  002d 81            	ret
 648                     ; 329 void TSL_SCKey_DetectedTreatment(void)
 648                     ; 330 {
 649                     .text:	section	.text,new
 650  0000               _TSL_SCKey_DetectedTreatment:
 654                     ; 333   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 654                     ; 334       (Delta <= pKeyStruct->EndDetectThreshold))
 656  0000 be00          	ldw	x,_pKeyStruct
 657  0002 e607          	ld	a,(7,x)
 658  0004 a115          	cp	a,#21
 659  0006 2420          	jruge	L102
 661  0008 9c            	rvf
 662  0009 be00          	ldw	x,_pKeyStruct
 663  000b e60d          	ld	a,(13,x)
 664  000d 5f            	clrw	x
 665  000e 4d            	tnz	a
 666  000f 2a01          	jrpl	L62
 667  0011 53            	cplw	x
 668  0012               L62:
 669  0012 97            	ld	xl,a
 670  0013 b300          	cpw	x,_Delta
 671  0015 2f11          	jrslt	L102
 672                     ; 340     TSL_SCKey_SetPostDetectState( );
 674  0017 cd0000        	call	_TSL_SCKey_SetPostDetectState
 676                     ; 341     if ( !EndDetectionIntegrator )
 678  001a 725d0000      	tnz	_EndDetectionIntegrator
 679  001e 2607          	jrne	L302
 680                     ; 343       pKeyStruct->Channel.IntegratorCounter++;
 682  0020 be00          	ldw	x,_pKeyStruct
 683  0022 6c0a          	inc	(10,x)
 684                     ; 344       TSL_SCKey_PostDetectTreatment( );
 686  0024 cd0000        	call	_TSL_SCKey_PostDetectTreatment
 688  0027               L302:
 689                     ; 346     return;
 692  0027 81            	ret
 693  0028               L102:
 694                     ; 349   TSL_SCKey_DetectionTimeout( );
 696  0028 cd0000        	call	_TSL_SCKey_DetectionTimeout
 698                     ; 351 }
 701  002b 81            	ret
 729                     ; 364 void TSL_SCKey_PostDetectTreatment(void)
 729                     ; 365 {
 730                     .text:	section	.text,new
 731  0000               _TSL_SCKey_PostDetectTreatment:
 735                     ; 368   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 735                     ; 369       (Delta <= pKeyStruct->EndDetectThreshold))
 737  0000 be00          	ldw	x,_pKeyStruct
 738  0002 e607          	ld	a,(7,x)
 739  0004 a115          	cp	a,#21
 740  0006 241e          	jruge	L512
 742  0008 9c            	rvf
 743  0009 be00          	ldw	x,_pKeyStruct
 744  000b e60d          	ld	a,(13,x)
 745  000d 5f            	clrw	x
 746  000e 4d            	tnz	a
 747  000f 2a01          	jrpl	L23
 748  0011 53            	cplw	x
 749  0012               L23:
 750  0012 97            	ld	xl,a
 751  0013 b300          	cpw	x,_Delta
 752  0015 2f0f          	jrslt	L512
 753                     ; 375     pKeyStruct->Channel.IntegratorCounter--;
 755  0017 be00          	ldw	x,_pKeyStruct
 756  0019 6a0a          	dec	(10,x)
 757                     ; 376     if ( !pKeyStruct->Channel.IntegratorCounter )
 759  001b be00          	ldw	x,_pKeyStruct
 760  001d 6d0a          	tnz	(10,x)
 761  001f 2608          	jrne	L122
 762                     ; 378       TSL_SCKey_SetIdleState( );
 764  0021 cd0000        	call	_TSL_SCKey_SetIdleState
 766  0024 2003          	jra	L122
 767  0026               L512:
 768                     ; 384     TSL_SCKey_BackToDetectedState( );
 770  0026 cd0000        	call	_TSL_SCKey_BackToDetectedState
 772  0029               L122:
 773                     ; 386 }
 776  0029 81            	ret
 804                     ; 399 void TSL_SCKey_PreRecalibrationTreatment(void)
 804                     ; 400 {
 805                     .text:	section	.text,new
 806  0000               _TSL_SCKey_PreRecalibrationTreatment:
 810                     ; 402   if ((pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS) &&
 810                     ; 403      (Delta <= pKeyStruct->RecalibrationThreshold))
 812  0000 be00          	ldw	x,_pKeyStruct
 813  0002 e607          	ld	a,(7,x)
 814  0004 a115          	cp	a,#21
 815  0006 241e          	jruge	L332
 817  0008 9c            	rvf
 818  0009 be00          	ldw	x,_pKeyStruct
 819  000b e60e          	ld	a,(14,x)
 820  000d 5f            	clrw	x
 821  000e 4d            	tnz	a
 822  000f 2a01          	jrpl	L63
 823  0011 53            	cplw	x
 824  0012               L63:
 825  0012 97            	ld	xl,a
 826  0013 b300          	cpw	x,_Delta
 827  0015 2f0f          	jrslt	L332
 828                     ; 405     pKeyStruct->Channel.IntegratorCounter--;
 830  0017 be00          	ldw	x,_pKeyStruct
 831  0019 6a0a          	dec	(10,x)
 832                     ; 406     if ( !pKeyStruct->Channel.IntegratorCounter )
 834  001b be00          	ldw	x,_pKeyStruct
 835  001d 6d0a          	tnz	(10,x)
 836  001f 2608          	jrne	L732
 837                     ; 408       TSL_SCKey_SetCalibrationState( );
 839  0021 cd0000        	call	_TSL_SCKey_SetCalibrationState
 841  0024 2003          	jra	L732
 842  0026               L332:
 843                     ; 413     TSL_SCKey_BackToIdleState( );
 845  0026 cd0000        	call	_TSL_SCKey_BackToIdleState
 847  0029               L732:
 848                     ; 416 }
 851  0029 81            	ret
 877                     ; 429 void TSL_SCKey_CalibrationTreatment(void)
 877                     ; 430 {
 878                     .text:	section	.text,new
 879  0000               _TSL_SCKey_CalibrationTreatment:
 883                     ; 432   if (pKeyStruct->Channel.LastMeasRejectNb <= MAX_REJECTED_MEASUREMENTS)
 885  0000 be00          	ldw	x,_pKeyStruct
 886  0002 e607          	ld	a,(7,x)
 887  0004 a115          	cp	a,#21
 888  0006 242e          	jruge	L152
 889                     ; 434     pKeyStruct->Channel.Reference += pKeyStruct->Channel.LastMeas;
 891  0008 be00          	ldw	x,_pKeyStruct
 892  000a 90be00        	ldw	y,_pKeyStruct
 893  000d 90ee05        	ldw	y,(5,y)
 894  0010 90bf00        	ldw	c_y,y
 895  0013 9093          	ldw	y,x
 896  0015 90ee08        	ldw	y,(8,y)
 897  0018 72b90000      	addw	y,c_y
 898  001c ef08          	ldw	(8,x),y
 899                     ; 435     pKeyStruct->Counter--;
 901  001e be00          	ldw	x,_pKeyStruct
 902  0020 6a03          	dec	(3,x)
 903                     ; 436     if ( !pKeyStruct->Counter )
 905  0022 be00          	ldw	x,_pKeyStruct
 906  0024 6d03          	tnz	(3,x)
 907  0026 260e          	jrne	L152
 908                     ; 439       pKeyStruct->Channel.Reference = (pKeyStruct->Channel.Reference >> 3);
 910  0028 be00          	ldw	x,_pKeyStruct
 911  002a a603          	ld	a,#3
 912  002c               L24:
 913  002c 6408          	srl	(8,x)
 914  002e 6609          	rrc	(9,x)
 915  0030 4a            	dec	a
 916  0031 26f9          	jrne	L24
 917                     ; 440       TSL_SCKey_SetIdleState( );
 919  0033 cd0000        	call	_TSL_SCKey_SetIdleState
 921  0036               L152:
 922                     ; 444 }
 925  0036 81            	ret
 951                     ; 457 void TSL_SCKey_CheckDisabled(void)
 951                     ; 458 {
 952                     .text:	section	.text,new
 953  0000               _TSL_SCKey_CheckDisabled:
 957                     ; 460   if ( !pKeyStruct->Setting.b.ENABLED )
 959  0000 be00          	ldw	x,_pKeyStruct
 960  0002 e602          	ld	a,(2,x)
 961  0004 a502          	bcp	a,#2
 962  0006 2603          	jrne	L562
 963                     ; 462     TSL_SCKey_SetDisabledState( );
 965  0008 cd0000        	call	_TSL_SCKey_SetDisabledState
 967  000b               L562:
 968                     ; 465 }
 971  000b 81            	ret
 997                     ; 478 void TSL_SCKey_CheckEnabled(void)
 997                     ; 479 {
 998                     .text:	section	.text,new
 999  0000               _TSL_SCKey_CheckEnabled:
1003                     ; 481   if ( pKeyStruct->Setting.b.ENABLED && pKeyStruct->Setting.b.IMPLEMENTED )
1005  0000 be00          	ldw	x,_pKeyStruct
1006  0002 e602          	ld	a,(2,x)
1007  0004 a502          	bcp	a,#2
1008  0006 270b          	jreq	L772
1010  0008 be00          	ldw	x,_pKeyStruct
1011  000a e602          	ld	a,(2,x)
1012  000c a501          	bcp	a,#1
1013  000e 2703          	jreq	L772
1014                     ; 483     TSL_SCKey_SetCalibrationState( );
1016  0010 cd0000        	call	_TSL_SCKey_SetCalibrationState
1018  0013               L772:
1019                     ; 486 }
1022  0013 81            	ret
1047                     ; 499 u8 TSL_SCKey_CheckErrorCondition(void)
1047                     ; 500 {
1048                     .text:	section	.text,new
1049  0000               _TSL_SCKey_CheckErrorCondition:
1053                     ; 502   if ( (pKeyStruct->Channel.LastMeas < SCKEY_MIN_ACQUISITION)
1053                     ; 503        || (pKeyStruct->Channel.LastMeas > SCKEY_MAX_ACQUISITION) )
1055  0000 be00          	ldw	x,_pKeyStruct
1056  0002 9093          	ldw	y,x
1057  0004 90ee05        	ldw	y,(5,y)
1058  0007 90a30096      	cpw	y,#150
1059  000b 250d          	jrult	L313
1061  000d be00          	ldw	x,_pKeyStruct
1062  000f 9093          	ldw	y,x
1063  0011 90ee05        	ldw	y,(5,y)
1064  0014 90a30bb9      	cpw	y,#3001
1065  0018 2503          	jrult	L113
1066  001a               L313:
1067                     ; 505     return 0xFF;  // Error case !
1069  001a a6ff          	ld	a,#255
1072  001c 81            	ret
1073  001d               L113:
1074                     ; 508   return 0;
1076  001d 4f            	clr	a
1079  001e 81            	ret
1092                     	xref	_TSL_SCKey_DetectionTimeout
1093                     	xref	_TSL_SCKey_DES
1094                     	xref	_TSL_SCKey_SetDisabledState
1095                     	xref	_TSL_SCKey_SetErrorState
1096                     	xref	_TSL_SCKey_SetPreRecalibrationState
1097                     	xref	_TSL_SCKey_BackToDetectedState
1098                     	xref	_TSL_SCKey_SetPostDetectState
1099                     	xref	_TSL_SCKey_SetDetectedState
1100                     	xref	_TSL_SCKey_SetPreDetectState
1101                     	xref	_TSL_SCKey_BackToIdleState
1102                     	xref	_TSL_SCKey_SetIdleState
1103                     	xref	_TSL_DeltaCalculation
1104                     	xref	_TSL_SetStructPointer
1105                     	xref.b	_TSL_TempGlobalState
1106                     	xref.b	_TSL_TempGlobalSetting
1107                     	xref.b	_Delta
1108                     	xref.b	_KeyIndex
1109                     	xref	_TSL_IO_Acquisition
1110                     	xref	_Table_SCKEY_BITS
1111                     	xref.b	_sTouchIO
1112                     	xref	_TSL_SCKey_SetCalibrationState
1113                     	xref	_EndDetectionIntegrator
1114                     	xref	_DetectionIntegrator
1115                     	xref	_sSCKeyInfo
1116                     	xref.b	_pKeyStruct
1117                     	xdef	_TSL_SCKey_CheckErrorCondition
1118                     	xdef	_TSL_SCKey_CheckEnabled
1119                     	xdef	_TSL_SCKey_CheckDisabled
1120                     	xdef	_TSL_SCKey_CalibrationTreatment
1121                     	xdef	_TSL_SCKey_PreRecalibrationTreatment
1122                     	xdef	_TSL_SCKey_PostDetectTreatment
1123                     	xdef	_TSL_SCKey_DetectedTreatment
1124                     	xdef	_TSL_SCKey_PreDetectTreatment
1125                     	xdef	_TSL_SCKey_IdleTreatment
1126                     	xdef	_TSL_SCKey_Process
1127                     	xdef	_TSL_SCKEY_P1_Acquisition
1128                     	xdef	_TSL_SCKey_Init
1129                     	xref.b	c_y
1148                     	end
