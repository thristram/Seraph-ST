   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
1143                     ; 26 u8 random(u8 xxx)  
1143                     ; 27 {  
1145                     .text:	section	.text,new
1146  0000               _random:
1148  0000 88            	push	a
1149  0001 89            	pushw	x
1150       00000002      OFST:	set	2
1153                     ; 29   for(iii=0;iii<xxx;iii++)  
1155  0002 0f02          	clr	(OFST+0,sp)
1157  0004 2011          	jra	L165
1158  0006               L555:
1159                     ; 31     value = rand() % (MAX + 1- MIN) + MIN; //获取一个随机数1~255
1161  0006 cd0000        	call	_rand
1163  0009 90ae00ff      	ldw	y,#255
1164  000d cd0000        	call	c_idiv
1166  0010 51            	exgw	x,y
1167  0011 9f            	ld	a,xl
1168  0012 4c            	inc	a
1169  0013 6b01          	ld	(OFST-1,sp),a
1170                     ; 29   for(iii=0;iii<xxx;iii++)  
1172  0015 0c02          	inc	(OFST+0,sp)
1173  0017               L165:
1176  0017 7b02          	ld	a,(OFST+0,sp)
1177  0019 1103          	cp	a,(OFST+1,sp)
1178  001b 25e9          	jrult	L555
1179                     ; 33   return value;  
1181  001d 7b01          	ld	a,(OFST-1,sp)
1184  001f 5b03          	addw	sp,#3
1185  0021 81            	ret
1212                     ; 42 void Init_uart2(void)
1212                     ; 43 {
1213                     .text:	section	.text,new
1214  0000               _Init_uart2:
1218                     ; 44 	UART2_DeInit();
1220  0000 cd0000        	call	_UART2_DeInit
1222                     ; 46 	UART2_Init((u32)57600,UART2_WORDLENGTH_8D,UART2_STOPBITS_1,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,	UART2_MODE_TXRX_ENABLE);
1224  0003 4b0c          	push	#12
1225  0005 4b80          	push	#128
1226  0007 4b00          	push	#0
1227  0009 4b00          	push	#0
1228  000b 4b00          	push	#0
1229  000d aee100        	ldw	x,#57600
1230  0010 89            	pushw	x
1231  0011 ae0000        	ldw	x,#0
1232  0014 89            	pushw	x
1233  0015 cd0000        	call	_UART2_Init
1235  0018 5b09          	addw	sp,#9
1236                     ; 47 	UART2_ITConfig(UART2_IT_TC,ENABLE);//发送完成中断
1238  001a 4b01          	push	#1
1239  001c ae0266        	ldw	x,#614
1240  001f cd0000        	call	_UART2_ITConfig
1242  0022 84            	pop	a
1243                     ; 48 	UART2_ITConfig(UART2_IT_RXNE_OR,ENABLE);//接收非空中断
1245  0023 4b01          	push	#1
1246  0025 ae0205        	ldw	x,#517
1247  0028 cd0000        	call	_UART2_ITConfig
1249  002b 84            	pop	a
1250                     ; 49 	UART2_Cmd(ENABLE);//启用uart1接口
1252  002c a601          	ld	a,#1
1253  002e cd0000        	call	_UART2_Cmd
1255                     ; 50 }
1258  0031 81            	ret
1284                     ; 58 void UART2_Send_Data_Init(void)
1284                     ; 59 {
1285                     .text:	section	.text,new
1286  0000               _UART2_Send_Data_Init:
1290                     ; 60 	send_buf[0] = 0xAA;
1292  0000 35aa003c      	mov	_send_buf,#170
1293                     ; 61 	send_buf[1] = 0xAA;
1295  0004 35aa003d      	mov	_send_buf+1,#170
1296                     ; 62 	send_buf[2] = 0x11;
1298  0008 3511003e      	mov	_send_buf+2,#17
1299                     ; 63 	send_buf[3] = 0x22;
1301  000c 3522003f      	mov	_send_buf+3,#34
1302                     ; 64 	send_buf[4] = 13;	//帧头及校验码不计入内
1304  0010 350d0040      	mov	_send_buf+4,#13
1305                     ; 65 	send_buf[5] = 0x01;
1307  0014 35010041      	mov	_send_buf+5,#1
1308                     ; 66 	send_buf[6] = 0x02;
1310  0018 35020042      	mov	_send_buf+6,#2
1311                     ; 67 	send_buf[7] = 0x03;
1313  001c 35030043      	mov	_send_buf+7,#3
1314                     ; 68 	send_buf[8] = 0x04;
1316  0020 35040044      	mov	_send_buf+8,#4
1317                     ; 69 	send_buf[9] = 0x05;
1319  0024 35050045      	mov	_send_buf+9,#5
1320                     ; 70 	send_buf[10] = 0x06;
1322  0028 35060046      	mov	_send_buf+10,#6
1323                     ; 71 	send_buf[11] = 0x07;
1325  002c 35070047      	mov	_send_buf+11,#7
1326                     ; 72 	send_buf[12] = 0x08;
1328  0030 35080048      	mov	_send_buf+12,#8
1329                     ; 73 	send_buf[13] = 0x09;
1331  0034 35090049      	mov	_send_buf+13,#9
1332                     ; 74 	send_buf[14] = 0x0A;
1334  0038 350a004a      	mov	_send_buf+14,#10
1335                     ; 75 	send_buf[15] = Check_Sum(send_buf,15);
1337  003c 4b0f          	push	#15
1338  003e ae003c        	ldw	x,#_send_buf
1339  0041 cd0000        	call	_Check_Sum
1341  0044 5b01          	addw	sp,#1
1342  0046 c7004b        	ld	_send_buf+15,a
1343                     ; 77 }
1346  0049 81            	ret
1372                     ; 84 void UART2_Send_Data_Start(void)
1372                     ; 85 {
1373                     .text:	section	.text,new
1374  0000               _UART2_Send_Data_Start:
1378                     ; 86 	UART2->DR = send_buf[0];
1380  0000 55003c5241    	mov	21057,_send_buf
1381                     ; 87 	send_count = 1;
1383  0005 3501005f      	mov	_send_count,#1
1384                     ; 88 }
1387  0009 81            	ret
1420                     ; 91 void clear_sicp_buf(void)
1420                     ; 92 {
1421                     .text:	section	.text,new
1422  0000               _clear_sicp_buf:
1424  0000 88            	push	a
1425       00000001      OFST:	set	1
1428                     ; 94 	for (i=0;i<30;i++)
1430  0001 0f01          	clr	(OFST+0,sp)
1431  0003               L136:
1432                     ; 96 		sicp_buf[i] = 0;
1434  0003 7b01          	ld	a,(OFST+0,sp)
1435  0005 5f            	clrw	x
1436  0006 97            	ld	xl,a
1437  0007 724f0000      	clr	(_sicp_buf,x)
1438                     ; 94 	for (i=0;i<30;i++)
1440  000b 0c01          	inc	(OFST+0,sp)
1443  000d 7b01          	ld	a,(OFST+0,sp)
1444  000f a11e          	cp	a,#30
1445  0011 25f0          	jrult	L136
1446                     ; 98 }
1449  0013 84            	pop	a
1450  0014 81            	ret
1483                     ; 101 void clear_send_buf(void)
1483                     ; 102 {
1484                     .text:	section	.text,new
1485  0000               _clear_send_buf:
1487  0000 88            	push	a
1488       00000001      OFST:	set	1
1491                     ; 104 	for (i=0;i<30;i++)
1493  0001 0f01          	clr	(OFST+0,sp)
1494  0003               L356:
1495                     ; 106 		send_buf[i] = 0;
1497  0003 7b01          	ld	a,(OFST+0,sp)
1498  0005 5f            	clrw	x
1499  0006 97            	ld	xl,a
1500  0007 724f003c      	clr	(_send_buf,x)
1501                     ; 104 	for (i=0;i<30;i++)
1503  000b 0c01          	inc	(OFST+0,sp)
1506  000d 7b01          	ld	a,(OFST+0,sp)
1507  000f a11e          	cp	a,#30
1508  0011 25f0          	jrult	L356
1509                     ; 108 }
1512  0013 84            	pop	a
1513  0014 81            	ret
1539                     ; 116 @interrupt void UART2_TX_ISR(void)
1539                     ; 117 {
1540                     .text:	section	.text,new
1541  0000               _UART2_TX_ISR:
1544  0000 be00          	ldw	x,c_x
1545  0002 89            	pushw	x
1548                     ; 121 	UART2->SR &= ~0x40;//清除发送完成标志位
1550  0003 721d5240      	bres	21056,#6
1551                     ; 122 	if (send_count < send_buf[5]+3)
1553  0007 9c            	rvf
1554  0008 c6005f        	ld	a,_send_count
1555  000b 5f            	clrw	x
1556  000c 97            	ld	xl,a
1557  000d c60041        	ld	a,_send_buf+5
1558  0010 905f          	clrw	y
1559  0012 9097          	ld	yl,a
1560  0014 72a90003      	addw	y,#3
1561  0018 bf01          	ldw	c_x+1,x
1562  001a 90b301        	cpw	y,c_x+1
1563  001d 2d11          	jrsle	L176
1564                     ; 124 		UART2->DR = send_buf[send_count];
1566  001f c6005f        	ld	a,_send_count
1567  0022 5f            	clrw	x
1568  0023 97            	ld	xl,a
1569  0024 d6003c        	ld	a,(_send_buf,x)
1570  0027 c75241        	ld	21057,a
1571                     ; 125 		send_count++;
1573  002a 725c005f      	inc	_send_count
1575  002e 2008          	jra	L376
1576  0030               L176:
1577                     ; 129 		send_count = 0;
1579  0030 725f005f      	clr	_send_count
1580                     ; 130 		rev_count = 0;
1582  0034 725f005e      	clr	_rev_count
1583  0038               L376:
1584                     ; 132 }
1587  0038 85            	popw	x
1588  0039 bf00          	ldw	c_x,x
1589  003b 80            	iret
1613                     ; 140 @interrupt void UART2_RX_ISR(void)
1613                     ; 141 {
1614                     .text:	section	.text,new
1615  0000               _UART2_RX_ISR:
1618  0000 3b0002        	push	c_x+2
1619  0003 be00          	ldw	x,c_x
1620  0005 89            	pushw	x
1621  0006 3b0002        	push	c_y+2
1622  0009 be00          	ldw	x,c_y
1623  000b 89            	pushw	x
1626                     ; 142 	rev_deal();
1628  000c cd0000        	call	_rev_deal
1630                     ; 143 }
1633  000f 85            	popw	x
1634  0010 bf00          	ldw	c_y,x
1635  0012 320002        	pop	c_y+2
1636  0015 85            	popw	x
1637  0016 bf00          	ldw	c_x,x
1638  0018 320002        	pop	c_x+2
1639  001b 80            	iret
1695                     ; 151 u8 Check_Sum(u8 *buf,u8 length)
1695                     ; 152 {
1696                     .text:	section	.text,new
1697  0000               _Check_Sum:
1699  0000 89            	pushw	x
1700  0001 89            	pushw	x
1701       00000002      OFST:	set	2
1704                     ; 154 	u8 result = *buf++;
1706  0002 1e03          	ldw	x,(OFST+1,sp)
1707  0004 1c0001        	addw	x,#1
1708  0007 1f03          	ldw	(OFST+1,sp),x
1709  0009 1d0001        	subw	x,#1
1710  000c f6            	ld	a,(x)
1711  000d 6b01          	ld	(OFST-1,sp),a
1712                     ; 155 	for(i = 1;i < length;i++)
1714  000f a601          	ld	a,#1
1715  0011 6b02          	ld	(OFST+0,sp),a
1717  0013 2011          	jra	L537
1718  0015               L137:
1719                     ; 157 		result ^= *buf++;
1721  0015 1e03          	ldw	x,(OFST+1,sp)
1722  0017 1c0001        	addw	x,#1
1723  001a 1f03          	ldw	(OFST+1,sp),x
1724  001c 1d0001        	subw	x,#1
1725  001f 7b01          	ld	a,(OFST-1,sp)
1726  0021 f8            	xor	a,	(x)
1727  0022 6b01          	ld	(OFST-1,sp),a
1728                     ; 155 	for(i = 1;i < length;i++)
1730  0024 0c02          	inc	(OFST+0,sp)
1731  0026               L537:
1734  0026 7b02          	ld	a,(OFST+0,sp)
1735  0028 1107          	cp	a,(OFST+5,sp)
1736  002a 25e9          	jrult	L137
1737                     ; 159 	return result;
1739  002c 7b01          	ld	a,(OFST-1,sp)
1742  002e 5b04          	addw	sp,#4
1743  0030 81            	ret
1801                     ; 167 void rev_deal(void)
1801                     ; 168 {
1802                     .text:	section	.text,new
1803  0000               _rev_deal:
1805  0000 89            	pushw	x
1806       00000002      OFST:	set	2
1809                     ; 171 	temp = (u8)UART2->DR;
1811  0001 c65241        	ld	a,21057
1812  0004 6b02          	ld	(OFST+0,sp),a
1813                     ; 172 	rev_buf[rev_count] = temp;
1815  0006 c6005e        	ld	a,_rev_count
1816  0009 5f            	clrw	x
1817  000a 97            	ld	xl,a
1818  000b 7b02          	ld	a,(OFST+0,sp)
1819  000d d7001e        	ld	(_rev_buf,x),a
1820                     ; 173 	rev_count++;
1822  0010 725c005e      	inc	_rev_count
1823                     ; 174 	switch(rev_count)
1825  0014 c6005e        	ld	a,_rev_count
1827                     ; 233 			break;
1828  0017 4a            	dec	a
1829  0018 2722          	jreq	L147
1830  001a 4a            	dec	a
1831  001b 2739          	jreq	L347
1832  001d 4a            	dec	a
1833  001e 2603          	jrne	L03
1834  0020 cc012b        	jp	L1001
1835  0023               L03:
1836  0023 4a            	dec	a
1837  0024 2603          	jrne	L23
1838  0026 cc012b        	jp	L1001
1839  0029               L23:
1840  0029 4a            	dec	a
1841  002a 2603          	jrne	L43
1842  002c cc012b        	jp	L1001
1843  002f               L43:
1844  002f               L357:
1845                     ; 191 		default:
1845                     ; 192 			if (rev_count > 30)//防止接收错误后溢出
1847  002f c6005e        	ld	a,_rev_count
1848  0032 a11f          	cp	a,#31
1849  0034 2543          	jrult	L7001
1850                     ; 194 				rev_count = 0;
1852  0036 725f005e      	clr	_rev_count
1853  003a 203d          	jra	L7001
1854  003c               L147:
1855                     ; 176 		case 1:
1855                     ; 177 			if ((temp != 0xEE) && (temp != 0xDD))	rev_count = 0;
1857  003c 7b02          	ld	a,(OFST+0,sp)
1858  003e a1ee          	cp	a,#238
1859  0040 2603          	jrne	L63
1860  0042 cc012b        	jp	L1001
1861  0045               L63:
1863  0045 7b02          	ld	a,(OFST+0,sp)
1864  0047 a1dd          	cp	a,#221
1865  0049 2603          	jrne	L04
1866  004b cc012b        	jp	L1001
1867  004e               L04:
1870  004e 725f005e      	clr	_rev_count
1871  0052 ac2b012b      	jpf	L1001
1872  0056               L347:
1873                     ; 179 		case 2:
1873                     ; 180 			if ((temp != 0xEE) && (temp != 0xDD) && (temp != 0xAA)) rev_count = 0;
1875  0056 7b02          	ld	a,(OFST+0,sp)
1876  0058 a1ee          	cp	a,#238
1877  005a 2603          	jrne	L24
1878  005c cc012b        	jp	L1001
1879  005f               L24:
1881  005f 7b02          	ld	a,(OFST+0,sp)
1882  0061 a1dd          	cp	a,#221
1883  0063 2603          	jrne	L44
1884  0065 cc012b        	jp	L1001
1885  0068               L44:
1887  0068 7b02          	ld	a,(OFST+0,sp)
1888  006a a1aa          	cp	a,#170
1889  006c 2603          	jrne	L64
1890  006e cc012b        	jp	L1001
1891  0071               L64:
1894  0071 725f005e      	clr	_rev_count
1895  0075 ac2b012b      	jpf	L1001
1896  0079               L7001:
1897                     ; 196 			if ((rev_buf[0] == 0xEE)&&((rev_buf[1] == 0xEE) ||(rev_buf[1] == 0xAA)))
1899  0079 c6001e        	ld	a,_rev_buf
1900  007c a1ee          	cp	a,#238
1901  007e 2663          	jrne	L1101
1903  0080 c6001f        	ld	a,_rev_buf+1
1904  0083 a1ee          	cp	a,#238
1905  0085 2707          	jreq	L3101
1907  0087 c6001f        	ld	a,_rev_buf+1
1908  008a a1aa          	cp	a,#170
1909  008c 2655          	jrne	L1101
1910  008e               L3101:
1911                     ; 198 				if (rev_count > rev_buf[5] + 2)//接收数据完成
1913  008e 9c            	rvf
1914  008f c6005e        	ld	a,_rev_count
1915  0092 5f            	clrw	x
1916  0093 97            	ld	xl,a
1917  0094 c60023        	ld	a,_rev_buf+5
1918  0097 905f          	clrw	y
1919  0099 9097          	ld	yl,a
1920  009b 905c          	incw	y
1921  009d 905c          	incw	y
1922  009f bf01          	ldw	c_x+1,x
1923  00a1 90b301        	cpw	y,c_x+1
1924  00a4 2ec8          	jrsge	L1001
1925                     ; 200 					rev_count = 0;
1927  00a6 725f005e      	clr	_rev_count
1928                     ; 201 					check_sum = Check_Sum((rev_buf+2),rev_buf[5]);
1930  00aa 3b0023        	push	_rev_buf+5
1931  00ad ae0020        	ldw	x,#_rev_buf+2
1932  00b0 cd0000        	call	_Check_Sum
1934  00b3 5b01          	addw	sp,#1
1935  00b5 6b02          	ld	(OFST+0,sp),a
1936                     ; 203 					if (check_sum == rev_buf[rev_buf[5] + 2])//校验正确	
1938  00b7 c60023        	ld	a,_rev_buf+5
1939  00ba 5f            	clrw	x
1940  00bb 97            	ld	xl,a
1941  00bc d60020        	ld	a,(_rev_buf+2,x)
1942  00bf 1102          	cp	a,(OFST+0,sp)
1943  00c1 261a          	jrne	L7101
1944                     ; 205 						rev_success = 1;
1946  00c3 721000c9      	bset	_UART1Flag1_,#0
1947                     ; 206 						for (i = 0;i < 30;i++)
1949  00c7 0f02          	clr	(OFST+0,sp)
1950  00c9               L1201:
1951                     ; 208 							sicp_buf[i] = rev_buf[i];
1953  00c9 7b02          	ld	a,(OFST+0,sp)
1954  00cb 5f            	clrw	x
1955  00cc 97            	ld	xl,a
1956  00cd d6001e        	ld	a,(_rev_buf,x)
1957  00d0 d70000        	ld	(_sicp_buf,x),a
1958                     ; 206 						for (i = 0;i < 30;i++)
1960  00d3 0c02          	inc	(OFST+0,sp)
1963  00d5 7b02          	ld	a,(OFST+0,sp)
1964  00d7 a11e          	cp	a,#30
1965  00d9 25ee          	jrult	L1201
1967  00db 204e          	jra	L1001
1968  00dd               L7101:
1969                     ; 213 						rev_count = 0;
1971  00dd 725f005e      	clr	_rev_count
1972  00e1 2048          	jra	L1001
1973  00e3               L1101:
1974                     ; 217 			else if((rev_buf[0] == 0xDD)&&(rev_buf[1] == 0xDD))
1976  00e3 c6001e        	ld	a,_rev_buf
1977  00e6 a1dd          	cp	a,#221
1978  00e8 263d          	jrne	L3301
1980  00ea c6001f        	ld	a,_rev_buf+1
1981  00ed a1dd          	cp	a,#221
1982  00ef 2636          	jrne	L3301
1983                     ; 219 				if (rev_count > rev_buf[3] + 2)//接收数据完成
1985  00f1 9c            	rvf
1986  00f2 c6005e        	ld	a,_rev_count
1987  00f5 5f            	clrw	x
1988  00f6 97            	ld	xl,a
1989  00f7 c60021        	ld	a,_rev_buf+3
1990  00fa 905f          	clrw	y
1991  00fc 9097          	ld	yl,a
1992  00fe 905c          	incw	y
1993  0100 905c          	incw	y
1994  0102 bf01          	ldw	c_x+1,x
1995  0104 90b301        	cpw	y,c_x+1
1996  0107 2e22          	jrsge	L1001
1997                     ; 221 					rev_count = 0;
1999  0109 725f005e      	clr	_rev_count
2000                     ; 222 					rev_success = 1;
2002  010d 721000c9      	bset	_UART1Flag1_,#0
2003                     ; 223 					for (i = 0;i < 30;i++)
2005  0111 0f02          	clr	(OFST+0,sp)
2006  0113               L7301:
2007                     ; 225 						sicp_buf[i] = rev_buf[i];
2009  0113 7b02          	ld	a,(OFST+0,sp)
2010  0115 5f            	clrw	x
2011  0116 97            	ld	xl,a
2012  0117 d6001e        	ld	a,(_rev_buf,x)
2013  011a d70000        	ld	(_sicp_buf,x),a
2014                     ; 223 					for (i = 0;i < 30;i++)
2016  011d 0c02          	inc	(OFST+0,sp)
2019  011f 7b02          	ld	a,(OFST+0,sp)
2020  0121 a11e          	cp	a,#30
2021  0123 25ee          	jrult	L7301
2022  0125 2004          	jra	L1001
2023  0127               L3301:
2024                     ; 231 				rev_count = 0;
2026  0127 725f005e      	clr	_rev_count
2027  012b               L1001:
2028                     ; 235 	if (UART2->SR & 0x20) //|| (UART2->SR & UART2_SR_OR))
2030  012b c65240        	ld	a,21056
2031  012e a520          	bcp	a,#32
2032  0130 2707          	jreq	L7401
2033                     ; 237 		temp2 = UART2->DR;
2035  0132 7b01          	ld	a,(OFST-1,sp)
2036  0134 97            	ld	xl,a
2037  0135 c65241        	ld	a,21057
2038  0138 97            	ld	xl,a
2039  0139               L7401:
2040                     ; 250 }
2043  0139 85            	popw	x
2044  013a 81            	ret
2069                     ; 258 void gest_confirm(void)
2069                     ; 259 {
2070                     .text:	section	.text,new
2071  0000               _gest_confirm:
2075                     ; 260 	if ((st1.st_ges_H == st1.st_ges1_ctrl_H) && (st1.st_ges_L == st1.st_ges1_ctrl_L))
2077  0000 c60077        	ld	a,_st1
2078  0003 c10093        	cp	a,_st1+28
2079  0006 260e          	jrne	L1601
2081  0008 c60078        	ld	a,_st1+1
2082  000b c10094        	cp	a,_st1+29
2083  000e 2606          	jrne	L1601
2084                     ; 262 		gest1_confirm = 1;
2086  0010 721400c8      	bset	_UART1Flag2_,#2
2088  0014 2004          	jra	L3601
2089  0016               L1601:
2090                     ; 266 		gest1_confirm = 0;
2092  0016 721500c8      	bres	_UART1Flag2_,#2
2093  001a               L3601:
2094                     ; 268 	if ((st1.st_ges_H == st1.st_ges2_ctrl_H) && (st1.st_ges_L == st1.st_ges2_ctrl_L))
2096  001a c60077        	ld	a,_st1
2097  001d c10098        	cp	a,_st1+33
2098  0020 260e          	jrne	L5601
2100  0022 c60078        	ld	a,_st1+1
2101  0025 c10099        	cp	a,_st1+34
2102  0028 2606          	jrne	L5601
2103                     ; 270 		gest2_confirm = 1;
2105  002a 721600c8      	bset	_UART1Flag2_,#3
2107  002e 2004          	jra	L7601
2108  0030               L5601:
2109                     ; 274 		gest2_confirm = 0;
2111  0030 721700c8      	bres	_UART1Flag2_,#3
2112  0034               L7601:
2113                     ; 276 	if ((st1.st_ges_H == st1.st_ges3_ctrl_H) && (st1.st_ges_L == st1.st_ges3_ctrl_L))
2115  0034 c60077        	ld	a,_st1
2116  0037 c1009d        	cp	a,_st1+38
2117  003a 260e          	jrne	L1701
2119  003c c60078        	ld	a,_st1+1
2120  003f c1009e        	cp	a,_st1+39
2121  0042 2606          	jrne	L1701
2122                     ; 278 		gest3_confirm = 1;
2124  0044 721800c8      	bset	_UART1Flag2_,#4
2126  0048 2004          	jra	L3701
2127  004a               L1701:
2128                     ; 282 		gest3_confirm = 0;
2130  004a 721900c8      	bres	_UART1Flag2_,#4
2131  004e               L3701:
2132                     ; 284 	if((st1.st_ges_H == st1.st_ges4_ctrl_H) && (st1.st_ges_L == st1.st_ges4_ctrl_L))
2134  004e c60077        	ld	a,_st1
2135  0051 c100a2        	cp	a,_st1+43
2136  0054 260e          	jrne	L5701
2138  0056 c60078        	ld	a,_st1+1
2139  0059 c100a3        	cp	a,_st1+44
2140  005c 2606          	jrne	L5701
2141                     ; 286 		gest4_confirm = 1;
2143  005e 721a00c8      	bset	_UART1Flag2_,#5
2145  0062 2004          	jra	L7701
2146  0064               L5701:
2147                     ; 290 		gest4_confirm = 0;
2149  0064 721b00c8      	bres	_UART1Flag2_,#5
2150  0068               L7701:
2151                     ; 292 }
2154  0068 81            	ret
2179                     ; 300 void pad_confirm(void)
2179                     ; 301 {
2180                     .text:	section	.text,new
2181  0000               _pad_confirm:
2185                     ; 302 	if(st_pad1_ctrl)
2187  0000 c600c7        	ld	a,_UART1Flag3_
2188  0003 a502          	bcp	a,#2
2189  0005 2724          	jreq	L1111
2190                     ; 304 		if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
2192  0007 725d0084      	tnz	_st1+13
2193  000b 2716          	jreq	L3111
2195  000d 725d0085      	tnz	_st1+14
2196  0011 2710          	jreq	L3111
2198  0013 725d0086      	tnz	_st1+15
2199  0017 270a          	jreq	L3111
2200                     ; 306 			st_pad1_confirm = 1;
2202  0019 721800c7      	bset	_UART1Flag3_,#4
2203                     ; 307 			st1.st_ctrl_address = 0x01;
2205  001d 3501007a      	mov	_st1+3,#1
2207  0021 2008          	jra	L1111
2208  0023               L3111:
2209                     ; 311 			st_pad1_confirm = 0;
2211  0023 721900c7      	bres	_UART1Flag3_,#4
2212                     ; 312 			st1.st_ctrl_address = 0x00;
2214  0027 725f007a      	clr	_st1+3
2215  002b               L1111:
2216                     ; 316 	if(st_pad2_ctrl)
2218  002b c600c7        	ld	a,_UART1Flag3_
2219  002e a504          	bcp	a,#4
2220  0030 2724          	jreq	L7111
2221                     ; 318 		if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
2223  0032 725d0089      	tnz	_st1+18
2224  0036 2716          	jreq	L1211
2226  0038 725d008a      	tnz	_st1+19
2227  003c 2710          	jreq	L1211
2229  003e 725d008b      	tnz	_st1+20
2230  0042 270a          	jreq	L1211
2231                     ; 320 			st_pad2_confirm = 1;
2233  0044 721a00c7      	bset	_UART1Flag3_,#5
2234                     ; 321 			st1.st_ctrl_address = 0x02;
2236  0048 3502007a      	mov	_st1+3,#2
2238  004c 2008          	jra	L7111
2239  004e               L1211:
2240                     ; 325 			st_pad2_confirm = 0;
2242  004e 721b00c7      	bres	_UART1Flag3_,#5
2243                     ; 326 			st1.st_ctrl_address = 0x00;
2245  0052 725f007a      	clr	_st1+3
2246  0056               L7111:
2247                     ; 329 	if(st_pad3_ctrl)
2249  0056 c600c7        	ld	a,_UART1Flag3_
2250  0059 a508          	bcp	a,#8
2251  005b 2724          	jreq	L5211
2252                     ; 331 		if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
2254  005d 725d008e      	tnz	_st1+23
2255  0061 2716          	jreq	L7211
2257  0063 725d008f      	tnz	_st1+24
2258  0067 2710          	jreq	L7211
2260  0069 725d0090      	tnz	_st1+25
2261  006d 270a          	jreq	L7211
2262                     ; 333 			st_pad3_confirm = 1;
2264  006f 721c00c7      	bset	_UART1Flag3_,#6
2265                     ; 334 			st1.st_ctrl_address = 0x04;
2267  0073 3504007a      	mov	_st1+3,#4
2269  0077 2008          	jra	L5211
2270  0079               L7211:
2271                     ; 338 			st_pad3_confirm = 0;
2273  0079 721d00c7      	bres	_UART1Flag3_,#6
2274                     ; 339 			st1.st_ctrl_address = 0x00;
2276  007d 725f007a      	clr	_st1+3
2277  0081               L5211:
2278                     ; 342 }
2281  0081 81            	ret
2402                     ; 349 int addNodeToUart2TxSLLast(char *psave, int length)
2402                     ; 350 {
2403                     .text:	section	.text,new
2404  0000               _addNodeToUart2TxSLLast:
2406  0000 89            	pushw	x
2407  0001 5206          	subw	sp,#6
2408       00000006      OFST:	set	6
2411                     ; 351 	int ret = -1;
2413  0003 aeffff        	ldw	x,#65535
2414  0006 1f01          	ldw	(OFST-5,sp),x
2415                     ; 355 	newNode = (slnode_t *)malloc(sizeof(slnode_t)); if(!newNode){ return -1;}
2417  0008 ae0008        	ldw	x,#8
2418  000b cd0000        	call	_malloc
2420  000e 1f05          	ldw	(OFST-1,sp),x
2423  0010 1e05          	ldw	x,(OFST-1,sp)
2424  0012 2605          	jrne	L1121
2427  0014 aeffff        	ldw	x,#65535
2429  0017 2013          	jra	L06
2430  0019               L1121:
2431                     ; 357 	pdata = (char *)malloc(length); if(!pdata){free(newNode); return -1;}
2433  0019 1e0b          	ldw	x,(OFST+5,sp)
2434  001b cd0000        	call	_malloc
2436  001e 1f03          	ldw	(OFST-3,sp),x
2439  0020 1e03          	ldw	x,(OFST-3,sp)
2440  0022 260b          	jrne	L3121
2443  0024 1e05          	ldw	x,(OFST-1,sp)
2444  0026 cd0000        	call	_free
2448  0029 aeffff        	ldw	x,#65535
2450  002c               L06:
2452  002c 5b08          	addw	sp,#8
2453  002e 81            	ret
2454  002f               L3121:
2455                     ; 358 	mutex2 = 1;
2457  002f 350100ce      	mov	_mutex2,#1
2458                     ; 359 	if(newNode && pdata){
2460  0033 1e05          	ldw	x,(OFST-1,sp)
2461  0035 2760          	jreq	L5121
2463  0037 1e03          	ldw	x,(OFST-3,sp)
2464  0039 275c          	jreq	L5121
2465                     ; 360 		newNode->next = NULL;
2467  003b 1e05          	ldw	x,(OFST-1,sp)
2468  003d 905f          	clrw	y
2469  003f ff            	ldw	(x),y
2470                     ; 361 		newNode->len = (u16)length;	
2472  0040 1e05          	ldw	x,(OFST-1,sp)
2473  0042 160b          	ldw	y,(OFST+5,sp)
2474  0044 ef02          	ldw	(2,x),y
2475                     ; 362 		newNode->hasWrite = 0;
2477  0046 1e05          	ldw	x,(OFST-1,sp)
2478  0048 905f          	clrw	y
2479  004a ef04          	ldw	(4,x),y
2480                     ; 363 		memcpy(pdata, psave, length);
2482  004c 1e03          	ldw	x,(OFST-3,sp)
2483  004e bf00          	ldw	c_x,x
2484  0050 1607          	ldw	y,(OFST+1,sp)
2485  0052 90bf00        	ldw	c_y,y
2486  0055 1e0b          	ldw	x,(OFST+5,sp)
2487  0057               L65:
2488  0057 5a            	decw	x
2489  0058 92d600        	ld	a,([c_y.w],x)
2490  005b 92d700        	ld	([c_x.w],x),a
2491  005e 5d            	tnzw	x
2492  005f 26f6          	jrne	L65
2493                     ; 365 		free(psave);
2495  0061 1e07          	ldw	x,(OFST+1,sp)
2496  0063 cd0000        	call	_free
2498                     ; 368 		newNode->data = pdata;
2500  0066 1e05          	ldw	x,(OFST-1,sp)
2501  0068 1603          	ldw	y,(OFST-3,sp)
2502  006a ef06          	ldw	(6,x),y
2503                     ; 369 		mutex2 = 0;
2505  006c 725f00ce      	clr	_mutex2
2506                     ; 370 		if(!uart2TxSLLast){	/* á′±í?2ê?·??a??? */
2508  0070 ce00ca        	ldw	x,_uart2TxSLLast
2509  0073 2610          	jrne	L7121
2510                     ; 371 			uart2TxSLHead = newNode;
2512  0075 1e05          	ldw	x,(OFST-1,sp)
2513  0077 cf00cc        	ldw	_uart2TxSLHead,x
2514                     ; 372 			uart2TxSLLast = newNode;
2516  007a 1e05          	ldw	x,(OFST-1,sp)
2517  007c cf00ca        	ldw	_uart2TxSLLast,x
2518                     ; 373 			mutex2 = 0;
2520  007f 725f00ce      	clr	_mutex2
2522  0083 200f          	jra	L1221
2523  0085               L7121:
2524                     ; 375 			uart2TxSLLast->next = newNode;	/* add node */
2526  0085 1e05          	ldw	x,(OFST-1,sp)
2527  0087 72cf00ca      	ldw	[_uart2TxSLLast.w],x
2528                     ; 376 			uart2TxSLLast = newNode;	/* new list end */
2530  008b 1e05          	ldw	x,(OFST-1,sp)
2531  008d cf00ca        	ldw	_uart2TxSLLast,x
2532                     ; 377 			mutex2 = 0;			
2534  0090 725f00ce      	clr	_mutex2
2535  0094               L1221:
2536                     ; 379 		ret = 0;
2538  0094 5f            	clrw	x
2539  0095 1f01          	ldw	(OFST-5,sp),x
2540  0097               L5121:
2541                     ; 381 	return ret;
2543  0097 1e01          	ldw	x,(OFST-5,sp)
2545  0099 2091          	jra	L06
2593                     ; 387 int deleteNodeFromUart2TxSLHead(void)
2593                     ; 388 {
2594                     .text:	section	.text,new
2595  0000               _deleteNodeFromUart2TxSLHead:
2597  0000 89            	pushw	x
2598       00000002      OFST:	set	2
2601                     ; 389 	int ret = -1;
2603  0001 aeffff        	ldw	x,#65535
2604  0004 1f01          	ldw	(OFST-1,sp),x
2605                     ; 392 	if(uart2TxSLHead){	/* 链表头不为空 */	
2607  0006 ce00cc        	ldw	x,_uart2TxSLHead
2608  0009 274e          	jreq	L5421
2609                     ; 393 		if(!uart2TxSLHead->next){	/* 链表头的next为空，即只有一个节点，链表头和链表尾都指向该节点 */
2611  000b ce00cc        	ldw	x,_uart2TxSLHead
2612  000e e601          	ld	a,(1,x)
2613  0010 fa            	or	a,(x)
2614  0011 2621          	jrne	L7421
2615                     ; 394 			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
2617  0013 ce00cc        	ldw	x,_uart2TxSLHead
2618  0016 e607          	ld	a,(7,x)
2619  0018 ea06          	or	a,(6,x)
2620  001a 2708          	jreq	L1521
2623  001c ce00cc        	ldw	x,_uart2TxSLHead
2624  001f ee06          	ldw	x,(6,x)
2625  0021 cd0000        	call	_free
2627  0024               L1521:
2628                     ; 395 			free(uart2TxSLHead);
2630  0024 ce00cc        	ldw	x,_uart2TxSLHead
2631  0027 cd0000        	call	_free
2633                     ; 396 			uart2TxSLHead = NULL;
2635  002a 5f            	clrw	x
2636  002b cf00cc        	ldw	_uart2TxSLHead,x
2637                     ; 397 			uart2TxSLLast = NULL;
2639  002e 5f            	clrw	x
2640  002f cf00ca        	ldw	_uart2TxSLLast,x
2642  0032 2022          	jra	L3521
2643  0034               L7421:
2644                     ; 399 			newhead = uart2TxSLHead->next;
2646  0034 72ce00cc      	ldw	x,[_uart2TxSLHead.w]
2647  0038 1f01          	ldw	(OFST-1,sp),x
2648                     ; 400 			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
2650  003a ce00cc        	ldw	x,_uart2TxSLHead
2651  003d e607          	ld	a,(7,x)
2652  003f ea06          	or	a,(6,x)
2653  0041 2708          	jreq	L5521
2656  0043 ce00cc        	ldw	x,_uart2TxSLHead
2657  0046 ee06          	ldw	x,(6,x)
2658  0048 cd0000        	call	_free
2660  004b               L5521:
2661                     ; 401 			free(uart2TxSLHead);
2663  004b ce00cc        	ldw	x,_uart2TxSLHead
2664  004e cd0000        	call	_free
2666                     ; 402 			uart2TxSLHead = newhead;			
2668  0051 1e01          	ldw	x,(OFST-1,sp)
2669  0053 cf00cc        	ldw	_uart2TxSLHead,x
2670  0056               L3521:
2671                     ; 404 		ret = 0;
2673  0056 5f            	clrw	x
2674  0057 1f01          	ldw	(OFST-1,sp),x
2675  0059               L5421:
2676                     ; 406 	return ret;	
2678  0059 1e01          	ldw	x,(OFST-1,sp)
2681  005b 5b02          	addw	sp,#2
2682  005d 81            	ret
2752                     ; 414 void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len ,u8 cmd)
2752                     ; 415 {
2753                     .text:	section	.text,new
2754  0000               _send_header_payload_init:
2756  0000 89            	pushw	x
2757       00000000      OFST:	set	0
2760                     ; 416 	send_buf[0] = 0xEE;
2762  0001 35ee003c      	mov	_send_buf,#238
2763                     ; 417 	send_buf[1] = 0xEE;
2765  0005 35ee003d      	mov	_send_buf+1,#238
2766                     ; 418 	send_buf[2] = id;
2768  0009 9e            	ld	a,xh
2769  000a c7003e        	ld	_send_buf+2,a
2770                     ; 419 	send_buf[3] = mesh_id_H;
2772  000d 9f            	ld	a,xl
2773  000e c7003f        	ld	_send_buf+3,a
2774                     ; 420 	send_buf[4] = mesh_id_L;
2776  0011 7b05          	ld	a,(OFST+5,sp)
2777  0013 c70040        	ld	_send_buf+4,a
2778                     ; 421 	send_buf[5] = len;
2780  0016 7b06          	ld	a,(OFST+6,sp)
2781  0018 c70041        	ld	_send_buf+5,a
2782                     ; 423 	switch(cmd)
2784  001b 7b07          	ld	a,(OFST+7,sp)
2786                     ; 690 			break;
2787  001d a006          	sub	a,#6
2788  001f 2761          	jreq	L1621
2789  0021 a002          	sub	a,#2
2790  0023 2603          	jrne	L66
2791  0025 cc0372        	jp	L7721
2792  0028               L66:
2793  0028 a002          	sub	a,#2
2794  002a 2603          	jrne	L07
2795  002c cc0282        	jp	L3721
2796  002f               L07:
2797  002f a016          	sub	a,#22
2798  0031 272e          	jreq	L7521
2799  0033 a009          	sub	a,#9
2800  0035 2603          	jrne	L27
2801  0037 cc00de        	jp	L3621
2802  003a               L27:
2803  003a a00c          	sub	a,#12
2804  003c 2603          	jrne	L47
2805  003e cc00f5        	jp	L5621
2806  0041               L47:
2807  0041 a01c          	sub	a,#28
2808  0043 2603          	jrne	L67
2809  0045 cc0294        	jp	L5721
2810  0048               L67:
2811  0048 a004          	sub	a,#4
2812  004a 2603          	jrne	L001
2813  004c cc0294        	jp	L5721
2814  004f               L001:
2815  004f a055          	sub	a,#85
2816  0051 2603          	jrne	L201
2817  0053 cc013c        	jp	L7621
2818  0056               L201:
2819  0056 a00a          	sub	a,#10
2820  0058 2603          	jrne	L401
2821  005a cc025c        	jp	L1721
2822  005d               L401:
2823  005d ac040504      	jpf	L7231
2824  0061               L7521:
2825                     ; 425 		case 0x20://回复环境光和环境颜色
2825                     ; 426 			send_buf[1] = 0xAA;
2827  0061 35aa003d      	mov	_send_buf+1,#170
2828                     ; 427 			send_buf[6] = cmd;
2830  0065 7b07          	ld	a,(OFST+7,sp)
2831  0067 c70042        	ld	_send_buf+6,a
2832                     ; 428 			send_buf[7] = st1.st_ambient_light;
2834  006a 5500800043    	mov	_send_buf+7,_st1+9
2835                     ; 429 			send_buf[8] = st1.st_color_sense_L;
2837  006f 5500830044    	mov	_send_buf+8,_st1+12
2838                     ; 430 			send_buf[9] = st1.st_color_sense_M;
2840  0074 5500820045    	mov	_send_buf+9,_st1+11
2841                     ; 431 			send_buf[10] = st1.st_color_sense_H;
2843  0079 5500810046    	mov	_send_buf+10,_st1+10
2844                     ; 432 			break;
2846  007e ac040504      	jpf	L7231
2847  0082               L1621:
2848                     ; 433 		case 0x06://回复心跳包，回复背光LED,及3个触控开关的状态
2848                     ; 434 			send_buf[1] = 0xAA;
2850  0082 35aa003d      	mov	_send_buf+1,#170
2851                     ; 435 			send_buf[6] = cmd;
2853  0086 7b07          	ld	a,(OFST+7,sp)
2854  0088 c70042        	ld	_send_buf+6,a
2855                     ; 436 			send_buf[7] = 0x00;//ST Module ID发0x00
2857  008b 725f0043      	clr	_send_buf+7
2858                     ; 437 			send_buf[8] = 0x00;
2860  008f 725f0044      	clr	_send_buf+8
2861                     ; 438 			if ((st1.st_device_status & 0x08)==0x08)	send_buf[8] = st1.st_pad1_status;
2863  0093 c60079        	ld	a,_st1+2
2864  0096 a408          	and	a,#8
2865  0098 a108          	cp	a,#8
2866  009a 2605          	jrne	L1331
2869  009c 55007d0044    	mov	_send_buf+8,_st1+6
2870  00a1               L1331:
2871                     ; 439 			send_buf[9] = 0x00;
2873  00a1 725f0045      	clr	_send_buf+9
2874                     ; 440 			if ((st1.st_device_status & 0x04)==0x04)	send_buf[9] = st1.st_pad2_status;
2876  00a5 c60079        	ld	a,_st1+2
2877  00a8 a404          	and	a,#4
2878  00aa a104          	cp	a,#4
2879  00ac 2605          	jrne	L3331
2882  00ae 55007e0045    	mov	_send_buf+9,_st1+7
2883  00b3               L3331:
2884                     ; 441 			send_buf[10] = 0x00;
2886  00b3 725f0046      	clr	_send_buf+10
2887                     ; 442 			if ((st1.st_device_status & 0x02)==0x02)	send_buf[10]= st1.st_pad3_status;
2889  00b7 c60079        	ld	a,_st1+2
2890  00ba a402          	and	a,#2
2891  00bc a102          	cp	a,#2
2892  00be 2605          	jrne	L5331
2895  00c0 55007f0046    	mov	_send_buf+10,_st1+8
2896  00c5               L5331:
2897                     ; 443 			send_buf[11] = 0x00;
2899  00c5 725f0047      	clr	_send_buf+11
2900                     ; 444 			if ((st1.st_device_status & 0x01)==0x01)	send_buf[11]= st1.st_led_status;
2902  00c9 c60079        	ld	a,_st1+2
2903  00cc a401          	and	a,#1
2904  00ce a101          	cp	a,#1
2905  00d0 2703          	jreq	L601
2906  00d2 cc0504        	jp	L7231
2907  00d5               L601:
2910  00d5 55007c0047    	mov	_send_buf+11,_st1+5
2911  00da ac040504      	jpf	L7231
2912  00de               L3621:
2913                     ; 446 		case 0x29://ST上报手势信息
2913                     ; 447 			send_buf[6] = cmd;
2915  00de 7b07          	ld	a,(OFST+7,sp)
2916  00e0 c70042        	ld	_send_buf+6,a
2917                     ; 448 			send_buf[7] = st1.st_ges_H;
2919  00e3 5500770043    	mov	_send_buf+7,_st1
2920                     ; 449 			send_buf[8] = st1.st_ges_L;
2922  00e8 5500780044    	mov	_send_buf+8,_st1+1
2923                     ; 450 			send_buf[9] = 0x00;//ST Module ID 保留
2925  00ed 725f0045      	clr	_send_buf+9
2926                     ; 451 			break;
2928  00f1 ac040504      	jpf	L7231
2929  00f5               L5621:
2930                     ; 452 		case 0x35:
2930                     ; 453 			send_buf[6] = cmd;
2932  00f5 7b07          	ld	a,(OFST+7,sp)
2933  00f7 c70042        	ld	_send_buf+6,a
2934                     ; 454 			if (st_pad1_ctrl)
2936  00fa c600c7        	ld	a,_UART1Flag3_
2937  00fd a502          	bcp	a,#2
2938  00ff 270e          	jreq	L1431
2939                     ; 456 				send_buf[7] = st1.st_pad1_ctrl_boardid;
2941  0101 5500860043    	mov	_send_buf+7,_st1+15
2942                     ; 457 				send_buf[8] = st1.st_pad1_status;
2944  0106 55007d0044    	mov	_send_buf+8,_st1+6
2946  010b ac040504      	jpf	L7231
2947  010f               L1431:
2948                     ; 459 			else if (st_pad2_ctrl)
2950  010f c600c7        	ld	a,_UART1Flag3_
2951  0112 a504          	bcp	a,#4
2952  0114 270e          	jreq	L5431
2953                     ; 461 				send_buf[7] = st1.st_pad2_ctrl_boardid;
2955  0116 55008b0043    	mov	_send_buf+7,_st1+20
2956                     ; 462 				send_buf[8] = st1.st_pad2_status;
2958  011b 55007e0044    	mov	_send_buf+8,_st1+7
2960  0120 ac040504      	jpf	L7231
2961  0124               L5431:
2962                     ; 464 			else if (st_pad3_ctrl)
2964  0124 c600c7        	ld	a,_UART1Flag3_
2965  0127 a508          	bcp	a,#8
2966  0129 2603          	jrne	L011
2967  012b cc0504        	jp	L7231
2968  012e               L011:
2969                     ; 466 				send_buf[7] = st1.st_pad3_ctrl_boardid;
2971  012e 5500900043    	mov	_send_buf+7,_st1+25
2972                     ; 467 				send_buf[8] = st1.st_pad3_status;
2974  0133 55007f0044    	mov	_send_buf+8,_st1+8
2975  0138 ac040504      	jpf	L7231
2976  013c               L7621:
2977                     ; 470 		case 0xAA://发送回执
2977                     ; 471 			send_buf[1] = 0xAA;
2979  013c 35aa003d      	mov	_send_buf+1,#170
2980                     ; 472 		  if (action_ctrlpad_flag)
2982  0140 c600c9        	ld	a,_UART1Flag1_
2983  0143 a510          	bcp	a,#16
2984  0145 2725          	jreq	L3531
2985                     ; 474 				action_ctrlpad_flag = 0;
2987  0147 721900c9      	bres	_UART1Flag1_,#4
2988                     ; 475 				send_buf[6] = cmd;
2990  014b 7b07          	ld	a,(OFST+7,sp)
2991  014d c70042        	ld	_send_buf+6,a
2992                     ; 476 				send_buf[7] = 0x05;//代表成功执行并返回模块状态
2994  0150 35050043      	mov	_send_buf+7,#5
2995                     ; 477 				send_buf[8] = st1.st_pad1_status;
2997  0154 55007d0044    	mov	_send_buf+8,_st1+6
2998                     ; 478 				send_buf[9] = st1.st_pad2_status;
3000  0159 55007e0045    	mov	_send_buf+9,_st1+7
3001                     ; 479 				send_buf[10] = st1.st_pad3_status;
3003  015e 55007f0046    	mov	_send_buf+10,_st1+8
3004                     ; 480 				send_buf[11] = st1.st_led_status;
3006  0163 55007c0047    	mov	_send_buf+11,_st1+5
3008  0168 ac040504      	jpf	L7231
3009  016c               L3531:
3010                     ; 482 			else if(led_ctrl_flag)
3012  016c c600c6        	ld	a,_UART1Flag4_
3013  016f a504          	bcp	a,#4
3014  0171 2726          	jreq	L7531
3015                     ; 484 				led_ctrl_flag = 0;
3017  0173 721500c6      	bres	_UART1Flag4_,#2
3018                     ; 485 				send_buf[6] = cmd;
3020  0177 7b07          	ld	a,(OFST+7,sp)
3021  0179 c70042        	ld	_send_buf+6,a
3022                     ; 486 				send_buf[7] = 0x01;//代表指令执行成功
3024  017c 35010043      	mov	_send_buf+7,#1
3025                     ; 487 				if((st1.st_led_mode == 0x4F) ||	(st1.st_led_mode == 0x5F))
3027  0180 c600b3        	ld	a,_st1+60
3028  0183 a14f          	cp	a,#79
3029  0185 270a          	jreq	L3631
3031  0187 c600b3        	ld	a,_st1+60
3032  018a a15f          	cp	a,#95
3033  018c 2703          	jreq	L211
3034  018e cc0504        	jp	L7231
3035  0191               L211:
3036  0191               L3631:
3037                     ; 488 					send_buf[7] = 0x02;//代表成功接收数据
3039  0191 35020043      	mov	_send_buf+7,#2
3040  0195 ac040504      	jpf	L7231
3041  0199               L7531:
3042                     ; 490 			else if(load_alert_flag)
3044  0199 c600c6        	ld	a,_UART1Flag4_
3045  019c a508          	bcp	a,#8
3046  019e 2711          	jreq	L7631
3047                     ; 492 				load_alert_flag = 0;
3049  01a0 721700c6      	bres	_UART1Flag4_,#3
3050                     ; 493 				send_buf[6] = cmd;
3052  01a4 7b07          	ld	a,(OFST+7,sp)
3053  01a6 c70042        	ld	_send_buf+6,a
3054                     ; 494 				send_buf[7] = 0x01;//代表指令执行成功
3056  01a9 35010043      	mov	_send_buf+7,#1
3058  01ad ac040504      	jpf	L7231
3059  01b1               L7631:
3060                     ; 496 			else if (cmd_refresh_flag)
3062  01b1 c600c9        	ld	a,_UART1Flag1_
3063  01b4 a504          	bcp	a,#4
3064  01b6 2711          	jreq	L3731
3065                     ; 498 				cmd_refresh_flag = 0;
3067  01b8 721500c9      	bres	_UART1Flag1_,#2
3068                     ; 499 				send_buf[6] = cmd;
3070  01bc 7b07          	ld	a,(OFST+7,sp)
3071  01be c70042        	ld	_send_buf+6,a
3072                     ; 500 				send_buf[7] = 0x01;//代表指令执行成功
3074  01c1 35010043      	mov	_send_buf+7,#1
3076  01c5 ac040504      	jpf	L7231
3077  01c9               L3731:
3078                     ; 502 			else if(receipt_conf_pad1)
3080  01c9 c600c5        	ld	a,_UART1Flag5_
3081  01cc a540          	bcp	a,#64
3082  01ce 2711          	jreq	L7731
3083                     ; 504 				receipt_conf_pad1 = 0;
3085  01d0 721d00c5      	bres	_UART1Flag5_,#6
3086                     ; 505 				send_buf[6] = cmd;
3088  01d4 7b07          	ld	a,(OFST+7,sp)
3089  01d6 c70042        	ld	_send_buf+6,a
3090                     ; 506 				send_buf[7] = 0x01;//代表指令执行成功
3092  01d9 35010043      	mov	_send_buf+7,#1
3094  01dd ac040504      	jpf	L7231
3095  01e1               L7731:
3096                     ; 508 			else if(receipt_conf_pad2)
3098  01e1 c600c5        	ld	a,_UART1Flag5_
3099  01e4 a580          	bcp	a,#128
3100  01e6 2711          	jreq	L3041
3101                     ; 510 				receipt_conf_pad2 = 0;
3103  01e8 721f00c5      	bres	_UART1Flag5_,#7
3104                     ; 511 				send_buf[6] = cmd;
3106  01ec 7b07          	ld	a,(OFST+7,sp)
3107  01ee c70042        	ld	_send_buf+6,a
3108                     ; 512 				send_buf[7] = 0x03;//代表指令执行失败
3110  01f1 35030043      	mov	_send_buf+7,#3
3112  01f5 ac040504      	jpf	L7231
3113  01f9               L3041:
3114                     ; 514 			else if(receipt_conf_gest1)
3116  01f9 c600c4        	ld	a,_UART1Flag6_
3117  01fc a501          	bcp	a,#1
3118  01fe 2711          	jreq	L7041
3119                     ; 516 				receipt_conf_gest1 = 0;
3121  0200 721100c4      	bres	_UART1Flag6_,#0
3122                     ; 517 				send_buf[6] = cmd;
3124  0204 7b07          	ld	a,(OFST+7,sp)
3125  0206 c70042        	ld	_send_buf+6,a
3126                     ; 518 				send_buf[7] = 0x01;//代表指令执行成功
3128  0209 35010043      	mov	_send_buf+7,#1
3130  020d ac040504      	jpf	L7231
3131  0211               L7041:
3132                     ; 520 			else if(receipt_conf_gest2)
3134  0211 c600c4        	ld	a,_UART1Flag6_
3135  0214 a502          	bcp	a,#2
3136  0216 2711          	jreq	L3141
3137                     ; 522 				receipt_conf_gest2 = 0;
3139  0218 721300c4      	bres	_UART1Flag6_,#1
3140                     ; 523 				send_buf[6] = cmd;
3142  021c 7b07          	ld	a,(OFST+7,sp)
3143  021e c70042        	ld	_send_buf+6,a
3144                     ; 524 				send_buf[7] = 0x03;//代表指令执行失败
3146  0221 35030043      	mov	_send_buf+7,#3
3148  0225 ac040504      	jpf	L7231
3149  0229               L3141:
3150                     ; 526 			else if(receipt_device_info2)
3152  0229 c600c5        	ld	a,_UART1Flag5_
3153  022c a502          	bcp	a,#2
3154  022e 2711          	jreq	L7141
3155                     ; 528 				receipt_device_info2 = 0;
3157  0230 721300c5      	bres	_UART1Flag5_,#1
3158                     ; 529 				send_buf[6] = cmd;
3160  0234 7b07          	ld	a,(OFST+7,sp)
3161  0236 c70042        	ld	_send_buf+6,a
3162                     ; 530 				send_buf[7] = 0x03;//代表指令执行失败
3164  0239 35030043      	mov	_send_buf+7,#3
3166  023d ac040504      	jpf	L7231
3167  0241               L7141:
3168                     ; 532 			else if(receipt_host_mesh)
3170  0241 c600c4        	ld	a,_UART1Flag6_
3171  0244 a504          	bcp	a,#4
3172  0246 2603          	jrne	L411
3173  0248 cc0504        	jp	L7231
3174  024b               L411:
3175                     ; 534 				receipt_host_mesh = 0;
3177  024b 721500c4      	bres	_UART1Flag6_,#2
3178                     ; 535 				send_buf[6] = cmd;
3180  024f 7b07          	ld	a,(OFST+7,sp)
3181  0251 c70042        	ld	_send_buf+6,a
3182                     ; 536 				send_buf[7] = 0x02;//代表指令接收成功
3184  0254 35020043      	mov	_send_buf+7,#2
3185  0258 ac040504      	jpf	L7231
3186  025c               L1721:
3187                     ; 539 		case 0xB4://ST回复设备信息
3187                     ; 540 			send_buf[6] = cmd;
3189  025c 7b07          	ld	a,(OFST+7,sp)
3190  025e c70042        	ld	_send_buf+6,a
3191                     ; 541 			send_buf[7] = 0xAA;//UUID
3193  0261 35aa0043      	mov	_send_buf+7,#170
3194                     ; 542 			send_buf[8] = 0x55;
3196  0265 35550044      	mov	_send_buf+8,#85
3197                     ; 543 			send_buf[9] = 0xAB;
3199  0269 35ab0045      	mov	_send_buf+9,#171
3200                     ; 544 			send_buf[10] = 0x70;
3202  026d 35700046      	mov	_send_buf+10,#112
3203                     ; 545 			send_buf[11] = 0x63;//设备型号
3205  0271 35630047      	mov	_send_buf+11,#99
3206                     ; 546 			send_buf[12] = 0x00;//固件版本
3208  0275 725f0048      	clr	_send_buf+12
3209                     ; 547 			send_buf[13] = st1.st_device_status;
3211  0279 5500790049    	mov	_send_buf+13,_st1+2
3212                     ; 548 			break;
3214  027e ac040504      	jpf	L7231
3215  0282               L3721:
3216                     ; 549 		case 0x0A://汇报 Seraph相关设备故障 
3216                     ; 550 			send_buf[6] = cmd;
3218  0282 7b07          	ld	a,(OFST+7,sp)
3219  0284 c70042        	ld	_send_buf+6,a
3220                     ; 551 			send_buf[7] = 0xB4;
3222  0287 35b40043      	mov	_send_buf+7,#180
3223                     ; 552 			send_buf[8] = st1.st_device_status;
3225  028b 5500790044    	mov	_send_buf+8,_st1+2
3226                     ; 553 			break;
3228  0290 ac040504      	jpf	L7231
3229  0294               L5721:
3230                     ; 554 		case 0x51://ST被触发判断需要向SC 发送指令	预设值指令手势
3230                     ; 555 		case 0x55:
3230                     ; 556 			send_buf[6] = cmd;
3232  0294 7b07          	ld	a,(OFST+7,sp)
3233  0296 c70042        	ld	_send_buf+6,a
3234                     ; 557 			if(gest1_confirm)
3236  0299 c600c8        	ld	a,_UART1Flag2_
3237  029c a504          	bcp	a,#4
3238  029e 2712          	jreq	L5241
3239                     ; 559 				send_buf[7] = st1.st_ges1_ctrl_boardid;
3241  02a0 5500970043    	mov	_send_buf+7,_st1+32
3242                     ; 560 				send_buf[8] = st1.st_ges1_ctrl_action_value;
3244  02a5 5500a80044    	mov	_send_buf+8,_st1+49
3245                     ; 561 				send_buf[9] = 0x1E;
3247  02aa 351e0045      	mov	_send_buf+9,#30
3249  02ae ac040504      	jpf	L7231
3250  02b2               L5241:
3251                     ; 563 			else if(gest2_confirm)
3253  02b2 c600c8        	ld	a,_UART1Flag2_
3254  02b5 a508          	bcp	a,#8
3255  02b7 2712          	jreq	L1341
3256                     ; 565 				send_buf[7] = st1.st_ges2_ctrl_boardid;
3258  02b9 55009c0043    	mov	_send_buf+7,_st1+37
3259                     ; 566 				send_buf[8] = st1.st_ges2_ctrl_action_value;
3261  02be 5500ab0044    	mov	_send_buf+8,_st1+52
3262                     ; 567 				send_buf[9] = 0x1E;
3264  02c3 351e0045      	mov	_send_buf+9,#30
3266  02c7 ac040504      	jpf	L7231
3267  02cb               L1341:
3268                     ; 569 			else if(gest3_confirm)
3270  02cb c600c8        	ld	a,_UART1Flag2_
3271  02ce a510          	bcp	a,#16
3272  02d0 2712          	jreq	L5341
3273                     ; 571 				send_buf[7] = st1.st_ges3_ctrl_boardid;
3275  02d2 5500a10043    	mov	_send_buf+7,_st1+42
3276                     ; 572 				send_buf[8] = st1.st_ges3_ctrl_action_value;
3278  02d7 5500ae0044    	mov	_send_buf+8,_st1+55
3279                     ; 573 				send_buf[9] = 0x1E;
3281  02dc 351e0045      	mov	_send_buf+9,#30
3283  02e0 ac040504      	jpf	L7231
3284  02e4               L5341:
3285                     ; 575 			else if(gest4_confirm)
3287  02e4 c600c8        	ld	a,_UART1Flag2_
3288  02e7 a520          	bcp	a,#32
3289  02e9 2712          	jreq	L1441
3290                     ; 577 				send_buf[7] = st1.st_ges4_ctrl_boardid;
3292  02eb 5500a60043    	mov	_send_buf+7,_st1+47
3293                     ; 578 				send_buf[8] = st1.st_ges4_ctrl_action_value;
3295  02f0 5500b10044    	mov	_send_buf+8,_st1+58
3296                     ; 579 				send_buf[9] = 0x1E;
3298  02f5 351e0045      	mov	_send_buf+9,#30
3300  02f9 ac040504      	jpf	L7231
3301  02fd               L1441:
3302                     ; 581 			else if(st_pad1_confirm)
3304  02fd c600c7        	ld	a,_UART1Flag3_
3305  0300 a510          	bcp	a,#16
3306  0302 271f          	jreq	L5441
3307                     ; 583 				send_buf[7] = st1.st_pad1_ctrl_boardid;
3309  0304 5500860043    	mov	_send_buf+7,_st1+15
3310                     ; 584 				if(cmd == 0x51)	send_buf[8] = st1.st_pad1_ctrl_action_value;//说明是调光
3312  0309 7b07          	ld	a,(OFST+7,sp)
3313  030b a151          	cp	a,#81
3314  030d 2607          	jrne	L7441
3317  030f 5500880044    	mov	_send_buf+8,_st1+17
3319  0314 2005          	jra	L1541
3320  0316               L7441:
3321                     ; 585 				else						send_buf[8] = st1.st_pad1_status;
3323  0316 55007d0044    	mov	_send_buf+8,_st1+6
3324  031b               L1541:
3325                     ; 586 				send_buf[9] = 0x1E;
3327  031b 351e0045      	mov	_send_buf+9,#30
3329  031f ac040504      	jpf	L7231
3330  0323               L5441:
3331                     ; 588 			else if(st_pad2_confirm)
3333  0323 c600c7        	ld	a,_UART1Flag3_
3334  0326 a520          	bcp	a,#32
3335  0328 271f          	jreq	L5541
3336                     ; 590 				send_buf[7] = st1.st_pad2_ctrl_boardid;
3338  032a 55008b0043    	mov	_send_buf+7,_st1+20
3339                     ; 591 				if(cmd == 0x51)	send_buf[8] = st1.st_pad2_ctrl_action_value;//说明是调光
3341  032f 7b07          	ld	a,(OFST+7,sp)
3342  0331 a151          	cp	a,#81
3343  0333 2607          	jrne	L7541
3346  0335 55008d0044    	mov	_send_buf+8,_st1+22
3348  033a 2005          	jra	L1641
3349  033c               L7541:
3350                     ; 592 				else						send_buf[8] = st1.st_pad2_status;
3352  033c 55007e0044    	mov	_send_buf+8,_st1+7
3353  0341               L1641:
3354                     ; 593 				send_buf[9] = 0x1E;
3356  0341 351e0045      	mov	_send_buf+9,#30
3358  0345 ac040504      	jpf	L7231
3359  0349               L5541:
3360                     ; 595 			else if(st_pad3_confirm)
3362  0349 c600c7        	ld	a,_UART1Flag3_
3363  034c a540          	bcp	a,#64
3364  034e 2603          	jrne	L611
3365  0350 cc0504        	jp	L7231
3366  0353               L611:
3367                     ; 597 				send_buf[7] = st1.st_pad3_ctrl_boardid;
3369  0353 5500900043    	mov	_send_buf+7,_st1+25
3370                     ; 598 				if(cmd == 0x51)	send_buf[8] = st1.st_pad3_ctrl_action_value;//说明是调光
3372  0358 7b07          	ld	a,(OFST+7,sp)
3373  035a a151          	cp	a,#81
3374  035c 2607          	jrne	L7641
3377  035e 5500920044    	mov	_send_buf+8,_st1+27
3379  0363 2005          	jra	L1741
3380  0365               L7641:
3381                     ; 599 				else						send_buf[8] = st1.st_pad3_status;
3383  0365 55007f0044    	mov	_send_buf+8,_st1+8
3384  036a               L1741:
3385                     ; 600 				send_buf[9] = 0x1E;
3387  036a 351e0045      	mov	_send_buf+9,#30
3388  036e ac040504      	jpf	L7231
3389  0372               L7721:
3390                     ; 604 		case 0x08://ST被触发异步向 SS 推送触发器数值和判断结果
3390                     ; 605 			send_buf[6] = cmd;
3392  0372 7b07          	ld	a,(OFST+7,sp)
3393  0374 c70042        	ld	_send_buf+6,a
3394                     ; 606 			if(gest1_confirm)
3396  0377 c600c8        	ld	a,_UART1Flag2_
3397  037a a504          	bcp	a,#4
3398  037c 2730          	jreq	L3741
3399                     ; 608 				send_buf[7] = 0x02;//触发器是手势
3401  037e 35020043      	mov	_send_buf+7,#2
3402                     ; 609 				send_buf[8] = st1.st_ges1_ctrl_H;
3404  0382 5500930044    	mov	_send_buf+8,_st1+28
3405                     ; 610 				send_buf[9] = st1.st_ges1_ctrl_L;
3407  0387 5500940045    	mov	_send_buf+9,_st1+29
3408                     ; 611 				send_buf[10] = st1.st_ges1_ctrl_meshid_H;
3410  038c 5500950046    	mov	_send_buf+10,_st1+30
3411                     ; 612 				send_buf[11] = st1.st_ges1_ctrl_meshid_L;
3413  0391 5500960047    	mov	_send_buf+11,_st1+31
3414                     ; 613 				send_buf[12] = st1.st_ges1_ctrl_action;
3416  0396 5500a70048    	mov	_send_buf+12,_st1+48
3417                     ; 614 				send_buf[13] = st1.st_ges1_ctrl_boardid;
3419  039b 5500970049    	mov	_send_buf+13,_st1+32
3420                     ; 615 				send_buf[14] = st1.st_ges1_ctrl_action_value;
3422  03a0 5500a8004a    	mov	_send_buf+14,_st1+49
3423                     ; 616 				send_buf[15] = st1.st_ges1_ctrl_action_time;
3425  03a5 5500a9004b    	mov	_send_buf+15,_st1+50
3427  03aa ac040504      	jpf	L7231
3428  03ae               L3741:
3429                     ; 618 			else if(gest2_confirm)
3431  03ae c600c8        	ld	a,_UART1Flag2_
3432  03b1 a508          	bcp	a,#8
3433  03b3 2730          	jreq	L7741
3434                     ; 620 				send_buf[7] = 0x02;
3436  03b5 35020043      	mov	_send_buf+7,#2
3437                     ; 621 				send_buf[8] = st1.st_ges2_ctrl_H;
3439  03b9 5500980044    	mov	_send_buf+8,_st1+33
3440                     ; 622 				send_buf[9] = st1.st_ges2_ctrl_L;
3442  03be 5500990045    	mov	_send_buf+9,_st1+34
3443                     ; 623 				send_buf[10] = st1.st_ges2_ctrl_meshid_H;
3445  03c3 55009a0046    	mov	_send_buf+10,_st1+35
3446                     ; 624 				send_buf[11] = st1.st_ges2_ctrl_meshid_L;
3448  03c8 55009b0047    	mov	_send_buf+11,_st1+36
3449                     ; 625 				send_buf[12] = st1.st_ges2_ctrl_action;
3451  03cd 5500aa0048    	mov	_send_buf+12,_st1+51
3452                     ; 626 				send_buf[13] = st1.st_ges2_ctrl_boardid;
3454  03d2 55009c0049    	mov	_send_buf+13,_st1+37
3455                     ; 627 				send_buf[14] = st1.st_ges2_ctrl_action_value;
3457  03d7 5500ab004a    	mov	_send_buf+14,_st1+52
3458                     ; 628 				send_buf[15] = st1.st_ges2_ctrl_action_time;
3460  03dc 5500ac004b    	mov	_send_buf+15,_st1+53
3462  03e1 ac040504      	jpf	L7231
3463  03e5               L7741:
3464                     ; 630 			else if(gest3_confirm)
3466  03e5 c600c8        	ld	a,_UART1Flag2_
3467  03e8 a510          	bcp	a,#16
3468  03ea 2730          	jreq	L3051
3469                     ; 632 				send_buf[7] = 0x02;
3471  03ec 35020043      	mov	_send_buf+7,#2
3472                     ; 633 				send_buf[8] = st1.st_ges3_ctrl_H;
3474  03f0 55009d0044    	mov	_send_buf+8,_st1+38
3475                     ; 634 				send_buf[9] = st1.st_ges3_ctrl_L;
3477  03f5 55009e0045    	mov	_send_buf+9,_st1+39
3478                     ; 635 				send_buf[10] = st1.st_ges3_ctrl_meshid_H;
3480  03fa 55009f0046    	mov	_send_buf+10,_st1+40
3481                     ; 636 				send_buf[11] = st1.st_ges3_ctrl_meshid_L;
3483  03ff 5500a00047    	mov	_send_buf+11,_st1+41
3484                     ; 637 				send_buf[12] = st1.st_ges3_ctrl_action;
3486  0404 5500ad0048    	mov	_send_buf+12,_st1+54
3487                     ; 638 				send_buf[13] = st1.st_ges3_ctrl_boardid;
3489  0409 5500a10049    	mov	_send_buf+13,_st1+42
3490                     ; 639 				send_buf[14] = st1.st_ges3_ctrl_action_value;
3492  040e 5500ae004a    	mov	_send_buf+14,_st1+55
3493                     ; 640 				send_buf[15] = st1.st_ges3_ctrl_action_time;
3495  0413 5500af004b    	mov	_send_buf+15,_st1+56
3497  0418 ac040504      	jpf	L7231
3498  041c               L3051:
3499                     ; 642 			else if(gest4_confirm)
3501  041c c600c8        	ld	a,_UART1Flag2_
3502  041f a520          	bcp	a,#32
3503  0421 272f          	jreq	L7051
3504                     ; 644 				send_buf[7] = 0x02;
3506  0423 35020043      	mov	_send_buf+7,#2
3507                     ; 645 				send_buf[8] = st1.st_ges4_ctrl_H;
3509  0427 5500a20044    	mov	_send_buf+8,_st1+43
3510                     ; 646 				send_buf[9] = st1.st_ges4_ctrl_L;
3512  042c 5500a30045    	mov	_send_buf+9,_st1+44
3513                     ; 647 				send_buf[10] = st1.st_ges4_ctrl_meshid_H;
3515  0431 5500a40046    	mov	_send_buf+10,_st1+45
3516                     ; 648 				send_buf[11] = st1.st_ges4_ctrl_meshid_L;
3518  0436 5500a50047    	mov	_send_buf+11,_st1+46
3519                     ; 649 				send_buf[12] = st1.st_ges4_ctrl_action;
3521  043b 5500b00048    	mov	_send_buf+12,_st1+57
3522                     ; 650 				send_buf[13] = st1.st_ges4_ctrl_boardid;
3524  0440 5500a60049    	mov	_send_buf+13,_st1+47
3525                     ; 651 				send_buf[14] = st1.st_ges4_ctrl_action_value;
3527  0445 5500b1004a    	mov	_send_buf+14,_st1+58
3528                     ; 652 				send_buf[15] = 0x00;
3530  044a 725f004b      	clr	_send_buf+15
3532  044e ac040504      	jpf	L7231
3533  0452               L7051:
3534                     ; 654 			else if(st_pad1_confirm)
3536  0452 c600c7        	ld	a,_UART1Flag3_
3537  0455 a510          	bcp	a,#16
3538  0457 2735          	jreq	L3151
3539                     ; 656 				send_buf[7] = 0x01;//触发器是按键
3541  0459 35010043      	mov	_send_buf+7,#1
3542                     ; 657 				send_buf[8] = 0x00;
3544  045d 725f0044      	clr	_send_buf+8
3545                     ; 658 				send_buf[9] = (st1.st_pad1_ctrl_boardid<<4) | st1.st_ctrl_address;
3547  0461 c60086        	ld	a,_st1+15
3548  0464 97            	ld	xl,a
3549  0465 a610          	ld	a,#16
3550  0467 42            	mul	x,a
3551  0468 9f            	ld	a,xl
3552  0469 ca007a        	or	a,_st1+3
3553  046c c70045        	ld	_send_buf+9,a
3554                     ; 659 				send_buf[10] = st1.st_pad1_ctrl_meshid_H;
3556  046f 5500840046    	mov	_send_buf+10,_st1+13
3557                     ; 660 				send_buf[11] = st1.st_pad1_ctrl_meshid_L;
3559  0474 5500850047    	mov	_send_buf+11,_st1+14
3560                     ; 661 				send_buf[12] = st1.st_pad1_ctrl_action;
3562  0479 5500870048    	mov	_send_buf+12,_st1+16
3563                     ; 662 				send_buf[13] = st1.st_pad1_ctrl_boardid;
3565  047e 5500860049    	mov	_send_buf+13,_st1+15
3566                     ; 663 				send_buf[14] = st1.st_pad1_status;
3568  0483 55007d004a    	mov	_send_buf+14,_st1+6
3569                     ; 664 				send_buf[15] = 0x00;
3571  0488 725f004b      	clr	_send_buf+15
3573  048c 2076          	jra	L7231
3574  048e               L3151:
3575                     ; 666 			else if(st_pad2_confirm)
3577  048e c600c7        	ld	a,_UART1Flag3_
3578  0491 a520          	bcp	a,#32
3579  0493 2735          	jreq	L7151
3580                     ; 668 				send_buf[7] = 0x01;//触发器是按键
3582  0495 35010043      	mov	_send_buf+7,#1
3583                     ; 669 				send_buf[8] = 0x00;
3585  0499 725f0044      	clr	_send_buf+8
3586                     ; 670 				send_buf[9] = (st1.st_pad2_ctrl_boardid<<4) |st1.st_ctrl_address;
3588  049d c6008b        	ld	a,_st1+20
3589  04a0 97            	ld	xl,a
3590  04a1 a610          	ld	a,#16
3591  04a3 42            	mul	x,a
3592  04a4 9f            	ld	a,xl
3593  04a5 ca007a        	or	a,_st1+3
3594  04a8 c70045        	ld	_send_buf+9,a
3595                     ; 671 				send_buf[10] = st1.st_pad2_ctrl_meshid_H;
3597  04ab 5500890046    	mov	_send_buf+10,_st1+18
3598                     ; 672 				send_buf[11] = st1.st_pad2_ctrl_meshid_L;
3600  04b0 55008a0047    	mov	_send_buf+11,_st1+19
3601                     ; 673 				send_buf[12] = st1.st_pad2_ctrl_action;
3603  04b5 55008c0048    	mov	_send_buf+12,_st1+21
3604                     ; 674 				send_buf[13] = st1.st_pad2_ctrl_boardid;
3606  04ba 55008b0049    	mov	_send_buf+13,_st1+20
3607                     ; 675 				send_buf[14] = st1.st_pad2_status;
3609  04bf 55007e004a    	mov	_send_buf+14,_st1+7
3610                     ; 676 				send_buf[15] = 0x00;
3612  04c4 725f004b      	clr	_send_buf+15
3614  04c8 203a          	jra	L7231
3615  04ca               L7151:
3616                     ; 678 			else if(st_pad3_confirm)
3618  04ca c600c7        	ld	a,_UART1Flag3_
3619  04cd a540          	bcp	a,#64
3620  04cf 2733          	jreq	L7231
3621                     ; 680 				send_buf[7] = 0x01;//触发器是按键
3623  04d1 35010043      	mov	_send_buf+7,#1
3624                     ; 681 				send_buf[8] = 0x00;
3626  04d5 725f0044      	clr	_send_buf+8
3627                     ; 682 				send_buf[9] = (st1.st_pad3_ctrl_boardid<<4) |st1.st_ctrl_address;
3629  04d9 c60090        	ld	a,_st1+25
3630  04dc 97            	ld	xl,a
3631  04dd a610          	ld	a,#16
3632  04df 42            	mul	x,a
3633  04e0 9f            	ld	a,xl
3634  04e1 ca007a        	or	a,_st1+3
3635  04e4 c70045        	ld	_send_buf+9,a
3636                     ; 683 				send_buf[10] = st1.st_pad3_ctrl_meshid_H;
3638  04e7 55008e0046    	mov	_send_buf+10,_st1+23
3639                     ; 684 				send_buf[11] = st1.st_pad3_ctrl_meshid_L;
3641  04ec 55008f0047    	mov	_send_buf+11,_st1+24
3642                     ; 685 				send_buf[12] = st1.st_pad3_ctrl_action;
3644  04f1 5500910048    	mov	_send_buf+12,_st1+26
3645                     ; 686 				send_buf[13] = st1.st_pad3_ctrl_boardid;
3647  04f6 5500900049    	mov	_send_buf+13,_st1+25
3648                     ; 687 				send_buf[14] = st1.st_pad3_status;
3650  04fb 55007f004a    	mov	_send_buf+14,_st1+8
3651                     ; 688 				send_buf[15] = 0x00;
3653  0500 725f004b      	clr	_send_buf+15
3654  0504               L7231:
3655                     ; 692 	send_buf[len+2] = Check_Sum((send_buf+2),len);
3657  0504 7b06          	ld	a,(OFST+6,sp)
3658  0506 5f            	clrw	x
3659  0507 97            	ld	xl,a
3660  0508 89            	pushw	x
3661  0509 7b08          	ld	a,(OFST+8,sp)
3662  050b 88            	push	a
3663  050c ae003e        	ldw	x,#_send_buf+2
3664  050f cd0000        	call	_Check_Sum
3666  0512 5b01          	addw	sp,#1
3667  0514 85            	popw	x
3668  0515 d7003e        	ld	(_send_buf+2,x),a
3669                     ; 694 }
3672  0518 85            	popw	x
3673  0519 81            	ret
3740                     ; 712 void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length)
3740                     ; 713 {
3741                     .text:	section	.text,new
3742  0000               _rev_header_anaylze:
3744  0000 89            	pushw	x
3745       00000000      OFST:	set	0
3748                     ; 714 	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
3750  0001 c60000        	ld	a,_sicp_buf
3751  0004 a1ee          	cp	a,#238
3752  0006 262c          	jrne	L7551
3754  0008 c60001        	ld	a,_sicp_buf+1
3755  000b a1ee          	cp	a,#238
3756  000d 2707          	jreq	L1651
3758  000f c60001        	ld	a,_sicp_buf+1
3759  0012 a1aa          	cp	a,#170
3760  0014 261e          	jrne	L7551
3761  0016               L1651:
3762                     ; 716 		ble_data_frame = 1;
3764  0016 721a00c9      	bset	_UART1Flag1_,#5
3765                     ; 717 		*message_id = sicp_buf[2];
3767  001a 1e01          	ldw	x,(OFST+1,sp)
3768  001c c60002        	ld	a,_sicp_buf+2
3769  001f f7            	ld	(x),a
3770                     ; 718 		*mesh_id_H = sicp_buf[3];
3772  0020 1e05          	ldw	x,(OFST+5,sp)
3773  0022 c60003        	ld	a,_sicp_buf+3
3774  0025 f7            	ld	(x),a
3775                     ; 719 		*mesh_id_L = sicp_buf[4];
3777  0026 1e07          	ldw	x,(OFST+7,sp)
3778  0028 c60004        	ld	a,_sicp_buf+4
3779  002b f7            	ld	(x),a
3780                     ; 720 		*message_length = sicp_buf[5];
3782  002c 1e09          	ldw	x,(OFST+9,sp)
3783  002e c60005        	ld	a,_sicp_buf+5
3784  0031 f7            	ld	(x),a
3786  0032 2018          	jra	L3651
3787  0034               L7551:
3788                     ; 723 	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))//Network	Status	Reporting	
3790  0034 c60000        	ld	a,_sicp_buf
3791  0037 a1dd          	cp	a,#221
3792  0039 2611          	jrne	L3651
3794  003b c60001        	ld	a,_sicp_buf+1
3795  003e a1dd          	cp	a,#221
3796  0040 260a          	jrne	L3651
3797                     ; 725 		ble_ctrl_frame = 1;
3799  0042 721c00c9      	bset	_UART1Flag1_,#6
3800                     ; 726 		*message_length = sicp_buf[3];
3802  0046 1e09          	ldw	x,(OFST+9,sp)
3803  0048 c60003        	ld	a,_sicp_buf+3
3804  004b f7            	ld	(x),a
3805  004c               L3651:
3806                     ; 733 }
3809  004c 85            	popw	x
3810  004d 81            	ret
3877                     ; 740 bool rev_payload_anaylze(void)
3877                     ; 741 {
3878                     .text:	section	.text,new
3879  0000               _rev_payload_anaylze:
3883                     ; 743 	if (ble_data_frame)
3885  0000 c600c9        	ld	a,_UART1Flag1_
3886  0003 a520          	bcp	a,#32
3887  0005 2603          	jrne	L421
3888  0007 cc0674        	jp	L1561
3889  000a               L421:
3890                     ; 745 		ble_data_frame = 0;
3892  000a 721b00c9      	bres	_UART1Flag1_,#5
3893                     ; 746 		switch(sicp_buf[6])
3895  000e c60006        	ld	a,_sicp_buf+6
3897                     ; 1063 			default:
3897                     ; 1064 				break;
3898  0011 a003          	sub	a,#3
3899  0013 2603          	jrne	L621
3900  0015 cc03ae        	jp	L5751
3901  0018               L621:
3902  0018 4a            	dec	a
3903  0019 272d          	jreq	L7651
3904  001b 4a            	dec	a
3905  001c 2603          	jrne	L031
3906  001e cc060f        	jp	L5161
3907  0021               L031:
3908  0021 a004          	sub	a,#4
3909  0023 2603          	jrne	L231
3910  0025 cc04a2        	jp	L1061
3911  0028               L231:
3912  0028 a04d          	sub	a,#77
3913  002a 2603          	jrne	L431
3914  002c cc043d        	jp	L7751
3915  002f               L431:
3916  002f a054          	sub	a,#84
3917  0031 2603          	jrne	L631
3918  0033 cc038a        	jp	L1751
3919  0036               L631:
3920  0036 a006          	sub	a,#6
3921  0038 2603          	jrne	L041
3922  003a cc0639        	jp	L7161
3923  003d               L041:
3924  003d a010          	sub	a,#16
3925  003f 2603          	jrne	L241
3926  0041 cc039c        	jp	L3751
3927  0044               L241:
3928  0044 ac710671      	jpf	L5561
3929  0048               L7651:
3930                     ; 748 			case 0x04://SS向ST发送配置信息
3930                     ; 749 				receipt_device_info1 = 1;
3932  0048 721000c5      	bset	_UART1Flag5_,#0
3933                     ; 752 					if (sicp_buf[7] == 0x01)//设置ST按键作用
3935  004c c60007        	ld	a,_sicp_buf+7
3936  004f a101          	cp	a,#1
3937  0051 2703          	jreq	L441
3938  0053 cc015a        	jp	L7561
3939  0056               L441:
3940                     ; 754 						kickout_flag = 0;
3942  0056 721100c6      	bres	_UART1Flag4_,#0
3943                     ; 755 						net_reset_flag = 0;
3945  005a 721300c6      	bres	_UART1Flag4_,#1
3946                     ; 756 						if (sicp_buf[8] == 1)//设置通道1
3948  005e c60008        	ld	a,_sicp_buf+8
3949  0061 a101          	cp	a,#1
3950  0063 2640          	jrne	L1661
3951                     ; 758 							st1.st_pad1_ctrl_meshid_H = sicp_buf[10];
3953  0065 55000a0084    	mov	_st1+13,_sicp_buf+10
3954                     ; 759 							st1.st_pad1_ctrl_meshid_L = sicp_buf[11];
3956  006a 55000b0085    	mov	_st1+14,_sicp_buf+11
3957                     ; 760 							st1.st_pad1_ctrl_boardid 	= sicp_buf[12];
3959  006f 55000c0086    	mov	_st1+15,_sicp_buf+12
3960                     ; 761 							st1.st_pad1_ctrl_action   = sicp_buf[13];
3962  0074 55000d0087    	mov	_st1+16,_sicp_buf+13
3963                     ; 762 							st1.st_pad1_ctrl_action_value = sicp_buf[14];
3965  0079 55000e0088    	mov	_st1+17,_sicp_buf+14
3966                     ; 763 							receipt_conf_pad1 = 1;
3968  007e 721c00c5      	bset	_UART1Flag5_,#6
3969                     ; 764 							send_message_length = 6;
3971  0082 35060064      	mov	_send_message_length,#6
3972                     ; 765 							send_cmd = 0xAA;
3974  0086 35aa0063      	mov	_send_cmd,#170
3975                     ; 766 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
3977  008a 4baa          	push	#170
3978  008c 4b06          	push	#6
3979  008e 3b006a        	push	_ns_host_meshid_L
3980  0091 c6006b        	ld	a,_ns_host_meshid_H
3981  0094 97            	ld	xl,a
3982  0095 c60069        	ld	a,_rev_message_id
3983  0098 95            	ld	xh,a
3984  0099 cd0000        	call	_send_header_payload_init
3986  009c 5b03          	addw	sp,#3
3987                     ; 767 							UART2_Send_Data_Start();
3989  009e cd0000        	call	_UART2_Send_Data_Start
3991                     ; 768 							break;
3993  00a1 ac710671      	jpf	L5561
3994  00a5               L1661:
3995                     ; 770 						else if (sicp_buf[8] == 2)//设置通道2
3997  00a5 c60008        	ld	a,_sicp_buf+8
3998  00a8 a102          	cp	a,#2
3999  00aa 2640          	jrne	L5661
4000                     ; 772 							st1.st_pad2_ctrl_meshid_H = sicp_buf[10];
4002  00ac 55000a0089    	mov	_st1+18,_sicp_buf+10
4003                     ; 773 							st1.st_pad2_ctrl_meshid_L = sicp_buf[11];
4005  00b1 55000b008a    	mov	_st1+19,_sicp_buf+11
4006                     ; 774 							st1.st_pad2_ctrl_boardid 	= sicp_buf[12];
4008  00b6 55000c008b    	mov	_st1+20,_sicp_buf+12
4009                     ; 775 							st1.st_pad2_ctrl_action   = sicp_buf[13];
4011  00bb 55000d008c    	mov	_st1+21,_sicp_buf+13
4012                     ; 776 							st1.st_pad2_ctrl_action_value = sicp_buf[14];
4014  00c0 55000e008d    	mov	_st1+22,_sicp_buf+14
4015                     ; 777 							receipt_conf_pad1 = 1;
4017  00c5 721c00c5      	bset	_UART1Flag5_,#6
4018                     ; 778 							send_message_length = 6;
4020  00c9 35060064      	mov	_send_message_length,#6
4021                     ; 779 							send_cmd = 0xAA;
4023  00cd 35aa0063      	mov	_send_cmd,#170
4024                     ; 780 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4026  00d1 4baa          	push	#170
4027  00d3 4b06          	push	#6
4028  00d5 3b006a        	push	_ns_host_meshid_L
4029  00d8 c6006b        	ld	a,_ns_host_meshid_H
4030  00db 97            	ld	xl,a
4031  00dc c60069        	ld	a,_rev_message_id
4032  00df 95            	ld	xh,a
4033  00e0 cd0000        	call	_send_header_payload_init
4035  00e3 5b03          	addw	sp,#3
4036                     ; 781 							UART2_Send_Data_Start();
4038  00e5 cd0000        	call	_UART2_Send_Data_Start
4040                     ; 782 							break;
4042  00e8 ac710671      	jpf	L5561
4043  00ec               L5661:
4044                     ; 784 						else if (sicp_buf[8] == 3)//设置通道3
4046  00ec c60008        	ld	a,_sicp_buf+8
4047  00ef a103          	cp	a,#3
4048  00f1 2640          	jrne	L1761
4049                     ; 786 							st1.st_pad3_ctrl_meshid_H = sicp_buf[10];
4051  00f3 55000a008e    	mov	_st1+23,_sicp_buf+10
4052                     ; 787 							st1.st_pad3_ctrl_meshid_L = sicp_buf[11];
4054  00f8 55000b008f    	mov	_st1+24,_sicp_buf+11
4055                     ; 788 							st1.st_pad3_ctrl_boardid 	= sicp_buf[12];
4057  00fd 55000c0090    	mov	_st1+25,_sicp_buf+12
4058                     ; 789 							st1.st_pad3_ctrl_action   = sicp_buf[13];
4060  0102 55000d0091    	mov	_st1+26,_sicp_buf+13
4061                     ; 790 							st1.st_pad3_ctrl_action_value = sicp_buf[14];
4063  0107 55000e0092    	mov	_st1+27,_sicp_buf+14
4064                     ; 791 							receipt_conf_pad1 = 1;
4066  010c 721c00c5      	bset	_UART1Flag5_,#6
4067                     ; 792 							send_message_length = 6;
4069  0110 35060064      	mov	_send_message_length,#6
4070                     ; 793 							send_cmd = 0xAA;
4072  0114 35aa0063      	mov	_send_cmd,#170
4073                     ; 794 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4075  0118 4baa          	push	#170
4076  011a 4b06          	push	#6
4077  011c 3b006a        	push	_ns_host_meshid_L
4078  011f c6006b        	ld	a,_ns_host_meshid_H
4079  0122 97            	ld	xl,a
4080  0123 c60069        	ld	a,_rev_message_id
4081  0126 95            	ld	xh,a
4082  0127 cd0000        	call	_send_header_payload_init
4084  012a 5b03          	addw	sp,#3
4085                     ; 795 							UART2_Send_Data_Start();
4087  012c cd0000        	call	_UART2_Send_Data_Start
4089                     ; 796 							break;
4091  012f ac710671      	jpf	L5561
4092  0133               L1761:
4093                     ; 800 							receipt_conf_pad2 = 1;
4095  0133 721e00c5      	bset	_UART1Flag5_,#7
4096                     ; 801 							send_message_length = 6;
4098  0137 35060064      	mov	_send_message_length,#6
4099                     ; 802 							send_cmd = 0xAA;
4101  013b 35aa0063      	mov	_send_cmd,#170
4102                     ; 803 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4104  013f 4baa          	push	#170
4105  0141 4b06          	push	#6
4106  0143 3b006a        	push	_ns_host_meshid_L
4107  0146 c6006b        	ld	a,_ns_host_meshid_H
4108  0149 97            	ld	xl,a
4109  014a c60069        	ld	a,_rev_message_id
4110  014d 95            	ld	xh,a
4111  014e cd0000        	call	_send_header_payload_init
4113  0151 5b03          	addw	sp,#3
4114                     ; 804 							UART2_Send_Data_Start();
4116  0153 cd0000        	call	_UART2_Send_Data_Start
4118                     ; 805 							break;
4120  0156 ac710671      	jpf	L5561
4121  015a               L7561:
4122                     ; 809 					else if (sicp_buf[7] == 0x02)//设置ST手势作用
4124  015a c60007        	ld	a,_sicp_buf+7
4125  015d a102          	cp	a,#2
4126  015f 2703          	jreq	L641
4127  0161 cc0671        	jp	L5561
4128  0164               L641:
4129                     ; 811 						kickout_flag = 0;
4131  0164 721100c6      	bres	_UART1Flag4_,#0
4132                     ; 812 						net_reset_flag = 0;
4134  0168 721300c6      	bres	_UART1Flag4_,#1
4135                     ; 814 						if((st1.st_ges1_ctrl_H == 0x11) && (st1.st_ges1_ctrl_L == 0x11) && (sicp_buf[8] != st1.st_ges1_ctrl_H) && (sicp_buf[9] != st1.st_ges1_ctrl_L))//第一个预设置手势
4137  016c c60093        	ld	a,_st1+28
4138  016f a111          	cp	a,#17
4139  0171 2661          	jrne	L1071
4141  0173 c60094        	ld	a,_st1+29
4142  0176 a111          	cp	a,#17
4143  0178 265a          	jrne	L1071
4145  017a c60008        	ld	a,_sicp_buf+8
4146  017d c10093        	cp	a,_st1+28
4147  0180 2752          	jreq	L1071
4149  0182 c60009        	ld	a,_sicp_buf+9
4150  0185 c10094        	cp	a,_st1+29
4151  0188 274a          	jreq	L1071
4152                     ; 816 							st1.st_ges1_ctrl_H						= sicp_buf[8];
4154  018a 5500080093    	mov	_st1+28,_sicp_buf+8
4155                     ; 817 							st1.st_ges1_ctrl_L						= sicp_buf[9];
4157  018f 5500090094    	mov	_st1+29,_sicp_buf+9
4158                     ; 818 							st1.st_ges1_ctrl_meshid_H 		= sicp_buf[10];
4160  0194 55000a0095    	mov	_st1+30,_sicp_buf+10
4161                     ; 819 							st1.st_ges1_ctrl_meshid_L 		= sicp_buf[11];
4163  0199 55000b0096    	mov	_st1+31,_sicp_buf+11
4164                     ; 820 							st1.st_ges1_ctrl_boardid 			= sicp_buf[12];
4166  019e 55000c0097    	mov	_st1+32,_sicp_buf+12
4167                     ; 821 							st1.st_ges1_ctrl_action				= sicp_buf[13];
4169  01a3 55000d00a7    	mov	_st1+48,_sicp_buf+13
4170                     ; 822 							st1.st_ges1_ctrl_action_value = sicp_buf[14];
4172  01a8 55000e00a8    	mov	_st1+49,_sicp_buf+14
4173                     ; 824 							receipt_conf_gest1 = 1;
4175  01ad 721000c4      	bset	_UART1Flag6_,#0
4176                     ; 825 							send_message_length = 6;
4178  01b1 35060064      	mov	_send_message_length,#6
4179                     ; 826 							send_cmd = 0xAA;
4181  01b5 35aa0063      	mov	_send_cmd,#170
4182                     ; 827 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4184  01b9 4baa          	push	#170
4185  01bb 4b06          	push	#6
4186  01bd 3b006a        	push	_ns_host_meshid_L
4187  01c0 c6006b        	ld	a,_ns_host_meshid_H
4188  01c3 97            	ld	xl,a
4189  01c4 c60069        	ld	a,_rev_message_id
4190  01c7 95            	ld	xh,a
4191  01c8 cd0000        	call	_send_header_payload_init
4193  01cb 5b03          	addw	sp,#3
4194                     ; 828 							UART2_Send_Data_Start();
4196  01cd cd0000        	call	_UART2_Send_Data_Start
4198                     ; 829 							break;
4200  01d0 ac710671      	jpf	L5561
4201  01d4               L1071:
4202                     ; 831 						else if((st1.st_ges2_ctrl_H == 0x11) && (st1.st_ges2_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges2_ctrl_H) && (sicp_buf[9] != st1.st_ges2_ctrl_L))//第二个预设置手势
4204  01d4 c60098        	ld	a,_st1+33
4205  01d7 a111          	cp	a,#17
4206  01d9 2661          	jrne	L5071
4208  01db c60099        	ld	a,_st1+34
4209  01de a111          	cp	a,#17
4210  01e0 265a          	jrne	L5071
4212  01e2 c60008        	ld	a,_sicp_buf+8
4213  01e5 c10098        	cp	a,_st1+33
4214  01e8 2752          	jreq	L5071
4216  01ea c60009        	ld	a,_sicp_buf+9
4217  01ed c10099        	cp	a,_st1+34
4218  01f0 274a          	jreq	L5071
4219                     ; 833 							st1.st_ges2_ctrl_H						= sicp_buf[8];
4221  01f2 5500080098    	mov	_st1+33,_sicp_buf+8
4222                     ; 834 							st1.st_ges2_ctrl_L						= sicp_buf[9];
4224  01f7 5500090099    	mov	_st1+34,_sicp_buf+9
4225                     ; 835 							st1.st_ges2_ctrl_meshid_H 		= sicp_buf[10];
4227  01fc 55000a009a    	mov	_st1+35,_sicp_buf+10
4228                     ; 836 							st1.st_ges2_ctrl_meshid_L 		= sicp_buf[11];
4230  0201 55000b009b    	mov	_st1+36,_sicp_buf+11
4231                     ; 837 							st1.st_ges2_ctrl_boardid 			= sicp_buf[12];
4233  0206 55000c009c    	mov	_st1+37,_sicp_buf+12
4234                     ; 838 							st1.st_ges2_ctrl_action				= sicp_buf[13];
4236  020b 55000d00aa    	mov	_st1+51,_sicp_buf+13
4237                     ; 839 							st1.st_ges2_ctrl_action_value = sicp_buf[14];
4239  0210 55000e00ab    	mov	_st1+52,_sicp_buf+14
4240                     ; 841 							receipt_conf_gest1 = 1;
4242  0215 721000c4      	bset	_UART1Flag6_,#0
4243                     ; 842 							send_message_length = 6;
4245  0219 35060064      	mov	_send_message_length,#6
4246                     ; 843 							send_cmd = 0xAA;
4248  021d 35aa0063      	mov	_send_cmd,#170
4249                     ; 844 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4251  0221 4baa          	push	#170
4252  0223 4b06          	push	#6
4253  0225 3b006a        	push	_ns_host_meshid_L
4254  0228 c6006b        	ld	a,_ns_host_meshid_H
4255  022b 97            	ld	xl,a
4256  022c c60069        	ld	a,_rev_message_id
4257  022f 95            	ld	xh,a
4258  0230 cd0000        	call	_send_header_payload_init
4260  0233 5b03          	addw	sp,#3
4261                     ; 845 							UART2_Send_Data_Start();
4263  0235 cd0000        	call	_UART2_Send_Data_Start
4265                     ; 846 							break;
4267  0238 ac710671      	jpf	L5561
4268  023c               L5071:
4269                     ; 848 						else if((st1.st_ges3_ctrl_H == 0x11) && (st1.st_ges3_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges3_ctrl_H) && (sicp_buf[9] != st1.st_ges3_ctrl_L))//第三个预设置手势
4271  023c c6009d        	ld	a,_st1+38
4272  023f a111          	cp	a,#17
4273  0241 2661          	jrne	L1171
4275  0243 c6009e        	ld	a,_st1+39
4276  0246 a111          	cp	a,#17
4277  0248 265a          	jrne	L1171
4279  024a c60008        	ld	a,_sicp_buf+8
4280  024d c1009d        	cp	a,_st1+38
4281  0250 2752          	jreq	L1171
4283  0252 c60009        	ld	a,_sicp_buf+9
4284  0255 c1009e        	cp	a,_st1+39
4285  0258 274a          	jreq	L1171
4286                     ; 850 							st1.st_ges3_ctrl_H						= sicp_buf[8];
4288  025a 550008009d    	mov	_st1+38,_sicp_buf+8
4289                     ; 851 							st1.st_ges3_ctrl_L						= sicp_buf[9];
4291  025f 550009009e    	mov	_st1+39,_sicp_buf+9
4292                     ; 852 							st1.st_ges3_ctrl_meshid_H 		= sicp_buf[10];
4294  0264 55000a009f    	mov	_st1+40,_sicp_buf+10
4295                     ; 853 							st1.st_ges3_ctrl_meshid_L 		= sicp_buf[11];
4297  0269 55000b00a0    	mov	_st1+41,_sicp_buf+11
4298                     ; 854 							st1.st_ges3_ctrl_boardid 			= sicp_buf[12];
4300  026e 55000c00a1    	mov	_st1+42,_sicp_buf+12
4301                     ; 855 							st1.st_ges3_ctrl_action				= sicp_buf[13];
4303  0273 55000d00ad    	mov	_st1+54,_sicp_buf+13
4304                     ; 856 							st1.st_ges3_ctrl_action_value = sicp_buf[14];
4306  0278 55000e00ae    	mov	_st1+55,_sicp_buf+14
4307                     ; 858 							receipt_conf_gest1 = 1;
4309  027d 721000c4      	bset	_UART1Flag6_,#0
4310                     ; 859 							send_message_length = 6;
4312  0281 35060064      	mov	_send_message_length,#6
4313                     ; 860 							send_cmd = 0xAA;
4315  0285 35aa0063      	mov	_send_cmd,#170
4316                     ; 861 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4318  0289 4baa          	push	#170
4319  028b 4b06          	push	#6
4320  028d 3b006a        	push	_ns_host_meshid_L
4321  0290 c6006b        	ld	a,_ns_host_meshid_H
4322  0293 97            	ld	xl,a
4323  0294 c60069        	ld	a,_rev_message_id
4324  0297 95            	ld	xh,a
4325  0298 cd0000        	call	_send_header_payload_init
4327  029b 5b03          	addw	sp,#3
4328                     ; 862 							UART2_Send_Data_Start();
4330  029d cd0000        	call	_UART2_Send_Data_Start
4332                     ; 863 							break;
4334  02a0 ac710671      	jpf	L5561
4335  02a4               L1171:
4336                     ; 865 						else if((st1.st_ges4_ctrl_H == 0x11) && (st1.st_ges4_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges4_ctrl_H) && (sicp_buf[9] != st1.st_ges4_ctrl_L))//第三个预设置手势
4338  02a4 c600a2        	ld	a,_st1+43
4339  02a7 a111          	cp	a,#17
4340  02a9 2661          	jrne	L5171
4342  02ab c600a3        	ld	a,_st1+44
4343  02ae a111          	cp	a,#17
4344  02b0 265a          	jrne	L5171
4346  02b2 c60008        	ld	a,_sicp_buf+8
4347  02b5 c100a2        	cp	a,_st1+43
4348  02b8 2752          	jreq	L5171
4350  02ba c60009        	ld	a,_sicp_buf+9
4351  02bd c100a3        	cp	a,_st1+44
4352  02c0 274a          	jreq	L5171
4353                     ; 867 							st1.st_ges4_ctrl_H						= sicp_buf[8];
4355  02c2 55000800a2    	mov	_st1+43,_sicp_buf+8
4356                     ; 868 							st1.st_ges4_ctrl_L						= sicp_buf[9];
4358  02c7 55000900a3    	mov	_st1+44,_sicp_buf+9
4359                     ; 869 							st1.st_ges4_ctrl_meshid_H 		= sicp_buf[10];
4361  02cc 55000a00a4    	mov	_st1+45,_sicp_buf+10
4362                     ; 870 							st1.st_ges4_ctrl_meshid_L 		= sicp_buf[11];
4364  02d1 55000b00a5    	mov	_st1+46,_sicp_buf+11
4365                     ; 871 							st1.st_ges4_ctrl_boardid 			= sicp_buf[12];
4367  02d6 55000c00a6    	mov	_st1+47,_sicp_buf+12
4368                     ; 872 							st1.st_ges4_ctrl_action				= sicp_buf[13];
4370  02db 55000d00b0    	mov	_st1+57,_sicp_buf+13
4371                     ; 873 							st1.st_ges4_ctrl_action_value = sicp_buf[14];
4373  02e0 55000e00b1    	mov	_st1+58,_sicp_buf+14
4374                     ; 875 							receipt_conf_gest1 = 1;
4376  02e5 721000c4      	bset	_UART1Flag6_,#0
4377                     ; 876 							send_message_length = 6;
4379  02e9 35060064      	mov	_send_message_length,#6
4380                     ; 877 							send_cmd = 0xAA;
4382  02ed 35aa0063      	mov	_send_cmd,#170
4383                     ; 878 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4385  02f1 4baa          	push	#170
4386  02f3 4b06          	push	#6
4387  02f5 3b006a        	push	_ns_host_meshid_L
4388  02f8 c6006b        	ld	a,_ns_host_meshid_H
4389  02fb 97            	ld	xl,a
4390  02fc c60069        	ld	a,_rev_message_id
4391  02ff 95            	ld	xh,a
4392  0300 cd0000        	call	_send_header_payload_init
4394  0303 5b03          	addw	sp,#3
4395                     ; 879 							UART2_Send_Data_Start();
4397  0305 cd0000        	call	_UART2_Send_Data_Start
4399                     ; 880 							break;
4401  0308 ac710671      	jpf	L5561
4402  030c               L5171:
4403                     ; 882 						else if(((sicp_buf[8] == st1.st_ges1_ctrl_H) && (sicp_buf[9] == st1.st_ges1_ctrl_L))
4403                     ; 883 										|| ((sicp_buf[8] == st1.st_ges2_ctrl_H) && (sicp_buf[9] == st1.st_ges2_ctrl_L))
4403                     ; 884 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L))
4403                     ; 885 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L)))
4405  030c c60008        	ld	a,_sicp_buf+8
4406  030f c10093        	cp	a,_st1+28
4407  0312 2608          	jrne	L5271
4409  0314 c60009        	ld	a,_sicp_buf+9
4410  0317 c10094        	cp	a,_st1+29
4411  031a 2720          	jreq	L3271
4412  031c               L5271:
4414  031c c60008        	ld	a,_sicp_buf+8
4415  031f c10098        	cp	a,_st1+33
4416  0322 2608          	jrne	L1371
4418  0324 c60009        	ld	a,_sicp_buf+9
4419  0327 c10099        	cp	a,_st1+34
4420  032a 2710          	jreq	L3271
4421  032c               L1371:
4423  032c c60008        	ld	a,_sicp_buf+8
4424  032f c1009d        	cp	a,_st1+38
4425  0332 262f          	jrne	L1271
4427  0334 c60009        	ld	a,_sicp_buf+9
4428  0337 c1009e        	cp	a,_st1+39
4429  033a 2627          	jrne	L1271
4430  033c               L3271:
4431                     ; 887 							receipt_conf_gest1 = 1;
4433  033c 721000c4      	bset	_UART1Flag6_,#0
4434                     ; 888 							send_message_length = 6;
4436  0340 35060064      	mov	_send_message_length,#6
4437                     ; 889 							send_cmd = 0xAA;
4439  0344 35aa0063      	mov	_send_cmd,#170
4440                     ; 890 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4442  0348 4baa          	push	#170
4443  034a 4b06          	push	#6
4444  034c 3b006a        	push	_ns_host_meshid_L
4445  034f c6006b        	ld	a,_ns_host_meshid_H
4446  0352 97            	ld	xl,a
4447  0353 c60069        	ld	a,_rev_message_id
4448  0356 95            	ld	xh,a
4449  0357 cd0000        	call	_send_header_payload_init
4451  035a 5b03          	addw	sp,#3
4452                     ; 891 							UART2_Send_Data_Start();
4454  035c cd0000        	call	_UART2_Send_Data_Start
4456                     ; 892 							break;
4458  035f ac710671      	jpf	L5561
4459  0363               L1271:
4460                     ; 896 							receipt_conf_gest2 = 1;
4462  0363 721200c4      	bset	_UART1Flag6_,#1
4463                     ; 897 							send_message_length = 6;
4465  0367 35060064      	mov	_send_message_length,#6
4466                     ; 898 							send_cmd = 0xAA;
4468  036b 35aa0063      	mov	_send_cmd,#170
4469                     ; 899 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4471  036f 4baa          	push	#170
4472  0371 4b06          	push	#6
4473  0373 3b006a        	push	_ns_host_meshid_L
4474  0376 c6006b        	ld	a,_ns_host_meshid_H
4475  0379 97            	ld	xl,a
4476  037a c60069        	ld	a,_rev_message_id
4477  037d 95            	ld	xh,a
4478  037e cd0000        	call	_send_header_payload_init
4480  0381 5b03          	addw	sp,#3
4481                     ; 900 							UART2_Send_Data_Start();
4483  0383 cd0000        	call	_UART2_Send_Data_Start
4485                     ; 901 							break;
4487  0386 ac710671      	jpf	L5561
4488  038a               L1751:
4489                     ; 906 			case 0xAA://SS回复ST的Device Info，Kick Out踢出
4489                     ; 907 				if (sicp_buf[7] == 0x04)
4491  038a c60007        	ld	a,_sicp_buf+7
4492  038d a104          	cp	a,#4
4493  038f 2703          	jreq	L051
4494  0391 cc0671        	jp	L5561
4495  0394               L051:
4496                     ; 909 					kickout_flag = 1;
4498  0394 721000c6      	bset	_UART1Flag4_,#0
4499  0398 ac710671      	jpf	L5561
4500  039c               L3751:
4501                     ; 918 			case 0xC0://BLE 网络模块重置指令
4501                     ; 919 				if (sicp_buf[7] == 0x02)
4504  039c c60007        	ld	a,_sicp_buf+7
4505  039f a102          	cp	a,#2
4506  03a1 2703          	jreq	L251
4507  03a3 cc0671        	jp	L5561
4508  03a6               L251:
4509                     ; 921 					net_reset_flag = 1;
4511  03a6 721200c6      	bset	_UART1Flag4_,#1
4512  03aa ac710671      	jpf	L5561
4513  03ae               L5751:
4514                     ; 924 			case 0x03://CMD-Data 
4514                     ; 925 				if (sicp_buf[7] == 0x01)//获取ST传感器信息
4516  03ae c60007        	ld	a,_sicp_buf+7
4517  03b1 a101          	cp	a,#1
4518  03b3 262d          	jrne	L1471
4519                     ; 927 					if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32))
4521  03b5 c60008        	ld	a,_sicp_buf+8
4522  03b8 a130          	cp	a,#48
4523  03ba 2626          	jrne	L1471
4525  03bc c60009        	ld	a,_sicp_buf+9
4526  03bf a132          	cp	a,#50
4527  03c1 261f          	jrne	L1471
4528                     ; 929 						send_message_length = 9;
4530  03c3 35090064      	mov	_send_message_length,#9
4531                     ; 930 						send_cmd = 0x20;
4533  03c7 35200063      	mov	_send_cmd,#32
4534                     ; 931 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4536  03cb 4b20          	push	#32
4537  03cd 4b09          	push	#9
4538  03cf 3b006a        	push	_ns_host_meshid_L
4539  03d2 c6006b        	ld	a,_ns_host_meshid_H
4540  03d5 97            	ld	xl,a
4541  03d6 c60069        	ld	a,_rev_message_id
4542  03d9 95            	ld	xh,a
4543  03da cd0000        	call	_send_header_payload_init
4545  03dd 5b03          	addw	sp,#3
4546                     ; 932 						UART2_Send_Data_Start();
4548  03df cd0000        	call	_UART2_Send_Data_Start
4550  03e2               L1471:
4551                     ; 935 				if (sicp_buf[7] == 0x02)//刷新ST传感器数据
4553  03e2 c60007        	ld	a,_sicp_buf+7
4554  03e5 a102          	cp	a,#2
4555  03e7 2623          	jrne	L5471
4556                     ; 937 					cmd_refresh_flag = 1;
4558  03e9 721400c9      	bset	_UART1Flag1_,#2
4559                     ; 938 					send_message_length = 6;
4561  03ed 35060064      	mov	_send_message_length,#6
4562                     ; 939 					send_cmd = 0xAA;
4564  03f1 35aa0063      	mov	_send_cmd,#170
4565                     ; 940 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4567  03f5 4baa          	push	#170
4568  03f7 4b06          	push	#6
4569  03f9 3b006a        	push	_ns_host_meshid_L
4570  03fc c6006b        	ld	a,_ns_host_meshid_H
4571  03ff 97            	ld	xl,a
4572  0400 c60069        	ld	a,_rev_message_id
4573  0403 95            	ld	xh,a
4574  0404 cd0000        	call	_send_header_payload_init
4576  0407 5b03          	addw	sp,#3
4577                     ; 941 					UART2_Send_Data_Start();
4579  0409 cd0000        	call	_UART2_Send_Data_Start
4581  040c               L5471:
4582                     ; 943 				if (sicp_buf[7] == 0x03)//获取ST当前设备的状态(灯亮度、开关)
4584  040c c60007        	ld	a,_sicp_buf+7
4585  040f a103          	cp	a,#3
4586  0411 2703          	jreq	L451
4587  0413 cc0671        	jp	L5561
4588  0416               L451:
4589                     ; 945 					cmd_status_flag = 1;
4591  0416 721600c9      	bset	_UART1Flag1_,#3
4592                     ; 947 					send_message_length = 10;
4594  041a 350a0064      	mov	_send_message_length,#10
4595                     ; 948 					send_cmd = 0x06;
4597  041e 35060063      	mov	_send_cmd,#6
4598                     ; 949 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4600  0422 4b06          	push	#6
4601  0424 4b0a          	push	#10
4602  0426 3b006a        	push	_ns_host_meshid_L
4603  0429 c6006b        	ld	a,_ns_host_meshid_H
4604  042c 97            	ld	xl,a
4605  042d c60069        	ld	a,_rev_message_id
4606  0430 95            	ld	xh,a
4607  0431 cd0000        	call	_send_header_payload_init
4609  0434 5b03          	addw	sp,#3
4610                     ; 950 					UART2_Send_Data_Start();
4612  0436 cd0000        	call	_UART2_Send_Data_Start
4614  0439 ac710671      	jpf	L5561
4615  043d               L7751:
4616                     ; 953 			case 0x56://打开或关闭ST开关
4616                     ; 954 				action_ctrlpad_flag = 1;
4618  043d 721800c9      	bset	_UART1Flag1_,#4
4619                     ; 955 				st1.st_ctrl_address = sicp_buf[7];
4621  0441 550007007a    	mov	_st1+3,_sicp_buf+7
4622                     ; 956 				if((sicp_buf[7] & 0x01) == 0x01)
4624  0446 c60007        	ld	a,_sicp_buf+7
4625  0449 a401          	and	a,#1
4626  044b a101          	cp	a,#1
4627  044d 2604          	jrne	L1571
4628                     ; 957 					st_pad1_ctrl = 1;
4630  044f 721200c7      	bset	_UART1Flag3_,#1
4631  0453               L1571:
4632                     ; 958 				if((sicp_buf[7] & 0x02) == 0x02)
4634  0453 c60007        	ld	a,_sicp_buf+7
4635  0456 a402          	and	a,#2
4636  0458 a102          	cp	a,#2
4637  045a 2604          	jrne	L3571
4638                     ; 959 					st_pad2_ctrl = 1;
4640  045c 721400c7      	bset	_UART1Flag3_,#2
4641  0460               L3571:
4642                     ; 960 				if((sicp_buf[7] & 0x04) == 0x04)
4644  0460 c60007        	ld	a,_sicp_buf+7
4645  0463 a404          	and	a,#4
4646  0465 a104          	cp	a,#4
4647  0467 2604          	jrne	L5571
4648                     ; 961 					st_pad3_ctrl = 1;
4650  0469 721600c7      	bset	_UART1Flag3_,#3
4651  046d               L5571:
4652                     ; 962 				if((sicp_buf[7] & 0x08) == 0x08)
4654  046d c60007        	ld	a,_sicp_buf+7
4655  0470 a408          	and	a,#8
4656  0472 a108          	cp	a,#8
4657  0474 2604          	jrne	L7571
4658                     ; 963 					st_led_ctrl = 1;
4660  0476 721000c7      	bset	_UART1Flag3_,#0
4661  047a               L7571:
4662                     ; 964 				st1.st_ctrl_value  = sicp_buf[8];
4664  047a 550008007b    	mov	_st1+4,_sicp_buf+8
4665                     ; 965 				send_message_length = 10;
4667  047f 350a0064      	mov	_send_message_length,#10
4668                     ; 966 				send_cmd = 0xAA;
4670  0483 35aa0063      	mov	_send_cmd,#170
4671                     ; 967 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4673  0487 4baa          	push	#170
4674  0489 4b0a          	push	#10
4675  048b 3b006a        	push	_ns_host_meshid_L
4676  048e c6006b        	ld	a,_ns_host_meshid_H
4677  0491 97            	ld	xl,a
4678  0492 c60069        	ld	a,_rev_message_id
4679  0495 95            	ld	xh,a
4680  0496 cd0000        	call	_send_header_payload_init
4682  0499 5b03          	addw	sp,#3
4683                     ; 969 				UART2_Send_Data_Start();
4685  049b cd0000        	call	_UART2_Send_Data_Start
4687                     ; 970 				break;
4689  049e ac710671      	jpf	L5561
4690  04a2               L1061:
4691                     ; 971 			case 0x09://LED控制
4691                     ; 972 				led_ctrl_flag = 1;
4693  04a2 721400c6      	bset	_UART1Flag4_,#2
4694                     ; 973 				switch(sicp_buf[7])
4696  04a6 c60007        	ld	a,_sicp_buf+7
4698                     ; 1040 						break;
4699  04a9 a01f          	sub	a,#31
4700  04ab 271d          	jreq	L3061
4701  04ad a010          	sub	a,#16
4702  04af 2768          	jreq	L5061
4703  04b1 a010          	sub	a,#16
4704  04b3 2603          	jrne	L651
4705  04b5 cc0572        	jp	L7061
4706  04b8               L651:
4707  04b8 a010          	sub	a,#16
4708  04ba 2603          	jrne	L061
4709  04bc cc05c1        	jp	L1161
4710  04bf               L061:
4711  04bf a010          	sub	a,#16
4712  04c1 2603          	jrne	L261
4713  04c3 cc05e8        	jp	L3161
4714  04c6               L261:
4715  04c6 ac710671      	jpf	L5561
4716  04ca               L3061:
4717                     ; 975 					case 0x1F://循环模式
4717                     ; 976 						st1.st_led_mode = 0x1F;
4719  04ca 351f00b3      	mov	_st1+60,#31
4720                     ; 977 						st1.st_led_density = sicp_buf[8];
4722  04ce 55000800b4    	mov	_st1+61,_sicp_buf+8
4723                     ; 978 						st1.st_led_speed = sicp_buf[9];
4725  04d3 55000900b5    	mov	_st1+62,_sicp_buf+9
4726                     ; 979 						st1.st_led_color1_H = sicp_buf[10];
4728  04d8 55000a00b6    	mov	_st1+63,_sicp_buf+10
4729                     ; 980 						st1.st_led_color1_M = sicp_buf[11];
4731  04dd 55000b00b7    	mov	_st1+64,_sicp_buf+11
4732                     ; 981 						st1.st_led_color1_L = sicp_buf[12];
4734  04e2 55000c00b8    	mov	_st1+65,_sicp_buf+12
4735                     ; 982 						st1.st_led_color2_H = sicp_buf[13];
4737  04e7 55000d00b9    	mov	_st1+66,_sicp_buf+13
4738                     ; 983 						st1.st_led_color2_M = sicp_buf[14];
4740  04ec 55000e00ba    	mov	_st1+67,_sicp_buf+14
4741                     ; 984 						st1.st_led_color2_L = sicp_buf[15];
4743  04f1 55000f00bb    	mov	_st1+68,_sicp_buf+15
4744                     ; 985 						send_message_length = 6;
4746  04f6 35060064      	mov	_send_message_length,#6
4747                     ; 986 						send_cmd = 0xAA;
4749  04fa 35aa0063      	mov	_send_cmd,#170
4750                     ; 987 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4752  04fe 4baa          	push	#170
4753  0500 4b06          	push	#6
4754  0502 3b006a        	push	_ns_host_meshid_L
4755  0505 c6006b        	ld	a,_ns_host_meshid_H
4756  0508 97            	ld	xl,a
4757  0509 c60069        	ld	a,_rev_message_id
4758  050c 95            	ld	xh,a
4759  050d cd0000        	call	_send_header_payload_init
4761  0510 5b03          	addw	sp,#3
4762                     ; 989 						UART2_Send_Data_Start();
4764  0512 cd0000        	call	_UART2_Send_Data_Start
4766                     ; 990 						break;
4768  0515 ac710671      	jpf	L5561
4769  0519               L5061:
4770                     ; 991 					case 0x2F://呼吸灯模式
4770                     ; 992 						st1.st_led_mode = 0x2F;
4772  0519 352f00b3      	mov	_st1+60,#47
4773                     ; 993 						st1.st_led_in		= sicp_buf[8];
4775  051d 55000800bc    	mov	_st1+69,_sicp_buf+8
4776                     ; 994 						st1.st_led_duration = sicp_buf[9];
4778  0522 55000900bd    	mov	_st1+70,_sicp_buf+9
4779                     ; 995 						st1.st_led_out	= sicp_buf[10];
4781  0527 55000a00be    	mov	_st1+71,_sicp_buf+10
4782                     ; 996 						st1.st_led_blank = sicp_buf[11];
4784  052c 55000b00bf    	mov	_st1+72,_sicp_buf+11
4785                     ; 997 						st1.st_led_color1_H = sicp_buf[12];
4787  0531 55000c00b6    	mov	_st1+63,_sicp_buf+12
4788                     ; 998 						st1.st_led_color1_M = sicp_buf[13];
4790  0536 55000d00b7    	mov	_st1+64,_sicp_buf+13
4791                     ; 999 						st1.st_led_color1_L = sicp_buf[14];
4793  053b 55000e00b8    	mov	_st1+65,_sicp_buf+14
4794                     ; 1000 						st1.st_led_color2_H = sicp_buf[15];
4796  0540 55000f00b9    	mov	_st1+66,_sicp_buf+15
4797                     ; 1001 						st1.st_led_color2_M = sicp_buf[16];
4799  0545 55001000ba    	mov	_st1+67,_sicp_buf+16
4800                     ; 1002 						st1.st_led_color2_L = sicp_buf[17];
4802  054a 55001100bb    	mov	_st1+68,_sicp_buf+17
4803                     ; 1003 						send_message_length = 6;
4805  054f 35060064      	mov	_send_message_length,#6
4806                     ; 1004 						send_cmd = 0xAA;
4808  0553 35aa0063      	mov	_send_cmd,#170
4809                     ; 1005 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4811  0557 4baa          	push	#170
4812  0559 4b06          	push	#6
4813  055b 3b006a        	push	_ns_host_meshid_L
4814  055e c6006b        	ld	a,_ns_host_meshid_H
4815  0561 97            	ld	xl,a
4816  0562 c60069        	ld	a,_rev_message_id
4817  0565 95            	ld	xh,a
4818  0566 cd0000        	call	_send_header_payload_init
4820  0569 5b03          	addw	sp,#3
4821                     ; 1007 						UART2_Send_Data_Start();
4823  056b cd0000        	call	_UART2_Send_Data_Start
4825                     ; 1008 						break;
4827  056e ac710671      	jpf	L5561
4828  0572               L7061:
4829                     ; 1009 					case 0x3F://颜色变化模式，从一个主颜色渐变黑色再变到另一个主颜色
4829                     ; 1010 						st1.st_led_mode = 0x3F;
4831  0572 353f00b3      	mov	_st1+60,#63
4832                     ; 1011 						st1.st_led_in		= sicp_buf[8];
4834  0576 55000800bc    	mov	_st1+69,_sicp_buf+8
4835                     ; 1012 						st1.st_led_duration = sicp_buf[9];
4837  057b 55000900bd    	mov	_st1+70,_sicp_buf+9
4838                     ; 1013 						st1.st_led_color1_H = sicp_buf[10];
4840  0580 55000a00b6    	mov	_st1+63,_sicp_buf+10
4841                     ; 1014 						st1.st_led_color1_M = sicp_buf[11];
4843  0585 55000b00b7    	mov	_st1+64,_sicp_buf+11
4844                     ; 1015 						st1.st_led_color1_L = sicp_buf[12];
4846  058a 55000c00b8    	mov	_st1+65,_sicp_buf+12
4847                     ; 1016 						st1.st_led_color2_H = sicp_buf[13];
4849  058f 55000d00b9    	mov	_st1+66,_sicp_buf+13
4850                     ; 1017 						st1.st_led_color2_M = sicp_buf[14];
4852  0594 55000e00ba    	mov	_st1+67,_sicp_buf+14
4853                     ; 1018 						st1.st_led_color2_L = sicp_buf[15];
4855  0599 55000f00bb    	mov	_st1+68,_sicp_buf+15
4856                     ; 1019 						send_message_length = 6;
4858  059e 35060064      	mov	_send_message_length,#6
4859                     ; 1020 						send_cmd = 0xAA;
4861  05a2 35aa0063      	mov	_send_cmd,#170
4862                     ; 1021 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4864  05a6 4baa          	push	#170
4865  05a8 4b06          	push	#6
4866  05aa 3b006a        	push	_ns_host_meshid_L
4867  05ad c6006b        	ld	a,_ns_host_meshid_H
4868  05b0 97            	ld	xl,a
4869  05b1 c60069        	ld	a,_rev_message_id
4870  05b4 95            	ld	xh,a
4871  05b5 cd0000        	call	_send_header_payload_init
4873  05b8 5b03          	addw	sp,#3
4874                     ; 1023 						UART2_Send_Data_Start();
4876  05ba cd0000        	call	_UART2_Send_Data_Start
4878                     ; 1024 						break;
4880  05bd ac710671      	jpf	L5561
4881  05c1               L1161:
4882                     ; 1025 					case 0x4F://指示灯模式，把LED的显示权交给设备
4882                     ; 1026 						st1.st_led_mode = 0x4F;
4884  05c1 354f00b3      	mov	_st1+60,#79
4885                     ; 1027 						send_message_length = 6;
4887  05c5 35060064      	mov	_send_message_length,#6
4888                     ; 1028 						send_cmd = 0xAA;
4890  05c9 35aa0063      	mov	_send_cmd,#170
4891                     ; 1029 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4893  05cd 4baa          	push	#170
4894  05cf 4b06          	push	#6
4895  05d1 3b006a        	push	_ns_host_meshid_L
4896  05d4 c6006b        	ld	a,_ns_host_meshid_H
4897  05d7 97            	ld	xl,a
4898  05d8 c60069        	ld	a,_rev_message_id
4899  05db 95            	ld	xh,a
4900  05dc cd0000        	call	_send_header_payload_init
4902  05df 5b03          	addw	sp,#3
4903                     ; 1031 						UART2_Send_Data_Start();
4905  05e1 cd0000        	call	_UART2_Send_Data_Start
4907                     ; 1032 						break;
4909  05e4 ac710671      	jpf	L5561
4910  05e8               L3161:
4911                     ; 1033 					case 0x5F://关闭模式。关闭所有LED显示 
4911                     ; 1034 						st1.st_led_mode = 0x5F;
4913  05e8 355f00b3      	mov	_st1+60,#95
4914                     ; 1035 						send_message_length = 6;
4916  05ec 35060064      	mov	_send_message_length,#6
4917                     ; 1036 						send_cmd = 0xAA;
4919  05f0 35aa0063      	mov	_send_cmd,#170
4920                     ; 1037 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4922  05f4 4baa          	push	#170
4923  05f6 4b06          	push	#6
4924  05f8 3b006a        	push	_ns_host_meshid_L
4925  05fb c6006b        	ld	a,_ns_host_meshid_H
4926  05fe 97            	ld	xl,a
4927  05ff c60069        	ld	a,_rev_message_id
4928  0602 95            	ld	xh,a
4929  0603 cd0000        	call	_send_header_payload_init
4931  0606 5b03          	addw	sp,#3
4932                     ; 1039 						UART2_Send_Data_Start();
4934  0608 cd0000        	call	_UART2_Send_Data_Start
4936                     ; 1040 						break;
4938  060b 2064          	jra	L5561
4939  060d               L3671:
4940                     ; 1042 				break;
4942  060d 2062          	jra	L5561
4943  060f               L5161:
4944                     ; 1043 			case 0x05://用于加载预装的报警信息，若此方法激活，则忽略所有 LED方法
4944                     ; 1044 				load_alert_flag = 1;
4946  060f 721600c6      	bset	_UART1Flag4_,#3
4947                     ; 1045 				st1.st_load_alert = sicp_buf[7];
4949  0613 55000700c0    	mov	_st1+73,_sicp_buf+7
4950                     ; 1046 				send_message_length = 6;
4952  0618 35060064      	mov	_send_message_length,#6
4953                     ; 1047 				send_cmd = 0xAA;
4955  061c 35aa0063      	mov	_send_cmd,#170
4956                     ; 1048 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4958  0620 4baa          	push	#170
4959  0622 4b06          	push	#6
4960  0624 3b006a        	push	_ns_host_meshid_L
4961  0627 c6006b        	ld	a,_ns_host_meshid_H
4962  062a 97            	ld	xl,a
4963  062b c60069        	ld	a,_rev_message_id
4964  062e 95            	ld	xh,a
4965  062f cd0000        	call	_send_header_payload_init
4967  0632 5b03          	addw	sp,#3
4968                     ; 1050 				UART2_Send_Data_Start();
4970  0634 cd0000        	call	_UART2_Send_Data_Start
4972                     ; 1051 				break;
4974  0637 2038          	jra	L5561
4975  0639               L7161:
4976                     ; 1052 			case 0xB0://Gateway	Mesh	ID	Broadcasting
4976                     ; 1053 				if(sicp_buf[2] == 0x9E){
4978  0639 c60002        	ld	a,_sicp_buf+2
4979  063c a19e          	cp	a,#158
4980  063e 2631          	jrne	L5561
4981                     ; 1054 					rev_host_mesh = 1;receipt_host_mesh = 1;
4983  0640 721c00c8      	bset	_UART1Flag2_,#6
4986  0644 721400c4      	bset	_UART1Flag6_,#2
4987                     ; 1055 					ns_host_meshid_H = sicp_buf[3];
4989  0648 550003006b    	mov	_ns_host_meshid_H,_sicp_buf+3
4990                     ; 1056 					ns_host_meshid_L = sicp_buf[4];
4992  064d 550004006a    	mov	_ns_host_meshid_L,_sicp_buf+4
4993                     ; 1057 					send_message_length = 6;
4995  0652 35060064      	mov	_send_message_length,#6
4996                     ; 1058 					send_cmd = 0xAA;
4998  0656 35aa0063      	mov	_send_cmd,#170
4999                     ; 1059 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5001  065a 4baa          	push	#170
5002  065c 4b06          	push	#6
5003  065e 3b006a        	push	_ns_host_meshid_L
5004  0661 c6006b        	ld	a,_ns_host_meshid_H
5005  0664 97            	ld	xl,a
5006  0665 c60069        	ld	a,_rev_message_id
5007  0668 95            	ld	xh,a
5008  0669 cd0000        	call	_send_header_payload_init
5010  066c 5b03          	addw	sp,#3
5011                     ; 1060 					UART2_Send_Data_Start();
5013  066e cd0000        	call	_UART2_Send_Data_Start
5015  0671               L1261:
5016                     ; 1063 			default:
5016                     ; 1064 				break;
5018  0671               L5561:
5019                     ; 1067 		return TRUE;
5021  0671 a601          	ld	a,#1
5024  0673 81            	ret
5025  0674               L1561:
5026                     ; 1069 	else if (ble_ctrl_frame)
5028  0674 c600c9        	ld	a,_UART1Flag1_
5029  0677 a540          	bcp	a,#64
5030  0679 275e          	jreq	L1771
5031                     ; 1071 		ble_ctrl_frame = 0;
5033  067b 721d00c9      	bres	_UART1Flag1_,#6
5034                     ; 1072 		switch(sicp_buf[4])
5036  067f c60004        	ld	a,_sicp_buf+4
5038                     ; 1098 				break;
5039  0682 4a            	dec	a
5040  0683 2708          	jreq	L3261
5041  0685 4a            	dec	a
5042  0686 2724          	jreq	L5261
5043  0688 4a            	dec	a
5044  0689 2729          	jreq	L7261
5045  068b 2049          	jra	L5771
5046  068d               L3261:
5047                     ; 1074 			case 0x01://网络状态帧
5047                     ; 1075 				rev_bleheartbeat = 1;
5049  068d 721e00c9      	bset	_UART1Flag1_,#7
5050                     ; 1076 				ns_signal = sicp_buf[5];
5052  0691 5500050070    	mov	_ns_signal,_sicp_buf+5
5053                     ; 1077 				ns_status = sicp_buf[6];
5055  0696 550006006f    	mov	_ns_status,_sicp_buf+6
5056                     ; 1078 				ns_phonenum = sicp_buf[7];
5058  069b 550007006e    	mov	_ns_phonenum,_sicp_buf+7
5059                     ; 1079 				ns_own_meshid_H = sicp_buf[8];
5061  06a0 550008006d    	mov	_ns_own_meshid_H,_sicp_buf+8
5062                     ; 1080 				ns_own_meshid_L = sicp_buf[9];
5064  06a5 550009006c    	mov	_ns_own_meshid_L,_sicp_buf+9
5065                     ; 1083 				break;
5067  06aa 202a          	jra	L5771
5068  06ac               L5261:
5069                     ; 1084 			case 0x02://重置芯片，清空串口缓存，保留mesh连接
5069                     ; 1085 				Variable_Init();
5071  06ac cd0000        	call	_Variable_Init
5073                     ; 1086 				clear_sicp_buf();
5075  06af cd0000        	call	_clear_sicp_buf
5077                     ; 1087 				break;
5079  06b2 2022          	jra	L5771
5080  06b4               L7261:
5081                     ; 1088 			case 0x03://重置芯片和网络，退出mesh连接
5081                     ; 1089 				Variable_Init();
5083  06b4 cd0000        	call	_Variable_Init
5085                     ; 1090 				clear_sicp_buf();
5087  06b7 cd0000        	call	_clear_sicp_buf
5089                     ; 1091 				ns_signal = 0x00;
5091  06ba 725f0070      	clr	_ns_signal
5092                     ; 1092 				ns_status = 0x00;
5094  06be 725f006f      	clr	_ns_status
5095                     ; 1093 				ns_phonenum = 0x00;
5097  06c2 725f006e      	clr	_ns_phonenum
5098                     ; 1094 				ns_own_meshid_H = 0x00;
5100  06c6 725f006d      	clr	_ns_own_meshid_H
5101                     ; 1095 				ns_own_meshid_L = 0x00;
5103  06ca 725f006c      	clr	_ns_own_meshid_L
5104                     ; 1096 				ns_host_meshid_H = 0x80;
5106  06ce 3580006b      	mov	_ns_host_meshid_H,#128
5107                     ; 1097 				ns_host_meshid_L = 0xFF;
5109  06d2 35ff006a      	mov	_ns_host_meshid_L,#255
5110                     ; 1098 				break;
5112  06d6               L5771:
5113                     ; 1129 		return TRUE;
5115  06d6 a601          	ld	a,#1
5118  06d8 81            	ret
5119  06d9               L1771:
5120                     ; 1133 		return FALSE;
5122  06d9 4f            	clr	a
5125  06da 81            	ret
5180                     ; 1142 void reve_analyze_reply(void)
5180                     ; 1143 {
5181                     .text:	section	.text,new
5182  0000               _reve_analyze_reply:
5184  0000 89            	pushw	x
5185       00000002      OFST:	set	2
5188                     ; 1144 	if (rev_success)
5190  0001 c600c9        	ld	a,_UART1Flag1_
5191  0004 a501          	bcp	a,#1
5192  0006 271b          	jreq	L1102
5193                     ; 1146 		rev_success = 0;
5195  0008 721100c9      	bres	_UART1Flag1_,#0
5196                     ; 1147 		rev_header_anaylze(&rev_message_id,&rev_meshid_H,&rev_meshid_L,&rev_message_length);
5198  000c ae0067        	ldw	x,#_rev_message_length
5199  000f 89            	pushw	x
5200  0010 ae0065        	ldw	x,#_rev_meshid_L
5201  0013 89            	pushw	x
5202  0014 ae0066        	ldw	x,#_rev_meshid_H
5203  0017 89            	pushw	x
5204  0018 ae0069        	ldw	x,#_rev_message_id
5205  001b cd0000        	call	_rev_header_anaylze
5207  001e 5b06          	addw	sp,#6
5208                     ; 1148 		rev_payload_anaylze();
5210  0020 cd0000        	call	_rev_payload_anaylze
5212  0023               L1102:
5213                     ; 1156 	if (receipt_send_failed)
5215  0023 c600c5        	ld	a,_UART1Flag5_
5216  0026 a520          	bcp	a,#32
5217  0028 273a          	jreq	L3102
5218                     ; 1158 		receipt_send_failed = 0;
5220  002a 721b00c5      	bres	_UART1Flag5_,#5
5221                     ; 1159 		st_pad1_ctrl = st_pad_temp._flag_bit.bit0;
5223                     	btst		_st_pad_temp,#0
5224  0033 901300c7      	bccm	_UART1Flag3_,#1
5225                     ; 1160 		st_pad2_ctrl = st_pad_temp._flag_bit.bit1;
5227                     	btst		_st_pad_temp,#1
5228  003c 901500c7      	bccm	_UART1Flag3_,#2
5229                     ; 1161 		st_pad3_ctrl = st_pad_temp._flag_bit.bit2;
5231                     	btst		_st_pad_temp,#2
5232  0045 901700c7      	bccm	_UART1Flag3_,#3
5233                     ; 1162 		st_pad1_confirm = st_pad_temp._flag_bit.bit3;
5235                     	btst		_st_pad_temp,#3
5236  004e 901900c7      	bccm	_UART1Flag3_,#4
5237                     ; 1163 		st_pad2_confirm = st_pad_temp._flag_bit.bit4;
5239                     	btst		_st_pad_temp,#4
5240  0057 901b00c7      	bccm	_UART1Flag3_,#5
5241                     ; 1164 		st_pad3_confirm = st_pad_temp._flag_bit.bit5;
5243                     	btst		_st_pad_temp,#5
5244  0060 901d00c7      	bccm	_UART1Flag3_,#6
5245  0064               L3102:
5246                     ; 1167 	if (receipt_send_failed)
5248  0064 c600c5        	ld	a,_UART1Flag5_
5249  0067 a520          	bcp	a,#32
5250  0069 270e          	jreq	L5102
5251                     ; 1169 		receipt_send_failed = 0;
5253  006b 721b00c5      	bres	_UART1Flag5_,#5
5254                     ; 1170 		st1.st_ges_H = st1_st_ges_H_temp;
5256  006f 5500c30077    	mov	_st1,_st1_st_ges_H_temp
5257                     ; 1171 		st1.st_ges_L = st1_st_ges_L_temp;
5259  0074 5500c20078    	mov	_st1+1,_st1_st_ges_L_temp
5260  0079               L5102:
5261                     ; 1174 	if (st_pad1_ctrl | st_pad2_ctrl | st_pad3_ctrl)
5263  0079 4f            	clr	a
5264                     	btst	_UART1Flag3_,#3
5265  007f 49            	rlc	a
5266  0080 6b02          	ld	(OFST+0,sp),a
5267  0082 4f            	clr	a
5268                     	btst	_UART1Flag3_,#2
5269  0088 49            	rlc	a
5270  0089 6b01          	ld	(OFST-1,sp),a
5271  008b c600c7        	ld	a,_UART1Flag3_
5272  008e 44            	srl	a
5273  008f a401          	and	a,#1
5274  0091 1a01          	or	a,(OFST-1,sp)
5275  0093 1a02          	or	a,(OFST+0,sp)
5276  0095 2603          	jrne	L661
5277  0097 cc0278        	jp	L7102
5278  009a               L661:
5279                     ; 1177 		if(st_pad1_confirm | st_pad2_confirm | st_pad3_confirm)
5281  009a 4f            	clr	a
5282                     	btst	_UART1Flag3_,#6
5283  00a0 49            	rlc	a
5284  00a1 6b02          	ld	(OFST+0,sp),a
5285  00a3 4f            	clr	a
5286                     	btst	_UART1Flag3_,#5
5287  00a9 49            	rlc	a
5288  00aa 6b01          	ld	(OFST-1,sp),a
5289  00ac 4f            	clr	a
5290                     	btst	_UART1Flag3_,#4
5291  00b2 49            	rlc	a
5292  00b3 1a01          	or	a,(OFST-1,sp)
5293  00b5 1a02          	or	a,(OFST+0,sp)
5294  00b7 2603          	jrne	L071
5295  00b9 cc01f8        	jp	L1202
5296  00bc               L071:
5297                     ; 1179 			st_pad_temp._flag_bit.bit0 = st_pad1_ctrl;
5299                     	btst		_UART1Flag3_,#1
5300  00c1 901100c1      	bccm	_st_pad_temp,#0
5301                     ; 1180 			st_pad_temp._flag_bit.bit1 = st_pad2_ctrl;
5303                     	btst		_UART1Flag3_,#2
5304  00ca 901300c1      	bccm	_st_pad_temp,#1
5305                     ; 1181 			st_pad_temp._flag_bit.bit2 = st_pad3_ctrl;
5307                     	btst		_UART1Flag3_,#3
5308  00d3 901500c1      	bccm	_st_pad_temp,#2
5309                     ; 1182 			st_pad_temp._flag_bit.bit3 = st_pad1_confirm;
5311                     	btst		_UART1Flag3_,#4
5312  00dc 901700c1      	bccm	_st_pad_temp,#3
5313                     ; 1183 			st_pad_temp._flag_bit.bit4 = st_pad2_confirm;
5315                     	btst		_UART1Flag3_,#5
5316  00e5 901900c1      	bccm	_st_pad_temp,#4
5317                     ; 1184 			st_pad_temp._flag_bit.bit5 = st_pad3_confirm;
5319                     	btst		_UART1Flag3_,#6
5320  00ee 901b00c1      	bccm	_st_pad_temp,#5
5321                     ; 1186 				generate_messageid = random(TIM4->CNTR);
5323  00f2 c65344        	ld	a,21316
5324  00f5 cd0000        	call	_random
5326  00f8 c70060        	ld	_generate_messageid,a
5327                     ; 1187 				pad_set_message_id = generate_messageid;
5329  00fb 5500600072    	mov	_pad_set_message_id,_generate_messageid
5330                     ; 1188 				send_message_length = 8;
5332  0100 35080064      	mov	_send_message_length,#8
5333                     ; 1190 				if (st_pad1_confirm)//预设置按键1被触发
5335  0104 c600c7        	ld	a,_UART1Flag3_
5336  0107 a510          	bcp	a,#16
5337  0109 2720          	jreq	L3202
5338                     ; 1192 					send_cmd = st1.st_pad1_ctrl_action;
5340  010b 5500870063    	mov	_send_cmd,_st1+16
5341                     ; 1193 					st_pad1_ctrl = 0;
5343  0110 721300c7      	bres	_UART1Flag3_,#1
5344                     ; 1194 					send_header_payload_init(pad_set_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
5346  0114 3b0063        	push	_send_cmd
5347  0117 4b08          	push	#8
5348  0119 3b0085        	push	_st1+14
5349  011c c60084        	ld	a,_st1+13
5350  011f 97            	ld	xl,a
5351  0120 c60072        	ld	a,_pad_set_message_id
5352  0123 95            	ld	xh,a
5353  0124 cd0000        	call	_send_header_payload_init
5355  0127 5b03          	addw	sp,#3
5357  0129 204c          	jra	L5202
5358  012b               L3202:
5359                     ; 1196 				else if (st_pad2_confirm)
5361  012b c600c7        	ld	a,_UART1Flag3_
5362  012e a520          	bcp	a,#32
5363  0130 2720          	jreq	L7202
5364                     ; 1198 					send_cmd = st1.st_pad2_ctrl_action;
5366  0132 55008c0063    	mov	_send_cmd,_st1+21
5367                     ; 1199 					st_pad2_ctrl = 0;
5369  0137 721500c7      	bres	_UART1Flag3_,#2
5370                     ; 1200 					send_header_payload_init(pad_set_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
5372  013b 3b0063        	push	_send_cmd
5373  013e 4b08          	push	#8
5374  0140 3b008a        	push	_st1+19
5375  0143 c60089        	ld	a,_st1+18
5376  0146 97            	ld	xl,a
5377  0147 c60072        	ld	a,_pad_set_message_id
5378  014a 95            	ld	xh,a
5379  014b cd0000        	call	_send_header_payload_init
5381  014e 5b03          	addw	sp,#3
5383  0150 2025          	jra	L5202
5384  0152               L7202:
5385                     ; 1202 				else if (st_pad3_confirm)
5387  0152 c600c7        	ld	a,_UART1Flag3_
5388  0155 a540          	bcp	a,#64
5389  0157 271e          	jreq	L5202
5390                     ; 1204 					send_cmd = st1.st_pad3_ctrl_action;
5392  0159 5500910063    	mov	_send_cmd,_st1+26
5393                     ; 1205 					st_pad3_ctrl = 0;
5395  015e 721700c7      	bres	_UART1Flag3_,#3
5396                     ; 1206 					send_header_payload_init(pad_set_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
5398  0162 3b0063        	push	_send_cmd
5399  0165 4b08          	push	#8
5400  0167 3b008f        	push	_st1+24
5401  016a c6008e        	ld	a,_st1+23
5402  016d 97            	ld	xl,a
5403  016e c60072        	ld	a,_pad_set_message_id
5404  0171 95            	ld	xh,a
5405  0172 cd0000        	call	_send_header_payload_init
5407  0175 5b03          	addw	sp,#3
5408  0177               L5202:
5409                     ; 1209 				UART2_Send_Data_Start();
5411  0177 cd0000        	call	_UART2_Send_Data_Start
5413                     ; 1210 				delay(300);
5415  017a ae012c        	ldw	x,#300
5416  017d cd0000        	call	_delay
5418                     ; 1213 				clear_send_buf();
5420  0180 cd0000        	call	_clear_send_buf
5422                     ; 1214 				send_message_length = 14;
5424  0183 350e0064      	mov	_send_message_length,#14
5425                     ; 1215 				send_cmd = 0x08;
5427  0187 35080063      	mov	_send_cmd,#8
5428                     ; 1216 				if (st_pad1_confirm)//预设置按键1被触发
5430  018b c600c7        	ld	a,_UART1Flag3_
5431  018e a510          	bcp	a,#16
5432  0190 271a          	jreq	L5302
5433                     ; 1218 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5435  0192 4b08          	push	#8
5436  0194 4b0e          	push	#14
5437  0196 3b006a        	push	_ns_host_meshid_L
5438  0199 c6006b        	ld	a,_ns_host_meshid_H
5439  019c 97            	ld	xl,a
5440  019d c60072        	ld	a,_pad_set_message_id
5441  01a0 95            	ld	xh,a
5442  01a1 cd0000        	call	_send_header_payload_init
5444  01a4 5b03          	addw	sp,#3
5445                     ; 1219 					st_pad1_confirm = 0;
5447  01a6 721900c7      	bres	_UART1Flag3_,#4
5449  01aa 2040          	jra	L7302
5450  01ac               L5302:
5451                     ; 1221 				else if (st_pad2_confirm)
5453  01ac c600c7        	ld	a,_UART1Flag3_
5454  01af a520          	bcp	a,#32
5455  01b1 271a          	jreq	L1402
5456                     ; 1224 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5458  01b3 4b08          	push	#8
5459  01b5 4b0e          	push	#14
5460  01b7 3b006a        	push	_ns_host_meshid_L
5461  01ba c6006b        	ld	a,_ns_host_meshid_H
5462  01bd 97            	ld	xl,a
5463  01be c60072        	ld	a,_pad_set_message_id
5464  01c1 95            	ld	xh,a
5465  01c2 cd0000        	call	_send_header_payload_init
5467  01c5 5b03          	addw	sp,#3
5468                     ; 1225 					st_pad2_confirm = 0;
5470  01c7 721b00c7      	bres	_UART1Flag3_,#5
5472  01cb 201f          	jra	L7302
5473  01cd               L1402:
5474                     ; 1227 				else if(st_pad3_confirm)
5476  01cd c600c7        	ld	a,_UART1Flag3_
5477  01d0 a540          	bcp	a,#64
5478  01d2 2718          	jreq	L7302
5479                     ; 1230 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5481  01d4 4b08          	push	#8
5482  01d6 4b0e          	push	#14
5483  01d8 3b006a        	push	_ns_host_meshid_L
5484  01db c6006b        	ld	a,_ns_host_meshid_H
5485  01de 97            	ld	xl,a
5486  01df c60072        	ld	a,_pad_set_message_id
5487  01e2 95            	ld	xh,a
5488  01e3 cd0000        	call	_send_header_payload_init
5490  01e6 5b03          	addw	sp,#3
5491                     ; 1231 					st_pad2_confirm = 0;
5493  01e8 721b00c7      	bres	_UART1Flag3_,#5
5494  01ec               L7302:
5495                     ; 1233 				UART2_Send_Data_Start();
5497  01ec cd0000        	call	_UART2_Send_Data_Start
5499                     ; 1234 				delay(10);
5501  01ef ae000a        	ldw	x,#10
5502  01f2 cd0000        	call	_delay
5505  01f5 cc0278        	jra	L7102
5506  01f8               L1202:
5507                     ; 1238 			generate_messageid = random(TIM4->CNTR);
5509  01f8 c65344        	ld	a,21316
5510  01fb cd0000        	call	_random
5512  01fe c70060        	ld	_generate_messageid,a
5513                     ; 1239 			pad_noset_message_id = generate_messageid;
5515  0201 5500600073    	mov	_pad_noset_message_id,_generate_messageid
5516                     ; 1240 			send_message_length = 7;
5518  0206 35070064      	mov	_send_message_length,#7
5519                     ; 1241 			send_cmd = 0x35;
5521  020a 35350063      	mov	_send_cmd,#53
5522                     ; 1242 			if (st_pad1_ctrl)
5524  020e c600c7        	ld	a,_UART1Flag3_
5525  0211 a502          	bcp	a,#2
5526  0213 271a          	jreq	L1502
5527                     ; 1244 				st_pad1_ctrl = 0;
5529  0215 721300c7      	bres	_UART1Flag3_,#1
5530                     ; 1245 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5532  0219 4b35          	push	#53
5533  021b 4b07          	push	#7
5534  021d 3b006a        	push	_ns_host_meshid_L
5535  0220 c6006b        	ld	a,_ns_host_meshid_H
5536  0223 97            	ld	xl,a
5537  0224 c60073        	ld	a,_pad_noset_message_id
5538  0227 95            	ld	xh,a
5539  0228 cd0000        	call	_send_header_payload_init
5541  022b 5b03          	addw	sp,#3
5543  022d 2040          	jra	L3502
5544  022f               L1502:
5545                     ; 1247 			else if (st_pad2_ctrl)
5547  022f c600c7        	ld	a,_UART1Flag3_
5548  0232 a504          	bcp	a,#4
5549  0234 271a          	jreq	L5502
5550                     ; 1249 				st_pad2_ctrl = 0;
5552  0236 721500c7      	bres	_UART1Flag3_,#2
5553                     ; 1250 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5555  023a 4b35          	push	#53
5556  023c 4b07          	push	#7
5557  023e 3b006a        	push	_ns_host_meshid_L
5558  0241 c6006b        	ld	a,_ns_host_meshid_H
5559  0244 97            	ld	xl,a
5560  0245 c60073        	ld	a,_pad_noset_message_id
5561  0248 95            	ld	xh,a
5562  0249 cd0000        	call	_send_header_payload_init
5564  024c 5b03          	addw	sp,#3
5566  024e 201f          	jra	L3502
5567  0250               L5502:
5568                     ; 1252 			else if (st_pad3_ctrl)
5570  0250 c600c7        	ld	a,_UART1Flag3_
5571  0253 a508          	bcp	a,#8
5572  0255 2718          	jreq	L3502
5573                     ; 1254 				st_pad3_ctrl = 0;
5575  0257 721700c7      	bres	_UART1Flag3_,#3
5576                     ; 1255 				send_header_payload_init(gesture_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5578  025b 4b35          	push	#53
5579  025d 4b07          	push	#7
5580  025f 3b006a        	push	_ns_host_meshid_L
5581  0262 c6006b        	ld	a,_ns_host_meshid_H
5582  0265 97            	ld	xl,a
5583  0266 c60075        	ld	a,_gesture_noset_message_id
5584  0269 95            	ld	xh,a
5585  026a cd0000        	call	_send_header_payload_init
5587  026d 5b03          	addw	sp,#3
5588  026f               L3502:
5589                     ; 1257 			UART2_Send_Data_Start();
5591  026f cd0000        	call	_UART2_Send_Data_Start
5593                     ; 1258 			delay(10);
5595  0272 ae000a        	ldw	x,#10
5596  0275 cd0000        	call	_delay
5598  0278               L7102:
5599                     ; 1265 	if(gest_detect){
5601  0278 c600c8        	ld	a,_UART1Flag2_
5602  027b a501          	bcp	a,#1
5603  027d 2603          	jrne	L271
5604  027f cc043b        	jp	L3602
5605  0282               L271:
5606                     ; 1266 		gest_detect = 0;
5608  0282 721100c8      	bres	_UART1Flag2_,#0
5609                     ; 1267 		gest_confirm();
5611  0286 cd0000        	call	_gest_confirm
5613                     ; 1268 		if ((st1.st_ges_H != 0x00) && (st1.st_ges_L != 0x00))
5615  0289 725d0077      	tnz	_st1
5616  028d 2603          	jrne	L471
5617  028f cc043b        	jp	L3602
5618  0292               L471:
5620  0292 725d0078      	tnz	_st1+1
5621  0296 2603          	jrne	L671
5622  0298 cc043b        	jp	L3602
5623  029b               L671:
5624                     ; 1270 			st1_st_ges_H_temp = st1.st_ges_H;
5626  029b 55007700c3    	mov	_st1_st_ges_H_temp,_st1
5627                     ; 1271 			st1_st_ges_L_temp = st1.st_ges_L;
5629  02a0 55007800c2    	mov	_st1_st_ges_L_temp,_st1+1
5630                     ; 1274 			if((!gest1_confirm) && (!gest2_confirm) && (!gest3_confirm) && (!gest4_confirm))
5632  02a5 c600c8        	ld	a,_UART1Flag2_
5633  02a8 a504          	bcp	a,#4
5634  02aa 2658          	jrne	L7602
5636  02ac c600c8        	ld	a,_UART1Flag2_
5637  02af a508          	bcp	a,#8
5638  02b1 2651          	jrne	L7602
5640  02b3 c600c8        	ld	a,_UART1Flag2_
5641  02b6 a510          	bcp	a,#16
5642  02b8 264a          	jrne	L7602
5644  02ba c600c8        	ld	a,_UART1Flag2_
5645  02bd a520          	bcp	a,#32
5646  02bf 2643          	jrne	L7602
5647                     ; 1276 				receipt_gesture1 = 0;//清除接收到该指令回执
5649  02c1 721500c5      	bres	_UART1Flag5_,#2
5650                     ; 1277 				generate_messageid = random(TIM4->CNTR);
5652  02c5 c65344        	ld	a,21316
5653  02c8 cd0000        	call	_random
5655  02cb c70060        	ld	_generate_messageid,a
5656                     ; 1278 				gesture_noset_message_id = generate_messageid;
5658  02ce 5500600075    	mov	_gesture_noset_message_id,_generate_messageid
5659                     ; 1280 				send_message_length = 8;
5661  02d3 35080064      	mov	_send_message_length,#8
5662                     ; 1281 				send_cmd = 0x29;
5664  02d7 35290063      	mov	_send_cmd,#41
5665                     ; 1282 				send_header_payload_init(gesture_noset_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5667  02db 4b29          	push	#41
5668  02dd 4b08          	push	#8
5669  02df 3b006c        	push	_ns_own_meshid_L
5670  02e2 c6006d        	ld	a,_ns_own_meshid_H
5671  02e5 97            	ld	xl,a
5672  02e6 c60075        	ld	a,_gesture_noset_message_id
5673  02e9 95            	ld	xh,a
5674  02ea cd0000        	call	_send_header_payload_init
5676  02ed 5b03          	addw	sp,#3
5677                     ; 1284 				UART2_Send_Data_Start();
5679  02ef cd0000        	call	_UART2_Send_Data_Start
5681                     ; 1285 				delay(10);
5683  02f2 ae000a        	ldw	x,#10
5684  02f5 cd0000        	call	_delay
5686                     ; 1286 				st1.st_ges_H = 0x00;
5688  02f8 725f0077      	clr	_st1
5689                     ; 1287 				st1.st_ges_L = 0x00;
5691  02fc 725f0078      	clr	_st1+1
5693  0300 ac3b043b      	jpf	L3602
5694  0304               L7602:
5695                     ; 1291 				receipt_gesture2 = 0;//清除接收到该指令回执
5697  0304 721700c5      	bres	_UART1Flag5_,#3
5698                     ; 1292 				generate_messageid = random(TIM4->CNTR);
5700  0308 c65344        	ld	a,21316
5701  030b cd0000        	call	_random
5703  030e c70060        	ld	_generate_messageid,a
5704                     ; 1293 				gesture_set_message_id = generate_messageid;
5706  0311 5500600074    	mov	_gesture_set_message_id,_generate_messageid
5707                     ; 1294 				send_message_length = 8;
5709  0316 35080064      	mov	_send_message_length,#8
5710                     ; 1296 				if (gest1_confirm)
5712  031a c600c8        	ld	a,_UART1Flag2_
5713  031d a504          	bcp	a,#4
5714  031f 271c          	jreq	L3702
5715                     ; 1298 					send_cmd = st1.st_ges1_ctrl_action_value;
5717  0321 5500a80063    	mov	_send_cmd,_st1+49
5718                     ; 1299 					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
5720  0326 3b0063        	push	_send_cmd
5721  0329 4b08          	push	#8
5722  032b 3b0096        	push	_st1+31
5723  032e c60095        	ld	a,_st1+30
5724  0331 97            	ld	xl,a
5725  0332 c60074        	ld	a,_gesture_set_message_id
5726  0335 95            	ld	xh,a
5727  0336 cd0000        	call	_send_header_payload_init
5729  0339 5b03          	addw	sp,#3
5731  033b 2067          	jra	L5702
5732  033d               L3702:
5733                     ; 1301 				else if (gest2_confirm)
5735  033d c600c8        	ld	a,_UART1Flag2_
5736  0340 a508          	bcp	a,#8
5737  0342 271c          	jreq	L7702
5738                     ; 1303 					send_cmd = st1.st_ges2_ctrl_action_value;
5740  0344 5500ab0063    	mov	_send_cmd,_st1+52
5741                     ; 1304 					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
5743  0349 3b0063        	push	_send_cmd
5744  034c 4b08          	push	#8
5745  034e 3b009b        	push	_st1+36
5746  0351 c6009a        	ld	a,_st1+35
5747  0354 97            	ld	xl,a
5748  0355 c60060        	ld	a,_generate_messageid
5749  0358 95            	ld	xh,a
5750  0359 cd0000        	call	_send_header_payload_init
5752  035c 5b03          	addw	sp,#3
5754  035e 2044          	jra	L5702
5755  0360               L7702:
5756                     ; 1306 				else if (gest3_confirm)
5758  0360 c600c8        	ld	a,_UART1Flag2_
5759  0363 a510          	bcp	a,#16
5760  0365 271c          	jreq	L3012
5761                     ; 1308 					send_cmd = st1.st_ges3_ctrl_action_value;
5763  0367 5500ae0063    	mov	_send_cmd,_st1+55
5764                     ; 1309 					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
5766  036c 3b0063        	push	_send_cmd
5767  036f 4b08          	push	#8
5768  0371 3b00a0        	push	_st1+41
5769  0374 c6009f        	ld	a,_st1+40
5770  0377 97            	ld	xl,a
5771  0378 c60060        	ld	a,_generate_messageid
5772  037b 95            	ld	xh,a
5773  037c cd0000        	call	_send_header_payload_init
5775  037f 5b03          	addw	sp,#3
5777  0381 2021          	jra	L5702
5778  0383               L3012:
5779                     ; 1311 				else if (gest4_confirm)
5781  0383 c600c8        	ld	a,_UART1Flag2_
5782  0386 a520          	bcp	a,#32
5783  0388 271a          	jreq	L5702
5784                     ; 1313 					send_cmd = st1.st_ges4_ctrl_action_value;
5786  038a 5500b10063    	mov	_send_cmd,_st1+58
5787                     ; 1314 					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
5789  038f 3b0063        	push	_send_cmd
5790  0392 4b08          	push	#8
5791  0394 3b00a5        	push	_st1+46
5792  0397 c600a4        	ld	a,_st1+45
5793  039a 97            	ld	xl,a
5794  039b c60060        	ld	a,_generate_messageid
5795  039e 95            	ld	xh,a
5796  039f cd0000        	call	_send_header_payload_init
5798  03a2 5b03          	addw	sp,#3
5799  03a4               L5702:
5800                     ; 1317 				UART2_Send_Data_Start();
5802  03a4 cd0000        	call	_UART2_Send_Data_Start
5804                     ; 1319 				delay(300);
5806  03a7 ae012c        	ldw	x,#300
5807  03aa cd0000        	call	_delay
5809                     ; 1320 				clear_send_buf();
5811  03ad cd0000        	call	_clear_send_buf
5813                     ; 1321 				send_message_length = 14;
5815  03b0 350e0064      	mov	_send_message_length,#14
5816                     ; 1322 				send_cmd = 0x08;
5818  03b4 35080063      	mov	_send_cmd,#8
5819                     ; 1323 				if (gest1_confirm)
5821  03b8 c600c8        	ld	a,_UART1Flag2_
5822  03bb a504          	bcp	a,#4
5823  03bd 2716          	jreq	L1112
5824                     ; 1325 					send_header_payload_init(gesture_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5826  03bf 4b08          	push	#8
5827  03c1 4b0e          	push	#14
5828  03c3 3b006a        	push	_ns_host_meshid_L
5829  03c6 c6006b        	ld	a,_ns_host_meshid_H
5830  03c9 97            	ld	xl,a
5831  03ca c60074        	ld	a,_gesture_set_message_id
5832  03cd 95            	ld	xh,a
5833  03ce cd0000        	call	_send_header_payload_init
5835  03d1 5b03          	addw	sp,#3
5837  03d3 2055          	jra	L3112
5838  03d5               L1112:
5839                     ; 1327 				else if (gest2_confirm)
5841  03d5 c600c8        	ld	a,_UART1Flag2_
5842  03d8 a508          	bcp	a,#8
5843  03da 2716          	jreq	L5112
5844                     ; 1329 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5846  03dc 4b08          	push	#8
5847  03de 4b0e          	push	#14
5848  03e0 3b006a        	push	_ns_host_meshid_L
5849  03e3 c6006b        	ld	a,_ns_host_meshid_H
5850  03e6 97            	ld	xl,a
5851  03e7 c60060        	ld	a,_generate_messageid
5852  03ea 95            	ld	xh,a
5853  03eb cd0000        	call	_send_header_payload_init
5855  03ee 5b03          	addw	sp,#3
5857  03f0 2038          	jra	L3112
5858  03f2               L5112:
5859                     ; 1331 				else if (gest3_confirm)
5861  03f2 c600c8        	ld	a,_UART1Flag2_
5862  03f5 a510          	bcp	a,#16
5863  03f7 2716          	jreq	L1212
5864                     ; 1333 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5866  03f9 4b08          	push	#8
5867  03fb 4b0e          	push	#14
5868  03fd 3b006a        	push	_ns_host_meshid_L
5869  0400 c6006b        	ld	a,_ns_host_meshid_H
5870  0403 97            	ld	xl,a
5871  0404 c60060        	ld	a,_generate_messageid
5872  0407 95            	ld	xh,a
5873  0408 cd0000        	call	_send_header_payload_init
5875  040b 5b03          	addw	sp,#3
5877  040d 201b          	jra	L3112
5878  040f               L1212:
5879                     ; 1335 				else if (gest4_confirm)
5881  040f c600c8        	ld	a,_UART1Flag2_
5882  0412 a520          	bcp	a,#32
5883  0414 2714          	jreq	L3112
5884                     ; 1337 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5886  0416 4b08          	push	#8
5887  0418 4b0e          	push	#14
5888  041a 3b006a        	push	_ns_host_meshid_L
5889  041d c6006b        	ld	a,_ns_host_meshid_H
5890  0420 97            	ld	xl,a
5891  0421 c60060        	ld	a,_generate_messageid
5892  0424 95            	ld	xh,a
5893  0425 cd0000        	call	_send_header_payload_init
5895  0428 5b03          	addw	sp,#3
5896  042a               L3112:
5897                     ; 1340 				UART2_Send_Data_Start();
5899  042a cd0000        	call	_UART2_Send_Data_Start
5901                     ; 1341 				delay(10);
5903  042d ae000a        	ldw	x,#10
5904  0430 cd0000        	call	_delay
5906                     ; 1342 				st1.st_ges_H = 0x00;
5908  0433 725f0077      	clr	_st1
5909                     ; 1343 				st1.st_ges_L = 0x00;
5911  0437 725f0078      	clr	_st1+1
5912  043b               L3602:
5913                     ; 1350 	if ((st1.st_device_status & 0xFF) < 0xFF)//ST有故障,有0无1
5915  043b 9c            	rvf
5916  043c c60079        	ld	a,_st1+2
5917  043f 5f            	clrw	x
5918  0440 97            	ld	xl,a
5919  0441 a300ff        	cpw	x,#255
5920  0444 2e3d          	jrsge	L7212
5921                     ; 1352 		send_fault_count++;
5923  0446 ce005c        	ldw	x,_send_fault_count
5924  0449 1c0001        	addw	x,#1
5925  044c cf005c        	ldw	_send_fault_count,x
5926                     ; 1353 		if (send_fault_count >= 500)
5928  044f ce005c        	ldw	x,_send_fault_count
5929  0452 a301f4        	cpw	x,#500
5930  0455 252c          	jrult	L7212
5931                     ; 1355 			send_fault_count = 0;
5933  0457 5f            	clrw	x
5934  0458 cf005c        	ldw	_send_fault_count,x
5935                     ; 1356 			generate_messageid = random(TIM4->CNTR);
5937  045b c65344        	ld	a,21316
5938  045e cd0000        	call	_random
5940  0461 c70060        	ld	_generate_messageid,a
5941                     ; 1357 			send_message_length = 7;
5943  0464 35070064      	mov	_send_message_length,#7
5944                     ; 1358 			send_cmd = 0x0A;
5946  0468 350a0063      	mov	_send_cmd,#10
5947                     ; 1359 			send_header_payload_init(generate_messageid,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5949  046c 4b0a          	push	#10
5950  046e 4b07          	push	#7
5951  0470 3b006c        	push	_ns_own_meshid_L
5952  0473 c6006d        	ld	a,_ns_own_meshid_H
5953  0476 97            	ld	xl,a
5954  0477 c60060        	ld	a,_generate_messageid
5955  047a 95            	ld	xh,a
5956  047b cd0000        	call	_send_header_payload_init
5958  047e 5b03          	addw	sp,#3
5959                     ; 1361 			UART2_Send_Data_Start();
5961  0480 cd0000        	call	_UART2_Send_Data_Start
5963  0483               L7212:
5964                     ; 1364 }
5967  0483 85            	popw	x
5968  0484 81            	ret
5981                     	xref	_memcpy
5982                     	xref	_UART2_ITConfig
5983                     	xref	_UART2_Cmd
5984                     	xref	_UART2_Init
5985                     	xref	_UART2_DeInit
5986                     	xref	_rand
5987                     	xref	_malloc
5988                     	xref	_free
5989                     	xdef	_gest_confirm
5990                     	xdef	_pad_confirm
5991                     	xdef	_rev_payload_anaylze
5992                     	xdef	_rev_header_anaylze
5993                     	xdef	_send_header_payload_init
5994                     	xdef	_reve_analyze_reply
5995                     	xdef	_random
5996                     	xdef	_rev_deal
5997                     	xdef	_Check_Sum
5998                     	xdef	_clear_send_buf
5999                     	xdef	_clear_sicp_buf
6000                     	xdef	_UART2_Send_Data_Start
6001                     	xdef	_UART2_Send_Data_Init
6002                     	xdef	_UART2_RX_ISR
6003                     	xdef	_UART2_TX_ISR
6004                     	xdef	_Init_uart2
6005                     	xdef	_deleteNodeFromUart2TxSLHead
6006                     	xdef	_addNodeToUart2TxSLLast
6007                     	switch	.bss
6008  0000               _sicp_buf:
6009  0000 000000000000  	ds.b	30
6010                     	xdef	_sicp_buf
6011  001e               _rev_buf:
6012  001e 000000000000  	ds.b	30
6013                     	xdef	_rev_buf
6014  003c               _send_buf:
6015  003c 000000000000  	ds.b	30
6016                     	xdef	_send_buf
6017  005a               _send_failed_count:
6018  005a 0000          	ds.b	2
6019                     	xdef	_send_failed_count
6020  005c               _send_fault_count:
6021  005c 0000          	ds.b	2
6022                     	xdef	_send_fault_count
6023  005e               _rev_count:
6024  005e 00            	ds.b	1
6025                     	xdef	_rev_count
6026  005f               _send_count:
6027  005f 00            	ds.b	1
6028                     	xdef	_send_count
6029  0060               _generate_messageid:
6030  0060 00            	ds.b	1
6031                     	xdef	_generate_messageid
6032  0061               _send_meshid_L:
6033  0061 00            	ds.b	1
6034                     	xdef	_send_meshid_L
6035  0062               _send_meshid_H:
6036  0062 00            	ds.b	1
6037                     	xdef	_send_meshid_H
6038  0063               _send_cmd:
6039  0063 00            	ds.b	1
6040                     	xdef	_send_cmd
6041  0064               _send_message_length:
6042  0064 00            	ds.b	1
6043                     	xdef	_send_message_length
6044  0065               _rev_meshid_L:
6045  0065 00            	ds.b	1
6046                     	xdef	_rev_meshid_L
6047  0066               _rev_meshid_H:
6048  0066 00            	ds.b	1
6049                     	xdef	_rev_meshid_H
6050  0067               _rev_message_length:
6051  0067 00            	ds.b	1
6052                     	xdef	_rev_message_length
6053  0068               _rev_module_id:
6054  0068 00            	ds.b	1
6055                     	xdef	_rev_module_id
6056  0069               _rev_message_id:
6057  0069 00            	ds.b	1
6058                     	xdef	_rev_message_id
6059  006a               _ns_host_meshid_L:
6060  006a 00            	ds.b	1
6061                     	xdef	_ns_host_meshid_L
6062  006b               _ns_host_meshid_H:
6063  006b 00            	ds.b	1
6064                     	xdef	_ns_host_meshid_H
6065  006c               _ns_own_meshid_L:
6066  006c 00            	ds.b	1
6067                     	xdef	_ns_own_meshid_L
6068  006d               _ns_own_meshid_H:
6069  006d 00            	ds.b	1
6070                     	xdef	_ns_own_meshid_H
6071  006e               _ns_phonenum:
6072  006e 00            	ds.b	1
6073                     	xdef	_ns_phonenum
6074  006f               _ns_status:
6075  006f 00            	ds.b	1
6076                     	xdef	_ns_status
6077  0070               _ns_signal:
6078  0070 00            	ds.b	1
6079                     	xdef	_ns_signal
6080  0071               _action_notify_message_id:
6081  0071 00            	ds.b	1
6082                     	xdef	_action_notify_message_id
6083  0072               _pad_set_message_id:
6084  0072 00            	ds.b	1
6085                     	xdef	_pad_set_message_id
6086  0073               _pad_noset_message_id:
6087  0073 00            	ds.b	1
6088                     	xdef	_pad_noset_message_id
6089  0074               _gesture_set_message_id:
6090  0074 00            	ds.b	1
6091                     	xdef	_gesture_set_message_id
6092  0075               _gesture_noset_message_id:
6093  0075 00            	ds.b	1
6094                     	xdef	_gesture_noset_message_id
6095  0076               _device_info_message_id:
6096  0076 00            	ds.b	1
6097                     	xdef	_device_info_message_id
6098  0077               _st1:
6099  0077 000000000000  	ds.b	74
6100                     	xdef	_st1
6101  00c1               _st_pad_temp:
6102  00c1 00            	ds.b	1
6103                     	xdef	_st_pad_temp
6104  00c2               _st1_st_ges_L_temp:
6105  00c2 00            	ds.b	1
6106                     	xdef	_st1_st_ges_L_temp
6107  00c3               _st1_st_ges_H_temp:
6108  00c3 00            	ds.b	1
6109                     	xdef	_st1_st_ges_H_temp
6110  00c4               _UART1Flag6_:
6111  00c4 00            	ds.b	1
6112                     	xdef	_UART1Flag6_
6113  00c5               _UART1Flag5_:
6114  00c5 00            	ds.b	1
6115                     	xdef	_UART1Flag5_
6116  00c6               _UART1Flag4_:
6117  00c6 00            	ds.b	1
6118                     	xdef	_UART1Flag4_
6119  00c7               _UART1Flag3_:
6120  00c7 00            	ds.b	1
6121                     	xdef	_UART1Flag3_
6122  00c8               _UART1Flag2_:
6123  00c8 00            	ds.b	1
6124                     	xdef	_UART1Flag2_
6125  00c9               _UART1Flag1_:
6126  00c9 00            	ds.b	1
6127                     	xdef	_UART1Flag1_
6128  00ca               _uart2TxSLLast:
6129  00ca 0000          	ds.b	2
6130                     	xdef	_uart2TxSLLast
6131  00cc               _uart2TxSLHead:
6132  00cc 0000          	ds.b	2
6133                     	xdef	_uart2TxSLHead
6134  00ce               _mutex2:
6135  00ce 00            	ds.b	1
6136                     	xdef	_mutex2
6137                     	xref	_Variable_Init
6138                     	xref	_delay
6139                     	xref.b	c_x
6140                     	xref.b	c_y
6160                     	xref	c_idiv
6161                     	end
