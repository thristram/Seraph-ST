   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  64                     ; 63 void FLASH_Unlock(FLASH_MemType_TypeDef MemType)
  64                     ; 64 {
  66                     .text:	section	.text,new
  67  0000               _FLASH_Unlock:
  71                     ; 66     assert_param(IS_MEMORY_TYPE_OK(MemType));
  73                     ; 69     if (MemType == FLASH_MEMTYPE_PROG)
  75  0000 4d            	tnz	a
  76  0001 260a          	jrne	L73
  77                     ; 71         FLASH->PUKR = FLASH_RASS_KEY1;
  79  0003 35565062      	mov	20578,#86
  80                     ; 72         FLASH->PUKR = FLASH_RASS_KEY2;
  82  0007 35ae5062      	mov	20578,#174
  84  000b 2008          	jra	L14
  85  000d               L73:
  86                     ; 78         FLASH->DUKR = FLASH_RASS_KEY2; /* Warning: keys are reversed on data memory !!! */
  88  000d 35ae5064      	mov	20580,#174
  89                     ; 79         FLASH->DUKR = FLASH_RASS_KEY1;
  91  0011 35565064      	mov	20580,#86
  92  0015               L14:
  93                     ; 82 }
  96  0015 81            	ret
 131                     ; 98 void FLASH_Lock(FLASH_MemType_TypeDef MemType)
 131                     ; 99 {
 132                     .text:	section	.text,new
 133  0000               _FLASH_Lock:
 137                     ; 101     assert_param(IS_MEMORY_TYPE_OK(MemType));
 139                     ; 104     if (MemType == FLASH_MEMTYPE_PROG)
 141  0000 4d            	tnz	a
 142  0001 2606          	jrne	L16
 143                     ; 106         FLASH->IAPSR = (u8)(~FLASH_IAPSR_PUL);
 145  0003 35fd505f      	mov	20575,#253
 147  0007 2004          	jra	L36
 148  0009               L16:
 149                     ; 112         FLASH->IAPSR = (u8)(~FLASH_IAPSR_DUL);
 151  0009 35f7505f      	mov	20575,#247
 152  000d               L36:
 153                     ; 114 }
 156  000d 81            	ret
 188                     ; 130 void FLASH_DeInit(void)
 188                     ; 131 {
 189                     .text:	section	.text,new
 190  0000               _FLASH_DeInit:
 192  0000 88            	push	a
 193       00000001      OFST:	set	1
 196                     ; 132     u8 temp = 0;
 198  0001 0f01          	clr	(OFST+0,sp)
 199                     ; 133     FLASH->CR1 = FLASH_CR1_RESET_VALUE;
 201  0003 725f505a      	clr	20570
 202                     ; 134     FLASH->CR2 = FLASH_CR2_RESET_VALUE;
 204  0007 725f505b      	clr	20571
 205                     ; 135     FLASH->NCR2 = FLASH_NCR2_RESET_VALUE;
 207  000b 35ff505c      	mov	20572,#255
 208                     ; 136     FLASH->IAPSR &= (u8)(~FLASH_IAPSR_DUL);
 210  000f 7217505f      	bres	20575,#3
 211                     ; 137     FLASH->IAPSR &= (u8)(~FLASH_IAPSR_PUL);
 213  0013 7213505f      	bres	20575,#1
 214                     ; 138     temp = FLASH->IAPSR; /* Reading of this register causes the clearing of status flags */
 216  0017 c6505f        	ld	a,20575
 217  001a 6b01          	ld	(OFST+0,sp),a
 218                     ; 139 }
 221  001c 84            	pop	a
 222  001d 81            	ret
 277                     ; 154 void FLASH_ITConfig(FunctionalState NewState)
 277                     ; 155 {
 278                     .text:	section	.text,new
 279  0000               _FLASH_ITConfig:
 283                     ; 156     if (NewState != DISABLE)
 285  0000 4d            	tnz	a
 286  0001 2706          	jreq	L721
 287                     ; 158         FLASH->CR1 |= FLASH_CR1_IE; /* Enables the interrupt sources */
 289  0003 7212505a      	bset	20570,#1
 291  0007 2004          	jra	L131
 292  0009               L721:
 293                     ; 162         FLASH->CR1 &= (u8)(~FLASH_CR1_IE); /* Disables the interrupt sources */
 295  0009 7213505a      	bres	20570,#1
 296  000d               L131:
 297                     ; 164 }
 300  000d 81            	ret
 349                     ; 184 void FLASH_EraseBlock(u16 BlockNum, FLASH_MemType_TypeDef MemType)
 349                     ; 185 {
 350                     .text:	section	.text,new
 351  0000               _FLASH_EraseBlock:
 353  0000 89            	pushw	x
 354  0001 5204          	subw	sp,#4
 355       00000004      OFST:	set	4
 358                     ; 186     u32 StartAddress = 0;
 360  0003 ae0000        	ldw	x,#0
 361  0006 1f03          	ldw	(OFST-1,sp),x
 362  0008 ae0000        	ldw	x,#0
 363  000b 1f01          	ldw	(OFST-3,sp),x
 364                     ; 189     assert_param(IS_MEMORY_TYPE_OK(MemType));
 366                     ; 190     if (MemType == FLASH_MEMTYPE_PROG)
 368  000d 0d09          	tnz	(OFST+5,sp)
 369  000f 260c          	jrne	L551
 370                     ; 192         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
 372                     ; 193         StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
 374  0011 ae8000        	ldw	x,#32768
 375  0014 1f03          	ldw	(OFST-1,sp),x
 376  0016 ae0000        	ldw	x,#0
 377  0019 1f01          	ldw	(OFST-3,sp),x
 379  001b 200a          	jra	L751
 380  001d               L551:
 381                     ; 197         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
 383                     ; 198         StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
 385  001d ae4000        	ldw	x,#16384
 386  0020 1f03          	ldw	(OFST-1,sp),x
 387  0022 ae0000        	ldw	x,#0
 388  0025 1f01          	ldw	(OFST-3,sp),x
 389  0027               L751:
 390                     ; 202     StartAddress = StartAddress + ((u32)BlockNum * FLASH_BLOCK_SIZE);
 392  0027 1e05          	ldw	x,(OFST+1,sp)
 393  0029 a680          	ld	a,#128
 394  002b cd0000        	call	c_cmulx
 396  002e 96            	ldw	x,sp
 397  002f 1c0001        	addw	x,#OFST-3
 398  0032 cd0000        	call	c_lgadd
 400                     ; 205     FLASH->CR2 |= FLASH_CR2_ERASE;
 402  0035 721a505b      	bset	20571,#5
 403                     ; 206     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NERASE);
 405  0039 721b505c      	bres	20572,#5
 406                     ; 209     *((@far u8*) StartAddress) = FLASH_CLEAR_BYTE;
 408  003d 7b02          	ld	a,(OFST-2,sp)
 409  003f b700          	ld	c_x,a
 410  0041 1e03          	ldw	x,(OFST-1,sp)
 411  0043 bf01          	ldw	c_x+1,x
 412  0045 4f            	clr	a
 413  0046 92bd0000      	ldf	[c_x.e],a
 414                     ; 210     *((@far u8*) StartAddress + 1) = FLASH_CLEAR_BYTE;
 417  004a 7b02          	ld	a,(OFST-2,sp)
 418  004c b700          	ld	c_x,a
 419  004e 1e03          	ldw	x,(OFST-1,sp)
 420  0050 90ae0001      	ldw	y,#1
 421  0054 bf01          	ldw	c_x+1,x
 422  0056 93            	ldw	x,y
 423  0057 4f            	clr	a
 424  0058 92a70000      	ldf	([c_x.e],x),a
 425                     ; 211     *((@far u8*) StartAddress + 2) = FLASH_CLEAR_BYTE;
 428  005c 7b02          	ld	a,(OFST-2,sp)
 429  005e b700          	ld	c_x,a
 430  0060 1e03          	ldw	x,(OFST-1,sp)
 431  0062 90ae0002      	ldw	y,#2
 432  0066 bf01          	ldw	c_x+1,x
 433  0068 93            	ldw	x,y
 434  0069 4f            	clr	a
 435  006a 92a70000      	ldf	([c_x.e],x),a
 436                     ; 212     *((@far u8*) StartAddress + 3) = FLASH_CLEAR_BYTE;
 439  006e 7b02          	ld	a,(OFST-2,sp)
 440  0070 b700          	ld	c_x,a
 441  0072 1e03          	ldw	x,(OFST-1,sp)
 442  0074 90ae0003      	ldw	y,#3
 443  0078 bf01          	ldw	c_x+1,x
 444  007a 93            	ldw	x,y
 445  007b 4f            	clr	a
 446  007c 92a70000      	ldf	([c_x.e],x),a
 447                     ; 219 }
 451  0080 5b06          	addw	sp,#6
 452  0082 81            	ret
 484                     ; 238 void FLASH_EraseByte(u32 Address)
 484                     ; 239 {
 485                     .text:	section	.text,new
 486  0000               _FLASH_EraseByte:
 488       00000000      OFST:	set	0
 491                     ; 241     assert_param(IS_FLASH_ADDRESS_OK(Address));
 493                     ; 244     *((@far u8*) Address) = FLASH_CLEAR_BYTE; /* Erase byte */
 495  0000 7b04          	ld	a,(OFST+4,sp)
 496  0002 b700          	ld	c_x,a
 497  0004 1e05          	ldw	x,(OFST+5,sp)
 498  0006 bf01          	ldw	c_x+1,x
 499  0008 4f            	clr	a
 500  0009 92bd0000      	ldf	[c_x.e],a
 501                     ; 248 }
 505  000d 81            	ret
 539                     ; 267 void FLASH_EraseOptionByte(u32 Address)
 539                     ; 268 {
 540                     .text:	section	.text,new
 541  0000               _FLASH_EraseOptionByte:
 543       00000000      OFST:	set	0
 546                     ; 270     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 548                     ; 273     FLASH->CR2 |= FLASH_CR2_OPT;
 550  0000 721e505b      	bset	20571,#7
 551                     ; 274     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
 553  0004 721f505c      	bres	20572,#7
 554                     ; 278     *((@far u8*)Address) = FLASH_CLEAR_BYTE;
 556  0008 7b04          	ld	a,(OFST+4,sp)
 557  000a b700          	ld	c_x,a
 558  000c 1e05          	ldw	x,(OFST+5,sp)
 559  000e bf01          	ldw	c_x+1,x
 560  0010 4f            	clr	a
 561  0011 92bd0000      	ldf	[c_x.e],a
 562                     ; 279     *((@far u8*)(Address + 1 )) = FLASH_SET_BYTE;
 565  0015 96            	ldw	x,sp
 566  0016 1c0003        	addw	x,#OFST+3
 567  0019 cd0000        	call	c_ltor
 569  001c a601          	ld	a,#1
 570  001e cd0000        	call	c_ladc
 572  0021 450100        	mov	c_x,c_lreg+1
 573  0024 be02          	ldw	x,c_lreg+2
 574  0026 bf01          	ldw	c_x+1,x
 575  0028 a6ff          	ld	a,#255
 576  002a 92bd0000      	ldf	[c_x.e],a
 577                     ; 285     FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 580  002e a601          	ld	a,#1
 581  0030 cd0000        	call	_FLASH_WaitForLastOperation
 583                     ; 288     FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
 585  0033 721f505b      	bres	20571,#7
 586                     ; 289     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 588  0037 721e505c      	bset	20572,#7
 589                     ; 290 }
 592  003b 81            	ret
 690                     ; 318 void FLASH_ProgramBlock(u16 BlockNum, FLASH_MemType_TypeDef MemType, FLASH_ProgramMode_TypeDef ProgMode, u8 *Buffer)
 690                     ; 319 {
 691                     .text:	section	.text,new
 692  0000               _FLASH_ProgramBlock:
 694  0000 89            	pushw	x
 695  0001 5206          	subw	sp,#6
 696       00000006      OFST:	set	6
 699                     ; 320     u16 Count = 0;
 701  0003 1e05          	ldw	x,(OFST-1,sp)
 702                     ; 321     u32 StartAddress = 0;
 704  0005 96            	ldw	x,sp
 705  0006 1c0001        	addw	x,#OFST-5
 706  0009 cd0000        	call	c_ltor
 708                     ; 324     assert_param(IS_MEMORY_TYPE_OK(MemType));
 710                     ; 325     assert_param(IS_FLASH_PROGRAM_MODE_OK(ProgMode));
 712                     ; 326     if (MemType == FLASH_MEMTYPE_PROG)
 714  000c 0d0b          	tnz	(OFST+5,sp)
 715  000e 260c          	jrne	L552
 716                     ; 328         assert_param(IS_FLASH_PROG_BLOCK_NUMBER_OK(BlockNum));
 718                     ; 329         StartAddress = FLASH_PROG_START_PHYSICAL_ADDRESS;
 720  0010 ae8000        	ldw	x,#32768
 721  0013 1f03          	ldw	(OFST-3,sp),x
 722  0015 ae0000        	ldw	x,#0
 723  0018 1f01          	ldw	(OFST-5,sp),x
 725  001a 200a          	jra	L752
 726  001c               L552:
 727                     ; 333         assert_param(IS_FLASH_DATA_BLOCK_NUMBER_OK(BlockNum));
 729                     ; 334         StartAddress = FLASH_DATA_START_PHYSICAL_ADDRESS;
 731  001c ae4000        	ldw	x,#16384
 732  001f 1f03          	ldw	(OFST-3,sp),x
 733  0021 ae0000        	ldw	x,#0
 734  0024 1f01          	ldw	(OFST-5,sp),x
 735  0026               L752:
 736                     ; 338     StartAddress = StartAddress + ((u32)BlockNum * FLASH_BLOCK_SIZE);
 738  0026 1e07          	ldw	x,(OFST+1,sp)
 739  0028 a680          	ld	a,#128
 740  002a cd0000        	call	c_cmulx
 742  002d 96            	ldw	x,sp
 743  002e 1c0001        	addw	x,#OFST-5
 744  0031 cd0000        	call	c_lgadd
 746                     ; 341     if (ProgMode == FLASH_PROGRAMMODE_STANDARD)
 748  0034 0d0c          	tnz	(OFST+6,sp)
 749  0036 260a          	jrne	L162
 750                     ; 344         FLASH->CR2 |= FLASH_CR2_PRG;
 752  0038 7210505b      	bset	20571,#0
 753                     ; 345         FLASH->NCR2 &= (u8)(~FLASH_NCR2_NPRG);
 755  003c 7211505c      	bres	20572,#0
 757  0040 2008          	jra	L362
 758  0042               L162:
 759                     ; 350         FLASH->CR2 |= FLASH_CR2_FPRG;
 761  0042 7218505b      	bset	20571,#4
 762                     ; 351         FLASH->NCR2 &= (u8)(~FLASH_NCR2_NFPRG);
 764  0046 7219505c      	bres	20572,#4
 765  004a               L362:
 766                     ; 355     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
 768  004a 5f            	clrw	x
 769  004b 1f05          	ldw	(OFST-1,sp),x
 770  004d               L562:
 771                     ; 357         *((u8*)StartAddress + Count) = ((u8)(Buffer[Count]));
 773  004d 1e0d          	ldw	x,(OFST+7,sp)
 774  004f 72fb05        	addw	x,(OFST-1,sp)
 775  0052 f6            	ld	a,(x)
 776  0053 1e03          	ldw	x,(OFST-3,sp)
 777  0055 72fb05        	addw	x,(OFST-1,sp)
 778  0058 f7            	ld	(x),a
 779                     ; 355     for (Count = 0; Count < FLASH_BLOCK_SIZE; Count++)
 781  0059 1e05          	ldw	x,(OFST-1,sp)
 782  005b 1c0001        	addw	x,#1
 783  005e 1f05          	ldw	(OFST-1,sp),x
 786  0060 1e05          	ldw	x,(OFST-1,sp)
 787  0062 a30080        	cpw	x,#128
 788  0065 25e6          	jrult	L562
 789                     ; 359 }
 792  0067 5b08          	addw	sp,#8
 793  0069 81            	ret
 832                     ; 381 void FLASH_ProgramByte(u32 Address, u8 Data)
 832                     ; 382 {
 833                     .text:	section	.text,new
 834  0000               _FLASH_ProgramByte:
 836       00000000      OFST:	set	0
 839                     ; 384     assert_param(IS_FLASH_ADDRESS_OK(Address));
 841                     ; 387     *((@far u8*) Address) = Data;
 843  0000 7b07          	ld	a,(OFST+7,sp)
 844  0002 88            	push	a
 845  0003 7b05          	ld	a,(OFST+5,sp)
 846  0005 b700          	ld	c_x,a
 847  0007 1e06          	ldw	x,(OFST+6,sp)
 848  0009 84            	pop	a
 849  000a bf01          	ldw	c_x+1,x
 850  000c 92bd0000      	ldf	[c_x.e],a
 851                     ; 391 }
 854  0010 81            	ret
 895                     ; 411 void FLASH_ProgramOptionByte(u32 Address, u8 Data)
 895                     ; 412 {
 896                     .text:	section	.text,new
 897  0000               _FLASH_ProgramOptionByte:
 899       00000000      OFST:	set	0
 902                     ; 414     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
 904                     ; 417     FLASH->CR2 |= FLASH_CR2_OPT;
 906  0000 721e505b      	bset	20571,#7
 907                     ; 418     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NOPT);
 909  0004 721f505c      	bres	20572,#7
 910                     ; 422     *((@far u8*)Address) = Data;
 912  0008 7b07          	ld	a,(OFST+7,sp)
 913  000a 88            	push	a
 914  000b 7b05          	ld	a,(OFST+5,sp)
 915  000d b700          	ld	c_x,a
 916  000f 1e06          	ldw	x,(OFST+6,sp)
 917  0011 84            	pop	a
 918  0012 bf01          	ldw	c_x+1,x
 919  0014 92bd0000      	ldf	[c_x.e],a
 920                     ; 423     *((@far u8*)(Address + 1)) = (u8)(~Data);
 922  0018 96            	ldw	x,sp
 923  0019 1c0003        	addw	x,#OFST+3
 924  001c cd0000        	call	c_ltor
 926  001f a601          	ld	a,#1
 927  0021 cd0000        	call	c_ladc
 929  0024 450100        	mov	c_x,c_lreg+1
 930  0027 be02          	ldw	x,c_lreg+2
 931  0029 7b07          	ld	a,(OFST+7,sp)
 932  002b 43            	cpl	a
 933  002c bf01          	ldw	c_x+1,x
 934  002e 92bd0000      	ldf	[c_x.e],a
 935                     ; 429     FLASH_WaitForLastOperation(FLASH_MEMTYPE_DATA);
 937  0032 a601          	ld	a,#1
 938  0034 cd0000        	call	_FLASH_WaitForLastOperation
 940                     ; 432     FLASH->CR2 &= (u8)(~FLASH_CR2_OPT);
 942  0037 721f505b      	bres	20571,#7
 943                     ; 433     FLASH->NCR2 |= FLASH_NCR2_NOPT;
 945  003b 721e505c      	bset	20572,#7
 946                     ; 434 }
 949  003f 81            	ret
 988                     ; 456 void FLASH_ProgramWord(u32 Address, u32 Data)
 988                     ; 457 {
 989                     .text:	section	.text,new
 990  0000               _FLASH_ProgramWord:
 992       00000000      OFST:	set	0
 995                     ; 459     assert_param(IS_FLASH_ADDRESS_OK(Address));
 997                     ; 462     FLASH->CR2 |= FLASH_CR2_WPRG;
 999  0000 721c505b      	bset	20571,#6
1000                     ; 463     FLASH->NCR2 &= (u8)(~FLASH_NCR2_NWPRG);
1002  0004 721d505c      	bres	20572,#6
1003                     ; 466     *((@far u8*)Address) = BYTE_0(Data); /* Write one byte */
1005  0008 7b0a          	ld	a,(OFST+10,sp)
1006  000a a4ff          	and	a,#255
1007  000c 88            	push	a
1008  000d 7b05          	ld	a,(OFST+5,sp)
1009  000f b700          	ld	c_x,a
1010  0011 1e06          	ldw	x,(OFST+6,sp)
1011  0013 84            	pop	a
1012  0014 bf01          	ldw	c_x+1,x
1013  0016 92bd0000      	ldf	[c_x.e],a
1014                     ; 467     *(((@far u8*)Address) + 1) = BYTE_1(Data); /* Write one byte */
1016  001a 7b09          	ld	a,(OFST+9,sp)
1017  001c a4ff          	and	a,#255
1018  001e 88            	push	a
1019  001f 7b05          	ld	a,(OFST+5,sp)
1020  0021 b700          	ld	c_x,a
1021  0023 1e06          	ldw	x,(OFST+6,sp)
1022  0025 84            	pop	a
1023  0026 90ae0001      	ldw	y,#1
1024  002a bf01          	ldw	c_x+1,x
1025  002c 93            	ldw	x,y
1026  002d 92a70000      	ldf	([c_x.e],x),a
1027                     ; 468     *(((@far u8*)Address) + 2) = BYTE_2(Data); /* Write one byte */
1029  0031 7b08          	ld	a,(OFST+8,sp)
1030  0033 a4ff          	and	a,#255
1031  0035 88            	push	a
1032  0036 7b05          	ld	a,(OFST+5,sp)
1033  0038 b700          	ld	c_x,a
1034  003a 1e06          	ldw	x,(OFST+6,sp)
1035  003c 84            	pop	a
1036  003d 90ae0002      	ldw	y,#2
1037  0041 bf01          	ldw	c_x+1,x
1038  0043 93            	ldw	x,y
1039  0044 92a70000      	ldf	([c_x.e],x),a
1040                     ; 469     *(((@far u8*)Address) + 3) = BYTE_3(Data); /* Write one byte */
1042  0048 7b07          	ld	a,(OFST+7,sp)
1043  004a a4ff          	and	a,#255
1044  004c 88            	push	a
1045  004d 7b05          	ld	a,(OFST+5,sp)
1046  004f b700          	ld	c_x,a
1047  0051 1e06          	ldw	x,(OFST+6,sp)
1048  0053 84            	pop	a
1049  0054 90ae0003      	ldw	y,#3
1050  0058 bf01          	ldw	c_x+1,x
1051  005a 93            	ldw	x,y
1052  005b 92a70000      	ldf	([c_x.e],x),a
1053                     ; 476 }
1056  005f 81            	ret
1088                     ; 492 u8 FLASH_ReadByte(u32 Address)
1088                     ; 493 {
1089                     .text:	section	.text,new
1090  0000               _FLASH_ReadByte:
1092       00000000      OFST:	set	0
1095                     ; 495     assert_param(IS_FLASH_ADDRESS_OK(Address));
1097                     ; 498     return(*((@far u8*) Address)); /* Read byte */
1099  0000 7b04          	ld	a,(OFST+4,sp)
1100  0002 b700          	ld	c_x,a
1101  0004 1e05          	ldw	x,(OFST+5,sp)
1102  0006 bf01          	ldw	c_x+1,x
1103  0008 92bc0000      	ldf	a,[c_x.e]
1106  000c 81            	ret
1161                     ; 518 u16 FLASH_ReadOptionByte(u32 Address)
1161                     ; 519 {
1162                     .text:	section	.text,new
1163  0000               _FLASH_ReadOptionByte:
1165  0000 5204          	subw	sp,#4
1166       00000004      OFST:	set	4
1169                     ; 520     u8 value_optbyte, value_optbyte_complement = 0;
1171  0002 7b02          	ld	a,(OFST-2,sp)
1172  0004 97            	ld	xl,a
1173                     ; 521     u16 res_value = 0;
1175  0005 1e03          	ldw	x,(OFST-1,sp)
1176                     ; 524     assert_param(IS_OPTION_BYTE_ADDRESS_OK(Address));
1178                     ; 527     value_optbyte = *((@far u8*)Address); /* Read option byte */
1180  0007 7b08          	ld	a,(OFST+4,sp)
1181  0009 b700          	ld	c_x,a
1182  000b 1e09          	ldw	x,(OFST+5,sp)
1183  000d bf01          	ldw	c_x+1,x
1184  000f 92bc0000      	ldf	a,[c_x.e]
1185  0013 6b01          	ld	(OFST-3,sp),a
1186                     ; 528     value_optbyte_complement = *(((@far u8*)Address) + 1); /* Read option byte complement*/
1188  0015 7b08          	ld	a,(OFST+4,sp)
1189  0017 b700          	ld	c_x,a
1190  0019 1e09          	ldw	x,(OFST+5,sp)
1191  001b 90ae0001      	ldw	y,#1
1192  001f bf01          	ldw	c_x+1,x
1193  0021 93            	ldw	x,y
1194  0022 92af0000      	ldf	a,([c_x.e],x)
1195  0026 6b02          	ld	(OFST-2,sp),a
1196                     ; 534     if (value_optbyte == (u8)(~value_optbyte_complement))
1198  0028 7b02          	ld	a,(OFST-2,sp)
1199  002a 43            	cpl	a
1200  002b 1101          	cp	a,(OFST-3,sp)
1201  002d 2617          	jrne	L304
1202                     ; 536         res_value = (u16)((u16)value_optbyte << 8);
1204  002f 7b01          	ld	a,(OFST-3,sp)
1205  0031 5f            	clrw	x
1206  0032 97            	ld	xl,a
1207  0033 4f            	clr	a
1208  0034 02            	rlwa	x,a
1209  0035 1f03          	ldw	(OFST-1,sp),x
1210                     ; 537         res_value = res_value | (u16)value_optbyte_complement;
1212  0037 7b02          	ld	a,(OFST-2,sp)
1213  0039 5f            	clrw	x
1214  003a 97            	ld	xl,a
1215  003b 01            	rrwa	x,a
1216  003c 1a04          	or	a,(OFST+0,sp)
1217  003e 01            	rrwa	x,a
1218  003f 1a03          	or	a,(OFST-1,sp)
1219  0041 01            	rrwa	x,a
1220  0042 1f03          	ldw	(OFST-1,sp),x
1222  0044 2005          	jra	L504
1223  0046               L304:
1224                     ; 541         res_value = FLASH_OPTIONBYTE_ERROR;
1226  0046 ae5555        	ldw	x,#21845
1227  0049 1f03          	ldw	(OFST-1,sp),x
1228  004b               L504:
1229                     ; 544     return(res_value);
1231  004b 1e03          	ldw	x,(OFST-1,sp)
1234  004d 5b04          	addw	sp,#4
1235  004f 81            	ret
1309                     ; 561 void FLASH_SetLowPowerMode(FLASH_LPMode_TypeDef LPMode)
1309                     ; 562 {
1310                     .text:	section	.text,new
1311  0000               _FLASH_SetLowPowerMode:
1313  0000 88            	push	a
1314       00000000      OFST:	set	0
1317                     ; 564     assert_param(IS_FLASH_LOW_POWER_MODE_OK(LPMode));
1319                     ; 566     FLASH->CR1 &= (u8)(~(FLASH_CR1_HALT | FLASH_CR1_AHALT)); /* Clears the two bits */
1321  0001 c6505a        	ld	a,20570
1322  0004 a4f3          	and	a,#243
1323  0006 c7505a        	ld	20570,a
1324                     ; 567     FLASH->CR1 |= (u8)LPMode; /* Sets the new mode */
1326  0009 c6505a        	ld	a,20570
1327  000c 1a01          	or	a,(OFST+1,sp)
1328  000e c7505a        	ld	20570,a
1329                     ; 568 }
1332  0011 84            	pop	a
1333  0012 81            	ret
1391                     ; 584 void FLASH_SetProgrammingTime(FLASH_ProgramTime_TypeDef ProgTime)
1391                     ; 585 {
1392                     .text:	section	.text,new
1393  0000               _FLASH_SetProgrammingTime:
1397                     ; 587     assert_param(IS_FLASH_PROGRAM_TIME_OK(ProgTime));
1399                     ; 589     FLASH->CR1 &= (u8)(~FLASH_CR1_FIX);
1401  0000 7211505a      	bres	20570,#0
1402                     ; 590     FLASH->CR1 |= (u8)ProgTime;
1404  0004 ca505a        	or	a,20570
1405  0007 c7505a        	ld	20570,a
1406                     ; 591 }
1409  000a 81            	ret
1434                     ; 608 FLASH_LPMode_TypeDef FLASH_GetLowPowerMode(void)
1434                     ; 609 {
1435                     .text:	section	.text,new
1436  0000               _FLASH_GetLowPowerMode:
1440                     ; 610     return((FLASH_LPMode_TypeDef)(FLASH->CR1 & (FLASH_CR1_HALT | FLASH_CR1_AHALT)));
1442  0000 c6505a        	ld	a,20570
1443  0003 a40c          	and	a,#12
1446  0005 81            	ret
1471                     ; 628 FLASH_ProgramTime_TypeDef FLASH_GetProgrammingTime(void)
1471                     ; 629 {
1472                     .text:	section	.text,new
1473  0000               _FLASH_GetProgrammingTime:
1477                     ; 630     return((FLASH_ProgramTime_TypeDef)(FLASH->CR1 & FLASH_CR1_FIX));
1479  0000 c6505a        	ld	a,20570
1480  0003 a401          	and	a,#1
1483  0005 81            	ret
1515                     ; 648 u32 FLASH_GetBootSize(void)
1515                     ; 649 {
1516                     .text:	section	.text,new
1517  0000               _FLASH_GetBootSize:
1519  0000 5204          	subw	sp,#4
1520       00000004      OFST:	set	4
1523                     ; 650     u32 temp = 0;
1525  0002 ae0000        	ldw	x,#0
1526  0005 1f03          	ldw	(OFST-1,sp),x
1527  0007 ae0000        	ldw	x,#0
1528  000a 1f01          	ldw	(OFST-3,sp),x
1529                     ; 653     temp = (u32)((u32)FLASH->FPR * (u32)512);
1531  000c c6505d        	ld	a,20573
1532  000f 5f            	clrw	x
1533  0010 97            	ld	xl,a
1534  0011 90ae0200      	ldw	y,#512
1535  0015 cd0000        	call	c_umul
1537  0018 96            	ldw	x,sp
1538  0019 1c0001        	addw	x,#OFST-3
1539  001c cd0000        	call	c_rtol
1541                     ; 656     if (FLASH->FPR == 0xFF)
1543  001f c6505d        	ld	a,20573
1544  0022 a1ff          	cp	a,#255
1545  0024 2611          	jrne	L325
1546                     ; 658         temp += 512;
1548  0026 ae0200        	ldw	x,#512
1549  0029 bf02          	ldw	c_lreg+2,x
1550  002b ae0000        	ldw	x,#0
1551  002e bf00          	ldw	c_lreg,x
1552  0030 96            	ldw	x,sp
1553  0031 1c0001        	addw	x,#OFST-3
1554  0034 cd0000        	call	c_lgadd
1556  0037               L325:
1557                     ; 662     return(temp);
1559  0037 96            	ldw	x,sp
1560  0038 1c0001        	addw	x,#OFST-3
1561  003b cd0000        	call	c_ltor
1565  003e 5b04          	addw	sp,#4
1566  0040 81            	ret
1675                     ; 682 FlagStatus FLASH_GetFlagStatus(FLASH_Flag_TypeDef FLASH_FLAG)
1675                     ; 683 {
1676                     .text:	section	.text,new
1677  0000               _FLASH_GetFlagStatus:
1679  0000 88            	push	a
1680       00000001      OFST:	set	1
1683                     ; 684     FlagStatus status = RESET;
1685  0001 0f01          	clr	(OFST+0,sp)
1686                     ; 686     assert_param(IS_FLASH_FLAGS_OK(FLASH_FLAG));
1688                     ; 689     if ((FLASH->IAPSR & (u8)FLASH_FLAG) != (u8)RESET)
1690  0003 c4505f        	and	a,20575
1691  0006 2706          	jreq	L575
1692                     ; 691         status = SET; /* FLASH_FLAG is set */
1694  0008 a601          	ld	a,#1
1695  000a 6b01          	ld	(OFST+0,sp),a
1697  000c 2002          	jra	L775
1698  000e               L575:
1699                     ; 695         status = RESET; /* FLASH_FLAG is reset*/
1701  000e 0f01          	clr	(OFST+0,sp)
1702  0010               L775:
1703                     ; 699     return status;
1705  0010 7b01          	ld	a,(OFST+0,sp)
1708  0012 5b01          	addw	sp,#1
1709  0014 81            	ret
1790                     ; 717 FLASH_Status_TypeDef FLASH_WaitForLastOperation(FLASH_MemType_TypeDef MemType)
1790                     ; 718 {
1791                     .text:	section	.text,new
1792  0000               _FLASH_WaitForLastOperation:
1794  0000 5205          	subw	sp,#5
1795       00000005      OFST:	set	5
1798                     ; 719     u32 timeout = 2000;
1800  0002 ae07d0        	ldw	x,#2000
1801  0005 1f03          	ldw	(OFST-2,sp),x
1802  0007 ae0000        	ldw	x,#0
1803  000a 1f01          	ldw	(OFST-4,sp),x
1804                     ; 720     u8 flagstatus = 0x00;
1806  000c 0f05          	clr	(OFST+0,sp)
1807                     ; 722     if (MemType == FLASH_MEMTYPE_PROG)
1809  000e 4d            	tnz	a
1810  000f 2631          	jrne	L356
1812  0011 2010          	jra	L146
1813  0013               L736:
1814                     ; 726             flagstatus = (u8)(FLASH->IAPSR & (FLASH_IAPSR_EOP |
1814                     ; 727                                                  FLASH_IAPSR_WR_PG_DIS));
1816  0013 c6505f        	ld	a,20575
1817  0016 a405          	and	a,#5
1818  0018 6b05          	ld	(OFST+0,sp),a
1819                     ; 728             timeout--;
1821  001a 96            	ldw	x,sp
1822  001b 1c0001        	addw	x,#OFST-4
1823  001e a601          	ld	a,#1
1824  0020 cd0000        	call	c_lgsbc
1826  0023               L146:
1827                     ; 724         while ((flagstatus == 0x00) && (timeout != 0x00))
1829  0023 0d05          	tnz	(OFST+0,sp)
1830  0025 2628          	jrne	L746
1832  0027 96            	ldw	x,sp
1833  0028 1c0001        	addw	x,#OFST-4
1834  002b cd0000        	call	c_lzmp
1836  002e 26e3          	jrne	L736
1837  0030 201d          	jra	L746
1838  0032               L156:
1839                     ; 735             flagstatus = (u8)(FLASH->IAPSR & (FLASH_IAPSR_HVOFF |
1839                     ; 736                                                  FLASH_IAPSR_WR_PG_DIS));
1841  0032 c6505f        	ld	a,20575
1842  0035 a441          	and	a,#65
1843  0037 6b05          	ld	(OFST+0,sp),a
1844                     ; 737             timeout--;
1846  0039 96            	ldw	x,sp
1847  003a 1c0001        	addw	x,#OFST-4
1848  003d a601          	ld	a,#1
1849  003f cd0000        	call	c_lgsbc
1851  0042               L356:
1852                     ; 733         while ((flagstatus == 0x00) && (timeout != 0x00))
1854  0042 0d05          	tnz	(OFST+0,sp)
1855  0044 2609          	jrne	L746
1857  0046 96            	ldw	x,sp
1858  0047 1c0001        	addw	x,#OFST-4
1859  004a cd0000        	call	c_lzmp
1861  004d 26e3          	jrne	L156
1862  004f               L746:
1863                     ; 740     if (timeout == 0x00 )
1865  004f 96            	ldw	x,sp
1866  0050 1c0001        	addw	x,#OFST-4
1867  0053 cd0000        	call	c_lzmp
1869  0056 2604          	jrne	L166
1870                     ; 742         flagstatus = FLASH_STATUS_TIMEOUT;
1872  0058 a602          	ld	a,#2
1873  005a 6b05          	ld	(OFST+0,sp),a
1874  005c               L166:
1875                     ; 745     return((FLASH_Status_TypeDef)flagstatus);
1877  005c 7b05          	ld	a,(OFST+0,sp)
1880  005e 5b05          	addw	sp,#5
1881  0060 81            	ret
1894                     	xdef	_FLASH_WaitForLastOperation
1895                     	xdef	_FLASH_GetFlagStatus
1896                     	xdef	_FLASH_GetBootSize
1897                     	xdef	_FLASH_GetProgrammingTime
1898                     	xdef	_FLASH_GetLowPowerMode
1899                     	xdef	_FLASH_SetProgrammingTime
1900                     	xdef	_FLASH_SetLowPowerMode
1901                     	xdef	_FLASH_ReadOptionByte
1902                     	xdef	_FLASH_ReadByte
1903                     	xdef	_FLASH_ProgramWord
1904                     	xdef	_FLASH_ProgramOptionByte
1905                     	xdef	_FLASH_ProgramByte
1906                     	xdef	_FLASH_ProgramBlock
1907                     	xdef	_FLASH_EraseOptionByte
1908                     	xdef	_FLASH_EraseByte
1909                     	xdef	_FLASH_EraseBlock
1910                     	xdef	_FLASH_ITConfig
1911                     	xdef	_FLASH_DeInit
1912                     	xdef	_FLASH_Lock
1913                     	xdef	_FLASH_Unlock
1914                     	xref.b	c_lreg
1915                     	xref.b	c_x
1934                     	xref	c_lzmp
1935                     	xref	c_lgsbc
1936                     	xref	c_rtol
1937                     	xref	c_umul
1938                     	xref	c_ladc
1939                     	xref	c_ltor
1940                     	xref	c_lgadd
1941                     	xref	c_cmulx
1942                     	end
