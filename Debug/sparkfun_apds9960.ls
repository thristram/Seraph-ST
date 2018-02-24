   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  41                     ; 39 void SparkFun_APDS9960(void)
  41                     ; 40 {
  43                     .text:	section	.text,new
  44  0000               _SparkFun_APDS9960:
  48                     ; 41 	gesture_ud_delta_ = 0;
  50  0000 5f            	clrw	x
  51  0001 cf008e        	ldw	_gesture_ud_delta_,x
  52                     ; 42 	gesture_lr_delta_ = 0;
  54  0004 5f            	clrw	x
  55  0005 cf008c        	ldw	_gesture_lr_delta_,x
  56                     ; 44 	gesture_ud_count_ = 0;
  58  0008 5f            	clrw	x
  59  0009 cf008a        	ldw	_gesture_ud_count_,x
  60                     ; 45 	gesture_lr_count_ = 0;
  62  000c 5f            	clrw	x
  63  000d cf0088        	ldw	_gesture_lr_count_,x
  64                     ; 47 	gesture_near_count_ = 0;
  66  0010 5f            	clrw	x
  67  0011 cf0086        	ldw	_gesture_near_count_,x
  68                     ; 48 	gesture_far_count_ = 0;
  70  0014 5f            	clrw	x
  71  0015 cf0084        	ldw	_gesture_far_count_,x
  72                     ; 50 	gesture_state_ = 0;
  74  0018 5f            	clrw	x
  75  0019 cf0082        	ldw	_gesture_state_,x
  76                     ; 51 	gesture_motion_ = DIR_NONE;
  78  001c 5f            	clrw	x
  79  001d cf0080        	ldw	_gesture_motion_,x
  80                     ; 52 }
  83  0020 81            	ret
 140                     ; 59 uint8_t init(void)
 140                     ; 60 {
 141                     .text:	section	.text,new
 142  0000               _init:
 144  0000 89            	pushw	x
 145       00000002      OFST:	set	2
 148                     ; 64 	SparkFun_APDS9960();
 150  0001 cd0000        	call	_SparkFun_APDS9960
 152                     ; 66 	ret = I2C_Config();
 154  0004 cd0000        	call	_I2C_Config
 156  0007 6b01          	ld	(OFST-1,sp),a
 157                     ; 67 	if(ret != IIC_SUCCESS) {
 159  0009 0d01          	tnz	(OFST-1,sp)
 160  000b 2703          	jreq	L73
 161                     ; 68 		return 0;
 163  000d 4f            	clr	a
 165  000e 200f          	jra	L01
 166  0010               L73:
 167                     ; 72 	if( !wireReadDataByte(APDS9960_ID, &id) ) {
 169  0010 96            	ldw	x,sp
 170  0011 1c0002        	addw	x,#OFST+0
 171  0014 89            	pushw	x
 172  0015 a692          	ld	a,#146
 173  0017 cd0000        	call	_wireReadDataByte
 175  001a 85            	popw	x
 176  001b 4d            	tnz	a
 177  001c 2603          	jrne	L14
 178                     ; 73 		return 0;
 180  001e 4f            	clr	a
 182  001f               L01:
 184  001f 85            	popw	x
 185  0020 81            	ret
 186  0021               L14:
 187                     ; 75 	if( !(id == APDS9960_ID_1 || id == APDS9960_ID_2) ) {
 189  0021 7b02          	ld	a,(OFST+0,sp)
 190  0023 a1ab          	cp	a,#171
 191  0025 2709          	jreq	L34
 193  0027 7b02          	ld	a,(OFST+0,sp)
 194  0029 a19c          	cp	a,#156
 195  002b 2703          	jreq	L34
 196                     ; 76 		return 0;
 198  002d 4f            	clr	a
 200  002e 20ef          	jra	L01
 201  0030               L34:
 202                     ; 80 	if( !setMode(ALL, OFF) ) {
 204  0030 5f            	clrw	x
 205  0031 a607          	ld	a,#7
 206  0033 95            	ld	xh,a
 207  0034 cd0000        	call	_setMode
 209  0037 4d            	tnz	a
 210  0038 2603          	jrne	L54
 211                     ; 81 		return 0;
 213  003a 4f            	clr	a
 215  003b 20e2          	jra	L01
 216  003d               L54:
 217                     ; 85 	if( !wireWriteDataByte(APDS9960_ATIME, DEFAULT_ATIME) ) {
 219  003d ae00db        	ldw	x,#219
 220  0040 a681          	ld	a,#129
 221  0042 95            	ld	xh,a
 222  0043 cd0000        	call	_wireWriteDataByte
 224  0046 4d            	tnz	a
 225  0047 2603          	jrne	L74
 226                     ; 86 		return 0;
 228  0049 4f            	clr	a
 230  004a 20d3          	jra	L01
 231  004c               L74:
 232                     ; 88 	if( !wireWriteDataByte(APDS9960_WTIME, DEFAULT_WTIME) ) {
 234  004c ae00f6        	ldw	x,#246
 235  004f a683          	ld	a,#131
 236  0051 95            	ld	xh,a
 237  0052 cd0000        	call	_wireWriteDataByte
 239  0055 4d            	tnz	a
 240  0056 2603          	jrne	L15
 241                     ; 89 		return 0;
 243  0058 4f            	clr	a
 245  0059 20c4          	jra	L01
 246  005b               L15:
 247                     ; 91 	if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_PROX_PPULSE) ) {
 249  005b ae0087        	ldw	x,#135
 250  005e a68e          	ld	a,#142
 251  0060 95            	ld	xh,a
 252  0061 cd0000        	call	_wireWriteDataByte
 254  0064 4d            	tnz	a
 255  0065 2603          	jrne	L35
 256                     ; 92 		return 0;
 258  0067 4f            	clr	a
 260  0068 20b5          	jra	L01
 261  006a               L35:
 262                     ; 94 	if( !wireWriteDataByte(APDS9960_POFFSET_UR, DEFAULT_POFFSET_UR) ) {
 264  006a 5f            	clrw	x
 265  006b a69d          	ld	a,#157
 266  006d 95            	ld	xh,a
 267  006e cd0000        	call	_wireWriteDataByte
 269  0071 4d            	tnz	a
 270  0072 2603          	jrne	L55
 271                     ; 95 		return 0;
 273  0074 4f            	clr	a
 275  0075 20a8          	jra	L01
 276  0077               L55:
 277                     ; 97 	if( !wireWriteDataByte(APDS9960_POFFSET_DL, DEFAULT_POFFSET_DL) ) {
 279  0077 5f            	clrw	x
 280  0078 a69e          	ld	a,#158
 281  007a 95            	ld	xh,a
 282  007b cd0000        	call	_wireWriteDataByte
 284  007e 4d            	tnz	a
 285  007f 2603          	jrne	L75
 286                     ; 98 		return 0;
 288  0081 4f            	clr	a
 290  0082 200d          	jra	L21
 291  0084               L75:
 292                     ; 100 	if( !wireWriteDataByte(APDS9960_CONFIG1, DEFAULT_CONFIG1) ) {
 294  0084 ae0060        	ldw	x,#96
 295  0087 a68d          	ld	a,#141
 296  0089 95            	ld	xh,a
 297  008a cd0000        	call	_wireWriteDataByte
 299  008d 4d            	tnz	a
 300  008e 2603          	jrne	L16
 301                     ; 101 		return 0;
 303  0090 4f            	clr	a
 305  0091               L21:
 307  0091 85            	popw	x
 308  0092 81            	ret
 309  0093               L16:
 310                     ; 103 	if( !setLEDDrive(DEFAULT_LDRIVE) ) {
 312  0093 4f            	clr	a
 313  0094 cd0000        	call	_setLEDDrive
 315  0097 4d            	tnz	a
 316  0098 2603          	jrne	L36
 317                     ; 104 		return 0;
 319  009a 4f            	clr	a
 321  009b 20f4          	jra	L21
 322  009d               L36:
 323                     ; 106 	if( !setProximityGain(DEFAULT_PGAIN) ) {
 325  009d a602          	ld	a,#2
 326  009f cd0000        	call	_setProximityGain
 328  00a2 4d            	tnz	a
 329  00a3 2603          	jrne	L56
 330                     ; 107 		return 0;
 332  00a5 4f            	clr	a
 334  00a6 20e9          	jra	L21
 335  00a8               L56:
 336                     ; 109 	if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
 338  00a8 a601          	ld	a,#1
 339  00aa cd0000        	call	_setAmbientLightGain
 341  00ad 4d            	tnz	a
 342  00ae 2603          	jrne	L76
 343                     ; 110 		return 0;
 345  00b0 4f            	clr	a
 347  00b1 20de          	jra	L21
 348  00b3               L76:
 349                     ; 112 	if( !setProxIntLowThresh(DEFAULT_PILT) ) {
 351  00b3 4f            	clr	a
 352  00b4 cd0000        	call	_setProxIntLowThresh
 354  00b7 4d            	tnz	a
 355  00b8 2603          	jrne	L17
 356                     ; 113 		return 0;
 358  00ba 4f            	clr	a
 360  00bb 20d4          	jra	L21
 361  00bd               L17:
 362                     ; 115 	if( !setProxIntHighThresh(DEFAULT_PIHT) ) {
 364  00bd a632          	ld	a,#50
 365  00bf cd0000        	call	_setProxIntHighThresh
 367  00c2 4d            	tnz	a
 368  00c3 2603          	jrne	L37
 369                     ; 116 		return 0;
 371  00c5 4f            	clr	a
 373  00c6 20c9          	jra	L21
 374  00c8               L37:
 375                     ; 118 	if( !setLightIntLowThreshold(DEFAULT_AILT) ) {
 377  00c8 aeffff        	ldw	x,#65535
 378  00cb cd0000        	call	_setLightIntLowThreshold
 380  00ce 4d            	tnz	a
 381  00cf 2603          	jrne	L57
 382                     ; 119 		return 0;
 384  00d1 4f            	clr	a
 386  00d2 20bd          	jra	L21
 387  00d4               L57:
 388                     ; 121 	if( !setLightIntHighThreshold(DEFAULT_AIHT) ) {
 390  00d4 5f            	clrw	x
 391  00d5 cd0000        	call	_setLightIntHighThreshold
 393  00d8 4d            	tnz	a
 394  00d9 2603          	jrne	L77
 395                     ; 122 		return 0;
 397  00db 4f            	clr	a
 399  00dc 20b3          	jra	L21
 400  00de               L77:
 401                     ; 124 	if( !wireWriteDataByte(APDS9960_PERS, DEFAULT_PERS) ) {
 403  00de ae0011        	ldw	x,#17
 404  00e1 a68c          	ld	a,#140
 405  00e3 95            	ld	xh,a
 406  00e4 cd0000        	call	_wireWriteDataByte
 408  00e7 4d            	tnz	a
 409  00e8 2603          	jrne	L101
 410                     ; 125 		return 0;
 412  00ea 4f            	clr	a
 414  00eb 20a4          	jra	L21
 415  00ed               L101:
 416                     ; 127 	if( !wireWriteDataByte(APDS9960_CONFIG2, DEFAULT_CONFIG2) ) {
 418  00ed ae0001        	ldw	x,#1
 419  00f0 a690          	ld	a,#144
 420  00f2 95            	ld	xh,a
 421  00f3 cd0000        	call	_wireWriteDataByte
 423  00f6 4d            	tnz	a
 424  00f7 2603          	jrne	L301
 425                     ; 128 		return 0;
 427  00f9 4f            	clr	a
 429  00fa 200b          	jra	L41
 430  00fc               L301:
 431                     ; 130 	if( !wireWriteDataByte(APDS9960_CONFIG3, DEFAULT_CONFIG3) ) {
 433  00fc 5f            	clrw	x
 434  00fd a69f          	ld	a,#159
 435  00ff 95            	ld	xh,a
 436  0100 cd0000        	call	_wireWriteDataByte
 438  0103 4d            	tnz	a
 439  0104 2603          	jrne	L501
 440                     ; 131 		return 0;
 442  0106 4f            	clr	a
 444  0107               L41:
 446  0107 85            	popw	x
 447  0108 81            	ret
 448  0109               L501:
 449                     ; 135 	if( !setGestureEnterThresh(DEFAULT_GPENTH) ) {
 451  0109 a628          	ld	a,#40
 452  010b cd0000        	call	_setGestureEnterThresh
 454  010e 4d            	tnz	a
 455  010f 2603          	jrne	L701
 456                     ; 136 		return 0;
 458  0111 4f            	clr	a
 460  0112 20f3          	jra	L41
 461  0114               L701:
 462                     ; 138 	if( !setGestureExitThresh(DEFAULT_GEXTH) ) {
 464  0114 a61e          	ld	a,#30
 465  0116 cd0000        	call	_setGestureExitThresh
 467  0119 4d            	tnz	a
 468  011a 2603          	jrne	L111
 469                     ; 139 		return 0;
 471  011c 4f            	clr	a
 473  011d 20e8          	jra	L41
 474  011f               L111:
 475                     ; 141 	if( !wireWriteDataByte(APDS9960_GCONF1, DEFAULT_GCONF1) ) {
 477  011f ae0040        	ldw	x,#64
 478  0122 a6a2          	ld	a,#162
 479  0124 95            	ld	xh,a
 480  0125 cd0000        	call	_wireWriteDataByte
 482  0128 4d            	tnz	a
 483  0129 2603          	jrne	L311
 484                     ; 142 		return 0;
 486  012b 4f            	clr	a
 488  012c 20d9          	jra	L41
 489  012e               L311:
 490                     ; 144 	if( !setGestureGain(DEFAULT_GGAIN) ) {
 492  012e a602          	ld	a,#2
 493  0130 cd0000        	call	_setGestureGain
 495  0133 4d            	tnz	a
 496  0134 2603          	jrne	L511
 497                     ; 145 		return 0;
 499  0136 4f            	clr	a
 501  0137 20ce          	jra	L41
 502  0139               L511:
 503                     ; 147 	if( !setGestureLEDDrive(DEFAULT_GLDRIVE) ) {
 505  0139 4f            	clr	a
 506  013a cd0000        	call	_setGestureLEDDrive
 508  013d 4d            	tnz	a
 509  013e 2603          	jrne	L711
 510                     ; 148 		return 0;
 512  0140 4f            	clr	a
 514  0141 20c4          	jra	L41
 515  0143               L711:
 516                     ; 150 	if( !setGestureWaitTime(DEFAULT_GWTIME) ) {
 518  0143 a601          	ld	a,#1
 519  0145 cd0000        	call	_setGestureWaitTime
 521  0148 4d            	tnz	a
 522  0149 2603          	jrne	L121
 523                     ; 151 		return 0;
 525  014b 4f            	clr	a
 527  014c 20b9          	jra	L41
 528  014e               L121:
 529                     ; 153 	if( !wireWriteDataByte(APDS9960_GOFFSET_U, DEFAULT_GOFFSET) ) {
 531  014e 5f            	clrw	x
 532  014f a6a4          	ld	a,#164
 533  0151 95            	ld	xh,a
 534  0152 cd0000        	call	_wireWriteDataByte
 536  0155 4d            	tnz	a
 537  0156 2603          	jrne	L321
 538                     ; 154 		return 0;
 540  0158 4f            	clr	a
 542  0159 20ac          	jra	L41
 543  015b               L321:
 544                     ; 156 	if( !wireWriteDataByte(APDS9960_GOFFSET_D, DEFAULT_GOFFSET) ) {
 546  015b 5f            	clrw	x
 547  015c a6a5          	ld	a,#165
 548  015e 95            	ld	xh,a
 549  015f cd0000        	call	_wireWriteDataByte
 551  0162 4d            	tnz	a
 552  0163 2603          	jrne	L521
 553                     ; 157 		return 0;
 555  0165 4f            	clr	a
 557  0166 209f          	jra	L41
 558  0168               L521:
 559                     ; 159 	if( !wireWriteDataByte(APDS9960_GOFFSET_L, DEFAULT_GOFFSET) ) {
 561  0168 5f            	clrw	x
 562  0169 a6a7          	ld	a,#167
 563  016b 95            	ld	xh,a
 564  016c cd0000        	call	_wireWriteDataByte
 566  016f 4d            	tnz	a
 567  0170 2603          	jrne	L721
 568                     ; 160 		return 0;
 570  0172 4f            	clr	a
 572  0173 200b          	jra	L61
 573  0175               L721:
 574                     ; 162 	if( !wireWriteDataByte(APDS9960_GOFFSET_R, DEFAULT_GOFFSET) ) {
 576  0175 5f            	clrw	x
 577  0176 a6a9          	ld	a,#169
 578  0178 95            	ld	xh,a
 579  0179 cd0000        	call	_wireWriteDataByte
 581  017c 4d            	tnz	a
 582  017d 2603          	jrne	L131
 583                     ; 163 		return 0;
 585  017f 4f            	clr	a
 587  0180               L61:
 589  0180 85            	popw	x
 590  0181 81            	ret
 591  0182               L131:
 592                     ; 165 	if( !wireWriteDataByte(APDS9960_GPULSE, DEFAULT_GPULSE) ) {
 594  0182 ae00c9        	ldw	x,#201
 595  0185 a6a6          	ld	a,#166
 596  0187 95            	ld	xh,a
 597  0188 cd0000        	call	_wireWriteDataByte
 599  018b 4d            	tnz	a
 600  018c 2603          	jrne	L331
 601                     ; 166 		return 0;
 603  018e 4f            	clr	a
 605  018f 20ef          	jra	L61
 606  0191               L331:
 607                     ; 168 	if( !wireWriteDataByte(APDS9960_GCONF3, DEFAULT_GCONF3) ) {
 609  0191 5f            	clrw	x
 610  0192 a6aa          	ld	a,#170
 611  0194 95            	ld	xh,a
 612  0195 cd0000        	call	_wireWriteDataByte
 614  0198 4d            	tnz	a
 615  0199 2603          	jrne	L531
 616                     ; 169 		return 0;
 618  019b 4f            	clr	a
 620  019c 20e2          	jra	L61
 621  019e               L531:
 622                     ; 171 	if( !setGestureIntEnable(DEFAULT_GIEN) ) {
 624  019e 4f            	clr	a
 625  019f cd0000        	call	_setGestureIntEnable
 627  01a2 4d            	tnz	a
 628  01a3 2603          	jrne	L731
 629                     ; 172 		return 0;
 631  01a5 4f            	clr	a
 633  01a6 20d8          	jra	L61
 634  01a8               L731:
 635                     ; 176 	return 1;
 637  01a8 a601          	ld	a,#1
 639  01aa 20d4          	jra	L61
 672                     ; 189 uint8_t getMode(void)
 672                     ; 190 {
 673                     .text:	section	.text,new
 674  0000               _getMode:
 676  0000 88            	push	a
 677       00000001      OFST:	set	1
 680                     ; 194 	if( !wireReadDataByte(APDS9960_ENABLE, &enable_value) ) {
 682  0001 96            	ldw	x,sp
 683  0002 1c0001        	addw	x,#OFST+0
 684  0005 89            	pushw	x
 685  0006 a680          	ld	a,#128
 686  0008 cd0000        	call	_wireReadDataByte
 688  000b 85            	popw	x
 689  000c 4d            	tnz	a
 690  000d 2605          	jrne	L551
 691                     ; 195 		return APDS9960_ERROR;
 693  000f a6ff          	ld	a,#255
 696  0011 5b01          	addw	sp,#1
 697  0013 81            	ret
 698  0014               L551:
 699                     ; 198 	return enable_value;
 701  0014 7b01          	ld	a,(OFST+0,sp)
 704  0016 5b01          	addw	sp,#1
 705  0018 81            	ret
 753                     ; 208 uint8_t setMode(uint8_t mode, uint8_t enable)
 753                     ; 209 {
 754                     .text:	section	.text,new
 755  0000               _setMode:
 757  0000 89            	pushw	x
 758  0001 88            	push	a
 759       00000001      OFST:	set	1
 762                     ; 213 	reg_val = getMode();
 764  0002 cd0000        	call	_getMode
 766  0005 6b01          	ld	(OFST+0,sp),a
 767                     ; 214 	if( reg_val == APDS9960_ERROR ) {
 769  0007 7b01          	ld	a,(OFST+0,sp)
 770  0009 a1ff          	cp	a,#255
 771  000b 2603          	jrne	L771
 772                     ; 215 		return 0;
 774  000d 4f            	clr	a
 776  000e 2056          	jra	L43
 777  0010               L771:
 778                     ; 219 	enable = enable & 0x01;
 780  0010 7b03          	ld	a,(OFST+2,sp)
 781  0012 a401          	and	a,#1
 782  0014 6b03          	ld	(OFST+2,sp),a
 783                     ; 220 	if( mode >= 0 && mode <= 6 ) {
 785  0016 7b02          	ld	a,(OFST+1,sp)
 786  0018 a107          	cp	a,#7
 787  001a 242b          	jruge	L102
 788                     ; 221 		if (enable) {
 790  001c 0d03          	tnz	(OFST+2,sp)
 791  001e 2713          	jreq	L302
 792                     ; 222 			reg_val |= (1 << mode);
 794  0020 7b02          	ld	a,(OFST+1,sp)
 795  0022 5f            	clrw	x
 796  0023 97            	ld	xl,a
 797  0024 a601          	ld	a,#1
 798  0026 5d            	tnzw	x
 799  0027 2704          	jreq	L42
 800  0029               L62:
 801  0029 48            	sll	a
 802  002a 5a            	decw	x
 803  002b 26fc          	jrne	L62
 804  002d               L42:
 805  002d 1a01          	or	a,(OFST+0,sp)
 806  002f 6b01          	ld	(OFST+0,sp),a
 808  0031 2026          	jra	L702
 809  0033               L302:
 810                     ; 224 			reg_val &= ~(1 << mode);
 812  0033 7b02          	ld	a,(OFST+1,sp)
 813  0035 5f            	clrw	x
 814  0036 97            	ld	xl,a
 815  0037 a601          	ld	a,#1
 816  0039 5d            	tnzw	x
 817  003a 2704          	jreq	L03
 818  003c               L23:
 819  003c 48            	sll	a
 820  003d 5a            	decw	x
 821  003e 26fc          	jrne	L23
 822  0040               L03:
 823  0040 43            	cpl	a
 824  0041 1401          	and	a,(OFST+0,sp)
 825  0043 6b01          	ld	(OFST+0,sp),a
 826  0045 2012          	jra	L702
 827  0047               L102:
 828                     ; 226 	} else if( mode == ALL ) {
 830  0047 7b02          	ld	a,(OFST+1,sp)
 831  0049 a107          	cp	a,#7
 832  004b 260c          	jrne	L702
 833                     ; 227 		if (enable) {
 835  004d 0d03          	tnz	(OFST+2,sp)
 836  004f 2706          	jreq	L312
 837                     ; 228 			reg_val = 0x7F;
 839  0051 a67f          	ld	a,#127
 840  0053 6b01          	ld	(OFST+0,sp),a
 842  0055 2002          	jra	L702
 843  0057               L312:
 844                     ; 230 			reg_val = 0x00;
 846  0057 0f01          	clr	(OFST+0,sp)
 847  0059               L702:
 848                     ; 235 	if( !wireWriteDataByte(APDS9960_ENABLE, reg_val) ) {
 850  0059 7b01          	ld	a,(OFST+0,sp)
 851  005b 97            	ld	xl,a
 852  005c a680          	ld	a,#128
 853  005e 95            	ld	xh,a
 854  005f cd0000        	call	_wireWriteDataByte
 856  0062 4d            	tnz	a
 857  0063 2604          	jrne	L712
 858                     ; 236 		return 0;
 860  0065 4f            	clr	a
 862  0066               L43:
 864  0066 5b03          	addw	sp,#3
 865  0068 81            	ret
 866  0069               L712:
 867                     ; 239 	return 1;
 869  0069 a601          	ld	a,#1
 871  006b 20f9          	jra	L43
 907                     ; 248 uint8_t enableLightSensor(uint8_t interrupts)
 907                     ; 249 {
 908                     .text:	section	.text,new
 909  0000               _enableLightSensor:
 911  0000 88            	push	a
 912       00000000      OFST:	set	0
 915                     ; 252 	if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
 917  0001 a601          	ld	a,#1
 918  0003 cd0000        	call	_setAmbientLightGain
 920  0006 4d            	tnz	a
 921  0007 2604          	jrne	L532
 922                     ; 253 		return 0;
 924  0009 4f            	clr	a
 927  000a 5b01          	addw	sp,#1
 928  000c 81            	ret
 929  000d               L532:
 930                     ; 255 	if( interrupts ) {
 932  000d 0d01          	tnz	(OFST+1,sp)
 933  000f 270c          	jreq	L732
 934                     ; 256 		if( !setAmbientLightIntEnable(1) ) {
 936  0011 a601          	ld	a,#1
 937  0013 cd0000        	call	_setAmbientLightIntEnable
 939  0016 4d            	tnz	a
 940  0017 260f          	jrne	L342
 941                     ; 257 			return 0;
 943  0019 4f            	clr	a
 946  001a 5b01          	addw	sp,#1
 947  001c 81            	ret
 948  001d               L732:
 949                     ; 260 		if( !setAmbientLightIntEnable(0) ) {
 951  001d 4f            	clr	a
 952  001e cd0000        	call	_setAmbientLightIntEnable
 954  0021 4d            	tnz	a
 955  0022 2604          	jrne	L342
 956                     ; 261 			return 0;
 958  0024 4f            	clr	a
 961  0025 5b01          	addw	sp,#1
 962  0027 81            	ret
 963  0028               L342:
 964                     ; 264 	if( !enablePower() ) {
 966  0028 cd0000        	call	_enablePower
 968  002b 4d            	tnz	a
 969  002c 2604          	jrne	L742
 970                     ; 265 		return 0;
 972  002e 4f            	clr	a
 975  002f 5b01          	addw	sp,#1
 976  0031 81            	ret
 977  0032               L742:
 978                     ; 267 	if( !setMode(AMBIENT_LIGHT, 1) ) {
 980  0032 ae0001        	ldw	x,#1
 981  0035 a601          	ld	a,#1
 982  0037 95            	ld	xh,a
 983  0038 cd0000        	call	_setMode
 985  003b 4d            	tnz	a
 986  003c 2604          	jrne	L152
 987                     ; 268 		return 0;
 989  003e 4f            	clr	a
 992  003f 5b01          	addw	sp,#1
 993  0041 81            	ret
 994  0042               L152:
 995                     ; 271 	return 1;
 997  0042 a601          	ld	a,#1
1000  0044 5b01          	addw	sp,#1
1001  0046 81            	ret
1026                     ; 280 uint8_t disableLightSensor(void)
1026                     ; 281 {
1027                     .text:	section	.text,new
1028  0000               _disableLightSensor:
1032                     ; 282 	if( !setAmbientLightIntEnable(0) ) {
1034  0000 4f            	clr	a
1035  0001 cd0000        	call	_setAmbientLightIntEnable
1037  0004 4d            	tnz	a
1038  0005 2602          	jrne	L362
1039                     ; 283 		return 0;
1041  0007 4f            	clr	a
1044  0008 81            	ret
1045  0009               L362:
1046                     ; 285 	if( !setMode(AMBIENT_LIGHT, 0) ) {
1048  0009 5f            	clrw	x
1049  000a a601          	ld	a,#1
1050  000c 95            	ld	xh,a
1051  000d cd0000        	call	_setMode
1053  0010 4d            	tnz	a
1054  0011 2602          	jrne	L562
1055                     ; 286 		return 0;
1057  0013 4f            	clr	a
1060  0014 81            	ret
1061  0015               L562:
1062                     ; 289 	return 1;
1064  0015 a601          	ld	a,#1
1067  0017 81            	ret
1105                     ; 298 uint8_t enableProximitySensor(uint8_t interrupts)
1105                     ; 299 {
1106                     .text:	section	.text,new
1107  0000               _enableProximitySensor:
1109  0000 88            	push	a
1110       00000000      OFST:	set	0
1113                     ; 301 	if( !setProximityGain(DEFAULT_PGAIN) ) {
1115  0001 a602          	ld	a,#2
1116  0003 cd0000        	call	_setProximityGain
1118  0006 4d            	tnz	a
1119  0007 2604          	jrne	L303
1120                     ; 302 		return 0;
1122  0009 4f            	clr	a
1125  000a 5b01          	addw	sp,#1
1126  000c 81            	ret
1127  000d               L303:
1128                     ; 304 	if( !setLEDDrive(DEFAULT_LDRIVE) ) {
1130  000d 4f            	clr	a
1131  000e cd0000        	call	_setLEDDrive
1133  0011 4d            	tnz	a
1134  0012 2604          	jrne	L503
1135                     ; 305 		return 0;
1137  0014 4f            	clr	a
1140  0015 5b01          	addw	sp,#1
1141  0017 81            	ret
1142  0018               L503:
1143                     ; 307 	if( interrupts ) {
1145  0018 0d01          	tnz	(OFST+1,sp)
1146  001a 270c          	jreq	L703
1147                     ; 308 		if( !setProximityIntEnable(1) ) {
1149  001c a601          	ld	a,#1
1150  001e cd0000        	call	_setProximityIntEnable
1152  0021 4d            	tnz	a
1153  0022 260f          	jrne	L313
1154                     ; 309 			return 0;
1156  0024 4f            	clr	a
1159  0025 5b01          	addw	sp,#1
1160  0027 81            	ret
1161  0028               L703:
1162                     ; 312 		if( !setProximityIntEnable(0) ) {
1164  0028 4f            	clr	a
1165  0029 cd0000        	call	_setProximityIntEnable
1167  002c 4d            	tnz	a
1168  002d 2604          	jrne	L313
1169                     ; 313 			return 0;
1171  002f 4f            	clr	a
1174  0030 5b01          	addw	sp,#1
1175  0032 81            	ret
1176  0033               L313:
1177                     ; 316 	if( !enablePower() ) {
1179  0033 cd0000        	call	_enablePower
1181  0036 4d            	tnz	a
1182  0037 2604          	jrne	L713
1183                     ; 317 		return 0;
1185  0039 4f            	clr	a
1188  003a 5b01          	addw	sp,#1
1189  003c 81            	ret
1190  003d               L713:
1191                     ; 319 	if( !setMode(PROXIMITY, 1) ) {
1193  003d ae0001        	ldw	x,#1
1194  0040 a602          	ld	a,#2
1195  0042 95            	ld	xh,a
1196  0043 cd0000        	call	_setMode
1198  0046 4d            	tnz	a
1199  0047 2604          	jrne	L123
1200                     ; 320 		return 0;
1202  0049 4f            	clr	a
1205  004a 5b01          	addw	sp,#1
1206  004c 81            	ret
1207  004d               L123:
1208                     ; 323 	return 1;
1210  004d a601          	ld	a,#1
1213  004f 5b01          	addw	sp,#1
1214  0051 81            	ret
1240                     ; 331 uint8_t disableProximitySensor(void)
1240                     ; 332 {
1241                     .text:	section	.text,new
1242  0000               _disableProximitySensor:
1246                     ; 333 	if( !setProximityIntEnable(0) ) {
1248  0000 4f            	clr	a
1249  0001 cd0000        	call	_setProximityIntEnable
1251  0004 4d            	tnz	a
1252  0005 2602          	jrne	L333
1253                     ; 334 		return 0;
1255  0007 4f            	clr	a
1258  0008 81            	ret
1259  0009               L333:
1260                     ; 336 	if( !setMode(PROXIMITY, 0) ) {
1262  0009 5f            	clrw	x
1263  000a a602          	ld	a,#2
1264  000c 95            	ld	xh,a
1265  000d cd0000        	call	_setMode
1267  0010 4d            	tnz	a
1268  0011 2602          	jrne	L533
1269                     ; 337 		return 0;
1271  0013 4f            	clr	a
1274  0014 81            	ret
1275  0015               L533:
1276                     ; 340 	return 1;
1278  0015 a601          	ld	a,#1
1281  0017 81            	ret
1321                     ; 349 uint8_t enableGestureSensor(uint8_t interrupts)
1321                     ; 350 {
1322                     .text:	section	.text,new
1323  0000               _enableGestureSensor:
1325  0000 88            	push	a
1326       00000000      OFST:	set	0
1329                     ; 358 	resetGestureParameters();
1331  0001 cd0000        	call	_resetGestureParameters
1333                     ; 359 	if( !wireWriteDataByte(APDS9960_WTIME, 0xFF) ) {
1335  0004 ae00ff        	ldw	x,#255
1336  0007 a683          	ld	a,#131
1337  0009 95            	ld	xh,a
1338  000a cd0000        	call	_wireWriteDataByte
1340  000d 4d            	tnz	a
1341  000e 2604          	jrne	L353
1342                     ; 360 		return 0;
1344  0010 4f            	clr	a
1347  0011 5b01          	addw	sp,#1
1348  0013 81            	ret
1349  0014               L353:
1350                     ; 362 	if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_GESTURE_PPULSE) ) {
1352  0014 ae0089        	ldw	x,#137
1353  0017 a68e          	ld	a,#142
1354  0019 95            	ld	xh,a
1355  001a cd0000        	call	_wireWriteDataByte
1357  001d 4d            	tnz	a
1358  001e 2604          	jrne	L553
1359                     ; 363 		return 0;
1361  0020 4f            	clr	a
1364  0021 5b01          	addw	sp,#1
1365  0023 81            	ret
1366  0024               L553:
1367                     ; 365 	if( !setLEDBoost(LED_BOOST_300) ) {
1369  0024 a603          	ld	a,#3
1370  0026 cd0000        	call	_setLEDBoost
1372  0029 4d            	tnz	a
1373  002a 2604          	jrne	L753
1374                     ; 366 		return 0;
1376  002c 4f            	clr	a
1379  002d 5b01          	addw	sp,#1
1380  002f 81            	ret
1381  0030               L753:
1382                     ; 368 	if( interrupts ) {
1384  0030 0d01          	tnz	(OFST+1,sp)
1385  0032 270c          	jreq	L163
1386                     ; 369 		if( !setGestureIntEnable(1) ) {
1388  0034 a601          	ld	a,#1
1389  0036 cd0000        	call	_setGestureIntEnable
1391  0039 4d            	tnz	a
1392  003a 260f          	jrne	L563
1393                     ; 370 			return 0;
1395  003c 4f            	clr	a
1398  003d 5b01          	addw	sp,#1
1399  003f 81            	ret
1400  0040               L163:
1401                     ; 373 		if( !setGestureIntEnable(0) ) {
1403  0040 4f            	clr	a
1404  0041 cd0000        	call	_setGestureIntEnable
1406  0044 4d            	tnz	a
1407  0045 2604          	jrne	L563
1408                     ; 374 			return 0;
1410  0047 4f            	clr	a
1413  0048 5b01          	addw	sp,#1
1414  004a 81            	ret
1415  004b               L563:
1416                     ; 377 	if( !setGestureMode(1) ) {
1418  004b a601          	ld	a,#1
1419  004d cd0000        	call	_setGestureMode
1421  0050 4d            	tnz	a
1422  0051 2604          	jrne	L173
1423                     ; 378 		return 0;
1425  0053 4f            	clr	a
1428  0054 5b01          	addw	sp,#1
1429  0056 81            	ret
1430  0057               L173:
1431                     ; 380 	if( !enablePower() ) {
1433  0057 cd0000        	call	_enablePower
1435  005a 4d            	tnz	a
1436  005b 2604          	jrne	L373
1437                     ; 381 		return 0;
1439  005d 4f            	clr	a
1442  005e 5b01          	addw	sp,#1
1443  0060 81            	ret
1444  0061               L373:
1445                     ; 383 	if( !setMode(WAIT, 1) ) {
1447  0061 ae0001        	ldw	x,#1
1448  0064 a603          	ld	a,#3
1449  0066 95            	ld	xh,a
1450  0067 cd0000        	call	_setMode
1452  006a 4d            	tnz	a
1453  006b 2604          	jrne	L573
1454                     ; 384 		return 0;
1456  006d 4f            	clr	a
1459  006e 5b01          	addw	sp,#1
1460  0070 81            	ret
1461  0071               L573:
1462                     ; 386 	if( !setMode(PROXIMITY, 1) ) {
1464  0071 ae0001        	ldw	x,#1
1465  0074 a602          	ld	a,#2
1466  0076 95            	ld	xh,a
1467  0077 cd0000        	call	_setMode
1469  007a 4d            	tnz	a
1470  007b 2604          	jrne	L773
1471                     ; 387 		return 0;
1473  007d 4f            	clr	a
1476  007e 5b01          	addw	sp,#1
1477  0080 81            	ret
1478  0081               L773:
1479                     ; 389 	if( !setMode(GESTURE, 1) ) {
1481  0081 ae0001        	ldw	x,#1
1482  0084 a606          	ld	a,#6
1483  0086 95            	ld	xh,a
1484  0087 cd0000        	call	_setMode
1486  008a 4d            	tnz	a
1487  008b 2604          	jrne	L104
1488                     ; 390 		return 0;
1490  008d 4f            	clr	a
1493  008e 5b01          	addw	sp,#1
1494  0090 81            	ret
1495  0091               L104:
1496                     ; 393 	return 1;
1498  0091 a601          	ld	a,#1
1501  0093 5b01          	addw	sp,#1
1502  0095 81            	ret
1530                     ; 402 uint8_t disableGestureSensor(void)
1530                     ; 403 {
1531                     .text:	section	.text,new
1532  0000               _disableGestureSensor:
1536                     ; 404 	resetGestureParameters();
1538  0000 cd0000        	call	_resetGestureParameters
1540                     ; 405 	if( !setGestureIntEnable(0) ) {
1542  0003 4f            	clr	a
1543  0004 cd0000        	call	_setGestureIntEnable
1545  0007 4d            	tnz	a
1546  0008 2602          	jrne	L314
1547                     ; 406 		return 0;
1549  000a 4f            	clr	a
1552  000b 81            	ret
1553  000c               L314:
1554                     ; 408 	if( !setGestureMode(0) ) {
1556  000c 4f            	clr	a
1557  000d cd0000        	call	_setGestureMode
1559  0010 4d            	tnz	a
1560  0011 2602          	jrne	L514
1561                     ; 409 		return 0;
1563  0013 4f            	clr	a
1566  0014 81            	ret
1567  0015               L514:
1568                     ; 411 	if( !setMode(GESTURE, 0) ) {
1570  0015 5f            	clrw	x
1571  0016 a606          	ld	a,#6
1572  0018 95            	ld	xh,a
1573  0019 cd0000        	call	_setMode
1575  001c 4d            	tnz	a
1576  001d 2602          	jrne	L714
1577                     ; 412 		return 0;
1579  001f 4f            	clr	a
1582  0020 81            	ret
1583  0021               L714:
1584                     ; 415 	return 1;
1586  0021 a601          	ld	a,#1
1589  0023 81            	ret
1622                     ; 423 uint8_t isGestureAvailable(void)
1622                     ; 424 {
1623                     .text:	section	.text,new
1624  0000               _isGestureAvailable:
1626  0000 88            	push	a
1627       00000001      OFST:	set	1
1630                     ; 428 	if( !wireReadDataByte(APDS9960_GSTATUS, &val) ) {
1632  0001 96            	ldw	x,sp
1633  0002 1c0001        	addw	x,#OFST+0
1634  0005 89            	pushw	x
1635  0006 a6af          	ld	a,#175
1636  0008 cd0000        	call	_wireReadDataByte
1638  000b 85            	popw	x
1639  000c 4d            	tnz	a
1640  000d 2605          	jrne	L534
1641                     ; 429 		return APDS9960_ERROR;
1643  000f a6ff          	ld	a,#255
1646  0011 5b01          	addw	sp,#1
1647  0013 81            	ret
1648  0014               L534:
1649                     ; 433 	val &= APDS9960_GVALID;
1651  0014 7b01          	ld	a,(OFST+0,sp)
1652  0016 a401          	and	a,#1
1653  0018 6b01          	ld	(OFST+0,sp),a
1654                     ; 436 	if( val == 1) {
1656  001a 7b01          	ld	a,(OFST+0,sp)
1657  001c a101          	cp	a,#1
1658  001e 2605          	jrne	L734
1659                     ; 437 		return 1;
1661  0020 a601          	ld	a,#1
1664  0022 5b01          	addw	sp,#1
1665  0024 81            	ret
1666  0025               L734:
1667                     ; 439 		return 0;
1669  0025 4f            	clr	a
1672  0026 5b01          	addw	sp,#1
1673  0028 81            	ret
1760                     ; 450 u8 gesture_read_data(u8 *dir)
1760                     ; 451 {
1761                     .text:	section	.text,new
1762  0000               _gesture_read_data:
1764  0000 89            	pushw	x
1765  0001 5285          	subw	sp,#133
1766       00000085      OFST:	set	133
1769                     ; 452 	u8  fifo_level = 0;
1771  0003 0f03          	clr	(OFST-130,sp)
1772                     ; 453 	u8  bytes_read = 0;
1774  0005 7b04          	ld	a,(OFST-129,sp)
1775  0007 97            	ld	xl,a
1776                     ; 455 	u8  gstatus = 0;
1778  0008 0f01          	clr	(OFST-132,sp)
1779                     ; 456 	u8  ret = 0xff, i;
1781  000a a6ff          	ld	a,#255
1782  000c 6b02          	ld	(OFST-131,sp),a
1783                     ; 459 	if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
1785  000e 96            	ldw	x,sp
1786  000f 1c0001        	addw	x,#OFST-132
1787  0012 89            	pushw	x
1788  0013 a6af          	ld	a,#175
1789  0015 cd0000        	call	_wireReadDataByte
1791  0018 85            	popw	x
1792  0019 4d            	tnz	a
1793  001a 2603          	jrne	L774
1794                     ; 460 		return 0;
1796  001c 4f            	clr	a
1798  001d 201a          	jra	L66
1799  001f               L774:
1800                     ; 464 	if( (gstatus & APDS9960_GVALID) == APDS9960_GVALID ) {
1802  001f 7b01          	ld	a,(OFST-132,sp)
1803  0021 a401          	and	a,#1
1804  0023 a101          	cp	a,#1
1805  0025 2703          	jreq	L07
1806  0027 cc00f8        	jp	L105
1807  002a               L07:
1808                     ; 467 		if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) {
1810  002a 96            	ldw	x,sp
1811  002b 1c0003        	addw	x,#OFST-130
1812  002e 89            	pushw	x
1813  002f a6ae          	ld	a,#174
1814  0031 cd0000        	call	_wireReadDataByte
1816  0034 85            	popw	x
1817  0035 4d            	tnz	a
1818  0036 2604          	jrne	L305
1819                     ; 468 			return 0;
1821  0038 4f            	clr	a
1823  0039               L66:
1825  0039 5b87          	addw	sp,#135
1826  003b 81            	ret
1827  003c               L305:
1828                     ; 472 		if(fifo_level > 0) {
1830  003c 0d03          	tnz	(OFST-130,sp)
1831  003e 2603          	jrne	L27
1832  0040 cc0105        	jp	L525
1833  0043               L27:
1834                     ; 473 			if(fifo_level >= 32){		//±ÜÃâÔ½½ç
1836  0043 7b03          	ld	a,(OFST-130,sp)
1837  0045 a120          	cp	a,#32
1838  0047 2504          	jrult	L705
1839                     ; 474 				fifo_level = 32;
1841  0049 a620          	ld	a,#32
1842  004b 6b03          	ld	(OFST-130,sp),a
1843  004d               L705:
1844                     ; 476 			bytes_read = wireReadDataBlock(APDS9960_GFIFO_U, (uint8_t*)fifo_data, (fifo_level * 4) );
1846  004d 7b03          	ld	a,(OFST-130,sp)
1847  004f 97            	ld	xl,a
1848  0050 a604          	ld	a,#4
1849  0052 42            	mul	x,a
1850  0053 89            	pushw	x
1851  0054 96            	ldw	x,sp
1852  0055 1c0007        	addw	x,#OFST-126
1853  0058 89            	pushw	x
1854  0059 a6fc          	ld	a,#252
1855  005b cd0000        	call	_wireReadDataBlock
1857  005e 5b04          	addw	sp,#4
1858  0060 01            	rrwa	x,a
1859  0061 6b04          	ld	(OFST-129,sp),a
1860  0063 02            	rlwa	x,a
1861                     ; 477 			if( bytes_read == 0 ) {
1863  0064 0d04          	tnz	(OFST-129,sp)
1864  0066 2603          	jrne	L115
1865                     ; 478 				return 0;
1867  0068 4f            	clr	a
1869  0069 20ce          	jra	L66
1870  006b               L115:
1871                     ; 482 			if( bytes_read >= 4 ) {
1873  006b 7b04          	ld	a,(OFST-129,sp)
1874  006d a104          	cp	a,#4
1875  006f 2403          	jruge	L47
1876  0071 cc0105        	jp	L525
1877  0074               L47:
1878                     ; 484 				for( i = 0; i < bytes_read; i += 4 ) {
1880  0074 0f85          	clr	(OFST+0,sp)
1882  0076 206a          	jra	L125
1883  0078               L515:
1884                     ; 485 					gesture_data_.u_data[gesture_data_.index] = \
1884                     ; 486 							fifo_data[i + 0];
1886  0078 c60110        	ld	a,_gesture_data_+128
1887  007b 5f            	clrw	x
1888  007c 97            	ld	xl,a
1889  007d 89            	pushw	x
1890  007e 96            	ldw	x,sp
1891  007f 1c0007        	addw	x,#OFST-126
1892  0082 9f            	ld	a,xl
1893  0083 5e            	swapw	x
1894  0084 1b87          	add	a,(OFST+2,sp)
1895  0086 2401          	jrnc	L65
1896  0088 5c            	incw	x
1897  0089               L65:
1898  0089 02            	rlwa	x,a
1899  008a f6            	ld	a,(x)
1900  008b 85            	popw	x
1901  008c d70090        	ld	(_gesture_data_,x),a
1902                     ; 487 					gesture_data_.d_data[gesture_data_.index] = \
1902                     ; 488 							fifo_data[i + 1];
1904  008f c60110        	ld	a,_gesture_data_+128
1905  0092 5f            	clrw	x
1906  0093 97            	ld	xl,a
1907  0094 89            	pushw	x
1908  0095 96            	ldw	x,sp
1909  0096 1c0008        	addw	x,#OFST-125
1910  0099 9f            	ld	a,xl
1911  009a 5e            	swapw	x
1912  009b 1b87          	add	a,(OFST+2,sp)
1913  009d 2401          	jrnc	L06
1914  009f 5c            	incw	x
1915  00a0               L06:
1916  00a0 02            	rlwa	x,a
1917  00a1 f6            	ld	a,(x)
1918  00a2 85            	popw	x
1919  00a3 d700b0        	ld	(_gesture_data_+32,x),a
1920                     ; 489 					gesture_data_.l_data[gesture_data_.index] = \
1920                     ; 490 							fifo_data[i + 2];
1922  00a6 c60110        	ld	a,_gesture_data_+128
1923  00a9 5f            	clrw	x
1924  00aa 97            	ld	xl,a
1925  00ab 89            	pushw	x
1926  00ac 96            	ldw	x,sp
1927  00ad 1c0009        	addw	x,#OFST-124
1928  00b0 9f            	ld	a,xl
1929  00b1 5e            	swapw	x
1930  00b2 1b87          	add	a,(OFST+2,sp)
1931  00b4 2401          	jrnc	L26
1932  00b6 5c            	incw	x
1933  00b7               L26:
1934  00b7 02            	rlwa	x,a
1935  00b8 f6            	ld	a,(x)
1936  00b9 85            	popw	x
1937  00ba d700d0        	ld	(_gesture_data_+64,x),a
1938                     ; 491 					gesture_data_.r_data[gesture_data_.index] = \
1938                     ; 492 							fifo_data[i + 3];
1940  00bd c60110        	ld	a,_gesture_data_+128
1941  00c0 5f            	clrw	x
1942  00c1 97            	ld	xl,a
1943  00c2 89            	pushw	x
1944  00c3 96            	ldw	x,sp
1945  00c4 1c000a        	addw	x,#OFST-123
1946  00c7 9f            	ld	a,xl
1947  00c8 5e            	swapw	x
1948  00c9 1b87          	add	a,(OFST+2,sp)
1949  00cb 2401          	jrnc	L46
1950  00cd 5c            	incw	x
1951  00ce               L46:
1952  00ce 02            	rlwa	x,a
1953  00cf f6            	ld	a,(x)
1954  00d0 85            	popw	x
1955  00d1 d700f0        	ld	(_gesture_data_+96,x),a
1956                     ; 493 					gesture_data_.index++;
1958  00d4 725c0110      	inc	_gesture_data_+128
1959                     ; 494 					gesture_data_.total_gestures++;
1961  00d8 725c0111      	inc	_gesture_data_+129
1962                     ; 484 				for( i = 0; i < bytes_read; i += 4 ) {
1964  00dc 7b85          	ld	a,(OFST+0,sp)
1965  00de ab04          	add	a,#4
1966  00e0 6b85          	ld	(OFST+0,sp),a
1967  00e2               L125:
1970  00e2 7b85          	ld	a,(OFST+0,sp)
1971  00e4 1104          	cp	a,(OFST-129,sp)
1972  00e6 2590          	jrult	L515
1973                     ; 505 				processGestureData();
1975  00e8 cd0000        	call	_processGestureData
1977                     ; 506 				decodeGesture();
1979  00eb cd0000        	call	_decodeGesture
1981                     ; 509 				gesture_data_.index = 0;
1983  00ee 725f0110      	clr	_gesture_data_+128
1984                     ; 510 				gesture_data_.total_gestures = 0;	
1986  00f2 725f0111      	clr	_gesture_data_+129
1987  00f6 200d          	jra	L525
1988  00f8               L105:
1989                     ; 517 		ret = 1;
1991  00f8 a601          	ld	a,#1
1992  00fa 6b02          	ld	(OFST-131,sp),a
1993                     ; 520 		*dir = (u8)gesture_motion_;
1995  00fc 1e86          	ldw	x,(OFST+1,sp)
1996  00fe c60081        	ld	a,_gesture_motion_+1
1997  0101 f7            	ld	(x),a
1998                     ; 521 		resetGestureParameters();
2000  0102 cd0000        	call	_resetGestureParameters
2002  0105               L525:
2003                     ; 525 	return ret;
2005  0105 7b02          	ld	a,(OFST-131,sp)
2007  0107 ac390039      	jpf	L66
2087                     ; 542 int readGesture(void)
2087                     ; 543 {
2088                     .text:	section	.text,new
2089  0000               _readGesture:
2091  0000 5287          	subw	sp,#135
2092       00000087      OFST:	set	135
2095                     ; 544 	uint8_t fifo_level = 0;
2097  0002 0f04          	clr	(OFST-131,sp)
2098                     ; 545 	uint8_t bytes_read = 0;
2100  0004 7b05          	ld	a,(OFST-130,sp)
2101  0006 97            	ld	xl,a
2102                     ; 552 	if( !isGestureAvailable() || !(getMode() & 0b01000001) ) {
2104  0007 cd0000        	call	_isGestureAvailable
2106  000a 4d            	tnz	a
2107  000b 2707          	jreq	L165
2109  000d cd0000        	call	_getMode
2111  0010 a541          	bcp	a,#65
2112  0012 2603          	jrne	L365
2113  0014               L165:
2114                     ; 553 		return DIR_NONE;
2116  0014 5f            	clrw	x
2118  0015 201c          	jra	L001
2119  0017               L365:
2120                     ; 560 		delay_ms(FIFO_PAUSE_TIME);
2122  0017 ae001e        	ldw	x,#30
2123  001a cf0000        	ldw	_I2CTimeOut,x
2124  001d               L765:
2128  001d ce0000        	ldw	x,_I2CTimeOut
2129  0020 26fb          	jrne	L765
2130                     ; 563 		if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
2133  0022 96            	ldw	x,sp
2134  0023 1c0003        	addw	x,#OFST-132
2135  0026 89            	pushw	x
2136  0027 a6af          	ld	a,#175
2137  0029 cd0000        	call	_wireReadDataByte
2139  002c 85            	popw	x
2140  002d 4d            	tnz	a
2141  002e 2606          	jrne	L575
2142                     ; 564 			return APDS9960_ERROR;
2144  0030 ae00ff        	ldw	x,#255
2146  0033               L001:
2148  0033 5b87          	addw	sp,#135
2149  0035 81            	ret
2150  0036               L575:
2151                     ; 568 		if( (gstatus & APDS9960_GVALID) == APDS9960_GVALID ) {
2153  0036 7b03          	ld	a,(OFST-132,sp)
2154  0038 a401          	and	a,#1
2155  003a a101          	cp	a,#1
2156  003c 2703          	jreq	L201
2157  003e cc0108        	jp	L775
2158  0041               L201:
2159                     ; 571 			if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) {
2161  0041 96            	ldw	x,sp
2162  0042 1c0004        	addw	x,#OFST-131
2163  0045 89            	pushw	x
2164  0046 a6ae          	ld	a,#174
2165  0048 cd0000        	call	_wireReadDataByte
2167  004b 85            	popw	x
2168  004c 4d            	tnz	a
2169  004d 2605          	jrne	L106
2170                     ; 572 				return APDS9960_ERROR;
2172  004f ae00ff        	ldw	x,#255
2174  0052 20df          	jra	L001
2175  0054               L106:
2176                     ; 576 			if( fifo_level > 0) {
2178  0054 0d04          	tnz	(OFST-131,sp)
2179  0056 27bf          	jreq	L365
2180                     ; 577 				bytes_read = wireReadDataBlock(  APDS9960_GFIFO_U,
2180                     ; 578 				                                 (uint8_t*)fifo_data,
2180                     ; 579 				                                 (fifo_level * 4) );
2182  0058 7b04          	ld	a,(OFST-131,sp)
2183  005a 97            	ld	xl,a
2184  005b a604          	ld	a,#4
2185  005d 42            	mul	x,a
2186  005e 89            	pushw	x
2187  005f 96            	ldw	x,sp
2188  0060 1c0008        	addw	x,#OFST-127
2189  0063 89            	pushw	x
2190  0064 a6fc          	ld	a,#252
2191  0066 cd0000        	call	_wireReadDataBlock
2193  0069 5b04          	addw	sp,#4
2194  006b 01            	rrwa	x,a
2195  006c 6b05          	ld	(OFST-130,sp),a
2196  006e 02            	rlwa	x,a
2197                     ; 585 				if( bytes_read >= 4 ) {
2199  006f 7b05          	ld	a,(OFST-130,sp)
2200  0071 a104          	cp	a,#4
2201  0073 25a2          	jrult	L365
2202                     ; 586 					for( i = 0; i < bytes_read; i += 4 ) {
2204  0075 5f            	clrw	x
2205  0076 1f86          	ldw	(OFST-1,sp),x
2207  0078 206b          	jra	L316
2208  007a               L706:
2209                     ; 587 						gesture_data_.u_data[gesture_data_.index] = \
2209                     ; 588 						        fifo_data[i + 0];
2211  007a c60110        	ld	a,_gesture_data_+128
2212  007d 5f            	clrw	x
2213  007e 97            	ld	xl,a
2214  007f 9096          	ldw	y,sp
2215  0081 72a90006      	addw	y,#OFST-129
2216  0085 1701          	ldw	(OFST-134,sp),y
2217  0087 1686          	ldw	y,(OFST-1,sp)
2218  0089 72f901        	addw	y,(OFST-134,sp)
2219  008c 90f6          	ld	a,(y)
2220  008e d70090        	ld	(_gesture_data_,x),a
2221                     ; 589 						gesture_data_.d_data[gesture_data_.index] = \
2221                     ; 590 						        fifo_data[i + 1];
2223  0091 c60110        	ld	a,_gesture_data_+128
2224  0094 5f            	clrw	x
2225  0095 97            	ld	xl,a
2226  0096 9096          	ldw	y,sp
2227  0098 72a90007      	addw	y,#OFST-128
2228  009c 1701          	ldw	(OFST-134,sp),y
2229  009e 1686          	ldw	y,(OFST-1,sp)
2230  00a0 72f901        	addw	y,(OFST-134,sp)
2231  00a3 90f6          	ld	a,(y)
2232  00a5 d700b0        	ld	(_gesture_data_+32,x),a
2233                     ; 591 						gesture_data_.l_data[gesture_data_.index] = \
2233                     ; 592 						        fifo_data[i + 2];
2235  00a8 c60110        	ld	a,_gesture_data_+128
2236  00ab 5f            	clrw	x
2237  00ac 97            	ld	xl,a
2238  00ad 9096          	ldw	y,sp
2239  00af 72a90008      	addw	y,#OFST-127
2240  00b3 1701          	ldw	(OFST-134,sp),y
2241  00b5 1686          	ldw	y,(OFST-1,sp)
2242  00b7 72f901        	addw	y,(OFST-134,sp)
2243  00ba 90f6          	ld	a,(y)
2244  00bc d700d0        	ld	(_gesture_data_+64,x),a
2245                     ; 593 						gesture_data_.r_data[gesture_data_.index] = \
2245                     ; 594 						        fifo_data[i + 3];
2247  00bf c60110        	ld	a,_gesture_data_+128
2248  00c2 5f            	clrw	x
2249  00c3 97            	ld	xl,a
2250  00c4 9096          	ldw	y,sp
2251  00c6 72a90009      	addw	y,#OFST-126
2252  00ca 1701          	ldw	(OFST-134,sp),y
2253  00cc 1686          	ldw	y,(OFST-1,sp)
2254  00ce 72f901        	addw	y,(OFST-134,sp)
2255  00d1 90f6          	ld	a,(y)
2256  00d3 d700f0        	ld	(_gesture_data_+96,x),a
2257                     ; 595 						gesture_data_.index++;
2259  00d6 725c0110      	inc	_gesture_data_+128
2260                     ; 596 						gesture_data_.total_gestures++;
2262  00da 725c0111      	inc	_gesture_data_+129
2263                     ; 586 					for( i = 0; i < bytes_read; i += 4 ) {
2265  00de 1e86          	ldw	x,(OFST-1,sp)
2266  00e0 1c0004        	addw	x,#4
2267  00e3 1f86          	ldw	(OFST-1,sp),x
2268  00e5               L316:
2271  00e5 9c            	rvf
2272  00e6 7b05          	ld	a,(OFST-130,sp)
2273  00e8 5f            	clrw	x
2274  00e9 97            	ld	xl,a
2275  00ea bf00          	ldw	c_x,x
2276  00ec 1e86          	ldw	x,(OFST-1,sp)
2277  00ee b300          	cpw	x,c_x
2278  00f0 2f88          	jrslt	L706
2279                     ; 602 					if( processGestureData() ) {
2281  00f2 cd0000        	call	_processGestureData
2283  00f5 4d            	tnz	a
2284  00f6 2704          	jreq	L716
2285                     ; 603 						if( decodeGesture() ) {
2287  00f8 cd0000        	call	_decodeGesture
2289  00fb 4d            	tnz	a
2290  00fc               L716:
2291                     ; 610 					gesture_data_.index = 0;
2293  00fc 725f0110      	clr	_gesture_data_+128
2294                     ; 611 					gesture_data_.total_gestures = 0;
2296  0100 725f0111      	clr	_gesture_data_+129
2297  0104 ac170017      	jpf	L365
2298  0108               L775:
2299                     ; 618 			decodeGesture();
2301  0108 cd0000        	call	_decodeGesture
2303                     ; 619 			motion = gesture_motion_;
2305  010b ce0080        	ldw	x,_gesture_motion_
2306  010e 1f86          	ldw	(OFST-1,sp),x
2307                     ; 620 			resetGestureParameters();
2309  0110 cd0000        	call	_resetGestureParameters
2311                     ; 621 			return motion;
2313  0113 1e86          	ldw	x,(OFST-1,sp)
2315  0115 ac330033      	jpf	L001
2339                     ; 631 uint8_t enablePower(void)
2339                     ; 632 {
2340                     .text:	section	.text,new
2341  0000               _enablePower:
2345                     ; 633 	if( !setMode(POWER, 1) ) {
2347  0000 ae0001        	ldw	x,#1
2348  0003 4f            	clr	a
2349  0004 95            	ld	xh,a
2350  0005 cd0000        	call	_setMode
2352  0008 4d            	tnz	a
2353  0009 2602          	jrne	L536
2354                     ; 634 		return 0;
2356  000b 4f            	clr	a
2359  000c 81            	ret
2360  000d               L536:
2361                     ; 637 	return 1;
2363  000d a601          	ld	a,#1
2366  000f 81            	ret
2390                     ; 645 uint8_t disablePower(void)
2390                     ; 646 {
2391                     .text:	section	.text,new
2392  0000               _disablePower:
2396                     ; 647 	if( !setMode(POWER, 0) ) {
2398  0000 5f            	clrw	x
2399  0001 4f            	clr	a
2400  0002 95            	ld	xh,a
2401  0003 cd0000        	call	_setMode
2403  0006 4d            	tnz	a
2404  0007 2602          	jrne	L746
2405                     ; 648 		return 0;
2407  0009 4f            	clr	a
2410  000a 81            	ret
2411  000b               L746:
2412                     ; 651 	return 1;
2414  000b a601          	ld	a,#1
2417  000d 81            	ret
2460                     ; 664 uint8_t readAmbientLight(uint16_t *val)
2460                     ; 665 {
2461                     .text:	section	.text,new
2462  0000               _readAmbientLight:
2464  0000 89            	pushw	x
2465  0001 88            	push	a
2466       00000001      OFST:	set	1
2469                     ; 667 	*val = 0;
2471  0002 905f          	clrw	y
2472  0004 ff            	ldw	(x),y
2473                     ; 670 	if( !wireReadDataByte(APDS9960_CDATAL, &val_byte) ) {
2475  0005 96            	ldw	x,sp
2476  0006 1c0001        	addw	x,#OFST+0
2477  0009 89            	pushw	x
2478  000a a694          	ld	a,#148
2479  000c cd0000        	call	_wireReadDataByte
2481  000f 85            	popw	x
2482  0010 4d            	tnz	a
2483  0011 2603          	jrne	L176
2484                     ; 671 		return 0;
2486  0013 4f            	clr	a
2488  0014 2017          	jra	L211
2489  0016               L176:
2490                     ; 673 	*val = val_byte;
2492  0016 7b01          	ld	a,(OFST+0,sp)
2493  0018 5f            	clrw	x
2494  0019 97            	ld	xl,a
2495  001a 1602          	ldw	y,(OFST+1,sp)
2496  001c 90ff          	ldw	(y),x
2497                     ; 676 	if( !wireReadDataByte(APDS9960_CDATAH, &val_byte) ) {
2499  001e 96            	ldw	x,sp
2500  001f 1c0001        	addw	x,#OFST+0
2501  0022 89            	pushw	x
2502  0023 a695          	ld	a,#149
2503  0025 cd0000        	call	_wireReadDataByte
2505  0028 85            	popw	x
2506  0029 4d            	tnz	a
2507  002a 2604          	jrne	L376
2508                     ; 677 		return 0;
2510  002c 4f            	clr	a
2512  002d               L211:
2514  002d 5b03          	addw	sp,#3
2515  002f 81            	ret
2516  0030               L376:
2517                     ; 679 	*val = *val + ((uint16_t)val_byte << 8);
2519  0030 1e02          	ldw	x,(OFST+1,sp)
2520  0032 7b01          	ld	a,(OFST+0,sp)
2521  0034 905f          	clrw	y
2522  0036 9097          	ld	yl,a
2523  0038 4f            	clr	a
2524  0039 9002          	rlwa	y,a
2525  003b 90bf00        	ldw	c_y,y
2526  003e 9093          	ldw	y,x
2527  0040 90fe          	ldw	y,(y)
2528  0042 72b90000      	addw	y,c_y
2529  0046 ff            	ldw	(x),y
2530                     ; 681 	return 1;
2532  0047 a601          	ld	a,#1
2534  0049 20e2          	jra	L211
2577                     ; 690 uint8_t readRedLight(uint16_t *val)
2577                     ; 691 {
2578                     .text:	section	.text,new
2579  0000               _readRedLight:
2581  0000 89            	pushw	x
2582  0001 88            	push	a
2583       00000001      OFST:	set	1
2586                     ; 693 	*val = 0;
2588  0002 905f          	clrw	y
2589  0004 ff            	ldw	(x),y
2590                     ; 696 	if( !wireReadDataByte(APDS9960_RDATAL, &val_byte) ) {
2592  0005 96            	ldw	x,sp
2593  0006 1c0001        	addw	x,#OFST+0
2594  0009 89            	pushw	x
2595  000a a696          	ld	a,#150
2596  000c cd0000        	call	_wireReadDataByte
2598  000f 85            	popw	x
2599  0010 4d            	tnz	a
2600  0011 2603          	jrne	L517
2601                     ; 697 		return 0;
2603  0013 4f            	clr	a
2605  0014 2017          	jra	L611
2606  0016               L517:
2607                     ; 699 	*val = val_byte;
2609  0016 7b01          	ld	a,(OFST+0,sp)
2610  0018 5f            	clrw	x
2611  0019 97            	ld	xl,a
2612  001a 1602          	ldw	y,(OFST+1,sp)
2613  001c 90ff          	ldw	(y),x
2614                     ; 702 	if( !wireReadDataByte(APDS9960_RDATAH, &val_byte) ) {
2616  001e 96            	ldw	x,sp
2617  001f 1c0001        	addw	x,#OFST+0
2618  0022 89            	pushw	x
2619  0023 a697          	ld	a,#151
2620  0025 cd0000        	call	_wireReadDataByte
2622  0028 85            	popw	x
2623  0029 4d            	tnz	a
2624  002a 2604          	jrne	L717
2625                     ; 703 		return 0;
2627  002c 4f            	clr	a
2629  002d               L611:
2631  002d 5b03          	addw	sp,#3
2632  002f 81            	ret
2633  0030               L717:
2634                     ; 705 	*val = *val + ((uint16_t)val_byte << 8);
2636  0030 1e02          	ldw	x,(OFST+1,sp)
2637  0032 7b01          	ld	a,(OFST+0,sp)
2638  0034 905f          	clrw	y
2639  0036 9097          	ld	yl,a
2640  0038 4f            	clr	a
2641  0039 9002          	rlwa	y,a
2642  003b 90bf00        	ldw	c_y,y
2643  003e 9093          	ldw	y,x
2644  0040 90fe          	ldw	y,(y)
2645  0042 72b90000      	addw	y,c_y
2646  0046 ff            	ldw	(x),y
2647                     ; 707 	return 1;
2649  0047 a601          	ld	a,#1
2651  0049 20e2          	jra	L611
2694                     ; 716 uint8_t readGreenLight(uint16_t *val)
2694                     ; 717 {
2695                     .text:	section	.text,new
2696  0000               _readGreenLight:
2698  0000 89            	pushw	x
2699  0001 88            	push	a
2700       00000001      OFST:	set	1
2703                     ; 719 	*val = 0;
2705  0002 905f          	clrw	y
2706  0004 ff            	ldw	(x),y
2707                     ; 722 	if( !wireReadDataByte(APDS9960_GDATAL, &val_byte) ) {
2709  0005 96            	ldw	x,sp
2710  0006 1c0001        	addw	x,#OFST+0
2711  0009 89            	pushw	x
2712  000a a698          	ld	a,#152
2713  000c cd0000        	call	_wireReadDataByte
2715  000f 85            	popw	x
2716  0010 4d            	tnz	a
2717  0011 2603          	jrne	L147
2718                     ; 723 		return 0;
2720  0013 4f            	clr	a
2722  0014 2017          	jra	L221
2723  0016               L147:
2724                     ; 725 	*val = val_byte;
2726  0016 7b01          	ld	a,(OFST+0,sp)
2727  0018 5f            	clrw	x
2728  0019 97            	ld	xl,a
2729  001a 1602          	ldw	y,(OFST+1,sp)
2730  001c 90ff          	ldw	(y),x
2731                     ; 728 	if( !wireReadDataByte(APDS9960_GDATAH, &val_byte) ) {
2733  001e 96            	ldw	x,sp
2734  001f 1c0001        	addw	x,#OFST+0
2735  0022 89            	pushw	x
2736  0023 a699          	ld	a,#153
2737  0025 cd0000        	call	_wireReadDataByte
2739  0028 85            	popw	x
2740  0029 4d            	tnz	a
2741  002a 2604          	jrne	L347
2742                     ; 729 		return 0;
2744  002c 4f            	clr	a
2746  002d               L221:
2748  002d 5b03          	addw	sp,#3
2749  002f 81            	ret
2750  0030               L347:
2751                     ; 731 	*val = *val + ((uint16_t)val_byte << 8);
2753  0030 1e02          	ldw	x,(OFST+1,sp)
2754  0032 7b01          	ld	a,(OFST+0,sp)
2755  0034 905f          	clrw	y
2756  0036 9097          	ld	yl,a
2757  0038 4f            	clr	a
2758  0039 9002          	rlwa	y,a
2759  003b 90bf00        	ldw	c_y,y
2760  003e 9093          	ldw	y,x
2761  0040 90fe          	ldw	y,(y)
2762  0042 72b90000      	addw	y,c_y
2763  0046 ff            	ldw	(x),y
2764                     ; 733 	return 1;
2766  0047 a601          	ld	a,#1
2768  0049 20e2          	jra	L221
2811                     ; 742 uint8_t readBlueLight(uint16_t *val)
2811                     ; 743 {
2812                     .text:	section	.text,new
2813  0000               _readBlueLight:
2815  0000 89            	pushw	x
2816  0001 88            	push	a
2817       00000001      OFST:	set	1
2820                     ; 745 	*val = 0;
2822  0002 905f          	clrw	y
2823  0004 ff            	ldw	(x),y
2824                     ; 748 	if( !wireReadDataByte(APDS9960_BDATAL, &val_byte) ) {
2826  0005 96            	ldw	x,sp
2827  0006 1c0001        	addw	x,#OFST+0
2828  0009 89            	pushw	x
2829  000a a69a          	ld	a,#154
2830  000c cd0000        	call	_wireReadDataByte
2832  000f 85            	popw	x
2833  0010 4d            	tnz	a
2834  0011 2603          	jrne	L567
2835                     ; 749 		return 0;
2837  0013 4f            	clr	a
2839  0014 2017          	jra	L621
2840  0016               L567:
2841                     ; 751 	*val = val_byte;
2843  0016 7b01          	ld	a,(OFST+0,sp)
2844  0018 5f            	clrw	x
2845  0019 97            	ld	xl,a
2846  001a 1602          	ldw	y,(OFST+1,sp)
2847  001c 90ff          	ldw	(y),x
2848                     ; 754 	if( !wireReadDataByte(APDS9960_BDATAH, &val_byte) ) {
2850  001e 96            	ldw	x,sp
2851  001f 1c0001        	addw	x,#OFST+0
2852  0022 89            	pushw	x
2853  0023 a69b          	ld	a,#155
2854  0025 cd0000        	call	_wireReadDataByte
2856  0028 85            	popw	x
2857  0029 4d            	tnz	a
2858  002a 2604          	jrne	L767
2859                     ; 755 		return 0;
2861  002c 4f            	clr	a
2863  002d               L621:
2865  002d 5b03          	addw	sp,#3
2866  002f 81            	ret
2867  0030               L767:
2868                     ; 757 	*val = *val + ((uint16_t)val_byte << 8);
2870  0030 1e02          	ldw	x,(OFST+1,sp)
2871  0032 7b01          	ld	a,(OFST+0,sp)
2872  0034 905f          	clrw	y
2873  0036 9097          	ld	yl,a
2874  0038 4f            	clr	a
2875  0039 9002          	rlwa	y,a
2876  003b 90bf00        	ldw	c_y,y
2877  003e 9093          	ldw	y,x
2878  0040 90fe          	ldw	y,(y)
2879  0042 72b90000      	addw	y,c_y
2880  0046 ff            	ldw	(x),y
2881                     ; 759 	return 1;
2883  0047 a601          	ld	a,#1
2885  0049 20e2          	jra	L621
2921                     ; 772 uint8_t readProximity(uint8_t *val)
2921                     ; 773 {
2922                     .text:	section	.text,new
2923  0000               _readProximity:
2927                     ; 774 	*val = 0;
2929  0000 7f            	clr	(x)
2930                     ; 777 	if( !wireReadDataByte(APDS9960_PDATA, val) ) {
2932  0001 89            	pushw	x
2933  0002 a69c          	ld	a,#156
2934  0004 cd0000        	call	_wireReadDataByte
2936  0007 85            	popw	x
2937  0008 4d            	tnz	a
2938  0009 2602          	jrne	L7001
2939                     ; 778 		return 0;
2941  000b 4f            	clr	a
2944  000c 81            	ret
2945  000d               L7001:
2946                     ; 781 	return 1;
2948  000d a601          	ld	a,#1
2951  000f 81            	ret
2984                     ; 791 void resetGestureParameters(void)
2984                     ; 792 {
2985                     .text:	section	.text,new
2986  0000               _resetGestureParameters:
2990                     ; 793 	gesture_data_.index = 0;
2992  0000 725f0110      	clr	_gesture_data_+128
2993                     ; 794 	gesture_data_.total_gestures = 0;
2995  0004 725f0111      	clr	_gesture_data_+129
2996                     ; 796 	gesture_ud_delta_ = 0;
2998  0008 5f            	clrw	x
2999  0009 cf008e        	ldw	_gesture_ud_delta_,x
3000                     ; 797 	gesture_lr_delta_ = 0;
3002  000c 5f            	clrw	x
3003  000d cf008c        	ldw	_gesture_lr_delta_,x
3004                     ; 799 	gesture_ud_count_ = 0;
3006  0010 5f            	clrw	x
3007  0011 cf008a        	ldw	_gesture_ud_count_,x
3008                     ; 800 	gesture_lr_count_ = 0;
3010  0014 5f            	clrw	x
3011  0015 cf0088        	ldw	_gesture_lr_count_,x
3012                     ; 802 	gesture_near_count_ = 0;
3014  0018 5f            	clrw	x
3015  0019 cf0086        	ldw	_gesture_near_count_,x
3016                     ; 803 	gesture_far_count_ = 0;
3018  001c 5f            	clrw	x
3019  001d cf0084        	ldw	_gesture_far_count_,x
3020                     ; 805 	gesture_state_ = 0;
3022  0020 5f            	clrw	x
3023  0021 cf0082        	ldw	_gesture_state_,x
3024                     ; 806 	gesture_motion_ = DIR_NONE;
3026  0024 5f            	clrw	x
3027  0025 cf0080        	ldw	_gesture_motion_,x
3028                     ; 807 }
3031  0028 81            	ret
3170                     ; 814 uint8_t processGestureData(void)
3170                     ; 815 {
3171                     .text:	section	.text,new
3172  0000               _processGestureData:
3174  0000 5210          	subw	sp,#16
3175       00000010      OFST:	set	16
3178                     ; 816 	uint8_t u_first = 0;
3180  0002 0f09          	clr	(OFST-7,sp)
3181                     ; 817 	uint8_t d_first = 0;
3183  0004 0f0a          	clr	(OFST-6,sp)
3184                     ; 818 	uint8_t l_first = 0;
3186  0006 0f0b          	clr	(OFST-5,sp)
3187                     ; 819 	uint8_t r_first = 0;
3189  0008 0f0c          	clr	(OFST-4,sp)
3190                     ; 820 	uint8_t u_last = 0;
3192  000a 0f05          	clr	(OFST-11,sp)
3193                     ; 821 	uint8_t d_last = 0;
3195  000c 0f06          	clr	(OFST-10,sp)
3196                     ; 822 	uint8_t l_last = 0;
3198  000e 0f07          	clr	(OFST-9,sp)
3199                     ; 823 	uint8_t r_last = 0;
3201  0010 0f08          	clr	(OFST-8,sp)
3202                     ; 833 	if( gesture_data_.total_gestures <= 4 ) {
3204  0012 c60111        	ld	a,_gesture_data_+129
3205  0015 a105          	cp	a,#5
3206  0017 2404          	jruge	L1701
3207                     ; 834 		return 0;
3209  0019 4f            	clr	a
3211  001a cc009f        	jra	L651
3212  001d               L1701:
3213                     ; 838 	if( (gesture_data_.total_gestures <= 32) && \
3213                     ; 839 	        (gesture_data_.total_gestures > 0) ) {
3215  001d c60111        	ld	a,_gesture_data_+129
3216  0020 a121          	cp	a,#33
3217  0022 2503          	jrult	L061
3218  0024 cc00fa        	jp	L3701
3219  0027               L061:
3221  0027 725d0111      	tnz	_gesture_data_+129
3222  002b 2603          	jrne	L261
3223  002d cc00fa        	jp	L3701
3224  0030               L261:
3225                     ; 842 		for( i = 0; i < gesture_data_.total_gestures; i++ ) {
3227  0030 5f            	clrw	x
3228  0031 1f0f          	ldw	(OFST-1,sp),x
3230  0033 2059          	jra	L1011
3231  0035               L5701:
3232                     ; 843 			if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
3232                     ; 844 			        (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
3232                     ; 845 			        (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
3232                     ; 846 			        (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
3234  0035 1e0f          	ldw	x,(OFST-1,sp)
3235  0037 d60090        	ld	a,(_gesture_data_,x)
3236  003a a10b          	cp	a,#11
3237  003c 2549          	jrult	L5011
3239  003e 1e0f          	ldw	x,(OFST-1,sp)
3240  0040 d600b0        	ld	a,(_gesture_data_+32,x)
3241  0043 a10b          	cp	a,#11
3242  0045 2540          	jrult	L5011
3244  0047 1e0f          	ldw	x,(OFST-1,sp)
3245  0049 d600d0        	ld	a,(_gesture_data_+64,x)
3246  004c a10b          	cp	a,#11
3247  004e 2537          	jrult	L5011
3249  0050 1e0f          	ldw	x,(OFST-1,sp)
3250  0052 d600f0        	ld	a,(_gesture_data_+96,x)
3251  0055 a10b          	cp	a,#11
3252  0057 252e          	jrult	L5011
3253                     ; 848 				u_first = gesture_data_.u_data[i];
3255  0059 1e0f          	ldw	x,(OFST-1,sp)
3256  005b d60090        	ld	a,(_gesture_data_,x)
3257  005e 6b09          	ld	(OFST-7,sp),a
3258                     ; 849 				d_first = gesture_data_.d_data[i];
3260  0060 1e0f          	ldw	x,(OFST-1,sp)
3261  0062 d600b0        	ld	a,(_gesture_data_+32,x)
3262  0065 6b0a          	ld	(OFST-6,sp),a
3263                     ; 850 				l_first = gesture_data_.l_data[i];
3265  0067 1e0f          	ldw	x,(OFST-1,sp)
3266  0069 d600d0        	ld	a,(_gesture_data_+64,x)
3267  006c 6b0b          	ld	(OFST-5,sp),a
3268                     ; 851 				r_first = gesture_data_.r_data[i];
3270  006e 1e0f          	ldw	x,(OFST-1,sp)
3271  0070 d600f0        	ld	a,(_gesture_data_+96,x)
3272  0073 6b0c          	ld	(OFST-4,sp),a
3273                     ; 852 				break;
3274  0075               L3011:
3275                     ; 857 		if( (u_first == 0) || (d_first == 0) || \
3275                     ; 858 		        (l_first == 0) || (r_first == 0) ) {
3277  0075 0d09          	tnz	(OFST-7,sp)
3278  0077 2725          	jreq	L1111
3280  0079 0d0a          	tnz	(OFST-6,sp)
3281  007b 2721          	jreq	L1111
3283  007d 0d0b          	tnz	(OFST-5,sp)
3284  007f 271d          	jreq	L1111
3286  0081 0d0c          	tnz	(OFST-4,sp)
3287  0083 261d          	jrne	L7011
3288  0085 2017          	jra	L1111
3289  0087               L5011:
3290                     ; 842 		for( i = 0; i < gesture_data_.total_gestures; i++ ) {
3292  0087 1e0f          	ldw	x,(OFST-1,sp)
3293  0089 1c0001        	addw	x,#1
3294  008c 1f0f          	ldw	(OFST-1,sp),x
3295  008e               L1011:
3298  008e 9c            	rvf
3299  008f c60111        	ld	a,_gesture_data_+129
3300  0092 5f            	clrw	x
3301  0093 97            	ld	xl,a
3302  0094 bf00          	ldw	c_x,x
3303  0096 1e0f          	ldw	x,(OFST-1,sp)
3304  0098 b300          	cpw	x,c_x
3305  009a 2f99          	jrslt	L5701
3306  009c 20d7          	jra	L3011
3307  009e               L1111:
3308                     ; 860 			return 0;
3310  009e 4f            	clr	a
3312  009f               L651:
3314  009f 5b10          	addw	sp,#16
3315  00a1 81            	ret
3316  00a2               L7011:
3317                     ; 863 		for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
3319  00a2 c60111        	ld	a,_gesture_data_+129
3320  00a5 5f            	clrw	x
3321  00a6 97            	ld	xl,a
3322  00a7 5a            	decw	x
3323  00a8 1f0f          	ldw	(OFST-1,sp),x
3325  00aa 2049          	jra	L3211
3326  00ac               L7111:
3327                     ; 875 			if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
3327                     ; 876 			        (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
3327                     ; 877 			        (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
3327                     ; 878 			        (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
3329  00ac 1e0f          	ldw	x,(OFST-1,sp)
3330  00ae d60090        	ld	a,(_gesture_data_,x)
3331  00b1 a10b          	cp	a,#11
3332  00b3 2539          	jrult	L7211
3334  00b5 1e0f          	ldw	x,(OFST-1,sp)
3335  00b7 d600b0        	ld	a,(_gesture_data_+32,x)
3336  00ba a10b          	cp	a,#11
3337  00bc 2530          	jrult	L7211
3339  00be 1e0f          	ldw	x,(OFST-1,sp)
3340  00c0 d600d0        	ld	a,(_gesture_data_+64,x)
3341  00c3 a10b          	cp	a,#11
3342  00c5 2527          	jrult	L7211
3344  00c7 1e0f          	ldw	x,(OFST-1,sp)
3345  00c9 d600f0        	ld	a,(_gesture_data_+96,x)
3346  00cc a10b          	cp	a,#11
3347  00ce 251e          	jrult	L7211
3348                     ; 880 				u_last = gesture_data_.u_data[i];
3350  00d0 1e0f          	ldw	x,(OFST-1,sp)
3351  00d2 d60090        	ld	a,(_gesture_data_,x)
3352  00d5 6b05          	ld	(OFST-11,sp),a
3353                     ; 881 				d_last = gesture_data_.d_data[i];
3355  00d7 1e0f          	ldw	x,(OFST-1,sp)
3356  00d9 d600b0        	ld	a,(_gesture_data_+32,x)
3357  00dc 6b06          	ld	(OFST-10,sp),a
3358                     ; 882 				l_last = gesture_data_.l_data[i];
3360  00de 1e0f          	ldw	x,(OFST-1,sp)
3361  00e0 d600d0        	ld	a,(_gesture_data_+64,x)
3362  00e3 6b07          	ld	(OFST-9,sp),a
3363                     ; 883 				r_last = gesture_data_.r_data[i];
3365  00e5 1e0f          	ldw	x,(OFST-1,sp)
3366  00e7 d600f0        	ld	a,(_gesture_data_+96,x)
3367  00ea 6b08          	ld	(OFST-8,sp),a
3368                     ; 884 				break;
3370  00ec 200c          	jra	L3701
3371  00ee               L7211:
3372                     ; 863 		for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
3374  00ee 1e0f          	ldw	x,(OFST-1,sp)
3375  00f0 1d0001        	subw	x,#1
3376  00f3 1f0f          	ldw	(OFST-1,sp),x
3377  00f5               L3211:
3380  00f5 9c            	rvf
3381  00f6 1e0f          	ldw	x,(OFST-1,sp)
3382  00f8 2eb2          	jrsge	L7111
3383  00fa               L3701:
3384                     ; 890 	ud_ratio_first = ((u_first - d_first) * 100) / (u_first + d_first);
3386  00fa 7b09          	ld	a,(OFST-7,sp)
3387  00fc 5f            	clrw	x
3388  00fd 100a          	sub	a,(OFST-6,sp)
3389  00ff 2401          	jrnc	L631
3390  0101 5a            	decw	x
3391  0102               L631:
3392  0102 02            	rlwa	x,a
3393  0103 90ae0064      	ldw	y,#100
3394  0107 cd0000        	call	c_imul
3396  010a 89            	pushw	x
3397  010b 7b0b          	ld	a,(OFST-5,sp)
3398  010d 5f            	clrw	x
3399  010e 1b0c          	add	a,(OFST-4,sp)
3400  0110 2401          	jrnc	L041
3401  0112 5c            	incw	x
3402  0113               L041:
3403  0113 02            	rlwa	x,a
3404  0114 9085          	popw	y
3405  0116 51            	exgw	x,y
3406  0117 cd0000        	call	c_idiv
3408  011a 51            	exgw	x,y
3409  011b 1701          	ldw	(OFST-15,sp),y
3410                     ; 891 	lr_ratio_first = ((l_first - r_first) * 100) / (l_first + r_first);
3412  011d 7b0b          	ld	a,(OFST-5,sp)
3413  011f 5f            	clrw	x
3414  0120 100c          	sub	a,(OFST-4,sp)
3415  0122 2401          	jrnc	L241
3416  0124 5a            	decw	x
3417  0125               L241:
3418  0125 02            	rlwa	x,a
3419  0126 90ae0064      	ldw	y,#100
3420  012a cd0000        	call	c_imul
3422  012d 89            	pushw	x
3423  012e 7b0d          	ld	a,(OFST-3,sp)
3424  0130 5f            	clrw	x
3425  0131 1b0e          	add	a,(OFST-2,sp)
3426  0133 2401          	jrnc	L441
3427  0135 5c            	incw	x
3428  0136               L441:
3429  0136 02            	rlwa	x,a
3430  0137 9085          	popw	y
3431  0139 51            	exgw	x,y
3432  013a cd0000        	call	c_idiv
3434  013d 51            	exgw	x,y
3435  013e 1703          	ldw	(OFST-13,sp),y
3436                     ; 892 	ud_ratio_last = ((u_last - d_last) * 100) / (u_last + d_last);
3438  0140 7b05          	ld	a,(OFST-11,sp)
3439  0142 5f            	clrw	x
3440  0143 1006          	sub	a,(OFST-10,sp)
3441  0145 2401          	jrnc	L641
3442  0147 5a            	decw	x
3443  0148               L641:
3444  0148 02            	rlwa	x,a
3445  0149 90ae0064      	ldw	y,#100
3446  014d cd0000        	call	c_imul
3448  0150 89            	pushw	x
3449  0151 7b07          	ld	a,(OFST-9,sp)
3450  0153 5f            	clrw	x
3451  0154 1b08          	add	a,(OFST-8,sp)
3452  0156 2401          	jrnc	L051
3453  0158 5c            	incw	x
3454  0159               L051:
3455  0159 02            	rlwa	x,a
3456  015a 9085          	popw	y
3457  015c 51            	exgw	x,y
3458  015d cd0000        	call	c_idiv
3460  0160 51            	exgw	x,y
3461  0161 170d          	ldw	(OFST-3,sp),y
3462                     ; 893 	lr_ratio_last = ((l_last - r_last) * 100) / (l_last + r_last);
3464  0163 7b07          	ld	a,(OFST-9,sp)
3465  0165 5f            	clrw	x
3466  0166 1008          	sub	a,(OFST-8,sp)
3467  0168 2401          	jrnc	L251
3468  016a 5a            	decw	x
3469  016b               L251:
3470  016b 02            	rlwa	x,a
3471  016c 90ae0064      	ldw	y,#100
3472  0170 cd0000        	call	c_imul
3474  0173 89            	pushw	x
3475  0174 7b09          	ld	a,(OFST-7,sp)
3476  0176 5f            	clrw	x
3477  0177 1b0a          	add	a,(OFST-6,sp)
3478  0179 2401          	jrnc	L451
3479  017b 5c            	incw	x
3480  017c               L451:
3481  017c 02            	rlwa	x,a
3482  017d 9085          	popw	y
3483  017f 51            	exgw	x,y
3484  0180 cd0000        	call	c_idiv
3486  0183 51            	exgw	x,y
3487  0184 170f          	ldw	(OFST-1,sp),y
3488                     ; 918 	ud_delta = ud_ratio_last - ud_ratio_first;
3490  0186 1e0d          	ldw	x,(OFST-3,sp)
3491  0188 72f001        	subw	x,(OFST-15,sp)
3492  018b 1f0d          	ldw	(OFST-3,sp),x
3493                     ; 919 	lr_delta = lr_ratio_last - lr_ratio_first;
3495  018d 1e0f          	ldw	x,(OFST-1,sp)
3496  018f 72f003        	subw	x,(OFST-13,sp)
3497  0192 1f0f          	ldw	(OFST-1,sp),x
3498                     ; 930 	gesture_ud_delta_ += ud_delta;
3500  0194 ce008e        	ldw	x,_gesture_ud_delta_
3501  0197 72fb0d        	addw	x,(OFST-3,sp)
3502  019a cf008e        	ldw	_gesture_ud_delta_,x
3503                     ; 931 	gesture_lr_delta_ += lr_delta;
3505  019d ce008c        	ldw	x,_gesture_lr_delta_
3506  01a0 72fb0f        	addw	x,(OFST-1,sp)
3507  01a3 cf008c        	ldw	_gesture_lr_delta_,x
3508                     ; 942 	if( gesture_ud_delta_ >= GESTURE_SENSITIVITY_1 ) {
3510  01a6 9c            	rvf
3511  01a7 ce008e        	ldw	x,_gesture_ud_delta_
3512  01aa a30032        	cpw	x,#50
3513  01ad 2f08          	jrslt	L1311
3514                     ; 943 		gesture_ud_count_ = 1;
3516  01af ae0001        	ldw	x,#1
3517  01b2 cf008a        	ldw	_gesture_ud_count_,x
3519  01b5 2015          	jra	L3311
3520  01b7               L1311:
3521                     ; 944 	} else if( gesture_ud_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3523  01b7 9c            	rvf
3524  01b8 ce008e        	ldw	x,_gesture_ud_delta_
3525  01bb a3ffcf        	cpw	x,#65487
3526  01be 2e08          	jrsge	L5311
3527                     ; 945 		gesture_ud_count_ = -1;
3529  01c0 aeffff        	ldw	x,#65535
3530  01c3 cf008a        	ldw	_gesture_ud_count_,x
3532  01c6 2004          	jra	L3311
3533  01c8               L5311:
3534                     ; 947 		gesture_ud_count_ = 0;
3536  01c8 5f            	clrw	x
3537  01c9 cf008a        	ldw	_gesture_ud_count_,x
3538  01cc               L3311:
3539                     ; 951 	if( gesture_lr_delta_ >= GESTURE_SENSITIVITY_1 ) {
3541  01cc 9c            	rvf
3542  01cd ce008c        	ldw	x,_gesture_lr_delta_
3543  01d0 a30032        	cpw	x,#50
3544  01d3 2f08          	jrslt	L1411
3545                     ; 952 		gesture_lr_count_ = 1;
3547  01d5 ae0001        	ldw	x,#1
3548  01d8 cf0088        	ldw	_gesture_lr_count_,x
3550  01db 2015          	jra	L3411
3551  01dd               L1411:
3552                     ; 953 	} else if( gesture_lr_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3554  01dd 9c            	rvf
3555  01de ce008c        	ldw	x,_gesture_lr_delta_
3556  01e1 a3ffcf        	cpw	x,#65487
3557  01e4 2e08          	jrsge	L5411
3558                     ; 954 		gesture_lr_count_ = -1;
3560  01e6 aeffff        	ldw	x,#65535
3561  01e9 cf0088        	ldw	_gesture_lr_count_,x
3563  01ec 2004          	jra	L3411
3564  01ee               L5411:
3565                     ; 956 		gesture_lr_count_ = 0;
3567  01ee 5f            	clrw	x
3568  01ef cf0088        	ldw	_gesture_lr_count_,x
3569  01f2               L3411:
3570                     ; 960 	if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 0) ) {
3572  01f2 ce008a        	ldw	x,_gesture_ud_count_
3573  01f5 267b          	jrne	L1511
3575  01f7 ce0088        	ldw	x,_gesture_lr_count_
3576  01fa 2676          	jrne	L1511
3577                     ; 961 		if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
3577                     ; 962 		        (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {
3579  01fc 9c            	rvf
3580  01fd 1e0d          	ldw	x,(OFST-3,sp)
3581  01ff cd0000        	call	_abs
3583  0202 a30014        	cpw	x,#20
3584  0205 2f03          	jrslt	L461
3585  0207 cc02b2        	jp	L5711
3586  020a               L461:
3588  020a 9c            	rvf
3589  020b 1e0f          	ldw	x,(OFST-1,sp)
3590  020d cd0000        	call	_abs
3592  0210 a30014        	cpw	x,#20
3593  0213 2f03          	jrslt	L661
3594  0215 cc02b2        	jp	L5711
3595  0218               L661:
3596                     ; 964 			if( (ud_delta == 0) && (lr_delta == 0) ) {
3598  0218 1e0d          	ldw	x,(OFST-3,sp)
3599  021a 260f          	jrne	L5511
3601  021c 1e0f          	ldw	x,(OFST-1,sp)
3602  021e 260b          	jrne	L5511
3603                     ; 965 				gesture_near_count_++;
3605  0220 ce0086        	ldw	x,_gesture_near_count_
3606  0223 1c0001        	addw	x,#1
3607  0226 cf0086        	ldw	_gesture_near_count_,x
3609  0229 2011          	jra	L7511
3610  022b               L5511:
3611                     ; 966 			} else if( (ud_delta != 0) || (lr_delta != 0) ) {
3613  022b 1e0d          	ldw	x,(OFST-3,sp)
3614  022d 2604          	jrne	L3611
3616  022f 1e0f          	ldw	x,(OFST-1,sp)
3617  0231 2709          	jreq	L7511
3618  0233               L3611:
3619                     ; 967 				gesture_far_count_++;
3621  0233 ce0084        	ldw	x,_gesture_far_count_
3622  0236 1c0001        	addw	x,#1
3623  0239 cf0084        	ldw	_gesture_far_count_,x
3624  023c               L7511:
3625                     ; 970 			if( (gesture_near_count_ >= 10) && (gesture_far_count_ >= 2) ) {
3627  023c 9c            	rvf
3628  023d ce0086        	ldw	x,_gesture_near_count_
3629  0240 a3000a        	cpw	x,#10
3630  0243 2f6d          	jrslt	L5711
3632  0245 9c            	rvf
3633  0246 ce0084        	ldw	x,_gesture_far_count_
3634  0249 a30002        	cpw	x,#2
3635  024c 2f64          	jrslt	L5711
3636                     ; 971 				if( (ud_delta == 0) && (lr_delta == 0) ) {
3638  024e 1e0d          	ldw	x,(OFST-3,sp)
3639  0250 260c          	jrne	L7611
3641  0252 1e0f          	ldw	x,(OFST-1,sp)
3642  0254 2608          	jrne	L7611
3643                     ; 972 					gesture_state_ = NEAR_STATE;
3645  0256 ae0001        	ldw	x,#1
3646  0259 cf0082        	ldw	_gesture_state_,x
3648  025c 200e          	jra	L1711
3649  025e               L7611:
3650                     ; 973 				} else if( (ud_delta != 0) && (lr_delta != 0) ) {
3652  025e 1e0d          	ldw	x,(OFST-3,sp)
3653  0260 270a          	jreq	L1711
3655  0262 1e0f          	ldw	x,(OFST-1,sp)
3656  0264 2706          	jreq	L1711
3657                     ; 974 					gesture_state_ = FAR_STATE;
3659  0266 ae0002        	ldw	x,#2
3660  0269 cf0082        	ldw	_gesture_state_,x
3661  026c               L1711:
3662                     ; 976 				return 1;
3664  026c a601          	ld	a,#1
3666  026e ac9f009f      	jpf	L651
3667  0272               L1511:
3668                     ; 980 		if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
3668                     ; 981 		        (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {
3670  0272 9c            	rvf
3671  0273 1e0d          	ldw	x,(OFST-3,sp)
3672  0275 cd0000        	call	_abs
3674  0278 a30014        	cpw	x,#20
3675  027b 2e35          	jrsge	L5711
3677  027d 9c            	rvf
3678  027e 1e0f          	ldw	x,(OFST-1,sp)
3679  0280 cd0000        	call	_abs
3681  0283 a30014        	cpw	x,#20
3682  0286 2e2a          	jrsge	L5711
3683                     ; 983 			if( (ud_delta == 0) && (lr_delta == 0) ) {
3685  0288 1e0d          	ldw	x,(OFST-3,sp)
3686  028a 260d          	jrne	L1021
3688  028c 1e0f          	ldw	x,(OFST-1,sp)
3689  028e 2609          	jrne	L1021
3690                     ; 984 				gesture_near_count_++;
3692  0290 ce0086        	ldw	x,_gesture_near_count_
3693  0293 1c0001        	addw	x,#1
3694  0296 cf0086        	ldw	_gesture_near_count_,x
3695  0299               L1021:
3696                     ; 987 			if( gesture_near_count_ >= 10 ) {
3698  0299 9c            	rvf
3699  029a ce0086        	ldw	x,_gesture_near_count_
3700  029d a3000a        	cpw	x,#10
3701  02a0 2f10          	jrslt	L5711
3702                     ; 988 				gesture_ud_count_ = 0;
3704  02a2 5f            	clrw	x
3705  02a3 cf008a        	ldw	_gesture_ud_count_,x
3706                     ; 989 				gesture_lr_count_ = 0;
3708  02a6 5f            	clrw	x
3709  02a7 cf0088        	ldw	_gesture_lr_count_,x
3710                     ; 990 				gesture_ud_delta_ = 0;
3712  02aa 5f            	clrw	x
3713  02ab cf008e        	ldw	_gesture_ud_delta_,x
3714                     ; 991 				gesture_lr_delta_ = 0;
3716  02ae 5f            	clrw	x
3717  02af cf008c        	ldw	_gesture_lr_delta_,x
3718  02b2               L5711:
3719                     ; 1008 	return 0;
3721  02b2 4f            	clr	a
3723  02b3 ac9f009f      	jpf	L651
3753                     ; 1016 uint8_t decodeGesture(void)
3753                     ; 1017 {
3754                     .text:	section	.text,new
3755  0000               _decodeGesture:
3757  0000 89            	pushw	x
3758       00000002      OFST:	set	2
3761                     ; 1019 	if( gesture_state_ == NEAR_STATE ) {
3763  0001 ce0082        	ldw	x,_gesture_state_
3764  0004 a30001        	cpw	x,#1
3765  0007 260a          	jrne	L5121
3766                     ; 1020 		gesture_motion_ = DIR_NEAR;
3768  0009 ae0005        	ldw	x,#5
3769  000c cf0080        	ldw	_gesture_motion_,x
3770                     ; 1021 		return 1;
3772  000f a601          	ld	a,#1
3774  0011 2010          	jra	L271
3775  0013               L5121:
3776                     ; 1022 	} else if ( gesture_state_ == FAR_STATE ) {
3778  0013 ce0082        	ldw	x,_gesture_state_
3779  0016 a30002        	cpw	x,#2
3780  0019 260a          	jrne	L7121
3781                     ; 1023 		gesture_motion_ = DIR_FAR;
3783  001b ae0006        	ldw	x,#6
3784  001e cf0080        	ldw	_gesture_motion_,x
3785                     ; 1024 		return 1;
3787  0021 a601          	ld	a,#1
3789  0023               L271:
3791  0023 85            	popw	x
3792  0024 81            	ret
3793  0025               L7121:
3794                     ; 1028 	if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 0) ) {
3796  0025 ce008a        	ldw	x,_gesture_ud_count_
3797  0028 a3ffff        	cpw	x,#65535
3798  002b 260f          	jrne	L3221
3800  002d ce0088        	ldw	x,_gesture_lr_count_
3801  0030 260a          	jrne	L3221
3802                     ; 1029 		gesture_motion_ = DIR_UP;
3804  0032 ae0003        	ldw	x,#3
3805  0035 cf0080        	ldw	_gesture_motion_,x
3807  0038 ac4f014f      	jpf	L5221
3808  003c               L3221:
3809                     ; 1030 	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 0) ) {
3811  003c ce008a        	ldw	x,_gesture_ud_count_
3812  003f a30001        	cpw	x,#1
3813  0042 260f          	jrne	L7221
3815  0044 ce0088        	ldw	x,_gesture_lr_count_
3816  0047 260a          	jrne	L7221
3817                     ; 1031 		gesture_motion_ = DIR_DOWN;
3819  0049 ae0004        	ldw	x,#4
3820  004c cf0080        	ldw	_gesture_motion_,x
3822  004f ac4f014f      	jpf	L5221
3823  0053               L7221:
3824                     ; 1032 	} else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 1) ) {
3826  0053 ce008a        	ldw	x,_gesture_ud_count_
3827  0056 2612          	jrne	L3321
3829  0058 ce0088        	ldw	x,_gesture_lr_count_
3830  005b a30001        	cpw	x,#1
3831  005e 260a          	jrne	L3321
3832                     ; 1033 		gesture_motion_ = DIR_RIGHT;
3834  0060 ae0002        	ldw	x,#2
3835  0063 cf0080        	ldw	_gesture_motion_,x
3837  0066 ac4f014f      	jpf	L5221
3838  006a               L3321:
3839                     ; 1034 	} else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == -1) ) {
3841  006a ce008a        	ldw	x,_gesture_ud_count_
3842  006d 2612          	jrne	L7321
3844  006f ce0088        	ldw	x,_gesture_lr_count_
3845  0072 a3ffff        	cpw	x,#65535
3846  0075 260a          	jrne	L7321
3847                     ; 1035 		gesture_motion_ = DIR_LEFT;
3849  0077 ae0001        	ldw	x,#1
3850  007a cf0080        	ldw	_gesture_motion_,x
3852  007d ac4f014f      	jpf	L5221
3853  0081               L7321:
3854                     ; 1036 	} else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 1) ) {
3856  0081 ce008a        	ldw	x,_gesture_ud_count_
3857  0084 a3ffff        	cpw	x,#65535
3858  0087 262f          	jrne	L3421
3860  0089 ce0088        	ldw	x,_gesture_lr_count_
3861  008c a30001        	cpw	x,#1
3862  008f 2627          	jrne	L3421
3863                     ; 1037 		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3865  0091 9c            	rvf
3866  0092 ce008c        	ldw	x,_gesture_lr_delta_
3867  0095 cd0000        	call	_abs
3869  0098 1f01          	ldw	(OFST-1,sp),x
3870  009a ce008e        	ldw	x,_gesture_ud_delta_
3871  009d cd0000        	call	_abs
3873  00a0 1301          	cpw	x,(OFST-1,sp)
3874  00a2 2d0a          	jrsle	L5421
3875                     ; 1038 			gesture_motion_ = DIR_UP;
3877  00a4 ae0003        	ldw	x,#3
3878  00a7 cf0080        	ldw	_gesture_motion_,x
3880  00aa ac4f014f      	jpf	L5221
3881  00ae               L5421:
3882                     ; 1040 			gesture_motion_ = DIR_RIGHT;
3884  00ae ae0002        	ldw	x,#2
3885  00b1 cf0080        	ldw	_gesture_motion_,x
3886  00b4 ac4f014f      	jpf	L5221
3887  00b8               L3421:
3888                     ; 1042 	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == -1) ) {
3890  00b8 ce008a        	ldw	x,_gesture_ud_count_
3891  00bb a30001        	cpw	x,#1
3892  00be 262b          	jrne	L3521
3894  00c0 ce0088        	ldw	x,_gesture_lr_count_
3895  00c3 a3ffff        	cpw	x,#65535
3896  00c6 2623          	jrne	L3521
3897                     ; 1043 		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3899  00c8 9c            	rvf
3900  00c9 ce008c        	ldw	x,_gesture_lr_delta_
3901  00cc cd0000        	call	_abs
3903  00cf 1f01          	ldw	(OFST-1,sp),x
3904  00d1 ce008e        	ldw	x,_gesture_ud_delta_
3905  00d4 cd0000        	call	_abs
3907  00d7 1301          	cpw	x,(OFST-1,sp)
3908  00d9 2d08          	jrsle	L5521
3909                     ; 1044 			gesture_motion_ = DIR_DOWN;
3911  00db ae0004        	ldw	x,#4
3912  00de cf0080        	ldw	_gesture_motion_,x
3914  00e1 206c          	jra	L5221
3915  00e3               L5521:
3916                     ; 1046 			gesture_motion_ = DIR_LEFT;
3918  00e3 ae0001        	ldw	x,#1
3919  00e6 cf0080        	ldw	_gesture_motion_,x
3920  00e9 2064          	jra	L5221
3921  00eb               L3521:
3922                     ; 1048 	} else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == -1) ) {
3924  00eb ce008a        	ldw	x,_gesture_ud_count_
3925  00ee a3ffff        	cpw	x,#65535
3926  00f1 262b          	jrne	L3621
3928  00f3 ce0088        	ldw	x,_gesture_lr_count_
3929  00f6 a3ffff        	cpw	x,#65535
3930  00f9 2623          	jrne	L3621
3931                     ; 1049 		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3933  00fb 9c            	rvf
3934  00fc ce008c        	ldw	x,_gesture_lr_delta_
3935  00ff cd0000        	call	_abs
3937  0102 1f01          	ldw	(OFST-1,sp),x
3938  0104 ce008e        	ldw	x,_gesture_ud_delta_
3939  0107 cd0000        	call	_abs
3941  010a 1301          	cpw	x,(OFST-1,sp)
3942  010c 2d08          	jrsle	L5621
3943                     ; 1050 			gesture_motion_ = DIR_UP;
3945  010e ae0003        	ldw	x,#3
3946  0111 cf0080        	ldw	_gesture_motion_,x
3948  0114 2039          	jra	L5221
3949  0116               L5621:
3950                     ; 1052 			gesture_motion_ = DIR_LEFT;
3952  0116 ae0001        	ldw	x,#1
3953  0119 cf0080        	ldw	_gesture_motion_,x
3954  011c 2031          	jra	L5221
3955  011e               L3621:
3956                     ; 1054 	} else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 1) ) {
3958  011e ce008a        	ldw	x,_gesture_ud_count_
3959  0121 a30001        	cpw	x,#1
3960  0124 262d          	jrne	L3721
3962  0126 ce0088        	ldw	x,_gesture_lr_count_
3963  0129 a30001        	cpw	x,#1
3964  012c 2625          	jrne	L3721
3965                     ; 1055 		if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3967  012e 9c            	rvf
3968  012f ce008c        	ldw	x,_gesture_lr_delta_
3969  0132 cd0000        	call	_abs
3971  0135 1f01          	ldw	(OFST-1,sp),x
3972  0137 ce008e        	ldw	x,_gesture_ud_delta_
3973  013a cd0000        	call	_abs
3975  013d 1301          	cpw	x,(OFST-1,sp)
3976  013f 2d08          	jrsle	L5721
3977                     ; 1056 			gesture_motion_ = DIR_DOWN;
3979  0141 ae0004        	ldw	x,#4
3980  0144 cf0080        	ldw	_gesture_motion_,x
3982  0147 2006          	jra	L5221
3983  0149               L5721:
3984                     ; 1058 			gesture_motion_ = DIR_RIGHT;
3986  0149 ae0002        	ldw	x,#2
3987  014c cf0080        	ldw	_gesture_motion_,x
3988  014f               L5221:
3989                     ; 1064 	return 1;
3991  014f a601          	ld	a,#1
3993  0151 2001          	jra	L471
3994  0153               L3721:
3995                     ; 1061 		return 0;
3997  0153 4f            	clr	a
3999  0154               L471:
4001  0154 85            	popw	x
4002  0155 81            	ret
4036                     ; 1076 uint8_t getProxIntLowThresh(void)
4036                     ; 1077 {
4037                     .text:	section	.text,new
4038  0000               _getProxIntLowThresh:
4040  0000 88            	push	a
4041       00000001      OFST:	set	1
4044                     ; 1081 	if( !wireReadDataByte(APDS9960_PILT, &val) ) {
4046  0001 96            	ldw	x,sp
4047  0002 1c0001        	addw	x,#OFST+0
4048  0005 89            	pushw	x
4049  0006 a689          	ld	a,#137
4050  0008 cd0000        	call	_wireReadDataByte
4052  000b 85            	popw	x
4053  000c 4d            	tnz	a
4054  000d 2602          	jrne	L7131
4055                     ; 1082 		val = 0;
4057  000f 0f01          	clr	(OFST+0,sp)
4058  0011               L7131:
4059                     ; 1085 	return val;
4061  0011 7b01          	ld	a,(OFST+0,sp)
4064  0013 5b01          	addw	sp,#1
4065  0015 81            	ret
4099                     ; 1094 uint8_t setProxIntLowThresh(uint8_t threshold)
4099                     ; 1095 {
4100                     .text:	section	.text,new
4101  0000               _setProxIntLowThresh:
4105                     ; 1096 	if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
4107  0000 97            	ld	xl,a
4108  0001 a689          	ld	a,#137
4109  0003 95            	ld	xh,a
4110  0004 cd0000        	call	_wireWriteDataByte
4112  0007 4d            	tnz	a
4113  0008 2602          	jrne	L5331
4114                     ; 1097 		return 0;
4116  000a 4f            	clr	a
4119  000b 81            	ret
4120  000c               L5331:
4121                     ; 1100 	return 1;
4123  000c a601          	ld	a,#1
4126  000e 81            	ret
4160                     ; 1108 uint8_t getProxIntHighThresh(void)
4160                     ; 1109 {
4161                     .text:	section	.text,new
4162  0000               _getProxIntHighThresh:
4164  0000 88            	push	a
4165       00000001      OFST:	set	1
4168                     ; 1113 	if( !wireReadDataByte(APDS9960_PIHT, &val) ) {
4170  0001 96            	ldw	x,sp
4171  0002 1c0001        	addw	x,#OFST+0
4172  0005 89            	pushw	x
4173  0006 a68b          	ld	a,#139
4174  0008 cd0000        	call	_wireReadDataByte
4176  000b 85            	popw	x
4177  000c 4d            	tnz	a
4178  000d 2602          	jrne	L3531
4179                     ; 1114 		val = 0;
4181  000f 0f01          	clr	(OFST+0,sp)
4182  0011               L3531:
4183                     ; 1117 	return val;
4185  0011 7b01          	ld	a,(OFST+0,sp)
4188  0013 5b01          	addw	sp,#1
4189  0015 81            	ret
4223                     ; 1126 uint8_t setProxIntHighThresh(uint8_t threshold)
4223                     ; 1127 {
4224                     .text:	section	.text,new
4225  0000               _setProxIntHighThresh:
4229                     ; 1128 	if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
4231  0000 97            	ld	xl,a
4232  0001 a68b          	ld	a,#139
4233  0003 95            	ld	xh,a
4234  0004 cd0000        	call	_wireWriteDataByte
4236  0007 4d            	tnz	a
4237  0008 2602          	jrne	L1731
4238                     ; 1129 		return 0;
4240  000a 4f            	clr	a
4243  000b 81            	ret
4244  000c               L1731:
4245                     ; 1132 	return 1;
4247  000c a601          	ld	a,#1
4250  000e 81            	ret
4283                     ; 1146 uint8_t getLEDDrive(void)
4283                     ; 1147 {
4284                     .text:	section	.text,new
4285  0000               _getLEDDrive:
4287  0000 88            	push	a
4288       00000001      OFST:	set	1
4291                     ; 1151 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4293  0001 96            	ldw	x,sp
4294  0002 1c0001        	addw	x,#OFST+0
4295  0005 89            	pushw	x
4296  0006 a68f          	ld	a,#143
4297  0008 cd0000        	call	_wireReadDataByte
4299  000b 85            	popw	x
4300  000c 4d            	tnz	a
4301  000d 2605          	jrne	L7041
4302                     ; 1152 		return APDS9960_ERROR;
4304  000f a6ff          	ld	a,#255
4307  0011 5b01          	addw	sp,#1
4308  0013 81            	ret
4309  0014               L7041:
4310                     ; 1156 	val = (val >> 6) & 0b00000011;
4312  0014 7b01          	ld	a,(OFST+0,sp)
4313  0016 4e            	swap	a
4314  0017 44            	srl	a
4315  0018 44            	srl	a
4316  0019 a403          	and	a,#3
4317  001b a403          	and	a,#3
4318  001d 6b01          	ld	(OFST+0,sp),a
4319                     ; 1158 	return val;
4321  001f 7b01          	ld	a,(OFST+0,sp)
4324  0021 5b01          	addw	sp,#1
4325  0023 81            	ret
4366                     ; 1173 uint8_t setLEDDrive(uint8_t drive)
4366                     ; 1174 {
4367                     .text:	section	.text,new
4368  0000               _setLEDDrive:
4370  0000 88            	push	a
4371  0001 88            	push	a
4372       00000001      OFST:	set	1
4375                     ; 1178 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4377  0002 96            	ldw	x,sp
4378  0003 1c0001        	addw	x,#OFST+0
4379  0006 89            	pushw	x
4380  0007 a68f          	ld	a,#143
4381  0009 cd0000        	call	_wireReadDataByte
4383  000c 85            	popw	x
4384  000d 4d            	tnz	a
4385  000e 2603          	jrne	L7241
4386                     ; 1179 		return 0;
4388  0010 4f            	clr	a
4390  0011 2028          	jra	L212
4391  0013               L7241:
4392                     ; 1183 	drive &= 0b00000011;
4394  0013 7b02          	ld	a,(OFST+1,sp)
4395  0015 a403          	and	a,#3
4396  0017 6b02          	ld	(OFST+1,sp),a
4397                     ; 1184 	drive = drive << 6;
4399  0019 7b02          	ld	a,(OFST+1,sp)
4400  001b 4e            	swap	a
4401  001c 48            	sll	a
4402  001d 48            	sll	a
4403  001e a4c0          	and	a,#192
4404  0020 6b02          	ld	(OFST+1,sp),a
4405                     ; 1185 	val &= 0b00111111;
4407  0022 7b01          	ld	a,(OFST+0,sp)
4408  0024 a43f          	and	a,#63
4409  0026 6b01          	ld	(OFST+0,sp),a
4410                     ; 1186 	val |= drive;
4412  0028 7b01          	ld	a,(OFST+0,sp)
4413  002a 1a02          	or	a,(OFST+1,sp)
4414  002c 6b01          	ld	(OFST+0,sp),a
4415                     ; 1189 	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4417  002e 7b01          	ld	a,(OFST+0,sp)
4418  0030 97            	ld	xl,a
4419  0031 a68f          	ld	a,#143
4420  0033 95            	ld	xh,a
4421  0034 cd0000        	call	_wireWriteDataByte
4423  0037 4d            	tnz	a
4424  0038 2603          	jrne	L1341
4425                     ; 1190 		return 0;
4427  003a 4f            	clr	a
4429  003b               L212:
4431  003b 85            	popw	x
4432  003c 81            	ret
4433  003d               L1341:
4434                     ; 1193 	return 1;
4436  003d a601          	ld	a,#1
4438  003f 20fa          	jra	L212
4471                     ; 1207 uint8_t getProximityGain(void)
4471                     ; 1208 {
4472                     .text:	section	.text,new
4473  0000               _getProximityGain:
4475  0000 88            	push	a
4476       00000001      OFST:	set	1
4479                     ; 1212 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4481  0001 96            	ldw	x,sp
4482  0002 1c0001        	addw	x,#OFST+0
4483  0005 89            	pushw	x
4484  0006 a68f          	ld	a,#143
4485  0008 cd0000        	call	_wireReadDataByte
4487  000b 85            	popw	x
4488  000c 4d            	tnz	a
4489  000d 2605          	jrne	L7441
4490                     ; 1213 		return APDS9960_ERROR;
4492  000f a6ff          	ld	a,#255
4495  0011 5b01          	addw	sp,#1
4496  0013 81            	ret
4497  0014               L7441:
4498                     ; 1217 	val = (val >> 2) & 0b00000011;
4500  0014 7b01          	ld	a,(OFST+0,sp)
4501  0016 44            	srl	a
4502  0017 44            	srl	a
4503  0018 a403          	and	a,#3
4504  001a 6b01          	ld	(OFST+0,sp),a
4505                     ; 1219 	return val;
4507  001c 7b01          	ld	a,(OFST+0,sp)
4510  001e 5b01          	addw	sp,#1
4511  0020 81            	ret
4552                     ; 1234 uint8_t setProximityGain(uint8_t drive)
4552                     ; 1235 {
4553                     .text:	section	.text,new
4554  0000               _setProximityGain:
4556  0000 88            	push	a
4557  0001 88            	push	a
4558       00000001      OFST:	set	1
4561                     ; 1239 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4563  0002 96            	ldw	x,sp
4564  0003 1c0001        	addw	x,#OFST+0
4565  0006 89            	pushw	x
4566  0007 a68f          	ld	a,#143
4567  0009 cd0000        	call	_wireReadDataByte
4569  000c 85            	popw	x
4570  000d 4d            	tnz	a
4571  000e 2603          	jrne	L7641
4572                     ; 1240 		return 0;
4574  0010 4f            	clr	a
4576  0011 2023          	jra	L022
4577  0013               L7641:
4578                     ; 1244 	drive &= 0b00000011;
4580  0013 7b02          	ld	a,(OFST+1,sp)
4581  0015 a403          	and	a,#3
4582  0017 6b02          	ld	(OFST+1,sp),a
4583                     ; 1245 	drive = drive << 2;
4585  0019 0802          	sll	(OFST+1,sp)
4586  001b 0802          	sll	(OFST+1,sp)
4587                     ; 1246 	val &= 0b11110011;
4589  001d 7b01          	ld	a,(OFST+0,sp)
4590  001f a4f3          	and	a,#243
4591  0021 6b01          	ld	(OFST+0,sp),a
4592                     ; 1247 	val |= drive;
4594  0023 7b01          	ld	a,(OFST+0,sp)
4595  0025 1a02          	or	a,(OFST+1,sp)
4596  0027 6b01          	ld	(OFST+0,sp),a
4597                     ; 1250 	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4599  0029 7b01          	ld	a,(OFST+0,sp)
4600  002b 97            	ld	xl,a
4601  002c a68f          	ld	a,#143
4602  002e 95            	ld	xh,a
4603  002f cd0000        	call	_wireWriteDataByte
4605  0032 4d            	tnz	a
4606  0033 2603          	jrne	L1741
4607                     ; 1251 		return 0;
4609  0035 4f            	clr	a
4611  0036               L022:
4613  0036 85            	popw	x
4614  0037 81            	ret
4615  0038               L1741:
4616                     ; 1254 	return 1;
4618  0038 a601          	ld	a,#1
4620  003a 20fa          	jra	L022
4654                     ; 1268 uint8_t getAmbientLightGain(void)
4654                     ; 1269 {
4655                     .text:	section	.text,new
4656  0000               _getAmbientLightGain:
4658  0000 88            	push	a
4659       00000001      OFST:	set	1
4662                     ; 1273 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4664  0001 96            	ldw	x,sp
4665  0002 1c0001        	addw	x,#OFST+0
4666  0005 89            	pushw	x
4667  0006 a68f          	ld	a,#143
4668  0008 cd0000        	call	_wireReadDataByte
4670  000b 85            	popw	x
4671  000c 4d            	tnz	a
4672  000d 2605          	jrne	L7051
4673                     ; 1274 		return APDS9960_ERROR;
4675  000f a6ff          	ld	a,#255
4678  0011 5b01          	addw	sp,#1
4679  0013 81            	ret
4680  0014               L7051:
4681                     ; 1278 	val &= 0b00000011;
4683  0014 7b01          	ld	a,(OFST+0,sp)
4684  0016 a403          	and	a,#3
4685  0018 6b01          	ld	(OFST+0,sp),a
4686                     ; 1280 	return val;
4688  001a 7b01          	ld	a,(OFST+0,sp)
4691  001c 5b01          	addw	sp,#1
4692  001e 81            	ret
4734                     ; 1295 uint8_t setAmbientLightGain(uint8_t drive)
4734                     ; 1296 {
4735                     .text:	section	.text,new
4736  0000               _setAmbientLightGain:
4738  0000 88            	push	a
4739  0001 88            	push	a
4740       00000001      OFST:	set	1
4743                     ; 1300 	if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4745  0002 96            	ldw	x,sp
4746  0003 1c0001        	addw	x,#OFST+0
4747  0006 89            	pushw	x
4748  0007 a68f          	ld	a,#143
4749  0009 cd0000        	call	_wireReadDataByte
4751  000c 85            	popw	x
4752  000d 4d            	tnz	a
4753  000e 2603          	jrne	L7251
4754                     ; 1301 		return 0;
4756  0010 4f            	clr	a
4758  0011 201f          	jra	L622
4759  0013               L7251:
4760                     ; 1305 	drive &= 0b00000011;
4762  0013 7b02          	ld	a,(OFST+1,sp)
4763  0015 a403          	and	a,#3
4764  0017 6b02          	ld	(OFST+1,sp),a
4765                     ; 1306 	val &= 0b11111100;
4767  0019 7b01          	ld	a,(OFST+0,sp)
4768  001b a4fc          	and	a,#252
4769  001d 6b01          	ld	(OFST+0,sp),a
4770                     ; 1307 	val |= drive;
4772  001f 7b01          	ld	a,(OFST+0,sp)
4773  0021 1a02          	or	a,(OFST+1,sp)
4774  0023 6b01          	ld	(OFST+0,sp),a
4775                     ; 1310 	if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4777  0025 7b01          	ld	a,(OFST+0,sp)
4778  0027 97            	ld	xl,a
4779  0028 a68f          	ld	a,#143
4780  002a 95            	ld	xh,a
4781  002b cd0000        	call	_wireWriteDataByte
4783  002e 4d            	tnz	a
4784  002f 2603          	jrne	L1351
4785                     ; 1311 		return 0;
4787  0031 4f            	clr	a
4789  0032               L622:
4791  0032 85            	popw	x
4792  0033 81            	ret
4793  0034               L1351:
4794                     ; 1314 	return 1;
4796  0034 a601          	ld	a,#1
4798  0036 20fa          	jra	L622
4831                     ; 1328 uint8_t getLEDBoost(void)
4831                     ; 1329 {
4832                     .text:	section	.text,new
4833  0000               _getLEDBoost:
4835  0000 88            	push	a
4836       00000001      OFST:	set	1
4839                     ; 1333 	if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
4841  0001 96            	ldw	x,sp
4842  0002 1c0001        	addw	x,#OFST+0
4843  0005 89            	pushw	x
4844  0006 a690          	ld	a,#144
4845  0008 cd0000        	call	_wireReadDataByte
4847  000b 85            	popw	x
4848  000c 4d            	tnz	a
4849  000d 2605          	jrne	L7451
4850                     ; 1334 		return APDS9960_ERROR;
4852  000f a6ff          	ld	a,#255
4855  0011 5b01          	addw	sp,#1
4856  0013 81            	ret
4857  0014               L7451:
4858                     ; 1338 	val = (val >> 4) & 0b00000011;
4860  0014 7b01          	ld	a,(OFST+0,sp)
4861  0016 4e            	swap	a
4862  0017 a40f          	and	a,#15
4863  0019 a403          	and	a,#3
4864  001b 6b01          	ld	(OFST+0,sp),a
4865                     ; 1340 	return val;
4867  001d 7b01          	ld	a,(OFST+0,sp)
4870  001f 5b01          	addw	sp,#1
4871  0021 81            	ret
4912                     ; 1355 uint8_t setLEDBoost(uint8_t boost)
4912                     ; 1356 {
4913                     .text:	section	.text,new
4914  0000               _setLEDBoost:
4916  0000 88            	push	a
4917  0001 88            	push	a
4918       00000001      OFST:	set	1
4921                     ; 1360 	if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
4923  0002 96            	ldw	x,sp
4924  0003 1c0001        	addw	x,#OFST+0
4925  0006 89            	pushw	x
4926  0007 a690          	ld	a,#144
4927  0009 cd0000        	call	_wireReadDataByte
4929  000c 85            	popw	x
4930  000d 4d            	tnz	a
4931  000e 2603          	jrne	L7651
4932                     ; 1361 		return 0;
4934  0010 4f            	clr	a
4936  0011 2026          	jra	L432
4937  0013               L7651:
4938                     ; 1365 	boost &= 0b00000011;
4940  0013 7b02          	ld	a,(OFST+1,sp)
4941  0015 a403          	and	a,#3
4942  0017 6b02          	ld	(OFST+1,sp),a
4943                     ; 1366 	boost = boost << 4;
4945  0019 7b02          	ld	a,(OFST+1,sp)
4946  001b 4e            	swap	a
4947  001c a4f0          	and	a,#240
4948  001e 6b02          	ld	(OFST+1,sp),a
4949                     ; 1367 	val &= 0b11001111;
4951  0020 7b01          	ld	a,(OFST+0,sp)
4952  0022 a4cf          	and	a,#207
4953  0024 6b01          	ld	(OFST+0,sp),a
4954                     ; 1368 	val |= boost;
4956  0026 7b01          	ld	a,(OFST+0,sp)
4957  0028 1a02          	or	a,(OFST+1,sp)
4958  002a 6b01          	ld	(OFST+0,sp),a
4959                     ; 1371 	if( !wireWriteDataByte(APDS9960_CONFIG2, val) ) {
4961  002c 7b01          	ld	a,(OFST+0,sp)
4962  002e 97            	ld	xl,a
4963  002f a690          	ld	a,#144
4964  0031 95            	ld	xh,a
4965  0032 cd0000        	call	_wireWriteDataByte
4967  0035 4d            	tnz	a
4968  0036 2603          	jrne	L1751
4969                     ; 1372 		return 0;
4971  0038 4f            	clr	a
4973  0039               L432:
4975  0039 85            	popw	x
4976  003a 81            	ret
4977  003b               L1751:
4978                     ; 1375 	return 1;
4980  003b a601          	ld	a,#1
4982  003d 20fa          	jra	L432
5016                     ; 1383 uint8_t getProxGainCompEnable(void)
5016                     ; 1384 {
5017                     .text:	section	.text,new
5018  0000               _getProxGainCompEnable:
5020  0000 88            	push	a
5021       00000001      OFST:	set	1
5024                     ; 1388 	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
5026  0001 96            	ldw	x,sp
5027  0002 1c0001        	addw	x,#OFST+0
5028  0005 89            	pushw	x
5029  0006 a69f          	ld	a,#159
5030  0008 cd0000        	call	_wireReadDataByte
5032  000b 85            	popw	x
5033  000c 4d            	tnz	a
5034  000d 2605          	jrne	L7061
5035                     ; 1389 		return APDS9960_ERROR;
5037  000f a6ff          	ld	a,#255
5040  0011 5b01          	addw	sp,#1
5041  0013 81            	ret
5042  0014               L7061:
5043                     ; 1393 	val = (val >> 5) & 0b00000001;
5045  0014 7b01          	ld	a,(OFST+0,sp)
5046  0016 4e            	swap	a
5047  0017 44            	srl	a
5048  0018 a407          	and	a,#7
5049  001a a401          	and	a,#1
5050  001c 6b01          	ld	(OFST+0,sp),a
5051                     ; 1395 	return val;
5053  001e 7b01          	ld	a,(OFST+0,sp)
5056  0020 5b01          	addw	sp,#1
5057  0022 81            	ret
5099                     ; 1404 uint8_t setProxGainCompEnable(uint8_t enable)
5099                     ; 1405 {
5100                     .text:	section	.text,new
5101  0000               _setProxGainCompEnable:
5103  0000 88            	push	a
5104  0001 88            	push	a
5105       00000001      OFST:	set	1
5108                     ; 1409 	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
5110  0002 96            	ldw	x,sp
5111  0003 1c0001        	addw	x,#OFST+0
5112  0006 89            	pushw	x
5113  0007 a69f          	ld	a,#159
5114  0009 cd0000        	call	_wireReadDataByte
5116  000c 85            	popw	x
5117  000d 4d            	tnz	a
5118  000e 2603          	jrne	L7261
5119                     ; 1410 		return 0;
5121  0010 4f            	clr	a
5123  0011 2027          	jra	L242
5124  0013               L7261:
5125                     ; 1414 	enable &= 0b00000001;
5127  0013 7b02          	ld	a,(OFST+1,sp)
5128  0015 a401          	and	a,#1
5129  0017 6b02          	ld	(OFST+1,sp),a
5130                     ; 1415 	enable = enable << 5;
5132  0019 7b02          	ld	a,(OFST+1,sp)
5133  001b 4e            	swap	a
5134  001c 48            	sll	a
5135  001d a4e0          	and	a,#224
5136  001f 6b02          	ld	(OFST+1,sp),a
5137                     ; 1416 	val &= 0b11011111;
5139  0021 7b01          	ld	a,(OFST+0,sp)
5140  0023 a4df          	and	a,#223
5141  0025 6b01          	ld	(OFST+0,sp),a
5142                     ; 1417 	val |= enable;
5144  0027 7b01          	ld	a,(OFST+0,sp)
5145  0029 1a02          	or	a,(OFST+1,sp)
5146  002b 6b01          	ld	(OFST+0,sp),a
5147                     ; 1420 	if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
5149  002d 7b01          	ld	a,(OFST+0,sp)
5150  002f 97            	ld	xl,a
5151  0030 a69f          	ld	a,#159
5152  0032 95            	ld	xh,a
5153  0033 cd0000        	call	_wireWriteDataByte
5155  0036 4d            	tnz	a
5156  0037 2603          	jrne	L1361
5157                     ; 1421 		return 0;
5159  0039 4f            	clr	a
5161  003a               L242:
5163  003a 85            	popw	x
5164  003b 81            	ret
5165  003c               L1361:
5166                     ; 1424 	return 1;
5168  003c a601          	ld	a,#1
5170  003e 20fa          	jra	L242
5203                     ; 1439 uint8_t getProxPhotoMask(void)
5203                     ; 1440 {
5204                     .text:	section	.text,new
5205  0000               _getProxPhotoMask:
5207  0000 88            	push	a
5208       00000001      OFST:	set	1
5211                     ; 1444 	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
5213  0001 96            	ldw	x,sp
5214  0002 1c0001        	addw	x,#OFST+0
5215  0005 89            	pushw	x
5216  0006 a69f          	ld	a,#159
5217  0008 cd0000        	call	_wireReadDataByte
5219  000b 85            	popw	x
5220  000c 4d            	tnz	a
5221  000d 2605          	jrne	L7461
5222                     ; 1445 		return APDS9960_ERROR;
5224  000f a6ff          	ld	a,#255
5227  0011 5b01          	addw	sp,#1
5228  0013 81            	ret
5229  0014               L7461:
5230                     ; 1449 	val &= 0b00001111;
5232  0014 7b01          	ld	a,(OFST+0,sp)
5233  0016 a40f          	and	a,#15
5234  0018 6b01          	ld	(OFST+0,sp),a
5235                     ; 1451 	return val;
5237  001a 7b01          	ld	a,(OFST+0,sp)
5240  001c 5b01          	addw	sp,#1
5241  001e 81            	ret
5282                     ; 1467 uint8_t setProxPhotoMask(uint8_t mask)
5282                     ; 1468 {
5283                     .text:	section	.text,new
5284  0000               _setProxPhotoMask:
5286  0000 88            	push	a
5287  0001 88            	push	a
5288       00000001      OFST:	set	1
5291                     ; 1472 	if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
5293  0002 96            	ldw	x,sp
5294  0003 1c0001        	addw	x,#OFST+0
5295  0006 89            	pushw	x
5296  0007 a69f          	ld	a,#159
5297  0009 cd0000        	call	_wireReadDataByte
5299  000c 85            	popw	x
5300  000d 4d            	tnz	a
5301  000e 2603          	jrne	L7661
5302                     ; 1473 		return 0;
5304  0010 4f            	clr	a
5306  0011 201f          	jra	L052
5307  0013               L7661:
5308                     ; 1477 	mask &= 0b00001111;
5310  0013 7b02          	ld	a,(OFST+1,sp)
5311  0015 a40f          	and	a,#15
5312  0017 6b02          	ld	(OFST+1,sp),a
5313                     ; 1478 	val &= 0b11110000;
5315  0019 7b01          	ld	a,(OFST+0,sp)
5316  001b a4f0          	and	a,#240
5317  001d 6b01          	ld	(OFST+0,sp),a
5318                     ; 1479 	val |= mask;
5320  001f 7b01          	ld	a,(OFST+0,sp)
5321  0021 1a02          	or	a,(OFST+1,sp)
5322  0023 6b01          	ld	(OFST+0,sp),a
5323                     ; 1482 	if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
5325  0025 7b01          	ld	a,(OFST+0,sp)
5326  0027 97            	ld	xl,a
5327  0028 a69f          	ld	a,#159
5328  002a 95            	ld	xh,a
5329  002b cd0000        	call	_wireWriteDataByte
5331  002e 4d            	tnz	a
5332  002f 2603          	jrne	L1761
5333                     ; 1483 		return 0;
5335  0031 4f            	clr	a
5337  0032               L052:
5339  0032 85            	popw	x
5340  0033 81            	ret
5341  0034               L1761:
5342                     ; 1486 	return 1;
5344  0034 a601          	ld	a,#1
5346  0036 20fa          	jra	L052
5380                     ; 1494 uint8_t getGestureEnterThresh(void)
5380                     ; 1495 {
5381                     .text:	section	.text,new
5382  0000               _getGestureEnterThresh:
5384  0000 88            	push	a
5385       00000001      OFST:	set	1
5388                     ; 1499 	if( !wireReadDataByte(APDS9960_GPENTH, &val) ) {
5390  0001 96            	ldw	x,sp
5391  0002 1c0001        	addw	x,#OFST+0
5392  0005 89            	pushw	x
5393  0006 a6a0          	ld	a,#160
5394  0008 cd0000        	call	_wireReadDataByte
5396  000b 85            	popw	x
5397  000c 4d            	tnz	a
5398  000d 2602          	jrne	L7071
5399                     ; 1500 		val = 0;
5401  000f 0f01          	clr	(OFST+0,sp)
5402  0011               L7071:
5403                     ; 1503 	return val;
5405  0011 7b01          	ld	a,(OFST+0,sp)
5408  0013 5b01          	addw	sp,#1
5409  0015 81            	ret
5443                     ; 1512 uint8_t setGestureEnterThresh(uint8_t threshold)
5443                     ; 1513 {
5444                     .text:	section	.text,new
5445  0000               _setGestureEnterThresh:
5449                     ; 1514 	if( !wireWriteDataByte(APDS9960_GPENTH, threshold) ) {
5451  0000 97            	ld	xl,a
5452  0001 a6a0          	ld	a,#160
5453  0003 95            	ld	xh,a
5454  0004 cd0000        	call	_wireWriteDataByte
5456  0007 4d            	tnz	a
5457  0008 2602          	jrne	L5271
5458                     ; 1515 		return 0;
5460  000a 4f            	clr	a
5463  000b 81            	ret
5464  000c               L5271:
5465                     ; 1518 	return 1;
5467  000c a601          	ld	a,#1
5470  000e 81            	ret
5504                     ; 1526 uint8_t getGestureExitThresh(void)
5504                     ; 1527 {
5505                     .text:	section	.text,new
5506  0000               _getGestureExitThresh:
5508  0000 88            	push	a
5509       00000001      OFST:	set	1
5512                     ; 1531 	if( !wireReadDataByte(APDS9960_GEXTH, &val) ) {
5514  0001 96            	ldw	x,sp
5515  0002 1c0001        	addw	x,#OFST+0
5516  0005 89            	pushw	x
5517  0006 a6a1          	ld	a,#161
5518  0008 cd0000        	call	_wireReadDataByte
5520  000b 85            	popw	x
5521  000c 4d            	tnz	a
5522  000d 2602          	jrne	L3471
5523                     ; 1532 		val = 0;
5525  000f 0f01          	clr	(OFST+0,sp)
5526  0011               L3471:
5527                     ; 1535 	return val;
5529  0011 7b01          	ld	a,(OFST+0,sp)
5532  0013 5b01          	addw	sp,#1
5533  0015 81            	ret
5567                     ; 1544 uint8_t setGestureExitThresh(uint8_t threshold)
5567                     ; 1545 {
5568                     .text:	section	.text,new
5569  0000               _setGestureExitThresh:
5573                     ; 1546 	if( !wireWriteDataByte(APDS9960_GEXTH, threshold) ) {
5575  0000 97            	ld	xl,a
5576  0001 a6a1          	ld	a,#161
5577  0003 95            	ld	xh,a
5578  0004 cd0000        	call	_wireWriteDataByte
5580  0007 4d            	tnz	a
5581  0008 2602          	jrne	L1671
5582                     ; 1547 		return 0;
5584  000a 4f            	clr	a
5587  000b 81            	ret
5588  000c               L1671:
5589                     ; 1550 	return 1;
5591  000c a601          	ld	a,#1
5594  000e 81            	ret
5627                     ; 1564 uint8_t getGestureGain(void)
5627                     ; 1565 {
5628                     .text:	section	.text,new
5629  0000               _getGestureGain:
5631  0000 88            	push	a
5632       00000001      OFST:	set	1
5635                     ; 1569 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5637  0001 96            	ldw	x,sp
5638  0002 1c0001        	addw	x,#OFST+0
5639  0005 89            	pushw	x
5640  0006 a6a3          	ld	a,#163
5641  0008 cd0000        	call	_wireReadDataByte
5643  000b 85            	popw	x
5644  000c 4d            	tnz	a
5645  000d 2605          	jrne	L7771
5646                     ; 1570 		return APDS9960_ERROR;
5648  000f a6ff          	ld	a,#255
5651  0011 5b01          	addw	sp,#1
5652  0013 81            	ret
5653  0014               L7771:
5654                     ; 1574 	val = (val >> 5) & 0b00000011;
5656  0014 7b01          	ld	a,(OFST+0,sp)
5657  0016 4e            	swap	a
5658  0017 44            	srl	a
5659  0018 a407          	and	a,#7
5660  001a a403          	and	a,#3
5661  001c 6b01          	ld	(OFST+0,sp),a
5662                     ; 1576 	return val;
5664  001e 7b01          	ld	a,(OFST+0,sp)
5667  0020 5b01          	addw	sp,#1
5668  0022 81            	ret
5709                     ; 1591 uint8_t setGestureGain(uint8_t gain)
5709                     ; 1592 {
5710                     .text:	section	.text,new
5711  0000               _setGestureGain:
5713  0000 88            	push	a
5714  0001 88            	push	a
5715       00000001      OFST:	set	1
5718                     ; 1596 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5720  0002 96            	ldw	x,sp
5721  0003 1c0001        	addw	x,#OFST+0
5722  0006 89            	pushw	x
5723  0007 a6a3          	ld	a,#163
5724  0009 cd0000        	call	_wireReadDataByte
5726  000c 85            	popw	x
5727  000d 4d            	tnz	a
5728  000e 2603          	jrne	L7102
5729                     ; 1597 		return 0;
5731  0010 4f            	clr	a
5733  0011 2027          	jra	L662
5734  0013               L7102:
5735                     ; 1601 	gain &= 0b00000011;
5737  0013 7b02          	ld	a,(OFST+1,sp)
5738  0015 a403          	and	a,#3
5739  0017 6b02          	ld	(OFST+1,sp),a
5740                     ; 1602 	gain = gain << 5;
5742  0019 7b02          	ld	a,(OFST+1,sp)
5743  001b 4e            	swap	a
5744  001c 48            	sll	a
5745  001d a4e0          	and	a,#224
5746  001f 6b02          	ld	(OFST+1,sp),a
5747                     ; 1603 	val &= 0b10011111;
5749  0021 7b01          	ld	a,(OFST+0,sp)
5750  0023 a49f          	and	a,#159
5751  0025 6b01          	ld	(OFST+0,sp),a
5752                     ; 1604 	val |= gain;
5754  0027 7b01          	ld	a,(OFST+0,sp)
5755  0029 1a02          	or	a,(OFST+1,sp)
5756  002b 6b01          	ld	(OFST+0,sp),a
5757                     ; 1607 	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
5759  002d 7b01          	ld	a,(OFST+0,sp)
5760  002f 97            	ld	xl,a
5761  0030 a6a3          	ld	a,#163
5762  0032 95            	ld	xh,a
5763  0033 cd0000        	call	_wireWriteDataByte
5765  0036 4d            	tnz	a
5766  0037 2603          	jrne	L1202
5767                     ; 1608 		return 0;
5769  0039 4f            	clr	a
5771  003a               L662:
5773  003a 85            	popw	x
5774  003b 81            	ret
5775  003c               L1202:
5776                     ; 1611 	return 1;
5778  003c a601          	ld	a,#1
5780  003e 20fa          	jra	L662
5813                     ; 1625 uint8_t getGestureLEDDrive(void)
5813                     ; 1626 {
5814                     .text:	section	.text,new
5815  0000               _getGestureLEDDrive:
5817  0000 88            	push	a
5818       00000001      OFST:	set	1
5821                     ; 1630 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5823  0001 96            	ldw	x,sp
5824  0002 1c0001        	addw	x,#OFST+0
5825  0005 89            	pushw	x
5826  0006 a6a3          	ld	a,#163
5827  0008 cd0000        	call	_wireReadDataByte
5829  000b 85            	popw	x
5830  000c 4d            	tnz	a
5831  000d 2605          	jrne	L7302
5832                     ; 1631 		return APDS9960_ERROR;
5834  000f a6ff          	ld	a,#255
5837  0011 5b01          	addw	sp,#1
5838  0013 81            	ret
5839  0014               L7302:
5840                     ; 1635 	val = (val >> 3) & 0b00000011;
5842  0014 7b01          	ld	a,(OFST+0,sp)
5843  0016 44            	srl	a
5844  0017 44            	srl	a
5845  0018 44            	srl	a
5846  0019 a403          	and	a,#3
5847  001b 6b01          	ld	(OFST+0,sp),a
5848                     ; 1637 	return val;
5850  001d 7b01          	ld	a,(OFST+0,sp)
5853  001f 5b01          	addw	sp,#1
5854  0021 81            	ret
5895                     ; 1652 uint8_t setGestureLEDDrive(uint8_t drive)
5895                     ; 1653 {
5896                     .text:	section	.text,new
5897  0000               _setGestureLEDDrive:
5899  0000 88            	push	a
5900  0001 88            	push	a
5901       00000001      OFST:	set	1
5904                     ; 1657 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5906  0002 96            	ldw	x,sp
5907  0003 1c0001        	addw	x,#OFST+0
5908  0006 89            	pushw	x
5909  0007 a6a3          	ld	a,#163
5910  0009 cd0000        	call	_wireReadDataByte
5912  000c 85            	popw	x
5913  000d 4d            	tnz	a
5914  000e 2603          	jrne	L7502
5915                     ; 1658 		return 0;
5917  0010 4f            	clr	a
5919  0011 2025          	jra	L472
5920  0013               L7502:
5921                     ; 1662 	drive &= 0b00000011;
5923  0013 7b02          	ld	a,(OFST+1,sp)
5924  0015 a403          	and	a,#3
5925  0017 6b02          	ld	(OFST+1,sp),a
5926                     ; 1663 	drive = drive << 3;
5928  0019 0802          	sll	(OFST+1,sp)
5929  001b 0802          	sll	(OFST+1,sp)
5930  001d 0802          	sll	(OFST+1,sp)
5931                     ; 1664 	val &= 0b11100111;
5933  001f 7b01          	ld	a,(OFST+0,sp)
5934  0021 a4e7          	and	a,#231
5935  0023 6b01          	ld	(OFST+0,sp),a
5936                     ; 1665 	val |= drive;
5938  0025 7b01          	ld	a,(OFST+0,sp)
5939  0027 1a02          	or	a,(OFST+1,sp)
5940  0029 6b01          	ld	(OFST+0,sp),a
5941                     ; 1668 	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
5943  002b 7b01          	ld	a,(OFST+0,sp)
5944  002d 97            	ld	xl,a
5945  002e a6a3          	ld	a,#163
5946  0030 95            	ld	xh,a
5947  0031 cd0000        	call	_wireWriteDataByte
5949  0034 4d            	tnz	a
5950  0035 2603          	jrne	L1602
5951                     ; 1669 		return 0;
5953  0037 4f            	clr	a
5955  0038               L472:
5957  0038 85            	popw	x
5958  0039 81            	ret
5959  003a               L1602:
5960                     ; 1672 	return 1;
5962  003a a601          	ld	a,#1
5964  003c 20fa          	jra	L472
5997                     ; 1690 uint8_t getGestureWaitTime(void)
5997                     ; 1691 {
5998                     .text:	section	.text,new
5999  0000               _getGestureWaitTime:
6001  0000 88            	push	a
6002       00000001      OFST:	set	1
6005                     ; 1695 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
6007  0001 96            	ldw	x,sp
6008  0002 1c0001        	addw	x,#OFST+0
6009  0005 89            	pushw	x
6010  0006 a6a3          	ld	a,#163
6011  0008 cd0000        	call	_wireReadDataByte
6013  000b 85            	popw	x
6014  000c 4d            	tnz	a
6015  000d 2605          	jrne	L7702
6016                     ; 1696 		return APDS9960_ERROR;
6018  000f a6ff          	ld	a,#255
6021  0011 5b01          	addw	sp,#1
6022  0013 81            	ret
6023  0014               L7702:
6024                     ; 1700 	val &= 0b00000111;
6026  0014 7b01          	ld	a,(OFST+0,sp)
6027  0016 a407          	and	a,#7
6028  0018 6b01          	ld	(OFST+0,sp),a
6029                     ; 1702 	return val;
6031  001a 7b01          	ld	a,(OFST+0,sp)
6034  001c 5b01          	addw	sp,#1
6035  001e 81            	ret
6076                     ; 1721 uint8_t setGestureWaitTime(uint8_t time)
6076                     ; 1722 {
6077                     .text:	section	.text,new
6078  0000               _setGestureWaitTime:
6080  0000 88            	push	a
6081  0001 88            	push	a
6082       00000001      OFST:	set	1
6085                     ; 1726 	if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
6087  0002 96            	ldw	x,sp
6088  0003 1c0001        	addw	x,#OFST+0
6089  0006 89            	pushw	x
6090  0007 a6a3          	ld	a,#163
6091  0009 cd0000        	call	_wireReadDataByte
6093  000c 85            	popw	x
6094  000d 4d            	tnz	a
6095  000e 2603          	jrne	L7112
6096                     ; 1727 		return 0;
6098  0010 4f            	clr	a
6100  0011 201f          	jra	L203
6101  0013               L7112:
6102                     ; 1731 	time &= 0b00000111;
6104  0013 7b02          	ld	a,(OFST+1,sp)
6105  0015 a407          	and	a,#7
6106  0017 6b02          	ld	(OFST+1,sp),a
6107                     ; 1732 	val &= 0b11111000;
6109  0019 7b01          	ld	a,(OFST+0,sp)
6110  001b a4f8          	and	a,#248
6111  001d 6b01          	ld	(OFST+0,sp),a
6112                     ; 1733 	val |= time;
6114  001f 7b01          	ld	a,(OFST+0,sp)
6115  0021 1a02          	or	a,(OFST+1,sp)
6116  0023 6b01          	ld	(OFST+0,sp),a
6117                     ; 1736 	if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
6119  0025 7b01          	ld	a,(OFST+0,sp)
6120  0027 97            	ld	xl,a
6121  0028 a6a3          	ld	a,#163
6122  002a 95            	ld	xh,a
6123  002b cd0000        	call	_wireWriteDataByte
6125  002e 4d            	tnz	a
6126  002f 2603          	jrne	L1212
6127                     ; 1737 		return 0;
6129  0031 4f            	clr	a
6131  0032               L203:
6133  0032 85            	popw	x
6134  0033 81            	ret
6135  0034               L1212:
6136                     ; 1740 	return 1;
6138  0034 a601          	ld	a,#1
6140  0036 20fa          	jra	L203
6184                     ; 1749 uint8_t getLightIntLowThreshold(uint16_t *threshold)
6184                     ; 1750 {
6185                     .text:	section	.text,new
6186  0000               _getLightIntLowThreshold:
6188  0000 89            	pushw	x
6189  0001 88            	push	a
6190       00000001      OFST:	set	1
6193                     ; 1752 	*threshold = 0;
6195  0002 905f          	clrw	y
6196  0004 ff            	ldw	(x),y
6197                     ; 1755 	if( !wireReadDataByte(APDS9960_AILTL, &val_byte) ) {
6199  0005 96            	ldw	x,sp
6200  0006 1c0001        	addw	x,#OFST+0
6201  0009 89            	pushw	x
6202  000a a684          	ld	a,#132
6203  000c cd0000        	call	_wireReadDataByte
6205  000f 85            	popw	x
6206  0010 4d            	tnz	a
6207  0011 2603          	jrne	L3412
6208                     ; 1756 		return 0;
6210  0013 4f            	clr	a
6212  0014 2017          	jra	L603
6213  0016               L3412:
6214                     ; 1758 	*threshold = val_byte;
6216  0016 7b01          	ld	a,(OFST+0,sp)
6217  0018 5f            	clrw	x
6218  0019 97            	ld	xl,a
6219  001a 1602          	ldw	y,(OFST+1,sp)
6220  001c 90ff          	ldw	(y),x
6221                     ; 1761 	if( !wireReadDataByte(APDS9960_AILTH, &val_byte) ) {
6223  001e 96            	ldw	x,sp
6224  001f 1c0001        	addw	x,#OFST+0
6225  0022 89            	pushw	x
6226  0023 a685          	ld	a,#133
6227  0025 cd0000        	call	_wireReadDataByte
6229  0028 85            	popw	x
6230  0029 4d            	tnz	a
6231  002a 2604          	jrne	L5412
6232                     ; 1762 		return 0;
6234  002c 4f            	clr	a
6236  002d               L603:
6238  002d 5b03          	addw	sp,#3
6239  002f 81            	ret
6240  0030               L5412:
6241                     ; 1764 	*threshold = *threshold + ((uint16_t)val_byte << 8);
6243  0030 1e02          	ldw	x,(OFST+1,sp)
6244  0032 7b01          	ld	a,(OFST+0,sp)
6245  0034 905f          	clrw	y
6246  0036 9097          	ld	yl,a
6247  0038 4f            	clr	a
6248  0039 9002          	rlwa	y,a
6249  003b 90bf00        	ldw	c_y,y
6250  003e 9093          	ldw	y,x
6251  0040 90fe          	ldw	y,(y)
6252  0042 72b90000      	addw	y,c_y
6253  0046 ff            	ldw	(x),y
6254                     ; 1766 	return 1;
6256  0047 a601          	ld	a,#1
6258  0049 20e2          	jra	L603
6306                     ; 1775 uint8_t setLightIntLowThreshold(uint16_t threshold)
6306                     ; 1776 {
6307                     .text:	section	.text,new
6308  0000               _setLightIntLowThreshold:
6310  0000 89            	pushw	x
6311  0001 89            	pushw	x
6312       00000002      OFST:	set	2
6315                     ; 1781 	val_low = threshold & 0x00FF;
6317  0002 9f            	ld	a,xl
6318  0003 a4ff          	and	a,#255
6319  0005 6b01          	ld	(OFST-1,sp),a
6320                     ; 1782 	val_high = (threshold & 0xFF00) >> 8;
6322  0007 7b03          	ld	a,(OFST+1,sp)
6323  0009 97            	ld	xl,a
6324  000a 7b04          	ld	a,(OFST+2,sp)
6325  000c 9f            	ld	a,xl
6326  000d a4ff          	and	a,#255
6327  000f 97            	ld	xl,a
6328  0010 4f            	clr	a
6329  0011 02            	rlwa	x,a
6330  0012 4f            	clr	a
6331  0013 01            	rrwa	x,a
6332  0014 01            	rrwa	x,a
6333  0015 6b02          	ld	(OFST+0,sp),a
6334  0017 02            	rlwa	x,a
6335                     ; 1785 	if( !wireWriteDataByte(APDS9960_AILTL, val_low) ) {
6337  0018 7b01          	ld	a,(OFST-1,sp)
6338  001a 97            	ld	xl,a
6339  001b a684          	ld	a,#132
6340  001d 95            	ld	xh,a
6341  001e cd0000        	call	_wireWriteDataByte
6343  0021 4d            	tnz	a
6344  0022 2603          	jrne	L7612
6345                     ; 1786 		return 0;
6347  0024 4f            	clr	a
6349  0025 200d          	jra	L213
6350  0027               L7612:
6351                     ; 1790 	if( !wireWriteDataByte(APDS9960_AILTH, val_high) ) {
6353  0027 7b02          	ld	a,(OFST+0,sp)
6354  0029 97            	ld	xl,a
6355  002a a685          	ld	a,#133
6356  002c 95            	ld	xh,a
6357  002d cd0000        	call	_wireWriteDataByte
6359  0030 4d            	tnz	a
6360  0031 2604          	jrne	L1712
6361                     ; 1791 		return 0;
6363  0033 4f            	clr	a
6365  0034               L213:
6367  0034 5b04          	addw	sp,#4
6368  0036 81            	ret
6369  0037               L1712:
6370                     ; 1794 	return 1;
6372  0037 a601          	ld	a,#1
6374  0039 20f9          	jra	L213
6418                     ; 1803 uint8_t getLightIntHighThreshold(uint16_t *threshold)
6418                     ; 1804 {
6419                     .text:	section	.text,new
6420  0000               _getLightIntHighThreshold:
6422  0000 89            	pushw	x
6423  0001 88            	push	a
6424       00000001      OFST:	set	1
6427                     ; 1806 	*threshold = 0;
6429  0002 905f          	clrw	y
6430  0004 ff            	ldw	(x),y
6431                     ; 1809 	if( !wireReadDataByte(APDS9960_AIHTL, &val_byte) ) {
6433  0005 96            	ldw	x,sp
6434  0006 1c0001        	addw	x,#OFST+0
6435  0009 89            	pushw	x
6436  000a a686          	ld	a,#134
6437  000c cd0000        	call	_wireReadDataByte
6439  000f 85            	popw	x
6440  0010 4d            	tnz	a
6441  0011 2603          	jrne	L3122
6442                     ; 1810 		return 0;
6444  0013 4f            	clr	a
6446  0014 2017          	jra	L613
6447  0016               L3122:
6448                     ; 1812 	*threshold = val_byte;
6450  0016 7b01          	ld	a,(OFST+0,sp)
6451  0018 5f            	clrw	x
6452  0019 97            	ld	xl,a
6453  001a 1602          	ldw	y,(OFST+1,sp)
6454  001c 90ff          	ldw	(y),x
6455                     ; 1815 	if( !wireReadDataByte(APDS9960_AIHTH, &val_byte) ) {
6457  001e 96            	ldw	x,sp
6458  001f 1c0001        	addw	x,#OFST+0
6459  0022 89            	pushw	x
6460  0023 a687          	ld	a,#135
6461  0025 cd0000        	call	_wireReadDataByte
6463  0028 85            	popw	x
6464  0029 4d            	tnz	a
6465  002a 2604          	jrne	L5122
6466                     ; 1816 		return 0;
6468  002c 4f            	clr	a
6470  002d               L613:
6472  002d 5b03          	addw	sp,#3
6473  002f 81            	ret
6474  0030               L5122:
6475                     ; 1818 	*threshold = *threshold + ((uint16_t)val_byte << 8);
6477  0030 1e02          	ldw	x,(OFST+1,sp)
6478  0032 7b01          	ld	a,(OFST+0,sp)
6479  0034 905f          	clrw	y
6480  0036 9097          	ld	yl,a
6481  0038 4f            	clr	a
6482  0039 9002          	rlwa	y,a
6483  003b 90bf00        	ldw	c_y,y
6484  003e 9093          	ldw	y,x
6485  0040 90fe          	ldw	y,(y)
6486  0042 72b90000      	addw	y,c_y
6487  0046 ff            	ldw	(x),y
6488                     ; 1820 	return 1;
6490  0047 a601          	ld	a,#1
6492  0049 20e2          	jra	L613
6540                     ; 1829 uint8_t setLightIntHighThreshold(uint16_t threshold)
6540                     ; 1830 {
6541                     .text:	section	.text,new
6542  0000               _setLightIntHighThreshold:
6544  0000 89            	pushw	x
6545  0001 89            	pushw	x
6546       00000002      OFST:	set	2
6549                     ; 1835 	val_low = threshold & 0x00FF;
6551  0002 9f            	ld	a,xl
6552  0003 a4ff          	and	a,#255
6553  0005 6b01          	ld	(OFST-1,sp),a
6554                     ; 1836 	val_high = (threshold & 0xFF00) >> 8;
6556  0007 7b03          	ld	a,(OFST+1,sp)
6557  0009 97            	ld	xl,a
6558  000a 7b04          	ld	a,(OFST+2,sp)
6559  000c 9f            	ld	a,xl
6560  000d a4ff          	and	a,#255
6561  000f 97            	ld	xl,a
6562  0010 4f            	clr	a
6563  0011 02            	rlwa	x,a
6564  0012 4f            	clr	a
6565  0013 01            	rrwa	x,a
6566  0014 01            	rrwa	x,a
6567  0015 6b02          	ld	(OFST+0,sp),a
6568  0017 02            	rlwa	x,a
6569                     ; 1839 	if( !wireWriteDataByte(APDS9960_AIHTL, val_low) ) {
6571  0018 7b01          	ld	a,(OFST-1,sp)
6572  001a 97            	ld	xl,a
6573  001b a686          	ld	a,#134
6574  001d 95            	ld	xh,a
6575  001e cd0000        	call	_wireWriteDataByte
6577  0021 4d            	tnz	a
6578  0022 2603          	jrne	L7322
6579                     ; 1840 		return 0;
6581  0024 4f            	clr	a
6583  0025 200d          	jra	L223
6584  0027               L7322:
6585                     ; 1844 	if( !wireWriteDataByte(APDS9960_AIHTH, val_high) ) {
6587  0027 7b02          	ld	a,(OFST+0,sp)
6588  0029 97            	ld	xl,a
6589  002a a687          	ld	a,#135
6590  002c 95            	ld	xh,a
6591  002d cd0000        	call	_wireWriteDataByte
6593  0030 4d            	tnz	a
6594  0031 2604          	jrne	L1422
6595                     ; 1845 		return 0;
6597  0033 4f            	clr	a
6599  0034               L223:
6601  0034 5b04          	addw	sp,#4
6602  0036 81            	ret
6603  0037               L1422:
6604                     ; 1848 	return 1;
6606  0037 a601          	ld	a,#1
6608  0039 20f9          	jra	L223
6645                     ; 1857 uint8_t getProximityIntLowThreshold(uint8_t *threshold)
6645                     ; 1858 {
6646                     .text:	section	.text,new
6647  0000               _getProximityIntLowThreshold:
6651                     ; 1859 	*threshold = 0;
6653  0000 7f            	clr	(x)
6654                     ; 1862 	if( !wireReadDataByte(APDS9960_PILT, threshold) ) {
6656  0001 89            	pushw	x
6657  0002 a689          	ld	a,#137
6658  0004 cd0000        	call	_wireReadDataByte
6660  0007 85            	popw	x
6661  0008 4d            	tnz	a
6662  0009 2602          	jrne	L1622
6663                     ; 1863 		return 0;
6665  000b 4f            	clr	a
6668  000c 81            	ret
6669  000d               L1622:
6670                     ; 1866 	return 1;
6672  000d a601          	ld	a,#1
6675  000f 81            	ret
6709                     ; 1875 uint8_t setProximityIntLowThreshold(uint8_t threshold)
6709                     ; 1876 {
6710                     .text:	section	.text,new
6711  0000               _setProximityIntLowThreshold:
6715                     ; 1879 	if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
6717  0000 97            	ld	xl,a
6718  0001 a689          	ld	a,#137
6719  0003 95            	ld	xh,a
6720  0004 cd0000        	call	_wireWriteDataByte
6722  0007 4d            	tnz	a
6723  0008 2602          	jrne	L7722
6724                     ; 1880 		return 0;
6726  000a 4f            	clr	a
6729  000b 81            	ret
6730  000c               L7722:
6731                     ; 1883 	return 1;
6733  000c a601          	ld	a,#1
6736  000e 81            	ret
6773                     ; 1892 uint8_t getProximityIntHighThreshold(uint8_t *threshold)
6773                     ; 1893 {
6774                     .text:	section	.text,new
6775  0000               _getProximityIntHighThreshold:
6779                     ; 1894 	*threshold = 0;
6781  0000 7f            	clr	(x)
6782                     ; 1897 	if( !wireReadDataByte(APDS9960_PIHT, threshold) ) {
6784  0001 89            	pushw	x
6785  0002 a68b          	ld	a,#139
6786  0004 cd0000        	call	_wireReadDataByte
6788  0007 85            	popw	x
6789  0008 4d            	tnz	a
6790  0009 2602          	jrne	L7132
6791                     ; 1898 		return 0;
6793  000b 4f            	clr	a
6796  000c 81            	ret
6797  000d               L7132:
6798                     ; 1901 	return 1;
6800  000d a601          	ld	a,#1
6803  000f 81            	ret
6837                     ; 1910 uint8_t setProximityIntHighThreshold(uint8_t threshold)
6837                     ; 1911 {
6838                     .text:	section	.text,new
6839  0000               _setProximityIntHighThreshold:
6843                     ; 1914 	if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
6845  0000 97            	ld	xl,a
6846  0001 a68b          	ld	a,#139
6847  0003 95            	ld	xh,a
6848  0004 cd0000        	call	_wireWriteDataByte
6850  0007 4d            	tnz	a
6851  0008 2602          	jrne	L5332
6852                     ; 1915 		return 0;
6854  000a 4f            	clr	a
6857  000b 81            	ret
6858  000c               L5332:
6859                     ; 1918 	return 1;
6861  000c a601          	ld	a,#1
6864  000e 81            	ret
6898                     ; 1926 uint8_t getAmbientLightIntEnable(void)
6898                     ; 1927 {
6899                     .text:	section	.text,new
6900  0000               _getAmbientLightIntEnable:
6902  0000 88            	push	a
6903       00000001      OFST:	set	1
6906                     ; 1931 	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6908  0001 96            	ldw	x,sp
6909  0002 1c0001        	addw	x,#OFST+0
6910  0005 89            	pushw	x
6911  0006 a680          	ld	a,#128
6912  0008 cd0000        	call	_wireReadDataByte
6914  000b 85            	popw	x
6915  000c 4d            	tnz	a
6916  000d 2605          	jrne	L3532
6917                     ; 1932 		return APDS9960_ERROR;
6919  000f a6ff          	ld	a,#255
6922  0011 5b01          	addw	sp,#1
6923  0013 81            	ret
6924  0014               L3532:
6925                     ; 1936 	val = (val >> 4) & 0b00000001;
6927  0014 7b01          	ld	a,(OFST+0,sp)
6928  0016 4e            	swap	a
6929  0017 a40f          	and	a,#15
6930  0019 a401          	and	a,#1
6931  001b 6b01          	ld	(OFST+0,sp),a
6932                     ; 1938 	return val;
6934  001d 7b01          	ld	a,(OFST+0,sp)
6937  001f 5b01          	addw	sp,#1
6938  0021 81            	ret
6980                     ; 1947 uint8_t setAmbientLightIntEnable(uint8_t enable)
6980                     ; 1948 {
6981                     .text:	section	.text,new
6982  0000               _setAmbientLightIntEnable:
6984  0000 88            	push	a
6985  0001 88            	push	a
6986       00000001      OFST:	set	1
6989                     ; 1952 	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6991  0002 96            	ldw	x,sp
6992  0003 1c0001        	addw	x,#OFST+0
6993  0006 89            	pushw	x
6994  0007 a680          	ld	a,#128
6995  0009 cd0000        	call	_wireReadDataByte
6997  000c 85            	popw	x
6998  000d 4d            	tnz	a
6999  000e 2603          	jrne	L3732
7000                     ; 1953 		return 0;
7002  0010 4f            	clr	a
7004  0011 2026          	jra	L043
7005  0013               L3732:
7006                     ; 1957 	enable &= 0b00000001;
7008  0013 7b02          	ld	a,(OFST+1,sp)
7009  0015 a401          	and	a,#1
7010  0017 6b02          	ld	(OFST+1,sp),a
7011                     ; 1958 	enable = enable << 4;
7013  0019 7b02          	ld	a,(OFST+1,sp)
7014  001b 4e            	swap	a
7015  001c a4f0          	and	a,#240
7016  001e 6b02          	ld	(OFST+1,sp),a
7017                     ; 1959 	val &= 0b11101111;
7019  0020 7b01          	ld	a,(OFST+0,sp)
7020  0022 a4ef          	and	a,#239
7021  0024 6b01          	ld	(OFST+0,sp),a
7022                     ; 1960 	val |= enable;
7024  0026 7b01          	ld	a,(OFST+0,sp)
7025  0028 1a02          	or	a,(OFST+1,sp)
7026  002a 6b01          	ld	(OFST+0,sp),a
7027                     ; 1963 	if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
7029  002c 7b01          	ld	a,(OFST+0,sp)
7030  002e 97            	ld	xl,a
7031  002f a680          	ld	a,#128
7032  0031 95            	ld	xh,a
7033  0032 cd0000        	call	_wireWriteDataByte
7035  0035 4d            	tnz	a
7036  0036 2603          	jrne	L5732
7037                     ; 1964 		return 0;
7039  0038 4f            	clr	a
7041  0039               L043:
7043  0039 85            	popw	x
7044  003a 81            	ret
7045  003b               L5732:
7046                     ; 1967 	return 1;
7048  003b a601          	ld	a,#1
7050  003d 20fa          	jra	L043
7084                     ; 1975 uint8_t getProximityIntEnable(void)
7084                     ; 1976 {
7085                     .text:	section	.text,new
7086  0000               _getProximityIntEnable:
7088  0000 88            	push	a
7089       00000001      OFST:	set	1
7092                     ; 1980 	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
7094  0001 96            	ldw	x,sp
7095  0002 1c0001        	addw	x,#OFST+0
7096  0005 89            	pushw	x
7097  0006 a680          	ld	a,#128
7098  0008 cd0000        	call	_wireReadDataByte
7100  000b 85            	popw	x
7101  000c 4d            	tnz	a
7102  000d 2605          	jrne	L3142
7103                     ; 1981 		return APDS9960_ERROR;
7105  000f a6ff          	ld	a,#255
7108  0011 5b01          	addw	sp,#1
7109  0013 81            	ret
7110  0014               L3142:
7111                     ; 1985 	val = (val >> 5) & 0b00000001;
7113  0014 7b01          	ld	a,(OFST+0,sp)
7114  0016 4e            	swap	a
7115  0017 44            	srl	a
7116  0018 a407          	and	a,#7
7117  001a a401          	and	a,#1
7118  001c 6b01          	ld	(OFST+0,sp),a
7119                     ; 1987 	return val;
7121  001e 7b01          	ld	a,(OFST+0,sp)
7124  0020 5b01          	addw	sp,#1
7125  0022 81            	ret
7167                     ; 1996 uint8_t setProximityIntEnable(uint8_t enable)
7167                     ; 1997 {
7168                     .text:	section	.text,new
7169  0000               _setProximityIntEnable:
7171  0000 88            	push	a
7172  0001 88            	push	a
7173       00000001      OFST:	set	1
7176                     ; 2001 	if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
7178  0002 96            	ldw	x,sp
7179  0003 1c0001        	addw	x,#OFST+0
7180  0006 89            	pushw	x
7181  0007 a680          	ld	a,#128
7182  0009 cd0000        	call	_wireReadDataByte
7184  000c 85            	popw	x
7185  000d 4d            	tnz	a
7186  000e 2603          	jrne	L3342
7187                     ; 2002 		return 0;
7189  0010 4f            	clr	a
7191  0011 2027          	jra	L643
7192  0013               L3342:
7193                     ; 2006 	enable &= 0b00000001;
7195  0013 7b02          	ld	a,(OFST+1,sp)
7196  0015 a401          	and	a,#1
7197  0017 6b02          	ld	(OFST+1,sp),a
7198                     ; 2007 	enable = enable << 5;
7200  0019 7b02          	ld	a,(OFST+1,sp)
7201  001b 4e            	swap	a
7202  001c 48            	sll	a
7203  001d a4e0          	and	a,#224
7204  001f 6b02          	ld	(OFST+1,sp),a
7205                     ; 2008 	val &= 0b11011111;
7207  0021 7b01          	ld	a,(OFST+0,sp)
7208  0023 a4df          	and	a,#223
7209  0025 6b01          	ld	(OFST+0,sp),a
7210                     ; 2009 	val |= enable;
7212  0027 7b01          	ld	a,(OFST+0,sp)
7213  0029 1a02          	or	a,(OFST+1,sp)
7214  002b 6b01          	ld	(OFST+0,sp),a
7215                     ; 2012 	if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
7217  002d 7b01          	ld	a,(OFST+0,sp)
7218  002f 97            	ld	xl,a
7219  0030 a680          	ld	a,#128
7220  0032 95            	ld	xh,a
7221  0033 cd0000        	call	_wireWriteDataByte
7223  0036 4d            	tnz	a
7224  0037 2603          	jrne	L5342
7225                     ; 2013 		return 0;
7227  0039 4f            	clr	a
7229  003a               L643:
7231  003a 85            	popw	x
7232  003b 81            	ret
7233  003c               L5342:
7234                     ; 2016 	return 1;
7236  003c a601          	ld	a,#1
7238  003e 20fa          	jra	L643
7272                     ; 2024 uint8_t getGestureIntEnable(void)
7272                     ; 2025 {
7273                     .text:	section	.text,new
7274  0000               _getGestureIntEnable:
7276  0000 88            	push	a
7277       00000001      OFST:	set	1
7280                     ; 2029 	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7282  0001 96            	ldw	x,sp
7283  0002 1c0001        	addw	x,#OFST+0
7284  0005 89            	pushw	x
7285  0006 a6ab          	ld	a,#171
7286  0008 cd0000        	call	_wireReadDataByte
7288  000b 85            	popw	x
7289  000c 4d            	tnz	a
7290  000d 2605          	jrne	L3542
7291                     ; 2030 		return APDS9960_ERROR;
7293  000f a6ff          	ld	a,#255
7296  0011 5b01          	addw	sp,#1
7297  0013 81            	ret
7298  0014               L3542:
7299                     ; 2034 	val = (val >> 1) & 0b00000001;
7301  0014 7b01          	ld	a,(OFST+0,sp)
7302  0016 44            	srl	a
7303  0017 a401          	and	a,#1
7304  0019 6b01          	ld	(OFST+0,sp),a
7305                     ; 2036 	return val;
7307  001b 7b01          	ld	a,(OFST+0,sp)
7310  001d 5b01          	addw	sp,#1
7311  001f 81            	ret
7353                     ; 2045 uint8_t setGestureIntEnable(uint8_t enable)
7353                     ; 2046 {
7354                     .text:	section	.text,new
7355  0000               _setGestureIntEnable:
7357  0000 88            	push	a
7358  0001 88            	push	a
7359       00000001      OFST:	set	1
7362                     ; 2050 	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7364  0002 96            	ldw	x,sp
7365  0003 1c0001        	addw	x,#OFST+0
7366  0006 89            	pushw	x
7367  0007 a6ab          	ld	a,#171
7368  0009 cd0000        	call	_wireReadDataByte
7370  000c 85            	popw	x
7371  000d 4d            	tnz	a
7372  000e 2603          	jrne	L3742
7373                     ; 2051 		return 0;
7375  0010 4f            	clr	a
7377  0011 2021          	jra	L453
7378  0013               L3742:
7379                     ; 2055 	enable &= 0b00000001;
7381  0013 7b02          	ld	a,(OFST+1,sp)
7382  0015 a401          	and	a,#1
7383  0017 6b02          	ld	(OFST+1,sp),a
7384                     ; 2056 	enable = enable << 1;
7386  0019 0802          	sll	(OFST+1,sp)
7387                     ; 2057 	val &= 0b11111101;
7389  001b 7b01          	ld	a,(OFST+0,sp)
7390  001d a4fd          	and	a,#253
7391  001f 6b01          	ld	(OFST+0,sp),a
7392                     ; 2058 	val |= enable;
7394  0021 7b01          	ld	a,(OFST+0,sp)
7395  0023 1a02          	or	a,(OFST+1,sp)
7396  0025 6b01          	ld	(OFST+0,sp),a
7397                     ; 2061 	if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
7399  0027 7b01          	ld	a,(OFST+0,sp)
7400  0029 97            	ld	xl,a
7401  002a a6ab          	ld	a,#171
7402  002c 95            	ld	xh,a
7403  002d cd0000        	call	_wireWriteDataByte
7405  0030 4d            	tnz	a
7406  0031 2603          	jrne	L5742
7407                     ; 2062 		return 0;
7409  0033 4f            	clr	a
7411  0034               L453:
7413  0034 85            	popw	x
7414  0035 81            	ret
7415  0036               L5742:
7416                     ; 2065 	return 1;
7418  0036 a601          	ld	a,#1
7420  0038 20fa          	jra	L453
7454                     ; 2073 uint8_t clearAmbientLightInt(void)
7454                     ; 2074 {
7455                     .text:	section	.text,new
7456  0000               _clearAmbientLightInt:
7458  0000 88            	push	a
7459       00000001      OFST:	set	1
7462                     ; 2076 	if( !wireReadDataByte(APDS9960_AICLEAR, &throwaway) ) {
7464  0001 96            	ldw	x,sp
7465  0002 1c0001        	addw	x,#OFST+0
7466  0005 89            	pushw	x
7467  0006 a6e7          	ld	a,#231
7468  0008 cd0000        	call	_wireReadDataByte
7470  000b 85            	popw	x
7471  000c 4d            	tnz	a
7472  000d 2604          	jrne	L3152
7473                     ; 2077 		return 0;
7475  000f 4f            	clr	a
7478  0010 5b01          	addw	sp,#1
7479  0012 81            	ret
7480  0013               L3152:
7481                     ; 2080 	return 1;
7483  0013 a601          	ld	a,#1
7486  0015 5b01          	addw	sp,#1
7487  0017 81            	ret
7520                     ; 2088 uint8_t clearProximityInt(void)
7520                     ; 2089 {
7521                     .text:	section	.text,new
7522  0000               _clearProximityInt:
7524  0000 88            	push	a
7525       00000001      OFST:	set	1
7528                     ; 2091 	if( !wireReadDataByte(APDS9960_PICLEAR, &throwaway) ) {
7530  0001 96            	ldw	x,sp
7531  0002 1c0001        	addw	x,#OFST+0
7532  0005 89            	pushw	x
7533  0006 a6e5          	ld	a,#229
7534  0008 cd0000        	call	_wireReadDataByte
7536  000b 85            	popw	x
7537  000c 4d            	tnz	a
7538  000d 2604          	jrne	L1352
7539                     ; 2092 		return 0;
7541  000f 4f            	clr	a
7544  0010 5b01          	addw	sp,#1
7545  0012 81            	ret
7546  0013               L1352:
7547                     ; 2095 	return 1;
7549  0013 a601          	ld	a,#1
7552  0015 5b01          	addw	sp,#1
7553  0017 81            	ret
7586                     ; 2103 uint8_t getGestureMode(void)
7586                     ; 2104 {
7587                     .text:	section	.text,new
7588  0000               _getGestureMode:
7590  0000 88            	push	a
7591       00000001      OFST:	set	1
7594                     ; 2108 	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7596  0001 96            	ldw	x,sp
7597  0002 1c0001        	addw	x,#OFST+0
7598  0005 89            	pushw	x
7599  0006 a6ab          	ld	a,#171
7600  0008 cd0000        	call	_wireReadDataByte
7602  000b 85            	popw	x
7603  000c 4d            	tnz	a
7604  000d 2605          	jrne	L7452
7605                     ; 2109 		return APDS9960_ERROR;
7607  000f a6ff          	ld	a,#255
7610  0011 5b01          	addw	sp,#1
7611  0013 81            	ret
7612  0014               L7452:
7613                     ; 2113 	val &= 0b00000001;
7615  0014 7b01          	ld	a,(OFST+0,sp)
7616  0016 a401          	and	a,#1
7617  0018 6b01          	ld	(OFST+0,sp),a
7618                     ; 2115 	return val;
7620  001a 7b01          	ld	a,(OFST+0,sp)
7623  001c 5b01          	addw	sp,#1
7624  001e 81            	ret
7665                     ; 2124 uint8_t setGestureMode(uint8_t mode)
7665                     ; 2125 {
7666                     .text:	section	.text,new
7667  0000               _setGestureMode:
7669  0000 88            	push	a
7670  0001 88            	push	a
7671       00000001      OFST:	set	1
7674                     ; 2129 	if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7676  0002 96            	ldw	x,sp
7677  0003 1c0001        	addw	x,#OFST+0
7678  0006 89            	pushw	x
7679  0007 a6ab          	ld	a,#171
7680  0009 cd0000        	call	_wireReadDataByte
7682  000c 85            	popw	x
7683  000d 4d            	tnz	a
7684  000e 2603          	jrne	L7652
7685                     ; 2130 		return 0;
7687  0010 4f            	clr	a
7689  0011 201f          	jra	L663
7690  0013               L7652:
7691                     ; 2134 	mode &= 0b00000001;
7693  0013 7b02          	ld	a,(OFST+1,sp)
7694  0015 a401          	and	a,#1
7695  0017 6b02          	ld	(OFST+1,sp),a
7696                     ; 2135 	val &= 0b11111110;
7698  0019 7b01          	ld	a,(OFST+0,sp)
7699  001b a4fe          	and	a,#254
7700  001d 6b01          	ld	(OFST+0,sp),a
7701                     ; 2136 	val |= mode;
7703  001f 7b01          	ld	a,(OFST+0,sp)
7704  0021 1a02          	or	a,(OFST+1,sp)
7705  0023 6b01          	ld	(OFST+0,sp),a
7706                     ; 2139 	if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
7708  0025 7b01          	ld	a,(OFST+0,sp)
7709  0027 97            	ld	xl,a
7710  0028 a6ab          	ld	a,#171
7711  002a 95            	ld	xh,a
7712  002b cd0000        	call	_wireWriteDataByte
7714  002e 4d            	tnz	a
7715  002f 2603          	jrne	L1752
7716                     ; 2140 		return 0;
7718  0031 4f            	clr	a
7720  0032               L663:
7722  0032 85            	popw	x
7723  0033 81            	ret
7724  0034               L1752:
7725                     ; 2143 	return 1;
7727  0034 a601          	ld	a,#1
7729  0036 20fa          	jra	L663
7769                     ; 2156 uint8_t wireWriteByte(uint8_t val)
7769                     ; 2157 {
7770                     .text:	section	.text,new
7771  0000               _wireWriteByte:
7773  0000 88            	push	a
7774  0001 88            	push	a
7775       00000001      OFST:	set	1
7778                     ; 2160 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR, &val, 1, 10);
7780  0002 4b0a          	push	#10
7781  0004 4b01          	push	#1
7782  0006 96            	ldw	x,sp
7783  0007 1c0004        	addw	x,#OFST+3
7784  000a 89            	pushw	x
7785  000b ae0039        	ldw	x,#57
7786  000e cd0000        	call	_I2C_WriteBytes
7788  0011 5b04          	addw	sp,#4
7789  0013 6b01          	ld	(OFST+0,sp),a
7790                     ; 2161 	if(ret != IIC_SUCCESS) {
7792  0015 0d01          	tnz	(OFST+0,sp)
7793  0017 2703          	jreq	L1162
7794                     ; 2162 		return 0;
7796  0019 4f            	clr	a
7798  001a 2002          	jra	L273
7799  001c               L1162:
7800                     ; 2164 	return 1;
7802  001c a601          	ld	a,#1
7804  001e               L273:
7806  001e 85            	popw	x
7807  001f 81            	ret
7864                     ; 2174 uint8_t wireWriteDataByte(uint8_t reg, uint8_t val)
7864                     ; 2175 {
7865                     .text:	section	.text,new
7866  0000               _wireWriteDataByte:
7868  0000 5203          	subw	sp,#3
7869       00000003      OFST:	set	3
7872                     ; 2179 	buffer[0] = reg;
7874  0002 9e            	ld	a,xh
7875  0003 6b02          	ld	(OFST-1,sp),a
7876                     ; 2180 	buffer[1] = val;
7878  0005 9f            	ld	a,xl
7879  0006 6b03          	ld	(OFST+0,sp),a
7880                     ; 2181 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR, buffer, 2, 10);
7882  0008 4b0a          	push	#10
7883  000a 4b02          	push	#2
7884  000c 96            	ldw	x,sp
7885  000d 1c0004        	addw	x,#OFST+1
7886  0010 89            	pushw	x
7887  0011 ae0039        	ldw	x,#57
7888  0014 cd0000        	call	_I2C_WriteBytes
7890  0017 5b04          	addw	sp,#4
7891  0019 6b01          	ld	(OFST-2,sp),a
7892                     ; 2182 	if(ret != IIC_SUCCESS) {
7894  001b 0d01          	tnz	(OFST-2,sp)
7895  001d 2703          	jreq	L7362
7896                     ; 2183 		return 0;
7898  001f 4f            	clr	a
7900  0020 2002          	jra	L673
7901  0022               L7362:
7902                     ; 2185 	return 1;
7904  0022 a601          	ld	a,#1
7906  0024               L673:
7908  0024 5b03          	addw	sp,#3
7909  0026 81            	ret
7912                     	switch	.bss
7913  0000               L1462_buffer:
7914  0000 000000000000  	ds.b	128
7986                     ; 2196 uint8_t wireWriteDataBlock(  uint8_t reg,
7986                     ; 2197                              uint8_t *val,
7986                     ; 2198                              unsigned int len)
7986                     ; 2199 {
7987                     .text:	section	.text,new
7988  0000               _wireWriteDataBlock:
7990  0000 88            	push	a
7991  0001 5203          	subw	sp,#3
7992       00000003      OFST:	set	3
7995                     ; 2203 	buffer[0] = reg;
7997  0003 c70000        	ld	L1462_buffer,a
7998                     ; 2204 	for(i = 0; (i < len)&&(i<sizeof(buffer)); i++) {
8000  0006 5f            	clrw	x
8001  0007 1f02          	ldw	(OFST-1,sp),x
8003  0009 2017          	jra	L1072
8004  000b               L5762:
8005                     ; 2205 		buffer[1+i] = *val++;
8007  000b 1e07          	ldw	x,(OFST+4,sp)
8008  000d 1c0001        	addw	x,#1
8009  0010 1f07          	ldw	(OFST+4,sp),x
8010  0012 1d0001        	subw	x,#1
8011  0015 f6            	ld	a,(x)
8012  0016 1e02          	ldw	x,(OFST-1,sp)
8013  0018 d70001        	ld	(L1462_buffer+1,x),a
8014                     ; 2204 	for(i = 0; (i < len)&&(i<sizeof(buffer)); i++) {
8016  001b 1e02          	ldw	x,(OFST-1,sp)
8017  001d 1c0001        	addw	x,#1
8018  0020 1f02          	ldw	(OFST-1,sp),x
8019  0022               L1072:
8022  0022 1e02          	ldw	x,(OFST-1,sp)
8023  0024 1309          	cpw	x,(OFST+6,sp)
8024  0026 2407          	jruge	L5072
8026  0028 1e02          	ldw	x,(OFST-1,sp)
8027  002a a30080        	cpw	x,#128
8028  002d 25dc          	jrult	L5762
8029  002f               L5072:
8030                     ; 2207 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR,buffer,i+1,100);
8032  002f 4b64          	push	#100
8033  0031 7b04          	ld	a,(OFST+1,sp)
8034  0033 4c            	inc	a
8035  0034 88            	push	a
8036  0035 ae0000        	ldw	x,#L1462_buffer
8037  0038 89            	pushw	x
8038  0039 ae0039        	ldw	x,#57
8039  003c cd0000        	call	_I2C_WriteBytes
8041  003f 5b04          	addw	sp,#4
8042  0041 6b01          	ld	(OFST-2,sp),a
8043                     ; 2208 	if(ret != IIC_SUCCESS) {
8045  0043 0d01          	tnz	(OFST-2,sp)
8046  0045 2703          	jreq	L7072
8047                     ; 2209 		return 0;
8049  0047 4f            	clr	a
8051  0048 2002          	jra	L204
8052  004a               L7072:
8053                     ; 2211 	return 1;
8055  004a a601          	ld	a,#1
8057  004c               L204:
8059  004c 5b04          	addw	sp,#4
8060  004e 81            	ret
8110                     ; 2221 uint8_t wireReadDataByte(uint8_t reg, uint8_t *val)
8110                     ; 2222 {
8111                     .text:	section	.text,new
8112  0000               _wireReadDataByte:
8114  0000 88            	push	a
8115  0001 88            	push	a
8116       00000001      OFST:	set	1
8119                     ; 2224 	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR, &reg, 1, val, 1, 10);
8121  0002 4b0a          	push	#10
8122  0004 4b01          	push	#1
8123  0006 1e07          	ldw	x,(OFST+6,sp)
8124  0008 89            	pushw	x
8125  0009 4b01          	push	#1
8126  000b 96            	ldw	x,sp
8127  000c 1c0007        	addw	x,#OFST+6
8128  000f 89            	pushw	x
8129  0010 ae0039        	ldw	x,#57
8130  0013 cd0000        	call	_I2C_WriteReadBytes
8132  0016 5b07          	addw	sp,#7
8133  0018 6b01          	ld	(OFST+0,sp),a
8134                     ; 2225 	if(ret != IIC_SUCCESS) {
8136  001a 0d01          	tnz	(OFST+0,sp)
8137  001c 2703          	jreq	L3372
8138                     ; 2226 		return 0;
8140  001e 4f            	clr	a
8142  001f 2002          	jra	L604
8143  0021               L3372:
8144                     ; 2228 	return 1;
8146  0021 a601          	ld	a,#1
8148  0023               L604:
8150  0023 85            	popw	x
8151  0024 81            	ret
8208                     ; 2239 int wireReadDataBlock(uint8_t reg, uint8_t *val, unsigned int len)
8208                     ; 2240 {
8209                     .text:	section	.text,new
8210  0000               _wireReadDataBlock:
8212  0000 88            	push	a
8213  0001 88            	push	a
8214       00000001      OFST:	set	1
8217                     ; 2242 	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR,&reg,1,val,len,100);
8219  0002 4b64          	push	#100
8220  0004 7b09          	ld	a,(OFST+8,sp)
8221  0006 88            	push	a
8222  0007 1e07          	ldw	x,(OFST+6,sp)
8223  0009 89            	pushw	x
8224  000a 4b01          	push	#1
8225  000c 96            	ldw	x,sp
8226  000d 1c0007        	addw	x,#OFST+6
8227  0010 89            	pushw	x
8228  0011 ae0039        	ldw	x,#57
8229  0014 cd0000        	call	_I2C_WriteReadBytes
8231  0017 5b07          	addw	sp,#7
8232  0019 6b01          	ld	(OFST+0,sp),a
8233                     ; 2243 	if(ret != IIC_SUCCESS) {
8235  001b 0d01          	tnz	(OFST+0,sp)
8236  001d 2703          	jreq	L1672
8237                     ; 2244 		return 0;
8239  001f 5f            	clrw	x
8241  0020 2002          	jra	L214
8242  0022               L1672:
8243                     ; 2246 	return len;
8245  0022 1e07          	ldw	x,(OFST+6,sp)
8247  0024               L214:
8249  0024 5b02          	addw	sp,#2
8250  0026 81            	ret
8407                     	switch	.bss
8408  0080               _gesture_motion_:
8409  0080 0000          	ds.b	2
8410                     	xdef	_gesture_motion_
8411  0082               _gesture_state_:
8412  0082 0000          	ds.b	2
8413                     	xdef	_gesture_state_
8414  0084               _gesture_far_count_:
8415  0084 0000          	ds.b	2
8416                     	xdef	_gesture_far_count_
8417  0086               _gesture_near_count_:
8418  0086 0000          	ds.b	2
8419                     	xdef	_gesture_near_count_
8420  0088               _gesture_lr_count_:
8421  0088 0000          	ds.b	2
8422                     	xdef	_gesture_lr_count_
8423  008a               _gesture_ud_count_:
8424  008a 0000          	ds.b	2
8425                     	xdef	_gesture_ud_count_
8426  008c               _gesture_lr_delta_:
8427  008c 0000          	ds.b	2
8428                     	xdef	_gesture_lr_delta_
8429  008e               _gesture_ud_delta_:
8430  008e 0000          	ds.b	2
8431                     	xdef	_gesture_ud_delta_
8432  0090               _gesture_data_:
8433  0090 000000000000  	ds.b	132
8434                     	xdef	_gesture_data_
8435                     	xref	_I2CTimeOut
8436                     	xref	_I2C_WriteReadBytes
8437                     	xref	_I2C_WriteBytes
8438                     	xref	_I2C_Config
8439                     	xdef	_gesture_read_data
8440                     	xdef	_readGesture
8441                     	xdef	_isGestureAvailable
8442                     	xdef	_readProximity
8443                     	xdef	_readBlueLight
8444                     	xdef	_readGreenLight
8445                     	xdef	_readRedLight
8446                     	xdef	_readAmbientLight
8447                     	xdef	_clearProximityInt
8448                     	xdef	_clearAmbientLightInt
8449                     	xdef	_setGestureIntEnable
8450                     	xdef	_getGestureIntEnable
8451                     	xdef	_setProximityIntEnable
8452                     	xdef	_getProximityIntEnable
8453                     	xdef	_setAmbientLightIntEnable
8454                     	xdef	_getAmbientLightIntEnable
8455                     	xdef	_setProximityIntHighThreshold
8456                     	xdef	_getProximityIntHighThreshold
8457                     	xdef	_setProximityIntLowThreshold
8458                     	xdef	_getProximityIntLowThreshold
8459                     	xdef	_setLightIntHighThreshold
8460                     	xdef	_getLightIntHighThreshold
8461                     	xdef	_setLightIntLowThreshold
8462                     	xdef	_getLightIntLowThreshold
8463                     	xdef	_setGestureGain
8464                     	xdef	_getGestureGain
8465                     	xdef	_setProximityGain
8466                     	xdef	_getProximityGain
8467                     	xdef	_setAmbientLightGain
8468                     	xdef	_getAmbientLightGain
8469                     	xdef	_setGestureLEDDrive
8470                     	xdef	_getGestureLEDDrive
8471                     	xdef	_setLEDDrive
8472                     	xdef	_getLEDDrive
8473                     	xdef	_disableGestureSensor
8474                     	xdef	_enableGestureSensor
8475                     	xdef	_disableProximitySensor
8476                     	xdef	_enableProximitySensor
8477                     	xdef	_disableLightSensor
8478                     	xdef	_enableLightSensor
8479                     	xdef	_disablePower
8480                     	xdef	_enablePower
8481                     	xdef	_setMode
8482                     	xdef	_getMode
8483                     	xdef	_init
8484                     	xdef	_SparkFun_APDS9960
8485                     	xdef	_wireReadDataBlock
8486                     	xdef	_wireReadDataByte
8487                     	xdef	_wireWriteDataBlock
8488                     	xdef	_wireWriteDataByte
8489                     	xdef	_wireWriteByte
8490                     	xdef	_setGestureMode
8491                     	xdef	_getGestureMode
8492                     	xdef	_setGestureWaitTime
8493                     	xdef	_getGestureWaitTime
8494                     	xdef	_setGestureExitThresh
8495                     	xdef	_getGestureExitThresh
8496                     	xdef	_setGestureEnterThresh
8497                     	xdef	_getGestureEnterThresh
8498                     	xdef	_setProxPhotoMask
8499                     	xdef	_getProxPhotoMask
8500                     	xdef	_setProxGainCompEnable
8501                     	xdef	_getProxGainCompEnable
8502                     	xdef	_setLEDBoost
8503                     	xdef	_getLEDBoost
8504                     	xdef	_setProxIntHighThresh
8505                     	xdef	_getProxIntHighThresh
8506                     	xdef	_setProxIntLowThresh
8507                     	xdef	_getProxIntLowThresh
8508                     	xdef	_decodeGesture
8509                     	xdef	_processGestureData
8510                     	xdef	_resetGestureParameters
8511                     	xref	_abs
8512                     	xref.b	c_x
8513                     	xref.b	c_y
8533                     	xref	c_idiv
8534                     	xref	c_imul
8535                     	end
