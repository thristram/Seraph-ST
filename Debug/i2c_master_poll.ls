   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
   4                     	switch	.data
   5  0000               _GestureTimeOut:
   6  0000 0000          	dc.w	0
   7  0002               _I2CTimeOut:
   8  0002 0000          	dc.w	0
  55                     .const:	section	.text
  56  0000               L6:
  57  0000 000f4240      	dc.l	1000000
  58                     ; 35 uint8_t I2C_Config(void)
  58                     ; 36 {
  59                     	scross	off
  60                     .text:	section	.text,new
  61  0000               _I2C_Config:
  63  0000 89            	pushw	x
  64       00000002      OFST:	set	2
  67                     ; 37 	uint16_t time_out = 0;
  69  0001 5f            	clrw	x
  70  0002 1f01          	ldw	(OFST-1,sp),x
  71                     ; 39 	My_TIM3_Init();
  73  0004 cd0000        	call	_My_TIM3_Init
  75                     ; 40 	enableInterrupts();
  78  0007 9a            rim
  80                     ; 44 	I2C_DeInit();
  83  0008 cd0000        	call	_I2C_DeInit
  85                     ; 45 	CLK_PeripheralClockConfig(CLK_PERIPHERAL_I2C, ENABLE);
  87  000b ae0001        	ldw	x,#1
  88  000e 4f            	clr	a
  89  000f 95            	ld	xh,a
  90  0010 cd0000        	call	_CLK_PeripheralClockConfig
  92                     ; 46 	I2C_Init(100000, 0x50, I2C_DUTYCYCLE_2, I2C_ACK_CURR, I2C_ADDMODE_7BIT, CLK_GetClockFreq() /1000000);
  94  0013 cd0000        	call	_CLK_GetClockFreq
  96  0016 ae0000        	ldw	x,#L6
  97  0019 cd0000        	call	c_ludv
  99  001c b603          	ld	a,c_lreg+3
 100  001e 88            	push	a
 101  001f 4b00          	push	#0
 102  0021 4b01          	push	#1
 103  0023 4b00          	push	#0
 104  0025 ae0050        	ldw	x,#80
 105  0028 89            	pushw	x
 106  0029 ae86a0        	ldw	x,#34464
 107  002c 89            	pushw	x
 108  002d ae0001        	ldw	x,#1
 109  0030 89            	pushw	x
 110  0031 cd0000        	call	_I2C_Init
 112  0034 5b0a          	addw	sp,#10
 113                     ; 48 	I2C_Cmd(ENABLE);
 115  0036 a601          	ld	a,#1
 116  0038 cd0000        	call	_I2C_Cmd
 119  003b 2036          	jra	L72
 120  003d               L52:
 121                     ; 51 		set_tout_ms(10);
 123  003d ae000a        	ldw	x,#10
 124  0040 cf0002        	ldw	_I2CTimeOut,x
 125                     ; 52 		I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
 128  0043 72125211      	bset	21009,#1
 130  0047               L53:
 131                     ; 53 		while((I2C->CR2 & I2C_CR2_STOP) && tout());      							// wait until stop is performed
 133  0047 c65211        	ld	a,21009
 134  004a a502          	bcp	a,#2
 135  004c 2705          	jreq	L14
 137  004e ce0002        	ldw	x,_I2CTimeOut
 138  0051 26f4          	jrne	L53
 139  0053               L14:
 140                     ; 54 		time_out += 10;
 142  0053 1e01          	ldw	x,(OFST-1,sp)
 143  0055 1c000a        	addw	x,#10
 144  0058 1f01          	ldw	(OFST-1,sp),x
 145                     ; 55 		if(!tout())
 147  005a ce0002        	ldw	x,_I2CTimeOut
 148  005d 2609          	jrne	L34
 149                     ; 57 			I2C_SoftwareResetCmd(ENABLE);
 151  005f a601          	ld	a,#1
 152  0061 cd0000        	call	_I2C_SoftwareResetCmd
 154                     ; 58 			I2C_SoftwareResetCmd(DISABLE);
 156  0064 4f            	clr	a
 157  0065 cd0000        	call	_I2C_SoftwareResetCmd
 159  0068               L34:
 160                     ; 60 		if(time_out > 500)
 162  0068 1e01          	ldw	x,(OFST-1,sp)
 163  006a a301f5        	cpw	x,#501
 164  006d 2504          	jrult	L72
 165                     ; 62 			return IIC_ERROR_BUSY;
 167  006f a602          	ld	a,#2
 169  0071 2008          	jra	L01
 170  0073               L72:
 171                     ; 49 	while((I2C->SR3 & I2C_SR3_BUSY))       									// Wait while the bus is busy
 173  0073 c65219        	ld	a,21017
 174  0076 a502          	bcp	a,#2
 175  0078 26c3          	jrne	L52
 176                     ; 66 	return IIC_SUCCESS;
 178  007a 4f            	clr	a
 180  007b               L01:
 182  007b 85            	popw	x
 183  007c 81            	ret
 240                     ; 77 uint8_t I2C_WriteBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite, uint8_t TimeOutOfMs)
 240                     ; 78 {
 241                     .text:	section	.text,new
 242  0000               _I2C_WriteBytes:
 244  0000 89            	pushw	x
 245       00000000      OFST:	set	0
 248                     ; 79 	set_tout_ms(TimeOutOfMs);
 250  0001 7b08          	ld	a,(OFST+8,sp)
 251  0003 5f            	clrw	x
 252  0004 97            	ld	xl,a
 253  0005 cf0002        	ldw	_I2CTimeOut,x
 256  0008 2010          	jra	L57
 257  000a               L37:
 258                     ; 82 		I2C->CR2 |= I2C_CR2_STOP;                        								// STOP=1, generate stop
 260  000a 72125211      	bset	21009,#1
 262  000e               L301:
 263                     ; 83 		while((I2C->CR2 & I2C_CR2_STOP) && tout());      								// wait until stop is performed
 265  000e c65211        	ld	a,21009
 266  0011 a502          	bcp	a,#2
 267  0013 2705          	jreq	L57
 269  0015 ce0002        	ldw	x,_I2CTimeOut
 270  0018 26f4          	jrne	L301
 271  001a               L57:
 272                     ; 80 	while((I2C->SR3 & I2C_SR3_BUSY) && tout())       									// Wait while the bus is busy
 274  001a c65219        	ld	a,21017
 275  001d a502          	bcp	a,#2
 276  001f 2705          	jreq	L111
 278  0021 ce0002        	ldw	x,_I2CTimeOut
 279  0024 26e4          	jrne	L37
 280  0026               L111:
 281                     ; 85 	if(!tout())
 283  0026 ce0002        	ldw	x,_I2CTimeOut
 284  0029 2604          	jrne	L311
 285                     ; 87 		return IIC_ERROR_BUSY;
 287  002b a602          	ld	a,#2
 289  002d 201f          	jra	L41
 290  002f               L311:
 291                     ; 89 	I2C->CR2 |= I2C_CR2_START;                        									// START=1, generate start
 293  002f 72105211      	bset	21009,#0
 295  0033               L711:
 296                     ; 90 	while(((I2C->SR1 & I2C_SR1_SB)==0) && tout()); 									// Wait for start bit detection (SB)
 298  0033 c65217        	ld	a,21015
 299  0036 a501          	bcp	a,#1
 300  0038 2605          	jrne	L321
 302  003a ce0002        	ldw	x,_I2CTimeOut
 303  003d 26f4          	jrne	L711
 304  003f               L321:
 305                     ; 92 	if(tout())
 308  003f ce0002        	ldw	x,_I2CTimeOut
 309  0042 2708          	jreq	L521
 310                     ; 102 		I2C->DR = (u8)(SlaveAddr << 1);   									// Send 7-bit device address & Write (R/W = 0)
 312  0044 7b02          	ld	a,(OFST+2,sp)
 313  0046 48            	sll	a
 314  0047 c75216        	ld	21014,a
 316  004a 2004          	jra	L331
 317  004c               L521:
 318                     ; 107 		return IIC_ERROR_TIME_OUT;
 320  004c a601          	ld	a,#1
 322  004e               L41:
 324  004e 85            	popw	x
 325  004f 81            	ret
 326  0050               L331:
 327                     ; 109 	while(!(I2C->SR1 & I2C_SR1_ADDR) && tout());     									// Wait for address ack (ADDR)
 329  0050 c65217        	ld	a,21015
 330  0053 a502          	bcp	a,#2
 331  0055 2605          	jrne	L731
 333  0057 ce0002        	ldw	x,_I2CTimeOut
 334  005a 26f4          	jrne	L331
 335  005c               L731:
 336                     ; 110 	if(!tout())
 338  005c ce0002        	ldw	x,_I2CTimeOut
 339  005f 2608          	jrne	L141
 340                     ; 112 		I2C->CR2 |= I2C_CR2_STOP;
 342  0061 72125211      	bset	21009,#1
 343                     ; 113 		return IIC_ERROR_NOT_ACK;
 345  0065 a603          	ld	a,#3
 347  0067 20e5          	jra	L41
 348  0069               L141:
 349                     ; 116 	I2C->SR3;
 352  0069 c65219        	ld	a,21017
 353  006c 97            	ld	xl,a
 355  006d               L541:
 356                     ; 117 	while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  									// Wait for TxE
 358  006d c65217        	ld	a,21015
 359  0070 a580          	bcp	a,#128
 360  0072 2605          	jrne	L151
 362  0074 ce0002        	ldw	x,_I2CTimeOut
 363  0077 26f4          	jrne	L541
 364  0079               L151:
 365                     ; 118 	if(NumByteToWrite)
 367  0079 0d07          	tnz	(OFST+7,sp)
 368  007b 2736          	jreq	L351
 370  007d 201f          	jra	L751
 371  007f               L551:
 372                     ; 122 			I2C->DR = *pWriteDataBuffer++;
 374  007f 1e05          	ldw	x,(OFST+5,sp)
 375  0081 1c0001        	addw	x,#1
 376  0084 1f05          	ldw	(OFST+5,sp),x
 377  0086 1d0001        	subw	x,#1
 378  0089 f6            	ld	a,(x)
 379  008a c75216        	ld	21014,a
 381  008d               L761:
 382                     ; 123 			while(!(I2C->SR1 & I2C_SR1_TXE) && tout());  								// test EV8 - wait for TxE
 384  008d c65217        	ld	a,21015
 385  0090 a580          	bcp	a,#128
 386  0092 2605          	jrne	L371
 388  0094 ce0002        	ldw	x,_I2CTimeOut
 389  0097 26f4          	jrne	L761
 390  0099               L371:
 391                     ; 124 			if(!tout())
 393  0099 ce0002        	ldw	x,_I2CTimeOut
 394  009c 2707          	jreq	L102
 395                     ; 126 				break;
 397  009e               L751:
 398                     ; 120 		while(NumByteToWrite--)
 400  009e 7b07          	ld	a,(OFST+7,sp)
 401  00a0 0a07          	dec	(OFST+7,sp)
 402  00a2 4d            	tnz	a
 403  00a3 26da          	jrne	L551
 404  00a5               L102:
 405                     ; 129 		while(((I2C->SR1 & (I2C_SR1_TXE|I2C_SR1_BTF)) != (I2C_SR1_TXE|I2C_SR1_BTF)) && tout()); 					// Wait for TxE & BTF
 407  00a5 c65217        	ld	a,21015
 408  00a8 a484          	and	a,#132
 409  00aa a184          	cp	a,#132
 410  00ac 2705          	jreq	L351
 412  00ae ce0002        	ldw	x,_I2CTimeOut
 413  00b1 26f2          	jrne	L102
 414  00b3               L351:
 415                     ; 133 	I2C->CR2 |= I2C_CR2_STOP;                        									// generate stop here (STOP=1)
 417  00b3 72125211      	bset	21009,#1
 419  00b7               L112:
 420                     ; 134 	while((I2C->CR2 & I2C_CR2_STOP) && tout());      									// wait until stop is performed
 422  00b7 c65211        	ld	a,21009
 423  00ba a502          	bcp	a,#2
 424  00bc 2705          	jreq	L512
 426  00be ce0002        	ldw	x,_I2CTimeOut
 427  00c1 26f4          	jrne	L112
 428  00c3               L512:
 429                     ; 135 	if(!tout())
 431  00c3 ce0002        	ldw	x,_I2CTimeOut
 432  00c6 2604          	jrne	L712
 433                     ; 137 		return IIC_ERROR_TIME_OUT;
 435  00c8 a601          	ld	a,#1
 437  00ca 2001          	jra	L61
 438  00cc               L712:
 439                     ; 141 		return IIC_SUCCESS;
 441  00cc 4f            	clr	a
 443  00cd               L61:
 445  00cd 85            	popw	x
 446  00ce 81            	ret
 511                     ; 145 uint8_t I2C_ReadBytes(uint16_t SlaveAddr, uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
 511                     ; 146 {
 512                     .text:	section	.text,new
 513  0000               _I2C_ReadBytes:
 515  0000 89            	pushw	x
 516       00000000      OFST:	set	0
 519                     ; 147 	set_tout_ms(TimeOutOfMs);
 521  0001 7b08          	ld	a,(OFST+8,sp)
 522  0003 5f            	clrw	x
 523  0004 97            	ld	xl,a
 524  0005 cf0002        	ldw	_I2CTimeOut,x
 527  0008 2010          	jra	L152
 528  000a               L742:
 529                     ; 151 		I2C->CR2 |= I2C_CR2_STOP;                   				// STOP=1, generate stop
 531  000a 72125211      	bset	21009,#1
 533  000e               L752:
 534                     ; 152 		while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// wait until stop is performed
 536  000e c65211        	ld	a,21009
 537  0011 a502          	bcp	a,#2
 538  0013 2705          	jreq	L152
 540  0015 ce0002        	ldw	x,_I2CTimeOut
 541  0018 26f4          	jrne	L752
 542  001a               L152:
 543                     ; 149 	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
 545  001a c65219        	ld	a,21017
 546  001d a502          	bcp	a,#2
 547  001f 2705          	jreq	L562
 549  0021 ce0002        	ldw	x,_I2CTimeOut
 550  0024 26e4          	jrne	L742
 551  0026               L562:
 552                     ; 154 	if(!tout())
 554  0026 ce0002        	ldw	x,_I2CTimeOut
 555  0029 2604          	jrne	L762
 556                     ; 156 		return IIC_ERROR_BUSY;
 558  002b a602          	ld	a,#2
 560  002d 2033          	jra	L22
 561  002f               L762:
 562                     ; 158 	I2C->CR2 &= ~I2C_CR2_STOP;
 564  002f 72135211      	bres	21009,#1
 565                     ; 159 	I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
 567  0033 72145211      	bset	21009,#2
 568                     ; 161 	I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
 570  0037 72105211      	bset	21009,#0
 572  003b               L372:
 573                     ; 162 	while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// wait for start bit detection (SB)
 575  003b c65217        	ld	a,21015
 576  003e a501          	bcp	a,#1
 577  0040 2605          	jrne	L772
 579  0042 ce0002        	ldw	x,_I2CTimeOut
 580  0045 26f4          	jrne	L372
 581  0047               L772:
 582                     ; 173 	I2C->DR = (u8)(SlaveAddr << 1) | 1;       			// Send 7-bit device address & Write (R/W = 1)
 584  0047 7b02          	ld	a,(OFST+2,sp)
 585  0049 48            	sll	a
 586  004a aa01          	or	a,#1
 587  004c c75216        	ld	21014,a
 589  004f               L503:
 590                     ; 175 	while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());				// Wait for address ack (ADDR)
 592  004f c65217        	ld	a,21015
 593  0052 a502          	bcp	a,#2
 594  0054 2605          	jrne	L113
 596  0056 ce0002        	ldw	x,_I2CTimeOut
 597  0059 26f4          	jrne	L503
 598  005b               L113:
 599                     ; 176 	if(!tout())
 601  005b ce0002        	ldw	x,_I2CTimeOut
 602  005e 2604          	jrne	L313
 603                     ; 178 		return IIC_ERROR_NOT_ACK;
 605  0060 a603          	ld	a,#3
 607  0062               L22:
 609  0062 85            	popw	x
 610  0063 81            	ret
 611  0064               L313:
 612                     ; 181 	if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
 614  0064 7b07          	ld	a,(OFST+7,sp)
 615  0066 a103          	cp	a,#3
 616  0068 257b          	jrult	L513
 617                     ; 183 		I2C->SR3;                                     			// ADDR clearing sequence
 619  006a c65219        	ld	a,21017
 620  006d 97            	ld	xl,a
 622  006e 201c          	jra	L123
 623  0070               L723:
 624                     ; 186 			while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
 626  0070 c65217        	ld	a,21015
 627  0073 a504          	bcp	a,#4
 628  0075 2605          	jrne	L333
 630  0077 ce0002        	ldw	x,_I2CTimeOut
 631  007a 26f4          	jrne	L723
 632  007c               L333:
 633                     ; 187 			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
 635  007c 1e05          	ldw	x,(OFST+5,sp)
 636  007e 1c0001        	addw	x,#1
 637  0081 1f05          	ldw	(OFST+5,sp),x
 638  0083 1d0001        	subw	x,#1
 639  0086 c65216        	ld	a,21014
 640  0089 f7            	ld	(x),a
 641                     ; 188 			--NumByteToRead;																		// Decrease Numbyte to reade by 1
 643  008a 0a07          	dec	(OFST+7,sp)
 644  008c               L123:
 645                     ; 184 		while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
 647  008c 7b07          	ld	a,(OFST+7,sp)
 648  008e a104          	cp	a,#4
 649  0090 2505          	jrult	L143
 651  0092 ce0002        	ldw	x,_I2CTimeOut
 652  0095 26d9          	jrne	L723
 653  0097               L143:
 654                     ; 191 		while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
 656  0097 c65217        	ld	a,21015
 657  009a a504          	bcp	a,#4
 658  009c 2605          	jrne	L543
 660  009e ce0002        	ldw	x,_I2CTimeOut
 661  00a1 26f4          	jrne	L143
 662  00a3               L543:
 663                     ; 192 		I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
 665  00a3 72155211      	bres	21009,#2
 666                     ; 193 		disableInterrupts();                          			// Errata workaround (Disable interrupt)
 669  00a7 9b            sim
 671                     ; 194 		*pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
 674  00a8 1e05          	ldw	x,(OFST+5,sp)
 675  00aa 1c0001        	addw	x,#1
 676  00ad 1f05          	ldw	(OFST+5,sp),x
 677  00af 1d0001        	subw	x,#1
 678  00b2 c65216        	ld	a,21014
 679  00b5 f7            	ld	(x),a
 680                     ; 195 		I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
 682  00b6 72125211      	bset	21009,#1
 683                     ; 196 		*pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
 685  00ba 1e05          	ldw	x,(OFST+5,sp)
 686  00bc 1c0001        	addw	x,#1
 687  00bf 1f05          	ldw	(OFST+5,sp),x
 688  00c1 1d0001        	subw	x,#1
 689  00c4 c65216        	ld	a,21014
 690  00c7 f7            	ld	(x),a
 691                     ; 197 		enableInterrupts();																	// Errata workaround (Enable interrupt)
 694  00c8 9a            rim
 698  00c9               L153:
 699                     ; 198 		while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
 701  00c9 c65217        	ld	a,21015
 702  00cc a540          	bcp	a,#64
 703  00ce 2605          	jrne	L553
 705  00d0 ce0002        	ldw	x,_I2CTimeOut
 706  00d3 26f4          	jrne	L153
 707  00d5               L553:
 708                     ; 199 		*pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
 710  00d5 1e05          	ldw	x,(OFST+5,sp)
 711  00d7 1c0001        	addw	x,#1
 712  00da 1f05          	ldw	(OFST+5,sp),x
 713  00dc 1d0001        	subw	x,#1
 714  00df c65216        	ld	a,21014
 715  00e2 f7            	ld	(x),a
 717  00e3 205c          	jra	L704
 718  00e5               L513:
 719                     ; 203 		if(NumByteToRead == 2)                						// *** just two bytes are received? ***
 721  00e5 7b07          	ld	a,(OFST+7,sp)
 722  00e7 a102          	cp	a,#2
 723  00e9 2636          	jrne	L163
 724                     ; 205 			I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
 726  00eb 72165211      	bset	21009,#3
 727                     ; 206 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
 730  00ef 9b            sim
 732                     ; 207 			I2C->SR3;                                       	// Clear ADDR Flag
 735  00f0 c65219        	ld	a,21017
 736  00f3 97            	ld	xl,a
 737                     ; 208 			I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK
 739  00f4 72155211      	bres	21009,#2
 740                     ; 209 			enableInterrupts();																// Errata workaround (Enable interrupt)
 743  00f8 9a            rim
 747  00f9               L563:
 748                     ; 210 			while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
 750  00f9 c65217        	ld	a,21015
 751  00fc a504          	bcp	a,#4
 752  00fe 2605          	jrne	L173
 754  0100 ce0002        	ldw	x,_I2CTimeOut
 755  0103 26f4          	jrne	L563
 756  0105               L173:
 757                     ; 211 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
 760  0105 9b            sim
 762                     ; 212 			I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
 765  0106 72125211      	bset	21009,#1
 766                     ; 213 			*pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
 768  010a 1e05          	ldw	x,(OFST+5,sp)
 769  010c 1c0001        	addw	x,#1
 770  010f 1f05          	ldw	(OFST+5,sp),x
 771  0111 1d0001        	subw	x,#1
 772  0114 c65216        	ld	a,21014
 773  0117 f7            	ld	(x),a
 774                     ; 214 			enableInterrupts();																// Errata workaround (Enable interrupt)
 777  0118 9a            rim
 779                     ; 215 			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
 782  0119 1e05          	ldw	x,(OFST+5,sp)
 783  011b c65216        	ld	a,21014
 784  011e f7            	ld	(x),a
 786  011f 2020          	jra	L704
 787  0121               L163:
 788                     ; 219 			I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK
 790  0121 72155211      	bres	21009,#2
 791                     ; 220 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
 795  0125 9b            sim
 797                     ; 221 			I2C->SR3;                                       	// Clear ADDR Flag
 800  0126 c65219        	ld	a,21017
 801  0129 97            	ld	xl,a
 802                     ; 222 			I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
 804  012a 72125211      	bset	21009,#1
 805                     ; 223 			enableInterrupts();																// Errata workaround (Enable interrupt)
 808  012e 9a            rim
 812  012f               L773:
 813                     ; 224 			while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
 815  012f c65217        	ld	a,21015
 816  0132 a540          	bcp	a,#64
 817  0134 2605          	jrne	L304
 819  0136 ce0002        	ldw	x,_I2CTimeOut
 820  0139 26f4          	jrne	L773
 821  013b               L304:
 822                     ; 225 			*pReadDataBuffer = I2C->DR;                     		// Read Data byte
 824  013b 1e05          	ldw	x,(OFST+5,sp)
 825  013d c65216        	ld	a,21014
 826  0140 f7            	ld	(x),a
 827  0141               L704:
 828                     ; 229 	while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
 830  0141 c65211        	ld	a,21009
 831  0144 a502          	bcp	a,#2
 832  0146 2705          	jreq	L314
 834  0148 ce0002        	ldw	x,_I2CTimeOut
 835  014b 26f4          	jrne	L704
 836  014d               L314:
 837                     ; 230 	I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
 839  014d 72175211      	bres	21009,#3
 840                     ; 231 	if(!tout())
 842  0151 ce0002        	ldw	x,_I2CTimeOut
 843  0154 2604          	jrne	L514
 844                     ; 233 		return IIC_ERROR_TIME_OUT;
 846  0156 a601          	ld	a,#1
 848  0158 2001          	jra	L42
 849  015a               L514:
 850                     ; 237 		return IIC_SUCCESS;
 852  015a 4f            	clr	a
 854  015b               L42:
 856  015b 85            	popw	x
 857  015c 81            	ret
 939                     ; 241 uint8_t I2C_WriteReadBytes(uint16_t SlaveAddr, uint8_t *pWriteDataBuffer, uint8_t NumByteToWrite,uint8_t *pReadDataBuffer, uint8_t NumByteToRead, uint8_t TimeOutOfMs)
 939                     ; 242 {
 940                     .text:	section	.text,new
 941  0000               _I2C_WriteReadBytes:
 943  0000 89            	pushw	x
 944       00000000      OFST:	set	0
 947                     ; 243 	set_tout_ms(TimeOutOfMs);
 949  0001 7b0b          	ld	a,(OFST+11,sp)
 950  0003 5f            	clrw	x
 951  0004 97            	ld	xl,a
 952  0005 cf0002        	ldw	_I2CTimeOut,x
 955  0008 2010          	jra	L554
 956  000a               L354:
 957                     ; 247 		I2C->CR2 |= I2C_CR2_STOP;                   				// Generate stop here (STOP=1)
 959  000a 72125211      	bset	21009,#1
 961  000e               L364:
 962                     ; 248 		while(I2C->CR2 & I2C_CR2_STOP  &&  tout()); 				// Wait until stop is performed
 964  000e c65211        	ld	a,21009
 965  0011 a502          	bcp	a,#2
 966  0013 2705          	jreq	L554
 968  0015 ce0002        	ldw	x,_I2CTimeOut
 969  0018 26f4          	jrne	L364
 970  001a               L554:
 971                     ; 245 	while(I2C->SR3 & I2C_SR3_BUSY  &&  tout())	  				// Wait while the bus is busy
 973  001a c65219        	ld	a,21017
 974  001d a502          	bcp	a,#2
 975  001f 2705          	jreq	L174
 977  0021 ce0002        	ldw	x,_I2CTimeOut
 978  0024 26e4          	jrne	L354
 979  0026               L174:
 980                     ; 250 	if(!tout())
 982  0026 ce0002        	ldw	x,_I2CTimeOut
 983  0029 2604          	jrne	L374
 984                     ; 252 		return IIC_ERROR_BUSY;
 986  002b a602          	ld	a,#2
 988  002d 2036          	jra	L03
 989  002f               L374:
 990                     ; 254 	I2C->CR2 &= ~I2C_CR2_STOP;
 992  002f 72135211      	bres	21009,#1
 993                     ; 255 	I2C->CR2 |= I2C_CR2_ACK;                      				// ACK=1, Ack enable
 995  0033 72145211      	bset	21009,#2
 996                     ; 257 	I2C->CR2 |= I2C_CR2_START;                    				// START=1, generate start
 998  0037 72105211      	bset	21009,#0
1000  003b               L774:
1001                     ; 258 	while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout());				// Wait for start bit detection (SB)
1003  003b c65217        	ld	a,21015
1004  003e a501          	bcp	a,#1
1005  0040 2605          	jrne	L305
1007  0042 ce0002        	ldw	x,_I2CTimeOut
1008  0045 26f4          	jrne	L774
1009  0047               L305:
1010                     ; 260 	if(tout())
1012  0047 ce0002        	ldw	x,_I2CTimeOut
1013  004a 2706          	jreq	L115
1014                     ; 270 		I2C->DR = (u8)(SlaveAddr << 1);   						// Send 7-bit device address & Write (R/W = 0)
1016  004c 7b02          	ld	a,(OFST+2,sp)
1017  004e 48            	sll	a
1018  004f c75216        	ld	21014,a
1019  0052               L115:
1020                     ; 273 	while(!(I2C->SR1 & I2C_SR1_ADDR) &&  tout()); 				// test EV6 - wait for address ack (ADDR)
1022  0052 c65217        	ld	a,21015
1023  0055 a502          	bcp	a,#2
1024  0057 2605          	jrne	L515
1026  0059 ce0002        	ldw	x,_I2CTimeOut
1027  005c 26f4          	jrne	L115
1028  005e               L515:
1029                     ; 274 	if(!tout())
1031  005e ce0002        	ldw	x,_I2CTimeOut
1032  0061 2604          	jrne	L715
1033                     ; 276 		return IIC_ERROR_NOT_ACK;
1035  0063 a603          	ld	a,#3
1037  0065               L03:
1039  0065 85            	popw	x
1040  0066 81            	ret
1041  0067               L715:
1042                     ; 279 	I2C->SR3;
1045  0067 c65219        	ld	a,21017
1046  006a 97            	ld	xl,a
1047                     ; 281 	if(NumByteToWrite > 0)
1049  006b 0d07          	tnz	(OFST+7,sp)
1050  006d 2736          	jreq	L125
1052  006f 201f          	jra	L525
1053  0071               L335:
1054                     ; 285 			while(!(I2C->SR1 & I2C_SR1_TXE) &&  tout());  				// Wait for TxE
1056  0071 c65217        	ld	a,21015
1057  0074 a580          	bcp	a,#128
1058  0076 2605          	jrne	L735
1060  0078 ce0002        	ldw	x,_I2CTimeOut
1061  007b 26f4          	jrne	L335
1062  007d               L735:
1063                     ; 286 			if(tout())
1065  007d ce0002        	ldw	x,_I2CTimeOut
1066  0080 270e          	jreq	L525
1067                     ; 288 				I2C->DR = *pWriteDataBuffer++;                         			// Send register address
1069  0082 1e05          	ldw	x,(OFST+5,sp)
1070  0084 1c0001        	addw	x,#1
1071  0087 1f05          	ldw	(OFST+5,sp),x
1072  0089 1d0001        	subw	x,#1
1073  008c f6            	ld	a,(x)
1074  008d c75216        	ld	21014,a
1075  0090               L525:
1076                     ; 283 		while(NumByteToWrite--)
1078  0090 7b07          	ld	a,(OFST+7,sp)
1079  0092 0a07          	dec	(OFST+7,sp)
1080  0094 4d            	tnz	a
1081  0095 26da          	jrne	L335
1083  0097               L545:
1084                     ; 291 		while((I2C->SR1 & (I2C_SR1_TXE | I2C_SR1_BTF)) != (I2C_SR1_TXE | I2C_SR1_BTF)  &&  tout());
1086  0097 c65217        	ld	a,21015
1087  009a a484          	and	a,#132
1088  009c a184          	cp	a,#132
1089  009e 2705          	jreq	L125
1091  00a0 ce0002        	ldw	x,_I2CTimeOut
1092  00a3 26f2          	jrne	L545
1093  00a5               L125:
1094                     ; 302 	I2C->CR2 &= ~I2C_CR2_STOP;
1096  00a5 72135211      	bres	21009,#1
1097                     ; 303 	I2C->CR2 |= I2C_CR2_START;                     				// START=1, generate re-start
1099  00a9 72105211      	bset	21009,#0
1101  00ad               L555:
1102                     ; 304 	while((I2C->SR1 & I2C_SR1_SB)==0  &&  tout()); 				// Wait for start bit detection (SB)
1104  00ad c65217        	ld	a,21015
1105  00b0 a501          	bcp	a,#1
1106  00b2 2605          	jrne	L165
1108  00b4 ce0002        	ldw	x,_I2CTimeOut
1109  00b7 26f4          	jrne	L555
1110  00b9               L165:
1111                     ; 306 	if(tout())
1113  00b9 ce0002        	ldw	x,_I2CTimeOut
1114  00bc 2708          	jreq	L765
1115                     ; 318 		I2C->DR = (u8)(SlaveAddr << 1) | 1;         	// Send 7-bit device address & Write (R/W = 1)
1117  00be 7b02          	ld	a,(OFST+2,sp)
1118  00c0 48            	sll	a
1119  00c1 aa01          	or	a,#1
1120  00c3 c75216        	ld	21014,a
1121  00c6               L765:
1122                     ; 321 	while(!(I2C->SR1 & I2C_SR1_ADDR)  &&  tout());  			// Wait for address ack (ADDR)
1124  00c6 c65217        	ld	a,21015
1125  00c9 a502          	bcp	a,#2
1126  00cb 2605          	jrne	L375
1128  00cd ce0002        	ldw	x,_I2CTimeOut
1129  00d0 26f4          	jrne	L765
1130  00d2               L375:
1131                     ; 322 	if(!tout())
1133  00d2 ce0002        	ldw	x,_I2CTimeOut
1134  00d5 2604          	jrne	L575
1135                     ; 324 		return IIC_ERROR_NOT_ACK;
1137  00d7 a603          	ld	a,#3
1139  00d9 208a          	jra	L03
1140  00db               L575:
1141                     ; 327 	if (NumByteToRead > 2)                 						// *** more than 2 bytes are received? ***
1143  00db 7b0a          	ld	a,(OFST+10,sp)
1144  00dd a103          	cp	a,#3
1145  00df 257b          	jrult	L775
1146                     ; 329 		I2C->SR3;                                     			// ADDR clearing sequence
1148  00e1 c65219        	ld	a,21017
1149  00e4 97            	ld	xl,a
1151  00e5 201c          	jra	L306
1152  00e7               L116:
1153                     ; 332 			while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 				// Wait for BTF
1155  00e7 c65217        	ld	a,21015
1156  00ea a504          	bcp	a,#4
1157  00ec 2605          	jrne	L516
1159  00ee ce0002        	ldw	x,_I2CTimeOut
1160  00f1 26f4          	jrne	L116
1161  00f3               L516:
1162                     ; 333 			*pReadDataBuffer++ = I2C->DR;                   				// Reading next data byte
1164  00f3 1e08          	ldw	x,(OFST+8,sp)
1165  00f5 1c0001        	addw	x,#1
1166  00f8 1f08          	ldw	(OFST+8,sp),x
1167  00fa 1d0001        	subw	x,#1
1168  00fd c65216        	ld	a,21014
1169  0100 f7            	ld	(x),a
1170                     ; 334 			--NumByteToRead;																		// Decrease Numbyte to reade by 1
1172  0101 0a0a          	dec	(OFST+10,sp)
1173  0103               L306:
1174                     ; 330 		while(NumByteToRead > 3  &&  tout())       			// not last three bytes?
1176  0103 7b0a          	ld	a,(OFST+10,sp)
1177  0105 a104          	cp	a,#4
1178  0107 2505          	jrult	L326
1180  0109 ce0002        	ldw	x,_I2CTimeOut
1181  010c 26d9          	jrne	L116
1182  010e               L326:
1183                     ; 337 		while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 			// Wait for BTF
1185  010e c65217        	ld	a,21015
1186  0111 a504          	bcp	a,#4
1187  0113 2605          	jrne	L726
1189  0115 ce0002        	ldw	x,_I2CTimeOut
1190  0118 26f4          	jrne	L326
1191  011a               L726:
1192                     ; 338 		I2C->CR2 &=~I2C_CR2_ACK;                      			// Clear ACK
1194  011a 72155211      	bres	21009,#2
1195                     ; 339 		disableInterrupts();                          			// Errata workaround (Disable interrupt)
1198  011e 9b            sim
1200                     ; 340 		*pReadDataBuffer++ = I2C->DR;                     		// Read 1st byte
1203  011f 1e08          	ldw	x,(OFST+8,sp)
1204  0121 1c0001        	addw	x,#1
1205  0124 1f08          	ldw	(OFST+8,sp),x
1206  0126 1d0001        	subw	x,#1
1207  0129 c65216        	ld	a,21014
1208  012c f7            	ld	(x),a
1209                     ; 341 		I2C->CR2 |= I2C_CR2_STOP;                       		// Generate stop here (STOP=1)
1211  012d 72125211      	bset	21009,#1
1212                     ; 342 		*pReadDataBuffer++ = I2C->DR;                     		// Read 2nd byte
1214  0131 1e08          	ldw	x,(OFST+8,sp)
1215  0133 1c0001        	addw	x,#1
1216  0136 1f08          	ldw	(OFST+8,sp),x
1217  0138 1d0001        	subw	x,#1
1218  013b c65216        	ld	a,21014
1219  013e f7            	ld	(x),a
1220                     ; 343 		enableInterrupts();																	// Errata workaround (Enable interrupt)
1223  013f 9a            rim
1227  0140               L336:
1228                     ; 344 		while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout());			// Wait for RXNE
1230  0140 c65217        	ld	a,21015
1231  0143 a540          	bcp	a,#64
1232  0145 2605          	jrne	L736
1234  0147 ce0002        	ldw	x,_I2CTimeOut
1235  014a 26f4          	jrne	L336
1236  014c               L736:
1237                     ; 345 		*pReadDataBuffer++ = I2C->DR;                   			// Read 3rd Data byte
1239  014c 1e08          	ldw	x,(OFST+8,sp)
1240  014e 1c0001        	addw	x,#1
1241  0151 1f08          	ldw	(OFST+8,sp),x
1242  0153 1d0001        	subw	x,#1
1243  0156 c65216        	ld	a,21014
1244  0159 f7            	ld	(x),a
1246  015a 205c          	jra	L176
1247  015c               L775:
1248                     ; 349 		if(NumByteToRead == 2)                						// *** just two bytes are received? ***
1250  015c 7b0a          	ld	a,(OFST+10,sp)
1251  015e a102          	cp	a,#2
1252  0160 2636          	jrne	L346
1253                     ; 351 			I2C->CR2 |= I2C_CR2_POS;                      		// Set POS bit (NACK at next received byte)
1255  0162 72165211      	bset	21009,#3
1256                     ; 352 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
1259  0166 9b            sim
1261                     ; 353 			I2C->SR3;                                       	// Clear ADDR Flag
1264  0167 c65219        	ld	a,21017
1265  016a 97            	ld	xl,a
1266                     ; 354 			I2C->CR2 &=~I2C_CR2_ACK;                        	// Clear ACK
1268  016b 72155211      	bres	21009,#2
1269                     ; 355 			enableInterrupts();																// Errata workaround (Enable interrupt)
1272  016f 9a            rim
1276  0170               L746:
1277                     ; 356 			while(!(I2C->SR1 & I2C_SR1_BTF)  &&  tout()); 		// Wait for BTF
1279  0170 c65217        	ld	a,21015
1280  0173 a504          	bcp	a,#4
1281  0175 2605          	jrne	L356
1283  0177 ce0002        	ldw	x,_I2CTimeOut
1284  017a 26f4          	jrne	L746
1285  017c               L356:
1286                     ; 357 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
1289  017c 9b            sim
1291                     ; 358 			I2C->CR2 |= I2C_CR2_STOP;                       	// Generate stop here (STOP=1)
1294  017d 72125211      	bset	21009,#1
1295                     ; 359 			*pReadDataBuffer++ = I2C->DR;                     	// Read 1st Data byte
1297  0181 1e08          	ldw	x,(OFST+8,sp)
1298  0183 1c0001        	addw	x,#1
1299  0186 1f08          	ldw	(OFST+8,sp),x
1300  0188 1d0001        	subw	x,#1
1301  018b c65216        	ld	a,21014
1302  018e f7            	ld	(x),a
1303                     ; 360 			enableInterrupts();																// Errata workaround (Enable interrupt)
1306  018f 9a            rim
1308                     ; 361 			*pReadDataBuffer = I2C->DR;													// Read 2nd Data byte
1311  0190 1e08          	ldw	x,(OFST+8,sp)
1312  0192 c65216        	ld	a,21014
1313  0195 f7            	ld	(x),a
1315  0196 2020          	jra	L176
1316  0198               L346:
1317                     ; 365 			I2C->CR2 &=~I2C_CR2_ACK;;                     		// Clear ACK
1319  0198 72155211      	bres	21009,#2
1320                     ; 366 			disableInterrupts();                          		// Errata workaround (Disable interrupt)
1324  019c 9b            sim
1326                     ; 367 			I2C->SR3;                                       	// Clear ADDR Flag
1329  019d c65219        	ld	a,21017
1330  01a0 97            	ld	xl,a
1331                     ; 368 			I2C->CR2 |= I2C_CR2_STOP;                       	// generate stop here (STOP=1)
1333  01a1 72125211      	bset	21009,#1
1334                     ; 369 			enableInterrupts();																// Errata workaround (Enable interrupt)
1337  01a5 9a            rim
1341  01a6               L166:
1342                     ; 370 			while(!(I2C->SR1 & I2C_SR1_RXNE)  &&  tout()); 		// test EV7, wait for RxNE
1344  01a6 c65217        	ld	a,21015
1345  01a9 a540          	bcp	a,#64
1346  01ab 2605          	jrne	L566
1348  01ad ce0002        	ldw	x,_I2CTimeOut
1349  01b0 26f4          	jrne	L166
1350  01b2               L566:
1351                     ; 371 			*pReadDataBuffer = I2C->DR;                     		// Read Data byte
1353  01b2 1e08          	ldw	x,(OFST+8,sp)
1354  01b4 c65216        	ld	a,21014
1355  01b7 f7            	ld	(x),a
1356  01b8               L176:
1357                     ; 375 	while((I2C->CR2 & I2C_CR2_STOP)  &&  tout());     		// Wait until stop is performed (STOPF = 1)
1359  01b8 c65211        	ld	a,21009
1360  01bb a502          	bcp	a,#2
1361  01bd 2705          	jreq	L576
1363  01bf ce0002        	ldw	x,_I2CTimeOut
1364  01c2 26f4          	jrne	L176
1365  01c4               L576:
1366                     ; 376 	I2C->CR2 &=~I2C_CR2_POS;                          		// return POS to default state (POS=0)
1368  01c4 72175211      	bres	21009,#3
1369                     ; 377 	return IIC_SUCCESS;
1371  01c8 4f            	clr	a
1374  01c9 85            	popw	x
1375  01ca 81            	ret
1399                     ; 387 void ErrProc(void)
1399                     ; 388 {
1400                     .text:	section	.text,new
1401  0000               _ErrProc:
1405                     ; 390 	I2C->SR2= 0;
1407  0000 725f5218      	clr	21016
1408                     ; 392 	I2C->CR2 |= 2;
1410  0004 72125211      	bset	21009,#1
1411                     ; 394 	I2CTimeOut = 0;
1413  0008 5f            	clrw	x
1414  0009 cf0002        	ldw	_I2CTimeOut,x
1415                     ; 395 }
1418  000c 81            	ret
1442                     ; 406 void My_TIM3_Init (void)
1442                     ; 407 {
1443                     .text:	section	.text,new
1444  0000               _My_TIM3_Init:
1448                     ; 408 	TIM3->ARRH = 0;
1450  0000 725f532b      	clr	21291
1451                     ; 409 	TIM3->ARRL = 0x80;                // init timer 4 1ms inetrrupts
1453  0004 3580532c      	mov	21292,#128
1454                     ; 410 	TIM3->PSCR= 7;
1456  0008 3507532a      	mov	21290,#7
1457                     ; 411 	TIM3->IER = 1;
1459  000c 35015321      	mov	21281,#1
1460                     ; 412 	TIM3->CR1 |= 1;
1462  0010 72105320      	bset	21280,#0
1463                     ; 413 	I2CTimeOut = 0;
1465  0014 5f            	clrw	x
1466  0015 cf0002        	ldw	_I2CTimeOut,x
1467                     ; 415 }
1470  0018 81            	ret
1495                     ; 425 @far @interrupt void I2C_error_Interrupt_Handler (void)
1495                     ; 426 {
1497                     .text:	section	.text,new
1498  0000               f_I2C_error_Interrupt_Handler:
1501  0000 3b0002        	push	c_x+2
1502  0003 be00          	ldw	x,c_x
1503  0005 89            	pushw	x
1504  0006 3b0002        	push	c_y+2
1505  0009 be00          	ldw	x,c_y
1506  000b 89            	pushw	x
1509                     ; 431 	ErrProc();
1511  000c cd0000        	call	_ErrProc
1513                     ; 432 }
1516  000f 85            	popw	x
1517  0010 bf00          	ldw	c_y,x
1518  0012 320002        	pop	c_y+2
1519  0015 85            	popw	x
1520  0016 bf00          	ldw	c_x,x
1521  0018 320002        	pop	c_x+2
1522  001b 80            	iret
1547                     ; 442 @far @interrupt void TIM3InterruptHandle (void)
1547                     ; 443 {
1548                     .text:	section	.text,new
1549  0000               f_TIM3InterruptHandle:
1554                     ; 449 	TIM3->SR1= 0;
1556  0000 725f5322      	clr	21282
1557                     ; 451 	if(I2CTimeOut){
1559  0004 ce0002        	ldw	x,_I2CTimeOut
1560  0007 2709          	jreq	L737
1561                     ; 452 		I2CTimeOut--;
1563  0009 ce0002        	ldw	x,_I2CTimeOut
1564  000c 1d0001        	subw	x,#1
1565  000f cf0002        	ldw	_I2CTimeOut,x
1566  0012               L737:
1567                     ; 455 	if(GestureTimeOut){
1569  0012 ce0000        	ldw	x,_GestureTimeOut
1570  0015 2709          	jreq	L147
1571                     ; 456 		GestureTimeOut--;
1573  0017 ce0000        	ldw	x,_GestureTimeOut
1574  001a 1d0001        	subw	x,#1
1575  001d cf0000        	ldw	_GestureTimeOut,x
1576  0020               L147:
1577                     ; 462 }
1580  0020 80            	iret
1612                     	xdef	f_TIM3InterruptHandle
1613                     	xdef	f_I2C_error_Interrupt_Handler
1614                     	xdef	_I2CTimeOut
1615                     	xdef	_GestureTimeOut
1616                     	xdef	_ErrProc
1617                     	xdef	_I2C_WriteReadBytes
1618                     	xdef	_I2C_ReadBytes
1619                     	xdef	_I2C_WriteBytes
1620                     	xdef	_I2C_Config
1621                     	xdef	_My_TIM3_Init
1622                     	xref	_I2C_SoftwareResetCmd
1623                     	xref	_I2C_Cmd
1624                     	xref	_I2C_Init
1625                     	xref	_I2C_DeInit
1626                     	xref	_CLK_GetClockFreq
1627                     	xref	_CLK_PeripheralClockConfig
1628                     	xref.b	c_lreg
1629                     	xref.b	c_x
1630                     	xref.b	c_y
1649                     	xref	c_ludv
1650                     	end
