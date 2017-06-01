   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  98                     ; 65 void GPIO_DeInit(GPIO_TypeDef* GPIOx)
  98                     ; 66 {
 100                     .text:	section	.text,new
 101  0000               _GPIO_DeInit:
 105                     ; 67   GPIOx->ODR = GPIO_ODR_RESET_VALUE; /* Reset Output Data Register */
 107  0000 7f            	clr	(x)
 108                     ; 68   GPIOx->DDR = GPIO_DDR_RESET_VALUE; /* Reset Data Direction Register */
 110  0001 6f02          	clr	(2,x)
 111                     ; 69   GPIOx->CR1 = GPIO_CR1_RESET_VALUE; /* Reset Control Register 1 */
 113  0003 6f03          	clr	(3,x)
 114                     ; 70   GPIOx->CR2 = GPIO_CR2_RESET_VALUE; /* Reset Control Register 2 */
 116  0005 6f04          	clr	(4,x)
 117                     ; 71 }
 120  0007 81            	ret
 360                     ; 92 void GPIO_Init(GPIO_TypeDef* GPIOx,
 360                     ; 93                GPIO_Pin_TypeDef GPIO_Pin,
 360                     ; 94                GPIO_Mode_TypeDef GPIO_Mode)
 360                     ; 95 {
 361                     .text:	section	.text,new
 362  0000               _GPIO_Init:
 364  0000 89            	pushw	x
 365       00000000      OFST:	set	0
 368                     ; 100   assert_param(IS_GPIO_MODE_OK(GPIO_Mode));
 370                     ; 101   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 372                     ; 107   if ((((u8)(GPIO_Mode)) & (u8)0x80) != (u8)0x00) /* Output mode */
 374  0001 7b06          	ld	a,(OFST+6,sp)
 375  0003 a580          	bcp	a,#128
 376  0005 271d          	jreq	L771
 377                     ; 109     if ((((u8)(GPIO_Mode)) & (u8)0x10) != (u8)0x00) /* High level */
 379  0007 7b06          	ld	a,(OFST+6,sp)
 380  0009 a510          	bcp	a,#16
 381  000b 2706          	jreq	L102
 382                     ; 111       GPIOx->ODR |= GPIO_Pin;
 384  000d f6            	ld	a,(x)
 385  000e 1a05          	or	a,(OFST+5,sp)
 386  0010 f7            	ld	(x),a
 388  0011 2007          	jra	L302
 389  0013               L102:
 390                     ; 114       GPIOx->ODR &= (u8)(~(GPIO_Pin));
 392  0013 1e01          	ldw	x,(OFST+1,sp)
 393  0015 7b05          	ld	a,(OFST+5,sp)
 394  0017 43            	cpl	a
 395  0018 f4            	and	a,(x)
 396  0019 f7            	ld	(x),a
 397  001a               L302:
 398                     ; 117     GPIOx->DDR |= GPIO_Pin;
 400  001a 1e01          	ldw	x,(OFST+1,sp)
 401  001c e602          	ld	a,(2,x)
 402  001e 1a05          	or	a,(OFST+5,sp)
 403  0020 e702          	ld	(2,x),a
 405  0022 2009          	jra	L502
 406  0024               L771:
 407                     ; 121     GPIOx->DDR &= (u8)(~(GPIO_Pin));
 409  0024 1e01          	ldw	x,(OFST+1,sp)
 410  0026 7b05          	ld	a,(OFST+5,sp)
 411  0028 43            	cpl	a
 412  0029 e402          	and	a,(2,x)
 413  002b e702          	ld	(2,x),a
 414  002d               L502:
 415                     ; 128   if ((((u8)(GPIO_Mode)) & (u8)0x40) != (u8)0x00) /* Pull-Up or Push-Pull */
 417  002d 7b06          	ld	a,(OFST+6,sp)
 418  002f a540          	bcp	a,#64
 419  0031 270a          	jreq	L702
 420                     ; 130     GPIOx->CR1 |= GPIO_Pin;
 422  0033 1e01          	ldw	x,(OFST+1,sp)
 423  0035 e603          	ld	a,(3,x)
 424  0037 1a05          	or	a,(OFST+5,sp)
 425  0039 e703          	ld	(3,x),a
 427  003b 2009          	jra	L112
 428  003d               L702:
 429                     ; 133     GPIOx->CR1 &= (u8)(~(GPIO_Pin));
 431  003d 1e01          	ldw	x,(OFST+1,sp)
 432  003f 7b05          	ld	a,(OFST+5,sp)
 433  0041 43            	cpl	a
 434  0042 e403          	and	a,(3,x)
 435  0044 e703          	ld	(3,x),a
 436  0046               L112:
 437                     ; 140   if ((((u8)(GPIO_Mode)) & (u8)0x20) != (u8)0x00) /* Interrupt or Slow slope */
 439  0046 7b06          	ld	a,(OFST+6,sp)
 440  0048 a520          	bcp	a,#32
 441  004a 270a          	jreq	L312
 442                     ; 142     GPIOx->CR2 |= GPIO_Pin;
 444  004c 1e01          	ldw	x,(OFST+1,sp)
 445  004e e604          	ld	a,(4,x)
 446  0050 1a05          	or	a,(OFST+5,sp)
 447  0052 e704          	ld	(4,x),a
 449  0054 2009          	jra	L512
 450  0056               L312:
 451                     ; 145     GPIOx->CR2 &= (u8)(~(GPIO_Pin));
 453  0056 1e01          	ldw	x,(OFST+1,sp)
 454  0058 7b05          	ld	a,(OFST+5,sp)
 455  005a 43            	cpl	a
 456  005b e404          	and	a,(4,x)
 457  005d e704          	ld	(4,x),a
 458  005f               L512:
 459                     ; 148 }
 462  005f 85            	popw	x
 463  0060 81            	ret
 507                     ; 166 void GPIO_Write(GPIO_TypeDef* GPIOx, u8 PortVal)
 507                     ; 167 {
 508                     .text:	section	.text,new
 509  0000               _GPIO_Write:
 511  0000 89            	pushw	x
 512       00000000      OFST:	set	0
 515                     ; 168   GPIOx->ODR = PortVal;
 517  0001 7b05          	ld	a,(OFST+5,sp)
 518  0003 1e01          	ldw	x,(OFST+1,sp)
 519  0005 f7            	ld	(x),a
 520                     ; 169 }
 523  0006 85            	popw	x
 524  0007 81            	ret
 571                     ; 187 void GPIO_WriteHigh(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 571                     ; 188 {
 572                     .text:	section	.text,new
 573  0000               _GPIO_WriteHigh:
 575  0000 89            	pushw	x
 576       00000000      OFST:	set	0
 579                     ; 189   GPIOx->ODR |= PortPins;
 581  0001 f6            	ld	a,(x)
 582  0002 1a05          	or	a,(OFST+5,sp)
 583  0004 f7            	ld	(x),a
 584                     ; 190 }
 587  0005 85            	popw	x
 588  0006 81            	ret
 635                     ; 208 void GPIO_WriteLow(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 635                     ; 209 {
 636                     .text:	section	.text,new
 637  0000               _GPIO_WriteLow:
 639  0000 89            	pushw	x
 640       00000000      OFST:	set	0
 643                     ; 210   GPIOx->ODR &= (u8)(~PortPins);
 645  0001 7b05          	ld	a,(OFST+5,sp)
 646  0003 43            	cpl	a
 647  0004 f4            	and	a,(x)
 648  0005 f7            	ld	(x),a
 649                     ; 211 }
 652  0006 85            	popw	x
 653  0007 81            	ret
 700                     ; 229 void GPIO_WriteReverse(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef PortPins)
 700                     ; 230 {
 701                     .text:	section	.text,new
 702  0000               _GPIO_WriteReverse:
 704  0000 89            	pushw	x
 705       00000000      OFST:	set	0
 708                     ; 231   GPIOx->ODR ^= PortPins;
 710  0001 f6            	ld	a,(x)
 711  0002 1805          	xor	a,	(OFST+5,sp)
 712  0004 f7            	ld	(x),a
 713                     ; 232 }
 716  0005 85            	popw	x
 717  0006 81            	ret
 755                     ; 249 u8 GPIO_ReadOutputData(GPIO_TypeDef* GPIOx)
 755                     ; 250 {
 756                     .text:	section	.text,new
 757  0000               _GPIO_ReadOutputData:
 761                     ; 251   return ((u8)GPIOx->ODR);
 763  0000 f6            	ld	a,(x)
 766  0001 81            	ret
 803                     ; 269 u8 GPIO_ReadInputData(GPIO_TypeDef* GPIOx)
 803                     ; 270 {
 804                     .text:	section	.text,new
 805  0000               _GPIO_ReadInputData:
 809                     ; 271   return ((u8)GPIOx->IDR);
 811  0000 e601          	ld	a,(1,x)
 814  0002 81            	ret
 882                     ; 292 BitStatus GPIO_ReadInputPin(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin)
 882                     ; 293 {
 883                     .text:	section	.text,new
 884  0000               _GPIO_ReadInputPin:
 886  0000 89            	pushw	x
 887       00000000      OFST:	set	0
 890                     ; 294   return ((BitStatus)(GPIOx->IDR & (u8)GPIO_Pin));
 892  0001 e601          	ld	a,(1,x)
 893  0003 1405          	and	a,(OFST+5,sp)
 896  0005 85            	popw	x
 897  0006 81            	ret
 975                     ; 314 void GPIO_ExternalPullUpConfig(GPIO_TypeDef* GPIOx, GPIO_Pin_TypeDef GPIO_Pin, FunctionalState NewState)
 975                     ; 315 {
 976                     .text:	section	.text,new
 977  0000               _GPIO_ExternalPullUpConfig:
 979  0000 89            	pushw	x
 980       00000000      OFST:	set	0
 983                     ; 317   assert_param(IS_GPIO_PIN_OK(GPIO_Pin));
 985                     ; 318   assert_param(IS_FUNCTIONALSTATE_OK(NewState));
 987                     ; 320   if (NewState != DISABLE) /* External Pull-Up Set*/
 989  0001 0d06          	tnz	(OFST+6,sp)
 990  0003 2708          	jreq	L174
 991                     ; 322     GPIOx->CR1 |= GPIO_Pin;
 993  0005 e603          	ld	a,(3,x)
 994  0007 1a05          	or	a,(OFST+5,sp)
 995  0009 e703          	ld	(3,x),a
 997  000b 2009          	jra	L374
 998  000d               L174:
 999                     ; 325     GPIOx->CR1 &= (u8)(~(GPIO_Pin));
1001  000d 1e01          	ldw	x,(OFST+1,sp)
1002  000f 7b05          	ld	a,(OFST+5,sp)
1003  0011 43            	cpl	a
1004  0012 e403          	and	a,(3,x)
1005  0014 e703          	ld	(3,x),a
1006  0016               L374:
1007                     ; 327 }
1010  0016 85            	popw	x
1011  0017 81            	ret
1024                     	xdef	_GPIO_ExternalPullUpConfig
1025                     	xdef	_GPIO_ReadInputPin
1026                     	xdef	_GPIO_ReadOutputData
1027                     	xdef	_GPIO_ReadInputData
1028                     	xdef	_GPIO_WriteReverse
1029                     	xdef	_GPIO_WriteLow
1030                     	xdef	_GPIO_WriteHigh
1031                     	xdef	_GPIO_Write
1032                     	xdef	_GPIO_Init
1033                     	xdef	_GPIO_DeInit
1052                     	end
