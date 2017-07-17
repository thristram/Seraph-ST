   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
 216                     ; 21 void delay_ms(u8 t)
 216                     ; 22 {
 218                     .text:	section	.text,new
 219  0000               _delay_ms:
 221  0000 5204          	subw	sp,#4
 222       00000004      OFST:	set	4
 225                     ; 24 	for (i = t;i > 0;i--)
 227  0002 5f            	clrw	x
 228  0003 97            	ld	xl,a
 229  0004 1f01          	ldw	(OFST-3,sp),x
 231  0006 2018          	jra	L521
 232  0008               L121:
 233                     ; 26 		for(j = 0;j < 620;j++);
 235  0008 5f            	clrw	x
 236  0009 1f03          	ldw	(OFST-1,sp),x
 237  000b               L131:
 241  000b 1e03          	ldw	x,(OFST-1,sp)
 242  000d 1c0001        	addw	x,#1
 243  0010 1f03          	ldw	(OFST-1,sp),x
 246  0012 1e03          	ldw	x,(OFST-1,sp)
 247  0014 a3026c        	cpw	x,#620
 248  0017 25f2          	jrult	L131
 249                     ; 24 	for (i = t;i > 0;i--)
 251  0019 1e01          	ldw	x,(OFST-3,sp)
 252  001b 1d0001        	subw	x,#1
 253  001e 1f01          	ldw	(OFST-3,sp),x
 254  0020               L521:
 257  0020 1e01          	ldw	x,(OFST-3,sp)
 258  0022 26e4          	jrne	L121
 259                     ; 28 }
 262  0024 5b04          	addw	sp,#4
 263  0026 81            	ret
 350                     ; 36 void IIC_Delay(void)
 350                     ; 37 {
 351                     .text:	section	.text,new
 352  0000               _IIC_Delay:
 356                     ; 38 	nop();//0.125us
 359  0000 9d            nop
 361                     ; 39 	nop();
 365  0001 9d            nop
 367                     ; 40 	nop();
 371  0002 9d            nop
 373                     ; 41 	nop();
 377  0003 9d            nop
 379                     ; 42 	nop();
 383  0004 9d            nop
 385                     ; 43 	nop();
 389  0005 9d            nop
 391                     ; 44 	nop();
 395  0006 9d            nop
 397                     ; 45 	nop();
 401  0007 9d            nop
 403                     ; 46 	nop();
 407  0008 9d            nop
 409                     ; 47 	nop();
 413  0009 9d            nop
 415                     ; 48 	nop();
 419  000a 9d            nop
 421                     ; 49 	nop();
 425  000b 9d            nop
 427                     ; 50 	nop();
 431  000c 9d            nop
 433                     ; 51 	nop();
 437  000d 9d            nop
 439                     ; 52 	nop();
 443  000e 9d            nop
 445                     ; 53 	nop();
 449  000f 9d            nop
 451                     ; 54 	nop();//0.125us
 455  0010 9d            nop
 457                     ; 55 	nop();
 461  0011 9d            nop
 463                     ; 56 	nop();
 467  0012 9d            nop
 469                     ; 57 	nop();
 473  0013 9d            nop
 475                     ; 58 	nop();
 479  0014 9d            nop
 481                     ; 59 	nop();
 485  0015 9d            nop
 487                     ; 60 	nop();
 491  0016 9d            nop
 493                     ; 61 	nop();
 497  0017 9d            nop
 499                     ; 62 	nop();
 503  0018 9d            nop
 505                     ; 63 	nop();
 509  0019 9d            nop
 511                     ; 64 	nop();
 515  001a 9d            nop
 517                     ; 65 	nop();
 521  001b 9d            nop
 523                     ; 66 	nop();
 527  001c 9d            nop
 529                     ; 67 	nop();
 533  001d 9d            nop
 535                     ; 68 	nop();
 539  001e 9d            nop
 541                     ; 69 	nop();
 545  001f 9d            nop
 547                     ; 70 	nop();//0.125us
 551  0020 9d            nop
 553                     ; 71 	nop();
 557  0021 9d            nop
 559                     ; 72 	nop();
 563  0022 9d            nop
 565                     ; 73 	nop();
 569  0023 9d            nop
 571                     ; 74 	nop();
 575  0024 9d            nop
 577                     ; 75 	nop();
 581  0025 9d            nop
 583                     ; 76 	nop();
 587  0026 9d            nop
 589                     ; 77 	nop();
 593  0027 9d            nop
 595                     ; 78 	nop();
 599  0028 9d            nop
 601                     ; 79 	nop();
 605  0029 9d            nop
 607                     ; 80 	nop();
 611  002a 9d            nop
 613                     ; 81 	nop();
 617  002b 9d            nop
 619                     ; 82 	nop();
 623  002c 9d            nop
 625                     ; 83 	nop();
 629  002d 9d            nop
 631                     ; 84 	nop();
 635  002e 9d            nop
 637                     ; 85 	nop();
 641  002f 9d            nop
 643                     ; 86 	nop();//0.125us
 647  0030 9d            nop
 649                     ; 87 	nop();
 653  0031 9d            nop
 655                     ; 88 	nop();
 659  0032 9d            nop
 661                     ; 89 	nop();
 665  0033 9d            nop
 667                     ; 90 	nop();
 671  0034 9d            nop
 673                     ; 91 	nop();
 677  0035 9d            nop
 679                     ; 92 	nop();
 683  0036 9d            nop
 685                     ; 93 	nop();
 689  0037 9d            nop
 691                     ; 94 	nop();
 695  0038 9d            nop
 697                     ; 95 	nop();
 701  0039 9d            nop
 703                     ; 96 	nop();
 707  003a 9d            nop
 709                     ; 97 	nop();
 713  003b 9d            nop
 715                     ; 98 	nop();
 719  003c 9d            nop
 721                     ; 99 	nop();
 725  003d 9d            nop
 727                     ; 100 	nop();
 731  003e 9d            nop
 733                     ; 101 	nop();
 737  003f 9d            nop
 739                     ; 102 }
 743  0040 81            	ret
 801                     ; 109 ErrorStatus I2CCheckERREN(void) 
 801                     ; 110 { 
 802                     .text:	section	.text,new
 803  0000               _I2CCheckERREN:
 805  0000 88            	push	a
 806       00000001      OFST:	set	1
 809                     ; 111      ErrorStatus Swif = SUCCESS; 
 811  0001 a601          	ld	a,#1
 812  0003 6b01          	ld	(OFST+0,sp),a
 813                     ; 112      if(I2C_GetFlagStatus(I2C_FLAG_OVERRUNUNDERRUN) 
 813                     ; 113 				||I2C_GetFlagStatus(I2C_FLAG_ACKNOWLEDGEFAILURE) 
 813                     ; 114 				||I2C_GetFlagStatus(I2C_FLAG_ARBITRATIONLOSS) ||I2C_GetFlagStatus(I2C_FLAG_BUSERROR)) 
 815  0005 ae2108        	ldw	x,#8456
 816  0008 cd0000        	call	_I2C_GetFlagStatus
 818  000b 4d            	tnz	a
 819  000c 261b          	jrne	L771
 821  000e ae2104        	ldw	x,#8452
 822  0011 cd0000        	call	_I2C_GetFlagStatus
 824  0014 4d            	tnz	a
 825  0015 2612          	jrne	L771
 827  0017 ae2102        	ldw	x,#8450
 828  001a cd0000        	call	_I2C_GetFlagStatus
 830  001d 4d            	tnz	a
 831  001e 2609          	jrne	L771
 833  0020 ae2101        	ldw	x,#8449
 834  0023 cd0000        	call	_I2C_GetFlagStatus
 836  0026 4d            	tnz	a
 837  0027 271c          	jreq	L571
 838  0029               L771:
 839                     ; 116          Swif = ERROR; 
 841  0029 a6ff          	ld	a,#255
 842  002b 6b01          	ld	(OFST+0,sp),a
 843                     ; 117          I2C_ClearFlag(I2C_FLAG_OVERRUNUNDERRUN); 
 845  002d ae2108        	ldw	x,#8456
 846  0030 cd0000        	call	_I2C_ClearFlag
 848                     ; 118          I2C_ClearFlag(I2C_FLAG_ACKNOWLEDGEFAILURE); 
 850  0033 ae2104        	ldw	x,#8452
 851  0036 cd0000        	call	_I2C_ClearFlag
 853                     ; 119          I2C_ClearFlag(I2C_FLAG_ARBITRATIONLOSS); 
 855  0039 ae2102        	ldw	x,#8450
 856  003c cd0000        	call	_I2C_ClearFlag
 858                     ; 120          I2C_ClearFlag(I2C_FLAG_BUSERROR); 
 860  003f ae2101        	ldw	x,#8449
 861  0042 cd0000        	call	_I2C_ClearFlag
 863  0045               L571:
 864                     ; 122      return(Swif); 
 866  0045 7b01          	ld	a,(OFST+0,sp)
 869  0047 5b01          	addw	sp,#1
 870  0049 81            	ret
 897                     ; 130 void I2CSoftStop(void) 
 897                     ; 131 { 
 898                     .text:	section	.text,new
 899  0000               _I2CSoftStop:
 903                     ; 132      GPIO_Init(GPIOB, GPIO_PIN_4, GPIO_MODE_OUT_OD_LOW_SLOW); 
 905  0000 4ba0          	push	#160
 906  0002 4b10          	push	#16
 907  0004 ae5005        	ldw	x,#20485
 908  0007 cd0000        	call	_GPIO_Init
 910  000a 85            	popw	x
 911                     ; 133      GPIO_Init(GPIOB, GPIO_PIN_5, GPIO_MODE_OUT_OD_LOW_SLOW); 
 913  000b 4ba0          	push	#160
 914  000d 4b20          	push	#32
 915  000f ae5005        	ldw	x,#20485
 916  0012 cd0000        	call	_GPIO_Init
 918  0015 85            	popw	x
 919                     ; 134      GPIO_WriteHigh(GPIOB, GPIO_PIN_4); 
 921  0016 4b10          	push	#16
 922  0018 ae5005        	ldw	x,#20485
 923  001b cd0000        	call	_GPIO_WriteHigh
 925  001e 84            	pop	a
 926                     ; 135      GPIO_WriteLow(GPIOB, GPIO_PIN_5); 
 928  001f 4b20          	push	#32
 929  0021 ae5005        	ldw	x,#20485
 930  0024 cd0000        	call	_GPIO_WriteLow
 932  0027 84            	pop	a
 933                     ; 136      IIC_Delay(); 
 935  0028 cd0000        	call	_IIC_Delay
 937                     ; 137      GPIO_WriteHigh(GPIOB, GPIO_PIN_5); 
 939  002b 4b20          	push	#32
 940  002d ae5005        	ldw	x,#20485
 941  0030 cd0000        	call	_GPIO_WriteHigh
 943  0033 84            	pop	a
 944                     ; 138      IIC_Delay(); 
 946  0034 cd0000        	call	_IIC_Delay
 948                     ; 139 } 
 951  0037 81            	ret
 974                     ; 162 void IIC_Init(void)
 974                     ; 163 {
 975                     .text:	section	.text,new
 976  0000               _IIC_Init:
 980                     ; 164 	SDA_OUT();
 982  0000 721e500c      	bset	20492,#7
 985  0004 721f500d      	bres	20493,#7
 988  0008 721e500e      	bset	20494,#7
 989                     ; 165 	SCL_OUT();
 992  000c 721c500c      	bset	20492,#6
 995  0010 721d500d      	bres	20493,#6
 998  0014 721c500e      	bset	20494,#6
 999                     ; 166 	SDA(1);
1002  0018 721e500a      	bset	20490,#7
1003                     ; 167 	SCL(1);
1005  001c 721c500a      	bset	20490,#6
1006                     ; 168 }
1009  0020 81            	ret
1033                     ; 176 void IIC_Start(void)
1033                     ; 177 {
1034                     .text:	section	.text,new
1035  0000               _IIC_Start:
1039                     ; 178 	SDA_OUT();     //sda线输出
1041  0000 721e500c      	bset	20492,#7
1044  0004 721f500d      	bres	20493,#7
1047  0008 721e500e      	bset	20494,#7
1048                     ; 179 	SDA(1);	  	  
1051  000c 721e500a      	bset	20490,#7
1052                     ; 180 	SCL(1);
1054  0010 721c500a      	bset	20490,#6
1055                     ; 182   delay_ms(1);
1057  0014 a601          	ld	a,#1
1058  0016 cd0000        	call	_delay_ms
1060                     ; 183  	SDA(0);//START:when CLK is high,DATA change form high to low 
1062  0019 721f500a      	bres	20490,#7
1063                     ; 185   delay_ms(1);
1065  001d a601          	ld	a,#1
1066  001f cd0000        	call	_delay_ms
1068                     ; 186 	SCL(0);//钳住I2C总线，准备发送或接收数据 
1070  0022 721d500a      	bres	20490,#6
1071                     ; 187 	delay_ms(1);
1073  0026 a601          	ld	a,#1
1074  0028 cd0000        	call	_delay_ms
1076                     ; 188 }
1079  002b 81            	ret
1103                     ; 196 void IIC_Stop(void)
1103                     ; 197 {
1104                     .text:	section	.text,new
1105  0000               _IIC_Stop:
1109                     ; 198 	SDA_OUT();//sda线输出
1111  0000 721e500c      	bset	20492,#7
1114  0004 721f500d      	bres	20493,#7
1117  0008 721e500e      	bset	20494,#7
1118                     ; 199   SCL(0);
1121  000c 721d500a      	bres	20490,#6
1122                     ; 200 	SDA(0);//STOP:when CLK is high DATA change form low to high
1124  0010 721f500a      	bres	20490,#7
1125                     ; 202 	delay_ms(1);
1127  0014 a601          	ld	a,#1
1128  0016 cd0000        	call	_delay_ms
1130                     ; 203 	SCL(1);
1132  0019 721c500a      	bset	20490,#6
1133                     ; 205 	delay_ms(1);
1135  001d a601          	ld	a,#1
1136  001f cd0000        	call	_delay_ms
1138                     ; 206 	SDA(1);//发送I2C总线结束信号
1140  0022 721e500a      	bset	20490,#7
1141                     ; 208 	delay_ms(1);
1143  0026 a601          	ld	a,#1
1144  0028 cd0000        	call	_delay_ms
1146                     ; 209 }
1149  002b 81            	ret
1183                     .const:	section	.text
1184  0000               L42:
1185  0000 0000fde9      	dc.l	65001
1186                     ; 218 u8 IIC_Wait_Ack(void)
1186                     ; 219 {
1187                     .text:	section	.text,new
1188  0000               _IIC_Wait_Ack:
1190  0000 89            	pushw	x
1191       00000002      OFST:	set	2
1194                     ; 220 	u16 ucErrTime=0;
1196  0001 5f            	clrw	x
1197  0002 1f01          	ldw	(OFST-1,sp),x
1198                     ; 221 	SDA_IN();      //SDA设置为输入  
1200  0004 721f500c      	bres	20492,#7
1203  0008 721e500d      	bset	20493,#7
1206  000c 721f500e      	bres	20494,#7
1207                     ; 223 	delay_ms(1);	
1210  0010 a601          	ld	a,#1
1211  0012 cd0000        	call	_delay_ms
1213                     ; 224 	SCL(1);//IIC_Delay();	
1215  0015 721c500a      	bset	20490,#6
1216                     ; 225 	delay_ms(1);	
1218  0019 a601          	ld	a,#1
1219  001b cd0000        	call	_delay_ms
1222  001e 201c          	jra	L362
1223  0020               L162:
1224                     ; 228 		ucErrTime++;
1226  0020 1e01          	ldw	x,(OFST-1,sp)
1227  0022 1c0001        	addw	x,#1
1228  0025 1f01          	ldw	(OFST-1,sp),x
1229                     ; 229 		if(ucErrTime>65000)
1231  0027 9c            	rvf
1232  0028 1e01          	ldw	x,(OFST-1,sp)
1233  002a cd0000        	call	c_uitolx
1235  002d ae0000        	ldw	x,#L42
1236  0030 cd0000        	call	c_lcmp
1238  0033 2f07          	jrslt	L362
1239                     ; 231 			IIC_Stop();
1241  0035 cd0000        	call	_IIC_Stop
1243                     ; 232 			return 1;
1245  0038 a601          	ld	a,#1
1247  003a 200c          	jra	L62
1248  003c               L362:
1249                     ; 226 	while(READ_SDA)
1251  003c c6500b        	ld	a,20491
1252  003f a580          	bcp	a,#128
1253  0041 26dd          	jrne	L162
1254                     ; 235 	SCL(0);//时钟输出0 	   
1256  0043 721d500a      	bres	20490,#6
1257                     ; 236 	return 0;  
1259  0047 4f            	clr	a
1261  0048               L62:
1263  0048 85            	popw	x
1264  0049 81            	ret
1288                     ; 246 void IIC_Ack(void)
1288                     ; 247 {
1289                     .text:	section	.text,new
1290  0000               _IIC_Ack:
1294                     ; 248 	SCL(0);
1296  0000 721d500a      	bres	20490,#6
1297                     ; 249 	SDA_OUT();
1299  0004 721e500c      	bset	20492,#7
1302  0008 721f500d      	bres	20493,#7
1305  000c 721e500e      	bset	20494,#7
1306                     ; 250 	SDA(0);
1309  0010 721f500a      	bres	20490,#7
1310                     ; 251 	IIC_Delay();
1312  0014 cd0000        	call	_IIC_Delay
1314                     ; 252 	SCL(1);
1316  0017 721c500a      	bset	20490,#6
1317                     ; 253 	IIC_Delay();
1319  001b cd0000        	call	_IIC_Delay
1321                     ; 254 	SCL(0);
1323  001e 721d500a      	bres	20490,#6
1324                     ; 255 }
1327  0022 81            	ret
1351                     ; 263 void IIC_NAck(void)
1351                     ; 264 {
1352                     .text:	section	.text,new
1353  0000               _IIC_NAck:
1357                     ; 265 	SCL(0);
1359  0000 721d500a      	bres	20490,#6
1360                     ; 266 	SDA_OUT();
1362  0004 721e500c      	bset	20492,#7
1365  0008 721f500d      	bres	20493,#7
1368  000c 721e500e      	bset	20494,#7
1369                     ; 267 	SDA(1);
1372  0010 721e500a      	bset	20490,#7
1373                     ; 268 	IIC_Delay();
1375  0014 cd0000        	call	_IIC_Delay
1377                     ; 269 	SCL(1);
1379  0017 721c500a      	bset	20490,#6
1380                     ; 270 	IIC_Delay();
1382  001b cd0000        	call	_IIC_Delay
1384                     ; 271   SCL(0);
1386  001e 721d500a      	bres	20490,#6
1387                     ; 272 }
1390  0022 81            	ret
1430                     ; 280 void IIC_Send_Byte(u8 txd)
1430                     ; 281 {                        
1431                     .text:	section	.text,new
1432  0000               _IIC_Send_Byte:
1434  0000 88            	push	a
1435  0001 88            	push	a
1436       00000001      OFST:	set	1
1439                     ; 283 	SDA_OUT(); 	    
1441  0002 721e500c      	bset	20492,#7
1444  0006 721f500d      	bres	20493,#7
1447  000a 721e500e      	bset	20494,#7
1448                     ; 284 	SCL(0);//拉低时钟开始数据传输
1451  000e 721d500a      	bres	20490,#6
1452                     ; 285 	for(i=0;i<8;i++)
1454  0012 0f01          	clr	(OFST+0,sp)
1455  0014               L723:
1456                     ; 287 		if ((txd & 0x80)>>7)
1458  0014 7b02          	ld	a,(OFST+1,sp)
1459  0016 a480          	and	a,#128
1460  0018 49            	rlc	a
1461  0019 4f            	clr	a
1462  001a 49            	rlc	a
1463  001b 2706          	jreq	L533
1464                     ; 288 			SDA(1);
1466  001d 721e500a      	bset	20490,#7
1468  0021 2004          	jra	L733
1469  0023               L533:
1470                     ; 290 			SDA(0);
1472  0023 721f500a      	bres	20490,#7
1473  0027               L733:
1474                     ; 291 		txd<<=1; 	  
1476  0027 0802          	sll	(OFST+1,sp)
1477                     ; 292 		SCL(1);
1479  0029 721c500a      	bset	20490,#6
1480                     ; 294   delay_ms(1);
1482  002d a601          	ld	a,#1
1483  002f cd0000        	call	_delay_ms
1485                     ; 295 		SCL(0);	
1487  0032 721d500a      	bres	20490,#6
1488                     ; 297   delay_ms(1);
1490  0036 a601          	ld	a,#1
1491  0038 cd0000        	call	_delay_ms
1493                     ; 285 	for(i=0;i<8;i++)
1495  003b 0c01          	inc	(OFST+0,sp)
1498  003d 7b01          	ld	a,(OFST+0,sp)
1499  003f a108          	cp	a,#8
1500  0041 25d1          	jrult	L723
1501                     ; 299 }
1504  0043 85            	popw	x
1505  0044 81            	ret
1554                     ; 308 u8 IIC_Read_Byte(u8 ack)
1554                     ; 309 {
1555                     .text:	section	.text,new
1556  0000               _IIC_Read_Byte:
1558  0000 88            	push	a
1559  0001 89            	pushw	x
1560       00000002      OFST:	set	2
1563                     ; 310 	u8 i,receive=0;
1565  0002 0f02          	clr	(OFST+0,sp)
1566                     ; 311 	SDA_IN();//SDA设置为输入
1568  0004 721f500c      	bres	20492,#7
1571  0008 721e500d      	bset	20493,#7
1574  000c 721f500e      	bres	20494,#7
1575                     ; 312 	for(i=0;i<8;i++ )
1578  0010 0f01          	clr	(OFST-1,sp)
1579  0012               L163:
1580                     ; 314 		SCL(0);
1582  0012 721d500a      	bres	20490,#6
1583                     ; 315 		IIC_Delay();
1585  0016 cd0000        	call	_IIC_Delay
1587                     ; 316 		SCL(1);
1589  0019 721c500a      	bset	20490,#6
1590                     ; 317 		receive<<=1;
1592  001d 0802          	sll	(OFST+0,sp)
1593                     ; 318 		if(READ_SDA)
1595  001f c6500b        	ld	a,20491
1596  0022 a580          	bcp	a,#128
1597  0024 2702          	jreq	L763
1598                     ; 319 			receive++;   
1600  0026 0c02          	inc	(OFST+0,sp)
1601  0028               L763:
1602                     ; 320 		IIC_Delay(); 
1604  0028 cd0000        	call	_IIC_Delay
1606                     ; 312 	for(i=0;i<8;i++ )
1608  002b 0c01          	inc	(OFST-1,sp)
1611  002d 7b01          	ld	a,(OFST-1,sp)
1612  002f a108          	cp	a,#8
1613  0031 25df          	jrult	L163
1614                     ; 322 	if (!ack)
1616  0033 0d03          	tnz	(OFST+1,sp)
1617  0035 2605          	jrne	L173
1618                     ; 323 			IIC_NAck();//发送nACK
1620  0037 cd0000        	call	_IIC_NAck
1623  003a 2003          	jra	L373
1624  003c               L173:
1625                     ; 325 			IIC_Ack(); //发送ACK   
1627  003c cd0000        	call	_IIC_Ack
1629  003f               L373:
1630                     ; 326 	return receive;
1632  003f 7b02          	ld	a,(OFST+0,sp)
1635  0041 5b03          	addw	sp,#3
1636  0043 81            	ret
1660                     ; 334 void Wire_begin_(void)
1660                     ; 335 {
1661                     .text:	section	.text,new
1662  0000               _Wire_begin_:
1666                     ; 336 	IIC_Init();
1668  0000 cd0000        	call	_IIC_Init
1670                     ; 337 }
1673  0003 81            	ret
1705                     ; 344 int abs(int x)
1705                     ; 345 {
1706                     .text:	section	.text,new
1707  0000               _abs:
1709  0000 89            	pushw	x
1710       00000000      OFST:	set	0
1713                     ; 346 	if (x < 0)
1715  0001 9c            	rvf
1716  0002 a30000        	cpw	x,#0
1717  0005 2e05          	jrsge	L124
1718                     ; 347 		x = -x;
1720  0007 1e01          	ldw	x,(OFST+1,sp)
1721  0009 50            	negw	x
1722  000a 1f01          	ldw	(OFST+1,sp),x
1723  000c               L124:
1724                     ; 348 	return x;
1726  000c 1e01          	ldw	x,(OFST+1,sp)
1729  000e 5b02          	addw	sp,#2
1730  0010 81            	ret
1761                     ; 356 void SparkFun_APDS9960(void)
1761                     ; 357 {
1762                     .text:	section	.text,new
1763  0000               _SparkFun_APDS9960:
1767                     ; 358     gesture_ud_delta_ = 0;
1769  0000 5f            	clrw	x
1770  0001 cf000e        	ldw	_gesture_ud_delta_,x
1771                     ; 359     gesture_lr_delta_ = 0;
1773  0004 5f            	clrw	x
1774  0005 cf000c        	ldw	_gesture_lr_delta_,x
1775                     ; 361     gesture_ud_count_ = 0;
1777  0008 5f            	clrw	x
1778  0009 cf000a        	ldw	_gesture_ud_count_,x
1779                     ; 362     gesture_lr_count_ = 0;
1781  000c 5f            	clrw	x
1782  000d cf0008        	ldw	_gesture_lr_count_,x
1783                     ; 364     gesture_near_count_ = 0;
1785  0010 5f            	clrw	x
1786  0011 cf0006        	ldw	_gesture_near_count_,x
1787                     ; 365     gesture_far_count_ = 0;
1789  0014 5f            	clrw	x
1790  0015 cf0004        	ldw	_gesture_far_count_,x
1791                     ; 367     gesture_state_ = 0;
1793  0018 5f            	clrw	x
1794  0019 cf0002        	ldw	_gesture_state_,x
1795                     ; 368     gesture_motion_ = DIR_NONE;
1797  001c 5f            	clrw	x
1798  001d cf0000        	ldw	_gesture_motion_,x
1799                     ; 369 }
1802  0020 81            	ret
1876                     ; 377 bool SparkFun_APDS9960_init(void)
1876                     ; 378 {
1877                     .text:	section	.text,new
1878  0000               _SparkFun_APDS9960_init:
1880  0000 5203          	subw	sp,#3
1881       00000003      OFST:	set	3
1884                     ; 382     Wire_begin_();
1886  0002 cd0000        	call	_Wire_begin_
1888                     ; 385     if( !wireReadDataByte(APDS9960_ID, pid) ) 
1890  0005 1e01          	ldw	x,(OFST-2,sp)
1891  0007 89            	pushw	x
1892  0008 a692          	ld	a,#146
1893  000a cd0000        	call	_wireReadDataByte
1895  000d 85            	popw	x
1896  000e 4d            	tnz	a
1897  000f 2603          	jrne	L364
1898                     ; 387 		    return FALSE;
1900  0011 4f            	clr	a
1902  0012 2012          	jra	L05
1903  0014               L364:
1904                     ; 390 		id=*pid;
1906  0014 1e01          	ldw	x,(OFST-2,sp)
1907  0016 f6            	ld	a,(x)
1908  0017 6b03          	ld	(OFST+0,sp),a
1909                     ; 392     if( !((id == APDS9960_ID_1 || id == APDS9960_ID_2)) ) 
1911  0019 7b03          	ld	a,(OFST+0,sp)
1912  001b a1ab          	cp	a,#171
1913  001d 270a          	jreq	L564
1915  001f 7b03          	ld	a,(OFST+0,sp)
1916  0021 a19c          	cp	a,#156
1917  0023 2704          	jreq	L564
1918                     ; 394         return FALSE;
1920  0025 4f            	clr	a
1922  0026               L05:
1924  0026 5b03          	addw	sp,#3
1925  0028 81            	ret
1926  0029               L564:
1927                     ; 399     if( !setMode(ALL, OFF) ) 
1929  0029 5f            	clrw	x
1930  002a a607          	ld	a,#7
1931  002c 95            	ld	xh,a
1932  002d cd0000        	call	_setMode
1934  0030 4d            	tnz	a
1935  0031 2603          	jrne	L764
1936                     ; 401         return FALSE;
1938  0033 4f            	clr	a
1940  0034 20f0          	jra	L05
1941  0036               L764:
1942                     ; 406     if( !setGestureEnterThresh(DEFAULT_GPENTH) ) {
1944  0036 a628          	ld	a,#40
1945  0038 cd0000        	call	_setGestureEnterThresh
1947  003b 4d            	tnz	a
1948  003c 2603          	jrne	L174
1949                     ; 407         return FALSE;
1951  003e 4f            	clr	a
1953  003f 20e5          	jra	L05
1954  0041               L174:
1955                     ; 409     if( !setGestureExitThresh(DEFAULT_GEXTH) ) {
1957  0041 a61e          	ld	a,#30
1958  0043 cd0000        	call	_setGestureExitThresh
1960  0046 4d            	tnz	a
1961  0047 2603          	jrne	L374
1962                     ; 410         return FALSE;
1964  0049 4f            	clr	a
1966  004a 20da          	jra	L05
1967  004c               L374:
1968                     ; 412     if( !wireWriteDataByte(APDS9960_GCONF1, DEFAULT_GCONF1) ) {
1970  004c ae0040        	ldw	x,#64
1971  004f a6a2          	ld	a,#162
1972  0051 95            	ld	xh,a
1973  0052 cd0000        	call	_wireWriteDataByte
1975  0055 4d            	tnz	a
1976  0056 2603          	jrne	L574
1977                     ; 413         return FALSE;
1979  0058 4f            	clr	a
1981  0059 20cb          	jra	L05
1982  005b               L574:
1983                     ; 415     if( !setGestureGain(DEFAULT_GGAIN) ) {
1985  005b a602          	ld	a,#2
1986  005d cd0000        	call	_setGestureGain
1988  0060 4d            	tnz	a
1989  0061 2603          	jrne	L774
1990                     ; 416         return FALSE;
1992  0063 4f            	clr	a
1994  0064 20c0          	jra	L05
1995  0066               L774:
1996                     ; 418     if( !setGestureLEDDrive(DEFAULT_GLDRIVE) ) {
1998  0066 4f            	clr	a
1999  0067 cd0000        	call	_setGestureLEDDrive
2001  006a 4d            	tnz	a
2002  006b 2603          	jrne	L105
2003                     ; 419         return FALSE;
2005  006d 4f            	clr	a
2007  006e 20b6          	jra	L05
2008  0070               L105:
2009                     ; 421     if( !setGestureWaitTime(DEFAULT_GWTIME) ) {
2011  0070 a601          	ld	a,#1
2012  0072 cd0000        	call	_setGestureWaitTime
2014  0075 4d            	tnz	a
2015  0076 2603          	jrne	L305
2016                     ; 422         return FALSE;
2018  0078 4f            	clr	a
2020  0079 20ab          	jra	L05
2021  007b               L305:
2022                     ; 424     if( !wireWriteDataByte(APDS9960_GOFFSET_U, DEFAULT_GOFFSET) ) {
2024  007b 5f            	clrw	x
2025  007c a6a4          	ld	a,#164
2026  007e 95            	ld	xh,a
2027  007f cd0000        	call	_wireWriteDataByte
2029  0082 4d            	tnz	a
2030  0083 2603          	jrne	L505
2031                     ; 425         return FALSE;
2033  0085 4f            	clr	a
2035  0086 209e          	jra	L05
2036  0088               L505:
2037                     ; 427     if( !wireWriteDataByte(APDS9960_GOFFSET_D, DEFAULT_GOFFSET) ) {
2039  0088 5f            	clrw	x
2040  0089 a6a5          	ld	a,#165
2041  008b 95            	ld	xh,a
2042  008c cd0000        	call	_wireWriteDataByte
2044  008f 4d            	tnz	a
2045  0090 2603          	jrne	L705
2046                     ; 428         return FALSE;
2048  0092 4f            	clr	a
2050  0093 2091          	jra	L05
2051  0095               L705:
2052                     ; 430     if( !wireWriteDataByte(APDS9960_GOFFSET_L, DEFAULT_GOFFSET) ) {
2054  0095 5f            	clrw	x
2055  0096 a6a7          	ld	a,#167
2056  0098 95            	ld	xh,a
2057  0099 cd0000        	call	_wireWriteDataByte
2059  009c 4d            	tnz	a
2060  009d 2603          	jrne	L115
2061                     ; 431         return FALSE;
2063  009f 4f            	clr	a
2065  00a0 2084          	jra	L05
2066  00a2               L115:
2067                     ; 433     if( !wireWriteDataByte(APDS9960_GOFFSET_R, DEFAULT_GOFFSET) ) {
2069  00a2 5f            	clrw	x
2070  00a3 a6a9          	ld	a,#169
2071  00a5 95            	ld	xh,a
2072  00a6 cd0000        	call	_wireWriteDataByte
2074  00a9 4d            	tnz	a
2075  00aa 2605          	jrne	L315
2076                     ; 434         return FALSE;
2078  00ac 4f            	clr	a
2080  00ad ac260026      	jpf	L05
2081  00b1               L315:
2082                     ; 436     if( !wireWriteDataByte(APDS9960_GPULSE, DEFAULT_GPULSE) ) {
2084  00b1 ae00c9        	ldw	x,#201
2085  00b4 a6a6          	ld	a,#166
2086  00b6 95            	ld	xh,a
2087  00b7 cd0000        	call	_wireWriteDataByte
2089  00ba 4d            	tnz	a
2090  00bb 2605          	jrne	L515
2091                     ; 437         return FALSE;
2093  00bd 4f            	clr	a
2095  00be ac260026      	jpf	L05
2096  00c2               L515:
2097                     ; 439     if( !wireWriteDataByte(APDS9960_GCONF3, DEFAULT_GCONF3) ) {
2099  00c2 5f            	clrw	x
2100  00c3 a6aa          	ld	a,#170
2101  00c5 95            	ld	xh,a
2102  00c6 cd0000        	call	_wireWriteDataByte
2104  00c9 4d            	tnz	a
2105  00ca 2605          	jrne	L715
2106                     ; 440         return FALSE;
2108  00cc 4f            	clr	a
2110  00cd ac260026      	jpf	L05
2111  00d1               L715:
2112                     ; 442     if( !setGestureIntEnable(DEFAULT_GIEN) ) {
2114  00d1 4f            	clr	a
2115  00d2 cd0000        	call	_setGestureIntEnable
2117  00d5 4d            	tnz	a
2118  00d6 2605          	jrne	L125
2119                     ; 443         return FALSE;
2121  00d8 4f            	clr	a
2123  00d9 ac260026      	jpf	L05
2124  00dd               L125:
2125                     ; 445 		return TRUE;		
2127  00dd a601          	ld	a,#1
2129  00df ac260026      	jpf	L05
2162                     ; 453 u8 getMode(void)
2162                     ; 454 {
2163                     .text:	section	.text,new
2164  0000               _getMode:
2166  0000 88            	push	a
2167       00000001      OFST:	set	1
2170                     ; 458     if( !wireReadDataByte(APDS9960_ENABLE, &enable_value) ) {
2172  0001 96            	ldw	x,sp
2173  0002 1c0001        	addw	x,#OFST+0
2174  0005 89            	pushw	x
2175  0006 a680          	ld	a,#128
2176  0008 cd0000        	call	_wireReadDataByte
2178  000b 85            	popw	x
2179  000c 4d            	tnz	a
2180  000d 2605          	jrne	L735
2181                     ; 459         return ERROR;
2183  000f a6ff          	ld	a,#255
2186  0011 5b01          	addw	sp,#1
2187  0013 81            	ret
2188  0014               L735:
2189                     ; 462     return enable_value;
2191  0014 7b01          	ld	a,(OFST+0,sp)
2194  0016 5b01          	addw	sp,#1
2195  0018 81            	ret
2244                     ; 471 bool setMode(s8 mode, u8 enable)
2244                     ; 472 {
2245                     .text:	section	.text,new
2246  0000               _setMode:
2248  0000 89            	pushw	x
2249  0001 88            	push	a
2250       00000001      OFST:	set	1
2253                     ; 476     reg_val = getMode();
2255  0002 cd0000        	call	_getMode
2257  0005 6b01          	ld	(OFST+0,sp),a
2258                     ; 477     if( reg_val == ERROR ) {
2260  0007 7b01          	ld	a,(OFST+0,sp)
2261  0009 a1ff          	cp	a,#255
2262  000b 2603          	jrne	L165
2263                     ; 478         return FALSE;
2265  000d 4f            	clr	a
2267  000e 2064          	jra	L27
2268  0010               L165:
2269                     ; 482     enable = enable & 0x01;
2271  0010 7b03          	ld	a,(OFST+2,sp)
2272  0012 a401          	and	a,#1
2273  0014 6b03          	ld	(OFST+2,sp),a
2274                     ; 483     if( (mode >= 0) && (mode <= 6) ) {
2276  0016 9c            	rvf
2277  0017 0d02          	tnz	(OFST+1,sp)
2278  0019 2f3a          	jrslt	L365
2280  001b 9c            	rvf
2281  001c 7b02          	ld	a,(OFST+1,sp)
2282  001e a107          	cp	a,#7
2283  0020 2e33          	jrsge	L365
2284                     ; 484         if (enable) {
2286  0022 0d03          	tnz	(OFST+2,sp)
2287  0024 2717          	jreq	L565
2288                     ; 485             reg_val |= (1 << mode);
2290  0026 7b02          	ld	a,(OFST+1,sp)
2291  0028 5f            	clrw	x
2292  0029 4d            	tnz	a
2293  002a 2a01          	jrpl	L65
2294  002c 53            	cplw	x
2295  002d               L65:
2296  002d 97            	ld	xl,a
2297  002e a601          	ld	a,#1
2298  0030 5d            	tnzw	x
2299  0031 2704          	jreq	L06
2300  0033               L26:
2301  0033 48            	sll	a
2302  0034 5a            	decw	x
2303  0035 26fc          	jrne	L26
2304  0037               L06:
2305  0037 1a01          	or	a,(OFST+0,sp)
2306  0039 6b01          	ld	(OFST+0,sp),a
2308  003b 202a          	jra	L175
2309  003d               L565:
2310                     ; 487             reg_val &= ~(1 << mode);
2312  003d 7b02          	ld	a,(OFST+1,sp)
2313  003f 5f            	clrw	x
2314  0040 4d            	tnz	a
2315  0041 2a01          	jrpl	L46
2316  0043 53            	cplw	x
2317  0044               L46:
2318  0044 97            	ld	xl,a
2319  0045 a601          	ld	a,#1
2320  0047 5d            	tnzw	x
2321  0048 2704          	jreq	L66
2322  004a               L07:
2323  004a 48            	sll	a
2324  004b 5a            	decw	x
2325  004c 26fc          	jrne	L07
2326  004e               L66:
2327  004e 43            	cpl	a
2328  004f 1401          	and	a,(OFST+0,sp)
2329  0051 6b01          	ld	(OFST+0,sp),a
2330  0053 2012          	jra	L175
2331  0055               L365:
2332                     ; 489     } else if( mode == ALL ) {
2334  0055 7b02          	ld	a,(OFST+1,sp)
2335  0057 a107          	cp	a,#7
2336  0059 260c          	jrne	L175
2337                     ; 490         if (enable) {
2339  005b 0d03          	tnz	(OFST+2,sp)
2340  005d 2706          	jreq	L575
2341                     ; 491             reg_val = 0x7F;
2343  005f a67f          	ld	a,#127
2344  0061 6b01          	ld	(OFST+0,sp),a
2346  0063 2002          	jra	L175
2347  0065               L575:
2348                     ; 493             reg_val = 0x00;
2350  0065 0f01          	clr	(OFST+0,sp)
2351  0067               L175:
2352                     ; 498     if( !wireWriteDataByte(APDS9960_ENABLE, reg_val) ) {
2354  0067 7b01          	ld	a,(OFST+0,sp)
2355  0069 97            	ld	xl,a
2356  006a a680          	ld	a,#128
2357  006c 95            	ld	xh,a
2358  006d cd0000        	call	_wireWriteDataByte
2360  0070 4d            	tnz	a
2361  0071 2604          	jrne	L106
2362                     ; 499         return FALSE;
2364  0073 4f            	clr	a
2366  0074               L27:
2368  0074 5b03          	addw	sp,#3
2369  0076 81            	ret
2370  0077               L106:
2371                     ; 502     return TRUE;
2373  0077 a601          	ld	a,#1
2375  0079 20f9          	jra	L27
2419                     ; 511 bool enableGestureSensor(bool interrupts)
2419                     ; 512 {
2420                     .text:	section	.text,new
2421  0000               _enableGestureSensor:
2423  0000 88            	push	a
2424       00000000      OFST:	set	0
2427                     ; 522     resetGestureParameters();
2429  0001 cd0000        	call	_resetGestureParameters
2431                     ; 523     if( !wireWriteDataByte(APDS9960_WTIME, 0xFF) ) {
2433  0004 ae00ff        	ldw	x,#255
2434  0007 a683          	ld	a,#131
2435  0009 95            	ld	xh,a
2436  000a cd0000        	call	_wireWriteDataByte
2438  000d 4d            	tnz	a
2439  000e 2604          	jrne	L126
2440                     ; 524         return FALSE;
2442  0010 4f            	clr	a
2445  0011 5b01          	addw	sp,#1
2446  0013 81            	ret
2447  0014               L126:
2448                     ; 526     if( !wireWriteDataByte(APDS9960_PPULSE, DEFAULT_GESTURE_PPULSE) ) {
2450  0014 ae0089        	ldw	x,#137
2451  0017 a68e          	ld	a,#142
2452  0019 95            	ld	xh,a
2453  001a cd0000        	call	_wireWriteDataByte
2455  001d 4d            	tnz	a
2456  001e 2604          	jrne	L326
2457                     ; 527         return FALSE;
2459  0020 4f            	clr	a
2462  0021 5b01          	addw	sp,#1
2463  0023 81            	ret
2464  0024               L326:
2465                     ; 529     if( !setLEDBoost(LED_BOOST_300) ) {
2467  0024 a603          	ld	a,#3
2468  0026 cd0000        	call	_setLEDBoost
2470  0029 4d            	tnz	a
2471  002a 2604          	jrne	L526
2472                     ; 530         return FALSE;
2474  002c 4f            	clr	a
2477  002d 5b01          	addw	sp,#1
2478  002f 81            	ret
2479  0030               L526:
2480                     ; 532     if( interrupts ) {
2482  0030 0d01          	tnz	(OFST+1,sp)
2483  0032 270c          	jreq	L726
2484                     ; 533         if( !setGestureIntEnable(1) ) {
2486  0034 a601          	ld	a,#1
2487  0036 cd0000        	call	_setGestureIntEnable
2489  0039 4d            	tnz	a
2490  003a 260f          	jrne	L336
2491                     ; 534             return FALSE;
2493  003c 4f            	clr	a
2496  003d 5b01          	addw	sp,#1
2497  003f 81            	ret
2498  0040               L726:
2499                     ; 537         if( !setGestureIntEnable(0) ) {
2501  0040 4f            	clr	a
2502  0041 cd0000        	call	_setGestureIntEnable
2504  0044 4d            	tnz	a
2505  0045 2604          	jrne	L336
2506                     ; 538             return FALSE;
2508  0047 4f            	clr	a
2511  0048 5b01          	addw	sp,#1
2512  004a 81            	ret
2513  004b               L336:
2514                     ; 541     if( !setGestureMode(1) ) {
2516  004b a601          	ld	a,#1
2517  004d cd0000        	call	_setGestureMode
2519  0050 4d            	tnz	a
2520  0051 2604          	jrne	L736
2521                     ; 542         return FALSE;
2523  0053 4f            	clr	a
2526  0054 5b01          	addw	sp,#1
2527  0056 81            	ret
2528  0057               L736:
2529                     ; 544     if( !enablePower() ){
2531  0057 cd0000        	call	_enablePower
2533  005a 4d            	tnz	a
2534  005b 2604          	jrne	L146
2535                     ; 545         return FALSE;
2537  005d 4f            	clr	a
2540  005e 5b01          	addw	sp,#1
2541  0060 81            	ret
2542  0061               L146:
2543                     ; 547     if( !setMode(WAIT, 1) ) {
2545  0061 ae0001        	ldw	x,#1
2546  0064 a603          	ld	a,#3
2547  0066 95            	ld	xh,a
2548  0067 cd0000        	call	_setMode
2550  006a 4d            	tnz	a
2551  006b 2604          	jrne	L346
2552                     ; 548         return FALSE;
2554  006d 4f            	clr	a
2557  006e 5b01          	addw	sp,#1
2558  0070 81            	ret
2559  0071               L346:
2560                     ; 550     if( !setMode(PROXIMITY, 1) ) {
2562  0071 ae0001        	ldw	x,#1
2563  0074 a602          	ld	a,#2
2564  0076 95            	ld	xh,a
2565  0077 cd0000        	call	_setMode
2567  007a 4d            	tnz	a
2568  007b 2604          	jrne	L546
2569                     ; 551         return FALSE;
2571  007d 4f            	clr	a
2574  007e 5b01          	addw	sp,#1
2575  0080 81            	ret
2576  0081               L546:
2577                     ; 553     if( !setMode(GESTURE, 1) ) {
2579  0081 ae0001        	ldw	x,#1
2580  0084 a606          	ld	a,#6
2581  0086 95            	ld	xh,a
2582  0087 cd0000        	call	_setMode
2584  008a 4d            	tnz	a
2585  008b 2604          	jrne	L746
2586                     ; 554         return FALSE;
2588  008d 4f            	clr	a
2591  008e 5b01          	addw	sp,#1
2592  0090 81            	ret
2593  0091               L746:
2594                     ; 557     return TRUE;
2596  0091 a601          	ld	a,#1
2599  0093 5b01          	addw	sp,#1
2600  0095 81            	ret
2634                     ; 566 bool isGestureAvailable(void)
2634                     ; 567 {
2635                     .text:	section	.text,new
2636  0000               _isGestureAvailable:
2638  0000 88            	push	a
2639       00000001      OFST:	set	1
2642                     ; 571     if( !wireReadDataByte(APDS9960_GSTATUS, &val) ) 
2644  0001 96            	ldw	x,sp
2645  0002 1c0001        	addw	x,#OFST+0
2646  0005 89            	pushw	x
2647  0006 a6af          	ld	a,#175
2648  0008 cd0000        	call	_wireReadDataByte
2650  000b 85            	popw	x
2651  000c 4d            	tnz	a
2652  000d 2605          	jrne	L566
2653                     ; 573         return ERROR;
2655  000f a6ff          	ld	a,#255
2658  0011 5b01          	addw	sp,#1
2659  0013 81            	ret
2660  0014               L566:
2661                     ; 577     val&=APDS9960_GVALID;
2663  0014 7b01          	ld	a,(OFST+0,sp)
2664  0016 a401          	and	a,#1
2665  0018 6b01          	ld	(OFST+0,sp),a
2666                     ; 580     if( val == 1) 
2668  001a 7b01          	ld	a,(OFST+0,sp)
2669  001c a101          	cp	a,#1
2670  001e 2605          	jrne	L766
2671                     ; 582         return TRUE;
2673  0020 a601          	ld	a,#1
2676  0022 5b01          	addw	sp,#1
2677  0024 81            	ret
2678  0025               L766:
2679                     ; 586         return FALSE;
2681  0025 4f            	clr	a
2684  0026 5b01          	addw	sp,#1
2685  0028 81            	ret
2765                     ; 595 int readGesture(void)
2765                     ; 596 {
2766                     .text:	section	.text,new
2767  0000               _readGesture:
2769  0000 5287          	subw	sp,#135
2770       00000087      OFST:	set	135
2773                     ; 597     u8 fifo_level = 0;
2775  0002 0f04          	clr	(OFST-131,sp)
2776                     ; 598     s8  bytes_read = 0;
2778  0004 7b05          	ld	a,(OFST-130,sp)
2779  0006 97            	ld	xl,a
2780                     ; 605     if(!isGestureAvailable()||!(getMode()&01000001) ) {
2782  0007 cd0000        	call	_isGestureAvailable
2784  000a 4d            	tnz	a
2785  000b 2707          	jreq	L527
2787  000d cd0000        	call	_getMode
2789  0010 a501          	bcp	a,#1
2790  0012 2603          	jrne	L727
2791  0014               L527:
2792                     ; 606         return DIR_NONE;
2794  0014 5f            	clrw	x
2796  0015 2016          	jra	L401
2797  0017               L727:
2798                     ; 613         delay_ms(FIFO_PAUSE_TIME);
2800  0017 a61e          	ld	a,#30
2801  0019 cd0000        	call	_delay_ms
2803                     ; 616         if( !wireReadDataByte(APDS9960_GSTATUS, &gstatus) ) {
2805  001c 96            	ldw	x,sp
2806  001d 1c0003        	addw	x,#OFST-132
2807  0020 89            	pushw	x
2808  0021 a6af          	ld	a,#175
2809  0023 cd0000        	call	_wireReadDataByte
2811  0026 85            	popw	x
2812  0027 4d            	tnz	a
2813  0028 2606          	jrne	L337
2814                     ; 617             return ERROR;
2816  002a ae00ff        	ldw	x,#255
2818  002d               L401:
2820  002d 5b87          	addw	sp,#135
2821  002f 81            	ret
2822  0030               L337:
2823                     ; 621         if((gstatus & APDS9960_GVALID)==APDS9960_GVALID) 
2825  0030 7b03          	ld	a,(OFST-132,sp)
2826  0032 a401          	and	a,#1
2827  0034 a101          	cp	a,#1
2828  0036 2703          	jreq	L601
2829  0038 cc0112        	jp	L537
2830  003b               L601:
2831                     ; 625             if( !wireReadDataByte(APDS9960_GFLVL, &fifo_level) ) 
2833  003b 96            	ldw	x,sp
2834  003c 1c0004        	addw	x,#OFST-131
2835  003f 89            	pushw	x
2836  0040 a6ae          	ld	a,#174
2837  0042 cd0000        	call	_wireReadDataByte
2839  0045 85            	popw	x
2840  0046 4d            	tnz	a
2841  0047 2605          	jrne	L737
2842                     ; 627                 return ERROR;
2844  0049 ae00ff        	ldw	x,#255
2846  004c 20df          	jra	L401
2847  004e               L737:
2848                     ; 632             if( fifo_level > 0) {
2850  004e 0d04          	tnz	(OFST-131,sp)
2851  0050 27c5          	jreq	L727
2852                     ; 633                 bytes_read = wireReadDataBlock(  APDS9960_GFIFO_U, 
2852                     ; 634                                                 (u8*)fifo_data, 
2852                     ; 635                                                 (fifo_level * 4) );
2854  0052 7b04          	ld	a,(OFST-131,sp)
2855  0054 97            	ld	xl,a
2856  0055 a604          	ld	a,#4
2857  0057 42            	mul	x,a
2858  0058 89            	pushw	x
2859  0059 96            	ldw	x,sp
2860  005a 1c0008        	addw	x,#OFST-127
2861  005d 89            	pushw	x
2862  005e a6fc          	ld	a,#252
2863  0060 cd0000        	call	_wireReadDataBlock
2865  0063 5b04          	addw	sp,#4
2866  0065 01            	rrwa	x,a
2867  0066 6b05          	ld	(OFST-130,sp),a
2868  0068 02            	rlwa	x,a
2869                     ; 636                 if(bytes_read==-1) {
2871  0069 7b05          	ld	a,(OFST-130,sp)
2872  006b a1ff          	cp	a,#255
2873  006d 2605          	jrne	L347
2874                     ; 637                     return ERROR;
2876  006f ae00ff        	ldw	x,#255
2878  0072 20b9          	jra	L401
2879  0074               L347:
2880                     ; 641                 if( bytes_read >= 4 ) {
2882  0074 9c            	rvf
2883  0075 7b05          	ld	a,(OFST-130,sp)
2884  0077 a104          	cp	a,#4
2885  0079 2f9c          	jrslt	L727
2886                     ; 642                     for( i = 0; i < bytes_read; i += 4 ) {
2888  007b 5f            	clrw	x
2889  007c 1f86          	ldw	(OFST-1,sp),x
2891  007e 206b          	jra	L357
2892  0080               L747:
2893                     ; 643                         gesture_data_.u_data[gesture_data_.index] = \
2893                     ; 644                                                             fifo_data[i + 0];
2895  0080 c60090        	ld	a,_gesture_data_+128
2896  0083 5f            	clrw	x
2897  0084 97            	ld	xl,a
2898  0085 9096          	ldw	y,sp
2899  0087 72a90006      	addw	y,#OFST-129
2900  008b 1701          	ldw	(OFST-134,sp),y
2901  008d 1686          	ldw	y,(OFST-1,sp)
2902  008f 72f901        	addw	y,(OFST-134,sp)
2903  0092 90f6          	ld	a,(y)
2904  0094 d70010        	ld	(_gesture_data_,x),a
2905                     ; 645                         gesture_data_.d_data[gesture_data_.index] = \
2905                     ; 646                                                             fifo_data[i + 1];
2907  0097 c60090        	ld	a,_gesture_data_+128
2908  009a 5f            	clrw	x
2909  009b 97            	ld	xl,a
2910  009c 9096          	ldw	y,sp
2911  009e 72a90007      	addw	y,#OFST-128
2912  00a2 1701          	ldw	(OFST-134,sp),y
2913  00a4 1686          	ldw	y,(OFST-1,sp)
2914  00a6 72f901        	addw	y,(OFST-134,sp)
2915  00a9 90f6          	ld	a,(y)
2916  00ab d70030        	ld	(_gesture_data_+32,x),a
2917                     ; 647                         gesture_data_.l_data[gesture_data_.index] = \
2917                     ; 648                                                             fifo_data[i + 2];
2919  00ae c60090        	ld	a,_gesture_data_+128
2920  00b1 5f            	clrw	x
2921  00b2 97            	ld	xl,a
2922  00b3 9096          	ldw	y,sp
2923  00b5 72a90008      	addw	y,#OFST-127
2924  00b9 1701          	ldw	(OFST-134,sp),y
2925  00bb 1686          	ldw	y,(OFST-1,sp)
2926  00bd 72f901        	addw	y,(OFST-134,sp)
2927  00c0 90f6          	ld	a,(y)
2928  00c2 d70050        	ld	(_gesture_data_+64,x),a
2929                     ; 649                         gesture_data_.r_data[gesture_data_.index] = \
2929                     ; 650                                                             fifo_data[i + 3];
2931  00c5 c60090        	ld	a,_gesture_data_+128
2932  00c8 5f            	clrw	x
2933  00c9 97            	ld	xl,a
2934  00ca 9096          	ldw	y,sp
2935  00cc 72a90009      	addw	y,#OFST-126
2936  00d0 1701          	ldw	(OFST-134,sp),y
2937  00d2 1686          	ldw	y,(OFST-1,sp)
2938  00d4 72f901        	addw	y,(OFST-134,sp)
2939  00d7 90f6          	ld	a,(y)
2940  00d9 d70070        	ld	(_gesture_data_+96,x),a
2941                     ; 651                         gesture_data_.index++;
2943  00dc 725c0090      	inc	_gesture_data_+128
2944                     ; 652                         gesture_data_.total_gestures++;
2946  00e0 725c0091      	inc	_gesture_data_+129
2947                     ; 642                     for( i = 0; i < bytes_read; i += 4 ) {
2949  00e4 1e86          	ldw	x,(OFST-1,sp)
2950  00e6 1c0004        	addw	x,#4
2951  00e9 1f86          	ldw	(OFST-1,sp),x
2952  00eb               L357:
2955  00eb 9c            	rvf
2956  00ec 7b05          	ld	a,(OFST-130,sp)
2957  00ee 5f            	clrw	x
2958  00ef 4d            	tnz	a
2959  00f0 2a01          	jrpl	L201
2960  00f2 53            	cplw	x
2961  00f3               L201:
2962  00f3 97            	ld	xl,a
2963  00f4 bf00          	ldw	c_x,x
2964  00f6 1e86          	ldw	x,(OFST-1,sp)
2965  00f8 b300          	cpw	x,c_x
2966  00fa 2f84          	jrslt	L747
2967                     ; 657                     if( processGestureData() ) {
2969  00fc cd0000        	call	_processGestureData
2971  00ff 4d            	tnz	a
2972  0100 2704          	jreq	L757
2973                     ; 658                         if( decodeGesture() ) {
2975  0102 cd0000        	call	_decodeGesture
2977  0105 4d            	tnz	a
2978  0106               L757:
2979                     ; 664                     gesture_data_.index = 0;
2981  0106 725f0090      	clr	_gesture_data_+128
2982                     ; 665                     gesture_data_.total_gestures = 0;
2984  010a 725f0091      	clr	_gesture_data_+129
2985  010e ac170017      	jpf	L727
2986  0112               L537:
2987                     ; 673             delay_ms(FIFO_PAUSE_TIME);
2989  0112 a61e          	ld	a,#30
2990  0114 cd0000        	call	_delay_ms
2992                     ; 674             decodeGesture();
2994  0117 cd0000        	call	_decodeGesture
2996                     ; 675             motion = gesture_motion_;
2998  011a ce0000        	ldw	x,_gesture_motion_
2999  011d 1f86          	ldw	(OFST-1,sp),x
3000                     ; 676             resetGestureParameters();
3002  011f cd0000        	call	_resetGestureParameters
3004                     ; 677             return motion;
3006  0122 1e86          	ldw	x,(OFST-1,sp)
3008  0124 ac2d002d      	jpf	L401
3033                     ; 688 bool enablePower(void)
3033                     ; 689 {
3034                     .text:	section	.text,new
3035  0000               _enablePower:
3039                     ; 690 	if( !setMode(POWER, 1) ) 
3041  0000 ae0001        	ldw	x,#1
3042  0003 4f            	clr	a
3043  0004 95            	ld	xh,a
3044  0005 cd0000        	call	_setMode
3046  0008 4d            	tnz	a
3047  0009 2602          	jrne	L577
3048                     ; 692 		return FALSE;
3050  000b 4f            	clr	a
3053  000c 81            	ret
3054  000d               L577:
3055                     ; 695 	return TRUE;
3057  000d a601          	ld	a,#1
3060  000f 81            	ret
3085                     ; 703 bool disablePower(void)
3085                     ; 704 {
3086                     .text:	section	.text,new
3087  0000               _disablePower:
3091                     ; 705 	if( !setMode(POWER, 0) )
3093  0000 5f            	clrw	x
3094  0001 4f            	clr	a
3095  0002 95            	ld	xh,a
3096  0003 cd0000        	call	_setMode
3098  0006 4d            	tnz	a
3099  0007 2602          	jrne	L7001
3100                     ; 707 			return FALSE;
3102  0009 4f            	clr	a
3105  000a 81            	ret
3106  000b               L7001:
3107                     ; 710 	return TRUE;
3109  000b a601          	ld	a,#1
3112  000d 81            	ret
3145                     ; 718 void resetGestureParameters(void)
3145                     ; 719 {
3146                     .text:	section	.text,new
3147  0000               _resetGestureParameters:
3151                     ; 720     gesture_data_.index = 0;
3153  0000 725f0090      	clr	_gesture_data_+128
3154                     ; 721     gesture_data_.total_gestures = 0;
3156  0004 725f0091      	clr	_gesture_data_+129
3157                     ; 723     gesture_ud_delta_ = 0;
3159  0008 5f            	clrw	x
3160  0009 cf000e        	ldw	_gesture_ud_delta_,x
3161                     ; 724     gesture_lr_delta_ = 0;
3163  000c 5f            	clrw	x
3164  000d cf000c        	ldw	_gesture_lr_delta_,x
3165                     ; 726     gesture_ud_count_ = 0;
3167  0010 5f            	clrw	x
3168  0011 cf000a        	ldw	_gesture_ud_count_,x
3169                     ; 727     gesture_lr_count_ = 0;
3171  0014 5f            	clrw	x
3172  0015 cf0008        	ldw	_gesture_lr_count_,x
3173                     ; 729     gesture_near_count_ = 0;
3175  0018 5f            	clrw	x
3176  0019 cf0006        	ldw	_gesture_near_count_,x
3177                     ; 730     gesture_far_count_ = 0;
3179  001c 5f            	clrw	x
3180  001d cf0004        	ldw	_gesture_far_count_,x
3181                     ; 732     gesture_state_ = 0;
3183  0020 5f            	clrw	x
3184  0021 cf0002        	ldw	_gesture_state_,x
3185                     ; 733     gesture_motion_ = DIR_NONE;
3187  0024 5f            	clrw	x
3188  0025 cf0000        	ldw	_gesture_motion_,x
3189                     ; 734 }
3192  0028 81            	ret
3332                     ; 741 bool processGestureData(void)
3332                     ; 742 {
3333                     .text:	section	.text,new
3334  0000               _processGestureData:
3336  0000 5210          	subw	sp,#16
3337       00000010      OFST:	set	16
3340                     ; 743     u8 u_first = 0;
3342  0002 0f09          	clr	(OFST-7,sp)
3343                     ; 744     u8 d_first = 0;
3345  0004 0f0a          	clr	(OFST-6,sp)
3346                     ; 745     u8 l_first = 0;
3348  0006 0f0b          	clr	(OFST-5,sp)
3349                     ; 746     u8 r_first = 0;
3351  0008 0f0c          	clr	(OFST-4,sp)
3352                     ; 747     u8 u_last = 0;
3354  000a 0f05          	clr	(OFST-11,sp)
3355                     ; 748     u8 d_last = 0;
3357  000c 0f06          	clr	(OFST-10,sp)
3358                     ; 749     u8 l_last = 0;
3360  000e 0f07          	clr	(OFST-9,sp)
3361                     ; 750     u8 r_last = 0;
3363  0010 0f08          	clr	(OFST-8,sp)
3364                     ; 760     if( gesture_data_.total_gestures <= 4 ) {
3366  0012 c60091        	ld	a,_gesture_data_+129
3367  0015 a105          	cp	a,#5
3368  0017 2404          	jruge	L1701
3369                     ; 761         return FALSE;
3371  0019 4f            	clr	a
3373  001a cc009f        	jra	L041
3374  001d               L1701:
3375                     ; 765     if( (gesture_data_.total_gestures <= 32) && \
3375                     ; 766         (gesture_data_.total_gestures > 0) ) {
3377  001d c60091        	ld	a,_gesture_data_+129
3378  0020 a121          	cp	a,#33
3379  0022 2503          	jrult	L241
3380  0024 cc00fa        	jp	L3701
3381  0027               L241:
3383  0027 725d0091      	tnz	_gesture_data_+129
3384  002b 2603          	jrne	L441
3385  002d cc00fa        	jp	L3701
3386  0030               L441:
3387                     ; 769         for( i = 0; i < gesture_data_.total_gestures; i++ ) {
3389  0030 5f            	clrw	x
3390  0031 1f0f          	ldw	(OFST-1,sp),x
3392  0033 2059          	jra	L1011
3393  0035               L5701:
3394                     ; 770             if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
3394                     ; 771                 (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
3394                     ; 772                 (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
3394                     ; 773                 (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
3396  0035 1e0f          	ldw	x,(OFST-1,sp)
3397  0037 d60010        	ld	a,(_gesture_data_,x)
3398  003a a10b          	cp	a,#11
3399  003c 2549          	jrult	L5011
3401  003e 1e0f          	ldw	x,(OFST-1,sp)
3402  0040 d60030        	ld	a,(_gesture_data_+32,x)
3403  0043 a10b          	cp	a,#11
3404  0045 2540          	jrult	L5011
3406  0047 1e0f          	ldw	x,(OFST-1,sp)
3407  0049 d60050        	ld	a,(_gesture_data_+64,x)
3408  004c a10b          	cp	a,#11
3409  004e 2537          	jrult	L5011
3411  0050 1e0f          	ldw	x,(OFST-1,sp)
3412  0052 d60070        	ld	a,(_gesture_data_+96,x)
3413  0055 a10b          	cp	a,#11
3414  0057 252e          	jrult	L5011
3415                     ; 775                 u_first = gesture_data_.u_data[i];
3417  0059 1e0f          	ldw	x,(OFST-1,sp)
3418  005b d60010        	ld	a,(_gesture_data_,x)
3419  005e 6b09          	ld	(OFST-7,sp),a
3420                     ; 776                 d_first = gesture_data_.d_data[i];
3422  0060 1e0f          	ldw	x,(OFST-1,sp)
3423  0062 d60030        	ld	a,(_gesture_data_+32,x)
3424  0065 6b0a          	ld	(OFST-6,sp),a
3425                     ; 777                 l_first = gesture_data_.l_data[i];
3427  0067 1e0f          	ldw	x,(OFST-1,sp)
3428  0069 d60050        	ld	a,(_gesture_data_+64,x)
3429  006c 6b0b          	ld	(OFST-5,sp),a
3430                     ; 778                 r_first = gesture_data_.r_data[i];
3432  006e 1e0f          	ldw	x,(OFST-1,sp)
3433  0070 d60070        	ld	a,(_gesture_data_+96,x)
3434  0073 6b0c          	ld	(OFST-4,sp),a
3435                     ; 779                 break;
3436  0075               L3011:
3437                     ; 784         if( (u_first == 0) || (d_first == 0) || \
3437                     ; 785             (l_first == 0) || (r_first == 0) ) {
3439  0075 0d09          	tnz	(OFST-7,sp)
3440  0077 2725          	jreq	L1111
3442  0079 0d0a          	tnz	(OFST-6,sp)
3443  007b 2721          	jreq	L1111
3445  007d 0d0b          	tnz	(OFST-5,sp)
3446  007f 271d          	jreq	L1111
3448  0081 0d0c          	tnz	(OFST-4,sp)
3449  0083 261d          	jrne	L7011
3450  0085 2017          	jra	L1111
3451  0087               L5011:
3452                     ; 769         for( i = 0; i < gesture_data_.total_gestures; i++ ) {
3454  0087 1e0f          	ldw	x,(OFST-1,sp)
3455  0089 1c0001        	addw	x,#1
3456  008c 1f0f          	ldw	(OFST-1,sp),x
3457  008e               L1011:
3460  008e 9c            	rvf
3461  008f c60091        	ld	a,_gesture_data_+129
3462  0092 5f            	clrw	x
3463  0093 97            	ld	xl,a
3464  0094 bf00          	ldw	c_x,x
3465  0096 1e0f          	ldw	x,(OFST-1,sp)
3466  0098 b300          	cpw	x,c_x
3467  009a 2f99          	jrslt	L5701
3468  009c 20d7          	jra	L3011
3469  009e               L1111:
3470                     ; 787             return FALSE;
3472  009e 4f            	clr	a
3474  009f               L041:
3476  009f 5b10          	addw	sp,#16
3477  00a1 81            	ret
3478  00a2               L7011:
3479                     ; 790         for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
3481  00a2 c60091        	ld	a,_gesture_data_+129
3482  00a5 5f            	clrw	x
3483  00a6 97            	ld	xl,a
3484  00a7 5a            	decw	x
3485  00a8 1f0f          	ldw	(OFST-1,sp),x
3487  00aa 2049          	jra	L3211
3488  00ac               L7111:
3489                     ; 792             if( (gesture_data_.u_data[i] > GESTURE_THRESHOLD_OUT) &&
3489                     ; 793                 (gesture_data_.d_data[i] > GESTURE_THRESHOLD_OUT) &&
3489                     ; 794                 (gesture_data_.l_data[i] > GESTURE_THRESHOLD_OUT) &&
3489                     ; 795                 (gesture_data_.r_data[i] > GESTURE_THRESHOLD_OUT) ) {
3491  00ac 1e0f          	ldw	x,(OFST-1,sp)
3492  00ae d60010        	ld	a,(_gesture_data_,x)
3493  00b1 a10b          	cp	a,#11
3494  00b3 2539          	jrult	L7211
3496  00b5 1e0f          	ldw	x,(OFST-1,sp)
3497  00b7 d60030        	ld	a,(_gesture_data_+32,x)
3498  00ba a10b          	cp	a,#11
3499  00bc 2530          	jrult	L7211
3501  00be 1e0f          	ldw	x,(OFST-1,sp)
3502  00c0 d60050        	ld	a,(_gesture_data_+64,x)
3503  00c3 a10b          	cp	a,#11
3504  00c5 2527          	jrult	L7211
3506  00c7 1e0f          	ldw	x,(OFST-1,sp)
3507  00c9 d60070        	ld	a,(_gesture_data_+96,x)
3508  00cc a10b          	cp	a,#11
3509  00ce 251e          	jrult	L7211
3510                     ; 797                 u_last = gesture_data_.u_data[i];
3512  00d0 1e0f          	ldw	x,(OFST-1,sp)
3513  00d2 d60010        	ld	a,(_gesture_data_,x)
3514  00d5 6b05          	ld	(OFST-11,sp),a
3515                     ; 798                 d_last = gesture_data_.d_data[i];
3517  00d7 1e0f          	ldw	x,(OFST-1,sp)
3518  00d9 d60030        	ld	a,(_gesture_data_+32,x)
3519  00dc 6b06          	ld	(OFST-10,sp),a
3520                     ; 799                 l_last = gesture_data_.l_data[i];
3522  00de 1e0f          	ldw	x,(OFST-1,sp)
3523  00e0 d60050        	ld	a,(_gesture_data_+64,x)
3524  00e3 6b07          	ld	(OFST-9,sp),a
3525                     ; 800                 r_last = gesture_data_.r_data[i];
3527  00e5 1e0f          	ldw	x,(OFST-1,sp)
3528  00e7 d60070        	ld	a,(_gesture_data_+96,x)
3529  00ea 6b08          	ld	(OFST-8,sp),a
3530                     ; 801                 break;
3532  00ec 200c          	jra	L3701
3533  00ee               L7211:
3534                     ; 790         for( i = gesture_data_.total_gestures - 1; i >= 0; i-- ) {
3536  00ee 1e0f          	ldw	x,(OFST-1,sp)
3537  00f0 1d0001        	subw	x,#1
3538  00f3 1f0f          	ldw	(OFST-1,sp),x
3539  00f5               L3211:
3542  00f5 9c            	rvf
3543  00f6 1e0f          	ldw	x,(OFST-1,sp)
3544  00f8 2eb2          	jrsge	L7111
3545  00fa               L3701:
3546                     ; 807     ud_ratio_first = ((u_first - d_first) * 100) / (u_first + d_first);
3548  00fa 7b09          	ld	a,(OFST-7,sp)
3549  00fc 5f            	clrw	x
3550  00fd 100a          	sub	a,(OFST-6,sp)
3551  00ff 2401          	jrnc	L021
3552  0101 5a            	decw	x
3553  0102               L021:
3554  0102 02            	rlwa	x,a
3555  0103 90ae0064      	ldw	y,#100
3556  0107 cd0000        	call	c_imul
3558  010a 89            	pushw	x
3559  010b 7b0b          	ld	a,(OFST-5,sp)
3560  010d 5f            	clrw	x
3561  010e 1b0c          	add	a,(OFST-4,sp)
3562  0110 2401          	jrnc	L221
3563  0112 5c            	incw	x
3564  0113               L221:
3565  0113 02            	rlwa	x,a
3566  0114 9085          	popw	y
3567  0116 51            	exgw	x,y
3568  0117 cd0000        	call	c_idiv
3570  011a 51            	exgw	x,y
3571  011b 1701          	ldw	(OFST-15,sp),y
3572                     ; 808     lr_ratio_first = ((l_first - r_first) * 100) / (l_first + r_first);
3574  011d 7b0b          	ld	a,(OFST-5,sp)
3575  011f 5f            	clrw	x
3576  0120 100c          	sub	a,(OFST-4,sp)
3577  0122 2401          	jrnc	L421
3578  0124 5a            	decw	x
3579  0125               L421:
3580  0125 02            	rlwa	x,a
3581  0126 90ae0064      	ldw	y,#100
3582  012a cd0000        	call	c_imul
3584  012d 89            	pushw	x
3585  012e 7b0d          	ld	a,(OFST-3,sp)
3586  0130 5f            	clrw	x
3587  0131 1b0e          	add	a,(OFST-2,sp)
3588  0133 2401          	jrnc	L621
3589  0135 5c            	incw	x
3590  0136               L621:
3591  0136 02            	rlwa	x,a
3592  0137 9085          	popw	y
3593  0139 51            	exgw	x,y
3594  013a cd0000        	call	c_idiv
3596  013d 51            	exgw	x,y
3597  013e 1703          	ldw	(OFST-13,sp),y
3598                     ; 809     ud_ratio_last = ((u_last - d_last) * 100) / (u_last + d_last);
3600  0140 7b05          	ld	a,(OFST-11,sp)
3601  0142 5f            	clrw	x
3602  0143 1006          	sub	a,(OFST-10,sp)
3603  0145 2401          	jrnc	L031
3604  0147 5a            	decw	x
3605  0148               L031:
3606  0148 02            	rlwa	x,a
3607  0149 90ae0064      	ldw	y,#100
3608  014d cd0000        	call	c_imul
3610  0150 89            	pushw	x
3611  0151 7b07          	ld	a,(OFST-9,sp)
3612  0153 5f            	clrw	x
3613  0154 1b08          	add	a,(OFST-8,sp)
3614  0156 2401          	jrnc	L231
3615  0158 5c            	incw	x
3616  0159               L231:
3617  0159 02            	rlwa	x,a
3618  015a 9085          	popw	y
3619  015c 51            	exgw	x,y
3620  015d cd0000        	call	c_idiv
3622  0160 51            	exgw	x,y
3623  0161 170d          	ldw	(OFST-3,sp),y
3624                     ; 810     lr_ratio_last = ((l_last - r_last) * 100) / (l_last + r_last);
3626  0163 7b07          	ld	a,(OFST-9,sp)
3627  0165 5f            	clrw	x
3628  0166 1008          	sub	a,(OFST-8,sp)
3629  0168 2401          	jrnc	L431
3630  016a 5a            	decw	x
3631  016b               L431:
3632  016b 02            	rlwa	x,a
3633  016c 90ae0064      	ldw	y,#100
3634  0170 cd0000        	call	c_imul
3636  0173 89            	pushw	x
3637  0174 7b09          	ld	a,(OFST-7,sp)
3638  0176 5f            	clrw	x
3639  0177 1b0a          	add	a,(OFST-6,sp)
3640  0179 2401          	jrnc	L631
3641  017b 5c            	incw	x
3642  017c               L631:
3643  017c 02            	rlwa	x,a
3644  017d 9085          	popw	y
3645  017f 51            	exgw	x,y
3646  0180 cd0000        	call	c_idiv
3648  0183 51            	exgw	x,y
3649  0184 170f          	ldw	(OFST-1,sp),y
3650                     ; 814     ud_delta = ud_ratio_last - ud_ratio_first;
3652  0186 1e0d          	ldw	x,(OFST-3,sp)
3653  0188 72f001        	subw	x,(OFST-15,sp)
3654  018b 1f0d          	ldw	(OFST-3,sp),x
3655                     ; 815     lr_delta = lr_ratio_last - lr_ratio_first;
3657  018d 1e0f          	ldw	x,(OFST-1,sp)
3658  018f 72f003        	subw	x,(OFST-13,sp)
3659  0192 1f0f          	ldw	(OFST-1,sp),x
3660                     ; 819     gesture_ud_delta_ += ud_delta;
3662  0194 ce000e        	ldw	x,_gesture_ud_delta_
3663  0197 72fb0d        	addw	x,(OFST-3,sp)
3664  019a cf000e        	ldw	_gesture_ud_delta_,x
3665                     ; 820     gesture_lr_delta_ += lr_delta;
3667  019d ce000c        	ldw	x,_gesture_lr_delta_
3668  01a0 72fb0f        	addw	x,(OFST-1,sp)
3669  01a3 cf000c        	ldw	_gesture_lr_delta_,x
3670                     ; 824     if( gesture_ud_delta_ >= GESTURE_SENSITIVITY_1 ) {
3672  01a6 9c            	rvf
3673  01a7 ce000e        	ldw	x,_gesture_ud_delta_
3674  01aa a30032        	cpw	x,#50
3675  01ad 2f08          	jrslt	L1311
3676                     ; 825         gesture_ud_count_ = 1;
3678  01af ae0001        	ldw	x,#1
3679  01b2 cf000a        	ldw	_gesture_ud_count_,x
3681  01b5 2015          	jra	L3311
3682  01b7               L1311:
3683                     ; 826     } else if( gesture_ud_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3685  01b7 9c            	rvf
3686  01b8 ce000e        	ldw	x,_gesture_ud_delta_
3687  01bb a3ffcf        	cpw	x,#65487
3688  01be 2e08          	jrsge	L5311
3689                     ; 827         gesture_ud_count_ = -1;
3691  01c0 aeffff        	ldw	x,#65535
3692  01c3 cf000a        	ldw	_gesture_ud_count_,x
3694  01c6 2004          	jra	L3311
3695  01c8               L5311:
3696                     ; 829         gesture_ud_count_ = 0;
3698  01c8 5f            	clrw	x
3699  01c9 cf000a        	ldw	_gesture_ud_count_,x
3700  01cc               L3311:
3701                     ; 833     if( gesture_lr_delta_ >= GESTURE_SENSITIVITY_1 ) {
3703  01cc 9c            	rvf
3704  01cd ce000c        	ldw	x,_gesture_lr_delta_
3705  01d0 a30032        	cpw	x,#50
3706  01d3 2f08          	jrslt	L1411
3707                     ; 834         gesture_lr_count_ = 1;
3709  01d5 ae0001        	ldw	x,#1
3710  01d8 cf0008        	ldw	_gesture_lr_count_,x
3712  01db 2015          	jra	L3411
3713  01dd               L1411:
3714                     ; 835     } else if( gesture_lr_delta_ <= -GESTURE_SENSITIVITY_1 ) {
3716  01dd 9c            	rvf
3717  01de ce000c        	ldw	x,_gesture_lr_delta_
3718  01e1 a3ffcf        	cpw	x,#65487
3719  01e4 2e08          	jrsge	L5411
3720                     ; 836         gesture_lr_count_ = -1;
3722  01e6 aeffff        	ldw	x,#65535
3723  01e9 cf0008        	ldw	_gesture_lr_count_,x
3725  01ec 2004          	jra	L3411
3726  01ee               L5411:
3727                     ; 838         gesture_lr_count_ = 0;
3729  01ee 5f            	clrw	x
3730  01ef cf0008        	ldw	_gesture_lr_count_,x
3731  01f2               L3411:
3732                     ; 842     if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 0) ) {
3734  01f2 ce000a        	ldw	x,_gesture_ud_count_
3735  01f5 267b          	jrne	L1511
3737  01f7 ce0008        	ldw	x,_gesture_lr_count_
3738  01fa 2676          	jrne	L1511
3739                     ; 843         if( (abs(ud_delta) < GESTURE_SENSITIVITY_2) && (abs(lr_delta) < GESTURE_SENSITIVITY_2) ) 
3741  01fc 9c            	rvf
3742  01fd 1e0d          	ldw	x,(OFST-3,sp)
3743  01ff cd0000        	call	_abs
3745  0202 a30014        	cpw	x,#20
3746  0205 2f03          	jrslt	L641
3747  0207 cc02b2        	jp	L5711
3748  020a               L641:
3750  020a 9c            	rvf
3751  020b 1e0f          	ldw	x,(OFST-1,sp)
3752  020d cd0000        	call	_abs
3754  0210 a30014        	cpw	x,#20
3755  0213 2f03          	jrslt	L051
3756  0215 cc02b2        	jp	L5711
3757  0218               L051:
3758                     ; 846             if( (ud_delta == 0) && (lr_delta == 0) ) {
3760  0218 1e0d          	ldw	x,(OFST-3,sp)
3761  021a 260f          	jrne	L5511
3763  021c 1e0f          	ldw	x,(OFST-1,sp)
3764  021e 260b          	jrne	L5511
3765                     ; 847                 gesture_near_count_++;
3767  0220 ce0006        	ldw	x,_gesture_near_count_
3768  0223 1c0001        	addw	x,#1
3769  0226 cf0006        	ldw	_gesture_near_count_,x
3771  0229 2011          	jra	L7511
3772  022b               L5511:
3773                     ; 848             } else if( (ud_delta != 0) || (lr_delta != 0) ) {
3775  022b 1e0d          	ldw	x,(OFST-3,sp)
3776  022d 2604          	jrne	L3611
3778  022f 1e0f          	ldw	x,(OFST-1,sp)
3779  0231 2709          	jreq	L7511
3780  0233               L3611:
3781                     ; 849                 gesture_far_count_++;
3783  0233 ce0004        	ldw	x,_gesture_far_count_
3784  0236 1c0001        	addw	x,#1
3785  0239 cf0004        	ldw	_gesture_far_count_,x
3786  023c               L7511:
3787                     ; 852             if( (gesture_near_count_ >= 10) && (gesture_far_count_ >= 2) ) {
3789  023c 9c            	rvf
3790  023d ce0006        	ldw	x,_gesture_near_count_
3791  0240 a3000a        	cpw	x,#10
3792  0243 2f6d          	jrslt	L5711
3794  0245 9c            	rvf
3795  0246 ce0004        	ldw	x,_gesture_far_count_
3796  0249 a30002        	cpw	x,#2
3797  024c 2f64          	jrslt	L5711
3798                     ; 853                 if( (ud_delta == 0) && (lr_delta == 0) ) {
3800  024e 1e0d          	ldw	x,(OFST-3,sp)
3801  0250 260c          	jrne	L7611
3803  0252 1e0f          	ldw	x,(OFST-1,sp)
3804  0254 2608          	jrne	L7611
3805                     ; 854                     gesture_state_ = NEAR_STATE;
3807  0256 ae0001        	ldw	x,#1
3808  0259 cf0002        	ldw	_gesture_state_,x
3810  025c 200e          	jra	L1711
3811  025e               L7611:
3812                     ; 855                 } else if( (ud_delta != 0) && (lr_delta != 0) ) {
3814  025e 1e0d          	ldw	x,(OFST-3,sp)
3815  0260 270a          	jreq	L1711
3817  0262 1e0f          	ldw	x,(OFST-1,sp)
3818  0264 2706          	jreq	L1711
3819                     ; 856                     gesture_state_ = FAR_STATE;
3821  0266 ae0002        	ldw	x,#2
3822  0269 cf0002        	ldw	_gesture_state_,x
3823  026c               L1711:
3824                     ; 858                 return TRUE;
3826  026c a601          	ld	a,#1
3828  026e ac9f009f      	jpf	L041
3829  0272               L1511:
3830                     ; 862         if( (abs((int)ud_delta) < GESTURE_SENSITIVITY_2) && (abs((int)lr_delta) < GESTURE_SENSITIVITY_2) ) {
3832  0272 9c            	rvf
3833  0273 1e0d          	ldw	x,(OFST-3,sp)
3834  0275 cd0000        	call	_abs
3836  0278 a30014        	cpw	x,#20
3837  027b 2e35          	jrsge	L5711
3839  027d 9c            	rvf
3840  027e 1e0f          	ldw	x,(OFST-1,sp)
3841  0280 cd0000        	call	_abs
3843  0283 a30014        	cpw	x,#20
3844  0286 2e2a          	jrsge	L5711
3845                     ; 864             if( (ud_delta == 0) && (lr_delta == 0) ) {
3847  0288 1e0d          	ldw	x,(OFST-3,sp)
3848  028a 260d          	jrne	L1021
3850  028c 1e0f          	ldw	x,(OFST-1,sp)
3851  028e 2609          	jrne	L1021
3852                     ; 865                 gesture_near_count_++;
3854  0290 ce0006        	ldw	x,_gesture_near_count_
3855  0293 1c0001        	addw	x,#1
3856  0296 cf0006        	ldw	_gesture_near_count_,x
3857  0299               L1021:
3858                     ; 868             if( gesture_near_count_ >= 10 ) {
3860  0299 9c            	rvf
3861  029a ce0006        	ldw	x,_gesture_near_count_
3862  029d a3000a        	cpw	x,#10
3863  02a0 2f10          	jrslt	L5711
3864                     ; 869                 gesture_ud_count_ = 0;
3866  02a2 5f            	clrw	x
3867  02a3 cf000a        	ldw	_gesture_ud_count_,x
3868                     ; 870                 gesture_lr_count_ = 0;
3870  02a6 5f            	clrw	x
3871  02a7 cf0008        	ldw	_gesture_lr_count_,x
3872                     ; 871                 gesture_ud_delta_ = 0;
3874  02aa 5f            	clrw	x
3875  02ab cf000e        	ldw	_gesture_ud_delta_,x
3876                     ; 872                 gesture_lr_delta_ = 0;
3878  02ae 5f            	clrw	x
3879  02af cf000c        	ldw	_gesture_lr_delta_,x
3880  02b2               L5711:
3881                     ; 876     return FALSE;
3883  02b2 4f            	clr	a
3885  02b3 ac9f009f      	jpf	L041
3916                     ; 884 bool decodeGesture(void)
3916                     ; 885 {
3917                     .text:	section	.text,new
3918  0000               _decodeGesture:
3920  0000 89            	pushw	x
3921       00000002      OFST:	set	2
3924                     ; 887     if( gesture_state_ == NEAR_STATE ) {
3926  0001 ce0002        	ldw	x,_gesture_state_
3927  0004 a30001        	cpw	x,#1
3928  0007 260a          	jrne	L5121
3929                     ; 888         gesture_motion_ = DIR_NEAR;
3931  0009 ae0005        	ldw	x,#5
3932  000c cf0000        	ldw	_gesture_motion_,x
3933                     ; 889         return TRUE;
3935  000f a601          	ld	a,#1
3937  0011 2010          	jra	L451
3938  0013               L5121:
3939                     ; 890     } else if ( gesture_state_ == FAR_STATE ) {
3941  0013 ce0002        	ldw	x,_gesture_state_
3942  0016 a30002        	cpw	x,#2
3943  0019 260a          	jrne	L7121
3944                     ; 891         gesture_motion_ = DIR_FAR;
3946  001b ae0006        	ldw	x,#6
3947  001e cf0000        	ldw	_gesture_motion_,x
3948                     ; 892         return TRUE;
3950  0021 a601          	ld	a,#1
3952  0023               L451:
3954  0023 85            	popw	x
3955  0024 81            	ret
3956  0025               L7121:
3957                     ; 896     if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 0) ) {
3959  0025 ce000a        	ldw	x,_gesture_ud_count_
3960  0028 a3ffff        	cpw	x,#65535
3961  002b 260f          	jrne	L3221
3963  002d ce0008        	ldw	x,_gesture_lr_count_
3964  0030 260a          	jrne	L3221
3965                     ; 897         gesture_motion_ = DIR_UP;
3967  0032 ae0003        	ldw	x,#3
3968  0035 cf0000        	ldw	_gesture_motion_,x
3970  0038 ac4f014f      	jpf	L5221
3971  003c               L3221:
3972                     ; 898     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 0) ) {
3974  003c ce000a        	ldw	x,_gesture_ud_count_
3975  003f a30001        	cpw	x,#1
3976  0042 260f          	jrne	L7221
3978  0044 ce0008        	ldw	x,_gesture_lr_count_
3979  0047 260a          	jrne	L7221
3980                     ; 899         gesture_motion_ = DIR_DOWN;
3982  0049 ae0004        	ldw	x,#4
3983  004c cf0000        	ldw	_gesture_motion_,x
3985  004f ac4f014f      	jpf	L5221
3986  0053               L7221:
3987                     ; 900     } else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == 1) ) {
3989  0053 ce000a        	ldw	x,_gesture_ud_count_
3990  0056 2612          	jrne	L3321
3992  0058 ce0008        	ldw	x,_gesture_lr_count_
3993  005b a30001        	cpw	x,#1
3994  005e 260a          	jrne	L3321
3995                     ; 901         gesture_motion_ = DIR_RIGHT;
3997  0060 ae0002        	ldw	x,#2
3998  0063 cf0000        	ldw	_gesture_motion_,x
4000  0066 ac4f014f      	jpf	L5221
4001  006a               L3321:
4002                     ; 902     } else if( (gesture_ud_count_ == 0) && (gesture_lr_count_ == -1) ) {
4004  006a ce000a        	ldw	x,_gesture_ud_count_
4005  006d 2612          	jrne	L7321
4007  006f ce0008        	ldw	x,_gesture_lr_count_
4008  0072 a3ffff        	cpw	x,#65535
4009  0075 260a          	jrne	L7321
4010                     ; 903         gesture_motion_ = DIR_LEFT;
4012  0077 ae0001        	ldw	x,#1
4013  007a cf0000        	ldw	_gesture_motion_,x
4015  007d ac4f014f      	jpf	L5221
4016  0081               L7321:
4017                     ; 904     } else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == 1) ) {
4019  0081 ce000a        	ldw	x,_gesture_ud_count_
4020  0084 a3ffff        	cpw	x,#65535
4021  0087 262f          	jrne	L3421
4023  0089 ce0008        	ldw	x,_gesture_lr_count_
4024  008c a30001        	cpw	x,#1
4025  008f 2627          	jrne	L3421
4026                     ; 905         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
4028  0091 9c            	rvf
4029  0092 ce000c        	ldw	x,_gesture_lr_delta_
4030  0095 cd0000        	call	_abs
4032  0098 1f01          	ldw	(OFST-1,sp),x
4033  009a ce000e        	ldw	x,_gesture_ud_delta_
4034  009d cd0000        	call	_abs
4036  00a0 1301          	cpw	x,(OFST-1,sp)
4037  00a2 2d0a          	jrsle	L5421
4038                     ; 906             gesture_motion_ = DIR_UP;
4040  00a4 ae0003        	ldw	x,#3
4041  00a7 cf0000        	ldw	_gesture_motion_,x
4043  00aa ac4f014f      	jpf	L5221
4044  00ae               L5421:
4045                     ; 908             gesture_motion_ = DIR_RIGHT;
4047  00ae ae0002        	ldw	x,#2
4048  00b1 cf0000        	ldw	_gesture_motion_,x
4049  00b4 ac4f014f      	jpf	L5221
4050  00b8               L3421:
4051                     ; 910     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == -1) ) {
4053  00b8 ce000a        	ldw	x,_gesture_ud_count_
4054  00bb a30001        	cpw	x,#1
4055  00be 262b          	jrne	L3521
4057  00c0 ce0008        	ldw	x,_gesture_lr_count_
4058  00c3 a3ffff        	cpw	x,#65535
4059  00c6 2623          	jrne	L3521
4060                     ; 911         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
4062  00c8 9c            	rvf
4063  00c9 ce000c        	ldw	x,_gesture_lr_delta_
4064  00cc cd0000        	call	_abs
4066  00cf 1f01          	ldw	(OFST-1,sp),x
4067  00d1 ce000e        	ldw	x,_gesture_ud_delta_
4068  00d4 cd0000        	call	_abs
4070  00d7 1301          	cpw	x,(OFST-1,sp)
4071  00d9 2d08          	jrsle	L5521
4072                     ; 912             gesture_motion_ = DIR_DOWN;
4074  00db ae0004        	ldw	x,#4
4075  00de cf0000        	ldw	_gesture_motion_,x
4077  00e1 206c          	jra	L5221
4078  00e3               L5521:
4079                     ; 914             gesture_motion_ = DIR_LEFT;
4081  00e3 ae0001        	ldw	x,#1
4082  00e6 cf0000        	ldw	_gesture_motion_,x
4083  00e9 2064          	jra	L5221
4084  00eb               L3521:
4085                     ; 916     } else if( (gesture_ud_count_ == -1) && (gesture_lr_count_ == -1) ) {
4087  00eb ce000a        	ldw	x,_gesture_ud_count_
4088  00ee a3ffff        	cpw	x,#65535
4089  00f1 262b          	jrne	L3621
4091  00f3 ce0008        	ldw	x,_gesture_lr_count_
4092  00f6 a3ffff        	cpw	x,#65535
4093  00f9 2623          	jrne	L3621
4094                     ; 917         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
4096  00fb 9c            	rvf
4097  00fc ce000c        	ldw	x,_gesture_lr_delta_
4098  00ff cd0000        	call	_abs
4100  0102 1f01          	ldw	(OFST-1,sp),x
4101  0104 ce000e        	ldw	x,_gesture_ud_delta_
4102  0107 cd0000        	call	_abs
4104  010a 1301          	cpw	x,(OFST-1,sp)
4105  010c 2d08          	jrsle	L5621
4106                     ; 918             gesture_motion_ = DIR_UP;
4108  010e ae0003        	ldw	x,#3
4109  0111 cf0000        	ldw	_gesture_motion_,x
4111  0114 2039          	jra	L5221
4112  0116               L5621:
4113                     ; 920             gesture_motion_ = DIR_LEFT;
4115  0116 ae0001        	ldw	x,#1
4116  0119 cf0000        	ldw	_gesture_motion_,x
4117  011c 2031          	jra	L5221
4118  011e               L3621:
4119                     ; 922     } else if( (gesture_ud_count_ == 1) && (gesture_lr_count_ == 1) ) {
4121  011e ce000a        	ldw	x,_gesture_ud_count_
4122  0121 a30001        	cpw	x,#1
4123  0124 262d          	jrne	L3721
4125  0126 ce0008        	ldw	x,_gesture_lr_count_
4126  0129 a30001        	cpw	x,#1
4127  012c 2625          	jrne	L3721
4128                     ; 923         if( abs(gesture_ud_delta_) > abs(gesture_lr_delta_) ) {
4130  012e 9c            	rvf
4131  012f ce000c        	ldw	x,_gesture_lr_delta_
4132  0132 cd0000        	call	_abs
4134  0135 1f01          	ldw	(OFST-1,sp),x
4135  0137 ce000e        	ldw	x,_gesture_ud_delta_
4136  013a cd0000        	call	_abs
4138  013d 1301          	cpw	x,(OFST-1,sp)
4139  013f 2d08          	jrsle	L5721
4140                     ; 924             gesture_motion_ = DIR_DOWN;
4142  0141 ae0004        	ldw	x,#4
4143  0144 cf0000        	ldw	_gesture_motion_,x
4145  0147 2006          	jra	L5221
4146  0149               L5721:
4147                     ; 926             gesture_motion_ = DIR_RIGHT;
4149  0149 ae0002        	ldw	x,#2
4150  014c cf0000        	ldw	_gesture_motion_,x
4151  014f               L5221:
4152                     ; 932     return TRUE;
4154  014f a601          	ld	a,#1
4156  0151 2001          	jra	L651
4157  0153               L3721:
4158                     ; 929         return FALSE;
4160  0153 4f            	clr	a
4162  0154               L651:
4164  0154 85            	popw	x
4165  0155 81            	ret
4207                     ; 947 bool setLEDBoost(u8 boost)
4207                     ; 948 {
4208                     .text:	section	.text,new
4209  0000               _setLEDBoost:
4211  0000 88            	push	a
4212  0001 88            	push	a
4213       00000001      OFST:	set	1
4216                     ; 952     if( !wireReadDataByte(APDS9960_CONFIG2, &val) ) {
4218  0002 96            	ldw	x,sp
4219  0003 1c0001        	addw	x,#OFST+0
4220  0006 89            	pushw	x
4221  0007 a690          	ld	a,#144
4222  0009 cd0000        	call	_wireReadDataByte
4224  000c 85            	popw	x
4225  000d 4d            	tnz	a
4226  000e 2603          	jrne	L1231
4227                     ; 953         return FALSE;
4229  0010 4f            	clr	a
4231  0011 2026          	jra	L261
4232  0013               L1231:
4233                     ; 957     boost &= 00000011;
4235  0013 7b02          	ld	a,(OFST+1,sp)
4236  0015 a409          	and	a,#9
4237  0017 6b02          	ld	(OFST+1,sp),a
4238                     ; 958     boost = boost << 4;
4240  0019 7b02          	ld	a,(OFST+1,sp)
4241  001b 4e            	swap	a
4242  001c a4f0          	and	a,#240
4243  001e 6b02          	ld	(OFST+1,sp),a
4244                     ; 959     val &= 11001111;
4246  0020 7b01          	ld	a,(OFST+0,sp)
4247  0022 a417          	and	a,#23
4248  0024 6b01          	ld	(OFST+0,sp),a
4249                     ; 960     val |= boost;
4251  0026 7b01          	ld	a,(OFST+0,sp)
4252  0028 1a02          	or	a,(OFST+1,sp)
4253  002a 6b01          	ld	(OFST+0,sp),a
4254                     ; 963     if( !wireWriteDataByte(APDS9960_CONFIG2, val) ) {
4256  002c 7b01          	ld	a,(OFST+0,sp)
4257  002e 97            	ld	xl,a
4258  002f a690          	ld	a,#144
4259  0031 95            	ld	xh,a
4260  0032 cd0000        	call	_wireWriteDataByte
4262  0035 4d            	tnz	a
4263  0036 2603          	jrne	L3231
4264                     ; 964         return FALSE;
4266  0038 4f            	clr	a
4268  0039               L261:
4270  0039 85            	popw	x
4271  003a 81            	ret
4272  003b               L3231:
4273                     ; 967     return TRUE;
4275  003b a601          	ld	a,#1
4277  003d 20fa          	jra	L261
4312                     ; 976 bool setGestureEnterThresh(u8 threshold)
4312                     ; 977 {
4313                     .text:	section	.text,new
4314  0000               _setGestureEnterThresh:
4318                     ; 978     if( !wireWriteDataByte(APDS9960_GPENTH, threshold) ) {
4320  0000 97            	ld	xl,a
4321  0001 a6a0          	ld	a,#160
4322  0003 95            	ld	xh,a
4323  0004 cd0000        	call	_wireWriteDataByte
4325  0007 4d            	tnz	a
4326  0008 2602          	jrne	L1431
4327                     ; 979         return FALSE;
4329  000a 4f            	clr	a
4332  000b 81            	ret
4333  000c               L1431:
4334                     ; 982     return TRUE;
4336  000c a601          	ld	a,#1
4339  000e 81            	ret
4374                     ; 991 bool setGestureExitThresh(u8 threshold)
4374                     ; 992 {
4375                     .text:	section	.text,new
4376  0000               _setGestureExitThresh:
4380                     ; 993     if( !wireWriteDataByte(APDS9960_GEXTH, threshold) ) {
4382  0000 97            	ld	xl,a
4383  0001 a6a1          	ld	a,#161
4384  0003 95            	ld	xh,a
4385  0004 cd0000        	call	_wireWriteDataByte
4387  0007 4d            	tnz	a
4388  0008 2602          	jrne	L7531
4389                     ; 994         return FALSE;
4391  000a 4f            	clr	a
4394  000b 81            	ret
4395  000c               L7531:
4396                     ; 997     return TRUE;
4398  000c a601          	ld	a,#1
4401  000e 81            	ret
4443                     ; 1013 bool setGestureGain(u8 gain)
4443                     ; 1014 {
4444                     .text:	section	.text,new
4445  0000               _setGestureGain:
4447  0000 88            	push	a
4448  0001 88            	push	a
4449       00000001      OFST:	set	1
4452                     ; 1018     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
4454  0002 96            	ldw	x,sp
4455  0003 1c0001        	addw	x,#OFST+0
4456  0006 89            	pushw	x
4457  0007 a6a3          	ld	a,#163
4458  0009 cd0000        	call	_wireReadDataByte
4460  000c 85            	popw	x
4461  000d 4d            	tnz	a
4462  000e 2603          	jrne	L7731
4463                     ; 1019         return FALSE;
4465  0010 4f            	clr	a
4467  0011 2027          	jra	L271
4468  0013               L7731:
4469                     ; 1023     gain &= 00000011;
4471  0013 7b02          	ld	a,(OFST+1,sp)
4472  0015 a409          	and	a,#9
4473  0017 6b02          	ld	(OFST+1,sp),a
4474                     ; 1024     gain = gain << 5;
4476  0019 7b02          	ld	a,(OFST+1,sp)
4477  001b 4e            	swap	a
4478  001c 48            	sll	a
4479  001d a4e0          	and	a,#224
4480  001f 6b02          	ld	(OFST+1,sp),a
4481                     ; 1025     val &= 10011111;
4483  0021 7b01          	ld	a,(OFST+0,sp)
4484  0023 a4e7          	and	a,#231
4485  0025 6b01          	ld	(OFST+0,sp),a
4486                     ; 1026     val |= gain;
4488  0027 7b01          	ld	a,(OFST+0,sp)
4489  0029 1a02          	or	a,(OFST+1,sp)
4490  002b 6b01          	ld	(OFST+0,sp),a
4491                     ; 1029     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
4493  002d 7b01          	ld	a,(OFST+0,sp)
4494  002f 97            	ld	xl,a
4495  0030 a6a3          	ld	a,#163
4496  0032 95            	ld	xh,a
4497  0033 cd0000        	call	_wireWriteDataByte
4499  0036 4d            	tnz	a
4500  0037 2603          	jrne	L1041
4501                     ; 1030         return FALSE;
4503  0039 4f            	clr	a
4505  003a               L271:
4507  003a 85            	popw	x
4508  003b 81            	ret
4509  003c               L1041:
4510                     ; 1033     return TRUE;
4512  003c a601          	ld	a,#1
4514  003e 20fa          	jra	L271
4556                     ; 1048 bool setGestureLEDDrive(u8 drive)
4556                     ; 1049 {
4557                     .text:	section	.text,new
4558  0000               _setGestureLEDDrive:
4560  0000 88            	push	a
4561  0001 88            	push	a
4562       00000001      OFST:	set	1
4565                     ; 1053     if( !wireReadDataByte(APDS9960_GCONF2, &val) ) {
4567  0002 96            	ldw	x,sp
4568  0003 1c0001        	addw	x,#OFST+0
4569  0006 89            	pushw	x
4570  0007 a6a3          	ld	a,#163
4571  0009 cd0000        	call	_wireReadDataByte
4573  000c 85            	popw	x
4574  000d 4d            	tnz	a
4575  000e 2603          	jrne	L1241
4576                     ; 1054         return FALSE;
4578  0010 4f            	clr	a
4580  0011 2025          	jra	L671
4581  0013               L1241:
4582                     ; 1058     drive &= 00000011;
4584  0013 7b02          	ld	a,(OFST+1,sp)
4585  0015 a409          	and	a,#9
4586  0017 6b02          	ld	(OFST+1,sp),a
4587                     ; 1059     drive = drive << 3;
4589  0019 0802          	sll	(OFST+1,sp)
4590  001b 0802          	sll	(OFST+1,sp)
4591  001d 0802          	sll	(OFST+1,sp)
4592                     ; 1060     val &= 11100111;
4594  001f 7b01          	ld	a,(OFST+0,sp)
4595  0021 a4cf          	and	a,#207
4596  0023 6b01          	ld	(OFST+0,sp),a
4597                     ; 1061     val |= drive;
4599  0025 7b01          	ld	a,(OFST+0,sp)
4600  0027 1a02          	or	a,(OFST+1,sp)
4601  0029 6b01          	ld	(OFST+0,sp),a
4602                     ; 1064     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
4604  002b 7b01          	ld	a,(OFST+0,sp)
4605  002d 97            	ld	xl,a
4606  002e a6a3          	ld	a,#163
4607  0030 95            	ld	xh,a
4608  0031 cd0000        	call	_wireWriteDataByte
4610  0034 4d            	tnz	a
4611  0035 2603          	jrne	L3241
4612                     ; 1065         return FALSE;
4614  0037 4f            	clr	a
4616  0038               L671:
4618  0038 85            	popw	x
4619  0039 81            	ret
4620  003a               L3241:
4621                     ; 1068     return TRUE;
4623  003a a601          	ld	a,#1
4625  003c 20fa          	jra	L671
4667                     ; 1087 bool setGestureWaitTime(u8 time)
4667                     ; 1088 {
4668                     .text:	section	.text,new
4669  0000               _setGestureWaitTime:
4671  0000 88            	push	a
4672  0001 88            	push	a
4673       00000001      OFST:	set	1
4676                     ; 1092     if( !wireReadDataByte(APDS9960_GCONF2, &val)){
4678  0002 96            	ldw	x,sp
4679  0003 1c0001        	addw	x,#OFST+0
4680  0006 89            	pushw	x
4681  0007 a6a3          	ld	a,#163
4682  0009 cd0000        	call	_wireReadDataByte
4684  000c 85            	popw	x
4685  000d 4d            	tnz	a
4686  000e 2603          	jrne	L3441
4687                     ; 1093         return FALSE;
4689  0010 4f            	clr	a
4691  0011 201f          	jra	L202
4692  0013               L3441:
4693                     ; 1098     time &= 00000111;
4695  0013 7b02          	ld	a,(OFST+1,sp)
4696  0015 a449          	and	a,#73
4697  0017 6b02          	ld	(OFST+1,sp),a
4698                     ; 1099     val &= 11111000;
4700  0019 7b01          	ld	a,(OFST+0,sp)
4701  001b a458          	and	a,#88
4702  001d 6b01          	ld	(OFST+0,sp),a
4703                     ; 1100     val |= time;
4705  001f 7b01          	ld	a,(OFST+0,sp)
4706  0021 1a02          	or	a,(OFST+1,sp)
4707  0023 6b01          	ld	(OFST+0,sp),a
4708                     ; 1103     if( !wireWriteDataByte(APDS9960_GCONF2, val) ) {
4710  0025 7b01          	ld	a,(OFST+0,sp)
4711  0027 97            	ld	xl,a
4712  0028 a6a3          	ld	a,#163
4713  002a 95            	ld	xh,a
4714  002b cd0000        	call	_wireWriteDataByte
4716  002e 4d            	tnz	a
4717  002f 2603          	jrne	L5441
4718                     ; 1104         return FALSE;
4720  0031 4f            	clr	a
4722  0032               L202:
4724  0032 85            	popw	x
4725  0033 81            	ret
4726  0034               L5441:
4727                     ; 1107     return TRUE;
4729  0034 a601          	ld	a,#1
4731  0036 20fa          	jra	L202
4774                     ; 1118 bool setGestureIntEnable(u8 enable)
4774                     ; 1119 {
4775                     .text:	section	.text,new
4776  0000               _setGestureIntEnable:
4778  0000 88            	push	a
4779  0001 88            	push	a
4780       00000001      OFST:	set	1
4783                     ; 1123     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
4785  0002 96            	ldw	x,sp
4786  0003 1c0001        	addw	x,#OFST+0
4787  0006 89            	pushw	x
4788  0007 a6ab          	ld	a,#171
4789  0009 cd0000        	call	_wireReadDataByte
4791  000c 85            	popw	x
4792  000d 4d            	tnz	a
4793  000e 2603          	jrne	L5641
4794                     ; 1124         return FALSE;
4796  0010 4f            	clr	a
4798  0011 2021          	jra	L602
4799  0013               L5641:
4800                     ; 1128     enable &= 00000001;
4802  0013 7b02          	ld	a,(OFST+1,sp)
4803  0015 a401          	and	a,#1
4804  0017 6b02          	ld	(OFST+1,sp),a
4805                     ; 1129     enable = enable << 1;
4807  0019 0802          	sll	(OFST+1,sp)
4808                     ; 1130     val &= 11111101;
4810  001b 7b01          	ld	a,(OFST+0,sp)
4811  001d a4bd          	and	a,#189
4812  001f 6b01          	ld	(OFST+0,sp),a
4813                     ; 1131     val |= enable;
4815  0021 7b01          	ld	a,(OFST+0,sp)
4816  0023 1a02          	or	a,(OFST+1,sp)
4817  0025 6b01          	ld	(OFST+0,sp),a
4818                     ; 1134     if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
4820  0027 7b01          	ld	a,(OFST+0,sp)
4821  0029 97            	ld	xl,a
4822  002a a6ab          	ld	a,#171
4823  002c 95            	ld	xh,a
4824  002d cd0000        	call	_wireWriteDataByte
4826  0030 4d            	tnz	a
4827  0031 2603          	jrne	L7641
4828                     ; 1135         return FALSE;
4830  0033 4f            	clr	a
4832  0034               L602:
4834  0034 85            	popw	x
4835  0035 81            	ret
4836  0036               L7641:
4837                     ; 1138     return TRUE;
4839  0036 a601          	ld	a,#1
4841  0038 20fa          	jra	L602
4883                     ; 1147 bool setGestureMode(u8 mode)
4883                     ; 1148 {
4884                     .text:	section	.text,new
4885  0000               _setGestureMode:
4887  0000 88            	push	a
4888  0001 88            	push	a
4889       00000001      OFST:	set	1
4892                     ; 1152     if( !wireReadDataByte(APDS9960_GCONF4, &val) ) {
4894  0002 96            	ldw	x,sp
4895  0003 1c0001        	addw	x,#OFST+0
4896  0006 89            	pushw	x
4897  0007 a6ab          	ld	a,#171
4898  0009 cd0000        	call	_wireReadDataByte
4900  000c 85            	popw	x
4901  000d 4d            	tnz	a
4902  000e 2603          	jrne	L7051
4903                     ; 1153         return FALSE;
4905  0010 4f            	clr	a
4907  0011 201f          	jra	L212
4908  0013               L7051:
4909                     ; 1157     mode &= 00000001;
4911  0013 7b02          	ld	a,(OFST+1,sp)
4912  0015 a401          	and	a,#1
4913  0017 6b02          	ld	(OFST+1,sp),a
4914                     ; 1158     val &= 11111110;
4916  0019 7b01          	ld	a,(OFST+0,sp)
4917  001b a4c6          	and	a,#198
4918  001d 6b01          	ld	(OFST+0,sp),a
4919                     ; 1159     val |= mode;
4921  001f 7b01          	ld	a,(OFST+0,sp)
4922  0021 1a02          	or	a,(OFST+1,sp)
4923  0023 6b01          	ld	(OFST+0,sp),a
4924                     ; 1162     if( !wireWriteDataByte(APDS9960_GCONF4, val) ) {
4926  0025 7b01          	ld	a,(OFST+0,sp)
4927  0027 97            	ld	xl,a
4928  0028 a6ab          	ld	a,#171
4929  002a 95            	ld	xh,a
4930  002b cd0000        	call	_wireWriteDataByte
4932  002e 4d            	tnz	a
4933  002f 2603          	jrne	L1151
4934                     ; 1163         return FALSE;
4936  0031 4f            	clr	a
4938  0032               L212:
4940  0032 85            	popw	x
4941  0033 81            	ret
4942  0034               L1151:
4943                     ; 1166     return TRUE;
4945  0034 a601          	ld	a,#1
4947  0036 20fa          	jra	L212
4984                     ; 1175 bool wireWriteDataByte(u8 reg, u8 val)
4984                     ; 1176 {
4985                     .text:	section	.text,new
4986  0000               _wireWriteDataByte:
4990                     ; 1201 	IIC_Start(); 
4992  0000 cd0000        	call	_IIC_Start
4994                     ; 1202 	IIC_Send_Byte((APDS9960_I2C_ADDR<<1)|0);//写命令
4996  0003 a672          	ld	a,#114
4997  0005 cd0000        	call	_IIC_Send_Byte
4999                     ; 1203 	if(IIC_Wait_Ack())	//等待应答
5001  0008 cd0000        	call	_IIC_Wait_Ack
5003  000b 4d            	tnz	a
5004  000c 2705          	jreq	L7251
5005                     ; 1205 		IIC_Stop();		 
5007  000e cd0000        	call	_IIC_Stop
5009                     ; 1206 		return FALSE;		
5011  0011 4f            	clr	a
5014  0012 81            	ret
5015  0013               L7251:
5016                     ; 1221 }
5019  0013 81            	ret
5073                     ; 1233 bool wireReadDataByte(u8 reg,u8 *val)
5073                     ; 1234 {
5074                     .text:	section	.text,new
5075  0000               _wireReadDataByte:
5077  0000 88            	push	a
5078       00000000      OFST:	set	0
5081  0001 2003          	jra	L3551
5082  0003               L1551:
5083                     ; 1238 		IIC_Init(); 
5085  0003 cd0000        	call	_IIC_Init
5087  0006               L3551:
5088                     ; 1236 	while(!I2CCheckERREN())
5090  0006 cd0000        	call	_I2CCheckERREN
5092  0009 4d            	tnz	a
5093  000a 27f7          	jreq	L1551
5094                     ; 1240 	if(I2C_GetFlagStatus(I2C_FLAG_BUSBUSY)) 
5096  000c ae3002        	ldw	x,#12290
5097  000f cd0000        	call	_I2C_GetFlagStatus
5099  0012 4d            	tnz	a
5100  0013 270c          	jreq	L7551
5101                     ; 1242 	 I2C_Cmd(DISABLE); 
5103  0015 4f            	clr	a
5104  0016 cd0000        	call	_I2C_Cmd
5106                     ; 1243 	 I2CSoftStop(); 
5108  0019 cd0000        	call	_I2CSoftStop
5110                     ; 1244 	 I2C_Cmd(ENABLE); 
5112  001c a601          	ld	a,#1
5113  001e cd0000        	call	_I2C_Cmd
5115  0021               L7551:
5116                     ; 1246 	if(!I2C_GetFlagStatus(I2C_FLAG_BUSBUSY))
5118  0021 ae3002        	ldw	x,#12290
5119  0024 cd0000        	call	_I2C_GetFlagStatus
5121  0027 4d            	tnz	a
5122  0028 2665          	jrne	L1651
5123                     ; 1248 		I2C_GenerateSTART(ENABLE);
5125  002a a601          	ld	a,#1
5126  002c cd0000        	call	_I2C_GenerateSTART
5129  002f               L5651:
5130                     ; 1249 		while(!I2C_GetFlagStatus(I2C_FLAG_STARTDETECTION));
5132  002f ae1401        	ldw	x,#5121
5133  0032 cd0000        	call	_I2C_GetFlagStatus
5135  0035 4d            	tnz	a
5136  0036 27f7          	jreq	L5651
5137                     ; 1250 		I2C_Send7bitAddress((APDS9960_I2C_ADDR<<1), I2C_DIRECTION_TX);
5139  0038 5f            	clrw	x
5140  0039 a672          	ld	a,#114
5141  003b 95            	ld	xh,a
5142  003c cd0000        	call	_I2C_Send7bitAddress
5145  003f               L3751:
5146                     ; 1251 		while(!I2C_GetFlagStatus(I2C_FLAG_ADDRESSSENTMATCHED));
5148  003f ae1302        	ldw	x,#4866
5149  0042 cd0000        	call	_I2C_GetFlagStatus
5151  0045 4d            	tnz	a
5152  0046 27f7          	jreq	L3751
5153                     ; 1253 		I2C_SendData(reg);
5155  0048 7b01          	ld	a,(OFST+1,sp)
5156  004a cd0000        	call	_I2C_SendData
5159  004d               L1061:
5160                     ; 1254 		while(!I2C_GetFlagStatus(I2C_FLAG_TXEMPTY));
5162  004d ae1080        	ldw	x,#4224
5163  0050 cd0000        	call	_I2C_GetFlagStatus
5165  0053 4d            	tnz	a
5166  0054 27f7          	jreq	L1061
5167                     ; 1256 		I2C_GenerateSTART(ENABLE);
5169  0056 a601          	ld	a,#1
5170  0058 cd0000        	call	_I2C_GenerateSTART
5173  005b               L7061:
5174                     ; 1257 		while(!I2C_GetFlagStatus(I2C_FLAG_STARTDETECTION));
5176  005b ae1401        	ldw	x,#5121
5177  005e cd0000        	call	_I2C_GetFlagStatus
5179  0061 4d            	tnz	a
5180  0062 27f7          	jreq	L7061
5181                     ; 1258 		I2C_Send7bitAddress((APDS9960_I2C_ADDR<<1), I2C_DIRECTION_RX);
5183  0064 ae0001        	ldw	x,#1
5184  0067 a672          	ld	a,#114
5185  0069 95            	ld	xh,a
5186  006a cd0000        	call	_I2C_Send7bitAddress
5189  006d               L5161:
5190                     ; 1259 		while(!I2C_GetFlagStatus(I2C_FLAG_ADDRESSSENTMATCHED));
5192  006d ae1302        	ldw	x,#4866
5193  0070 cd0000        	call	_I2C_GetFlagStatus
5195  0073 4d            	tnz	a
5196  0074 27f7          	jreq	L5161
5198  0076               L3261:
5199                     ; 1261 		while(!I2C_GetFlagStatus(I2C_FLAG_RXNOTEMPTY));
5201  0076 ae1040        	ldw	x,#4160
5202  0079 cd0000        	call	_I2C_GetFlagStatus
5204  007c 4d            	tnz	a
5205  007d 27f7          	jreq	L3261
5206                     ; 1262 		I2C_AcknowledgeConfig(I2C_ACK_CURR);
5208  007f a601          	ld	a,#1
5209  0081 cd0000        	call	_I2C_AcknowledgeConfig
5211                     ; 1263 		*val=I2C_ReceiveData();   
5213  0084 cd0000        	call	_I2C_ReceiveData
5215  0087 1e04          	ldw	x,(OFST+4,sp)
5216  0089 f7            	ld	(x),a
5217                     ; 1264 		I2C_GenerateSTOP(ENABLE);
5219  008a a601          	ld	a,#1
5220  008c cd0000        	call	_I2C_GenerateSTOP
5222  008f               L1651:
5223                     ; 1359 }
5226  008f 84            	pop	a
5227  0090 81            	ret
5266                     ; 1369 int wireReadDataBlock( u8 reg,u8 *val, unsigned int len)
5266                     ; 1370 {
5267                     .text:	section	.text,new
5268  0000               _wireReadDataBlock:
5270  0000 88            	push	a
5271       00000001      OFST:	set	1
5274                     ; 1371 	unsigned char i = 0;
5276  0001 0f01          	clr	(OFST+0,sp)
5277                     ; 1416 	  return i;
5279  0003 5f            	clrw	x
5282  0004 84            	pop	a
5283  0005 81            	ret
5296                     	xdef	_abs
5297                     	xdef	_Wire_begin_
5298                     	xdef	_I2CSoftStop
5299                     	xdef	_I2CCheckERREN
5300                     	xdef	_wireReadDataBlock
5301                     	xdef	_wireReadDataByte
5302                     	xdef	_wireWriteDataByte
5303                     	xdef	_setGestureMode
5304                     	xdef	_setGestureWaitTime
5305                     	xdef	_setGestureExitThresh
5306                     	xdef	_setGestureEnterThresh
5307                     	xdef	_setLEDBoost
5308                     	xdef	_decodeGesture
5309                     	xdef	_processGestureData
5310                     	xdef	_resetGestureParameters
5311                     	xdef	_readGesture
5312                     	xdef	_isGestureAvailable
5313                     	xdef	_setGestureIntEnable
5314                     	xdef	_setGestureGain
5315                     	xdef	_setGestureLEDDrive
5316                     	xdef	_enableGestureSensor
5317                     	xdef	_disablePower
5318                     	xdef	_enablePower
5319                     	xdef	_setMode
5320                     	xdef	_getMode
5321                     	xdef	_SparkFun_APDS9960_init
5322                     	xdef	_SparkFun_APDS9960
5323                     	xdef	_IIC_Read_Byte
5324                     	xdef	_IIC_Send_Byte
5325                     	xdef	_IIC_NAck
5326                     	xdef	_IIC_Ack
5327                     	xdef	_IIC_Wait_Ack
5328                     	xdef	_IIC_Stop
5329                     	xdef	_IIC_Start
5330                     	xdef	_IIC_Init
5331                     	xdef	_delay_ms
5332                     	xdef	_IIC_Delay
5333                     	switch	.bss
5334  0000               _gesture_motion_:
5335  0000 0000          	ds.b	2
5336                     	xdef	_gesture_motion_
5337  0002               _gesture_state_:
5338  0002 0000          	ds.b	2
5339                     	xdef	_gesture_state_
5340  0004               _gesture_far_count_:
5341  0004 0000          	ds.b	2
5342                     	xdef	_gesture_far_count_
5343  0006               _gesture_near_count_:
5344  0006 0000          	ds.b	2
5345                     	xdef	_gesture_near_count_
5346  0008               _gesture_lr_count_:
5347  0008 0000          	ds.b	2
5348                     	xdef	_gesture_lr_count_
5349  000a               _gesture_ud_count_:
5350  000a 0000          	ds.b	2
5351                     	xdef	_gesture_ud_count_
5352  000c               _gesture_lr_delta_:
5353  000c 0000          	ds.b	2
5354                     	xdef	_gesture_lr_delta_
5355  000e               _gesture_ud_delta_:
5356  000e 0000          	ds.b	2
5357                     	xdef	_gesture_ud_delta_
5358  0010               _gesture_data_:
5359  0010 000000000000  	ds.b	132
5360                     	xdef	_gesture_data_
5361                     	xref	_I2C_ClearFlag
5362                     	xref	_I2C_GetFlagStatus
5363                     	xref	_I2C_SendData
5364                     	xref	_I2C_Send7bitAddress
5365                     	xref	_I2C_ReceiveData
5366                     	xref	_I2C_AcknowledgeConfig
5367                     	xref	_I2C_GenerateSTOP
5368                     	xref	_I2C_GenerateSTART
5369                     	xref	_I2C_Cmd
5370                     	xref	_GPIO_WriteLow
5371                     	xref	_GPIO_WriteHigh
5372                     	xref	_GPIO_Init
5373                     	xref.b	c_x
5393                     	xref	c_idiv
5394                     	xref	c_imul
5395                     	xref	c_lcmp
5396                     	xref	c_uitolx
5397                     	end
