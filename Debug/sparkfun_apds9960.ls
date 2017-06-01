   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  41                     ; 79 void SparkFun_APDS9960(void)
  41                     ; 80 {
  43                     .text:	section	.text,new
  44  0000               _SparkFun_APDS9960:
  48                     ; 81     gesture_ud_delta_ = 0;
  50  0000 5f            	clrw	x
  51  0001 cf008e        	ldw	_gesture_ud_delta_,x
  52                     ; 82     gesture_lr_delta_ = 0;
  54  0004 5f            	clrw	x
  55  0005 cf008c        	ldw	_gesture_lr_delta_,x
  56                     ; 84     gesture_ud_count_ = 0;
  58  0008 5f            	clrw	x
  59  0009 cf008a        	ldw	_gesture_ud_count_,x
  60                     ; 85     gesture_lr_count_ = 0;
  62  000c 5f            	clrw	x
  63  000d cf0088        	ldw	_gesture_lr_count_,x
  64                     ; 87     gesture_near_count_ = 0;
  66  0010 5f            	clrw	x
  67  0011 cf0086        	ldw	_gesture_near_count_,x
  68                     ; 88     gesture_far_count_ = 0;
  70  0014 5f            	clrw	x
  71  0015 cf0084        	ldw	_gesture_far_count_,x
  72                     ; 90     gesture_state_ = 0;
  74  0018 5f            	clrw	x
  75  0019 cf0082        	ldw	_gesture_state_,x
  76                     ; 91     gesture_motion_ = DIR_NONE;
  78  001c 5f            	clrw	x
  79  001d cf0080        	ldw	_gesture_motion_,x
  80                     ; 92 }
  83  0020 81            	ret
 140                     ; 99 uint8_t init(void)
 140                     ; 100 {
 141                     .text:	section	.text,new
 142  0000               _init:
 144  0000 89            	pushw	x
 145       00000002      OFST:	set	2
 148                     ; 104 		SparkFun_APDS9960();
 150  0001 cd0000        	call	_SparkFun_APDS9960
 152                     ; 106     ret = I2C_Config();
 154  0004 cd0000        	call	_I2C_Config
 156  0007 6b01          	ld	(OFST-1,sp),a
 157                     ; 107 		if(ret != IIC_SUCCESS){
 159  0009 0d01          	tnz	(OFST-1,sp)
 160  000b 2703          	jreq	L73
 161                     ; 108 			return 0;
 163  000d 4f            	clr	a
 165  000e 200f          	jra	L01
 166  0010               L73:
 167                     ; 112     if( !wireReadDataByte(APDS9960_ID, &id) ) {
 169  0010 96            	ldw	x,sp
 170  0011 1c0002        	addw	x,#OFST+0
 171  0014 89            	pushw	x
 172  0015 a692          	ld	a,#146
 173  0017 cd0000        	call	_wireReadDataByte
 175  001a 85            	popw	x
 176  001b 4d            	tnz	a
 177  001c 2603          	jrne	L14
 178                     ; 113         return 0;
 180  001e 4f            	clr	a
 182  001f               L01:
 184  001f 85            	popw	x
 185  0020 81            	ret
 186  0021               L14:
 187                     ; 115     if( !(id == APDS9960_ID_1 || id == APDS9960_ID_2) ) {
 189  0021 7b02          	ld	a,(OFST+0,sp)
 190  0023 a1ab          	cp	a,#171
 191  0025 2709          	jreq	L34
 193  0027 7b02          	ld	a,(OFST+0,sp)
 194  0029 a19c          	cp	a,#156
 195  002b 2703          	jreq	L34
 196                     ; 116         return 0;
 198  002d 4f            	clr	a
 200  002e 20ef          	jra	L01
 201  0030               L34:
 202                     ; 120     if( !setMode(ALL, OFF) ) {
 204  0030 5f            	clrw	x
 205  0031 a607          	ld	a,#7
 206  0033 95            	ld	xh,a
 207  0034 cd0000        	call	_setMode
 209  0037 4d            	tnz	a
 210  0038 2603          	jrne	L54
 211                     ; 121         return 0;
 213  003a 4f            	clr	a
 215  003b 20e2          	jra	L01
 216  003d               L54:
 217                     ; 125     if( !wireWriteDataByte(APDS9960_ATIME, DEFAULT_ATIME) ) {
 219  003d ae00db        	ldw	x,#219
 220  0040 a681          	ld	a,#129
 221  0042 95            	ld	xh,a
 222  0043 cd0000        	call	_wireWriteDataByte
 224  0046 4d            	tnz	a
 225  0047 2603          	jrne	L74
 226                     ; 126         return 0;
 228  0049 4f            	clr	a
 230  004a 20d3          	jra	L01
 231  004c               L74:
 232                     ; 128     if( !wireWriteDataByte(APDS9960_WTIME, DEFAULT_WTIME) ) {
 234  004c ae00f6        	ldw	x,#246
 235  004f a683          	ld	a,#131
 236  0051 95            	ld	xh,a
 237  0052 cd0000        	call	_wireWriteDataByte
 239  0055 4d            	tnz	a
 240  0056 2603          	jrne	L15
 241                     ; 129         return 0;
 243  0058 4f            	clr	a
 245  0059 20c4          	jra	L01
 246  005b               L15:
 247                     ; 131     if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_PROX_PPULSE) ) {
 249  005b ae0087        	ldw	x,#135
 250  005e a68e          	ld	a,#142
 251  0060 95            	ld	xh,a
 252  0061 cd0000        	call	_wireWriteDataByte
 254  0064 4d            	tnz	a
 255  0065 2603          	jrne	L35
 256                     ; 132         return 0;
 258  0067 4f            	clr	a
 260  0068 20b5          	jra	L01
 261  006a               L35:
 262                     ; 134     if( !wireWriteDataByte(APDS9960_POFFSET_UR, DEFAULT_POFFSET_UR) ) {
 264  006a 5f            	clrw	x
 265  006b a69d          	ld	a,#157
 266  006d 95            	ld	xh,a
 267  006e cd0000        	call	_wireWriteDataByte
 269  0071 4d            	tnz	a
 270  0072 2603          	jrne	L55
 271                     ; 135         return 0;
 273  0074 4f            	clr	a
 275  0075 20a8          	jra	L01
 276  0077               L55:
 277                     ; 137     if( !wireWriteDataByte(APDS9960_POFFSET_DL, DEFAULT_POFFSET_DL) ) {
 279  0077 5f            	clrw	x
 280  0078 a69e          	ld	a,#158
 281  007a 95            	ld	xh,a
 282  007b cd0000        	call	_wireWriteDataByte
 284  007e 4d            	tnz	a
 285  007f 2603          	jrne	L75
 286                     ; 138         return 0;
 288  0081 4f            	clr	a
 290  0082 200d          	jra	L21
 291  0084               L75:
 292                     ; 140     if( !wireWriteDataByte(APDS9960_CONFIG1, DEFAULT_CONFIG1) ) {
 294  0084 ae0060        	ldw	x,#96
 295  0087 a68d          	ld	a,#141
 296  0089 95            	ld	xh,a
 297  008a cd0000        	call	_wireWriteDataByte
 299  008d 4d            	tnz	a
 300  008e 2603          	jrne	L16
 301                     ; 141         return 0;
 303  0090 4f            	clr	a
 305  0091               L21:
 307  0091 85            	popw	x
 308  0092 81            	ret
 309  0093               L16:
 310                     ; 143     if( !setLEDDrive(DEFAULT_LDRIVE) ) {
 312  0093 4f            	clr	a
 313  0094 cd0000        	call	_setLEDDrive
 315  0097 4d            	tnz	a
 316  0098 2603          	jrne	L36
 317                     ; 144         return 0;
 319  009a 4f            	clr	a
 321  009b 20f4          	jra	L21
 322  009d               L36:
 323                     ; 146     if( !setProximityGain(DEFAULT_PGAIN) ) {
 325  009d a602          	ld	a,#2
 326  009f cd0000        	call	_setProximityGain
 328  00a2 4d            	tnz	a
 329  00a3 2603          	jrne	L56
 330                     ; 147         return 0;
 332  00a5 4f            	clr	a
 334  00a6 20e9          	jra	L21
 335  00a8               L56:
 336                     ; 149     if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
 338  00a8 a601          	ld	a,#1
 339  00aa cd0000        	call	_setAmbientLightGain
 341  00ad 4d            	tnz	a
 342  00ae 2603          	jrne	L76
 343                     ; 150         return 0;
 345  00b0 4f            	clr	a
 347  00b1 20de          	jra	L21
 348  00b3               L76:
 349                     ; 152     if( !setProxIntLowThresh(DEFAULT_PILT) ) {
 351  00b3 4f            	clr	a
 352  00b4 cd0000        	call	_setProxIntLowThresh
 354  00b7 4d            	tnz	a
 355  00b8 2603          	jrne	L17
 356                     ; 153         return 0;
 358  00ba 4f            	clr	a
 360  00bb 20d4          	jra	L21
 361  00bd               L17:
 362                     ; 155     if( !setProxIntHighThresh(DEFAULT_PIHT) ) {
 364  00bd a632          	ld	a,#50
 365  00bf cd0000        	call	_setProxIntHighThresh
 367  00c2 4d            	tnz	a
 368  00c3 2603          	jrne	L37
 369                     ; 156         return 0;
 371  00c5 4f            	clr	a
 373  00c6 20c9          	jra	L21
 374  00c8               L37:
 375                     ; 158     if( !setLightIntLowThreshold(DEFAULT_AILT) ) {
 377  00c8 aeffff        	ldw	x,#65535
 378  00cb cd0000        	call	_setLightIntLowThreshold
 380  00ce 4d            	tnz	a
 381  00cf 2603          	jrne	L57
 382                     ; 159         return 0;
 384  00d1 4f            	clr	a
 386  00d2 20bd          	jra	L21
 387  00d4               L57:
 388                     ; 161     if( !setLightIntHighThreshold(DEFAULT_AIHT) ) {
 390  00d4 5f            	clrw	x
 391  00d5 cd0000        	call	_setLightIntHighThreshold
 393  00d8 4d            	tnz	a
 394  00d9 2603          	jrne	L77
 395                     ; 162         return 0;
 397  00db 4f            	clr	a
 399  00dc 20b3          	jra	L21
 400  00de               L77:
 401                     ; 164     if( !wireWriteDataByte(APDS9960_PERS, DEFAULT_PERS) ) {
 403  00de ae0011        	ldw	x,#17
 404  00e1 a68c          	ld	a,#140
 405  00e3 95            	ld	xh,a
 406  00e4 cd0000        	call	_wireWriteDataByte
 408  00e7 4d            	tnz	a
 409  00e8 2603          	jrne	L101
 410                     ; 165         return 0;
 412  00ea 4f            	clr	a
 414  00eb 20a4          	jra	L21
 415  00ed               L101:
 416                     ; 167     if( !wireWriteDataByte(APDS9960_CONFIG2, DEFAULT_CONFIG2) ) {
 418  00ed ae0001        	ldw	x,#1
 419  00f0 a690          	ld	a,#144
 420  00f2 95            	ld	xh,a
 421  00f3 cd0000        	call	_wireWriteDataByte
 423  00f6 4d            	tnz	a
 424  00f7 2603          	jrne	L301
 425                     ; 168         return 0;
 427  00f9 4f            	clr	a
 429  00fa 200b          	jra	L41
 430  00fc               L301:
 431                     ; 170     if( !wireWriteDataByte(APDS9960_CONFIG3, DEFAULT_CONFIG3) ) {
 433  00fc 5f            	clrw	x
 434  00fd a69f          	ld	a,#159
 435  00ff 95            	ld	xh,a
 436  0100 cd0000        	call	_wireWriteDataByte
 438  0103 4d            	tnz	a
 439  0104 2603          	jrne	L501
 440                     ; 171         return 0;
 442  0106 4f            	clr	a
 444  0107               L41:
 446  0107 85            	popw	x
 447  0108 81            	ret
 448  0109               L501:
 449                     ; 175     if( !setGestureEnterThresh(DEFAULT_GPENTH) ) {
 451  0109 a628          	ld	a,#40
 452  010b cd0000        	call	_setGestureEnterThresh
 454  010e 4d            	tnz	a
 455  010f 2603          	jrne	L701
 456                     ; 176         return 0;
 458  0111 4f            	clr	a
 460  0112 20f3          	jra	L41
 461  0114               L701:
 462                     ; 178     if( !setGestureExitThresh(DEFAULT_GEXTH) ) {
 464  0114 a61e          	ld	a,#30
 465  0116 cd0000        	call	_setGestureExitThresh
 467  0119 4d            	tnz	a
 468  011a 2603          	jrne	L111
 469                     ; 179         return 0;
 471  011c 4f            	clr	a
 473  011d 20e8          	jra	L41
 474  011f               L111:
 475                     ; 181     if( !wireWriteDataByte(APDS9960_GCONF1, DEFAULT_GCONF1) ) {
 477  011f ae0040        	ldw	x,#64
 478  0122 a6a2          	ld	a,#162
 479  0124 95            	ld	xh,a
 480  0125 cd0000        	call	_wireWriteDataByte
 482  0128 4d            	tnz	a
 483  0129 2603          	jrne	L311
 484                     ; 182         return 0;
 486  012b 4f            	clr	a
 488  012c 20d9          	jra	L41
 489  012e               L311:
 490                     ; 184     if( !setGestureGain(DEFAULT_GGAIN) ) {
 492  012e a602          	ld	a,#2
 493  0130 cd0000        	call	_setGestureGain
 495  0133 4d            	tnz	a
 496  0134 2603          	jrne	L511
 497                     ; 185         return 0;
 499  0136 4f            	clr	a
 501  0137 20ce          	jra	L41
 502  0139               L511:
 503                     ; 187     if( !setGestureLEDDrive(DEFAULT_GLDRIVE) ) {
 505  0139 4f            	clr	a
 506  013a cd0000        	call	_setGestureLEDDrive
 508  013d 4d            	tnz	a
 509  013e 2603          	jrne	L711
 510                     ; 188         return 0;
 512  0140 4f            	clr	a
 514  0141 20c4          	jra	L41
 515  0143               L711:
 516                     ; 190     if( !setGestureWaitTime(DEFAULT_GWTIME) ) {
 518  0143 a601          	ld	a,#1
 519  0145 cd0000        	call	_setGestureWaitTime
 521  0148 4d            	tnz	a
 522  0149 2603          	jrne	L121
 523                     ; 191         return 0;
 525  014b 4f            	clr	a
 527  014c 20b9          	jra	L41
 528  014e               L121:
 529                     ; 193     if( !wireWriteDataByte(APDS9960_GOFFSET_U, DEFAULT_GOFFSET) ) {
 531  014e 5f            	clrw	x
 532  014f a6a4          	ld	a,#164
 533  0151 95            	ld	xh,a
 534  0152 cd0000        	call	_wireWriteDataByte
 536  0155 4d            	tnz	a
 537  0156 2603          	jrne	L321
 538                     ; 194         return 0;
 540  0158 4f            	clr	a
 542  0159 20ac          	jra	L41
 543  015b               L321:
 544                     ; 196     if( !wireWriteDataByte(APDS9960_GOFFSET_D, DEFAULT_GOFFSET) ) {
 546  015b 5f            	clrw	x
 547  015c a6a5          	ld	a,#165
 548  015e 95            	ld	xh,a
 549  015f cd0000        	call	_wireWriteDataByte
 551  0162 4d            	tnz	a
 552  0163 2603          	jrne	L521
 553                     ; 197         return 0;
 555  0165 4f            	clr	a
 557  0166 209f          	jra	L41
 558  0168               L521:
 559                     ; 199     if( !wireWriteDataByte(APDS9960_GOFFSET_L, DEFAULT_GOFFSET) ) {
 561  0168 5f            	clrw	x
 562  0169 a6a7          	ld	a,#167
 563  016b 95            	ld	xh,a
 564  016c cd0000        	call	_wireWriteDataByte
 566  016f 4d            	tnz	a
 567  0170 2603          	jrne	L721
 568                     ; 200         return 0;
 570  0172 4f            	clr	a
 572  0173 200b          	jra	L61
 573  0175               L721:
 574                     ; 202     if( !wireWriteDataByte(APDS9960_GOFFSET_R, DEFAULT_GOFFSET) ) {
 576  0175 5f            	clrw	x
 577  0176 a6a9          	ld	a,#169
 578  0178 95            	ld	xh,a
 579  0179 cd0000        	call	_wireWriteDataByte
 581  017c 4d            	tnz	a
 582  017d 2603          	jrne	L131
 583                     ; 203         return 0;
 585  017f 4f            	clr	a
 587  0180               L61:
 589  0180 85            	popw	x
 590  0181 81            	ret
 591  0182               L131:
 592                     ; 205     if( !wireWriteDataByte(APDS9960_GPULSE, DEFAULT_GPULSE) ) {
 594  0182 ae00c9        	ldw	x,#201
 595  0185 a6a6          	ld	a,#166
 596  0187 95            	ld	xh,a
 597  0188 cd0000        	call	_wireWriteDataByte
 599  018b 4d            	tnz	a
 600  018c 2603          	jrne	L331
 601                     ; 206         return 0;
 603  018e 4f            	clr	a
 605  018f 20ef          	jra	L61
 606  0191               L331:
 607                     ; 208     if( !wireWriteDataByte(APDS9960_GCONF3, DEFAULT_GCONF3) ) {
 609  0191 5f            	clrw	x
 610  0192 a6aa          	ld	a,#170
 611  0194 95            	ld	xh,a
 612  0195 cd0000        	call	_wireWriteDataByte
 614  0198 4d            	tnz	a
 615  0199 2603          	jrne	L531
 616                     ; 209         return 0;
 618  019b 4f            	clr	a
 620  019c 20e2          	jra	L61
 621  019e               L531:
 622                     ; 211     if( !setGestureIntEnable(DEFAULT_GIEN) ) {
 624  019e 4f            	clr	a
 625  019f cd0000        	call	_setGestureIntEnable
 627  01a2 4d            	tnz	a
 628  01a3 2603          	jrne	L731
 629                     ; 212         return 0;
 631  01a5 4f            	clr	a
 633  01a6 20d8          	jra	L61
 634  01a8               L731:
 635                     ; 243     return 1;
 637  01a8 a601          	ld	a,#1
 639  01aa 20d4          	jra	L61
 672                     ; 255 uint8_t getMode(void)
 672                     ; 256 {
 673                     .text:	section	.text,new
 674  0000               _getMode:
 676  0000 88            	push	a
 677       00000001      OFST:	set	1
 680                     ; 260     if( !wireReadDataByte(APDS9960_ENABLE, &enable_value) ) {
 682  0001 96            	ldw	x,sp
 683  0002 1c0001        	addw	x,#OFST+0
 684  0005 89            	pushw	x
 685  0006 a680          	ld	a,#128
 686  0008 cd0000        	call	_wireReadDataByte
 688  000b 85            	popw	x
 689  000c 4d            	tnz	a
 690  000d 2605          	jrne	L551
 691                     ; 261         return APDS9960_ERROR;
 693  000f a6ff          	ld	a,#255
 696  0011 5b01          	addw	sp,#1
 697  0013 81            	ret
 698  0014               L551:
 699                     ; 264     return enable_value;
 701  0014 7b01          	ld	a,(OFST+0,sp)
 704  0016 5b01          	addw	sp,#1
 705  0018 81            	ret
 753                     ; 274 uint8_t setMode(uint8_t mode, uint8_t enable)
 753                     ; 275 {
 754                     .text:	section	.text,new
 755  0000               _setMode:
 757  0000 89            	pushw	x
 758  0001 88            	push	a
 759       00000001      OFST:	set	1
 762                     ; 279     reg_val = getMode();
 764  0002 cd0000        	call	_getMode
 766  0005 6b01          	ld	(OFST+0,sp),a
 767                     ; 280     if( reg_val == APDS9960_ERROR ) {
 769  0007 7b01          	ld	a,(OFST+0,sp)
 770  0009 a1ff          	cp	a,#255
 771  000b 2603          	jrne	L771
 772                     ; 281         return 0;
 774  000d 4f            	clr	a
 776  000e 2056          	jra	L43
 777  0010               L771:
 778                     ; 285     enable = enable & 0x01;
 780  0010 7b03          	ld	a,(OFST+2,sp)
 781  0012 a401          	and	a,#1
 782  0014 6b03          	ld	(OFST+2,sp),a
 783                     ; 286     if( mode >= 0 && mode <= 6 ) {
 785  0016 7b02          	ld	a,(OFST+1,sp)
 786  0018 a107          	cp	a,#7
 787  001a 242b          	jruge	L102
 788                     ; 287         if (enable) {
 790  001c 0d03          	tnz	(OFST+2,sp)
 791  001e 2713          	jreq	L302
 792                     ; 288             reg_val |= (1 << mode);
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
 810                     ; 290             reg_val &= ~(1 << mode);
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
 828                     ; 292     } else if( mode == ALL ) {
 830  0047 7b02          	ld	a,(OFST+1,sp)
 831  0049 a107          	cp	a,#7
 832  004b 260c          	jrne	L702
 833                     ; 293         if (enable) {
 835  004d 0d03          	tnz	(OFST+2,sp)
 836  004f 2706          	jreq	L312
 837                     ; 294             reg_val = 0x7F;
 839  0051 a67f          	ld	a,#127
 840  0053 6b01          	ld	(OFST+0,sp),a
 842  0055 2002          	jra	L702
 843  0057               L312:
 844                     ; 296             reg_val = 0x00;
 846  0057 0f01          	clr	(OFST+0,sp)
 847  0059               L702:
 848                     ; 301     if( !wireWriteDataByte(APDS9960_ENABLE, reg_val) ) {
 850  0059 7b01          	ld	a,(OFST+0,sp)
 851  005b 97            	ld	xl,a
 852  005c a680          	ld	a,#128
 853  005e 95            	ld	xh,a
 854  005f cd0000        	call	_wireWriteDataByte
 856  0062 4d            	tnz	a
 857  0063 2604          	jrne	L712
 858                     ; 302         return 0;
 860  0065 4f            	clr	a
 862  0066               L43:
 864  0066 5b03          	addw	sp,#3
 865  0068 81            	ret
 866  0069               L712:
 867                     ; 305     return 1;
 869  0069 a601          	ld	a,#1
 871  006b 20f9          	jra	L43
 907                     ; 314 uint8_t enableLightSensor(uint8_t interrupts)
 907                     ; 315 {
 908                     .text:	section	.text,new
 909  0000               _enableLightSensor:
 911  0000 88            	push	a
 912       00000000      OFST:	set	0
 915                     ; 318     if( !setAmbientLightGain(DEFAULT_AGAIN) ) {
 917  0001 a601          	ld	a,#1
 918  0003 cd0000        	call	_setAmbientLightGain
 920  0006 4d            	tnz	a
 921  0007 2604          	jrne	L532
 922                     ; 319         return 0;
 924  0009 4f            	clr	a
 927  000a 5b01          	addw	sp,#1
 928  000c 81            	ret
 929  000d               L532:
 930                     ; 321     if( interrupts ) {
 932  000d 0d01          	tnz	(OFST+1,sp)
 933  000f 270c          	jreq	L732
 934                     ; 322         if( !setAmbientLightIntEnable(1) ) {
 936  0011 a601          	ld	a,#1
 937  0013 cd0000        	call	_setAmbientLightIntEnable
 939  0016 4d            	tnz	a
 940  0017 260f          	jrne	L342
 941                     ; 323             return 0;
 943  0019 4f            	clr	a
 946  001a 5b01          	addw	sp,#1
 947  001c 81            	ret
 948  001d               L732:
 949                     ; 326         if( !setAmbientLightIntEnable(0) ) {
 951  001d 4f            	clr	a
 952  001e cd0000        	call	_setAmbientLightIntEnable
 954  0021 4d            	tnz	a
 955  0022 2604          	jrne	L342
 956                     ; 327             return 0;
 958  0024 4f            	clr	a
 961  0025 5b01          	addw	sp,#1
 962  0027 81            	ret
 963  0028               L342:
 964                     ; 330     if( !enablePower() ){
 966  0028 cd0000        	call	_enablePower
 968  002b 4d            	tnz	a
 969  002c 2604          	jrne	L742
 970                     ; 331         return 0;
 972  002e 4f            	clr	a
 975  002f 5b01          	addw	sp,#1
 976  0031 81            	ret
 977  0032               L742:
 978                     ; 333     if( !setMode(AMBIENT_LIGHT, 1) ) {
 980  0032 ae0001        	ldw	x,#1
 981  0035 a601          	ld	a,#1
 982  0037 95            	ld	xh,a
 983  0038 cd0000        	call	_setMode
 985  003b 4d            	tnz	a
 986  003c 2604          	jrne	L152
 987                     ; 334         return 0;
 989  003e 4f            	clr	a
 992  003f 5b01          	addw	sp,#1
 993  0041 81            	ret
 994  0042               L152:
 995                     ; 337     return 1;
 997  0042 a601          	ld	a,#1
1000  0044 5b01          	addw	sp,#1
1001  0046 81            	ret
1026                     ; 346 uint8_t disableLightSensor(void)
1026                     ; 347 {
1027                     .text:	section	.text,new
1028  0000               _disableLightSensor:
1032                     ; 348     if( !setAmbientLightIntEnable(0) ) {
1034  0000 4f            	clr	a
1035  0001 cd0000        	call	_setAmbientLightIntEnable
1037  0004 4d            	tnz	a
1038  0005 2602          	jrne	L362
1039                     ; 349         return 0;
1041  0007 4f            	clr	a
1044  0008 81            	ret
1045  0009               L362:
1046                     ; 351     if( !setMode(AMBIENT_LIGHT, 0) ) {
1048  0009 5f            	clrw	x
1049  000a a601          	ld	a,#1
1050  000c 95            	ld	xh,a
1051  000d cd0000        	call	_setMode
1053  0010 4d            	tnz	a
1054  0011 2602          	jrne	L562
1055                     ; 352         return 0;
1057  0013 4f            	clr	a
1060  0014 81            	ret
1061  0015               L562:
1062                     ; 355     return 1;
1064  0015 a601          	ld	a,#1
1067  0017 81            	ret
1105                     ; 364 uint8_t enableProximitySensor(uint8_t interrupts)
1105                     ; 365 {
1106                     .text:	section	.text,new
1107  0000               _enableProximitySensor:
1109  0000 88            	push	a
1110       00000000      OFST:	set	0
1113                     ; 367     if( !setProximityGain(DEFAULT_PGAIN) ) {
1115  0001 a602          	ld	a,#2
1116  0003 cd0000        	call	_setProximityGain
1118  0006 4d            	tnz	a
1119  0007 2604          	jrne	L303
1120                     ; 368         return 0;
1122  0009 4f            	clr	a
1125  000a 5b01          	addw	sp,#1
1126  000c 81            	ret
1127  000d               L303:
1128                     ; 370     if( !setLEDDrive(DEFAULT_LDRIVE) ) {
1130  000d 4f            	clr	a
1131  000e cd0000        	call	_setLEDDrive
1133  0011 4d            	tnz	a
1134  0012 2604          	jrne	L503
1135                     ; 371         return 0;
1137  0014 4f            	clr	a
1140  0015 5b01          	addw	sp,#1
1141  0017 81            	ret
1142  0018               L503:
1143                     ; 373     if( interrupts ) {
1145  0018 0d01          	tnz	(OFST+1,sp)
1146  001a 270c          	jreq	L703
1147                     ; 374         if( !setProximityIntEnable(1) ) {
1149  001c a601          	ld	a,#1
1150  001e cd0000        	call	_setProximityIntEnable
1152  0021 4d            	tnz	a
1153  0022 260f          	jrne	L313
1154                     ; 375             return 0;
1156  0024 4f            	clr	a
1159  0025 5b01          	addw	sp,#1
1160  0027 81            	ret
1161  0028               L703:
1162                     ; 378         if( !setProximityIntEnable(0) ) {
1164  0028 4f            	clr	a
1165  0029 cd0000        	call	_setProximityIntEnable
1167  002c 4d            	tnz	a
1168  002d 2604          	jrne	L313
1169                     ; 379             return 0;
1171  002f 4f            	clr	a
1174  0030 5b01          	addw	sp,#1
1175  0032 81            	ret
1176  0033               L313:
1177                     ; 382     if( !enablePower() ){
1179  0033 cd0000        	call	_enablePower
1181  0036 4d            	tnz	a
1182  0037 2604          	jrne	L713
1183                     ; 383         return 0;
1185  0039 4f            	clr	a
1188  003a 5b01          	addw	sp,#1
1189  003c 81            	ret
1190  003d               L713:
1191                     ; 385     if( !setMode(PROXIMITY, 1) ) {
1193  003d ae0001        	ldw	x,#1
1194  0040 a602          	ld	a,#2
1195  0042 95            	ld	xh,a
1196  0043 cd0000        	call	_setMode
1198  0046 4d            	tnz	a
1199  0047 2604          	jrne	L123
1200                     ; 386         return 0;
1202  0049 4f            	clr	a
1205  004a 5b01          	addw	sp,#1
1206  004c 81            	ret
1207  004d               L123:
1208                     ; 389     return 1;
1210  004d a601          	ld	a,#1
1213  004f 5b01          	addw	sp,#1
1214  0051 81            	ret
1240                     ; 397 uint8_t disableProximitySensor(void)
1240                     ; 398 {
1241                     .text:	section	.text,new
1242  0000               _disableProximitySensor:
1246                     ; 399 	if( !setProximityIntEnable(0) ) {
1248  0000 4f            	clr	a
1249  0001 cd0000        	call	_setProximityIntEnable
1251  0004 4d            	tnz	a
1252  0005 2602          	jrne	L333
1253                     ; 400 		return 0;
1255  0007 4f            	clr	a
1258  0008 81            	ret
1259  0009               L333:
1260                     ; 402 	if( !setMode(PROXIMITY, 0) ) {
1262  0009 5f            	clrw	x
1263  000a a602          	ld	a,#2
1264  000c 95            	ld	xh,a
1265  000d cd0000        	call	_setMode
1267  0010 4d            	tnz	a
1268  0011 2602          	jrne	L533
1269                     ; 403 		return 0;
1271  0013 4f            	clr	a
1274  0014 81            	ret
1275  0015               L533:
1276                     ; 406 	return 1;
1278  0015 a601          	ld	a,#1
1281  0017 81            	ret
1321                     ; 415 uint8_t enableGestureSensor(uint8_t interrupts)
1321                     ; 416 {
1322                     .text:	section	.text,new
1323  0000               _enableGestureSensor:
1325  0000 88            	push	a
1326       00000000      OFST:	set	0
1329                     ; 424     resetGestureParameters();
1331  0001 cd0000        	call	_resetGestureParameters
1333                     ; 425     if( !wireWriteDataByte(APDS9960_WTIME, 0xFF) ) {
1335  0004 ae00ff        	ldw	x,#255
1336  0007 a683          	ld	a,#131
1337  0009 95            	ld	xh,a
1338  000a cd0000        	call	_wireWriteDataByte
1340  000d 4d            	tnz	a
1341  000e 2604          	jrne	L353
1342                     ; 426         return 0;
1344  0010 4f            	clr	a
1347  0011 5b01          	addw	sp,#1
1348  0013 81            	ret
1349  0014               L353:
1350                     ; 428     if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_GESTURE_PPULSE) ) {
1352  0014 ae0089        	ldw	x,#137
1353  0017 a68e          	ld	a,#142
1354  0019 95            	ld	xh,a
1355  001a cd0000        	call	_wireWriteDataByte
1357  001d 4d            	tnz	a
1358  001e 2604          	jrne	L553
1359                     ; 429         return 0;
1361  0020 4f            	clr	a
1364  0021 5b01          	addw	sp,#1
1365  0023 81            	ret
1366  0024               L553:
1367                     ; 431     if( !setLEDBoost(LED_BOOST_300) ) {
1369  0024 a603          	ld	a,#3
1370  0026 cd0000        	call	_setLEDBoost
1372  0029 4d            	tnz	a
1373  002a 2604          	jrne	L753
1374                     ; 432         return 0;
1376  002c 4f            	clr	a
1379  002d 5b01          	addw	sp,#1
1380  002f 81            	ret
1381  0030               L753:
1382                     ; 434     if( interrupts ) {
1384  0030 0d01          	tnz	(OFST+1,sp)
1385  0032 270c          	jreq	L163
1386                     ; 435         if( !setGestureIntEnable(1) ) {
1388  0034 a601          	ld	a,#1
1389  0036 cd0000        	call	_setGestureIntEnable
1391  0039 4d            	tnz	a
1392  003a 260f          	jrne	L563
1393                     ; 436             return 0;
1395  003c 4f            	clr	a
1398  003d 5b01          	addw	sp,#1
1399  003f 81            	ret
1400  0040               L163:
1401                     ; 439         if( !setGestureIntEnable(0) ) {
1403  0040 4f            	clr	a
1404  0041 cd0000        	call	_setGestureIntEnable
1406  0044 4d            	tnz	a
1407  0045 2604          	jrne	L563
1408                     ; 440             return 0;
1410  0047 4f            	clr	a
1413  0048 5b01          	addw	sp,#1
1414  004a 81            	ret
1415  004b               L563:
1416                     ; 443     if( !setGestureMode(1) ) {
1418  004b a601          	ld	a,#1
1419  004d cd0000        	call	_setGestureMode
1421  0050 4d            	tnz	a
1422  0051 2604          	jrne	L173
1423                     ; 444         return 0;
1425  0053 4f            	clr	a
1428  0054 5b01          	addw	sp,#1
1429  0056 81            	ret
1430  0057               L173:
1431                     ; 446     if( !enablePower() ){
1433  0057 cd0000        	call	_enablePower
1435  005a 4d            	tnz	a
1436  005b 2604          	jrne	L373
1437                     ; 447         return 0;
1439  005d 4f            	clr	a
1442  005e 5b01          	addw	sp,#1
1443  0060 81            	ret
1444  0061               L373:
1445                     ; 449     if( !setMode(WAIT, 1) ) {
1447  0061 ae0001        	ldw	x,#1
1448  0064 a603          	ld	a,#3
1449  0066 95            	ld	xh,a
1450  0067 cd0000        	call	_setMode
1452  006a 4d            	tnz	a
1453  006b 2604          	jrne	L573
1454                     ; 450         return 0;
1456  006d 4f            	clr	a
1459  006e 5b01          	addw	sp,#1
1460  0070 81            	ret
1461  0071               L573:
1462                     ; 452     if( !setMode(PROXIMITY, 1) ) {
1464  0071 ae0001        	ldw	x,#1
1465  0074 a602          	ld	a,#2
1466  0076 95            	ld	xh,a
1467  0077 cd0000        	call	_setMode
1469  007a 4d            	tnz	a
1470  007b 2604          	jrne	L773
1471                     ; 453         return 0;
1473  007d 4f            	clr	a
1476  007e 5b01          	addw	sp,#1
1477  0080 81            	ret
1478  0081               L773:
1479                     ; 455     if( !setMode(GESTURE, 1) ) {
1481  0081 ae0001        	ldw	x,#1
1482  0084 a606          	ld	a,#6
1483  0086 95            	ld	xh,a
1484  0087 cd0000        	call	_setMode
1486  008a 4d            	tnz	a
1487  008b 2604          	jrne	L104
1488                     ; 456         return 0;
1490  008d 4f            	clr	a
1493  008e 5b01          	addw	sp,#1
1494  0090 81            	ret
1495  0091               L104:
1496                     ; 459     return 1;
1498  0091 a601          	ld	a,#1
1501  0093 5b01          	addw	sp,#1
1502  0095 81            	ret
1530                     ; 467 uint8_t disableGestureSensor(void)
1530                     ; 468 {
1531                     .text:	section	.text,new
1532  0000               _disableGestureSensor:
1536                     ; 469     resetGestureParameters();
1538  0000 cd0000        	call	_resetGestureParameters
1540                     ; 470     if( !setGestureIntEnable(0) ) {
1542  0003 4f            	clr	a
1543  0004 cd0000        	call	_setGestureIntEnable
1545  0007 4d            	tnz	a
1546  0008 2602          	jrne	L314
1547                     ; 471         return 0;
1549  000a 4f            	clr	a
1552  000b 81            	ret
1553  000c               L314:
1554                     ; 473     if( !setGestureMode(0) ) {
1556  000c 4f            	clr	a
1557  000d cd0000        	call	_setGestureMode
1559  0010 4d            	tnz	a
1560  0011 2602          	jrne	L514
1561                     ; 474         return 0;
1563  0013 4f            	clr	a
1566  0014 81            	ret
1567  0015               L514:
1568                     ; 476     if( !setMode(GESTURE, 0) ) {
1570  0015 5f            	clrw	x
1571  0016 a606          	ld	a,#6
1572  0018 95            	ld	xh,a
1573  0019 cd0000        	call	_setMode
1575  001c 4d            	tnz	a
1576  001d 2602          	jrne	L714
1577                     ; 477         return 0;
1579  001f 4f            	clr	a
1582  0020 81            	ret
1583  0021               L714:
1584                     ; 480     return 1;
1586  0021 a601          	ld	a,#1
1589  0023 81            	ret
1622                     ; 488 uint8_t isGestureAvailable(void)
1622                     ; 489 {
1623                     .text:	section	.text,new
1624  0000               _isGestureAvailable:
1626  0000 88            	push	a
1627       00000001      OFST:	set	1
1630                     ; 493     if( !wireReadDataByte(APDS9960_GSTATUS, &val) ) {
1632  0001 96            	ldw	x,sp
1633  0002 1c0001        	addw	x,#OFST+0
1634  0005 89            	pushw	x
1635  0006 a6af          	ld	a,#175
1636  0008 cd0000        	call	_wireReadDataByte
1638  000b 85            	popw	x
1639  000c 4d            	tnz	a
1640  000d 2605          	jrne	L534
1641                     ; 494         return APDS9960_ERROR;
1643  000f a6ff          	ld	a,#255
1646  0011 5b01          	addw	sp,#1
1647  0013 81            	ret
1648  0014               L534:
1649                     ; 498     val &= APDS9960_GVALID;
1651  0014 7b01          	ld	a,(OFST+0,sp)
1652  0016 a401          	and	a,#1
1653  0018 6b01          	ld	(OFST+0,sp),a
1654                     ; 501     if( val == 1) {
1656  001a 7b01          	ld	a,(OFST+0,sp)
1657  001c a101          	cp	a,#1
1658  001e 2605          	jrne	L734
1659                     ; 502         return 1;
1661  0020 a601          	ld	a,#1
1664  0022 5b01          	addw	sp,#1
1665  0024 81            	ret
1666  0025               L734:
1667                     ; 504         return 0;
1669  0025 4f            	clr	a
1672  0026 5b01          	addw	sp,#1
1673  0028 81            	ret
1753                     ; 513 int readGesture(void)
1753                     ; 514 {
1754                     .text:	section	.text,new
1755  0000               _readGesture:
1757  0000 5287          	subw	sp,#135
1758       00000087      OFST:	set	135
1761                     ; 515     uint8_t fifo_level = 0;
1763  0002 0f04          	clr	(OFST-131,sp)
1764                     ; 516     uint8_t bytes_read = 0;
1766  0004 7b05          	ld	a,(OFST-130,sp)
1767  0006 97            	ld	xl,a
1768                     ; 523     if( !isGestureAvailable() || !(getMode() & 0b01000001) ) {
1770  0007 cd0000        	call	_isGestureAvailable
1772  000a 4d            	tnz	a
1773  000b 2707          	jreq	L574
1775  000d cd0000        	call	_getMode
1777  0010 a541          	bcp	a,#65
1778  0012 2603          	jrne	L774
1779  0014               L574:
1780                     ; 524         return DIR_NONE;
1782  0014 5f            	clrw	x
1784  0015 201c          	jra	L65
1785  0017               L774:
1786                     ; 531         delay_ms(FIFO_PAUSE_TIME);
1788  0017 ae001e        	ldw	x,#30
1789  001a cf0000        	ldw	_TIM3_tout,x
1790  001d               L305:
1794  001d ce0000        	ldw	x,_TIM3_tout
1795  0020 26fb          	jrne	L305
1796                     ; 534         if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
1799  0022 96            	ldw	x,sp
1800  0023 1c0003        	addw	x,#OFST-132
1801  0026 89            	pushw	x
1802  0027 a6af          	ld	a,#175
1803  0029 cd0000        	call	_wireReadDataByte
1805  002c 85            	popw	x
1806  002d 4d            	tnz	a
1807  002e 2606          	jrne	L115
1808                     ; 535             return APDS9960_ERROR;
1810  0030 ae00ff        	ldw	x,#255
1812  0033               L65:
1814  0033 5b87          	addw	sp,#135
1815  0035 81            	ret
1816  0036               L115:
1817                     ; 539         if( (gstatus & APDS9960_GVALID) == APDS9960_GVALID ) {
1819  0036 7b03          	ld	a,(OFST-132,sp)
1820  0038 a401          	and	a,#1
1821  003a a101          	cp	a,#1
1822  003c 2703          	jreq	L06
1823  003e cc0108        	jp	L315
1824  0041               L06:
1825                     ; 542             if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) {
1827  0041 96            	ldw	x,sp
1828  0042 1c0004        	addw	x,#OFST-131
1829  0045 89            	pushw	x
1830  0046 a6ae          	ld	a,#174
1831  0048 cd0000        	call	_wireReadDataByte
1833  004b 85            	popw	x
1834  004c 4d            	tnz	a
1835  004d 2605          	jrne	L515
1836                     ; 543                 return APDS9960_ERROR;
1838  004f ae00ff        	ldw	x,#255
1840  0052 20df          	jra	L65
1841  0054               L515:
1842                     ; 552             if( fifo_level > 0) {
1844  0054 0d04          	tnz	(OFST-131,sp)
1845  0056 27bf          	jreq	L774
1846                     ; 553                 bytes_read = wireReadDataBlock(  APDS9960_GFIFO_U, 
1846                     ; 554                                                 (uint8_t*)fifo_data, 
1846                     ; 555                                                 (fifo_level * 4) );
1848  0058 7b04          	ld	a,(OFST-131,sp)
1849  005a 97            	ld	xl,a
1850  005b a604          	ld	a,#4
1851  005d 42            	mul	x,a
1852  005e 89            	pushw	x
1853  005f 96            	ldw	x,sp
1854  0060 1c0008        	addw	x,#OFST-127
1855  0063 89            	pushw	x
1856  0064 a6fc          	ld	a,#252
1857  0066 cd0000        	call	_wireReadDataBlock
1859  0069 5b04          	addw	sp,#4
1860  006b 01            	rrwa	x,a
1861  006c 6b05          	ld	(OFST-130,sp),a
1862  006e 02            	rlwa	x,a
1863                     ; 569                 if( bytes_read >= 4 ) {
1865  006f 7b05          	ld	a,(OFST-130,sp)
1866  0071 a104          	cp	a,#4
1867  0073 25a2          	jrult	L774
1868                     ; 570                     for( i = 0; i < bytes_read; i += 4 ) {
1870  0075 5f            	clrw	x
1871  0076 1f86          	ldw	(OFST-1,sp),x
1873  0078 206b          	jra	L725
1874  007a               L325:
1875                     ; 571                         gesture_data_.u_data[gesture_data_.index] = \
1875                     ; 572                                                             fifo_data[i + 0];
1877  007a c60110        	ld	a,_gesture_data_+128
1878  007d 5f            	clrw	x
1879  007e 97            	ld	xl,a
1880  007f 9096          	ldw	y,sp
1881  0081 72a90006      	addw	y,#OFST-129
1882  0085 1701          	ldw	(OFST-134,sp),y
1883  0087 1686          	ldw	y,(OFST-1,sp)
1884  0089 72f901        	addw	y,(OFST-134,sp)
1885  008c 90f6          	ld	a,(y)
1886  008e d70090        	ld	(_gesture_data_,x),a
1887                     ; 573                         gesture_data_.d_data[gesture_data_.index] = \
1887                     ; 574                                                             fifo_data[i + 1];
1889  0091 c60110        	ld	a,_gesture_data_+128
1890  0094 5f            	clrw	x
1891  0095 97            	ld	xl,a
1892  0096 9096          	ldw	y,sp
1893  0098 72a90007      	addw	y,#OFST-128
1894  009c 1701          	ldw	(OFST-134,sp),y
1895  009e 1686          	ldw	y,(OFST-1,sp)
1896  00a0 72f901        	addw	y,(OFST-134,sp)
1897  00a3 90f6          	ld	a,(y)
1898  00a5 d700b0        	ld	(_gesture_data_+32,x),a
1899                     ; 575                         gesture_data_.l_data[gesture_data_.index] = \
1899                     ; 576                                                             fifo_data[i + 2];
1901  00a8 c60110        	ld	a,_gesture_data_+128
1902  00ab 5f            	clrw	x
1903  00ac 97            	ld	xl,a
1904  00ad 9096          	ldw	y,sp
1905  00af 72a90008      	addw	y,#OFST-127
1906  00b3 1701          	ldw	(OFST-134,sp),y
1907  00b5 1686          	ldw	y,(OFST-1,sp)
1908  00b7 72f901        	addw	y,(OFST-134,sp)
1909  00ba 90f6          	ld	a,(y)
1910  00bc d700d0        	ld	(_gesture_data_+64,x),a
1911                     ; 577                         gesture_data_.r_data[gesture_data_.index] = \
1911                     ; 578                                                             fifo_data[i + 3];
1913  00bf c60110        	ld	a,_gesture_data_+128
1914  00c2 5f            	clrw	x
1915  00c3 97            	ld	xl,a
1916  00c4 9096          	ldw	y,sp
1917  00c6 72a90009      	addw	y,#OFST-126
1918  00ca 1701          	ldw	(OFST-134,sp),y
1919  00cc 1686          	ldw	y,(OFST-1,sp)
1920  00ce 72f901        	addw	y,(OFST-134,sp)
1921  00d1 90f6          	ld	a,(y)
1922  00d3 d700f0        	ld	(_gesture_data_+96,x),a
1923                     ; 579                         gesture_data_.index++;
1925  00d6 725c0110      	inc	_gesture_data_+128
1926                     ; 580                         gesture_data_.total_gestures++;
1928  00da 725c0111      	inc	_gesture_data_+129
1929                     ; 570                     for( i = 0; i < bytes_read; i += 4 ) {
1931  00de 1e86          	ldw	x,(OFST-1,sp)
1932  00e0 1c0004        	addw	x,#4
1933  00e3 1f86          	ldw	(OFST-1,sp),x
1934  00e5               L725:
1937  00e5 9c            	rvf
1938  00e6 7b05          	ld	a,(OFST-130,sp)
1939  00e8 5f            	clrw	x
1940  00e9 97            	ld	xl,a
1941  00ea bf00          	ldw	c_x,x
1942  00ec 1e86          	ldw	x,(OFST-1,sp)
1943  00ee b300          	cpw	x,c_x
1944  00f0 2f88          	jrslt	L325
1945                     ; 593                     if( processGestureData() ) {
1947  00f2 cd0000        	call	_processGestureData
1949  00f5 4d            	tnz	a
1950  00f6 2704          	jreq	L335
1951                     ; 594                         if( decodeGesture() ) {
1953  00f8 cd0000        	call	_decodeGesture
1955  00fb 4d            	tnz	a
1956  00fc               L335:
1957                     ; 603                     gesture_data_.index = 0;
1959  00fc 725f0110      	clr	_gesture_data_+128
1960                     ; 604                     gesture_data_.total_gestures = 0;
1962  0100 725f0111      	clr	_gesture_data_+129
1963  0104 ac170017      	jpf	L774
1964  0108               L315:
1965                     ; 610             delay_ms(FIFO_PAUSE_TIME);
1967  0108 ae001e        	ldw	x,#30
1968  010b cf0000        	ldw	_TIM3_tout,x
1969  010e               L145:
1973  010e ce0000        	ldw	x,_TIM3_tout
1974  0111 26fb          	jrne	L145
1975                     ; 611             decodeGesture();
1978  0113 cd0000        	call	_decodeGesture
1980                     ; 612             motion = gesture_motion_;
1982  0116 ce0080        	ldw	x,_gesture_motion_
1983  0119 1f86          	ldw	(OFST-1,sp),x
1984                     ; 617             resetGestureParameters();
1986  011b cd0000        	call	_resetGestureParameters
1988                     ; 618             return motion;
1990  011e 1e86          	ldw	x,(OFST-1,sp)
1992  0120 ac330033      	jpf	L65
2016                     ; 628 uint8_t enablePower(void)
2016                     ; 629 {
2017                     .text:	section	.text,new
2018  0000               _enablePower:
2022                     ; 630     if( !setMode(POWER, 1) ) {
2024  0000 ae0001        	ldw	x,#1
2025  0003 4f            	clr	a
2026  0004 95            	ld	xh,a
2027  0005 cd0000        	call	_setMode
2029  0008 4d            	tnz	a
2030  0009 2602          	jrne	L755
2031                     ; 631         return 0;
2033  000b 4f            	clr	a
2036  000c 81            	ret
2037  000d               L755:
2038                     ; 634     return 1;
2040  000d a601          	ld	a,#1
2043  000f 81            	ret
2067                     ; 642 uint8_t disablePower(void)
2067                     ; 643 {
2068                     .text:	section	.text,new
2069  0000               _disablePower:
2073                     ; 644     if( !setMode(POWER, 0) ) {
2075  0000 5f            	clrw	x
2076  0001 4f            	clr	a
2077  0002 95            	ld	xh,a
2078  0003 cd0000        	call	_setMode
2080  0006 4d            	tnz	a
2081  0007 2602          	jrne	L175
2082                     ; 645         return 0;
2084  0009 4f            	clr	a
2087  000a 81            	ret
2088  000b               L175:
2089                     ; 648     return 1;
2091  000b a601          	ld	a,#1
2094  000d 81            	ret
2137                     ; 661 uint8_t readAmbientLight(uint16_t *val)
2137                     ; 662 {
2138                     .text:	section	.text,new
2139  0000               _readAmbientLight:
2141  0000 89            	pushw	x
2142  0001 88            	push	a
2143       00000001      OFST:	set	1
2146                     ; 664     *val = 0;
2148  0002 905f          	clrw	y
2149  0004 ff            	ldw	(x),y
2150                     ; 667     if( !wireReadDataByte(APDS9960_CDATAL, &val_byte) ) {
2152  0005 96            	ldw	x,sp
2153  0006 1c0001        	addw	x,#OFST+0
2154  0009 89            	pushw	x
2155  000a a694          	ld	a,#148
2156  000c cd0000        	call	_wireReadDataByte
2158  000f 85            	popw	x
2159  0010 4d            	tnz	a
2160  0011 2603          	jrne	L316
2161                     ; 668         return 0;
2163  0013 4f            	clr	a
2165  0014 2017          	jra	L07
2166  0016               L316:
2167                     ; 670     *val = val_byte;
2169  0016 7b01          	ld	a,(OFST+0,sp)
2170  0018 5f            	clrw	x
2171  0019 97            	ld	xl,a
2172  001a 1602          	ldw	y,(OFST+1,sp)
2173  001c 90ff          	ldw	(y),x
2174                     ; 673     if( !wireReadDataByte(APDS9960_CDATAH, &val_byte) ) {
2176  001e 96            	ldw	x,sp
2177  001f 1c0001        	addw	x,#OFST+0
2178  0022 89            	pushw	x
2179  0023 a695          	ld	a,#149
2180  0025 cd0000        	call	_wireReadDataByte
2182  0028 85            	popw	x
2183  0029 4d            	tnz	a
2184  002a 2604          	jrne	L516
2185                     ; 674         return 0;
2187  002c 4f            	clr	a
2189  002d               L07:
2191  002d 5b03          	addw	sp,#3
2192  002f 81            	ret
2193  0030               L516:
2194                     ; 676     *val = *val + ((uint16_t)val_byte << 8);
2196  0030 1e02          	ldw	x,(OFST+1,sp)
2197  0032 7b01          	ld	a,(OFST+0,sp)
2198  0034 905f          	clrw	y
2199  0036 9097          	ld	yl,a
2200  0038 4f            	clr	a
2201  0039 9002          	rlwa	y,a
2202  003b 90bf00        	ldw	c_y,y
2203  003e 9093          	ldw	y,x
2204  0040 90fe          	ldw	y,(y)
2205  0042 72b90000      	addw	y,c_y
2206  0046 ff            	ldw	(x),y
2207                     ; 678     return 1;
2209  0047 a601          	ld	a,#1
2211  0049 20e2          	jra	L07
2254                     ; 687 uint8_t readRedLight(uint16_t *val)
2254                     ; 688 {
2255                     .text:	section	.text,new
2256  0000               _readRedLight:
2258  0000 89            	pushw	x
2259  0001 88            	push	a
2260       00000001      OFST:	set	1
2263                     ; 690     *val = 0;
2265  0002 905f          	clrw	y
2266  0004 ff            	ldw	(x),y
2267                     ; 693     if( !wireReadDataByte(APDS9960_RDATAL, &val_byte) ) {
2269  0005 96            	ldw	x,sp
2270  0006 1c0001        	addw	x,#OFST+0
2271  0009 89            	pushw	x
2272  000a a696          	ld	a,#150
2273  000c cd0000        	call	_wireReadDataByte
2275  000f 85            	popw	x
2276  0010 4d            	tnz	a
2277  0011 2603          	jrne	L736
2278                     ; 694         return 0;
2280  0013 4f            	clr	a
2282  0014 2017          	jra	L47
2283  0016               L736:
2284                     ; 696     *val = val_byte;
2286  0016 7b01          	ld	a,(OFST+0,sp)
2287  0018 5f            	clrw	x
2288  0019 97            	ld	xl,a
2289  001a 1602          	ldw	y,(OFST+1,sp)
2290  001c 90ff          	ldw	(y),x
2291                     ; 699     if( !wireReadDataByte(APDS9960_RDATAH, &val_byte) ) {
2293  001e 96            	ldw	x,sp
2294  001f 1c0001        	addw	x,#OFST+0
2295  0022 89            	pushw	x
2296  0023 a697          	ld	a,#151
2297  0025 cd0000        	call	_wireReadDataByte
2299  0028 85            	popw	x
2300  0029 4d            	tnz	a
2301  002a 2604          	jrne	L146
2302                     ; 700         return 0;
2304  002c 4f            	clr	a
2306  002d               L47:
2308  002d 5b03          	addw	sp,#3
2309  002f 81            	ret
2310  0030               L146:
2311                     ; 702     *val = *val + ((uint16_t)val_byte << 8);
2313  0030 1e02          	ldw	x,(OFST+1,sp)
2314  0032 7b01          	ld	a,(OFST+0,sp)
2315  0034 905f          	clrw	y
2316  0036 9097          	ld	yl,a
2317  0038 4f            	clr	a
2318  0039 9002          	rlwa	y,a
2319  003b 90bf00        	ldw	c_y,y
2320  003e 9093          	ldw	y,x
2321  0040 90fe          	ldw	y,(y)
2322  0042 72b90000      	addw	y,c_y
2323  0046 ff            	ldw	(x),y
2324                     ; 704     return 1;
2326  0047 a601          	ld	a,#1
2328  0049 20e2          	jra	L47
2371                     ; 713 uint8_t readGreenLight(uint16_t *val)
2371                     ; 714 {
2372                     .text:	section	.text,new
2373  0000               _readGreenLight:
2375  0000 89            	pushw	x
2376  0001 88            	push	a
2377       00000001      OFST:	set	1
2380                     ; 716     *val = 0;
2382  0002 905f          	clrw	y
2383  0004 ff            	ldw	(x),y
2384                     ; 719     if( !wireReadDataByte(APDS9960_GDATAL, &val_byte) ) {
2386  0005 96            	ldw	x,sp
2387  0006 1c0001        	addw	x,#OFST+0
2388  0009 89            	pushw	x
2389  000a a698          	ld	a,#152
2390  000c cd0000        	call	_wireReadDataByte
2392  000f 85            	popw	x
2393  0010 4d            	tnz	a
2394  0011 2603          	jrne	L366
2395                     ; 720         return 0;
2397  0013 4f            	clr	a
2399  0014 2017          	jra	L001
2400  0016               L366:
2401                     ; 722     *val = val_byte;
2403  0016 7b01          	ld	a,(OFST+0,sp)
2404  0018 5f            	clrw	x
2405  0019 97            	ld	xl,a
2406  001a 1602          	ldw	y,(OFST+1,sp)
2407  001c 90ff          	ldw	(y),x
2408                     ; 725     if( !wireReadDataByte(APDS9960_GDATAH, &val_byte) ) {
2410  001e 96            	ldw	x,sp
2411  001f 1c0001        	addw	x,#OFST+0
2412  0022 89            	pushw	x
2413  0023 a699          	ld	a,#153
2414  0025 cd0000        	call	_wireReadDataByte
2416  0028 85            	popw	x
2417  0029 4d            	tnz	a
2418  002a 2604          	jrne	L566
2419                     ; 726         return 0;
2421  002c 4f            	clr	a
2423  002d               L001:
2425  002d 5b03          	addw	sp,#3
2426  002f 81            	ret
2427  0030               L566:
2428                     ; 728     *val = *val + ((uint16_t)val_byte << 8);
2430  0030 1e02          	ldw	x,(OFST+1,sp)
2431  0032 7b01          	ld	a,(OFST+0,sp)
2432  0034 905f          	clrw	y
2433  0036 9097          	ld	yl,a
2434  0038 4f            	clr	a
2435  0039 9002          	rlwa	y,a
2436  003b 90bf00        	ldw	c_y,y
2437  003e 9093          	ldw	y,x
2438  0040 90fe          	ldw	y,(y)
2439  0042 72b90000      	addw	y,c_y
2440  0046 ff            	ldw	(x),y
2441                     ; 730     return 1;
2443  0047 a601          	ld	a,#1
2445  0049 20e2          	jra	L001
2488                     ; 739 uint8_t readBlueLight(uint16_t *val)
2488                     ; 740 {
2489                     .text:	section	.text,new
2490  0000               _readBlueLight:
2492  0000 89            	pushw	x
2493  0001 88            	push	a
2494       00000001      OFST:	set	1
2497                     ; 742     *val = 0;
2499  0002 905f          	clrw	y
2500  0004 ff            	ldw	(x),y
2501                     ; 745     if( !wireReadDataByte(APDS9960_BDATAL, &val_byte) ) {
2503  0005 96            	ldw	x,sp
2504  0006 1c0001        	addw	x,#OFST+0
2505  0009 89            	pushw	x
2506  000a a69a          	ld	a,#154
2507  000c cd0000        	call	_wireReadDataByte
2509  000f 85            	popw	x
2510  0010 4d            	tnz	a
2511  0011 2603          	jrne	L707
2512                     ; 746         return 0;
2514  0013 4f            	clr	a
2516  0014 2017          	jra	L401
2517  0016               L707:
2518                     ; 748     *val = val_byte;
2520  0016 7b01          	ld	a,(OFST+0,sp)
2521  0018 5f            	clrw	x
2522  0019 97            	ld	xl,a
2523  001a 1602          	ldw	y,(OFST+1,sp)
2524  001c 90ff          	ldw	(y),x
2525                     ; 751     if( !wireReadDataByte(APDS9960_BDATAH, &val_byte) ) {
2527  001e 96            	ldw	x,sp
2528  001f 1c0001        	addw	x,#OFST+0
2529  0022 89            	pushw	x
2530  0023 a69b          	ld	a,#155
2531  0025 cd0000        	call	_wireReadDataByte
2533  0028 85            	popw	x
2534  0029 4d            	tnz	a
2535  002a 2604          	jrne	L117
2536                     ; 752         return 0;
2538  002c 4f            	clr	a
2540  002d               L401:
2542  002d 5b03          	addw	sp,#3
2543  002f 81            	ret
2544  0030               L117:
2545                     ; 754     *val = *val + ((uint16_t)val_byte << 8);
2547  0030 1e02          	ldw	x,(OFST+1,sp)
2548  0032 7b01          	ld	a,(OFST+0,sp)
2549  0034 905f          	clrw	y
2550  0036 9097          	ld	yl,a
2551  0038 4f            	clr	a
2552  0039 9002          	rlwa	y,a
2553  003b 90bf00        	ldw	c_y,y
2554  003e 9093          	ldw	y,x
2555  0040 90fe          	ldw	y,(y)
2556  0042 72b90000      	addw	y,c_y
2557  0046 ff            	ldw	(x),y
2558                     ; 756     return 1;
2560  0047 a601          	ld	a,#1
2562  0049 20e2          	jra	L401
2598                     ; 769 uint8_t readProximity(uint8_t *val)
2598                     ; 770 {
2599                     .text:	section	.text,new
2600  0000               _readProximity:
2604                     ; 771     *val = 0;
2606  0000 7f            	clr	(x)
2607                     ; 774     if( !wireReadDataByte(APDS9960_PDATA, val) ) {
2609  0001 89            	pushw	x
2610  0002 a69c          	ld	a,#156
2611  0004 cd0000        	call	_wireReadDataByte
2613  0007 85            	popw	x
2614  0008 4d            	tnz	a
2615  0009 2602          	jrne	L137
2616                     ; 775         return 0;
2618  000b 4f            	clr	a
2621  000c 81            	ret
2622  000d               L137:
2623                     ; 778     return 1;
2625  000d a601          	ld	a,#1
2628  000f 81            	ret
2661                     ; 788 void resetGestureParameters(void)
2661                     ; 789 {
2662                     .text:	section	.text,new
2663  0000               _resetGestureParameters:
2667                     ; 790     gesture_data_.index = 0;
2669  0000 725f0110      	clr	_gesture_data_+128
2670                     ; 791     gesture_data_.total_gestures = 0;
2672  0004 725f0111      	clr	_gesture_data_+129
2673                     ; 793     gesture_ud_delta_ = 0;
2675  0008 5f            	clrw	x
2676  0009 cf008e        	ldw	_gesture_ud_delta_,x
2677                     ; 794     gesture_lr_delta_ = 0;
2679  000c 5f            	clrw	x
2680  000d cf008c        	ldw	_gesture_lr_delta_,x
2681                     ; 796     gesture_ud_count_ = 0;
2683  0010 5f            	clrw	x
2684  0011 cf008a        	ldw	_gesture_ud_count_,x
2685                     ; 797     gesture_lr_count_ = 0;
2687  0014 5f            	clrw	x
2688  0015 cf0088        	ldw	_gesture_lr_count_,x
2689                     ; 799     gesture_near_count_ = 0;
2691  0018 5f            	clrw	x
2692  0019 cf0086        	ldw	_gesture_near_count_,x
2693                     ; 800     gesture_far_count_ = 0;
2695  001c 5f            	clrw	x
2696  001d cf0084        	ldw	_gesture_far_count_,x
2697                     ; 802     gesture_state_ = 0;
2699  0020 5f            	clrw	x
2700  0021 cf0082        	ldw	_gesture_state_,x
2701                     ; 803     gesture_motion_ = DIR_NONE;
2703  0024 5f            	clrw	x
2704  0025 cf0080        	ldw	_gesture_motion_,x
2705                     ; 804 }
2708  0028 81            	ret
2847                     ; 811 uint8_t processGestureData(void)
2847                     ; 812 {
2848                     .text:	section	.text,new
2849  0000               _processGestureData:
2851  0000 5210          	subw	sp,#16
2852       00000010      OFST:	set	16
2855                     ; 813     uint8_t u_first = 0;
2857  0002 0f09          	clr	(OFST-7,sp)
2858                     ; 814     uint8_t d_first = 0;
2860  0004 0f0a          	clr	(OFST-6,sp)
2861                     ; 815     uint8_t l_first = 0;
2863  0006 0f0b          	clr	(OFST-5,sp)
2864                     ; 816     uint8_t r_first = 0;
2866  0008 0f0c          	clr	(OFST-4,sp)
2867                     ; 817     uint8_t u_last = 0;
2869  000a 0f05          	clr	(OFST-11,sp)
2870                     ; 818     uint8_t d_last = 0;
2872  000c 0f06          	clr	(OFST-10,sp)
2873                     ; 819     uint8_t l_last = 0;
2875  000e 0f07          	clr	(OFST-9,sp)
2876                     ; 820     uint8_t r_last = 0;
2878  0010 0f08          	clr	(OFST-8,sp)
2879                     ; 830     if( gesture_data_.total_gestures <= 4 ) {
2881  0012 c60111        	ld	a,_gesture_data_+129
2882  0015 a105          	cp	a,#5
2883  0017 2404          	jruge	L3101
2884                     ; 831         return 0;
2886  0019 4f            	clr	a
2888  001a cc009f        	jra	L431
2889  001d               L3101:
2890                     ; 835     if( (gesture_data_.total_gestures <= 32) && \
2890                     ; 836         (gesture_data_.total_gestures > 0) ) {
2892  001d c60111        	ld	a,_gesture_data_+129
2893  0020 a121          	cp	a,#33
2894  0022 2503          	jrult	L631
2895  0024 cc00fa        	jp	L5101
2896  0027               L631:
2898  0027 725d0111      	tnz	_gesture_data_+129
2899  002b 2603          	jrne	L041
2900  002d cc00fa        	jp	L5101
2901  0030               L041:
2902                     ; 839         for( i = 0; i < gesture_data_.total_gestures; i++ ) {
2904  0030 5f            	clrw	x
2905  0031 1f0f          	ldw	(OFST-1,sp),x
2907  0033 2059          	jra	L3201
2908  0035               L7101:
2909                     ; 840             if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
2909                     ; 841                 (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
2909                     ; 842                 (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
2909                     ; 843                 (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
2911  0035 1e0f          	ldw	x,(OFST-1,sp)
2912  0037 d60090        	ld	a,(_gesture_data_,x)
2913  003a a10b          	cp	a,#11
2914  003c 2549          	jrult	L7201
2916  003e 1e0f          	ldw	x,(OFST-1,sp)
2917  0040 d600b0        	ld	a,(_gesture_data_+32,x)
2918  0043 a10b          	cp	a,#11
2919  0045 2540          	jrult	L7201
2921  0047 1e0f          	ldw	x,(OFST-1,sp)
2922  0049 d600d0        	ld	a,(_gesture_data_+64,x)
2923  004c a10b          	cp	a,#11
2924  004e 2537          	jrult	L7201
2926  0050 1e0f          	ldw	x,(OFST-1,sp)
2927  0052 d600f0        	ld	a,(_gesture_data_+96,x)
2928  0055 a10b          	cp	a,#11
2929  0057 252e          	jrult	L7201
2930                     ; 845                 u_first = gesture_data_.u_data[i];
2932  0059 1e0f          	ldw	x,(OFST-1,sp)
2933  005b d60090        	ld	a,(_gesture_data_,x)
2934  005e 6b09          	ld	(OFST-7,sp),a
2935                     ; 846                 d_first = gesture_data_.d_data[i];
2937  0060 1e0f          	ldw	x,(OFST-1,sp)
2938  0062 d600b0        	ld	a,(_gesture_data_+32,x)
2939  0065 6b0a          	ld	(OFST-6,sp),a
2940                     ; 847                 l_first = gesture_data_.l_data[i];
2942  0067 1e0f          	ldw	x,(OFST-1,sp)
2943  0069 d600d0        	ld	a,(_gesture_data_+64,x)
2944  006c 6b0b          	ld	(OFST-5,sp),a
2945                     ; 848                 r_first = gesture_data_.r_data[i];
2947  006e 1e0f          	ldw	x,(OFST-1,sp)
2948  0070 d600f0        	ld	a,(_gesture_data_+96,x)
2949  0073 6b0c          	ld	(OFST-4,sp),a
2950                     ; 849                 break;
2951  0075               L5201:
2952                     ; 854         if( (u_first == 0) || (d_first == 0) || \
2952                     ; 855             (l_first == 0) || (r_first == 0) ) {
2954  0075 0d09          	tnz	(OFST-7,sp)
2955  0077 2725          	jreq	L3301
2957  0079 0d0a          	tnz	(OFST-6,sp)
2958  007b 2721          	jreq	L3301
2960  007d 0d0b          	tnz	(OFST-5,sp)
2961  007f 271d          	jreq	L3301
2963  0081 0d0c          	tnz	(OFST-4,sp)
2964  0083 261d          	jrne	L1301
2965  0085 2017          	jra	L3301
2966  0087               L7201:
2967                     ; 839         for( i = 0; i < gesture_data_.total_gestures; i++ ) {
2969  0087 1e0f          	ldw	x,(OFST-1,sp)
2970  0089 1c0001        	addw	x,#1
2971  008c 1f0f          	ldw	(OFST-1,sp),x
2972  008e               L3201:
2975  008e 9c            	rvf
2976  008f c60111        	ld	a,_gesture_data_+129
2977  0092 5f            	clrw	x
2978  0093 97            	ld	xl,a
2979  0094 bf00          	ldw	c_x,x
2980  0096 1e0f          	ldw	x,(OFST-1,sp)
2981  0098 b300          	cpw	x,c_x
2982  009a 2f99          	jrslt	L7101
2983  009c 20d7          	jra	L5201
2984  009e               L3301:
2985                     ; 857             return 0;
2987  009e 4f            	clr	a
2989  009f               L431:
2991  009f 5b10          	addw	sp,#16
2992  00a1 81            	ret
2993  00a2               L1301:
2994                     ; 860         for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
2996  00a2 c60111        	ld	a,_gesture_data_+129
2997  00a5 5f            	clrw	x
2998  00a6 97            	ld	xl,a
2999  00a7 5a            	decw	x
3000  00a8 1f0f          	ldw	(OFST-1,sp),x
3002  00aa 2049          	jra	L5401
3003  00ac               L1401:
3004                     ; 872             if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
3004                     ; 873                 (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
3004                     ; 874                 (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
3004                     ; 875                 (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
3006  00ac 1e0f          	ldw	x,(OFST-1,sp)
3007  00ae d60090        	ld	a,(_gesture_data_,x)
3008  00b1 a10b          	cp	a,#11
3009  00b3 2539          	jrult	L1501
3011  00b5 1e0f          	ldw	x,(OFST-1,sp)
3012  00b7 d600b0        	ld	a,(_gesture_data_+32,x)
3013  00ba a10b          	cp	a,#11
3014  00bc 2530          	jrult	L1501
3016  00be 1e0f          	ldw	x,(OFST-1,sp)
3017  00c0 d600d0        	ld	a,(_gesture_data_+64,x)
3018  00c3 a10b          	cp	a,#11
3019  00c5 2527          	jrult	L1501
3021  00c7 1e0f          	ldw	x,(OFST-1,sp)
3022  00c9 d600f0        	ld	a,(_gesture_data_+96,x)
3023  00cc a10b          	cp	a,#11
3024  00ce 251e          	jrult	L1501
3025                     ; 877                 u_last = gesture_data_.u_data[i];
3027  00d0 1e0f          	ldw	x,(OFST-1,sp)
3028  00d2 d60090        	ld	a,(_gesture_data_,x)
3029  00d5 6b05          	ld	(OFST-11,sp),a
3030                     ; 878                 d_last = gesture_data_.d_data[i];
3032  00d7 1e0f          	ldw	x,(OFST-1,sp)
3033  00d9 d600b0        	ld	a,(_gesture_data_+32,x)
3034  00dc 6b06          	ld	(OFST-10,sp),a
3035                     ; 879                 l_last = gesture_data_.l_data[i];
3037  00de 1e0f          	ldw	x,(OFST-1,sp)
3038  00e0 d600d0        	ld	a,(_gesture_data_+64,x)
3039  00e3 6b07          	ld	(OFST-9,sp),a
3040                     ; 880                 r_last = gesture_data_.r_data[i];
3042  00e5 1e0f          	ldw	x,(OFST-1,sp)
3043  00e7 d600f0        	ld	a,(_gesture_data_+96,x)
3044  00ea 6b08          	ld	(OFST-8,sp),a
3045                     ; 881                 break;
3047  00ec 200c          	jra	L5101
3048  00ee               L1501:
3049                     ; 860         for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
3051  00ee 1e0f          	ldw	x,(OFST-1,sp)
3052  00f0 1d0001        	subw	x,#1
3053  00f3 1f0f          	ldw	(OFST-1,sp),x
3054  00f5               L5401:
3057  00f5 9c            	rvf
3058  00f6 1e0f          	ldw	x,(OFST-1,sp)
3059  00f8 2eb2          	jrsge	L1401
3060  00fa               L5101:
3061                     ; 887     ud_ratio_first = ((u_first - d_first) * 100) / (u_first + d_first);
3063  00fa 7b09          	ld	a,(OFST-7,sp)
3064  00fc 5f            	clrw	x
3065  00fd 100a          	sub	a,(OFST-6,sp)
3066  00ff 2401          	jrnc	L411
3067  0101 5a            	decw	x
3068  0102               L411:
3069  0102 02            	rlwa	x,a
3070  0103 90ae0064      	ldw	y,#100
3071  0107 cd0000        	call	c_imul
3073  010a 89            	pushw	x
3074  010b 7b0b          	ld	a,(OFST-5,sp)
3075  010d 5f            	clrw	x
3076  010e 1b0c          	add	a,(OFST-4,sp)
3077  0110 2401          	jrnc	L611
3078  0112 5c            	incw	x
3079  0113               L611:
3080  0113 02            	rlwa	x,a
3081  0114 9085          	popw	y
3082  0116 51            	exgw	x,y
3083  0117 cd0000        	call	c_idiv
3085  011a 51            	exgw	x,y
3086  011b 1701          	ldw	(OFST-15,sp),y
3087                     ; 888     lr_ratio_first = ((l_first - r_first) * 100) / (l_first + r_first);
3089  011d 7b0b          	ld	a,(OFST-5,sp)
3090  011f 5f            	clrw	x
3091  0120 100c          	sub	a,(OFST-4,sp)
3092  0122 2401          	jrnc	L021
3093  0124 5a            	decw	x
3094  0125               L021:
3095  0125 02            	rlwa	x,a
3096  0126 90ae0064      	ldw	y,#100
3097  012a cd0000        	call	c_imul
3099  012d 89            	pushw	x
3100  012e 7b0d          	ld	a,(OFST-3,sp)
3101  0130 5f            	clrw	x
3102  0131 1b0e          	add	a,(OFST-2,sp)
3103  0133 2401          	jrnc	L221
3104  0135 5c            	incw	x
3105  0136               L221:
3106  0136 02            	rlwa	x,a
3107  0137 9085          	popw	y
3108  0139 51            	exgw	x,y
3109  013a cd0000        	call	c_idiv
3111  013d 51            	exgw	x,y
3112  013e 1703          	ldw	(OFST-13,sp),y
3113                     ; 889     ud_ratio_last = ((u_last - d_last) * 100) / (u_last + d_last);
3115  0140 7b05          	ld	a,(OFST-11,sp)
3116  0142 5f            	clrw	x
3117  0143 1006          	sub	a,(OFST-10,sp)
3118  0145 2401          	jrnc	L421
3119  0147 5a            	decw	x
3120  0148               L421:
3121  0148 02            	rlwa	x,a
3122  0149 90ae0064      	ldw	y,#100
3123  014d cd0000        	call	c_imul
3125  0150 89            	pushw	x
3126  0151 7b07          	ld	a,(OFST-9,sp)
3127  0153 5f            	clrw	x
3128  0154 1b08          	add	a,(OFST-8,sp)
3129  0156 2401          	jrnc	L621
3130  0158 5c            	incw	x
3131  0159               L621:
3132  0159 02            	rlwa	x,a
3133  015a 9085          	popw	y
3134  015c 51            	exgw	x,y
3135  015d cd0000        	call	c_idiv
3137  0160 51            	exgw	x,y
3138  0161 170d          	ldw	(OFST-3,sp),y
3139                     ; 890     lr_ratio_last = ((l_last - r_last) * 100) / (l_last + r_last);
3141  0163 7b07          	ld	a,(OFST-9,sp)
3142  0165 5f            	clrw	x
3143  0166 1008          	sub	a,(OFST-8,sp)
3144  0168 2401          	jrnc	L031
3145  016a 5a            	decw	x
3146  016b               L031:
3147  016b 02            	rlwa	x,a
3148  016c 90ae0064      	ldw	y,#100
3149  0170 cd0000        	call	c_imul
3151  0173 89            	pushw	x
3152  0174 7b09          	ld	a,(OFST-7,sp)
3153  0176 5f            	clrw	x
3154  0177 1b0a          	add	a,(OFST-6,sp)
3155  0179 2401          	jrnc	L231
3156  017b 5c            	incw	x
3157  017c               L231:
3158  017c 02            	rlwa	x,a
3159  017d 9085          	popw	y
3160  017f 51            	exgw	x,y
3161  0180 cd0000        	call	c_idiv
3163  0183 51            	exgw	x,y
3164  0184 170f          	ldw	(OFST-1,sp),y
3165                     ; 915     ud_delta = ud_ratio_last - ud_ratio_first;
3167  0186 1e0d          	ldw	x,(OFST-3,sp)
3168  0188 72f001        	subw	x,(OFST-15,sp)
3169  018b 1f0d          	ldw	(OFST-3,sp),x
3170                     ; 916     lr_delta = lr_ratio_last - lr_ratio_first;
3172  018d 1e0f          	ldw	x,(OFST-1,sp)
3173  018f 72f003        	subw	x,(OFST-13,sp)
3174  0192 1f0f          	ldw	(OFST-1,sp),x
3175                     ; 927     gesture_ud_delta_ += ud_delta;
3177  0194 ce008e        	ldw	x,_gesture_ud_delta_
3178  0197 72fb0d        	addw	x,(OFST-3,sp)
3179  019a cf008e        	ldw	_gesture_ud_delta_,x
3180                     ; 928     gesture_lr_delta_ += lr_delta;
3182  019d ce008c        	ldw	x,_gesture_lr_delta_
3183  01a0 72fb0f        	addw	x,(OFST-1,sp)
3184  01a3 cf008c        	ldw	_gesture_lr_delta_,x
3185                     ; 939     if( gesture_ud_delta_ >= GESTURE_SENSITIVITY_1 ) {
3187  01a6 9c            	rvf
3188  01a7 ce008e        	ldw	x,_gesture_ud_delta_
3189  01aa a30032        	cpw	x,#50
3190  01ad 2f08          	jrslt	L3501
3191                     ; 940         gesture_ud_count_ = 1;
3193  01af ae0001        	ldw	x,#1
3194  01b2 cf008a        	ldw	_gesture_ud_count_,x
3196  01b5 2015          	jra	L5501
3197  01b7               L3501:
3198                     ; 941     } else if( gesture_ud_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3200  01b7 9c            	rvf
3201  01b8 ce008e        	ldw	x,_gesture_ud_delta_
3202  01bb a3ffcf        	cpw	x,#65487
3203  01be 2e08          	jrsge	L7501
3204                     ; 942         gesture_ud_count_ = -1;
3206  01c0 aeffff        	ldw	x,#65535
3207  01c3 cf008a        	ldw	_gesture_ud_count_,x
3209  01c6 2004          	jra	L5501
3210  01c8               L7501:
3211                     ; 944         gesture_ud_count_ = 0;
3213  01c8 5f            	clrw	x
3214  01c9 cf008a        	ldw	_gesture_ud_count_,x
3215  01cc               L5501:
3216                     ; 948     if( gesture_lr_delta_ >= GESTURE_SENSITIVITY_1 ) {
3218  01cc 9c            	rvf
3219  01cd ce008c        	ldw	x,_gesture_lr_delta_
3220  01d0 a30032        	cpw	x,#50
3221  01d3 2f08          	jrslt	L3601
3222                     ; 949         gesture_lr_count_ = 1;
3224  01d5 ae0001        	ldw	x,#1
3225  01d8 cf0088        	ldw	_gesture_lr_count_,x
3227  01db 2015          	jra	L5601
3228  01dd               L3601:
3229                     ; 950     } else if( gesture_lr_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3231  01dd 9c            	rvf
3232  01de ce008c        	ldw	x,_gesture_lr_delta_
3233  01e1 a3ffcf        	cpw	x,#65487
3234  01e4 2e08          	jrsge	L7601
3235                     ; 951         gesture_lr_count_ = -1;
3237  01e6 aeffff        	ldw	x,#65535
3238  01e9 cf0088        	ldw	_gesture_lr_count_,x
3240  01ec 2004          	jra	L5601
3241  01ee               L7601:
3242                     ; 953         gesture_lr_count_ = 0;
3244  01ee 5f            	clrw	x
3245  01ef cf0088        	ldw	_gesture_lr_count_,x
3246  01f2               L5601:
3247                     ; 957     if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 0) ) {
3249  01f2 ce008a        	ldw	x,_gesture_ud_count_
3250  01f5 267b          	jrne	L3701
3252  01f7 ce0088        	ldw	x,_gesture_lr_count_
3253  01fa 2676          	jrne	L3701
3254                     ; 958         if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
3254                     ; 959             (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {
3256  01fc 9c            	rvf
3257  01fd 1e0d          	ldw	x,(OFST-3,sp)
3258  01ff cd0000        	call	_abs
3260  0202 a30014        	cpw	x,#20
3261  0205 2f03          	jrslt	L241
3262  0207 cc02b2        	jp	L7111
3263  020a               L241:
3265  020a 9c            	rvf
3266  020b 1e0f          	ldw	x,(OFST-1,sp)
3267  020d cd0000        	call	_abs
3269  0210 a30014        	cpw	x,#20
3270  0213 2f03          	jrslt	L441
3271  0215 cc02b2        	jp	L7111
3272  0218               L441:
3273                     ; 961             if( (ud_delta == 0) && (lr_delta == 0) ) {
3275  0218 1e0d          	ldw	x,(OFST-3,sp)
3276  021a 260f          	jrne	L7701
3278  021c 1e0f          	ldw	x,(OFST-1,sp)
3279  021e 260b          	jrne	L7701
3280                     ; 962                 gesture_near_count_++;
3282  0220 ce0086        	ldw	x,_gesture_near_count_
3283  0223 1c0001        	addw	x,#1
3284  0226 cf0086        	ldw	_gesture_near_count_,x
3286  0229 2011          	jra	L1011
3287  022b               L7701:
3288                     ; 963             } else if( (ud_delta != 0) || (lr_delta != 0) ) {
3290  022b 1e0d          	ldw	x,(OFST-3,sp)
3291  022d 2604          	jrne	L5011
3293  022f 1e0f          	ldw	x,(OFST-1,sp)
3294  0231 2709          	jreq	L1011
3295  0233               L5011:
3296                     ; 964                 gesture_far_count_++;
3298  0233 ce0084        	ldw	x,_gesture_far_count_
3299  0236 1c0001        	addw	x,#1
3300  0239 cf0084        	ldw	_gesture_far_count_,x
3301  023c               L1011:
3302                     ; 967             if( (gesture_near_count_ >= 10) && (gesture_far_count_ >= 2) ) {
3304  023c 9c            	rvf
3305  023d ce0086        	ldw	x,_gesture_near_count_
3306  0240 a3000a        	cpw	x,#10
3307  0243 2f6d          	jrslt	L7111
3309  0245 9c            	rvf
3310  0246 ce0084        	ldw	x,_gesture_far_count_
3311  0249 a30002        	cpw	x,#2
3312  024c 2f64          	jrslt	L7111
3313                     ; 968                 if( (ud_delta == 0) && (lr_delta == 0) ) {
3315  024e 1e0d          	ldw	x,(OFST-3,sp)
3316  0250 260c          	jrne	L1111
3318  0252 1e0f          	ldw	x,(OFST-1,sp)
3319  0254 2608          	jrne	L1111
3320                     ; 969                     gesture_state_ = NEAR_STATE;
3322  0256 ae0001        	ldw	x,#1
3323  0259 cf0082        	ldw	_gesture_state_,x
3325  025c 200e          	jra	L3111
3326  025e               L1111:
3327                     ; 970                 } else if( (ud_delta != 0) && (lr_delta != 0) ) {
3329  025e 1e0d          	ldw	x,(OFST-3,sp)
3330  0260 270a          	jreq	L3111
3332  0262 1e0f          	ldw	x,(OFST-1,sp)
3333  0264 2706          	jreq	L3111
3334                     ; 971                     gesture_state_ = FAR_STATE;
3336  0266 ae0002        	ldw	x,#2
3337  0269 cf0082        	ldw	_gesture_state_,x
3338  026c               L3111:
3339                     ; 973                 return 1;
3341  026c a601          	ld	a,#1
3343  026e ac9f009f      	jpf	L431
3344  0272               L3701:
3345                     ; 977         if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && \
3345                     ; 978             (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) {
3347  0272 9c            	rvf
3348  0273 1e0d          	ldw	x,(OFST-3,sp)
3349  0275 cd0000        	call	_abs
3351  0278 a30014        	cpw	x,#20
3352  027b 2e35          	jrsge	L7111
3354  027d 9c            	rvf
3355  027e 1e0f          	ldw	x,(OFST-1,sp)
3356  0280 cd0000        	call	_abs
3358  0283 a30014        	cpw	x,#20
3359  0286 2e2a          	jrsge	L7111
3360                     ; 980             if( (ud_delta == 0) && (lr_delta == 0) ) {
3362  0288 1e0d          	ldw	x,(OFST-3,sp)
3363  028a 260d          	jrne	L3211
3365  028c 1e0f          	ldw	x,(OFST-1,sp)
3366  028e 2609          	jrne	L3211
3367                     ; 981                 gesture_near_count_++;
3369  0290 ce0086        	ldw	x,_gesture_near_count_
3370  0293 1c0001        	addw	x,#1
3371  0296 cf0086        	ldw	_gesture_near_count_,x
3372  0299               L3211:
3373                     ; 984             if( gesture_near_count_ >= 10 ) {
3375  0299 9c            	rvf
3376  029a ce0086        	ldw	x,_gesture_near_count_
3377  029d a3000a        	cpw	x,#10
3378  02a0 2f10          	jrslt	L7111
3379                     ; 985                 gesture_ud_count_ = 0;
3381  02a2 5f            	clrw	x
3382  02a3 cf008a        	ldw	_gesture_ud_count_,x
3383                     ; 986                 gesture_lr_count_ = 0;
3385  02a6 5f            	clrw	x
3386  02a7 cf0088        	ldw	_gesture_lr_count_,x
3387                     ; 987                 gesture_ud_delta_ = 0;
3389  02aa 5f            	clrw	x
3390  02ab cf008e        	ldw	_gesture_ud_delta_,x
3391                     ; 988                 gesture_lr_delta_ = 0;
3393  02ae 5f            	clrw	x
3394  02af cf008c        	ldw	_gesture_lr_delta_,x
3395  02b2               L7111:
3396                     ; 1005     return 0;
3398  02b2 4f            	clr	a
3400  02b3 ac9f009f      	jpf	L431
3430                     ; 1013 uint8_t decodeGesture(void)
3430                     ; 1014 {
3431                     .text:	section	.text,new
3432  0000               _decodeGesture:
3434  0000 89            	pushw	x
3435       00000002      OFST:	set	2
3438                     ; 1016     if( gesture_state_ == NEAR_STATE ) {
3440  0001 ce0082        	ldw	x,_gesture_state_
3441  0004 a30001        	cpw	x,#1
3442  0007 260a          	jrne	L7311
3443                     ; 1017         gesture_motion_ = DIR_NEAR;
3445  0009 ae0005        	ldw	x,#5
3446  000c cf0080        	ldw	_gesture_motion_,x
3447                     ; 1018         return 1;
3449  000f a601          	ld	a,#1
3451  0011 2010          	jra	L051
3452  0013               L7311:
3453                     ; 1019     } else if ( gesture_state_ == FAR_STATE ) {
3455  0013 ce0082        	ldw	x,_gesture_state_
3456  0016 a30002        	cpw	x,#2
3457  0019 260a          	jrne	L1411
3458                     ; 1020         gesture_motion_ = DIR_FAR;
3460  001b ae0006        	ldw	x,#6
3461  001e cf0080        	ldw	_gesture_motion_,x
3462                     ; 1021         return 1;
3464  0021 a601          	ld	a,#1
3466  0023               L051:
3468  0023 85            	popw	x
3469  0024 81            	ret
3470  0025               L1411:
3471                     ; 1025     if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 0) ) {
3473  0025 ce008a        	ldw	x,_gesture_ud_count_
3474  0028 a3ffff        	cpw	x,#65535
3475  002b 260f          	jrne	L5411
3477  002d ce0088        	ldw	x,_gesture_lr_count_
3478  0030 260a          	jrne	L5411
3479                     ; 1026         gesture_motion_ = DIR_UP;
3481  0032 ae0003        	ldw	x,#3
3482  0035 cf0080        	ldw	_gesture_motion_,x
3484  0038 ac4f014f      	jpf	L7411
3485  003c               L5411:
3486                     ; 1027     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 0) ) {
3488  003c ce008a        	ldw	x,_gesture_ud_count_
3489  003f a30001        	cpw	x,#1
3490  0042 260f          	jrne	L1511
3492  0044 ce0088        	ldw	x,_gesture_lr_count_
3493  0047 260a          	jrne	L1511
3494                     ; 1028         gesture_motion_ = DIR_DOWN;
3496  0049 ae0004        	ldw	x,#4
3497  004c cf0080        	ldw	_gesture_motion_,x
3499  004f ac4f014f      	jpf	L7411
3500  0053               L1511:
3501                     ; 1029     } else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 1) ) {
3503  0053 ce008a        	ldw	x,_gesture_ud_count_
3504  0056 2612          	jrne	L5511
3506  0058 ce0088        	ldw	x,_gesture_lr_count_
3507  005b a30001        	cpw	x,#1
3508  005e 260a          	jrne	L5511
3509                     ; 1030         gesture_motion_ = DIR_RIGHT;
3511  0060 ae0002        	ldw	x,#2
3512  0063 cf0080        	ldw	_gesture_motion_,x
3514  0066 ac4f014f      	jpf	L7411
3515  006a               L5511:
3516                     ; 1031     } else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == -1) ) {
3518  006a ce008a        	ldw	x,_gesture_ud_count_
3519  006d 2612          	jrne	L1611
3521  006f ce0088        	ldw	x,_gesture_lr_count_
3522  0072 a3ffff        	cpw	x,#65535
3523  0075 260a          	jrne	L1611
3524                     ; 1032         gesture_motion_ = DIR_LEFT;
3526  0077 ae0001        	ldw	x,#1
3527  007a cf0080        	ldw	_gesture_motion_,x
3529  007d ac4f014f      	jpf	L7411
3530  0081               L1611:
3531                     ; 1033     } else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 1) ) {
3533  0081 ce008a        	ldw	x,_gesture_ud_count_
3534  0084 a3ffff        	cpw	x,#65535
3535  0087 262f          	jrne	L5611
3537  0089 ce0088        	ldw	x,_gesture_lr_count_
3538  008c a30001        	cpw	x,#1
3539  008f 2627          	jrne	L5611
3540                     ; 1034         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3542  0091 9c            	rvf
3543  0092 ce008c        	ldw	x,_gesture_lr_delta_
3544  0095 cd0000        	call	_abs
3546  0098 1f01          	ldw	(OFST-1,sp),x
3547  009a ce008e        	ldw	x,_gesture_ud_delta_
3548  009d cd0000        	call	_abs
3550  00a0 1301          	cpw	x,(OFST-1,sp)
3551  00a2 2d0a          	jrsle	L7611
3552                     ; 1035             gesture_motion_ = DIR_UP;
3554  00a4 ae0003        	ldw	x,#3
3555  00a7 cf0080        	ldw	_gesture_motion_,x
3557  00aa ac4f014f      	jpf	L7411
3558  00ae               L7611:
3559                     ; 1037             gesture_motion_ = DIR_RIGHT;
3561  00ae ae0002        	ldw	x,#2
3562  00b1 cf0080        	ldw	_gesture_motion_,x
3563  00b4 ac4f014f      	jpf	L7411
3564  00b8               L5611:
3565                     ; 1039     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == -1) ) {
3567  00b8 ce008a        	ldw	x,_gesture_ud_count_
3568  00bb a30001        	cpw	x,#1
3569  00be 262b          	jrne	L5711
3571  00c0 ce0088        	ldw	x,_gesture_lr_count_
3572  00c3 a3ffff        	cpw	x,#65535
3573  00c6 2623          	jrne	L5711
3574                     ; 1040         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3576  00c8 9c            	rvf
3577  00c9 ce008c        	ldw	x,_gesture_lr_delta_
3578  00cc cd0000        	call	_abs
3580  00cf 1f01          	ldw	(OFST-1,sp),x
3581  00d1 ce008e        	ldw	x,_gesture_ud_delta_
3582  00d4 cd0000        	call	_abs
3584  00d7 1301          	cpw	x,(OFST-1,sp)
3585  00d9 2d08          	jrsle	L7711
3586                     ; 1041             gesture_motion_ = DIR_DOWN;
3588  00db ae0004        	ldw	x,#4
3589  00de cf0080        	ldw	_gesture_motion_,x
3591  00e1 206c          	jra	L7411
3592  00e3               L7711:
3593                     ; 1043             gesture_motion_ = DIR_LEFT;
3595  00e3 ae0001        	ldw	x,#1
3596  00e6 cf0080        	ldw	_gesture_motion_,x
3597  00e9 2064          	jra	L7411
3598  00eb               L5711:
3599                     ; 1045     } else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == -1) ) {
3601  00eb ce008a        	ldw	x,_gesture_ud_count_
3602  00ee a3ffff        	cpw	x,#65535
3603  00f1 262b          	jrne	L5021
3605  00f3 ce0088        	ldw	x,_gesture_lr_count_
3606  00f6 a3ffff        	cpw	x,#65535
3607  00f9 2623          	jrne	L5021
3608                     ; 1046         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3610  00fb 9c            	rvf
3611  00fc ce008c        	ldw	x,_gesture_lr_delta_
3612  00ff cd0000        	call	_abs
3614  0102 1f01          	ldw	(OFST-1,sp),x
3615  0104 ce008e        	ldw	x,_gesture_ud_delta_
3616  0107 cd0000        	call	_abs
3618  010a 1301          	cpw	x,(OFST-1,sp)
3619  010c 2d08          	jrsle	L7021
3620                     ; 1047             gesture_motion_ = DIR_UP;
3622  010e ae0003        	ldw	x,#3
3623  0111 cf0080        	ldw	_gesture_motion_,x
3625  0114 2039          	jra	L7411
3626  0116               L7021:
3627                     ; 1049             gesture_motion_ = DIR_LEFT;
3629  0116 ae0001        	ldw	x,#1
3630  0119 cf0080        	ldw	_gesture_motion_,x
3631  011c 2031          	jra	L7411
3632  011e               L5021:
3633                     ; 1051     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 1) ) {
3635  011e ce008a        	ldw	x,_gesture_ud_count_
3636  0121 a30001        	cpw	x,#1
3637  0124 262d          	jrne	L5121
3639  0126 ce0088        	ldw	x,_gesture_lr_count_
3640  0129 a30001        	cpw	x,#1
3641  012c 2625          	jrne	L5121
3642                     ; 1052         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
3644  012e 9c            	rvf
3645  012f ce008c        	ldw	x,_gesture_lr_delta_
3646  0132 cd0000        	call	_abs
3648  0135 1f01          	ldw	(OFST-1,sp),x
3649  0137 ce008e        	ldw	x,_gesture_ud_delta_
3650  013a cd0000        	call	_abs
3652  013d 1301          	cpw	x,(OFST-1,sp)
3653  013f 2d08          	jrsle	L7121
3654                     ; 1053             gesture_motion_ = DIR_DOWN;
3656  0141 ae0004        	ldw	x,#4
3657  0144 cf0080        	ldw	_gesture_motion_,x
3659  0147 2006          	jra	L7411
3660  0149               L7121:
3661                     ; 1055             gesture_motion_ = DIR_RIGHT;
3663  0149 ae0002        	ldw	x,#2
3664  014c cf0080        	ldw	_gesture_motion_,x
3665  014f               L7411:
3666                     ; 1061     return 1;
3668  014f a601          	ld	a,#1
3670  0151 2001          	jra	L251
3671  0153               L5121:
3672                     ; 1058         return 0;
3674  0153 4f            	clr	a
3676  0154               L251:
3678  0154 85            	popw	x
3679  0155 81            	ret
3713                     ; 1073 uint8_t getProxIntLowThresh(void)
3713                     ; 1074 {
3714                     .text:	section	.text,new
3715  0000               _getProxIntLowThresh:
3717  0000 88            	push	a
3718       00000001      OFST:	set	1
3721                     ; 1078     if( !wireReadDataByte(APDS9960_PILT, &val) ) {
3723  0001 96            	ldw	x,sp
3724  0002 1c0001        	addw	x,#OFST+0
3725  0005 89            	pushw	x
3726  0006 a689          	ld	a,#137
3727  0008 cd0000        	call	_wireReadDataByte
3729  000b 85            	popw	x
3730  000c 4d            	tnz	a
3731  000d 2602          	jrne	L1421
3732                     ; 1079         val = 0;
3734  000f 0f01          	clr	(OFST+0,sp)
3735  0011               L1421:
3736                     ; 1082     return val;
3738  0011 7b01          	ld	a,(OFST+0,sp)
3741  0013 5b01          	addw	sp,#1
3742  0015 81            	ret
3776                     ; 1091 uint8_t setProxIntLowThresh(uint8_t threshold)
3776                     ; 1092 {
3777                     .text:	section	.text,new
3778  0000               _setProxIntLowThresh:
3782                     ; 1093     if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
3784  0000 97            	ld	xl,a
3785  0001 a689          	ld	a,#137
3786  0003 95            	ld	xh,a
3787  0004 cd0000        	call	_wireWriteDataByte
3789  0007 4d            	tnz	a
3790  0008 2602          	jrne	L7521
3791                     ; 1094         return 0;
3793  000a 4f            	clr	a
3796  000b 81            	ret
3797  000c               L7521:
3798                     ; 1097     return 1;
3800  000c a601          	ld	a,#1
3803  000e 81            	ret
3837                     ; 1105 uint8_t getProxIntHighThresh(void)
3837                     ; 1106 {
3838                     .text:	section	.text,new
3839  0000               _getProxIntHighThresh:
3841  0000 88            	push	a
3842       00000001      OFST:	set	1
3845                     ; 1110     if( !wireReadDataByte(APDS9960_PIHT, &val) ) {
3847  0001 96            	ldw	x,sp
3848  0002 1c0001        	addw	x,#OFST+0
3849  0005 89            	pushw	x
3850  0006 a68b          	ld	a,#139
3851  0008 cd0000        	call	_wireReadDataByte
3853  000b 85            	popw	x
3854  000c 4d            	tnz	a
3855  000d 2602          	jrne	L5721
3856                     ; 1111         val = 0;
3858  000f 0f01          	clr	(OFST+0,sp)
3859  0011               L5721:
3860                     ; 1114     return val;
3862  0011 7b01          	ld	a,(OFST+0,sp)
3865  0013 5b01          	addw	sp,#1
3866  0015 81            	ret
3900                     ; 1123 uint8_t setProxIntHighThresh(uint8_t threshold)
3900                     ; 1124 {
3901                     .text:	section	.text,new
3902  0000               _setProxIntHighThresh:
3906                     ; 1125     if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
3908  0000 97            	ld	xl,a
3909  0001 a68b          	ld	a,#139
3910  0003 95            	ld	xh,a
3911  0004 cd0000        	call	_wireWriteDataByte
3913  0007 4d            	tnz	a
3914  0008 2602          	jrne	L3131
3915                     ; 1126         return 0;
3917  000a 4f            	clr	a
3920  000b 81            	ret
3921  000c               L3131:
3922                     ; 1129     return 1;
3924  000c a601          	ld	a,#1
3927  000e 81            	ret
3960                     ; 1143 uint8_t getLEDDrive(void)
3960                     ; 1144 {
3961                     .text:	section	.text,new
3962  0000               _getLEDDrive:
3964  0000 88            	push	a
3965       00000001      OFST:	set	1
3968                     ; 1148     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
3970  0001 96            	ldw	x,sp
3971  0002 1c0001        	addw	x,#OFST+0
3972  0005 89            	pushw	x
3973  0006 a68f          	ld	a,#143
3974  0008 cd0000        	call	_wireReadDataByte
3976  000b 85            	popw	x
3977  000c 4d            	tnz	a
3978  000d 2605          	jrne	L1331
3979                     ; 1149         return APDS9960_ERROR;
3981  000f a6ff          	ld	a,#255
3984  0011 5b01          	addw	sp,#1
3985  0013 81            	ret
3986  0014               L1331:
3987                     ; 1153     val = (val >> 6) & 0b00000011;
3989  0014 7b01          	ld	a,(OFST+0,sp)
3990  0016 4e            	swap	a
3991  0017 44            	srl	a
3992  0018 44            	srl	a
3993  0019 a403          	and	a,#3
3994  001b a403          	and	a,#3
3995  001d 6b01          	ld	(OFST+0,sp),a
3996                     ; 1155     return val;
3998  001f 7b01          	ld	a,(OFST+0,sp)
4001  0021 5b01          	addw	sp,#1
4002  0023 81            	ret
4043                     ; 1170 uint8_t setLEDDrive(uint8_t drive)
4043                     ; 1171 {
4044                     .text:	section	.text,new
4045  0000               _setLEDDrive:
4047  0000 88            	push	a
4048  0001 88            	push	a
4049       00000001      OFST:	set	1
4052                     ; 1175     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4054  0002 96            	ldw	x,sp
4055  0003 1c0001        	addw	x,#OFST+0
4056  0006 89            	pushw	x
4057  0007 a68f          	ld	a,#143
4058  0009 cd0000        	call	_wireReadDataByte
4060  000c 85            	popw	x
4061  000d 4d            	tnz	a
4062  000e 2603          	jrne	L1531
4063                     ; 1176         return 0;
4065  0010 4f            	clr	a
4067  0011 2028          	jra	L071
4068  0013               L1531:
4069                     ; 1180     drive &= 0b00000011;
4071  0013 7b02          	ld	a,(OFST+1,sp)
4072  0015 a403          	and	a,#3
4073  0017 6b02          	ld	(OFST+1,sp),a
4074                     ; 1181     drive = drive << 6;
4076  0019 7b02          	ld	a,(OFST+1,sp)
4077  001b 4e            	swap	a
4078  001c 48            	sll	a
4079  001d 48            	sll	a
4080  001e a4c0          	and	a,#192
4081  0020 6b02          	ld	(OFST+1,sp),a
4082                     ; 1182     val &= 0b00111111;
4084  0022 7b01          	ld	a,(OFST+0,sp)
4085  0024 a43f          	and	a,#63
4086  0026 6b01          	ld	(OFST+0,sp),a
4087                     ; 1183     val |= drive;
4089  0028 7b01          	ld	a,(OFST+0,sp)
4090  002a 1a02          	or	a,(OFST+1,sp)
4091  002c 6b01          	ld	(OFST+0,sp),a
4092                     ; 1186     if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4094  002e 7b01          	ld	a,(OFST+0,sp)
4095  0030 97            	ld	xl,a
4096  0031 a68f          	ld	a,#143
4097  0033 95            	ld	xh,a
4098  0034 cd0000        	call	_wireWriteDataByte
4100  0037 4d            	tnz	a
4101  0038 2603          	jrne	L3531
4102                     ; 1187         return 0;
4104  003a 4f            	clr	a
4106  003b               L071:
4108  003b 85            	popw	x
4109  003c 81            	ret
4110  003d               L3531:
4111                     ; 1190     return 1;
4113  003d a601          	ld	a,#1
4115  003f 20fa          	jra	L071
4148                     ; 1204 uint8_t getProximityGain(void)
4148                     ; 1205 {
4149                     .text:	section	.text,new
4150  0000               _getProximityGain:
4152  0000 88            	push	a
4153       00000001      OFST:	set	1
4156                     ; 1209     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4158  0001 96            	ldw	x,sp
4159  0002 1c0001        	addw	x,#OFST+0
4160  0005 89            	pushw	x
4161  0006 a68f          	ld	a,#143
4162  0008 cd0000        	call	_wireReadDataByte
4164  000b 85            	popw	x
4165  000c 4d            	tnz	a
4166  000d 2605          	jrne	L1731
4167                     ; 1210         return APDS9960_ERROR;
4169  000f a6ff          	ld	a,#255
4172  0011 5b01          	addw	sp,#1
4173  0013 81            	ret
4174  0014               L1731:
4175                     ; 1214     val = (val >> 2) & 0b00000011;
4177  0014 7b01          	ld	a,(OFST+0,sp)
4178  0016 44            	srl	a
4179  0017 44            	srl	a
4180  0018 a403          	and	a,#3
4181  001a 6b01          	ld	(OFST+0,sp),a
4182                     ; 1216     return val;
4184  001c 7b01          	ld	a,(OFST+0,sp)
4187  001e 5b01          	addw	sp,#1
4188  0020 81            	ret
4229                     ; 1231 uint8_t setProximityGain(uint8_t drive)
4229                     ; 1232 {
4230                     .text:	section	.text,new
4231  0000               _setProximityGain:
4233  0000 88            	push	a
4234  0001 88            	push	a
4235       00000001      OFST:	set	1
4238                     ; 1236     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4240  0002 96            	ldw	x,sp
4241  0003 1c0001        	addw	x,#OFST+0
4242  0006 89            	pushw	x
4243  0007 a68f          	ld	a,#143
4244  0009 cd0000        	call	_wireReadDataByte
4246  000c 85            	popw	x
4247  000d 4d            	tnz	a
4248  000e 2603          	jrne	L1141
4249                     ; 1237         return 0;
4251  0010 4f            	clr	a
4253  0011 2023          	jra	L671
4254  0013               L1141:
4255                     ; 1241     drive &= 0b00000011;
4257  0013 7b02          	ld	a,(OFST+1,sp)
4258  0015 a403          	and	a,#3
4259  0017 6b02          	ld	(OFST+1,sp),a
4260                     ; 1242     drive = drive << 2;
4262  0019 0802          	sll	(OFST+1,sp)
4263  001b 0802          	sll	(OFST+1,sp)
4264                     ; 1243     val &= 0b11110011;
4266  001d 7b01          	ld	a,(OFST+0,sp)
4267  001f a4f3          	and	a,#243
4268  0021 6b01          	ld	(OFST+0,sp),a
4269                     ; 1244     val |= drive;
4271  0023 7b01          	ld	a,(OFST+0,sp)
4272  0025 1a02          	or	a,(OFST+1,sp)
4273  0027 6b01          	ld	(OFST+0,sp),a
4274                     ; 1247     if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4276  0029 7b01          	ld	a,(OFST+0,sp)
4277  002b 97            	ld	xl,a
4278  002c a68f          	ld	a,#143
4279  002e 95            	ld	xh,a
4280  002f cd0000        	call	_wireWriteDataByte
4282  0032 4d            	tnz	a
4283  0033 2603          	jrne	L3141
4284                     ; 1248         return 0;
4286  0035 4f            	clr	a
4288  0036               L671:
4290  0036 85            	popw	x
4291  0037 81            	ret
4292  0038               L3141:
4293                     ; 1251     return 1;
4295  0038 a601          	ld	a,#1
4297  003a 20fa          	jra	L671
4331                     ; 1265 uint8_t getAmbientLightGain(void)
4331                     ; 1266 {
4332                     .text:	section	.text,new
4333  0000               _getAmbientLightGain:
4335  0000 88            	push	a
4336       00000001      OFST:	set	1
4339                     ; 1270     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4341  0001 96            	ldw	x,sp
4342  0002 1c0001        	addw	x,#OFST+0
4343  0005 89            	pushw	x
4344  0006 a68f          	ld	a,#143
4345  0008 cd0000        	call	_wireReadDataByte
4347  000b 85            	popw	x
4348  000c 4d            	tnz	a
4349  000d 2605          	jrne	L1341
4350                     ; 1271         return APDS9960_ERROR;
4352  000f a6ff          	ld	a,#255
4355  0011 5b01          	addw	sp,#1
4356  0013 81            	ret
4357  0014               L1341:
4358                     ; 1275     val &= 0b00000011;
4360  0014 7b01          	ld	a,(OFST+0,sp)
4361  0016 a403          	and	a,#3
4362  0018 6b01          	ld	(OFST+0,sp),a
4363                     ; 1277     return val;
4365  001a 7b01          	ld	a,(OFST+0,sp)
4368  001c 5b01          	addw	sp,#1
4369  001e 81            	ret
4411                     ; 1292 uint8_t setAmbientLightGain(uint8_t drive)
4411                     ; 1293 {
4412                     .text:	section	.text,new
4413  0000               _setAmbientLightGain:
4415  0000 88            	push	a
4416  0001 88            	push	a
4417       00000001      OFST:	set	1
4420                     ; 1297     if( !wireReadDataByte(APDS9960_CONTROL, &val) ) {
4422  0002 96            	ldw	x,sp
4423  0003 1c0001        	addw	x,#OFST+0
4424  0006 89            	pushw	x
4425  0007 a68f          	ld	a,#143
4426  0009 cd0000        	call	_wireReadDataByte
4428  000c 85            	popw	x
4429  000d 4d            	tnz	a
4430  000e 2603          	jrne	L1541
4431                     ; 1298         return 0;
4433  0010 4f            	clr	a
4435  0011 201f          	jra	L402
4436  0013               L1541:
4437                     ; 1302     drive &= 0b00000011;
4439  0013 7b02          	ld	a,(OFST+1,sp)
4440  0015 a403          	and	a,#3
4441  0017 6b02          	ld	(OFST+1,sp),a
4442                     ; 1303     val &= 0b11111100;
4444  0019 7b01          	ld	a,(OFST+0,sp)
4445  001b a4fc          	and	a,#252
4446  001d 6b01          	ld	(OFST+0,sp),a
4447                     ; 1304     val |= drive;
4449  001f 7b01          	ld	a,(OFST+0,sp)
4450  0021 1a02          	or	a,(OFST+1,sp)
4451  0023 6b01          	ld	(OFST+0,sp),a
4452                     ; 1307     if( !wireWriteDataByte(APDS9960_CONTROL, val) ) {
4454  0025 7b01          	ld	a,(OFST+0,sp)
4455  0027 97            	ld	xl,a
4456  0028 a68f          	ld	a,#143
4457  002a 95            	ld	xh,a
4458  002b cd0000        	call	_wireWriteDataByte
4460  002e 4d            	tnz	a
4461  002f 2603          	jrne	L3541
4462                     ; 1308         return 0;
4464  0031 4f            	clr	a
4466  0032               L402:
4468  0032 85            	popw	x
4469  0033 81            	ret
4470  0034               L3541:
4471                     ; 1311     return 1;
4473  0034 a601          	ld	a,#1
4475  0036 20fa          	jra	L402
4508                     ; 1325 uint8_t getLEDBoost(void)
4508                     ; 1326 {
4509                     .text:	section	.text,new
4510  0000               _getLEDBoost:
4512  0000 88            	push	a
4513       00000001      OFST:	set	1
4516                     ; 1330     if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
4518  0001 96            	ldw	x,sp
4519  0002 1c0001        	addw	x,#OFST+0
4520  0005 89            	pushw	x
4521  0006 a690          	ld	a,#144
4522  0008 cd0000        	call	_wireReadDataByte
4524  000b 85            	popw	x
4525  000c 4d            	tnz	a
4526  000d 2605          	jrne	L1741
4527                     ; 1331         return APDS9960_ERROR;
4529  000f a6ff          	ld	a,#255
4532  0011 5b01          	addw	sp,#1
4533  0013 81            	ret
4534  0014               L1741:
4535                     ; 1335     val = (val >> 4) & 0b00000011;
4537  0014 7b01          	ld	a,(OFST+0,sp)
4538  0016 4e            	swap	a
4539  0017 a40f          	and	a,#15
4540  0019 a403          	and	a,#3
4541  001b 6b01          	ld	(OFST+0,sp),a
4542                     ; 1337     return val;
4544  001d 7b01          	ld	a,(OFST+0,sp)
4547  001f 5b01          	addw	sp,#1
4548  0021 81            	ret
4589                     ; 1352 uint8_t setLEDBoost(uint8_t boost)
4589                     ; 1353 {
4590                     .text:	section	.text,new
4591  0000               _setLEDBoost:
4593  0000 88            	push	a
4594  0001 88            	push	a
4595       00000001      OFST:	set	1
4598                     ; 1357     if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
4600  0002 96            	ldw	x,sp
4601  0003 1c0001        	addw	x,#OFST+0
4602  0006 89            	pushw	x
4603  0007 a690          	ld	a,#144
4604  0009 cd0000        	call	_wireReadDataByte
4606  000c 85            	popw	x
4607  000d 4d            	tnz	a
4608  000e 2603          	jrne	L1151
4609                     ; 1358         return 0;
4611  0010 4f            	clr	a
4613  0011 2026          	jra	L212
4614  0013               L1151:
4615                     ; 1362     boost &= 0b00000011;
4617  0013 7b02          	ld	a,(OFST+1,sp)
4618  0015 a403          	and	a,#3
4619  0017 6b02          	ld	(OFST+1,sp),a
4620                     ; 1363     boost = boost << 4;
4622  0019 7b02          	ld	a,(OFST+1,sp)
4623  001b 4e            	swap	a
4624  001c a4f0          	and	a,#240
4625  001e 6b02          	ld	(OFST+1,sp),a
4626                     ; 1364     val &= 0b11001111;
4628  0020 7b01          	ld	a,(OFST+0,sp)
4629  0022 a4cf          	and	a,#207
4630  0024 6b01          	ld	(OFST+0,sp),a
4631                     ; 1365     val |= boost;
4633  0026 7b01          	ld	a,(OFST+0,sp)
4634  0028 1a02          	or	a,(OFST+1,sp)
4635  002a 6b01          	ld	(OFST+0,sp),a
4636                     ; 1368     if( !wireWriteDataByte(APDS9960_CONFIG2, val) ) {
4638  002c 7b01          	ld	a,(OFST+0,sp)
4639  002e 97            	ld	xl,a
4640  002f a690          	ld	a,#144
4641  0031 95            	ld	xh,a
4642  0032 cd0000        	call	_wireWriteDataByte
4644  0035 4d            	tnz	a
4645  0036 2603          	jrne	L3151
4646                     ; 1369         return 0;
4648  0038 4f            	clr	a
4650  0039               L212:
4652  0039 85            	popw	x
4653  003a 81            	ret
4654  003b               L3151:
4655                     ; 1372     return 1;
4657  003b a601          	ld	a,#1
4659  003d 20fa          	jra	L212
4693                     ; 1380 uint8_t getProxGainCompEnable(void)
4693                     ; 1381 {
4694                     .text:	section	.text,new
4695  0000               _getProxGainCompEnable:
4697  0000 88            	push	a
4698       00000001      OFST:	set	1
4701                     ; 1385     if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
4703  0001 96            	ldw	x,sp
4704  0002 1c0001        	addw	x,#OFST+0
4705  0005 89            	pushw	x
4706  0006 a69f          	ld	a,#159
4707  0008 cd0000        	call	_wireReadDataByte
4709  000b 85            	popw	x
4710  000c 4d            	tnz	a
4711  000d 2605          	jrne	L1351
4712                     ; 1386         return APDS9960_ERROR;
4714  000f a6ff          	ld	a,#255
4717  0011 5b01          	addw	sp,#1
4718  0013 81            	ret
4719  0014               L1351:
4720                     ; 1390     val = (val >> 5) & 0b00000001;
4722  0014 7b01          	ld	a,(OFST+0,sp)
4723  0016 4e            	swap	a
4724  0017 44            	srl	a
4725  0018 a407          	and	a,#7
4726  001a a401          	and	a,#1
4727  001c 6b01          	ld	(OFST+0,sp),a
4728                     ; 1392     return val;
4730  001e 7b01          	ld	a,(OFST+0,sp)
4733  0020 5b01          	addw	sp,#1
4734  0022 81            	ret
4776                     ; 1401  uint8_t setProxGainCompEnable(uint8_t enable)
4776                     ; 1402 {
4777                     .text:	section	.text,new
4778  0000               _setProxGainCompEnable:
4780  0000 88            	push	a
4781  0001 88            	push	a
4782       00000001      OFST:	set	1
4785                     ; 1406     if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
4787  0002 96            	ldw	x,sp
4788  0003 1c0001        	addw	x,#OFST+0
4789  0006 89            	pushw	x
4790  0007 a69f          	ld	a,#159
4791  0009 cd0000        	call	_wireReadDataByte
4793  000c 85            	popw	x
4794  000d 4d            	tnz	a
4795  000e 2603          	jrne	L1551
4796                     ; 1407         return 0;
4798  0010 4f            	clr	a
4800  0011 2027          	jra	L022
4801  0013               L1551:
4802                     ; 1411     enable &= 0b00000001;
4804  0013 7b02          	ld	a,(OFST+1,sp)
4805  0015 a401          	and	a,#1
4806  0017 6b02          	ld	(OFST+1,sp),a
4807                     ; 1412     enable = enable << 5;
4809  0019 7b02          	ld	a,(OFST+1,sp)
4810  001b 4e            	swap	a
4811  001c 48            	sll	a
4812  001d a4e0          	and	a,#224
4813  001f 6b02          	ld	(OFST+1,sp),a
4814                     ; 1413     val &= 0b11011111;
4816  0021 7b01          	ld	a,(OFST+0,sp)
4817  0023 a4df          	and	a,#223
4818  0025 6b01          	ld	(OFST+0,sp),a
4819                     ; 1414     val |= enable;
4821  0027 7b01          	ld	a,(OFST+0,sp)
4822  0029 1a02          	or	a,(OFST+1,sp)
4823  002b 6b01          	ld	(OFST+0,sp),a
4824                     ; 1417     if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
4826  002d 7b01          	ld	a,(OFST+0,sp)
4827  002f 97            	ld	xl,a
4828  0030 a69f          	ld	a,#159
4829  0032 95            	ld	xh,a
4830  0033 cd0000        	call	_wireWriteDataByte
4832  0036 4d            	tnz	a
4833  0037 2603          	jrne	L3551
4834                     ; 1418         return 0;
4836  0039 4f            	clr	a
4838  003a               L022:
4840  003a 85            	popw	x
4841  003b 81            	ret
4842  003c               L3551:
4843                     ; 1421     return 1;
4845  003c a601          	ld	a,#1
4847  003e 20fa          	jra	L022
4880                     ; 1436 uint8_t getProxPhotoMask(void)
4880                     ; 1437 {
4881                     .text:	section	.text,new
4882  0000               _getProxPhotoMask:
4884  0000 88            	push	a
4885       00000001      OFST:	set	1
4888                     ; 1441     if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
4890  0001 96            	ldw	x,sp
4891  0002 1c0001        	addw	x,#OFST+0
4892  0005 89            	pushw	x
4893  0006 a69f          	ld	a,#159
4894  0008 cd0000        	call	_wireReadDataByte
4896  000b 85            	popw	x
4897  000c 4d            	tnz	a
4898  000d 2605          	jrne	L1751
4899                     ; 1442         return APDS9960_ERROR;
4901  000f a6ff          	ld	a,#255
4904  0011 5b01          	addw	sp,#1
4905  0013 81            	ret
4906  0014               L1751:
4907                     ; 1446     val &= 0b00001111;
4909  0014 7b01          	ld	a,(OFST+0,sp)
4910  0016 a40f          	and	a,#15
4911  0018 6b01          	ld	(OFST+0,sp),a
4912                     ; 1448     return val;
4914  001a 7b01          	ld	a,(OFST+0,sp)
4917  001c 5b01          	addw	sp,#1
4918  001e 81            	ret
4959                     ; 1464 uint8_t setProxPhotoMask(uint8_t mask)
4959                     ; 1465 {
4960                     .text:	section	.text,new
4961  0000               _setProxPhotoMask:
4963  0000 88            	push	a
4964  0001 88            	push	a
4965       00000001      OFST:	set	1
4968                     ; 1469     if( !wireReadDataByte(APDS9960_CONFIG3, &val) ) {
4970  0002 96            	ldw	x,sp
4971  0003 1c0001        	addw	x,#OFST+0
4972  0006 89            	pushw	x
4973  0007 a69f          	ld	a,#159
4974  0009 cd0000        	call	_wireReadDataByte
4976  000c 85            	popw	x
4977  000d 4d            	tnz	a
4978  000e 2603          	jrne	L1161
4979                     ; 1470         return 0;
4981  0010 4f            	clr	a
4983  0011 201f          	jra	L622
4984  0013               L1161:
4985                     ; 1474     mask &= 0b00001111;
4987  0013 7b02          	ld	a,(OFST+1,sp)
4988  0015 a40f          	and	a,#15
4989  0017 6b02          	ld	(OFST+1,sp),a
4990                     ; 1475     val &= 0b11110000;
4992  0019 7b01          	ld	a,(OFST+0,sp)
4993  001b a4f0          	and	a,#240
4994  001d 6b01          	ld	(OFST+0,sp),a
4995                     ; 1476     val |= mask;
4997  001f 7b01          	ld	a,(OFST+0,sp)
4998  0021 1a02          	or	a,(OFST+1,sp)
4999  0023 6b01          	ld	(OFST+0,sp),a
5000                     ; 1479     if( !wireWriteDataByte(APDS9960_CONFIG3, val) ) {
5002  0025 7b01          	ld	a,(OFST+0,sp)
5003  0027 97            	ld	xl,a
5004  0028 a69f          	ld	a,#159
5005  002a 95            	ld	xh,a
5006  002b cd0000        	call	_wireWriteDataByte
5008  002e 4d            	tnz	a
5009  002f 2603          	jrne	L3161
5010                     ; 1480         return 0;
5012  0031 4f            	clr	a
5014  0032               L622:
5016  0032 85            	popw	x
5017  0033 81            	ret
5018  0034               L3161:
5019                     ; 1483     return 1;
5021  0034 a601          	ld	a,#1
5023  0036 20fa          	jra	L622
5057                     ; 1491 uint8_t getGestureEnterThresh(void)
5057                     ; 1492 {
5058                     .text:	section	.text,new
5059  0000               _getGestureEnterThresh:
5061  0000 88            	push	a
5062       00000001      OFST:	set	1
5065                     ; 1496     if( !wireReadDataByte(APDS9960_GPENTH, &val) ) {
5067  0001 96            	ldw	x,sp
5068  0002 1c0001        	addw	x,#OFST+0
5069  0005 89            	pushw	x
5070  0006 a6a0          	ld	a,#160
5071  0008 cd0000        	call	_wireReadDataByte
5073  000b 85            	popw	x
5074  000c 4d            	tnz	a
5075  000d 2602          	jrne	L1361
5076                     ; 1497         val = 0;
5078  000f 0f01          	clr	(OFST+0,sp)
5079  0011               L1361:
5080                     ; 1500     return val;
5082  0011 7b01          	ld	a,(OFST+0,sp)
5085  0013 5b01          	addw	sp,#1
5086  0015 81            	ret
5120                     ; 1509 uint8_t setGestureEnterThresh(uint8_t threshold)
5120                     ; 1510 {
5121                     .text:	section	.text,new
5122  0000               _setGestureEnterThresh:
5126                     ; 1511     if( !wireWriteDataByte(APDS9960_GPENTH, threshold) ) {
5128  0000 97            	ld	xl,a
5129  0001 a6a0          	ld	a,#160
5130  0003 95            	ld	xh,a
5131  0004 cd0000        	call	_wireWriteDataByte
5133  0007 4d            	tnz	a
5134  0008 2602          	jrne	L7461
5135                     ; 1512         return 0;
5137  000a 4f            	clr	a
5140  000b 81            	ret
5141  000c               L7461:
5142                     ; 1515     return 1;
5144  000c a601          	ld	a,#1
5147  000e 81            	ret
5181                     ; 1523 uint8_t getGestureExitThresh(void)
5181                     ; 1524 {
5182                     .text:	section	.text,new
5183  0000               _getGestureExitThresh:
5185  0000 88            	push	a
5186       00000001      OFST:	set	1
5189                     ; 1528     if( !wireReadDataByte(APDS9960_GEXTH, &val) ) {
5191  0001 96            	ldw	x,sp
5192  0002 1c0001        	addw	x,#OFST+0
5193  0005 89            	pushw	x
5194  0006 a6a1          	ld	a,#161
5195  0008 cd0000        	call	_wireReadDataByte
5197  000b 85            	popw	x
5198  000c 4d            	tnz	a
5199  000d 2602          	jrne	L5661
5200                     ; 1529         val = 0;
5202  000f 0f01          	clr	(OFST+0,sp)
5203  0011               L5661:
5204                     ; 1532     return val;
5206  0011 7b01          	ld	a,(OFST+0,sp)
5209  0013 5b01          	addw	sp,#1
5210  0015 81            	ret
5244                     ; 1541 uint8_t setGestureExitThresh(uint8_t threshold)
5244                     ; 1542 {
5245                     .text:	section	.text,new
5246  0000               _setGestureExitThresh:
5250                     ; 1543     if( !wireWriteDataByte(APDS9960_GEXTH, threshold) ) {
5252  0000 97            	ld	xl,a
5253  0001 a6a1          	ld	a,#161
5254  0003 95            	ld	xh,a
5255  0004 cd0000        	call	_wireWriteDataByte
5257  0007 4d            	tnz	a
5258  0008 2602          	jrne	L3071
5259                     ; 1544         return 0;
5261  000a 4f            	clr	a
5264  000b 81            	ret
5265  000c               L3071:
5266                     ; 1547     return 1;
5268  000c a601          	ld	a,#1
5271  000e 81            	ret
5304                     ; 1561 uint8_t getGestureGain(void)
5304                     ; 1562 {
5305                     .text:	section	.text,new
5306  0000               _getGestureGain:
5308  0000 88            	push	a
5309       00000001      OFST:	set	1
5312                     ; 1566     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5314  0001 96            	ldw	x,sp
5315  0002 1c0001        	addw	x,#OFST+0
5316  0005 89            	pushw	x
5317  0006 a6a3          	ld	a,#163
5318  0008 cd0000        	call	_wireReadDataByte
5320  000b 85            	popw	x
5321  000c 4d            	tnz	a
5322  000d 2605          	jrne	L1271
5323                     ; 1567         return APDS9960_ERROR;
5325  000f a6ff          	ld	a,#255
5328  0011 5b01          	addw	sp,#1
5329  0013 81            	ret
5330  0014               L1271:
5331                     ; 1571     val = (val >> 5) & 0b00000011;
5333  0014 7b01          	ld	a,(OFST+0,sp)
5334  0016 4e            	swap	a
5335  0017 44            	srl	a
5336  0018 a407          	and	a,#7
5337  001a a403          	and	a,#3
5338  001c 6b01          	ld	(OFST+0,sp),a
5339                     ; 1573     return val;
5341  001e 7b01          	ld	a,(OFST+0,sp)
5344  0020 5b01          	addw	sp,#1
5345  0022 81            	ret
5386                     ; 1588 uint8_t setGestureGain(uint8_t gain)
5386                     ; 1589 {
5387                     .text:	section	.text,new
5388  0000               _setGestureGain:
5390  0000 88            	push	a
5391  0001 88            	push	a
5392       00000001      OFST:	set	1
5395                     ; 1593     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5397  0002 96            	ldw	x,sp
5398  0003 1c0001        	addw	x,#OFST+0
5399  0006 89            	pushw	x
5400  0007 a6a3          	ld	a,#163
5401  0009 cd0000        	call	_wireReadDataByte
5403  000c 85            	popw	x
5404  000d 4d            	tnz	a
5405  000e 2603          	jrne	L1471
5406                     ; 1594         return 0;
5408  0010 4f            	clr	a
5410  0011 2027          	jra	L442
5411  0013               L1471:
5412                     ; 1598     gain &= 0b00000011;
5414  0013 7b02          	ld	a,(OFST+1,sp)
5415  0015 a403          	and	a,#3
5416  0017 6b02          	ld	(OFST+1,sp),a
5417                     ; 1599     gain = gain << 5;
5419  0019 7b02          	ld	a,(OFST+1,sp)
5420  001b 4e            	swap	a
5421  001c 48            	sll	a
5422  001d a4e0          	and	a,#224
5423  001f 6b02          	ld	(OFST+1,sp),a
5424                     ; 1600     val &= 0b10011111;
5426  0021 7b01          	ld	a,(OFST+0,sp)
5427  0023 a49f          	and	a,#159
5428  0025 6b01          	ld	(OFST+0,sp),a
5429                     ; 1601     val |= gain;
5431  0027 7b01          	ld	a,(OFST+0,sp)
5432  0029 1a02          	or	a,(OFST+1,sp)
5433  002b 6b01          	ld	(OFST+0,sp),a
5434                     ; 1604     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
5436  002d 7b01          	ld	a,(OFST+0,sp)
5437  002f 97            	ld	xl,a
5438  0030 a6a3          	ld	a,#163
5439  0032 95            	ld	xh,a
5440  0033 cd0000        	call	_wireWriteDataByte
5442  0036 4d            	tnz	a
5443  0037 2603          	jrne	L3471
5444                     ; 1605         return 0;
5446  0039 4f            	clr	a
5448  003a               L442:
5450  003a 85            	popw	x
5451  003b 81            	ret
5452  003c               L3471:
5453                     ; 1608     return 1;
5455  003c a601          	ld	a,#1
5457  003e 20fa          	jra	L442
5490                     ; 1622 uint8_t getGestureLEDDrive(void)
5490                     ; 1623 {
5491                     .text:	section	.text,new
5492  0000               _getGestureLEDDrive:
5494  0000 88            	push	a
5495       00000001      OFST:	set	1
5498                     ; 1627     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5500  0001 96            	ldw	x,sp
5501  0002 1c0001        	addw	x,#OFST+0
5502  0005 89            	pushw	x
5503  0006 a6a3          	ld	a,#163
5504  0008 cd0000        	call	_wireReadDataByte
5506  000b 85            	popw	x
5507  000c 4d            	tnz	a
5508  000d 2605          	jrne	L1671
5509                     ; 1628         return APDS9960_ERROR;
5511  000f a6ff          	ld	a,#255
5514  0011 5b01          	addw	sp,#1
5515  0013 81            	ret
5516  0014               L1671:
5517                     ; 1632     val = (val >> 3) & 0b00000011;
5519  0014 7b01          	ld	a,(OFST+0,sp)
5520  0016 44            	srl	a
5521  0017 44            	srl	a
5522  0018 44            	srl	a
5523  0019 a403          	and	a,#3
5524  001b 6b01          	ld	(OFST+0,sp),a
5525                     ; 1634     return val;
5527  001d 7b01          	ld	a,(OFST+0,sp)
5530  001f 5b01          	addw	sp,#1
5531  0021 81            	ret
5572                     ; 1649 uint8_t setGestureLEDDrive(uint8_t drive)
5572                     ; 1650 {
5573                     .text:	section	.text,new
5574  0000               _setGestureLEDDrive:
5576  0000 88            	push	a
5577  0001 88            	push	a
5578       00000001      OFST:	set	1
5581                     ; 1654     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5583  0002 96            	ldw	x,sp
5584  0003 1c0001        	addw	x,#OFST+0
5585  0006 89            	pushw	x
5586  0007 a6a3          	ld	a,#163
5587  0009 cd0000        	call	_wireReadDataByte
5589  000c 85            	popw	x
5590  000d 4d            	tnz	a
5591  000e 2603          	jrne	L1002
5592                     ; 1655         return 0;
5594  0010 4f            	clr	a
5596  0011 2025          	jra	L252
5597  0013               L1002:
5598                     ; 1659     drive &= 0b00000011;
5600  0013 7b02          	ld	a,(OFST+1,sp)
5601  0015 a403          	and	a,#3
5602  0017 6b02          	ld	(OFST+1,sp),a
5603                     ; 1660     drive = drive << 3;
5605  0019 0802          	sll	(OFST+1,sp)
5606  001b 0802          	sll	(OFST+1,sp)
5607  001d 0802          	sll	(OFST+1,sp)
5608                     ; 1661     val &= 0b11100111;
5610  001f 7b01          	ld	a,(OFST+0,sp)
5611  0021 a4e7          	and	a,#231
5612  0023 6b01          	ld	(OFST+0,sp),a
5613                     ; 1662     val |= drive;
5615  0025 7b01          	ld	a,(OFST+0,sp)
5616  0027 1a02          	or	a,(OFST+1,sp)
5617  0029 6b01          	ld	(OFST+0,sp),a
5618                     ; 1665     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
5620  002b 7b01          	ld	a,(OFST+0,sp)
5621  002d 97            	ld	xl,a
5622  002e a6a3          	ld	a,#163
5623  0030 95            	ld	xh,a
5624  0031 cd0000        	call	_wireWriteDataByte
5626  0034 4d            	tnz	a
5627  0035 2603          	jrne	L3002
5628                     ; 1666         return 0;
5630  0037 4f            	clr	a
5632  0038               L252:
5634  0038 85            	popw	x
5635  0039 81            	ret
5636  003a               L3002:
5637                     ; 1669     return 1;
5639  003a a601          	ld	a,#1
5641  003c 20fa          	jra	L252
5674                     ; 1687 uint8_t getGestureWaitTime(void)
5674                     ; 1688 {
5675                     .text:	section	.text,new
5676  0000               _getGestureWaitTime:
5678  0000 88            	push	a
5679       00000001      OFST:	set	1
5682                     ; 1692     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5684  0001 96            	ldw	x,sp
5685  0002 1c0001        	addw	x,#OFST+0
5686  0005 89            	pushw	x
5687  0006 a6a3          	ld	a,#163
5688  0008 cd0000        	call	_wireReadDataByte
5690  000b 85            	popw	x
5691  000c 4d            	tnz	a
5692  000d 2605          	jrne	L1202
5693                     ; 1693         return APDS9960_ERROR;
5695  000f a6ff          	ld	a,#255
5698  0011 5b01          	addw	sp,#1
5699  0013 81            	ret
5700  0014               L1202:
5701                     ; 1697     val &= 0b00000111;
5703  0014 7b01          	ld	a,(OFST+0,sp)
5704  0016 a407          	and	a,#7
5705  0018 6b01          	ld	(OFST+0,sp),a
5706                     ; 1699     return val;
5708  001a 7b01          	ld	a,(OFST+0,sp)
5711  001c 5b01          	addw	sp,#1
5712  001e 81            	ret
5753                     ; 1718 uint8_t setGestureWaitTime(uint8_t time)
5753                     ; 1719 {
5754                     .text:	section	.text,new
5755  0000               _setGestureWaitTime:
5757  0000 88            	push	a
5758  0001 88            	push	a
5759       00000001      OFST:	set	1
5762                     ; 1723     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
5764  0002 96            	ldw	x,sp
5765  0003 1c0001        	addw	x,#OFST+0
5766  0006 89            	pushw	x
5767  0007 a6a3          	ld	a,#163
5768  0009 cd0000        	call	_wireReadDataByte
5770  000c 85            	popw	x
5771  000d 4d            	tnz	a
5772  000e 2603          	jrne	L1402
5773                     ; 1724         return 0;
5775  0010 4f            	clr	a
5777  0011 201f          	jra	L062
5778  0013               L1402:
5779                     ; 1728     time &= 0b00000111;
5781  0013 7b02          	ld	a,(OFST+1,sp)
5782  0015 a407          	and	a,#7
5783  0017 6b02          	ld	(OFST+1,sp),a
5784                     ; 1729     val &= 0b11111000;
5786  0019 7b01          	ld	a,(OFST+0,sp)
5787  001b a4f8          	and	a,#248
5788  001d 6b01          	ld	(OFST+0,sp),a
5789                     ; 1730     val |= time;
5791  001f 7b01          	ld	a,(OFST+0,sp)
5792  0021 1a02          	or	a,(OFST+1,sp)
5793  0023 6b01          	ld	(OFST+0,sp),a
5794                     ; 1733     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
5796  0025 7b01          	ld	a,(OFST+0,sp)
5797  0027 97            	ld	xl,a
5798  0028 a6a3          	ld	a,#163
5799  002a 95            	ld	xh,a
5800  002b cd0000        	call	_wireWriteDataByte
5802  002e 4d            	tnz	a
5803  002f 2603          	jrne	L3402
5804                     ; 1734         return 0;
5806  0031 4f            	clr	a
5808  0032               L062:
5810  0032 85            	popw	x
5811  0033 81            	ret
5812  0034               L3402:
5813                     ; 1737     return 1;
5815  0034 a601          	ld	a,#1
5817  0036 20fa          	jra	L062
5861                     ; 1746 uint8_t getLightIntLowThreshold(uint16_t *threshold)
5861                     ; 1747 {
5862                     .text:	section	.text,new
5863  0000               _getLightIntLowThreshold:
5865  0000 89            	pushw	x
5866  0001 88            	push	a
5867       00000001      OFST:	set	1
5870                     ; 1749     *threshold = 0;
5872  0002 905f          	clrw	y
5873  0004 ff            	ldw	(x),y
5874                     ; 1752     if( !wireReadDataByte(APDS9960_AILTL, &val_byte) ) {
5876  0005 96            	ldw	x,sp
5877  0006 1c0001        	addw	x,#OFST+0
5878  0009 89            	pushw	x
5879  000a a684          	ld	a,#132
5880  000c cd0000        	call	_wireReadDataByte
5882  000f 85            	popw	x
5883  0010 4d            	tnz	a
5884  0011 2603          	jrne	L5602
5885                     ; 1753         return 0;
5887  0013 4f            	clr	a
5889  0014 2017          	jra	L462
5890  0016               L5602:
5891                     ; 1755     *threshold = val_byte;
5893  0016 7b01          	ld	a,(OFST+0,sp)
5894  0018 5f            	clrw	x
5895  0019 97            	ld	xl,a
5896  001a 1602          	ldw	y,(OFST+1,sp)
5897  001c 90ff          	ldw	(y),x
5898                     ; 1758     if( !wireReadDataByte(APDS9960_AILTH, &val_byte) ) {
5900  001e 96            	ldw	x,sp
5901  001f 1c0001        	addw	x,#OFST+0
5902  0022 89            	pushw	x
5903  0023 a685          	ld	a,#133
5904  0025 cd0000        	call	_wireReadDataByte
5906  0028 85            	popw	x
5907  0029 4d            	tnz	a
5908  002a 2604          	jrne	L7602
5909                     ; 1759         return 0;
5911  002c 4f            	clr	a
5913  002d               L462:
5915  002d 5b03          	addw	sp,#3
5916  002f 81            	ret
5917  0030               L7602:
5918                     ; 1761     *threshold = *threshold + ((uint16_t)val_byte << 8);
5920  0030 1e02          	ldw	x,(OFST+1,sp)
5921  0032 7b01          	ld	a,(OFST+0,sp)
5922  0034 905f          	clrw	y
5923  0036 9097          	ld	yl,a
5924  0038 4f            	clr	a
5925  0039 9002          	rlwa	y,a
5926  003b 90bf00        	ldw	c_y,y
5927  003e 9093          	ldw	y,x
5928  0040 90fe          	ldw	y,(y)
5929  0042 72b90000      	addw	y,c_y
5930  0046 ff            	ldw	(x),y
5931                     ; 1763     return 1;
5933  0047 a601          	ld	a,#1
5935  0049 20e2          	jra	L462
5983                     ; 1772 uint8_t setLightIntLowThreshold(uint16_t threshold)
5983                     ; 1773 {
5984                     .text:	section	.text,new
5985  0000               _setLightIntLowThreshold:
5987  0000 89            	pushw	x
5988  0001 89            	pushw	x
5989       00000002      OFST:	set	2
5992                     ; 1778     val_low = threshold & 0x00FF;
5994  0002 9f            	ld	a,xl
5995  0003 a4ff          	and	a,#255
5996  0005 6b01          	ld	(OFST-1,sp),a
5997                     ; 1779     val_high = (threshold & 0xFF00) >> 8;
5999  0007 7b03          	ld	a,(OFST+1,sp)
6000  0009 97            	ld	xl,a
6001  000a 7b04          	ld	a,(OFST+2,sp)
6002  000c 9f            	ld	a,xl
6003  000d a4ff          	and	a,#255
6004  000f 97            	ld	xl,a
6005  0010 4f            	clr	a
6006  0011 02            	rlwa	x,a
6007  0012 4f            	clr	a
6008  0013 01            	rrwa	x,a
6009  0014 01            	rrwa	x,a
6010  0015 6b02          	ld	(OFST+0,sp),a
6011  0017 02            	rlwa	x,a
6012                     ; 1782     if( !wireWriteDataByte(APDS9960_AILTL, val_low) ) {
6014  0018 7b01          	ld	a,(OFST-1,sp)
6015  001a 97            	ld	xl,a
6016  001b a684          	ld	a,#132
6017  001d 95            	ld	xh,a
6018  001e cd0000        	call	_wireWriteDataByte
6020  0021 4d            	tnz	a
6021  0022 2603          	jrne	L1112
6022                     ; 1783         return 0;
6024  0024 4f            	clr	a
6026  0025 200d          	jra	L072
6027  0027               L1112:
6028                     ; 1787     if( !wireWriteDataByte(APDS9960_AILTH, val_high) ) {
6030  0027 7b02          	ld	a,(OFST+0,sp)
6031  0029 97            	ld	xl,a
6032  002a a685          	ld	a,#133
6033  002c 95            	ld	xh,a
6034  002d cd0000        	call	_wireWriteDataByte
6036  0030 4d            	tnz	a
6037  0031 2604          	jrne	L3112
6038                     ; 1788         return 0;
6040  0033 4f            	clr	a
6042  0034               L072:
6044  0034 5b04          	addw	sp,#4
6045  0036 81            	ret
6046  0037               L3112:
6047                     ; 1791     return 1;
6049  0037 a601          	ld	a,#1
6051  0039 20f9          	jra	L072
6095                     ; 1800 uint8_t getLightIntHighThreshold(uint16_t *threshold)
6095                     ; 1801 {
6096                     .text:	section	.text,new
6097  0000               _getLightIntHighThreshold:
6099  0000 89            	pushw	x
6100  0001 88            	push	a
6101       00000001      OFST:	set	1
6104                     ; 1803     *threshold = 0;
6106  0002 905f          	clrw	y
6107  0004 ff            	ldw	(x),y
6108                     ; 1806     if( !wireReadDataByte(APDS9960_AIHTL, &val_byte) ) {
6110  0005 96            	ldw	x,sp
6111  0006 1c0001        	addw	x,#OFST+0
6112  0009 89            	pushw	x
6113  000a a686          	ld	a,#134
6114  000c cd0000        	call	_wireReadDataByte
6116  000f 85            	popw	x
6117  0010 4d            	tnz	a
6118  0011 2603          	jrne	L5312
6119                     ; 1807         return 0;
6121  0013 4f            	clr	a
6123  0014 2017          	jra	L472
6124  0016               L5312:
6125                     ; 1809     *threshold = val_byte;
6127  0016 7b01          	ld	a,(OFST+0,sp)
6128  0018 5f            	clrw	x
6129  0019 97            	ld	xl,a
6130  001a 1602          	ldw	y,(OFST+1,sp)
6131  001c 90ff          	ldw	(y),x
6132                     ; 1812     if( !wireReadDataByte(APDS9960_AIHTH, &val_byte) ) {
6134  001e 96            	ldw	x,sp
6135  001f 1c0001        	addw	x,#OFST+0
6136  0022 89            	pushw	x
6137  0023 a687          	ld	a,#135
6138  0025 cd0000        	call	_wireReadDataByte
6140  0028 85            	popw	x
6141  0029 4d            	tnz	a
6142  002a 2604          	jrne	L7312
6143                     ; 1813         return 0;
6145  002c 4f            	clr	a
6147  002d               L472:
6149  002d 5b03          	addw	sp,#3
6150  002f 81            	ret
6151  0030               L7312:
6152                     ; 1815     *threshold = *threshold + ((uint16_t)val_byte << 8);
6154  0030 1e02          	ldw	x,(OFST+1,sp)
6155  0032 7b01          	ld	a,(OFST+0,sp)
6156  0034 905f          	clrw	y
6157  0036 9097          	ld	yl,a
6158  0038 4f            	clr	a
6159  0039 9002          	rlwa	y,a
6160  003b 90bf00        	ldw	c_y,y
6161  003e 9093          	ldw	y,x
6162  0040 90fe          	ldw	y,(y)
6163  0042 72b90000      	addw	y,c_y
6164  0046 ff            	ldw	(x),y
6165                     ; 1817     return 1;
6167  0047 a601          	ld	a,#1
6169  0049 20e2          	jra	L472
6217                     ; 1826 uint8_t setLightIntHighThreshold(uint16_t threshold)
6217                     ; 1827 {
6218                     .text:	section	.text,new
6219  0000               _setLightIntHighThreshold:
6221  0000 89            	pushw	x
6222  0001 89            	pushw	x
6223       00000002      OFST:	set	2
6226                     ; 1832     val_low = threshold & 0x00FF;
6228  0002 9f            	ld	a,xl
6229  0003 a4ff          	and	a,#255
6230  0005 6b01          	ld	(OFST-1,sp),a
6231                     ; 1833     val_high = (threshold & 0xFF00) >> 8;
6233  0007 7b03          	ld	a,(OFST+1,sp)
6234  0009 97            	ld	xl,a
6235  000a 7b04          	ld	a,(OFST+2,sp)
6236  000c 9f            	ld	a,xl
6237  000d a4ff          	and	a,#255
6238  000f 97            	ld	xl,a
6239  0010 4f            	clr	a
6240  0011 02            	rlwa	x,a
6241  0012 4f            	clr	a
6242  0013 01            	rrwa	x,a
6243  0014 01            	rrwa	x,a
6244  0015 6b02          	ld	(OFST+0,sp),a
6245  0017 02            	rlwa	x,a
6246                     ; 1836     if( !wireWriteDataByte(APDS9960_AIHTL, val_low) ) {
6248  0018 7b01          	ld	a,(OFST-1,sp)
6249  001a 97            	ld	xl,a
6250  001b a686          	ld	a,#134
6251  001d 95            	ld	xh,a
6252  001e cd0000        	call	_wireWriteDataByte
6254  0021 4d            	tnz	a
6255  0022 2603          	jrne	L1612
6256                     ; 1837         return 0;
6258  0024 4f            	clr	a
6260  0025 200d          	jra	L003
6261  0027               L1612:
6262                     ; 1841     if( !wireWriteDataByte(APDS9960_AIHTH, val_high) ) {
6264  0027 7b02          	ld	a,(OFST+0,sp)
6265  0029 97            	ld	xl,a
6266  002a a687          	ld	a,#135
6267  002c 95            	ld	xh,a
6268  002d cd0000        	call	_wireWriteDataByte
6270  0030 4d            	tnz	a
6271  0031 2604          	jrne	L3612
6272                     ; 1842         return 0;
6274  0033 4f            	clr	a
6276  0034               L003:
6278  0034 5b04          	addw	sp,#4
6279  0036 81            	ret
6280  0037               L3612:
6281                     ; 1845     return 1;
6283  0037 a601          	ld	a,#1
6285  0039 20f9          	jra	L003
6322                     ; 1854 uint8_t getProximityIntLowThreshold(uint8_t *threshold)
6322                     ; 1855 {
6323                     .text:	section	.text,new
6324  0000               _getProximityIntLowThreshold:
6328                     ; 1856     *threshold = 0;
6330  0000 7f            	clr	(x)
6331                     ; 1859     if( !wireReadDataByte(APDS9960_PILT, threshold) ) {
6333  0001 89            	pushw	x
6334  0002 a689          	ld	a,#137
6335  0004 cd0000        	call	_wireReadDataByte
6337  0007 85            	popw	x
6338  0008 4d            	tnz	a
6339  0009 2602          	jrne	L3022
6340                     ; 1860         return 0;
6342  000b 4f            	clr	a
6345  000c 81            	ret
6346  000d               L3022:
6347                     ; 1863     return 1;
6349  000d a601          	ld	a,#1
6352  000f 81            	ret
6386                     ; 1872 uint8_t setProximityIntLowThreshold(uint8_t threshold)
6386                     ; 1873 {
6387                     .text:	section	.text,new
6388  0000               _setProximityIntLowThreshold:
6392                     ; 1876     if( !wireWriteDataByte(APDS9960_PILT, threshold) ) {
6394  0000 97            	ld	xl,a
6395  0001 a689          	ld	a,#137
6396  0003 95            	ld	xh,a
6397  0004 cd0000        	call	_wireWriteDataByte
6399  0007 4d            	tnz	a
6400  0008 2602          	jrne	L1222
6401                     ; 1877         return 0;
6403  000a 4f            	clr	a
6406  000b 81            	ret
6407  000c               L1222:
6408                     ; 1880     return 1;
6410  000c a601          	ld	a,#1
6413  000e 81            	ret
6450                     ; 1889 uint8_t getProximityIntHighThreshold(uint8_t *threshold)
6450                     ; 1890 {
6451                     .text:	section	.text,new
6452  0000               _getProximityIntHighThreshold:
6456                     ; 1891     *threshold = 0;
6458  0000 7f            	clr	(x)
6459                     ; 1894     if( !wireReadDataByte(APDS9960_PIHT, threshold) ) {
6461  0001 89            	pushw	x
6462  0002 a68b          	ld	a,#139
6463  0004 cd0000        	call	_wireReadDataByte
6465  0007 85            	popw	x
6466  0008 4d            	tnz	a
6467  0009 2602          	jrne	L1422
6468                     ; 1895         return 0;
6470  000b 4f            	clr	a
6473  000c 81            	ret
6474  000d               L1422:
6475                     ; 1898     return 1;
6477  000d a601          	ld	a,#1
6480  000f 81            	ret
6514                     ; 1907 uint8_t setProximityIntHighThreshold(uint8_t threshold)
6514                     ; 1908 {
6515                     .text:	section	.text,new
6516  0000               _setProximityIntHighThreshold:
6520                     ; 1911     if( !wireWriteDataByte(APDS9960_PIHT, threshold) ) {
6522  0000 97            	ld	xl,a
6523  0001 a68b          	ld	a,#139
6524  0003 95            	ld	xh,a
6525  0004 cd0000        	call	_wireWriteDataByte
6527  0007 4d            	tnz	a
6528  0008 2602          	jrne	L7522
6529                     ; 1912         return 0;
6531  000a 4f            	clr	a
6534  000b 81            	ret
6535  000c               L7522:
6536                     ; 1915     return 1;
6538  000c a601          	ld	a,#1
6541  000e 81            	ret
6575                     ; 1923 uint8_t getAmbientLightIntEnable(void)
6575                     ; 1924 {
6576                     .text:	section	.text,new
6577  0000               _getAmbientLightIntEnable:
6579  0000 88            	push	a
6580       00000001      OFST:	set	1
6583                     ; 1928     if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6585  0001 96            	ldw	x,sp
6586  0002 1c0001        	addw	x,#OFST+0
6587  0005 89            	pushw	x
6588  0006 a680          	ld	a,#128
6589  0008 cd0000        	call	_wireReadDataByte
6591  000b 85            	popw	x
6592  000c 4d            	tnz	a
6593  000d 2605          	jrne	L5722
6594                     ; 1929         return APDS9960_ERROR;
6596  000f a6ff          	ld	a,#255
6599  0011 5b01          	addw	sp,#1
6600  0013 81            	ret
6601  0014               L5722:
6602                     ; 1933     val = (val >> 4) & 0b00000001;
6604  0014 7b01          	ld	a,(OFST+0,sp)
6605  0016 4e            	swap	a
6606  0017 a40f          	and	a,#15
6607  0019 a401          	and	a,#1
6608  001b 6b01          	ld	(OFST+0,sp),a
6609                     ; 1935     return val;
6611  001d 7b01          	ld	a,(OFST+0,sp)
6614  001f 5b01          	addw	sp,#1
6615  0021 81            	ret
6657                     ; 1944 uint8_t setAmbientLightIntEnable(uint8_t enable)
6657                     ; 1945 {
6658                     .text:	section	.text,new
6659  0000               _setAmbientLightIntEnable:
6661  0000 88            	push	a
6662  0001 88            	push	a
6663       00000001      OFST:	set	1
6666                     ; 1949     if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6668  0002 96            	ldw	x,sp
6669  0003 1c0001        	addw	x,#OFST+0
6670  0006 89            	pushw	x
6671  0007 a680          	ld	a,#128
6672  0009 cd0000        	call	_wireReadDataByte
6674  000c 85            	popw	x
6675  000d 4d            	tnz	a
6676  000e 2603          	jrne	L5132
6677                     ; 1950         return 0;
6679  0010 4f            	clr	a
6681  0011 2026          	jra	L613
6682  0013               L5132:
6683                     ; 1954     enable &= 0b00000001;
6685  0013 7b02          	ld	a,(OFST+1,sp)
6686  0015 a401          	and	a,#1
6687  0017 6b02          	ld	(OFST+1,sp),a
6688                     ; 1955     enable = enable << 4;
6690  0019 7b02          	ld	a,(OFST+1,sp)
6691  001b 4e            	swap	a
6692  001c a4f0          	and	a,#240
6693  001e 6b02          	ld	(OFST+1,sp),a
6694                     ; 1956     val &= 0b11101111;
6696  0020 7b01          	ld	a,(OFST+0,sp)
6697  0022 a4ef          	and	a,#239
6698  0024 6b01          	ld	(OFST+0,sp),a
6699                     ; 1957     val |= enable;
6701  0026 7b01          	ld	a,(OFST+0,sp)
6702  0028 1a02          	or	a,(OFST+1,sp)
6703  002a 6b01          	ld	(OFST+0,sp),a
6704                     ; 1960     if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
6706  002c 7b01          	ld	a,(OFST+0,sp)
6707  002e 97            	ld	xl,a
6708  002f a680          	ld	a,#128
6709  0031 95            	ld	xh,a
6710  0032 cd0000        	call	_wireWriteDataByte
6712  0035 4d            	tnz	a
6713  0036 2603          	jrne	L7132
6714                     ; 1961         return 0;
6716  0038 4f            	clr	a
6718  0039               L613:
6720  0039 85            	popw	x
6721  003a 81            	ret
6722  003b               L7132:
6723                     ; 1964     return 1;
6725  003b a601          	ld	a,#1
6727  003d 20fa          	jra	L613
6761                     ; 1972 uint8_t getProximityIntEnable(void)
6761                     ; 1973 {
6762                     .text:	section	.text,new
6763  0000               _getProximityIntEnable:
6765  0000 88            	push	a
6766       00000001      OFST:	set	1
6769                     ; 1977     if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6771  0001 96            	ldw	x,sp
6772  0002 1c0001        	addw	x,#OFST+0
6773  0005 89            	pushw	x
6774  0006 a680          	ld	a,#128
6775  0008 cd0000        	call	_wireReadDataByte
6777  000b 85            	popw	x
6778  000c 4d            	tnz	a
6779  000d 2605          	jrne	L5332
6780                     ; 1978         return APDS9960_ERROR;
6782  000f a6ff          	ld	a,#255
6785  0011 5b01          	addw	sp,#1
6786  0013 81            	ret
6787  0014               L5332:
6788                     ; 1982     val = (val >> 5) & 0b00000001;
6790  0014 7b01          	ld	a,(OFST+0,sp)
6791  0016 4e            	swap	a
6792  0017 44            	srl	a
6793  0018 a407          	and	a,#7
6794  001a a401          	and	a,#1
6795  001c 6b01          	ld	(OFST+0,sp),a
6796                     ; 1984     return val;
6798  001e 7b01          	ld	a,(OFST+0,sp)
6801  0020 5b01          	addw	sp,#1
6802  0022 81            	ret
6844                     ; 1993 uint8_t setProximityIntEnable(uint8_t enable)
6844                     ; 1994 {
6845                     .text:	section	.text,new
6846  0000               _setProximityIntEnable:
6848  0000 88            	push	a
6849  0001 88            	push	a
6850       00000001      OFST:	set	1
6853                     ; 1998     if( !wireReadDataByte(APDS9960_ENABLE, &val) ) {
6855  0002 96            	ldw	x,sp
6856  0003 1c0001        	addw	x,#OFST+0
6857  0006 89            	pushw	x
6858  0007 a680          	ld	a,#128
6859  0009 cd0000        	call	_wireReadDataByte
6861  000c 85            	popw	x
6862  000d 4d            	tnz	a
6863  000e 2603          	jrne	L5532
6864                     ; 1999         return 0;
6866  0010 4f            	clr	a
6868  0011 2027          	jra	L423
6869  0013               L5532:
6870                     ; 2003     enable &= 0b00000001;
6872  0013 7b02          	ld	a,(OFST+1,sp)
6873  0015 a401          	and	a,#1
6874  0017 6b02          	ld	(OFST+1,sp),a
6875                     ; 2004     enable = enable << 5;
6877  0019 7b02          	ld	a,(OFST+1,sp)
6878  001b 4e            	swap	a
6879  001c 48            	sll	a
6880  001d a4e0          	and	a,#224
6881  001f 6b02          	ld	(OFST+1,sp),a
6882                     ; 2005     val &= 0b11011111;
6884  0021 7b01          	ld	a,(OFST+0,sp)
6885  0023 a4df          	and	a,#223
6886  0025 6b01          	ld	(OFST+0,sp),a
6887                     ; 2006     val |= enable;
6889  0027 7b01          	ld	a,(OFST+0,sp)
6890  0029 1a02          	or	a,(OFST+1,sp)
6891  002b 6b01          	ld	(OFST+0,sp),a
6892                     ; 2009     if( !wireWriteDataByte(APDS9960_ENABLE, val) ) {
6894  002d 7b01          	ld	a,(OFST+0,sp)
6895  002f 97            	ld	xl,a
6896  0030 a680          	ld	a,#128
6897  0032 95            	ld	xh,a
6898  0033 cd0000        	call	_wireWriteDataByte
6900  0036 4d            	tnz	a
6901  0037 2603          	jrne	L7532
6902                     ; 2010         return 0;
6904  0039 4f            	clr	a
6906  003a               L423:
6908  003a 85            	popw	x
6909  003b 81            	ret
6910  003c               L7532:
6911                     ; 2013     return 1;
6913  003c a601          	ld	a,#1
6915  003e 20fa          	jra	L423
6949                     ; 2021 uint8_t getGestureIntEnable(void)
6949                     ; 2022 {
6950                     .text:	section	.text,new
6951  0000               _getGestureIntEnable:
6953  0000 88            	push	a
6954       00000001      OFST:	set	1
6957                     ; 2026     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
6959  0001 96            	ldw	x,sp
6960  0002 1c0001        	addw	x,#OFST+0
6961  0005 89            	pushw	x
6962  0006 a6ab          	ld	a,#171
6963  0008 cd0000        	call	_wireReadDataByte
6965  000b 85            	popw	x
6966  000c 4d            	tnz	a
6967  000d 2605          	jrne	L5732
6968                     ; 2027         return APDS9960_ERROR;
6970  000f a6ff          	ld	a,#255
6973  0011 5b01          	addw	sp,#1
6974  0013 81            	ret
6975  0014               L5732:
6976                     ; 2031     val = (val >> 1) & 0b00000001;
6978  0014 7b01          	ld	a,(OFST+0,sp)
6979  0016 44            	srl	a
6980  0017 a401          	and	a,#1
6981  0019 6b01          	ld	(OFST+0,sp),a
6982                     ; 2033     return val;
6984  001b 7b01          	ld	a,(OFST+0,sp)
6987  001d 5b01          	addw	sp,#1
6988  001f 81            	ret
7030                     ; 2042 uint8_t setGestureIntEnable(uint8_t enable)
7030                     ; 2043 {
7031                     .text:	section	.text,new
7032  0000               _setGestureIntEnable:
7034  0000 88            	push	a
7035  0001 88            	push	a
7036       00000001      OFST:	set	1
7039                     ; 2047     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7041  0002 96            	ldw	x,sp
7042  0003 1c0001        	addw	x,#OFST+0
7043  0006 89            	pushw	x
7044  0007 a6ab          	ld	a,#171
7045  0009 cd0000        	call	_wireReadDataByte
7047  000c 85            	popw	x
7048  000d 4d            	tnz	a
7049  000e 2603          	jrne	L5142
7050                     ; 2048         return 0;
7052  0010 4f            	clr	a
7054  0011 2021          	jra	L233
7055  0013               L5142:
7056                     ; 2052     enable &= 0b00000001;
7058  0013 7b02          	ld	a,(OFST+1,sp)
7059  0015 a401          	and	a,#1
7060  0017 6b02          	ld	(OFST+1,sp),a
7061                     ; 2053     enable = enable << 1;
7063  0019 0802          	sll	(OFST+1,sp)
7064                     ; 2054     val &= 0b11111101;
7066  001b 7b01          	ld	a,(OFST+0,sp)
7067  001d a4fd          	and	a,#253
7068  001f 6b01          	ld	(OFST+0,sp),a
7069                     ; 2055     val |= enable;
7071  0021 7b01          	ld	a,(OFST+0,sp)
7072  0023 1a02          	or	a,(OFST+1,sp)
7073  0025 6b01          	ld	(OFST+0,sp),a
7074                     ; 2058     if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
7076  0027 7b01          	ld	a,(OFST+0,sp)
7077  0029 97            	ld	xl,a
7078  002a a6ab          	ld	a,#171
7079  002c 95            	ld	xh,a
7080  002d cd0000        	call	_wireWriteDataByte
7082  0030 4d            	tnz	a
7083  0031 2603          	jrne	L7142
7084                     ; 2059         return 0;
7086  0033 4f            	clr	a
7088  0034               L233:
7090  0034 85            	popw	x
7091  0035 81            	ret
7092  0036               L7142:
7093                     ; 2062     return 1;
7095  0036 a601          	ld	a,#1
7097  0038 20fa          	jra	L233
7131                     ; 2070 uint8_t clearAmbientLightInt(void)
7131                     ; 2071 {
7132                     .text:	section	.text,new
7133  0000               _clearAmbientLightInt:
7135  0000 88            	push	a
7136       00000001      OFST:	set	1
7139                     ; 2073     if( !wireReadDataByte(APDS9960_AICLEAR, &throwaway) ) {
7141  0001 96            	ldw	x,sp
7142  0002 1c0001        	addw	x,#OFST+0
7143  0005 89            	pushw	x
7144  0006 a6e7          	ld	a,#231
7145  0008 cd0000        	call	_wireReadDataByte
7147  000b 85            	popw	x
7148  000c 4d            	tnz	a
7149  000d 2604          	jrne	L5342
7150                     ; 2074         return 0;
7152  000f 4f            	clr	a
7155  0010 5b01          	addw	sp,#1
7156  0012 81            	ret
7157  0013               L5342:
7158                     ; 2077     return 1;
7160  0013 a601          	ld	a,#1
7163  0015 5b01          	addw	sp,#1
7164  0017 81            	ret
7197                     ; 2085 uint8_t clearProximityInt(void)
7197                     ; 2086 {
7198                     .text:	section	.text,new
7199  0000               _clearProximityInt:
7201  0000 88            	push	a
7202       00000001      OFST:	set	1
7205                     ; 2088     if( !wireReadDataByte(APDS9960_PICLEAR, &throwaway) ) {
7207  0001 96            	ldw	x,sp
7208  0002 1c0001        	addw	x,#OFST+0
7209  0005 89            	pushw	x
7210  0006 a6e5          	ld	a,#229
7211  0008 cd0000        	call	_wireReadDataByte
7213  000b 85            	popw	x
7214  000c 4d            	tnz	a
7215  000d 2604          	jrne	L3542
7216                     ; 2089         return 0;
7218  000f 4f            	clr	a
7221  0010 5b01          	addw	sp,#1
7222  0012 81            	ret
7223  0013               L3542:
7224                     ; 2092     return 1;
7226  0013 a601          	ld	a,#1
7229  0015 5b01          	addw	sp,#1
7230  0017 81            	ret
7263                     ; 2100 uint8_t getGestureMode(void)
7263                     ; 2101 {
7264                     .text:	section	.text,new
7265  0000               _getGestureMode:
7267  0000 88            	push	a
7268       00000001      OFST:	set	1
7271                     ; 2105     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7273  0001 96            	ldw	x,sp
7274  0002 1c0001        	addw	x,#OFST+0
7275  0005 89            	pushw	x
7276  0006 a6ab          	ld	a,#171
7277  0008 cd0000        	call	_wireReadDataByte
7279  000b 85            	popw	x
7280  000c 4d            	tnz	a
7281  000d 2605          	jrne	L1742
7282                     ; 2106         return APDS9960_ERROR;
7284  000f a6ff          	ld	a,#255
7287  0011 5b01          	addw	sp,#1
7288  0013 81            	ret
7289  0014               L1742:
7290                     ; 2110     val &= 0b00000001;
7292  0014 7b01          	ld	a,(OFST+0,sp)
7293  0016 a401          	and	a,#1
7294  0018 6b01          	ld	(OFST+0,sp),a
7295                     ; 2112     return val;
7297  001a 7b01          	ld	a,(OFST+0,sp)
7300  001c 5b01          	addw	sp,#1
7301  001e 81            	ret
7342                     ; 2121 uint8_t setGestureMode(uint8_t mode)
7342                     ; 2122 {
7343                     .text:	section	.text,new
7344  0000               _setGestureMode:
7346  0000 88            	push	a
7347  0001 88            	push	a
7348       00000001      OFST:	set	1
7351                     ; 2126     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
7353  0002 96            	ldw	x,sp
7354  0003 1c0001        	addw	x,#OFST+0
7355  0006 89            	pushw	x
7356  0007 a6ab          	ld	a,#171
7357  0009 cd0000        	call	_wireReadDataByte
7359  000c 85            	popw	x
7360  000d 4d            	tnz	a
7361  000e 2603          	jrne	L1152
7362                     ; 2127         return 0;
7364  0010 4f            	clr	a
7366  0011 201f          	jra	L443
7367  0013               L1152:
7368                     ; 2131     mode &= 0b00000001;
7370  0013 7b02          	ld	a,(OFST+1,sp)
7371  0015 a401          	and	a,#1
7372  0017 6b02          	ld	(OFST+1,sp),a
7373                     ; 2132     val &= 0b11111110;
7375  0019 7b01          	ld	a,(OFST+0,sp)
7376  001b a4fe          	and	a,#254
7377  001d 6b01          	ld	(OFST+0,sp),a
7378                     ; 2133     val |= mode;
7380  001f 7b01          	ld	a,(OFST+0,sp)
7381  0021 1a02          	or	a,(OFST+1,sp)
7382  0023 6b01          	ld	(OFST+0,sp),a
7383                     ; 2136     if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
7385  0025 7b01          	ld	a,(OFST+0,sp)
7386  0027 97            	ld	xl,a
7387  0028 a6ab          	ld	a,#171
7388  002a 95            	ld	xh,a
7389  002b cd0000        	call	_wireWriteDataByte
7391  002e 4d            	tnz	a
7392  002f 2603          	jrne	L3152
7393                     ; 2137         return 0;
7395  0031 4f            	clr	a
7397  0032               L443:
7399  0032 85            	popw	x
7400  0033 81            	ret
7401  0034               L3152:
7402                     ; 2140     return 1;
7404  0034 a601          	ld	a,#1
7406  0036 20fa          	jra	L443
7446                     ; 2153 uint8_t wireWriteByte(uint8_t val)
7446                     ; 2154 {
7447                     .text:	section	.text,new
7448  0000               _wireWriteByte:
7450  0000 88            	push	a
7451  0001 88            	push	a
7452       00000001      OFST:	set	1
7455                     ; 2156 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR,&val,1,10);
7457  0002 4b0a          	push	#10
7458  0004 4b01          	push	#1
7459  0006 96            	ldw	x,sp
7460  0007 1c0004        	addw	x,#OFST+3
7461  000a 89            	pushw	x
7462  000b ae0039        	ldw	x,#57
7463  000e cd0000        	call	_I2C_WriteBytes
7465  0011 5b04          	addw	sp,#4
7466  0013 6b01          	ld	(OFST+0,sp),a
7467                     ; 2157   if(ret != IIC_SUCCESS){
7469  0015 0d01          	tnz	(OFST+0,sp)
7470  0017 2703          	jreq	L3352
7471                     ; 2158 		return 0;
7473  0019 4f            	clr	a
7475  001a 2002          	jra	L053
7476  001c               L3352:
7477                     ; 2160 	return 1;
7479  001c a601          	ld	a,#1
7481  001e               L053:
7483  001e 85            	popw	x
7484  001f 81            	ret
7541                     ; 2170 uint8_t wireWriteDataByte(uint8_t reg, uint8_t val)
7541                     ; 2171 {
7542                     .text:	section	.text,new
7543  0000               _wireWriteDataByte:
7545  0000 5203          	subw	sp,#3
7546       00000003      OFST:	set	3
7549                     ; 2174 	buffer[0] = reg;
7551  0002 9e            	ld	a,xh
7552  0003 6b02          	ld	(OFST-1,sp),a
7553                     ; 2175 	buffer[1] = val;
7555  0005 9f            	ld	a,xl
7556  0006 6b03          	ld	(OFST+0,sp),a
7557                     ; 2176 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR,buffer,2,10);
7559  0008 4b0a          	push	#10
7560  000a 4b02          	push	#2
7561  000c 96            	ldw	x,sp
7562  000d 1c0004        	addw	x,#OFST+1
7563  0010 89            	pushw	x
7564  0011 ae0039        	ldw	x,#57
7565  0014 cd0000        	call	_I2C_WriteBytes
7567  0017 5b04          	addw	sp,#4
7568  0019 6b01          	ld	(OFST-2,sp),a
7569                     ; 2177   if(ret != IIC_SUCCESS){
7571  001b 0d01          	tnz	(OFST-2,sp)
7572  001d 2703          	jreq	L1652
7573                     ; 2178 		return 0;
7575  001f 4f            	clr	a
7577  0020 2002          	jra	L453
7578  0022               L1652:
7579                     ; 2180 	return 1;
7581  0022 a601          	ld	a,#1
7583  0024               L453:
7585  0024 5b03          	addw	sp,#3
7586  0026 81            	ret
7589                     	switch	.bss
7590  0000               L3652_buffer:
7591  0000 000000000000  	ds.b	128
7663                     ; 2191 uint8_t wireWriteDataBlock(  uint8_t reg, 
7663                     ; 2192                                         uint8_t *val, 
7663                     ; 2193                                         unsigned int len)
7663                     ; 2194 {
7664                     .text:	section	.text,new
7665  0000               _wireWriteDataBlock:
7667  0000 88            	push	a
7668  0001 5203          	subw	sp,#3
7669       00000003      OFST:	set	3
7672                     ; 2198 	buffer[0] = reg;
7674  0003 c70000        	ld	L3652_buffer,a
7675                     ; 2199 	for(i = 0; (i < len)&&(i<sizeof(buffer)); i++) {
7677  0006 5f            	clrw	x
7678  0007 1f02          	ldw	(OFST-1,sp),x
7680  0009 2017          	jra	L3262
7681  000b               L7162:
7682                     ; 2200 			buffer[1+i] = *val++;
7684  000b 1e07          	ldw	x,(OFST+4,sp)
7685  000d 1c0001        	addw	x,#1
7686  0010 1f07          	ldw	(OFST+4,sp),x
7687  0012 1d0001        	subw	x,#1
7688  0015 f6            	ld	a,(x)
7689  0016 1e02          	ldw	x,(OFST-1,sp)
7690  0018 d70001        	ld	(L3652_buffer+1,x),a
7691                     ; 2199 	for(i = 0; (i < len)&&(i<sizeof(buffer)); i++) {
7693  001b 1e02          	ldw	x,(OFST-1,sp)
7694  001d 1c0001        	addw	x,#1
7695  0020 1f02          	ldw	(OFST-1,sp),x
7696  0022               L3262:
7699  0022 1e02          	ldw	x,(OFST-1,sp)
7700  0024 1309          	cpw	x,(OFST+6,sp)
7701  0026 2407          	jruge	L7262
7703  0028 1e02          	ldw	x,(OFST-1,sp)
7704  002a a30080        	cpw	x,#128
7705  002d 25dc          	jrult	L7162
7706  002f               L7262:
7707                     ; 2202 	ret = I2C_WriteBytes(APDS9960_I2C_ADDR,buffer,i+1,100);
7709  002f 4b64          	push	#100
7710  0031 7b04          	ld	a,(OFST+1,sp)
7711  0033 4c            	inc	a
7712  0034 88            	push	a
7713  0035 ae0000        	ldw	x,#L3652_buffer
7714  0038 89            	pushw	x
7715  0039 ae0039        	ldw	x,#57
7716  003c cd0000        	call	_I2C_WriteBytes
7718  003f 5b04          	addw	sp,#4
7719  0041 6b01          	ld	(OFST-2,sp),a
7720                     ; 2203   if(ret != IIC_SUCCESS){
7722  0043 0d01          	tnz	(OFST-2,sp)
7723  0045 2703          	jreq	L1362
7724                     ; 2204 		return 0;
7726  0047 4f            	clr	a
7728  0048 2002          	jra	L063
7729  004a               L1362:
7730                     ; 2206 	return 1;
7732  004a a601          	ld	a,#1
7734  004c               L063:
7736  004c 5b04          	addw	sp,#4
7737  004e 81            	ret
7787                     ; 2216 uint8_t wireReadDataByte(uint8_t reg, uint8_t *val)
7787                     ; 2217 {
7788                     .text:	section	.text,new
7789  0000               _wireReadDataByte:
7791  0000 88            	push	a
7792  0001 88            	push	a
7793       00000001      OFST:	set	1
7796                     ; 2219 	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR,&reg,1,val,1,10);
7798  0002 4b0a          	push	#10
7799  0004 4b01          	push	#1
7800  0006 1e07          	ldw	x,(OFST+6,sp)
7801  0008 89            	pushw	x
7802  0009 4b01          	push	#1
7803  000b 96            	ldw	x,sp
7804  000c 1c0007        	addw	x,#OFST+6
7805  000f 89            	pushw	x
7806  0010 ae0039        	ldw	x,#57
7807  0013 cd0000        	call	_I2C_WriteReadBytes
7809  0016 5b07          	addw	sp,#7
7810  0018 6b01          	ld	(OFST+0,sp),a
7811                     ; 2220   if(ret != IIC_SUCCESS){
7813  001a 0d01          	tnz	(OFST+0,sp)
7814  001c 2703          	jreq	L5562
7815                     ; 2221 		return 0;
7817  001e 4f            	clr	a
7819  001f 2002          	jra	L463
7820  0021               L5562:
7821                     ; 2223 	return 1;
7823  0021 a601          	ld	a,#1
7825  0023               L463:
7827  0023 85            	popw	x
7828  0024 81            	ret
7885                     ; 2234 int wireReadDataBlock(   uint8_t reg, 
7885                     ; 2235                                         uint8_t *val, 
7885                     ; 2236                                         unsigned int len)
7885                     ; 2237 {
7886                     .text:	section	.text,new
7887  0000               _wireReadDataBlock:
7889  0000 88            	push	a
7890  0001 88            	push	a
7891       00000001      OFST:	set	1
7894                     ; 2239 	ret = I2C_WriteReadBytes(APDS9960_I2C_ADDR,&reg,1,val,len,100);
7896  0002 4b64          	push	#100
7897  0004 7b09          	ld	a,(OFST+8,sp)
7898  0006 88            	push	a
7899  0007 1e07          	ldw	x,(OFST+6,sp)
7900  0009 89            	pushw	x
7901  000a 4b01          	push	#1
7902  000c 96            	ldw	x,sp
7903  000d 1c0007        	addw	x,#OFST+6
7904  0010 89            	pushw	x
7905  0011 ae0039        	ldw	x,#57
7906  0014 cd0000        	call	_I2C_WriteReadBytes
7908  0017 5b07          	addw	sp,#7
7909  0019 6b01          	ld	(OFST+0,sp),a
7910                     ; 2240   if(ret != IIC_SUCCESS){
7912  001b 0d01          	tnz	(OFST+0,sp)
7913  001d 2703          	jreq	L3072
7914                     ; 2241 		return 0;
7916  001f 5f            	clrw	x
7918  0020 2002          	jra	L073
7919  0022               L3072:
7920                     ; 2243 	return len;
7922  0022 1e07          	ldw	x,(OFST+6,sp)
7924  0024               L073:
7926  0024 5b02          	addw	sp,#2
7927  0026 81            	ret
8084                     	switch	.bss
8085  0080               _gesture_motion_:
8086  0080 0000          	ds.b	2
8087                     	xdef	_gesture_motion_
8088  0082               _gesture_state_:
8089  0082 0000          	ds.b	2
8090                     	xdef	_gesture_state_
8091  0084               _gesture_far_count_:
8092  0084 0000          	ds.b	2
8093                     	xdef	_gesture_far_count_
8094  0086               _gesture_near_count_:
8095  0086 0000          	ds.b	2
8096                     	xdef	_gesture_near_count_
8097  0088               _gesture_lr_count_:
8098  0088 0000          	ds.b	2
8099                     	xdef	_gesture_lr_count_
8100  008a               _gesture_ud_count_:
8101  008a 0000          	ds.b	2
8102                     	xdef	_gesture_ud_count_
8103  008c               _gesture_lr_delta_:
8104  008c 0000          	ds.b	2
8105                     	xdef	_gesture_lr_delta_
8106  008e               _gesture_ud_delta_:
8107  008e 0000          	ds.b	2
8108                     	xdef	_gesture_ud_delta_
8109  0090               _gesture_data_:
8110  0090 000000000000  	ds.b	132
8111                     	xdef	_gesture_data_
8112                     	xdef	_wireReadDataBlock
8113                     	xdef	_wireReadDataByte
8114                     	xdef	_wireWriteDataBlock
8115                     	xdef	_wireWriteDataByte
8116                     	xdef	_wireWriteByte
8117                     	xdef	_setGestureMode
8118                     	xdef	_getGestureMode
8119                     	xdef	_setGestureWaitTime
8120                     	xdef	_getGestureWaitTime
8121                     	xdef	_setGestureExitThresh
8122                     	xdef	_getGestureExitThresh
8123                     	xdef	_setGestureEnterThresh
8124                     	xdef	_getGestureEnterThresh
8125                     	xdef	_setProxPhotoMask
8126                     	xdef	_getProxPhotoMask
8127                     	xdef	_setProxGainCompEnable
8128                     	xdef	_getProxGainCompEnable
8129                     	xdef	_setLEDBoost
8130                     	xdef	_getLEDBoost
8131                     	xdef	_setProxIntHighThresh
8132                     	xdef	_getProxIntHighThresh
8133                     	xdef	_setProxIntLowThresh
8134                     	xdef	_getProxIntLowThresh
8135                     	xdef	_decodeGesture
8136                     	xdef	_processGestureData
8137                     	xdef	_resetGestureParameters
8138                     	xref	_TIM3_tout
8139                     	xref	_I2C_WriteReadBytes
8140                     	xref	_I2C_WriteBytes
8141                     	xref	_I2C_Config
8142                     	xdef	_readGesture
8143                     	xdef	_isGestureAvailable
8144                     	xdef	_readProximity
8145                     	xdef	_readBlueLight
8146                     	xdef	_readGreenLight
8147                     	xdef	_readRedLight
8148                     	xdef	_readAmbientLight
8149                     	xdef	_clearProximityInt
8150                     	xdef	_clearAmbientLightInt
8151                     	xdef	_setGestureIntEnable
8152                     	xdef	_getGestureIntEnable
8153                     	xdef	_setProximityIntEnable
8154                     	xdef	_getProximityIntEnable
8155                     	xdef	_setAmbientLightIntEnable
8156                     	xdef	_getAmbientLightIntEnable
8157                     	xdef	_setProximityIntHighThreshold
8158                     	xdef	_getProximityIntHighThreshold
8159                     	xdef	_setProximityIntLowThreshold
8160                     	xdef	_getProximityIntLowThreshold
8161                     	xdef	_setLightIntHighThreshold
8162                     	xdef	_getLightIntHighThreshold
8163                     	xdef	_setLightIntLowThreshold
8164                     	xdef	_getLightIntLowThreshold
8165                     	xdef	_setGestureGain
8166                     	xdef	_getGestureGain
8167                     	xdef	_setProximityGain
8168                     	xdef	_getProximityGain
8169                     	xdef	_setAmbientLightGain
8170                     	xdef	_getAmbientLightGain
8171                     	xdef	_setGestureLEDDrive
8172                     	xdef	_getGestureLEDDrive
8173                     	xdef	_setLEDDrive
8174                     	xdef	_getLEDDrive
8175                     	xdef	_disableGestureSensor
8176                     	xdef	_enableGestureSensor
8177                     	xdef	_disableProximitySensor
8178                     	xdef	_enableProximitySensor
8179                     	xdef	_disableLightSensor
8180                     	xdef	_enableLightSensor
8181                     	xdef	_disablePower
8182                     	xdef	_enablePower
8183                     	xdef	_setMode
8184                     	xdef	_getMode
8185                     	xdef	_init
8186                     	xdef	_SparkFun_APDS9960
8187                     	xref	_abs
8188                     	xref.b	c_x
8189                     	xref.b	c_y
8209                     	xref	c_idiv
8210                     	xref	c_imul
8211                     	end
