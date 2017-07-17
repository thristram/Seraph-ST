   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  49                     .const:	section	.text
  50  0000               L6:
  51  0000 000f4240      	dc.l	1000000
  52                     ; 30 uint8_t I2C_Config(void) {
  53                     	scross	off
  54                     .text:	section	.text,new
  55  0000               _I2C_Config:
  57  0000 89            	pushw	x
  58       00000002      OFST:	set	2
  61                     ; 31 	uint16_t time_out = 0;
  63  0001 5f            	clrw	x
  64  0002 1f01          	ldw	(OFST-1,sp),x
  65                     ; 32 	My_TIM3_Init();
  67  0004 cd0000        	call	_My_TIM3_Init
  69                     ; 33 	enableInterrupts();
  72  0007 9a            rim
  74                     ; 37 	I2C_DeInit();
  77  0008 cd0000        	call	_I2C_DeInit
  79                     ; 39 	I2C_Init(100000,0x50,I2C_DUTYCYCLE_2,I2C_ACK_CURR,I2C_ADDMODE_7BIT,CLK_GetClockFreq()/1000000);
  81  000b cd0000        	call	_CLK_GetClockFreq
  83  000e ae0000        	ldw	x,#L6
  84  0011 cd0000        	call	c_ludv
  86  0014 b603          	ld	a,c_lreg+3
  87  0016 88            	push	a
  88  0017 4b00          	push	#0
  89  0019 4b01          	push	#1
  90  001b 4b00          	push	#0
  91  001d ae0050        	ldw	x,#80
  92  0020 89            	pushw	x
  93  0021 ae86a0        	ldw	x,#34464
  94  0024 89            	pushw	x
  95  0025 ae0001        	ldw	x,#1
  96  0028 89            	pushw	x
  97  0029 cd0000        	call	_I2C_Init
  99  002c 5b0a          	addw	sp,#10
 100                     ; 41 	I2C_Cmd(ENABLE);
 102  002e a601          	ld	a,#1
 103  0030 cd0000        	call	_I2C_Cmd
 106  0033 2036          	jra	L72
 107  0035               L52:
 108                     ; 44 		set_tout_ms(10);
 110  0035 ae000a        	ldw	x,#10
 111  0038 cf0000        	ldw	_TIM3_tout,x
 112                     ; 45     I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
 115  003b 72125211      	bset	21009,#1
 117  003f               L53:
 118                     ; 46     while((I2C->CR2 & I2C_CR2_STOP) && tout());      								// wait until stop is performed
 120  003f c65211        	ld	a,21009
 121  0042 a502          	bcp	a,#2
 122  0044 2705          	jreq	L14
 124  0046 ce0000        	ldw	x,_TIM3_tout
 125  0049 26f4          	jrne	L53
 126  004b               L14:
 127                     ; 47 		time_out += 10;
 129  004b 1e01          	ldw	x,(OFST-1,sp)
 130  004d 1c000a        	addw	x,#10
 131  0050 1f01          	ldw	(OFST-1,sp),x
 132                     ; 48 		if(!tout()){
 134  0052 ce0000        	ldw	x,_TIM3_tout
 135  0055 2609          	jrne	L34
 136                     ; 49 			I2C_SoftwareResetCmd(ENABLE);
 138  0057 a601          	ld	a,#1
 139  0059 cd0000        	call	_I2C_SoftwareResetCmd
 141                     ; 50 			I2C_SoftwareResetCmd(DISABLE);
 143  005c 4f            	clr	a
 144  005d cd0000        	call	_I2C_SoftwareResetCmd
 146  0060               L34:
 147                     ; 52 		if(time_out > 500){
 149  0060 1e01          	ldw	x,(OFST-1,sp)
 150  0062 a301f5        	cpw	x,#501
 151  0065 2504          	jrult	L72
 152                     ; 53 			return IIC_ERROR_BUSY;
 154  0067 a602          	ld	a,#2
 156  0069 2008          	jra	L01
 157  006b               L72:
 158                     ; 42   while((I2C->SR3 & I2C_SR3_BUSY))       									// Wait while the bus is busy
 160  006b c65219        	ld	a,21017
 161  006e a502          	bcp	a,#2
 162  0070 26c3          	jrne	L52
 163                     ; 56 	return IIC_SUCCESS;
 165  0072 4f            	clr	a
 167  0073               L01:
 169  0073 85            	popw	x
 170  0074 81            	ret
 227                     ; 66 uint8_t I2C_WriteBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite, uint8_t TimeOutOfMs)
 227                     ; 67 {
 228                     .text:	section	.text,new
 229  0000               _I2C_WriteBytes:
 231  0000 89            	pushw	x
 232       00000000      OFST:	set	0
 235                     ; 68 	set_tout_ms(TimeOutOfMs);
 237  0001 7b08          	ld	a,(OFST+8,sp)
 238  0003 5f            	clrw	x
 239  0004 97            	ld	xl,a
 240  0005 cf0000        	ldw	_TIM3_tout,x
 243  0008 2010          	jra	L57
 244  000a               L37:
 245                     ; 71     I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
 247  000a 72125211      	bset	21009,#1
 249  000e               L301:
 250                     ; 72     while((I2C->CR2 & I2C_CR2_STOP) && tout());      								// wait until stop is performed
 252  000e c65211        	ld	a,21009
 253  0011 a502          	bcp	a,#2
 254  0013 2705          	jreq	L57
 256  0015 ce0000        	ldw	x,_TIM3_tout
 257  0018 26f4          	jrne	L301
 258  001a               L57:
 259                     ; 69   while((I2C->SR3 & I2C_SR3_BUSY) && tout())       									// Wait while the bus is busy
 261  001a c65219        	ld	a,21017
 262  001d a502          	bcp	a,#2
 263  001f 2705          	jreq	L111
 265  0021 ce0000        	ldw	x,_TIM3_tout
 266  0024 26e4          	jrne	L37
 267  0026               L111:
 268                     ; 74 	if(!tout()){return IIC_ERROR_BUSY;}
 270  0026 ce0000        	ldw	x,_TIM3_tout
 271  0029 2604          	jrne	L311
 274  002b a602          	ld	a,#2
 276  002d 201f          	jra	L41
 277  002f               L311:
 278                     ; 75   I2C->CR2 |= I2C_CR2_START;                        									// START=1, generate start
 280  002f 72105211      	bset	21009,#0
 282  0033               L711:
 283                     ; 76   while(((I2C->SR1 & I2C_SR1_SB)==0) && tout()); 									// Wait for start bit detection (SB)
 285  0033 c65217        	ld	a,21015
 286  0036 a501          	bcp	a,#1
 287  0038 2605          	jrne	L321
 289  003a ce0000        	ldw	x,_TIM3_tout
 290  003d 26f4          	jrne	L711
 291  003f               L321:
 292                     ; 78   if(tout())
 295  003f ce0000        	ldw	x,_TIM3_tout
 296  0042 2708          	jreq	L521
 297                     ; 88       I2C->DR = (u8)(SlaveAddr << 1);   									// Send 7-bit device address & Write (R/W = 0)
 299  0044 7b02          	ld	a,(OFST+2,sp)
 300  0046 48            	sll	a
 301  0047 c75216        	ld	21014,a
 303  004a 2004          	jra	L331
 304  004c               L521:
 305                     ; 91 		return IIC_ERROR_TIME_OUT;
 307  004c a601          	ld	a,#1
 309  004e               L41:
 311  004e 85            	popw	x
 312  004f 81            	ret
 313  0050               L331:
 314                     ; 93   while(!(I2C->SR1 & I2C_SR1_ADDR) && tout());     									// Wait for address ack (ADDR)
 316  0050 c65217        	ld	a,21015
 317  0053 a502          	bcp	a,#2
 318  0055 2605          	jrne	L731
 320  0057 ce0000        	ldw	x,_TIM3_tout
 321  005a 26f4          	jrne	L331
 322  005c               L731:
 323                     ; 94 	if(!tout()){
 325  005c ce0000        	ldw	x,_TIM3_tout
 326  005f 2608          	jrne	L141
 327                     ; 95 		I2C->CR2 |= I2C_CR2_STOP;
 329  0061 72125211      	bset	21009,#1
 330                     ; 96 		return IIC_ERROR_NOT_ACK;
 332  0065 a603          	ld	a,#3
 334  0067 20e5          	jra	L41
 335  0069               L141:
 336                     ; 99   I2C->SR3;
 339  0069 c65219        	ld	a,21017
 340  006c 97            	ld	xl,a
 342  006d               L541:
 343                     ; 100   while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  									// Wait for TxE
 345  006d c65217        	ld	a,21015
 346  0070 a580          	bcp	a,#128
 347  0072 2605          	jrne	L151
 349  0074 ce0000        	ldw	x,_TIM3_tout
 350  0077 26f4          	jrne	L541
 351  0079               L151:
 352                     ; 101   if(NumByteToWrite)
 354  0079 0d07          	tnz	(OFST+7,sp)
 355  007b 2736          	jreq	L351
 357  007d 201f          	jra	L751
 358  007f               L551:
 359                     ; 105 			I2C->DR = *pWriteDataBuffer++; 
 361  007f 1e05          	ldw	x,(OFST+5,sp)
 362  0081 1c0001        	addw	x,#1
 363  0084 1f05          	ldw	(OFST+5,sp),x
 364  0086 1d0001        	subw	x,#1
 365  0089 f6            	ld	a,(x)
 366  008a c75216        	ld	21014,a
 368  008d               L761:
 369                     ; 106 			while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  								// test EV8 - wait for TxE
 371  008d c65217        	ld	a,21015
 372  0090 a580          	bcp	a,#128
 373  0092 2605          	jrne	L371
 375  0094 ce0000        	ldw	x,_TIM3_tout
 376  0097 26f4          	jrne	L761
 377  0099               L371:
 378                     ; 107 			if(!tout()){
 380  0099 ce0000        	ldw	x,_TIM3_tout
 381  009c 2707          	jreq	L102
 382                     ; 108 				break;
 384  009e               L751:
 385                     ; 103 		while(NumByteToWrite--)
 387  009e 7b07          	ld	a,(OFST+7,sp)
 388  00a0 0a07          	dec	(OFST+7,sp)
 389  00a2 4d            	tnz	a
 390  00a3 26da          	jrne	L551
 391  00a5               L102:
 392                     ; 111 		while(((I2C->SR1 & (I2C_SR1_TXE|I2C_SR1_BTF)) != (I2C_SR1_TXE|I2C_SR1_BTF)) && tout()); 					// Wait for TxE & BTF
 394  00a5 c65217        	ld	a,21015
 395  00a8 a484          	and	a,#132
 396  00aa a184          	cp	a,#132
 397  00ac 2705          	jreq	L351
 399  00ae ce0000        	ldw	x,_TIM3_tout
 400  00b1 26f2          	jrne	L102
 401  00b3               L351:
 402                     ; 115   I2C->CR2 |= I2C_CR2_STOP;                        									// generate stop here (STOP=1)
 404  00b3 72125211      	bset	21009,#1
 406  00b7               L112:
 407                     ; 116   while((I2C->CR2 & I2C_CR2_STOP) && tout());      									// wait until stop is performed  
 409  00b7 c65211        	ld	a,21009
 410  00ba a502          	bcp	a,#2
 411  00bc 2705          	jreq	L512
 413  00be ce0000        	ldw	x,_TIM3_tout
 414  00c1 26f4          	jrne	L112
 415  00c3               L512:
 416                     ; 117 	if(!tout()){
 418  00c3 ce0000        	ldw	x,_TIM3_tout
 419  00c6 2604          	jrne	L712
 420                     ; 118 		return IIC_ERROR_TIME_OUT;
 422  00c8 a601          	ld	a,#1
 424  00ca 2001          	jra	L61
 425  00cc               L712:
 426                     ; 120 		return IIC_SUCCESS;
 428  00cc 4f            	clr	a
 430  00cd               L61:
 432  00cd 85            	popw	x
 433  00ce 81            	ret
 498                     ; 124 uint8_t I2C_ReadBytes(uint16_t SlaveAddr, uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
 498                     ; 125 {
 499                     .text:	section	.text,new
 500  0000               _I2C_ReadBytes:
 502  0000 89            	pushw	x
 503       00000000      OFST:	set	0
 506                     ; 126 	set_tout_ms(TimeOutOfMs);
 508  0001 7b08          	ld	a,(OFST+8,sp)
 509  0003 5f            	clrw	x
 510  0004 97            	ld	xl,a
 511  0005 cf0000        	ldw	_TIM3_tout,x
 514  0008 2010          	jra	L152
 515  000a               L742:
 516                     ; 130 		I2C->CR2 |= I2C_CR2_STOP;                   				// STOP=1, generate stop
 518  000a 72125211      	bset	21009,#1
 520  000e               L752:
 521                     ; 131     while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// wait until stop is performed
 523  000e c65211        	ld	a,21009
 524  0011 a502          	bcp	a,#2
 525  0013 2705          	jreq	L152
 527  0015 ce0000        	ldw	x,_TIM3_tout
 528  0018 26f4          	jrne	L752
 529  001a               L152:
 530                     ; 128 	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
 532  001a c65219        	ld	a,21017
 533  001d a502          	bcp	a,#2
 534  001f 2705          	jreq	L562
 536  0021 ce0000        	ldw	x,_TIM3_tout
 537  0024 26e4          	jrne	L742
 538  0026               L562:
 539                     ; 133 	if(!tout()){return IIC_ERROR_BUSY;}
 541  0026 ce0000        	ldw	x,_TIM3_tout
 542  0029 2604          	jrne	L762
 545  002b a602          	ld	a,#2
 547  002d 2033          	jra	L22
 548  002f               L762:
 549                     ; 134 	I2C->CR2 &= ~I2C_CR2_STOP;
 551  002f 72135211      	bres	21009,#1
 552                     ; 135   I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
 554  0033 72145211      	bset	21009,#2
 555                     ; 137   I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
 557  0037 72105211      	bset	21009,#0
 559  003b               L372:
 560                     ; 138   while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// wait for start bit detection (SB)
 562  003b c65217        	ld	a,21015
 563  003e a501          	bcp	a,#1
 564  0040 2605          	jrne	L772
 566  0042 ce0000        	ldw	x,_TIM3_tout
 567  0045 26f4          	jrne	L372
 568  0047               L772:
 569                     ; 149     I2C->DR = (u8)(SlaveAddr << 1) | 1;       			// Send 7-bit device address & Write (R/W = 1)
 571  0047 7b02          	ld	a,(OFST+2,sp)
 572  0049 48            	sll	a
 573  004a aa01          	or	a,#1
 574  004c c75216        	ld	21014,a
 576  004f               L503:
 577                     ; 151   while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());				// Wait for address ack (ADDR)
 579  004f c65217        	ld	a,21015
 580  0052 a502          	bcp	a,#2
 581  0054 2605          	jrne	L113
 583  0056 ce0000        	ldw	x,_TIM3_tout
 584  0059 26f4          	jrne	L503
 585  005b               L113:
 586                     ; 152 	if(!tout()){
 588  005b ce0000        	ldw	x,_TIM3_tout
 589  005e 2604          	jrne	L313
 590                     ; 153 		return IIC_ERROR_NOT_ACK;
 592  0060 a603          	ld	a,#3
 594  0062               L22:
 596  0062 85            	popw	x
 597  0063 81            	ret
 598  0064               L313:
 599                     ; 156   if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
 601  0064 7b07          	ld	a,(OFST+7,sp)
 602  0066 a103          	cp	a,#3
 603  0068 257b          	jrult	L513
 604                     ; 158     I2C->SR3;                                     			// ADDR clearing sequence    
 606  006a c65219        	ld	a,21017
 607  006d 97            	ld	xl,a
 609  006e 201c          	jra	L123
 610  0070               L723:
 611                     ; 161       while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
 613  0070 c65217        	ld	a,21015
 614  0073 a504          	bcp	a,#4
 615  0075 2605          	jrne	L333
 617  0077 ce0000        	ldw	x,_TIM3_tout
 618  007a 26f4          	jrne	L723
 619  007c               L333:
 620                     ; 162 			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
 622  007c 1e05          	ldw	x,(OFST+5,sp)
 623  007e 1c0001        	addw	x,#1
 624  0081 1f05          	ldw	(OFST+5,sp),x
 625  0083 1d0001        	subw	x,#1
 626  0086 c65216        	ld	a,21014
 627  0089 f7            	ld	(x),a
 628                     ; 163       --NumByteToRead;																		// Decrease Numbyte to reade by 1
 630  008a 0a07          	dec	(OFST+7,sp)
 631  008c               L123:
 632                     ; 159     while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
 634  008c 7b07          	ld	a,(OFST+7,sp)
 635  008e a104          	cp	a,#4
 636  0090 2505          	jrult	L143
 638  0092 ce0000        	ldw	x,_TIM3_tout
 639  0095 26d9          	jrne	L723
 640  0097               L143:
 641                     ; 166     while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
 643  0097 c65217        	ld	a,21015
 644  009a a504          	bcp	a,#4
 645  009c 2605          	jrne	L543
 647  009e ce0000        	ldw	x,_TIM3_tout
 648  00a1 26f4          	jrne	L143
 649  00a3               L543:
 650                     ; 167     I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
 652  00a3 72155211      	bres	21009,#2
 653                     ; 168     disableInterrupts();                          			// Errata workaround (Disable interrupt)
 656  00a7 9b            sim
 658                     ; 169     *pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
 661  00a8 1e05          	ldw	x,(OFST+5,sp)
 662  00aa 1c0001        	addw	x,#1
 663  00ad 1f05          	ldw	(OFST+5,sp),x
 664  00af 1d0001        	subw	x,#1
 665  00b2 c65216        	ld	a,21014
 666  00b5 f7            	ld	(x),a
 667                     ; 170     I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
 669  00b6 72125211      	bset	21009,#1
 670                     ; 171     *pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
 672  00ba 1e05          	ldw	x,(OFST+5,sp)
 673  00bc 1c0001        	addw	x,#1
 674  00bf 1f05          	ldw	(OFST+5,sp),x
 675  00c1 1d0001        	subw	x,#1
 676  00c4 c65216        	ld	a,21014
 677  00c7 f7            	ld	(x),a
 678                     ; 172     enableInterrupts();																	// Errata workaround (Enable interrupt)
 681  00c8 9a            rim
 685  00c9               L153:
 686                     ; 173     while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
 688  00c9 c65217        	ld	a,21015
 689  00cc a540          	bcp	a,#64
 690  00ce 2605          	jrne	L553
 692  00d0 ce0000        	ldw	x,_TIM3_tout
 693  00d3 26f4          	jrne	L153
 694  00d5               L553:
 695                     ; 174     *pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
 697  00d5 1e05          	ldw	x,(OFST+5,sp)
 698  00d7 1c0001        	addw	x,#1
 699  00da 1f05          	ldw	(OFST+5,sp),x
 700  00dc 1d0001        	subw	x,#1
 701  00df c65216        	ld	a,21014
 702  00e2 f7            	ld	(x),a
 704  00e3 205c          	jra	L704
 705  00e5               L513:
 706                     ; 178     if(NumByteToRead == 2)                						// *** just two bytes are received? ***
 708  00e5 7b07          	ld	a,(OFST+7,sp)
 709  00e7 a102          	cp	a,#2
 710  00e9 2636          	jrne	L163
 711                     ; 180       I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
 713  00eb 72165211      	bset	21009,#3
 714                     ; 181       disableInterrupts();                          		// Errata workaround (Disable interrupt)
 717  00ef 9b            sim
 719                     ; 182       I2C->SR3;                                       	// Clear ADDR Flag
 722  00f0 c65219        	ld	a,21017
 723  00f3 97            	ld	xl,a
 724                     ; 183       I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK 
 726  00f4 72155211      	bres	21009,#2
 727                     ; 184       enableInterrupts();																// Errata workaround (Enable interrupt)
 730  00f8 9a            rim
 734  00f9               L563:
 735                     ; 185       while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
 737  00f9 c65217        	ld	a,21015
 738  00fc a504          	bcp	a,#4
 739  00fe 2605          	jrne	L173
 741  0100 ce0000        	ldw	x,_TIM3_tout
 742  0103 26f4          	jrne	L563
 743  0105               L173:
 744                     ; 186       disableInterrupts();                          		// Errata workaround (Disable interrupt)
 747  0105 9b            sim
 749                     ; 187       I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
 752  0106 72125211      	bset	21009,#1
 753                     ; 188       *pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
 755  010a 1e05          	ldw	x,(OFST+5,sp)
 756  010c 1c0001        	addw	x,#1
 757  010f 1f05          	ldw	(OFST+5,sp),x
 758  0111 1d0001        	subw	x,#1
 759  0114 c65216        	ld	a,21014
 760  0117 f7            	ld	(x),a
 761                     ; 189       enableInterrupts();																// Errata workaround (Enable interrupt)
 764  0118 9a            rim
 766                     ; 190 			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
 769  0119 1e05          	ldw	x,(OFST+5,sp)
 770  011b c65216        	ld	a,21014
 771  011e f7            	ld	(x),a
 773  011f 2020          	jra	L704
 774  0121               L163:
 775                     ; 194       I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK 
 777  0121 72155211      	bres	21009,#2
 778                     ; 195       disableInterrupts();                          		// Errata workaround (Disable interrupt)
 782  0125 9b            sim
 784                     ; 196       I2C->SR3;                                       	// Clear ADDR Flag   
 787  0126 c65219        	ld	a,21017
 788  0129 97            	ld	xl,a
 789                     ; 197       I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
 791  012a 72125211      	bset	21009,#1
 792                     ; 198       enableInterrupts();																// Errata workaround (Enable interrupt)
 795  012e 9a            rim
 799  012f               L773:
 800                     ; 199       while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
 802  012f c65217        	ld	a,21015
 803  0132 a540          	bcp	a,#64
 804  0134 2605          	jrne	L304
 806  0136 ce0000        	ldw	x,_TIM3_tout
 807  0139 26f4          	jrne	L773
 808  013b               L304:
 809                     ; 200       *pReadDataBuffer = I2C->DR;                     		// Read Data byte
 811  013b 1e05          	ldw	x,(OFST+5,sp)
 812  013d c65216        	ld	a,21014
 813  0140 f7            	ld	(x),a
 814  0141               L704:
 815                     ; 204   while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
 817  0141 c65211        	ld	a,21009
 818  0144 a502          	bcp	a,#2
 819  0146 2705          	jreq	L314
 821  0148 ce0000        	ldw	x,_TIM3_tout
 822  014b 26f4          	jrne	L704
 823  014d               L314:
 824                     ; 205   I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
 826  014d 72175211      	bres	21009,#3
 827                     ; 206 	if(!tout()){
 829  0151 ce0000        	ldw	x,_TIM3_tout
 830  0154 2604          	jrne	L514
 831                     ; 207 		return IIC_ERROR_TIME_OUT;
 833  0156 a601          	ld	a,#1
 835  0158 2001          	jra	L42
 836  015a               L514:
 837                     ; 209 		return IIC_SUCCESS;
 839  015a 4f            	clr	a
 841  015b               L42:
 843  015b 85            	popw	x
 844  015c 81            	ret
 926                     ; 213 uint8_t I2C_WriteReadBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite,uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
 926                     ; 214 {
 927                     .text:	section	.text,new
 928  0000               _I2C_WriteReadBytes:
 930  0000 89            	pushw	x
 931       00000000      OFST:	set	0
 934                     ; 215 	set_tout_ms(TimeOutOfMs);
 936  0001 7b0b          	ld	a,(OFST+11,sp)
 937  0003 5f            	clrw	x
 938  0004 97            	ld	xl,a
 939  0005 cf0000        	ldw	_TIM3_tout,x
 942  0008 2010          	jra	L554
 943  000a               L354:
 944                     ; 219 		I2C->CR2 |= I2C_CR2_STOP;                   				// Generate stop here (STOP=1)
 946  000a 72125211      	bset	21009,#1
 948  000e               L364:
 949                     ; 220     while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// Wait until stop is performed
 951  000e c65211        	ld	a,21009
 952  0011 a502          	bcp	a,#2
 953  0013 2705          	jreq	L554
 955  0015 ce0000        	ldw	x,_TIM3_tout
 956  0018 26f4          	jrne	L364
 957  001a               L554:
 958                     ; 217 	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
 960  001a c65219        	ld	a,21017
 961  001d a502          	bcp	a,#2
 962  001f 2705          	jreq	L174
 964  0021 ce0000        	ldw	x,_TIM3_tout
 965  0024 26e4          	jrne	L354
 966  0026               L174:
 967                     ; 222 	if(!tout()){return IIC_ERROR_BUSY;}
 969  0026 ce0000        	ldw	x,_TIM3_tout
 970  0029 2604          	jrne	L374
 973  002b a602          	ld	a,#2
 975  002d 2036          	jra	L03
 976  002f               L374:
 977                     ; 223 	I2C->CR2 &= ~I2C_CR2_STOP;
 979  002f 72135211      	bres	21009,#1
 980                     ; 224   I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
 982  0033 72145211      	bset	21009,#2
 983                     ; 226   I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
 985  0037 72105211      	bset	21009,#0
 987  003b               L774:
 988                     ; 227   while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// Wait for start bit detection (SB)
 990  003b c65217        	ld	a,21015
 991  003e a501          	bcp	a,#1
 992  0040 2605          	jrne	L305
 994  0042 ce0000        	ldw	x,_TIM3_tout
 995  0045 26f4          	jrne	L774
 996  0047               L305:
 997                     ; 229   if(tout())
 999  0047 ce0000        	ldw	x,_TIM3_tout
1000  004a 2706          	jreq	L115
1001                     ; 239       I2C->DR = (u8)(SlaveAddr << 1);   						// Send 7-bit device address & Write (R/W = 0)
1003  004c 7b02          	ld	a,(OFST+2,sp)
1004  004e 48            	sll	a
1005  004f c75216        	ld	21014,a
1006  0052               L115:
1007                     ; 242   while(!(I2C->SR1 & I2C_SR1_ADDR) &&  tout()); 				// test EV6 - wait for address ack (ADDR)
1009  0052 c65217        	ld	a,21015
1010  0055 a502          	bcp	a,#2
1011  0057 2605          	jrne	L515
1013  0059 ce0000        	ldw	x,_TIM3_tout
1014  005c 26f4          	jrne	L115
1015  005e               L515:
1016                     ; 243 	if(!tout()){
1018  005e ce0000        	ldw	x,_TIM3_tout
1019  0061 2604          	jrne	L715
1020                     ; 244 		return IIC_ERROR_NOT_ACK;
1022  0063 a603          	ld	a,#3
1024  0065               L03:
1026  0065 85            	popw	x
1027  0066 81            	ret
1028  0067               L715:
1029                     ; 247   I2C->SR3;
1032  0067 c65219        	ld	a,21017
1033  006a 97            	ld	xl,a
1034                     ; 249 	if(NumByteToWrite > 0){
1036  006b 0d07          	tnz	(OFST+7,sp)
1037  006d 2736          	jreq	L125
1039  006f 201f          	jra	L525
1040  0071               L335:
1041                     ; 251 			while(!(I2C->SR1 & I2C_SR1_TXE) &&  tout());  				// Wait for TxE
1043  0071 c65217        	ld	a,21015
1044  0074 a580          	bcp	a,#128
1045  0076 2605          	jrne	L735
1047  0078 ce0000        	ldw	x,_TIM3_tout
1048  007b 26f4          	jrne	L335
1049  007d               L735:
1050                     ; 252 			if(tout())
1052  007d ce0000        	ldw	x,_TIM3_tout
1053  0080 270e          	jreq	L525
1054                     ; 254 				I2C->DR = *pWriteDataBuffer++;                         			// Send register address
1056  0082 1e05          	ldw	x,(OFST+5,sp)
1057  0084 1c0001        	addw	x,#1
1058  0087 1f05          	ldw	(OFST+5,sp),x
1059  0089 1d0001        	subw	x,#1
1060  008c f6            	ld	a,(x)
1061  008d c75216        	ld	21014,a
1062  0090               L525:
1063                     ; 250 		while(NumByteToWrite--){
1065  0090 7b07          	ld	a,(OFST+7,sp)
1066  0092 0a07          	dec	(OFST+7,sp)
1067  0094 4d            	tnz	a
1068  0095 26da          	jrne	L335
1070  0097               L545:
1071                     ; 257 		while((I2C->SR1 & (I2C_SR1_TXE | I2C_SR1_BTF)) != (I2C_SR1_TXE | I2C_SR1_BTF)  &&  tout()); 
1073  0097 c65217        	ld	a,21015
1074  009a a484          	and	a,#132
1075  009c a184          	cp	a,#132
1076  009e 2705          	jreq	L125
1078  00a0 ce0000        	ldw	x,_TIM3_tout
1079  00a3 26f2          	jrne	L545
1080  00a5               L125:
1081                     ; 268 	I2C->CR2 &= ~I2C_CR2_STOP;
1083  00a5 72135211      	bres	21009,#1
1084                     ; 269   I2C->CR2 |= I2C_CR2_START;                     				// START=1, generate re-start
1086  00a9 72105211      	bset	21009,#0
1088  00ad               L555:
1089                     ; 270   while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout()); 				// Wait for start bit detection (SB)
1091  00ad c65217        	ld	a,21015
1092  00b0 a501          	bcp	a,#1
1093  00b2 2605          	jrne	L165
1095  00b4 ce0000        	ldw	x,_TIM3_tout
1096  00b7 26f4          	jrne	L555
1097  00b9               L165:
1098                     ; 272   if(tout())
1100  00b9 ce0000        	ldw	x,_TIM3_tout
1101  00bc 2708          	jreq	L765
1102                     ; 284       I2C->DR = (u8)(SlaveAddr << 1) | 1;         	// Send 7-bit device address & Write (R/W = 1)
1104  00be 7b02          	ld	a,(OFST+2,sp)
1105  00c0 48            	sll	a
1106  00c1 aa01          	or	a,#1
1107  00c3 c75216        	ld	21014,a
1108  00c6               L765:
1109                     ; 287   while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());  			// Wait for address ack (ADDR)
1111  00c6 c65217        	ld	a,21015
1112  00c9 a502          	bcp	a,#2
1113  00cb 2605          	jrne	L375
1115  00cd ce0000        	ldw	x,_TIM3_tout
1116  00d0 26f4          	jrne	L765
1117  00d2               L375:
1118                     ; 288 	if(!tout()){
1120  00d2 ce0000        	ldw	x,_TIM3_tout
1121  00d5 2604          	jrne	L575
1122                     ; 289 		return IIC_ERROR_NOT_ACK;
1124  00d7 a603          	ld	a,#3
1126  00d9 208a          	jra	L03
1127  00db               L575:
1128                     ; 292   if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
1130  00db 7b0a          	ld	a,(OFST+10,sp)
1131  00dd a103          	cp	a,#3
1132  00df 257b          	jrult	L775
1133                     ; 294     I2C->SR3;                                     			// ADDR clearing sequence    
1135  00e1 c65219        	ld	a,21017
1136  00e4 97            	ld	xl,a
1138  00e5 201c          	jra	L306
1139  00e7               L116:
1140                     ; 297       while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
1142  00e7 c65217        	ld	a,21015
1143  00ea a504          	bcp	a,#4
1144  00ec 2605          	jrne	L516
1146  00ee ce0000        	ldw	x,_TIM3_tout
1147  00f1 26f4          	jrne	L116
1148  00f3               L516:
1149                     ; 298 			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
1151  00f3 1e08          	ldw	x,(OFST+8,sp)
1152  00f5 1c0001        	addw	x,#1
1153  00f8 1f08          	ldw	(OFST+8,sp),x
1154  00fa 1d0001        	subw	x,#1
1155  00fd c65216        	ld	a,21014
1156  0100 f7            	ld	(x),a
1157                     ; 299       --NumByteToRead;																		// Decrease Numbyte to reade by 1
1159  0101 0a0a          	dec	(OFST+10,sp)
1160  0103               L306:
1161                     ; 295     while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
1163  0103 7b0a          	ld	a,(OFST+10,sp)
1164  0105 a104          	cp	a,#4
1165  0107 2505          	jrult	L326
1167  0109 ce0000        	ldw	x,_TIM3_tout
1168  010c 26d9          	jrne	L116
1169  010e               L326:
1170                     ; 302     while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
1172  010e c65217        	ld	a,21015
1173  0111 a504          	bcp	a,#4
1174  0113 2605          	jrne	L726
1176  0115 ce0000        	ldw	x,_TIM3_tout
1177  0118 26f4          	jrne	L326
1178  011a               L726:
1179                     ; 303     I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
1181  011a 72155211      	bres	21009,#2
1182                     ; 304     disableInterrupts();                          			// Errata workaround (Disable interrupt)
1185  011e 9b            sim
1187                     ; 305     *pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
1190  011f 1e08          	ldw	x,(OFST+8,sp)
1191  0121 1c0001        	addw	x,#1
1192  0124 1f08          	ldw	(OFST+8,sp),x
1193  0126 1d0001        	subw	x,#1
1194  0129 c65216        	ld	a,21014
1195  012c f7            	ld	(x),a
1196                     ; 306     I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
1198  012d 72125211      	bset	21009,#1
1199                     ; 307     *pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
1201  0131 1e08          	ldw	x,(OFST+8,sp)
1202  0133 1c0001        	addw	x,#1
1203  0136 1f08          	ldw	(OFST+8,sp),x
1204  0138 1d0001        	subw	x,#1
1205  013b c65216        	ld	a,21014
1206  013e f7            	ld	(x),a
1207                     ; 308     enableInterrupts();																	// Errata workaround (Enable interrupt)
1210  013f 9a            rim
1214  0140               L336:
1215                     ; 309     while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
1217  0140 c65217        	ld	a,21015
1218  0143 a540          	bcp	a,#64
1219  0145 2605          	jrne	L736
1221  0147 ce0000        	ldw	x,_TIM3_tout
1222  014a 26f4          	jrne	L336
1223  014c               L736:
1224                     ; 310     *pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
1226  014c 1e08          	ldw	x,(OFST+8,sp)
1227  014e 1c0001        	addw	x,#1
1228  0151 1f08          	ldw	(OFST+8,sp),x
1229  0153 1d0001        	subw	x,#1
1230  0156 c65216        	ld	a,21014
1231  0159 f7            	ld	(x),a
1233  015a 205c          	jra	L176
1234  015c               L775:
1235                     ; 314    if(NumByteToRead == 2)                						// *** just two bytes are received? ***
1237  015c 7b0a          	ld	a,(OFST+10,sp)
1238  015e a102          	cp	a,#2
1239  0160 2636          	jrne	L346
1240                     ; 316       I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
1242  0162 72165211      	bset	21009,#3
1243                     ; 317       disableInterrupts();                          		// Errata workaround (Disable interrupt)
1246  0166 9b            sim
1248                     ; 318       I2C->SR3;                                       	// Clear ADDR Flag
1251  0167 c65219        	ld	a,21017
1252  016a 97            	ld	xl,a
1253                     ; 319       I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK 
1255  016b 72155211      	bres	21009,#2
1256                     ; 320       enableInterrupts();																// Errata workaround (Enable interrupt)
1259  016f 9a            rim
1263  0170               L746:
1264                     ; 321       while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
1266  0170 c65217        	ld	a,21015
1267  0173 a504          	bcp	a,#4
1268  0175 2605          	jrne	L356
1270  0177 ce0000        	ldw	x,_TIM3_tout
1271  017a 26f4          	jrne	L746
1272  017c               L356:
1273                     ; 322       disableInterrupts();                          		// Errata workaround (Disable interrupt)
1276  017c 9b            sim
1278                     ; 323       I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
1281  017d 72125211      	bset	21009,#1
1282                     ; 324       *pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
1284  0181 1e08          	ldw	x,(OFST+8,sp)
1285  0183 1c0001        	addw	x,#1
1286  0186 1f08          	ldw	(OFST+8,sp),x
1287  0188 1d0001        	subw	x,#1
1288  018b c65216        	ld	a,21014
1289  018e f7            	ld	(x),a
1290                     ; 325       enableInterrupts();																// Errata workaround (Enable interrupt)
1293  018f 9a            rim
1295                     ; 326 			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
1298  0190 1e08          	ldw	x,(OFST+8,sp)
1299  0192 c65216        	ld	a,21014
1300  0195 f7            	ld	(x),a
1302  0196 2020          	jra	L176
1303  0198               L346:
1304                     ; 330       I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK 
1306  0198 72155211      	bres	21009,#2
1307                     ; 331       disableInterrupts();                          		// Errata workaround (Disable interrupt)
1311  019c 9b            sim
1313                     ; 332       I2C->SR3;                                       	// Clear ADDR Flag   
1316  019d c65219        	ld	a,21017
1317  01a0 97            	ld	xl,a
1318                     ; 333       I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
1320  01a1 72125211      	bset	21009,#1
1321                     ; 334       enableInterrupts();																// Errata workaround (Enable interrupt)
1324  01a5 9a            rim
1328  01a6               L166:
1329                     ; 335       while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
1331  01a6 c65217        	ld	a,21015
1332  01a9 a540          	bcp	a,#64
1333  01ab 2605          	jrne	L566
1335  01ad ce0000        	ldw	x,_TIM3_tout
1336  01b0 26f4          	jrne	L166
1337  01b2               L566:
1338                     ; 336       *pReadDataBuffer = I2C->DR;                     		// Read Data byte
1340  01b2 1e08          	ldw	x,(OFST+8,sp)
1341  01b4 c65216        	ld	a,21014
1342  01b7 f7            	ld	(x),a
1343  01b8               L176:
1344                     ; 340   while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
1346  01b8 c65211        	ld	a,21009
1347  01bb a502          	bcp	a,#2
1348  01bd 2705          	jreq	L576
1350  01bf ce0000        	ldw	x,_TIM3_tout
1351  01c2 26f4          	jrne	L176
1352  01c4               L576:
1353                     ; 341   I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
1355  01c4 72175211      	bres	21009,#3
1356                     ; 342 	return IIC_SUCCESS;
1358  01c8 4f            	clr	a
1361  01c9 85            	popw	x
1362  01ca 81            	ret
1386                     ; 352 void ErrProc(void)
1386                     ; 353 {
1387                     .text:	section	.text,new
1388  0000               _ErrProc:
1392                     ; 355     I2C->SR2= 0;
1394  0000 725f5218      	clr	21016
1395                     ; 357 	  I2C->CR2 |= 2;  
1397  0004 72125211      	bset	21009,#1
1398                     ; 359     TIM3_tout= 0;
1400  0008 5f            	clrw	x
1401  0009 cf0000        	ldw	_TIM3_tout,x
1402                     ; 362 }
1405  000c 81            	ret
1429                     ; 373 void My_TIM3_Init (void) {
1430                     .text:	section	.text,new
1431  0000               _My_TIM3_Init:
1435                     ; 374 	TIM3->ARRH = 0;
1437  0000 725f532b      	clr	21291
1438                     ; 375   TIM3->ARRL = 0x80;                // init timer 4 1ms inetrrupts
1440  0004 3580532c      	mov	21292,#128
1441                     ; 376   TIM3->PSCR= 7;
1443  0008 3507532a      	mov	21290,#7
1444                     ; 377   TIM3->IER = 1;
1446  000c 35015321      	mov	21281,#1
1447                     ; 378   TIM3->CR1 |= 1;
1449  0010 72105320      	bset	21280,#0
1450                     ; 379 	TIM3_tout = 0;
1452  0014 5f            	clrw	x
1453  0015 cf0000        	ldw	_TIM3_tout,x
1454                     ; 380 }
1457  0018 81            	ret
1482                     ; 390 @far @interrupt void I2C_error_Interrupt_Handler (void) {
1484                     .text:	section	.text,new
1485  0000               f_I2C_error_Interrupt_Handler:
1488  0000 3b0002        	push	c_x+2
1489  0003 be00          	ldw	x,c_x
1490  0005 89            	pushw	x
1491  0006 3b0002        	push	c_y+2
1492  0009 be00          	ldw	x,c_y
1493  000b 89            	pushw	x
1496                     ; 394 ErrProc();
1498  000c cd0000        	call	_ErrProc
1500                     ; 395 }
1503  000f 85            	popw	x
1504  0010 bf00          	ldw	c_y,x
1505  0012 320002        	pop	c_y+2
1506  0015 85            	popw	x
1507  0016 bf00          	ldw	c_x,x
1508  0018 320002        	pop	c_x+2
1509  001b 80            	iret
1543                     ; 405 @far @interrupt void TIM3InterruptHandle (void) {
1544                     .text:	section	.text,new
1545  0000               f_TIM3InterruptHandle:
1548       00000001      OFST:	set	1
1549  0000 88            	push	a
1552                     ; 409   u8 dly= 10;
1554  0001 a60a          	ld	a,#10
1555  0003 6b01          	ld	(OFST+0,sp),a
1556                     ; 411   TIM3->SR1= 0;
1558  0005 725f5322      	clr	21282
1559                     ; 413   if(TIM3_tout)
1561  0009 ce0000        	ldw	x,_TIM3_tout
1562  000c 270c          	jreq	L157
1563                     ; 414     if(--TIM3_tout == 0)
1565  000e ce0000        	ldw	x,_TIM3_tout
1566  0011 1d0001        	subw	x,#1
1567  0014 cf0000        	ldw	_TIM3_tout,x
1568  0017 2601          	jrne	L157
1569                     ; 416       _asm("nop");
1572  0019 9d            nop
1574  001a               L157:
1575                     ; 420   while(dly--);
1577  001a 7b01          	ld	a,(OFST+0,sp)
1578  001c 0a01          	dec	(OFST+0,sp)
1579  001e 4d            	tnz	a
1580  001f 26f9          	jrne	L157
1581                     ; 421 }
1584  0021 84            	pop	a
1585  0022 80            	iret
1608                     	xdef	f_TIM3InterruptHandle
1609                     	xdef	f_I2C_error_Interrupt_Handler
1610                     	switch	.bss
1611  0000               _TIM3_tout:
1612  0000 0000          	ds.b	2
1613                     	xdef	_TIM3_tout
1614                     	xdef	_ErrProc
1615                     	xdef	_I2C_WriteReadBytes
1616                     	xdef	_I2C_ReadBytes
1617                     	xdef	_I2C_WriteBytes
1618                     	xdef	_My_TIM3_Init
1619                     	xdef	_I2C_Config
1620                     	xref	_I2C_SoftwareResetCmd
1621                     	xref	_I2C_Cmd
1622                     	xref	_I2C_Init
1623                     	xref	_I2C_DeInit
1624                     	xref	_CLK_GetClockFreq
1625                     	xref.b	c_lreg
1626                     	xref.b	c_x
1627                     	xref.b	c_y
1647                     	xref	c_ludv
1648                     	end
