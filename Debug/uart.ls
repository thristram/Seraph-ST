   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
1151                     ; 26 u8 random(u8 xxx)  
1151                     ; 27 {  
1153                     .text:	section	.text,new
1154  0000               _random:
1156  0000 88            	push	a
1157  0001 89            	pushw	x
1158       00000002      OFST:	set	2
1161                     ; 29   for(iii=0;iii<xxx;iii++)  
1163  0002 0f02          	clr	(OFST+0,sp)
1165  0004 2011          	jra	L365
1166  0006               L755:
1167                     ; 31     value = rand() % (MAX + 1- MIN) + MIN; //获取一个随机数1~255
1169  0006 cd0000        	call	_rand
1171  0009 90ae00ff      	ldw	y,#255
1172  000d cd0000        	call	c_idiv
1174  0010 51            	exgw	x,y
1175  0011 9f            	ld	a,xl
1176  0012 4c            	inc	a
1177  0013 6b01          	ld	(OFST-1,sp),a
1178                     ; 29   for(iii=0;iii<xxx;iii++)  
1180  0015 0c02          	inc	(OFST+0,sp)
1181  0017               L365:
1184  0017 7b02          	ld	a,(OFST+0,sp)
1185  0019 1103          	cp	a,(OFST+1,sp)
1186  001b 25e9          	jrult	L755
1187                     ; 33   return value;  
1189  001d 7b01          	ld	a,(OFST-1,sp)
1192  001f 5b03          	addw	sp,#3
1193  0021 81            	ret
1220                     ; 42 void Init_uart2(void)
1220                     ; 43 {
1221                     .text:	section	.text,new
1222  0000               _Init_uart2:
1226                     ; 44 	UART2_DeInit();
1228  0000 cd0000        	call	_UART2_DeInit
1230                     ; 46 	UART2_Init((u32)57600,UART2_WORDLENGTH_8D,UART2_STOPBITS_1,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,	UART2_MODE_TXRX_ENABLE);
1232  0003 4b0c          	push	#12
1233  0005 4b80          	push	#128
1234  0007 4b00          	push	#0
1235  0009 4b00          	push	#0
1236  000b 4b00          	push	#0
1237  000d aee100        	ldw	x,#57600
1238  0010 89            	pushw	x
1239  0011 ae0000        	ldw	x,#0
1240  0014 89            	pushw	x
1241  0015 cd0000        	call	_UART2_Init
1243  0018 5b09          	addw	sp,#9
1244                     ; 47 	UART2_ITConfig(UART2_IT_TC,ENABLE);//发送完成中断
1246  001a 4b01          	push	#1
1247  001c ae0266        	ldw	x,#614
1248  001f cd0000        	call	_UART2_ITConfig
1250  0022 84            	pop	a
1251                     ; 48 	UART2_ITConfig(UART2_IT_RXNE_OR,ENABLE);//接收非空中断
1253  0023 4b01          	push	#1
1254  0025 ae0205        	ldw	x,#517
1255  0028 cd0000        	call	_UART2_ITConfig
1257  002b 84            	pop	a
1258                     ; 49 	UART2_Cmd(ENABLE);//启用uart1接口
1260  002c a601          	ld	a,#1
1261  002e cd0000        	call	_UART2_Cmd
1263                     ; 50 }
1266  0031 81            	ret
1292                     ; 58 void UART2_Send_Data_Init(void)
1292                     ; 59 {
1293                     .text:	section	.text,new
1294  0000               _UART2_Send_Data_Init:
1298                     ; 60 	send_buf[0] = 0xAA;
1300  0000 35aa003d      	mov	_send_buf,#170
1301                     ; 61 	send_buf[1] = 0xAA;
1303  0004 35aa003e      	mov	_send_buf+1,#170
1304                     ; 62 	send_buf[2] = 0x11;
1306  0008 3511003f      	mov	_send_buf+2,#17
1307                     ; 63 	send_buf[3] = 0x22;
1309  000c 35220040      	mov	_send_buf+3,#34
1310                     ; 64 	send_buf[4] = 13;	//帧头及校验码不计入内
1312  0010 350d0041      	mov	_send_buf+4,#13
1313                     ; 65 	send_buf[5] = 0x01;
1315  0014 35010042      	mov	_send_buf+5,#1
1316                     ; 66 	send_buf[6] = 0x02;
1318  0018 35020043      	mov	_send_buf+6,#2
1319                     ; 67 	send_buf[7] = 0x03;
1321  001c 35030044      	mov	_send_buf+7,#3
1322                     ; 68 	send_buf[8] = 0x04;
1324  0020 35040045      	mov	_send_buf+8,#4
1325                     ; 69 	send_buf[9] = 0x05;
1327  0024 35050046      	mov	_send_buf+9,#5
1328                     ; 70 	send_buf[10] = 0x06;
1330  0028 35060047      	mov	_send_buf+10,#6
1331                     ; 71 	send_buf[11] = 0x07;
1333  002c 35070048      	mov	_send_buf+11,#7
1334                     ; 72 	send_buf[12] = 0x08;
1336  0030 35080049      	mov	_send_buf+12,#8
1337                     ; 73 	send_buf[13] = 0x09;
1339  0034 3509004a      	mov	_send_buf+13,#9
1340                     ; 74 	send_buf[14] = 0x0A;
1342  0038 350a004b      	mov	_send_buf+14,#10
1343                     ; 75 	send_buf[15] = Check_Sum(send_buf,15);
1345  003c 4b0f          	push	#15
1346  003e ae003d        	ldw	x,#_send_buf
1347  0041 cd0000        	call	_Check_Sum
1349  0044 5b01          	addw	sp,#1
1350  0046 c7004c        	ld	_send_buf+15,a
1351                     ; 77 }
1354  0049 81            	ret
1380                     ; 84 void UART2_Send_Data_Start(void)
1380                     ; 85 {
1381                     .text:	section	.text,new
1382  0000               _UART2_Send_Data_Start:
1386                     ; 86 	UART2->DR = send_buf[0];
1388  0000 55003d5241    	mov	21057,_send_buf
1389                     ; 87 	send_count = 1;
1391  0005 35010060      	mov	_send_count,#1
1392                     ; 88 }
1395  0009 81            	ret
1428                     ; 91 void clear_sicp_buf(void)
1428                     ; 92 {
1429                     .text:	section	.text,new
1430  0000               _clear_sicp_buf:
1432  0000 88            	push	a
1433       00000001      OFST:	set	1
1436                     ; 94 	for (i=0;i<30;i++)
1438  0001 0f01          	clr	(OFST+0,sp)
1439  0003               L336:
1440                     ; 96 		sicp_buf[i] = 0;
1442  0003 7b01          	ld	a,(OFST+0,sp)
1443  0005 5f            	clrw	x
1444  0006 97            	ld	xl,a
1445  0007 724f0001      	clr	(_sicp_buf,x)
1446                     ; 94 	for (i=0;i<30;i++)
1448  000b 0c01          	inc	(OFST+0,sp)
1451  000d 7b01          	ld	a,(OFST+0,sp)
1452  000f a11e          	cp	a,#30
1453  0011 25f0          	jrult	L336
1454                     ; 98 }
1457  0013 84            	pop	a
1458  0014 81            	ret
1491                     ; 101 void clear_send_buf(void)
1491                     ; 102 {
1492                     .text:	section	.text,new
1493  0000               _clear_send_buf:
1495  0000 88            	push	a
1496       00000001      OFST:	set	1
1499                     ; 104 	for (i=0;i<30;i++)
1501  0001 0f01          	clr	(OFST+0,sp)
1502  0003               L556:
1503                     ; 106 		send_buf[i] = 0;
1505  0003 7b01          	ld	a,(OFST+0,sp)
1506  0005 5f            	clrw	x
1507  0006 97            	ld	xl,a
1508  0007 724f003d      	clr	(_send_buf,x)
1509                     ; 104 	for (i=0;i<30;i++)
1511  000b 0c01          	inc	(OFST+0,sp)
1514  000d 7b01          	ld	a,(OFST+0,sp)
1515  000f a11e          	cp	a,#30
1516  0011 25f0          	jrult	L556
1517                     ; 108 }
1520  0013 84            	pop	a
1521  0014 81            	ret
1547                     ; 116 @interrupt void UART2_TX_ISR(void)
1547                     ; 117 {
1548                     .text:	section	.text,new
1549  0000               _UART2_TX_ISR:
1552  0000 be00          	ldw	x,c_x
1553  0002 89            	pushw	x
1556                     ; 121 	UART2->SR &= ~0x40;//清除发送完成标志位
1558  0003 721d5240      	bres	21056,#6
1559                     ; 122 	if (send_count < send_buf[5]+3)
1561  0007 9c            	rvf
1562  0008 c60060        	ld	a,_send_count
1563  000b 5f            	clrw	x
1564  000c 97            	ld	xl,a
1565  000d c60042        	ld	a,_send_buf+5
1566  0010 905f          	clrw	y
1567  0012 9097          	ld	yl,a
1568  0014 72a90003      	addw	y,#3
1569  0018 bf01          	ldw	c_x+1,x
1570  001a 90b301        	cpw	y,c_x+1
1571  001d 2d11          	jrsle	L376
1572                     ; 124 		UART2->DR = send_buf[send_count];
1574  001f c60060        	ld	a,_send_count
1575  0022 5f            	clrw	x
1576  0023 97            	ld	xl,a
1577  0024 d6003d        	ld	a,(_send_buf,x)
1578  0027 c75241        	ld	21057,a
1579                     ; 125 		send_count++;
1581  002a 725c0060      	inc	_send_count
1583  002e 2008          	jra	L576
1584  0030               L376:
1585                     ; 129 		send_count = 0;
1587  0030 725f0060      	clr	_send_count
1588                     ; 130 		rev_count = 0;
1590  0034 725f005f      	clr	_rev_count
1591  0038               L576:
1592                     ; 132 }
1595  0038 85            	popw	x
1596  0039 bf00          	ldw	c_x,x
1597  003b 80            	iret
1621                     ; 140 @interrupt void UART2_RX_ISR(void)
1621                     ; 141 {
1622                     .text:	section	.text,new
1623  0000               _UART2_RX_ISR:
1626  0000 3b0002        	push	c_x+2
1627  0003 be00          	ldw	x,c_x
1628  0005 89            	pushw	x
1629  0006 3b0002        	push	c_y+2
1630  0009 be00          	ldw	x,c_y
1631  000b 89            	pushw	x
1634                     ; 142 	rev_deal();
1636  000c cd0000        	call	_rev_deal
1638                     ; 143 }
1641  000f 85            	popw	x
1642  0010 bf00          	ldw	c_y,x
1643  0012 320002        	pop	c_y+2
1644  0015 85            	popw	x
1645  0016 bf00          	ldw	c_x,x
1646  0018 320002        	pop	c_x+2
1647  001b 80            	iret
1703                     ; 151 u8 Check_Sum(u8 *buf,u8 length)
1703                     ; 152 {
1704                     .text:	section	.text,new
1705  0000               _Check_Sum:
1707  0000 89            	pushw	x
1708  0001 89            	pushw	x
1709       00000002      OFST:	set	2
1712                     ; 154 	u8 result = *buf++;
1714  0002 1e03          	ldw	x,(OFST+1,sp)
1715  0004 1c0001        	addw	x,#1
1716  0007 1f03          	ldw	(OFST+1,sp),x
1717  0009 1d0001        	subw	x,#1
1718  000c f6            	ld	a,(x)
1719  000d 6b01          	ld	(OFST-1,sp),a
1720                     ; 155 	for(i = 1;i < length;i++)
1722  000f a601          	ld	a,#1
1723  0011 6b02          	ld	(OFST+0,sp),a
1725  0013 2011          	jra	L737
1726  0015               L337:
1727                     ; 157 		result ^= *buf++;
1729  0015 1e03          	ldw	x,(OFST+1,sp)
1730  0017 1c0001        	addw	x,#1
1731  001a 1f03          	ldw	(OFST+1,sp),x
1732  001c 1d0001        	subw	x,#1
1733  001f 7b01          	ld	a,(OFST-1,sp)
1734  0021 f8            	xor	a,	(x)
1735  0022 6b01          	ld	(OFST-1,sp),a
1736                     ; 155 	for(i = 1;i < length;i++)
1738  0024 0c02          	inc	(OFST+0,sp)
1739  0026               L737:
1742  0026 7b02          	ld	a,(OFST+0,sp)
1743  0028 1107          	cp	a,(OFST+5,sp)
1744  002a 25e9          	jrult	L337
1745                     ; 159 	return result;
1747  002c 7b01          	ld	a,(OFST-1,sp)
1750  002e 5b04          	addw	sp,#4
1751  0030 81            	ret
1809                     ; 167 void rev_deal(void)
1809                     ; 168 {
1810                     .text:	section	.text,new
1811  0000               _rev_deal:
1813  0000 89            	pushw	x
1814       00000002      OFST:	set	2
1817                     ; 171 	temp = (u8)UART2->DR;
1819  0001 c65241        	ld	a,21057
1820  0004 6b02          	ld	(OFST+0,sp),a
1821                     ; 172 	rev_buf[rev_count] = temp;
1823  0006 c6005f        	ld	a,_rev_count
1824  0009 5f            	clrw	x
1825  000a 97            	ld	xl,a
1826  000b 7b02          	ld	a,(OFST+0,sp)
1827  000d d7001f        	ld	(_rev_buf,x),a
1828                     ; 173 	rev_count++;
1830  0010 725c005f      	inc	_rev_count
1831                     ; 174 	switch(rev_count)
1833  0014 c6005f        	ld	a,_rev_count
1835                     ; 233 			break;
1836  0017 4a            	dec	a
1837  0018 2722          	jreq	L347
1838  001a 4a            	dec	a
1839  001b 2739          	jreq	L547
1840  001d 4a            	dec	a
1841  001e 2603          	jrne	L03
1842  0020 cc012b        	jp	L3001
1843  0023               L03:
1844  0023 4a            	dec	a
1845  0024 2603          	jrne	L23
1846  0026 cc012b        	jp	L3001
1847  0029               L23:
1848  0029 4a            	dec	a
1849  002a 2603          	jrne	L43
1850  002c cc012b        	jp	L3001
1851  002f               L43:
1852  002f               L557:
1853                     ; 191 		default:
1853                     ; 192 			if (rev_count > 30)//防止接收错误后溢出
1855  002f c6005f        	ld	a,_rev_count
1856  0032 a11f          	cp	a,#31
1857  0034 2543          	jrult	L1101
1858                     ; 194 				rev_count = 0;
1860  0036 725f005f      	clr	_rev_count
1861  003a 203d          	jra	L1101
1862  003c               L347:
1863                     ; 176 		case 1:
1863                     ; 177 			if ((temp != 0xEE) && (temp != 0xDD))	rev_count = 0;
1865  003c 7b02          	ld	a,(OFST+0,sp)
1866  003e a1ee          	cp	a,#238
1867  0040 2603          	jrne	L63
1868  0042 cc012b        	jp	L3001
1869  0045               L63:
1871  0045 7b02          	ld	a,(OFST+0,sp)
1872  0047 a1dd          	cp	a,#221
1873  0049 2603          	jrne	L04
1874  004b cc012b        	jp	L3001
1875  004e               L04:
1878  004e 725f005f      	clr	_rev_count
1879  0052 ac2b012b      	jpf	L3001
1880  0056               L547:
1881                     ; 179 		case 2:
1881                     ; 180 			if ((temp != 0xEE) && (temp != 0xDD) && (temp != 0xAA)) rev_count = 0;
1883  0056 7b02          	ld	a,(OFST+0,sp)
1884  0058 a1ee          	cp	a,#238
1885  005a 2603          	jrne	L24
1886  005c cc012b        	jp	L3001
1887  005f               L24:
1889  005f 7b02          	ld	a,(OFST+0,sp)
1890  0061 a1dd          	cp	a,#221
1891  0063 2603          	jrne	L44
1892  0065 cc012b        	jp	L3001
1893  0068               L44:
1895  0068 7b02          	ld	a,(OFST+0,sp)
1896  006a a1aa          	cp	a,#170
1897  006c 2603          	jrne	L64
1898  006e cc012b        	jp	L3001
1899  0071               L64:
1902  0071 725f005f      	clr	_rev_count
1903  0075 ac2b012b      	jpf	L3001
1904  0079               L1101:
1905                     ; 196 			if ((rev_buf[0] == 0xEE)&&((rev_buf[1] == 0xEE) ||(rev_buf[1] == 0xAA)))
1907  0079 c6001f        	ld	a,_rev_buf
1908  007c a1ee          	cp	a,#238
1909  007e 2663          	jrne	L3101
1911  0080 c60020        	ld	a,_rev_buf+1
1912  0083 a1ee          	cp	a,#238
1913  0085 2707          	jreq	L5101
1915  0087 c60020        	ld	a,_rev_buf+1
1916  008a a1aa          	cp	a,#170
1917  008c 2655          	jrne	L3101
1918  008e               L5101:
1919                     ; 198 				if (rev_count > rev_buf[5] + 2)//接收数据完成
1921  008e 9c            	rvf
1922  008f c6005f        	ld	a,_rev_count
1923  0092 5f            	clrw	x
1924  0093 97            	ld	xl,a
1925  0094 c60024        	ld	a,_rev_buf+5
1926  0097 905f          	clrw	y
1927  0099 9097          	ld	yl,a
1928  009b 905c          	incw	y
1929  009d 905c          	incw	y
1930  009f bf01          	ldw	c_x+1,x
1931  00a1 90b301        	cpw	y,c_x+1
1932  00a4 2ec8          	jrsge	L3001
1933                     ; 200 					rev_count = 0;
1935  00a6 725f005f      	clr	_rev_count
1936                     ; 201 					check_sum = Check_Sum((rev_buf+2),rev_buf[5]);
1938  00aa 3b0024        	push	_rev_buf+5
1939  00ad ae0021        	ldw	x,#_rev_buf+2
1940  00b0 cd0000        	call	_Check_Sum
1942  00b3 5b01          	addw	sp,#1
1943  00b5 6b02          	ld	(OFST+0,sp),a
1944                     ; 203 					if (check_sum == rev_buf[rev_buf[5] + 2])//校验正确	
1946  00b7 c60024        	ld	a,_rev_buf+5
1947  00ba 5f            	clrw	x
1948  00bb 97            	ld	xl,a
1949  00bc d60021        	ld	a,(_rev_buf+2,x)
1950  00bf 1102          	cp	a,(OFST+0,sp)
1951  00c1 261a          	jrne	L1201
1952                     ; 205 						rev_success = 1;
1954  00c3 721000ca      	bset	_UART1Flag1_,#0
1955                     ; 206 						for (i = 0;i < 30;i++)
1957  00c7 0f02          	clr	(OFST+0,sp)
1958  00c9               L3201:
1959                     ; 208 							sicp_buf[i] = rev_buf[i];
1961  00c9 7b02          	ld	a,(OFST+0,sp)
1962  00cb 5f            	clrw	x
1963  00cc 97            	ld	xl,a
1964  00cd d6001f        	ld	a,(_rev_buf,x)
1965  00d0 d70001        	ld	(_sicp_buf,x),a
1966                     ; 206 						for (i = 0;i < 30;i++)
1968  00d3 0c02          	inc	(OFST+0,sp)
1971  00d5 7b02          	ld	a,(OFST+0,sp)
1972  00d7 a11e          	cp	a,#30
1973  00d9 25ee          	jrult	L3201
1975  00db 204e          	jra	L3001
1976  00dd               L1201:
1977                     ; 213 						rev_count = 0;
1979  00dd 725f005f      	clr	_rev_count
1980  00e1 2048          	jra	L3001
1981  00e3               L3101:
1982                     ; 217 			else if((rev_buf[0] == 0xDD)&&(rev_buf[1] == 0xDD))
1984  00e3 c6001f        	ld	a,_rev_buf
1985  00e6 a1dd          	cp	a,#221
1986  00e8 263d          	jrne	L5301
1988  00ea c60020        	ld	a,_rev_buf+1
1989  00ed a1dd          	cp	a,#221
1990  00ef 2636          	jrne	L5301
1991                     ; 219 				if (rev_count > rev_buf[3] + 2)//接收数据完成
1993  00f1 9c            	rvf
1994  00f2 c6005f        	ld	a,_rev_count
1995  00f5 5f            	clrw	x
1996  00f6 97            	ld	xl,a
1997  00f7 c60022        	ld	a,_rev_buf+3
1998  00fa 905f          	clrw	y
1999  00fc 9097          	ld	yl,a
2000  00fe 905c          	incw	y
2001  0100 905c          	incw	y
2002  0102 bf01          	ldw	c_x+1,x
2003  0104 90b301        	cpw	y,c_x+1
2004  0107 2e22          	jrsge	L3001
2005                     ; 221 					rev_count = 0;
2007  0109 725f005f      	clr	_rev_count
2008                     ; 222 					rev_success = 1;
2010  010d 721000ca      	bset	_UART1Flag1_,#0
2011                     ; 223 					for (i = 0;i < 30;i++)
2013  0111 0f02          	clr	(OFST+0,sp)
2014  0113               L1401:
2015                     ; 225 						sicp_buf[i] = rev_buf[i];
2017  0113 7b02          	ld	a,(OFST+0,sp)
2018  0115 5f            	clrw	x
2019  0116 97            	ld	xl,a
2020  0117 d6001f        	ld	a,(_rev_buf,x)
2021  011a d70001        	ld	(_sicp_buf,x),a
2022                     ; 223 					for (i = 0;i < 30;i++)
2024  011d 0c02          	inc	(OFST+0,sp)
2027  011f 7b02          	ld	a,(OFST+0,sp)
2028  0121 a11e          	cp	a,#30
2029  0123 25ee          	jrult	L1401
2030  0125 2004          	jra	L3001
2031  0127               L5301:
2032                     ; 231 				rev_count = 0;
2034  0127 725f005f      	clr	_rev_count
2035  012b               L3001:
2036                     ; 235 	if (UART2->SR & 0x20) //|| (UART2->SR & UART2_SR_OR))
2038  012b c65240        	ld	a,21056
2039  012e a520          	bcp	a,#32
2040  0130 2707          	jreq	L1501
2041                     ; 237 		temp2 = UART2->DR;
2043  0132 7b01          	ld	a,(OFST-1,sp)
2044  0134 97            	ld	xl,a
2045  0135 c65241        	ld	a,21057
2046  0138 97            	ld	xl,a
2047  0139               L1501:
2048                     ; 250 }
2051  0139 85            	popw	x
2052  013a 81            	ret
2077                     ; 258 void gest_confirm(void)
2077                     ; 259 {
2078                     .text:	section	.text,new
2079  0000               _gest_confirm:
2083                     ; 260 	if ((st1.st_ges_H == st1.st_ges1_ctrl_H) && (st1.st_ges_L == st1.st_ges1_ctrl_L))
2085  0000 c60078        	ld	a,_st1
2086  0003 c10094        	cp	a,_st1+28
2087  0006 260e          	jrne	L3601
2089  0008 c60079        	ld	a,_st1+1
2090  000b c10095        	cp	a,_st1+29
2091  000e 2606          	jrne	L3601
2092                     ; 262 		gest1_confirm = 1;
2094  0010 721400c9      	bset	_UART1Flag2_,#2
2096  0014 2004          	jra	L5601
2097  0016               L3601:
2098                     ; 266 		gest1_confirm = 0;
2100  0016 721500c9      	bres	_UART1Flag2_,#2
2101  001a               L5601:
2102                     ; 268 	if ((st1.st_ges_H == st1.st_ges2_ctrl_H) && (st1.st_ges_L == st1.st_ges2_ctrl_L))
2104  001a c60078        	ld	a,_st1
2105  001d c10099        	cp	a,_st1+33
2106  0020 260e          	jrne	L7601
2108  0022 c60079        	ld	a,_st1+1
2109  0025 c1009a        	cp	a,_st1+34
2110  0028 2606          	jrne	L7601
2111                     ; 270 		gest2_confirm = 1;
2113  002a 721600c9      	bset	_UART1Flag2_,#3
2115  002e 2004          	jra	L1701
2116  0030               L7601:
2117                     ; 274 		gest2_confirm = 0;
2119  0030 721700c9      	bres	_UART1Flag2_,#3
2120  0034               L1701:
2121                     ; 276 	if ((st1.st_ges_H == st1.st_ges3_ctrl_H) && (st1.st_ges_L == st1.st_ges3_ctrl_L))
2123  0034 c60078        	ld	a,_st1
2124  0037 c1009e        	cp	a,_st1+38
2125  003a 260e          	jrne	L3701
2127  003c c60079        	ld	a,_st1+1
2128  003f c1009f        	cp	a,_st1+39
2129  0042 2606          	jrne	L3701
2130                     ; 278 		gest3_confirm = 1;
2132  0044 721800c9      	bset	_UART1Flag2_,#4
2134  0048 2004          	jra	L5701
2135  004a               L3701:
2136                     ; 282 		gest3_confirm = 0;
2138  004a 721900c9      	bres	_UART1Flag2_,#4
2139  004e               L5701:
2140                     ; 284 	if((st1.st_ges_H == st1.st_ges4_ctrl_H) && (st1.st_ges_L == st1.st_ges4_ctrl_L))
2142  004e c60078        	ld	a,_st1
2143  0051 c100a3        	cp	a,_st1+43
2144  0054 260e          	jrne	L7701
2146  0056 c60079        	ld	a,_st1+1
2147  0059 c100a4        	cp	a,_st1+44
2148  005c 2606          	jrne	L7701
2149                     ; 286 		gest4_confirm = 1;
2151  005e 721a00c9      	bset	_UART1Flag2_,#5
2153  0062 2004          	jra	L1011
2154  0064               L7701:
2155                     ; 290 		gest4_confirm = 0;
2157  0064 721b00c9      	bres	_UART1Flag2_,#5
2158  0068               L1011:
2159                     ; 292 }
2162  0068 81            	ret
2187                     ; 300 void pad_confirm(void)
2187                     ; 301 {
2188                     .text:	section	.text,new
2189  0000               _pad_confirm:
2193                     ; 302 	if(st_pad1_ctrl)
2195  0000 c600c8        	ld	a,_UART1Flag3_
2196  0003 a502          	bcp	a,#2
2197  0005 2724          	jreq	L3111
2198                     ; 304 		if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
2200  0007 725d0085      	tnz	_st1+13
2201  000b 2716          	jreq	L5111
2203  000d 725d0086      	tnz	_st1+14
2204  0011 2710          	jreq	L5111
2206  0013 725d0087      	tnz	_st1+15
2207  0017 270a          	jreq	L5111
2208                     ; 306 			st_pad1_confirm = 1;
2210  0019 721800c8      	bset	_UART1Flag3_,#4
2211                     ; 307 			st1.st_ctrl_address = 0x01;
2213  001d 3501007b      	mov	_st1+3,#1
2215  0021 2008          	jra	L3111
2216  0023               L5111:
2217                     ; 311 			st_pad1_confirm = 0;
2219  0023 721900c8      	bres	_UART1Flag3_,#4
2220                     ; 312 			st1.st_ctrl_address = 0x00;
2222  0027 725f007b      	clr	_st1+3
2223  002b               L3111:
2224                     ; 316 	if(st_pad2_ctrl)
2226  002b c600c8        	ld	a,_UART1Flag3_
2227  002e a504          	bcp	a,#4
2228  0030 2724          	jreq	L1211
2229                     ; 318 		if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
2231  0032 725d008a      	tnz	_st1+18
2232  0036 2716          	jreq	L3211
2234  0038 725d008b      	tnz	_st1+19
2235  003c 2710          	jreq	L3211
2237  003e 725d008c      	tnz	_st1+20
2238  0042 270a          	jreq	L3211
2239                     ; 320 			st_pad2_confirm = 1;
2241  0044 721a00c8      	bset	_UART1Flag3_,#5
2242                     ; 321 			st1.st_ctrl_address = 0x02;
2244  0048 3502007b      	mov	_st1+3,#2
2246  004c 2008          	jra	L1211
2247  004e               L3211:
2248                     ; 325 			st_pad2_confirm = 0;
2250  004e 721b00c8      	bres	_UART1Flag3_,#5
2251                     ; 326 			st1.st_ctrl_address = 0x00;
2253  0052 725f007b      	clr	_st1+3
2254  0056               L1211:
2255                     ; 329 	if(st_pad3_ctrl)
2257  0056 c600c8        	ld	a,_UART1Flag3_
2258  0059 a508          	bcp	a,#8
2259  005b 2724          	jreq	L7211
2260                     ; 331 		if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
2262  005d 725d008f      	tnz	_st1+23
2263  0061 2716          	jreq	L1311
2265  0063 725d0090      	tnz	_st1+24
2266  0067 2710          	jreq	L1311
2268  0069 725d0091      	tnz	_st1+25
2269  006d 270a          	jreq	L1311
2270                     ; 333 			st_pad3_confirm = 1;
2272  006f 721c00c8      	bset	_UART1Flag3_,#6
2273                     ; 334 			st1.st_ctrl_address = 0x04;
2275  0073 3504007b      	mov	_st1+3,#4
2277  0077 2008          	jra	L7211
2278  0079               L1311:
2279                     ; 338 			st_pad3_confirm = 0;
2281  0079 721d00c8      	bres	_UART1Flag3_,#6
2282                     ; 339 			st1.st_ctrl_address = 0x00;
2284  007d 725f007b      	clr	_st1+3
2285  0081               L7211:
2286                     ; 342 }
2289  0081 81            	ret
2410                     ; 349 int addNodeToUart2TxSLLast(char *psave, int length)
2410                     ; 350 {
2411                     .text:	section	.text,new
2412  0000               _addNodeToUart2TxSLLast:
2414  0000 89            	pushw	x
2415  0001 5206          	subw	sp,#6
2416       00000006      OFST:	set	6
2419                     ; 351 	int ret = -1;
2421  0003 aeffff        	ldw	x,#65535
2422  0006 1f01          	ldw	(OFST-5,sp),x
2423                     ; 355 	newNode = (slnode_t *)malloc(sizeof(slnode_t)); if(!newNode){ return -1;}
2425  0008 ae0008        	ldw	x,#8
2426  000b cd0000        	call	_malloc
2428  000e 1f05          	ldw	(OFST-1,sp),x
2431  0010 1e05          	ldw	x,(OFST-1,sp)
2432  0012 2605          	jrne	L3121
2435  0014 aeffff        	ldw	x,#65535
2437  0017 2013          	jra	L06
2438  0019               L3121:
2439                     ; 357 	pdata = (char *)malloc(length); if(!pdata){free(newNode); return -1;}
2441  0019 1e0b          	ldw	x,(OFST+5,sp)
2442  001b cd0000        	call	_malloc
2444  001e 1f03          	ldw	(OFST-3,sp),x
2447  0020 1e03          	ldw	x,(OFST-3,sp)
2448  0022 260b          	jrne	L5121
2451  0024 1e05          	ldw	x,(OFST-1,sp)
2452  0026 cd0000        	call	_free
2456  0029 aeffff        	ldw	x,#65535
2458  002c               L06:
2460  002c 5b08          	addw	sp,#8
2461  002e 81            	ret
2462  002f               L5121:
2463                     ; 358 	mutex2 = 1;
2465  002f 350100cf      	mov	_mutex2,#1
2466                     ; 359 	if(newNode && pdata){
2468  0033 1e05          	ldw	x,(OFST-1,sp)
2469  0035 2760          	jreq	L7121
2471  0037 1e03          	ldw	x,(OFST-3,sp)
2472  0039 275c          	jreq	L7121
2473                     ; 360 		newNode->next = NULL;
2475  003b 1e05          	ldw	x,(OFST-1,sp)
2476  003d 905f          	clrw	y
2477  003f ff            	ldw	(x),y
2478                     ; 361 		newNode->len = (u16)length;	
2480  0040 1e05          	ldw	x,(OFST-1,sp)
2481  0042 160b          	ldw	y,(OFST+5,sp)
2482  0044 ef02          	ldw	(2,x),y
2483                     ; 362 		newNode->hasWrite = 0;
2485  0046 1e05          	ldw	x,(OFST-1,sp)
2486  0048 905f          	clrw	y
2487  004a ef04          	ldw	(4,x),y
2488                     ; 363 		memcpy(pdata, psave, length);
2490  004c 1e03          	ldw	x,(OFST-3,sp)
2491  004e bf00          	ldw	c_x,x
2492  0050 1607          	ldw	y,(OFST+1,sp)
2493  0052 90bf00        	ldw	c_y,y
2494  0055 1e0b          	ldw	x,(OFST+5,sp)
2495  0057               L65:
2496  0057 5a            	decw	x
2497  0058 92d600        	ld	a,([c_y.w],x)
2498  005b 92d700        	ld	([c_x.w],x),a
2499  005e 5d            	tnzw	x
2500  005f 26f6          	jrne	L65
2501                     ; 365 		free(psave);
2503  0061 1e07          	ldw	x,(OFST+1,sp)
2504  0063 cd0000        	call	_free
2506                     ; 368 		newNode->data = pdata;
2508  0066 1e05          	ldw	x,(OFST-1,sp)
2509  0068 1603          	ldw	y,(OFST-3,sp)
2510  006a ef06          	ldw	(6,x),y
2511                     ; 369 		mutex2 = 0;
2513  006c 725f00cf      	clr	_mutex2
2514                     ; 370 		if(!uart2TxSLLast){	/* á′±í?2ê?·??a??? */
2516  0070 ce00cb        	ldw	x,_uart2TxSLLast
2517  0073 2610          	jrne	L1221
2518                     ; 371 			uart2TxSLHead = newNode;
2520  0075 1e05          	ldw	x,(OFST-1,sp)
2521  0077 cf00cd        	ldw	_uart2TxSLHead,x
2522                     ; 372 			uart2TxSLLast = newNode;
2524  007a 1e05          	ldw	x,(OFST-1,sp)
2525  007c cf00cb        	ldw	_uart2TxSLLast,x
2526                     ; 373 			mutex2 = 0;
2528  007f 725f00cf      	clr	_mutex2
2530  0083 200f          	jra	L3221
2531  0085               L1221:
2532                     ; 375 			uart2TxSLLast->next = newNode;	/* add node */
2534  0085 1e05          	ldw	x,(OFST-1,sp)
2535  0087 72cf00cb      	ldw	[_uart2TxSLLast.w],x
2536                     ; 376 			uart2TxSLLast = newNode;	/* new list end */
2538  008b 1e05          	ldw	x,(OFST-1,sp)
2539  008d cf00cb        	ldw	_uart2TxSLLast,x
2540                     ; 377 			mutex2 = 0;			
2542  0090 725f00cf      	clr	_mutex2
2543  0094               L3221:
2544                     ; 379 		ret = 0;
2546  0094 5f            	clrw	x
2547  0095 1f01          	ldw	(OFST-5,sp),x
2548  0097               L7121:
2549                     ; 381 	return ret;
2551  0097 1e01          	ldw	x,(OFST-5,sp)
2553  0099 2091          	jra	L06
2601                     ; 387 int deleteNodeFromUart2TxSLHead(void)
2601                     ; 388 {
2602                     .text:	section	.text,new
2603  0000               _deleteNodeFromUart2TxSLHead:
2605  0000 89            	pushw	x
2606       00000002      OFST:	set	2
2609                     ; 389 	int ret = -1;
2611  0001 aeffff        	ldw	x,#65535
2612  0004 1f01          	ldw	(OFST-1,sp),x
2613                     ; 392 	if(uart2TxSLHead){	/* 链表头不为空 */	
2615  0006 ce00cd        	ldw	x,_uart2TxSLHead
2616  0009 274e          	jreq	L7421
2617                     ; 393 		if(!uart2TxSLHead->next){	/* 链表头的next为空，即只有一个节点，链表头和链表尾都指向该节点 */
2619  000b ce00cd        	ldw	x,_uart2TxSLHead
2620  000e e601          	ld	a,(1,x)
2621  0010 fa            	or	a,(x)
2622  0011 2621          	jrne	L1521
2623                     ; 394 			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
2625  0013 ce00cd        	ldw	x,_uart2TxSLHead
2626  0016 e607          	ld	a,(7,x)
2627  0018 ea06          	or	a,(6,x)
2628  001a 2708          	jreq	L3521
2631  001c ce00cd        	ldw	x,_uart2TxSLHead
2632  001f ee06          	ldw	x,(6,x)
2633  0021 cd0000        	call	_free
2635  0024               L3521:
2636                     ; 395 			free(uart2TxSLHead);
2638  0024 ce00cd        	ldw	x,_uart2TxSLHead
2639  0027 cd0000        	call	_free
2641                     ; 396 			uart2TxSLHead = NULL;
2643  002a 5f            	clrw	x
2644  002b cf00cd        	ldw	_uart2TxSLHead,x
2645                     ; 397 			uart2TxSLLast = NULL;
2647  002e 5f            	clrw	x
2648  002f cf00cb        	ldw	_uart2TxSLLast,x
2650  0032 2022          	jra	L5521
2651  0034               L1521:
2652                     ; 399 			newhead = uart2TxSLHead->next;
2654  0034 72ce00cd      	ldw	x,[_uart2TxSLHead.w]
2655  0038 1f01          	ldw	(OFST-1,sp),x
2656                     ; 400 			if(uart2TxSLHead->data) {free(uart2TxSLHead->data);}
2658  003a ce00cd        	ldw	x,_uart2TxSLHead
2659  003d e607          	ld	a,(7,x)
2660  003f ea06          	or	a,(6,x)
2661  0041 2708          	jreq	L7521
2664  0043 ce00cd        	ldw	x,_uart2TxSLHead
2665  0046 ee06          	ldw	x,(6,x)
2666  0048 cd0000        	call	_free
2668  004b               L7521:
2669                     ; 401 			free(uart2TxSLHead);
2671  004b ce00cd        	ldw	x,_uart2TxSLHead
2672  004e cd0000        	call	_free
2674                     ; 402 			uart2TxSLHead = newhead;			
2676  0051 1e01          	ldw	x,(OFST-1,sp)
2677  0053 cf00cd        	ldw	_uart2TxSLHead,x
2678  0056               L5521:
2679                     ; 404 		ret = 0;
2681  0056 5f            	clrw	x
2682  0057 1f01          	ldw	(OFST-1,sp),x
2683  0059               L7421:
2684                     ; 406 	return ret;	
2686  0059 1e01          	ldw	x,(OFST-1,sp)
2689  005b 5b02          	addw	sp,#2
2690  005d 81            	ret
2761                     ; 414 void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len ,u8 cmd)
2761                     ; 415 {
2762                     .text:	section	.text,new
2763  0000               _send_header_payload_init:
2765  0000 89            	pushw	x
2766       00000000      OFST:	set	0
2769                     ; 416 	send_buf[0] = 0xEE;
2771  0001 35ee003d      	mov	_send_buf,#238
2772                     ; 417 	send_buf[1] = 0xEE;
2774  0005 35ee003e      	mov	_send_buf+1,#238
2775                     ; 418 	send_buf[2] = id;
2777  0009 9e            	ld	a,xh
2778  000a c7003f        	ld	_send_buf+2,a
2779                     ; 419 	send_buf[3] = mesh_id_H;
2781  000d 9f            	ld	a,xl
2782  000e c70040        	ld	_send_buf+3,a
2783                     ; 420 	send_buf[4] = mesh_id_L;
2785  0011 7b05          	ld	a,(OFST+5,sp)
2786  0013 c70041        	ld	_send_buf+4,a
2787                     ; 421 	send_buf[5] = len;
2789  0016 7b06          	ld	a,(OFST+6,sp)
2790  0018 c70042        	ld	_send_buf+5,a
2791                     ; 423 	switch(cmd)
2793  001b 7b07          	ld	a,(OFST+7,sp)
2795                     ; 698 			break;
2796  001d a006          	sub	a,#6
2797  001f 2761          	jreq	L3621
2798  0021 a002          	sub	a,#2
2799  0023 2603          	jrne	L66
2800  0025 cc0387        	jp	L1031
2801  0028               L66:
2802  0028 a002          	sub	a,#2
2803  002a 2603          	jrne	L07
2804  002c cc0297        	jp	L5721
2805  002f               L07:
2806  002f a016          	sub	a,#22
2807  0031 272e          	jreq	L1621
2808  0033 a009          	sub	a,#9
2809  0035 2603          	jrne	L27
2810  0037 cc00de        	jp	L5621
2811  003a               L27:
2812  003a a00c          	sub	a,#12
2813  003c 2603          	jrne	L47
2814  003e cc00f5        	jp	L7621
2815  0041               L47:
2816  0041 a01c          	sub	a,#28
2817  0043 2603          	jrne	L67
2818  0045 cc02a9        	jp	L7721
2819  0048               L67:
2820  0048 a004          	sub	a,#4
2821  004a 2603          	jrne	L001
2822  004c cc02a9        	jp	L7721
2823  004f               L001:
2824  004f a055          	sub	a,#85
2825  0051 2603          	jrne	L201
2826  0053 cc013c        	jp	L1721
2827  0056               L201:
2828  0056 a00a          	sub	a,#10
2829  0058 2603          	jrne	L401
2830  005a cc0271        	jp	L3721
2831  005d               L401:
2832  005d ac190519      	jpf	L1331
2833  0061               L1621:
2834                     ; 425 		case 0x20://回复环境光和环境颜色
2834                     ; 426 			send_buf[1] = 0xAA;
2836  0061 35aa003e      	mov	_send_buf+1,#170
2837                     ; 427 			send_buf[6] = cmd;
2839  0065 7b07          	ld	a,(OFST+7,sp)
2840  0067 c70043        	ld	_send_buf+6,a
2841                     ; 428 			send_buf[7] = st1.st_ambient_light;
2843  006a 5500810044    	mov	_send_buf+7,_st1+9
2844                     ; 429 			send_buf[8] = st1.st_color_sense_L;
2846  006f 5500840045    	mov	_send_buf+8,_st1+12
2847                     ; 430 			send_buf[9] = st1.st_color_sense_M;
2849  0074 5500830046    	mov	_send_buf+9,_st1+11
2850                     ; 431 			send_buf[10] = st1.st_color_sense_H;
2852  0079 5500820047    	mov	_send_buf+10,_st1+10
2853                     ; 432 			break;
2855  007e ac190519      	jpf	L1331
2856  0082               L3621:
2857                     ; 433 		case 0x06://回复心跳包，回复背光LED,及3个触控开关的状态
2857                     ; 434 			send_buf[1] = 0xAA;
2859  0082 35aa003e      	mov	_send_buf+1,#170
2860                     ; 435 			send_buf[6] = cmd;
2862  0086 7b07          	ld	a,(OFST+7,sp)
2863  0088 c70043        	ld	_send_buf+6,a
2864                     ; 436 			send_buf[7] = 0x00;//ST Module ID发0x00
2866  008b 725f0044      	clr	_send_buf+7
2867                     ; 437 			send_buf[8] = 0x00;
2869  008f 725f0045      	clr	_send_buf+8
2870                     ; 438 			if ((st1.st_device_status & 0x08)==0x08)	send_buf[8] = st1.st_pad1_status;
2872  0093 c6007a        	ld	a,_st1+2
2873  0096 a408          	and	a,#8
2874  0098 a108          	cp	a,#8
2875  009a 2605          	jrne	L3331
2878  009c 55007e0045    	mov	_send_buf+8,_st1+6
2879  00a1               L3331:
2880                     ; 439 			send_buf[9] = 0x00;
2882  00a1 725f0046      	clr	_send_buf+9
2883                     ; 440 			if ((st1.st_device_status & 0x04)==0x04)	send_buf[9] = st1.st_pad2_status;
2885  00a5 c6007a        	ld	a,_st1+2
2886  00a8 a404          	and	a,#4
2887  00aa a104          	cp	a,#4
2888  00ac 2605          	jrne	L5331
2891  00ae 55007f0046    	mov	_send_buf+9,_st1+7
2892  00b3               L5331:
2893                     ; 441 			send_buf[10] = 0x00;
2895  00b3 725f0047      	clr	_send_buf+10
2896                     ; 442 			if ((st1.st_device_status & 0x02)==0x02)	send_buf[10]= st1.st_pad3_status;
2898  00b7 c6007a        	ld	a,_st1+2
2899  00ba a402          	and	a,#2
2900  00bc a102          	cp	a,#2
2901  00be 2605          	jrne	L7331
2904  00c0 5500800047    	mov	_send_buf+10,_st1+8
2905  00c5               L7331:
2906                     ; 443 			send_buf[11] = 0x00;
2908  00c5 725f0048      	clr	_send_buf+11
2909                     ; 444 			if ((st1.st_device_status & 0x01)==0x01)	send_buf[11]= st1.st_led_status;
2911  00c9 c6007a        	ld	a,_st1+2
2912  00cc a401          	and	a,#1
2913  00ce a101          	cp	a,#1
2914  00d0 2703          	jreq	L601
2915  00d2 cc0519        	jp	L1331
2916  00d5               L601:
2919  00d5 55007d0048    	mov	_send_buf+11,_st1+5
2920  00da ac190519      	jpf	L1331
2921  00de               L5621:
2922                     ; 446 		case 0x29://ST上报手势信息
2922                     ; 447 			send_buf[6] = cmd;
2924  00de 7b07          	ld	a,(OFST+7,sp)
2925  00e0 c70043        	ld	_send_buf+6,a
2926                     ; 448 			send_buf[7] = st1.st_ges_H;
2928  00e3 5500780044    	mov	_send_buf+7,_st1
2929                     ; 449 			send_buf[8] = st1.st_ges_L;
2931  00e8 5500790045    	mov	_send_buf+8,_st1+1
2932                     ; 450 			send_buf[9] = 0x00;//ST Module ID 保留
2934  00ed 725f0046      	clr	_send_buf+9
2935                     ; 451 			break;
2937  00f1 ac190519      	jpf	L1331
2938  00f5               L7621:
2939                     ; 452 		case 0x35:
2939                     ; 453 			send_buf[6] = cmd;
2941  00f5 7b07          	ld	a,(OFST+7,sp)
2942  00f7 c70043        	ld	_send_buf+6,a
2943                     ; 454 			if (st_pad1_ctrl)
2945  00fa c600c8        	ld	a,_UART1Flag3_
2946  00fd a502          	bcp	a,#2
2947  00ff 270e          	jreq	L3431
2948                     ; 456 				send_buf[7] = st1.st_pad1_ctrl_boardid;
2950  0101 5500870044    	mov	_send_buf+7,_st1+15
2951                     ; 457 				send_buf[8] = st1.st_pad1_status;
2953  0106 55007e0045    	mov	_send_buf+8,_st1+6
2955  010b ac190519      	jpf	L1331
2956  010f               L3431:
2957                     ; 459 			else if (st_pad2_ctrl)
2959  010f c600c8        	ld	a,_UART1Flag3_
2960  0112 a504          	bcp	a,#4
2961  0114 270e          	jreq	L7431
2962                     ; 461 				send_buf[7] = st1.st_pad2_ctrl_boardid;
2964  0116 55008c0044    	mov	_send_buf+7,_st1+20
2965                     ; 462 				send_buf[8] = st1.st_pad2_status;
2967  011b 55007f0045    	mov	_send_buf+8,_st1+7
2969  0120 ac190519      	jpf	L1331
2970  0124               L7431:
2971                     ; 464 			else if (st_pad3_ctrl)
2973  0124 c600c8        	ld	a,_UART1Flag3_
2974  0127 a508          	bcp	a,#8
2975  0129 2603          	jrne	L011
2976  012b cc0519        	jp	L1331
2977  012e               L011:
2978                     ; 466 				send_buf[7] = st1.st_pad3_ctrl_boardid;
2980  012e 5500910044    	mov	_send_buf+7,_st1+25
2981                     ; 467 				send_buf[8] = st1.st_pad3_status;
2983  0133 5500800045    	mov	_send_buf+8,_st1+8
2984  0138 ac190519      	jpf	L1331
2985  013c               L1721:
2986                     ; 470 		case 0xAA://发送回执
2986                     ; 471 			send_buf[1] = 0xAA;
2988  013c 35aa003e      	mov	_send_buf+1,#170
2989                     ; 472 		  if (action_ctrlpad_flag)
2991  0140 c600ca        	ld	a,_UART1Flag1_
2992  0143 a510          	bcp	a,#16
2993  0145 273a          	jreq	L5531
2994                     ; 474 				action_ctrlpad_flag = 0;
2996  0147 721900ca      	bres	_UART1Flag1_,#4
2997                     ; 475 				send_buf[6] = cmd;
2999  014b 7b07          	ld	a,(OFST+7,sp)
3000  014d c70043        	ld	_send_buf+6,a
3001                     ; 476 				send_buf[7] = 0x05;//代表成功执行并返回模块状态
3003  0150 35050044      	mov	_send_buf+7,#5
3004                     ; 477 				send_buf[8] = st1.st_pad1_status;
3006  0154 55007e0045    	mov	_send_buf+8,_st1+6
3007                     ; 478 				send_buf[9] = st1.st_pad2_status;
3009  0159 55007f0046    	mov	_send_buf+9,_st1+7
3010                     ; 479 				send_buf[10] = st1.st_pad3_status;
3012  015e 5500800047    	mov	_send_buf+10,_st1+8
3013                     ; 480 				send_buf[11] = st1.st_led_status;
3015  0163 55007d0048    	mov	_send_buf+11,_st1+5
3016                     ; 482 				if((action_ctrl_address & 0x01) == 0x01){//需要回复key1控制SLC或SPC的状态
3018  0168 c60000        	ld	a,_action_ctrl_address
3019  016b a401          	and	a,#1
3020  016d a101          	cp	a,#1
3021  016f 2703          	jreq	L211
3022  0171 cc0519        	jp	L1331
3023  0174               L211:
3024                     ; 483 					send_buf[12] += 1;
3026  0174 725c0049      	inc	_send_buf+12
3027                     ; 484 					send_buf[13] = st1.st_pad1_ctrl_boardid;
3029  0178 550087004a    	mov	_send_buf+13,_st1+15
3030  017d ac190519      	jpf	L1331
3031  0181               L5531:
3032                     ; 490 			else if(led_ctrl_flag)
3034  0181 c600c7        	ld	a,_UART1Flag4_
3035  0184 a504          	bcp	a,#4
3036  0186 2726          	jreq	L3631
3037                     ; 492 				led_ctrl_flag = 0;
3039  0188 721500c7      	bres	_UART1Flag4_,#2
3040                     ; 493 				send_buf[6] = cmd;
3042  018c 7b07          	ld	a,(OFST+7,sp)
3043  018e c70043        	ld	_send_buf+6,a
3044                     ; 494 				send_buf[7] = 0x01;//代表指令执行成功
3046  0191 35010044      	mov	_send_buf+7,#1
3047                     ; 495 				if((st1.st_led_mode == 0x4F) ||	(st1.st_led_mode == 0x5F))
3049  0195 c600b4        	ld	a,_st1+60
3050  0198 a14f          	cp	a,#79
3051  019a 270a          	jreq	L7631
3053  019c c600b4        	ld	a,_st1+60
3054  019f a15f          	cp	a,#95
3055  01a1 2703          	jreq	L411
3056  01a3 cc0519        	jp	L1331
3057  01a6               L411:
3058  01a6               L7631:
3059                     ; 496 					send_buf[7] = 0x02;//代表成功接收数据
3061  01a6 35020044      	mov	_send_buf+7,#2
3062  01aa ac190519      	jpf	L1331
3063  01ae               L3631:
3064                     ; 498 			else if(load_alert_flag)
3066  01ae c600c7        	ld	a,_UART1Flag4_
3067  01b1 a508          	bcp	a,#8
3068  01b3 2711          	jreq	L3731
3069                     ; 500 				load_alert_flag = 0;
3071  01b5 721700c7      	bres	_UART1Flag4_,#3
3072                     ; 501 				send_buf[6] = cmd;
3074  01b9 7b07          	ld	a,(OFST+7,sp)
3075  01bb c70043        	ld	_send_buf+6,a
3076                     ; 502 				send_buf[7] = 0x01;//代表指令执行成功
3078  01be 35010044      	mov	_send_buf+7,#1
3080  01c2 ac190519      	jpf	L1331
3081  01c6               L3731:
3082                     ; 504 			else if (cmd_refresh_flag)
3084  01c6 c600ca        	ld	a,_UART1Flag1_
3085  01c9 a504          	bcp	a,#4
3086  01cb 2711          	jreq	L7731
3087                     ; 506 				cmd_refresh_flag = 0;
3089  01cd 721500ca      	bres	_UART1Flag1_,#2
3090                     ; 507 				send_buf[6] = cmd;
3092  01d1 7b07          	ld	a,(OFST+7,sp)
3093  01d3 c70043        	ld	_send_buf+6,a
3094                     ; 508 				send_buf[7] = 0x01;//代表指令执行成功
3096  01d6 35010044      	mov	_send_buf+7,#1
3098  01da ac190519      	jpf	L1331
3099  01de               L7731:
3100                     ; 510 			else if(receipt_conf_pad1)
3102  01de c600c6        	ld	a,_UART1Flag5_
3103  01e1 a540          	bcp	a,#64
3104  01e3 2711          	jreq	L3041
3105                     ; 512 				receipt_conf_pad1 = 0;
3107  01e5 721d00c6      	bres	_UART1Flag5_,#6
3108                     ; 513 				send_buf[6] = cmd;
3110  01e9 7b07          	ld	a,(OFST+7,sp)
3111  01eb c70043        	ld	_send_buf+6,a
3112                     ; 514 				send_buf[7] = 0x01;//代表指令执行成功
3114  01ee 35010044      	mov	_send_buf+7,#1
3116  01f2 ac190519      	jpf	L1331
3117  01f6               L3041:
3118                     ; 516 			else if(receipt_conf_pad2)
3120  01f6 c600c6        	ld	a,_UART1Flag5_
3121  01f9 a580          	bcp	a,#128
3122  01fb 2711          	jreq	L7041
3123                     ; 518 				receipt_conf_pad2 = 0;
3125  01fd 721f00c6      	bres	_UART1Flag5_,#7
3126                     ; 519 				send_buf[6] = cmd;
3128  0201 7b07          	ld	a,(OFST+7,sp)
3129  0203 c70043        	ld	_send_buf+6,a
3130                     ; 520 				send_buf[7] = 0x03;//代表指令执行失败
3132  0206 35030044      	mov	_send_buf+7,#3
3134  020a ac190519      	jpf	L1331
3135  020e               L7041:
3136                     ; 522 			else if(receipt_conf_gest1)
3138  020e c600c5        	ld	a,_UART1Flag6_
3139  0211 a501          	bcp	a,#1
3140  0213 2711          	jreq	L3141
3141                     ; 524 				receipt_conf_gest1 = 0;
3143  0215 721100c5      	bres	_UART1Flag6_,#0
3144                     ; 525 				send_buf[6] = cmd;
3146  0219 7b07          	ld	a,(OFST+7,sp)
3147  021b c70043        	ld	_send_buf+6,a
3148                     ; 526 				send_buf[7] = 0x01;//代表指令执行成功
3150  021e 35010044      	mov	_send_buf+7,#1
3152  0222 ac190519      	jpf	L1331
3153  0226               L3141:
3154                     ; 528 			else if(receipt_conf_gest2)
3156  0226 c600c5        	ld	a,_UART1Flag6_
3157  0229 a502          	bcp	a,#2
3158  022b 2711          	jreq	L7141
3159                     ; 530 				receipt_conf_gest2 = 0;
3161  022d 721300c5      	bres	_UART1Flag6_,#1
3162                     ; 531 				send_buf[6] = cmd;
3164  0231 7b07          	ld	a,(OFST+7,sp)
3165  0233 c70043        	ld	_send_buf+6,a
3166                     ; 532 				send_buf[7] = 0x03;//代表指令执行失败
3168  0236 35030044      	mov	_send_buf+7,#3
3170  023a ac190519      	jpf	L1331
3171  023e               L7141:
3172                     ; 534 			else if(receipt_device_info2)
3174  023e c600c6        	ld	a,_UART1Flag5_
3175  0241 a502          	bcp	a,#2
3176  0243 2711          	jreq	L3241
3177                     ; 536 				receipt_device_info2 = 0;
3179  0245 721300c6      	bres	_UART1Flag5_,#1
3180                     ; 537 				send_buf[6] = cmd;
3182  0249 7b07          	ld	a,(OFST+7,sp)
3183  024b c70043        	ld	_send_buf+6,a
3184                     ; 538 				send_buf[7] = 0x03;//代表指令执行失败
3186  024e 35030044      	mov	_send_buf+7,#3
3188  0252 ac190519      	jpf	L1331
3189  0256               L3241:
3190                     ; 540 			else if(receipt_host_mesh)
3192  0256 c600c5        	ld	a,_UART1Flag6_
3193  0259 a504          	bcp	a,#4
3194  025b 2603          	jrne	L611
3195  025d cc0519        	jp	L1331
3196  0260               L611:
3197                     ; 542 				receipt_host_mesh = 0;
3199  0260 721500c5      	bres	_UART1Flag6_,#2
3200                     ; 543 				send_buf[6] = cmd;
3202  0264 7b07          	ld	a,(OFST+7,sp)
3203  0266 c70043        	ld	_send_buf+6,a
3204                     ; 544 				send_buf[7] = 0x02;//代表指令接收成功
3206  0269 35020044      	mov	_send_buf+7,#2
3207  026d ac190519      	jpf	L1331
3208  0271               L3721:
3209                     ; 547 		case 0xB4://ST回复设备信息
3209                     ; 548 			send_buf[6] = cmd;
3211  0271 7b07          	ld	a,(OFST+7,sp)
3212  0273 c70043        	ld	_send_buf+6,a
3213                     ; 549 			send_buf[7] = 0xAA;//UUID
3215  0276 35aa0044      	mov	_send_buf+7,#170
3216                     ; 550 			send_buf[8] = 0x55;
3218  027a 35550045      	mov	_send_buf+8,#85
3219                     ; 551 			send_buf[9] = 0xAB;
3221  027e 35ab0046      	mov	_send_buf+9,#171
3222                     ; 552 			send_buf[10] = 0x70;
3224  0282 35700047      	mov	_send_buf+10,#112
3225                     ; 553 			send_buf[11] = 0x63;//设备型号
3227  0286 35630048      	mov	_send_buf+11,#99
3228                     ; 554 			send_buf[12] = 0x00;//固件版本
3230  028a 725f0049      	clr	_send_buf+12
3231                     ; 555 			send_buf[13] = st1.st_device_status;
3233  028e 55007a004a    	mov	_send_buf+13,_st1+2
3234                     ; 556 			break;
3236  0293 ac190519      	jpf	L1331
3237  0297               L5721:
3238                     ; 557 		case 0x0A://汇报 Seraph相关设备故障 
3238                     ; 558 			send_buf[6] = cmd;
3240  0297 7b07          	ld	a,(OFST+7,sp)
3241  0299 c70043        	ld	_send_buf+6,a
3242                     ; 559 			send_buf[7] = 0xB4;
3244  029c 35b40044      	mov	_send_buf+7,#180
3245                     ; 560 			send_buf[8] = st1.st_device_status;
3247  02a0 55007a0045    	mov	_send_buf+8,_st1+2
3248                     ; 561 			break;
3250  02a5 ac190519      	jpf	L1331
3251  02a9               L7721:
3252                     ; 562 		case 0x51://ST被触发判断需要向SC 发送指令	预设值指令手势
3252                     ; 563 		case 0x55:
3252                     ; 564 			send_buf[6] = cmd;
3254  02a9 7b07          	ld	a,(OFST+7,sp)
3255  02ab c70043        	ld	_send_buf+6,a
3256                     ; 565 			if(gest1_confirm)
3258  02ae c600c9        	ld	a,_UART1Flag2_
3259  02b1 a504          	bcp	a,#4
3260  02b3 2712          	jreq	L1341
3261                     ; 567 				send_buf[7] = st1.st_ges1_ctrl_boardid;
3263  02b5 5500980044    	mov	_send_buf+7,_st1+32
3264                     ; 568 				send_buf[8] = st1.st_ges1_ctrl_action_value;
3266  02ba 5500a90045    	mov	_send_buf+8,_st1+49
3267                     ; 569 				send_buf[9] = 0x1E;
3269  02bf 351e0046      	mov	_send_buf+9,#30
3271  02c3 ac190519      	jpf	L1331
3272  02c7               L1341:
3273                     ; 571 			else if(gest2_confirm)
3275  02c7 c600c9        	ld	a,_UART1Flag2_
3276  02ca a508          	bcp	a,#8
3277  02cc 2712          	jreq	L5341
3278                     ; 573 				send_buf[7] = st1.st_ges2_ctrl_boardid;
3280  02ce 55009d0044    	mov	_send_buf+7,_st1+37
3281                     ; 574 				send_buf[8] = st1.st_ges2_ctrl_action_value;
3283  02d3 5500ac0045    	mov	_send_buf+8,_st1+52
3284                     ; 575 				send_buf[9] = 0x1E;
3286  02d8 351e0046      	mov	_send_buf+9,#30
3288  02dc ac190519      	jpf	L1331
3289  02e0               L5341:
3290                     ; 577 			else if(gest3_confirm)
3292  02e0 c600c9        	ld	a,_UART1Flag2_
3293  02e3 a510          	bcp	a,#16
3294  02e5 2712          	jreq	L1441
3295                     ; 579 				send_buf[7] = st1.st_ges3_ctrl_boardid;
3297  02e7 5500a20044    	mov	_send_buf+7,_st1+42
3298                     ; 580 				send_buf[8] = st1.st_ges3_ctrl_action_value;
3300  02ec 5500af0045    	mov	_send_buf+8,_st1+55
3301                     ; 581 				send_buf[9] = 0x1E;
3303  02f1 351e0046      	mov	_send_buf+9,#30
3305  02f5 ac190519      	jpf	L1331
3306  02f9               L1441:
3307                     ; 583 			else if(gest4_confirm)
3309  02f9 c600c9        	ld	a,_UART1Flag2_
3310  02fc a520          	bcp	a,#32
3311  02fe 2712          	jreq	L5441
3312                     ; 585 				send_buf[7] = st1.st_ges4_ctrl_boardid;
3314  0300 5500a70044    	mov	_send_buf+7,_st1+47
3315                     ; 586 				send_buf[8] = st1.st_ges4_ctrl_action_value;
3317  0305 5500b20045    	mov	_send_buf+8,_st1+58
3318                     ; 587 				send_buf[9] = 0x1E;
3320  030a 351e0046      	mov	_send_buf+9,#30
3322  030e ac190519      	jpf	L1331
3323  0312               L5441:
3324                     ; 589 			else if(st_pad1_confirm)
3326  0312 c600c8        	ld	a,_UART1Flag3_
3327  0315 a510          	bcp	a,#16
3328  0317 271f          	jreq	L1541
3329                     ; 591 				send_buf[7] = st1.st_pad1_ctrl_boardid;
3331  0319 5500870044    	mov	_send_buf+7,_st1+15
3332                     ; 592 				if(cmd == 0x51)	send_buf[8] = st1.st_pad1_ctrl_action_value;//说明是调光
3334  031e 7b07          	ld	a,(OFST+7,sp)
3335  0320 a151          	cp	a,#81
3336  0322 2607          	jrne	L3541
3339  0324 5500890045    	mov	_send_buf+8,_st1+17
3341  0329 2005          	jra	L5541
3342  032b               L3541:
3343                     ; 593 				else						send_buf[8] = st1.st_pad1_status;
3345  032b 55007e0045    	mov	_send_buf+8,_st1+6
3346  0330               L5541:
3347                     ; 594 				send_buf[9] = 0x1E;
3349  0330 351e0046      	mov	_send_buf+9,#30
3351  0334 ac190519      	jpf	L1331
3352  0338               L1541:
3353                     ; 596 			else if(st_pad2_confirm)
3355  0338 c600c8        	ld	a,_UART1Flag3_
3356  033b a520          	bcp	a,#32
3357  033d 271f          	jreq	L1641
3358                     ; 598 				send_buf[7] = st1.st_pad2_ctrl_boardid;
3360  033f 55008c0044    	mov	_send_buf+7,_st1+20
3361                     ; 599 				if(cmd == 0x51)	send_buf[8] = st1.st_pad2_ctrl_action_value;//说明是调光
3363  0344 7b07          	ld	a,(OFST+7,sp)
3364  0346 a151          	cp	a,#81
3365  0348 2607          	jrne	L3641
3368  034a 55008e0045    	mov	_send_buf+8,_st1+22
3370  034f 2005          	jra	L5641
3371  0351               L3641:
3372                     ; 600 				else						send_buf[8] = st1.st_pad2_status;
3374  0351 55007f0045    	mov	_send_buf+8,_st1+7
3375  0356               L5641:
3376                     ; 601 				send_buf[9] = 0x1E;
3378  0356 351e0046      	mov	_send_buf+9,#30
3380  035a ac190519      	jpf	L1331
3381  035e               L1641:
3382                     ; 603 			else if(st_pad3_confirm)
3384  035e c600c8        	ld	a,_UART1Flag3_
3385  0361 a540          	bcp	a,#64
3386  0363 2603          	jrne	L021
3387  0365 cc0519        	jp	L1331
3388  0368               L021:
3389                     ; 605 				send_buf[7] = st1.st_pad3_ctrl_boardid;
3391  0368 5500910044    	mov	_send_buf+7,_st1+25
3392                     ; 606 				if(cmd == 0x51)	send_buf[8] = st1.st_pad3_ctrl_action_value;//说明是调光
3394  036d 7b07          	ld	a,(OFST+7,sp)
3395  036f a151          	cp	a,#81
3396  0371 2607          	jrne	L3741
3399  0373 5500930045    	mov	_send_buf+8,_st1+27
3401  0378 2005          	jra	L5741
3402  037a               L3741:
3403                     ; 607 				else						send_buf[8] = st1.st_pad3_status;
3405  037a 5500800045    	mov	_send_buf+8,_st1+8
3406  037f               L5741:
3407                     ; 608 				send_buf[9] = 0x1E;
3409  037f 351e0046      	mov	_send_buf+9,#30
3410  0383 ac190519      	jpf	L1331
3411  0387               L1031:
3412                     ; 612 		case 0x08://ST被触发异步向 SS 推送触发器数值和判断结果
3412                     ; 613 			send_buf[6] = cmd;
3414  0387 7b07          	ld	a,(OFST+7,sp)
3415  0389 c70043        	ld	_send_buf+6,a
3416                     ; 614 			if(gest1_confirm)
3418  038c c600c9        	ld	a,_UART1Flag2_
3419  038f a504          	bcp	a,#4
3420  0391 2730          	jreq	L7741
3421                     ; 616 				send_buf[7] = 0x02;//触发器是手势
3423  0393 35020044      	mov	_send_buf+7,#2
3424                     ; 617 				send_buf[8] = st1.st_ges1_ctrl_H;
3426  0397 5500940045    	mov	_send_buf+8,_st1+28
3427                     ; 618 				send_buf[9] = st1.st_ges1_ctrl_L;
3429  039c 5500950046    	mov	_send_buf+9,_st1+29
3430                     ; 619 				send_buf[10] = st1.st_ges1_ctrl_meshid_H;
3432  03a1 5500960047    	mov	_send_buf+10,_st1+30
3433                     ; 620 				send_buf[11] = st1.st_ges1_ctrl_meshid_L;
3435  03a6 5500970048    	mov	_send_buf+11,_st1+31
3436                     ; 621 				send_buf[12] = st1.st_ges1_ctrl_action;
3438  03ab 5500a80049    	mov	_send_buf+12,_st1+48
3439                     ; 622 				send_buf[13] = st1.st_ges1_ctrl_boardid;
3441  03b0 550098004a    	mov	_send_buf+13,_st1+32
3442                     ; 623 				send_buf[14] = st1.st_ges1_ctrl_action_value;
3444  03b5 5500a9004b    	mov	_send_buf+14,_st1+49
3445                     ; 624 				send_buf[15] = st1.st_ges1_ctrl_action_time;
3447  03ba 5500aa004c    	mov	_send_buf+15,_st1+50
3449  03bf ac190519      	jpf	L1331
3450  03c3               L7741:
3451                     ; 626 			else if(gest2_confirm)
3453  03c3 c600c9        	ld	a,_UART1Flag2_
3454  03c6 a508          	bcp	a,#8
3455  03c8 2730          	jreq	L3051
3456                     ; 628 				send_buf[7] = 0x02;
3458  03ca 35020044      	mov	_send_buf+7,#2
3459                     ; 629 				send_buf[8] = st1.st_ges2_ctrl_H;
3461  03ce 5500990045    	mov	_send_buf+8,_st1+33
3462                     ; 630 				send_buf[9] = st1.st_ges2_ctrl_L;
3464  03d3 55009a0046    	mov	_send_buf+9,_st1+34
3465                     ; 631 				send_buf[10] = st1.st_ges2_ctrl_meshid_H;
3467  03d8 55009b0047    	mov	_send_buf+10,_st1+35
3468                     ; 632 				send_buf[11] = st1.st_ges2_ctrl_meshid_L;
3470  03dd 55009c0048    	mov	_send_buf+11,_st1+36
3471                     ; 633 				send_buf[12] = st1.st_ges2_ctrl_action;
3473  03e2 5500ab0049    	mov	_send_buf+12,_st1+51
3474                     ; 634 				send_buf[13] = st1.st_ges2_ctrl_boardid;
3476  03e7 55009d004a    	mov	_send_buf+13,_st1+37
3477                     ; 635 				send_buf[14] = st1.st_ges2_ctrl_action_value;
3479  03ec 5500ac004b    	mov	_send_buf+14,_st1+52
3480                     ; 636 				send_buf[15] = st1.st_ges2_ctrl_action_time;
3482  03f1 5500ad004c    	mov	_send_buf+15,_st1+53
3484  03f6 ac190519      	jpf	L1331
3485  03fa               L3051:
3486                     ; 638 			else if(gest3_confirm)
3488  03fa c600c9        	ld	a,_UART1Flag2_
3489  03fd a510          	bcp	a,#16
3490  03ff 2730          	jreq	L7051
3491                     ; 640 				send_buf[7] = 0x02;
3493  0401 35020044      	mov	_send_buf+7,#2
3494                     ; 641 				send_buf[8] = st1.st_ges3_ctrl_H;
3496  0405 55009e0045    	mov	_send_buf+8,_st1+38
3497                     ; 642 				send_buf[9] = st1.st_ges3_ctrl_L;
3499  040a 55009f0046    	mov	_send_buf+9,_st1+39
3500                     ; 643 				send_buf[10] = st1.st_ges3_ctrl_meshid_H;
3502  040f 5500a00047    	mov	_send_buf+10,_st1+40
3503                     ; 644 				send_buf[11] = st1.st_ges3_ctrl_meshid_L;
3505  0414 5500a10048    	mov	_send_buf+11,_st1+41
3506                     ; 645 				send_buf[12] = st1.st_ges3_ctrl_action;
3508  0419 5500ae0049    	mov	_send_buf+12,_st1+54
3509                     ; 646 				send_buf[13] = st1.st_ges3_ctrl_boardid;
3511  041e 5500a2004a    	mov	_send_buf+13,_st1+42
3512                     ; 647 				send_buf[14] = st1.st_ges3_ctrl_action_value;
3514  0423 5500af004b    	mov	_send_buf+14,_st1+55
3515                     ; 648 				send_buf[15] = st1.st_ges3_ctrl_action_time;
3517  0428 5500b0004c    	mov	_send_buf+15,_st1+56
3519  042d ac190519      	jpf	L1331
3520  0431               L7051:
3521                     ; 650 			else if(gest4_confirm)
3523  0431 c600c9        	ld	a,_UART1Flag2_
3524  0434 a520          	bcp	a,#32
3525  0436 272f          	jreq	L3151
3526                     ; 652 				send_buf[7] = 0x02;
3528  0438 35020044      	mov	_send_buf+7,#2
3529                     ; 653 				send_buf[8] = st1.st_ges4_ctrl_H;
3531  043c 5500a30045    	mov	_send_buf+8,_st1+43
3532                     ; 654 				send_buf[9] = st1.st_ges4_ctrl_L;
3534  0441 5500a40046    	mov	_send_buf+9,_st1+44
3535                     ; 655 				send_buf[10] = st1.st_ges4_ctrl_meshid_H;
3537  0446 5500a50047    	mov	_send_buf+10,_st1+45
3538                     ; 656 				send_buf[11] = st1.st_ges4_ctrl_meshid_L;
3540  044b 5500a60048    	mov	_send_buf+11,_st1+46
3541                     ; 657 				send_buf[12] = st1.st_ges4_ctrl_action;
3543  0450 5500b10049    	mov	_send_buf+12,_st1+57
3544                     ; 658 				send_buf[13] = st1.st_ges4_ctrl_boardid;
3546  0455 5500a7004a    	mov	_send_buf+13,_st1+47
3547                     ; 659 				send_buf[14] = st1.st_ges4_ctrl_action_value;
3549  045a 5500b2004b    	mov	_send_buf+14,_st1+58
3550                     ; 660 				send_buf[15] = 0x00;
3552  045f 725f004c      	clr	_send_buf+15
3554  0463 ac190519      	jpf	L1331
3555  0467               L3151:
3556                     ; 662 			else if(st_pad1_confirm)
3558  0467 c600c8        	ld	a,_UART1Flag3_
3559  046a a510          	bcp	a,#16
3560  046c 2735          	jreq	L7151
3561                     ; 664 				send_buf[7] = 0x01;//触发器是按键
3563  046e 35010044      	mov	_send_buf+7,#1
3564                     ; 665 				send_buf[8] = 0x00;
3566  0472 725f0045      	clr	_send_buf+8
3567                     ; 666 				send_buf[9] = (st1.st_pad1_ctrl_boardid<<4) | st1.st_ctrl_address;
3569  0476 c60087        	ld	a,_st1+15
3570  0479 97            	ld	xl,a
3571  047a a610          	ld	a,#16
3572  047c 42            	mul	x,a
3573  047d 9f            	ld	a,xl
3574  047e ca007b        	or	a,_st1+3
3575  0481 c70046        	ld	_send_buf+9,a
3576                     ; 667 				send_buf[10] = st1.st_pad1_ctrl_meshid_H;
3578  0484 5500850047    	mov	_send_buf+10,_st1+13
3579                     ; 668 				send_buf[11] = st1.st_pad1_ctrl_meshid_L;
3581  0489 5500860048    	mov	_send_buf+11,_st1+14
3582                     ; 669 				send_buf[12] = st1.st_pad1_ctrl_action;
3584  048e 5500880049    	mov	_send_buf+12,_st1+16
3585                     ; 670 				send_buf[13] = st1.st_pad1_ctrl_boardid;
3587  0493 550087004a    	mov	_send_buf+13,_st1+15
3588                     ; 671 				send_buf[14] = st1.st_pad1_status;
3590  0498 55007e004b    	mov	_send_buf+14,_st1+6
3591                     ; 672 				send_buf[15] = 0x00;
3593  049d 725f004c      	clr	_send_buf+15
3595  04a1 2076          	jra	L1331
3596  04a3               L7151:
3597                     ; 674 			else if(st_pad2_confirm)
3599  04a3 c600c8        	ld	a,_UART1Flag3_
3600  04a6 a520          	bcp	a,#32
3601  04a8 2735          	jreq	L3251
3602                     ; 676 				send_buf[7] = 0x01;//触发器是按键
3604  04aa 35010044      	mov	_send_buf+7,#1
3605                     ; 677 				send_buf[8] = 0x00;
3607  04ae 725f0045      	clr	_send_buf+8
3608                     ; 678 				send_buf[9] = (st1.st_pad2_ctrl_boardid<<4) |st1.st_ctrl_address;
3610  04b2 c6008c        	ld	a,_st1+20
3611  04b5 97            	ld	xl,a
3612  04b6 a610          	ld	a,#16
3613  04b8 42            	mul	x,a
3614  04b9 9f            	ld	a,xl
3615  04ba ca007b        	or	a,_st1+3
3616  04bd c70046        	ld	_send_buf+9,a
3617                     ; 679 				send_buf[10] = st1.st_pad2_ctrl_meshid_H;
3619  04c0 55008a0047    	mov	_send_buf+10,_st1+18
3620                     ; 680 				send_buf[11] = st1.st_pad2_ctrl_meshid_L;
3622  04c5 55008b0048    	mov	_send_buf+11,_st1+19
3623                     ; 681 				send_buf[12] = st1.st_pad2_ctrl_action;
3625  04ca 55008d0049    	mov	_send_buf+12,_st1+21
3626                     ; 682 				send_buf[13] = st1.st_pad2_ctrl_boardid;
3628  04cf 55008c004a    	mov	_send_buf+13,_st1+20
3629                     ; 683 				send_buf[14] = st1.st_pad2_status;
3631  04d4 55007f004b    	mov	_send_buf+14,_st1+7
3632                     ; 684 				send_buf[15] = 0x00;
3634  04d9 725f004c      	clr	_send_buf+15
3636  04dd 203a          	jra	L1331
3637  04df               L3251:
3638                     ; 686 			else if(st_pad3_confirm)
3640  04df c600c8        	ld	a,_UART1Flag3_
3641  04e2 a540          	bcp	a,#64
3642  04e4 2733          	jreq	L1331
3643                     ; 688 				send_buf[7] = 0x01;//触发器是按键
3645  04e6 35010044      	mov	_send_buf+7,#1
3646                     ; 689 				send_buf[8] = 0x00;
3648  04ea 725f0045      	clr	_send_buf+8
3649                     ; 690 				send_buf[9] = (st1.st_pad3_ctrl_boardid<<4) |st1.st_ctrl_address;
3651  04ee c60091        	ld	a,_st1+25
3652  04f1 97            	ld	xl,a
3653  04f2 a610          	ld	a,#16
3654  04f4 42            	mul	x,a
3655  04f5 9f            	ld	a,xl
3656  04f6 ca007b        	or	a,_st1+3
3657  04f9 c70046        	ld	_send_buf+9,a
3658                     ; 691 				send_buf[10] = st1.st_pad3_ctrl_meshid_H;
3660  04fc 55008f0047    	mov	_send_buf+10,_st1+23
3661                     ; 692 				send_buf[11] = st1.st_pad3_ctrl_meshid_L;
3663  0501 5500900048    	mov	_send_buf+11,_st1+24
3664                     ; 693 				send_buf[12] = st1.st_pad3_ctrl_action;
3666  0506 5500920049    	mov	_send_buf+12,_st1+26
3667                     ; 694 				send_buf[13] = st1.st_pad3_ctrl_boardid;
3669  050b 550091004a    	mov	_send_buf+13,_st1+25
3670                     ; 695 				send_buf[14] = st1.st_pad3_status;
3672  0510 550080004b    	mov	_send_buf+14,_st1+8
3673                     ; 696 				send_buf[15] = 0x00;
3675  0515 725f004c      	clr	_send_buf+15
3676  0519               L1331:
3677                     ; 700 	send_buf[len+2] = Check_Sum((send_buf+2),len);
3679  0519 7b06          	ld	a,(OFST+6,sp)
3680  051b 5f            	clrw	x
3681  051c 97            	ld	xl,a
3682  051d 89            	pushw	x
3683  051e 7b08          	ld	a,(OFST+8,sp)
3684  0520 88            	push	a
3685  0521 ae003f        	ldw	x,#_send_buf+2
3686  0524 cd0000        	call	_Check_Sum
3688  0527 5b01          	addw	sp,#1
3689  0529 85            	popw	x
3690  052a d7003f        	ld	(_send_buf+2,x),a
3691                     ; 702 }
3694  052d 85            	popw	x
3695  052e 81            	ret
3762                     ; 720 void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length)
3762                     ; 721 {
3763                     .text:	section	.text,new
3764  0000               _rev_header_anaylze:
3766  0000 89            	pushw	x
3767       00000000      OFST:	set	0
3770                     ; 722 	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
3772  0001 c60001        	ld	a,_sicp_buf
3773  0004 a1ee          	cp	a,#238
3774  0006 262c          	jrne	L3651
3776  0008 c60002        	ld	a,_sicp_buf+1
3777  000b a1ee          	cp	a,#238
3778  000d 2707          	jreq	L5651
3780  000f c60002        	ld	a,_sicp_buf+1
3781  0012 a1aa          	cp	a,#170
3782  0014 261e          	jrne	L3651
3783  0016               L5651:
3784                     ; 724 		ble_data_frame = 1;
3786  0016 721a00ca      	bset	_UART1Flag1_,#5
3787                     ; 725 		*message_id = sicp_buf[2];
3789  001a 1e01          	ldw	x,(OFST+1,sp)
3790  001c c60003        	ld	a,_sicp_buf+2
3791  001f f7            	ld	(x),a
3792                     ; 726 		*mesh_id_H = sicp_buf[3];
3794  0020 1e05          	ldw	x,(OFST+5,sp)
3795  0022 c60004        	ld	a,_sicp_buf+3
3796  0025 f7            	ld	(x),a
3797                     ; 727 		*mesh_id_L = sicp_buf[4];
3799  0026 1e07          	ldw	x,(OFST+7,sp)
3800  0028 c60005        	ld	a,_sicp_buf+4
3801  002b f7            	ld	(x),a
3802                     ; 728 		*message_length = sicp_buf[5];
3804  002c 1e09          	ldw	x,(OFST+9,sp)
3805  002e c60006        	ld	a,_sicp_buf+5
3806  0031 f7            	ld	(x),a
3808  0032 2018          	jra	L7651
3809  0034               L3651:
3810                     ; 731 	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))//Network	Status	Reporting	
3812  0034 c60001        	ld	a,_sicp_buf
3813  0037 a1dd          	cp	a,#221
3814  0039 2611          	jrne	L7651
3816  003b c60002        	ld	a,_sicp_buf+1
3817  003e a1dd          	cp	a,#221
3818  0040 260a          	jrne	L7651
3819                     ; 733 		ble_ctrl_frame = 1;
3821  0042 721c00ca      	bset	_UART1Flag1_,#6
3822                     ; 734 		*message_length = sicp_buf[3];
3824  0046 1e09          	ldw	x,(OFST+9,sp)
3825  0048 c60004        	ld	a,_sicp_buf+3
3826  004b f7            	ld	(x),a
3827  004c               L7651:
3828                     ; 741 }
3831  004c 85            	popw	x
3832  004d 81            	ret
3909                     ; 748 bool rev_payload_anaylze(void)
3909                     ; 749 {
3910                     .text:	section	.text,new
3911  0000               _rev_payload_anaylze:
3913  0000 88            	push	a
3914       00000001      OFST:	set	1
3917                     ; 750 	u8 action_ctrl_num = 0;
3919  0001 0f01          	clr	(OFST+0,sp)
3920                     ; 751 	if (ble_data_frame)
3922  0003 c600ca        	ld	a,_UART1Flag1_
3923  0006 a520          	bcp	a,#32
3924  0008 2603          	jrne	L621
3925  000a cc06d9        	jp	L1661
3926  000d               L621:
3927                     ; 753 		ble_data_frame = 0;
3929  000d 721b00ca      	bres	_UART1Flag1_,#5
3930                     ; 754 		switch(sicp_buf[6])
3932  0011 c60007        	ld	a,_sicp_buf+6
3934                     ; 1072 			default:
3934                     ; 1073 				break;
3935  0014 a003          	sub	a,#3
3936  0016 2603          	jrne	L031
3937  0018 cc03b1        	jp	L1061
3938  001b               L031:
3939  001b 4a            	dec	a
3940  001c 272d          	jreq	L3751
3941  001e 4a            	dec	a
3942  001f 2603          	jrne	L231
3943  0021 cc0672        	jp	L1261
3944  0024               L231:
3945  0024 a004          	sub	a,#4
3946  0026 2603          	jrne	L431
3947  0028 cc0505        	jp	L5061
3948  002b               L431:
3949  002b a04d          	sub	a,#77
3950  002d 2603          	jrne	L631
3951  002f cc0440        	jp	L3061
3952  0032               L631:
3953  0032 a054          	sub	a,#84
3954  0034 2603          	jrne	L041
3955  0036 cc038d        	jp	L5751
3956  0039               L041:
3957  0039 a006          	sub	a,#6
3958  003b 2603          	jrne	L241
3959  003d cc069c        	jp	L3261
3960  0040               L241:
3961  0040 a010          	sub	a,#16
3962  0042 2603          	jrne	L441
3963  0044 cc039f        	jp	L7751
3964  0047               L441:
3965  0047 acd406d4      	jpf	L5661
3966  004b               L3751:
3967                     ; 756 			case 0x04://SS向ST发送配置信息
3967                     ; 757 				receipt_device_info1 = 1;
3969  004b 721000c6      	bset	_UART1Flag5_,#0
3970                     ; 760 					if (sicp_buf[7] == 0x01)//设置ST按键作用
3972  004f c60008        	ld	a,_sicp_buf+7
3973  0052 a101          	cp	a,#1
3974  0054 2703          	jreq	L641
3975  0056 cc015d        	jp	L7661
3976  0059               L641:
3977                     ; 762 						kickout_flag = 0;
3979  0059 721100c7      	bres	_UART1Flag4_,#0
3980                     ; 763 						net_reset_flag = 0;
3982  005d 721300c7      	bres	_UART1Flag4_,#1
3983                     ; 764 						if (sicp_buf[8] == 1)//设置通道1
3985  0061 c60009        	ld	a,_sicp_buf+8
3986  0064 a101          	cp	a,#1
3987  0066 2640          	jrne	L1761
3988                     ; 766 							st1.st_pad1_ctrl_meshid_H = sicp_buf[10];
3990  0068 55000b0085    	mov	_st1+13,_sicp_buf+10
3991                     ; 767 							st1.st_pad1_ctrl_meshid_L = sicp_buf[11];
3993  006d 55000c0086    	mov	_st1+14,_sicp_buf+11
3994                     ; 768 							st1.st_pad1_ctrl_boardid 	= sicp_buf[12];
3996  0072 55000d0087    	mov	_st1+15,_sicp_buf+12
3997                     ; 769 							st1.st_pad1_ctrl_action   = sicp_buf[13];
3999  0077 55000e0088    	mov	_st1+16,_sicp_buf+13
4000                     ; 770 							st1.st_pad1_ctrl_action_value = sicp_buf[14];
4002  007c 55000f0089    	mov	_st1+17,_sicp_buf+14
4003                     ; 771 							receipt_conf_pad1 = 1;
4005  0081 721c00c6      	bset	_UART1Flag5_,#6
4006                     ; 772 							send_message_length = 6;
4008  0085 35060065      	mov	_send_message_length,#6
4009                     ; 773 							send_cmd = 0xAA;
4011  0089 35aa0064      	mov	_send_cmd,#170
4012                     ; 774 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4014  008d 4baa          	push	#170
4015  008f 4b06          	push	#6
4016  0091 3b006b        	push	_ns_host_meshid_L
4017  0094 c6006c        	ld	a,_ns_host_meshid_H
4018  0097 97            	ld	xl,a
4019  0098 c6006a        	ld	a,_rev_message_id
4020  009b 95            	ld	xh,a
4021  009c cd0000        	call	_send_header_payload_init
4023  009f 5b03          	addw	sp,#3
4024                     ; 775 							UART2_Send_Data_Start();
4026  00a1 cd0000        	call	_UART2_Send_Data_Start
4028                     ; 776 							break;
4030  00a4 acd406d4      	jpf	L5661
4031  00a8               L1761:
4032                     ; 778 						else if (sicp_buf[8] == 2)//设置通道2
4034  00a8 c60009        	ld	a,_sicp_buf+8
4035  00ab a102          	cp	a,#2
4036  00ad 2640          	jrne	L5761
4037                     ; 780 							st1.st_pad2_ctrl_meshid_H = sicp_buf[10];
4039  00af 55000b008a    	mov	_st1+18,_sicp_buf+10
4040                     ; 781 							st1.st_pad2_ctrl_meshid_L = sicp_buf[11];
4042  00b4 55000c008b    	mov	_st1+19,_sicp_buf+11
4043                     ; 782 							st1.st_pad2_ctrl_boardid 	= sicp_buf[12];
4045  00b9 55000d008c    	mov	_st1+20,_sicp_buf+12
4046                     ; 783 							st1.st_pad2_ctrl_action   = sicp_buf[13];
4048  00be 55000e008d    	mov	_st1+21,_sicp_buf+13
4049                     ; 784 							st1.st_pad2_ctrl_action_value = sicp_buf[14];
4051  00c3 55000f008e    	mov	_st1+22,_sicp_buf+14
4052                     ; 785 							receipt_conf_pad1 = 1;
4054  00c8 721c00c6      	bset	_UART1Flag5_,#6
4055                     ; 786 							send_message_length = 6;
4057  00cc 35060065      	mov	_send_message_length,#6
4058                     ; 787 							send_cmd = 0xAA;
4060  00d0 35aa0064      	mov	_send_cmd,#170
4061                     ; 788 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4063  00d4 4baa          	push	#170
4064  00d6 4b06          	push	#6
4065  00d8 3b006b        	push	_ns_host_meshid_L
4066  00db c6006c        	ld	a,_ns_host_meshid_H
4067  00de 97            	ld	xl,a
4068  00df c6006a        	ld	a,_rev_message_id
4069  00e2 95            	ld	xh,a
4070  00e3 cd0000        	call	_send_header_payload_init
4072  00e6 5b03          	addw	sp,#3
4073                     ; 789 							UART2_Send_Data_Start();
4075  00e8 cd0000        	call	_UART2_Send_Data_Start
4077                     ; 790 							break;
4079  00eb acd406d4      	jpf	L5661
4080  00ef               L5761:
4081                     ; 792 						else if (sicp_buf[8] == 3)//设置通道3
4083  00ef c60009        	ld	a,_sicp_buf+8
4084  00f2 a103          	cp	a,#3
4085  00f4 2640          	jrne	L1071
4086                     ; 794 							st1.st_pad3_ctrl_meshid_H = sicp_buf[10];
4088  00f6 55000b008f    	mov	_st1+23,_sicp_buf+10
4089                     ; 795 							st1.st_pad3_ctrl_meshid_L = sicp_buf[11];
4091  00fb 55000c0090    	mov	_st1+24,_sicp_buf+11
4092                     ; 796 							st1.st_pad3_ctrl_boardid 	= sicp_buf[12];
4094  0100 55000d0091    	mov	_st1+25,_sicp_buf+12
4095                     ; 797 							st1.st_pad3_ctrl_action   = sicp_buf[13];
4097  0105 55000e0092    	mov	_st1+26,_sicp_buf+13
4098                     ; 798 							st1.st_pad3_ctrl_action_value = sicp_buf[14];
4100  010a 55000f0093    	mov	_st1+27,_sicp_buf+14
4101                     ; 799 							receipt_conf_pad1 = 1;
4103  010f 721c00c6      	bset	_UART1Flag5_,#6
4104                     ; 800 							send_message_length = 6;
4106  0113 35060065      	mov	_send_message_length,#6
4107                     ; 801 							send_cmd = 0xAA;
4109  0117 35aa0064      	mov	_send_cmd,#170
4110                     ; 802 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4112  011b 4baa          	push	#170
4113  011d 4b06          	push	#6
4114  011f 3b006b        	push	_ns_host_meshid_L
4115  0122 c6006c        	ld	a,_ns_host_meshid_H
4116  0125 97            	ld	xl,a
4117  0126 c6006a        	ld	a,_rev_message_id
4118  0129 95            	ld	xh,a
4119  012a cd0000        	call	_send_header_payload_init
4121  012d 5b03          	addw	sp,#3
4122                     ; 803 							UART2_Send_Data_Start();
4124  012f cd0000        	call	_UART2_Send_Data_Start
4126                     ; 804 							break;
4128  0132 acd406d4      	jpf	L5661
4129  0136               L1071:
4130                     ; 808 							receipt_conf_pad2 = 1;
4132  0136 721e00c6      	bset	_UART1Flag5_,#7
4133                     ; 809 							send_message_length = 6;
4135  013a 35060065      	mov	_send_message_length,#6
4136                     ; 810 							send_cmd = 0xAA;
4138  013e 35aa0064      	mov	_send_cmd,#170
4139                     ; 811 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4141  0142 4baa          	push	#170
4142  0144 4b06          	push	#6
4143  0146 3b006b        	push	_ns_host_meshid_L
4144  0149 c6006c        	ld	a,_ns_host_meshid_H
4145  014c 97            	ld	xl,a
4146  014d c6006a        	ld	a,_rev_message_id
4147  0150 95            	ld	xh,a
4148  0151 cd0000        	call	_send_header_payload_init
4150  0154 5b03          	addw	sp,#3
4151                     ; 812 							UART2_Send_Data_Start();
4153  0156 cd0000        	call	_UART2_Send_Data_Start
4155                     ; 813 							break;
4157  0159 acd406d4      	jpf	L5661
4158  015d               L7661:
4159                     ; 817 					else if (sicp_buf[7] == 0x02)//设置ST手势作用
4161  015d c60008        	ld	a,_sicp_buf+7
4162  0160 a102          	cp	a,#2
4163  0162 2703          	jreq	L051
4164  0164 cc06d4        	jp	L5661
4165  0167               L051:
4166                     ; 819 						kickout_flag = 0;
4168  0167 721100c7      	bres	_UART1Flag4_,#0
4169                     ; 820 						net_reset_flag = 0;
4171  016b 721300c7      	bres	_UART1Flag4_,#1
4172                     ; 822 						if((st1.st_ges1_ctrl_H == 0x11) && (st1.st_ges1_ctrl_L == 0x11) && (sicp_buf[8] != st1.st_ges1_ctrl_H) && (sicp_buf[9] != st1.st_ges1_ctrl_L))//第一个预设置手势
4174  016f c60094        	ld	a,_st1+28
4175  0172 a111          	cp	a,#17
4176  0174 2661          	jrne	L1171
4178  0176 c60095        	ld	a,_st1+29
4179  0179 a111          	cp	a,#17
4180  017b 265a          	jrne	L1171
4182  017d c60009        	ld	a,_sicp_buf+8
4183  0180 c10094        	cp	a,_st1+28
4184  0183 2752          	jreq	L1171
4186  0185 c6000a        	ld	a,_sicp_buf+9
4187  0188 c10095        	cp	a,_st1+29
4188  018b 274a          	jreq	L1171
4189                     ; 824 							st1.st_ges1_ctrl_H						= sicp_buf[8];
4191  018d 5500090094    	mov	_st1+28,_sicp_buf+8
4192                     ; 825 							st1.st_ges1_ctrl_L						= sicp_buf[9];
4194  0192 55000a0095    	mov	_st1+29,_sicp_buf+9
4195                     ; 826 							st1.st_ges1_ctrl_meshid_H 		= sicp_buf[10];
4197  0197 55000b0096    	mov	_st1+30,_sicp_buf+10
4198                     ; 827 							st1.st_ges1_ctrl_meshid_L 		= sicp_buf[11];
4200  019c 55000c0097    	mov	_st1+31,_sicp_buf+11
4201                     ; 828 							st1.st_ges1_ctrl_boardid 			= sicp_buf[12];
4203  01a1 55000d0098    	mov	_st1+32,_sicp_buf+12
4204                     ; 829 							st1.st_ges1_ctrl_action				= sicp_buf[13];
4206  01a6 55000e00a8    	mov	_st1+48,_sicp_buf+13
4207                     ; 830 							st1.st_ges1_ctrl_action_value = sicp_buf[14];
4209  01ab 55000f00a9    	mov	_st1+49,_sicp_buf+14
4210                     ; 832 							receipt_conf_gest1 = 1;
4212  01b0 721000c5      	bset	_UART1Flag6_,#0
4213                     ; 833 							send_message_length = 6;
4215  01b4 35060065      	mov	_send_message_length,#6
4216                     ; 834 							send_cmd = 0xAA;
4218  01b8 35aa0064      	mov	_send_cmd,#170
4219                     ; 835 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4221  01bc 4baa          	push	#170
4222  01be 4b06          	push	#6
4223  01c0 3b006b        	push	_ns_host_meshid_L
4224  01c3 c6006c        	ld	a,_ns_host_meshid_H
4225  01c6 97            	ld	xl,a
4226  01c7 c6006a        	ld	a,_rev_message_id
4227  01ca 95            	ld	xh,a
4228  01cb cd0000        	call	_send_header_payload_init
4230  01ce 5b03          	addw	sp,#3
4231                     ; 836 							UART2_Send_Data_Start();
4233  01d0 cd0000        	call	_UART2_Send_Data_Start
4235                     ; 837 							break;
4237  01d3 acd406d4      	jpf	L5661
4238  01d7               L1171:
4239                     ; 839 						else if((st1.st_ges2_ctrl_H == 0x11) && (st1.st_ges2_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges2_ctrl_H) && (sicp_buf[9] != st1.st_ges2_ctrl_L))//第二个预设置手势
4241  01d7 c60099        	ld	a,_st1+33
4242  01da a111          	cp	a,#17
4243  01dc 2661          	jrne	L5171
4245  01de c6009a        	ld	a,_st1+34
4246  01e1 a111          	cp	a,#17
4247  01e3 265a          	jrne	L5171
4249  01e5 c60009        	ld	a,_sicp_buf+8
4250  01e8 c10099        	cp	a,_st1+33
4251  01eb 2752          	jreq	L5171
4253  01ed c6000a        	ld	a,_sicp_buf+9
4254  01f0 c1009a        	cp	a,_st1+34
4255  01f3 274a          	jreq	L5171
4256                     ; 841 							st1.st_ges2_ctrl_H						= sicp_buf[8];
4258  01f5 5500090099    	mov	_st1+33,_sicp_buf+8
4259                     ; 842 							st1.st_ges2_ctrl_L						= sicp_buf[9];
4261  01fa 55000a009a    	mov	_st1+34,_sicp_buf+9
4262                     ; 843 							st1.st_ges2_ctrl_meshid_H 		= sicp_buf[10];
4264  01ff 55000b009b    	mov	_st1+35,_sicp_buf+10
4265                     ; 844 							st1.st_ges2_ctrl_meshid_L 		= sicp_buf[11];
4267  0204 55000c009c    	mov	_st1+36,_sicp_buf+11
4268                     ; 845 							st1.st_ges2_ctrl_boardid 			= sicp_buf[12];
4270  0209 55000d009d    	mov	_st1+37,_sicp_buf+12
4271                     ; 846 							st1.st_ges2_ctrl_action				= sicp_buf[13];
4273  020e 55000e00ab    	mov	_st1+51,_sicp_buf+13
4274                     ; 847 							st1.st_ges2_ctrl_action_value = sicp_buf[14];
4276  0213 55000f00ac    	mov	_st1+52,_sicp_buf+14
4277                     ; 849 							receipt_conf_gest1 = 1;
4279  0218 721000c5      	bset	_UART1Flag6_,#0
4280                     ; 850 							send_message_length = 6;
4282  021c 35060065      	mov	_send_message_length,#6
4283                     ; 851 							send_cmd = 0xAA;
4285  0220 35aa0064      	mov	_send_cmd,#170
4286                     ; 852 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4288  0224 4baa          	push	#170
4289  0226 4b06          	push	#6
4290  0228 3b006b        	push	_ns_host_meshid_L
4291  022b c6006c        	ld	a,_ns_host_meshid_H
4292  022e 97            	ld	xl,a
4293  022f c6006a        	ld	a,_rev_message_id
4294  0232 95            	ld	xh,a
4295  0233 cd0000        	call	_send_header_payload_init
4297  0236 5b03          	addw	sp,#3
4298                     ; 853 							UART2_Send_Data_Start();
4300  0238 cd0000        	call	_UART2_Send_Data_Start
4302                     ; 854 							break;
4304  023b acd406d4      	jpf	L5661
4305  023f               L5171:
4306                     ; 856 						else if((st1.st_ges3_ctrl_H == 0x11) && (st1.st_ges3_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges3_ctrl_H) && (sicp_buf[9] != st1.st_ges3_ctrl_L))//第三个预设置手势
4308  023f c6009e        	ld	a,_st1+38
4309  0242 a111          	cp	a,#17
4310  0244 2661          	jrne	L1271
4312  0246 c6009f        	ld	a,_st1+39
4313  0249 a111          	cp	a,#17
4314  024b 265a          	jrne	L1271
4316  024d c60009        	ld	a,_sicp_buf+8
4317  0250 c1009e        	cp	a,_st1+38
4318  0253 2752          	jreq	L1271
4320  0255 c6000a        	ld	a,_sicp_buf+9
4321  0258 c1009f        	cp	a,_st1+39
4322  025b 274a          	jreq	L1271
4323                     ; 858 							st1.st_ges3_ctrl_H						= sicp_buf[8];
4325  025d 550009009e    	mov	_st1+38,_sicp_buf+8
4326                     ; 859 							st1.st_ges3_ctrl_L						= sicp_buf[9];
4328  0262 55000a009f    	mov	_st1+39,_sicp_buf+9
4329                     ; 860 							st1.st_ges3_ctrl_meshid_H 		= sicp_buf[10];
4331  0267 55000b00a0    	mov	_st1+40,_sicp_buf+10
4332                     ; 861 							st1.st_ges3_ctrl_meshid_L 		= sicp_buf[11];
4334  026c 55000c00a1    	mov	_st1+41,_sicp_buf+11
4335                     ; 862 							st1.st_ges3_ctrl_boardid 			= sicp_buf[12];
4337  0271 55000d00a2    	mov	_st1+42,_sicp_buf+12
4338                     ; 863 							st1.st_ges3_ctrl_action				= sicp_buf[13];
4340  0276 55000e00ae    	mov	_st1+54,_sicp_buf+13
4341                     ; 864 							st1.st_ges3_ctrl_action_value = sicp_buf[14];
4343  027b 55000f00af    	mov	_st1+55,_sicp_buf+14
4344                     ; 866 							receipt_conf_gest1 = 1;
4346  0280 721000c5      	bset	_UART1Flag6_,#0
4347                     ; 867 							send_message_length = 6;
4349  0284 35060065      	mov	_send_message_length,#6
4350                     ; 868 							send_cmd = 0xAA;
4352  0288 35aa0064      	mov	_send_cmd,#170
4353                     ; 869 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4355  028c 4baa          	push	#170
4356  028e 4b06          	push	#6
4357  0290 3b006b        	push	_ns_host_meshid_L
4358  0293 c6006c        	ld	a,_ns_host_meshid_H
4359  0296 97            	ld	xl,a
4360  0297 c6006a        	ld	a,_rev_message_id
4361  029a 95            	ld	xh,a
4362  029b cd0000        	call	_send_header_payload_init
4364  029e 5b03          	addw	sp,#3
4365                     ; 870 							UART2_Send_Data_Start();
4367  02a0 cd0000        	call	_UART2_Send_Data_Start
4369                     ; 871 							break;
4371  02a3 acd406d4      	jpf	L5661
4372  02a7               L1271:
4373                     ; 873 						else if((st1.st_ges4_ctrl_H == 0x11) && (st1.st_ges4_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges4_ctrl_H) && (sicp_buf[9] != st1.st_ges4_ctrl_L))//第三个预设置手势
4375  02a7 c600a3        	ld	a,_st1+43
4376  02aa a111          	cp	a,#17
4377  02ac 2661          	jrne	L5271
4379  02ae c600a4        	ld	a,_st1+44
4380  02b1 a111          	cp	a,#17
4381  02b3 265a          	jrne	L5271
4383  02b5 c60009        	ld	a,_sicp_buf+8
4384  02b8 c100a3        	cp	a,_st1+43
4385  02bb 2752          	jreq	L5271
4387  02bd c6000a        	ld	a,_sicp_buf+9
4388  02c0 c100a4        	cp	a,_st1+44
4389  02c3 274a          	jreq	L5271
4390                     ; 875 							st1.st_ges4_ctrl_H						= sicp_buf[8];
4392  02c5 55000900a3    	mov	_st1+43,_sicp_buf+8
4393                     ; 876 							st1.st_ges4_ctrl_L						= sicp_buf[9];
4395  02ca 55000a00a4    	mov	_st1+44,_sicp_buf+9
4396                     ; 877 							st1.st_ges4_ctrl_meshid_H 		= sicp_buf[10];
4398  02cf 55000b00a5    	mov	_st1+45,_sicp_buf+10
4399                     ; 878 							st1.st_ges4_ctrl_meshid_L 		= sicp_buf[11];
4401  02d4 55000c00a6    	mov	_st1+46,_sicp_buf+11
4402                     ; 879 							st1.st_ges4_ctrl_boardid 			= sicp_buf[12];
4404  02d9 55000d00a7    	mov	_st1+47,_sicp_buf+12
4405                     ; 880 							st1.st_ges4_ctrl_action				= sicp_buf[13];
4407  02de 55000e00b1    	mov	_st1+57,_sicp_buf+13
4408                     ; 881 							st1.st_ges4_ctrl_action_value = sicp_buf[14];
4410  02e3 55000f00b2    	mov	_st1+58,_sicp_buf+14
4411                     ; 883 							receipt_conf_gest1 = 1;
4413  02e8 721000c5      	bset	_UART1Flag6_,#0
4414                     ; 884 							send_message_length = 6;
4416  02ec 35060065      	mov	_send_message_length,#6
4417                     ; 885 							send_cmd = 0xAA;
4419  02f0 35aa0064      	mov	_send_cmd,#170
4420                     ; 886 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4422  02f4 4baa          	push	#170
4423  02f6 4b06          	push	#6
4424  02f8 3b006b        	push	_ns_host_meshid_L
4425  02fb c6006c        	ld	a,_ns_host_meshid_H
4426  02fe 97            	ld	xl,a
4427  02ff c6006a        	ld	a,_rev_message_id
4428  0302 95            	ld	xh,a
4429  0303 cd0000        	call	_send_header_payload_init
4431  0306 5b03          	addw	sp,#3
4432                     ; 887 							UART2_Send_Data_Start();
4434  0308 cd0000        	call	_UART2_Send_Data_Start
4436                     ; 888 							break;
4438  030b acd406d4      	jpf	L5661
4439  030f               L5271:
4440                     ; 890 						else if(((sicp_buf[8] == st1.st_ges1_ctrl_H) && (sicp_buf[9] == st1.st_ges1_ctrl_L))
4440                     ; 891 										|| ((sicp_buf[8] == st1.st_ges2_ctrl_H) && (sicp_buf[9] == st1.st_ges2_ctrl_L))
4440                     ; 892 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L))
4440                     ; 893 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L)))
4442  030f c60009        	ld	a,_sicp_buf+8
4443  0312 c10094        	cp	a,_st1+28
4444  0315 2608          	jrne	L5371
4446  0317 c6000a        	ld	a,_sicp_buf+9
4447  031a c10095        	cp	a,_st1+29
4448  031d 2720          	jreq	L3371
4449  031f               L5371:
4451  031f c60009        	ld	a,_sicp_buf+8
4452  0322 c10099        	cp	a,_st1+33
4453  0325 2608          	jrne	L1471
4455  0327 c6000a        	ld	a,_sicp_buf+9
4456  032a c1009a        	cp	a,_st1+34
4457  032d 2710          	jreq	L3371
4458  032f               L1471:
4460  032f c60009        	ld	a,_sicp_buf+8
4461  0332 c1009e        	cp	a,_st1+38
4462  0335 262f          	jrne	L1371
4464  0337 c6000a        	ld	a,_sicp_buf+9
4465  033a c1009f        	cp	a,_st1+39
4466  033d 2627          	jrne	L1371
4467  033f               L3371:
4468                     ; 895 							receipt_conf_gest1 = 1;
4470  033f 721000c5      	bset	_UART1Flag6_,#0
4471                     ; 896 							send_message_length = 6;
4473  0343 35060065      	mov	_send_message_length,#6
4474                     ; 897 							send_cmd = 0xAA;
4476  0347 35aa0064      	mov	_send_cmd,#170
4477                     ; 898 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4479  034b 4baa          	push	#170
4480  034d 4b06          	push	#6
4481  034f 3b006b        	push	_ns_host_meshid_L
4482  0352 c6006c        	ld	a,_ns_host_meshid_H
4483  0355 97            	ld	xl,a
4484  0356 c6006a        	ld	a,_rev_message_id
4485  0359 95            	ld	xh,a
4486  035a cd0000        	call	_send_header_payload_init
4488  035d 5b03          	addw	sp,#3
4489                     ; 899 							UART2_Send_Data_Start();
4491  035f cd0000        	call	_UART2_Send_Data_Start
4493                     ; 900 							break;
4495  0362 acd406d4      	jpf	L5661
4496  0366               L1371:
4497                     ; 904 							receipt_conf_gest2 = 1;
4499  0366 721200c5      	bset	_UART1Flag6_,#1
4500                     ; 905 							send_message_length = 6;
4502  036a 35060065      	mov	_send_message_length,#6
4503                     ; 906 							send_cmd = 0xAA;
4505  036e 35aa0064      	mov	_send_cmd,#170
4506                     ; 907 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4508  0372 4baa          	push	#170
4509  0374 4b06          	push	#6
4510  0376 3b006b        	push	_ns_host_meshid_L
4511  0379 c6006c        	ld	a,_ns_host_meshid_H
4512  037c 97            	ld	xl,a
4513  037d c6006a        	ld	a,_rev_message_id
4514  0380 95            	ld	xh,a
4515  0381 cd0000        	call	_send_header_payload_init
4517  0384 5b03          	addw	sp,#3
4518                     ; 908 							UART2_Send_Data_Start();
4520  0386 cd0000        	call	_UART2_Send_Data_Start
4522                     ; 909 							break;
4524  0389 acd406d4      	jpf	L5661
4525  038d               L5751:
4526                     ; 914 			case 0xAA://SS回复ST的Device Info，Kick Out踢出
4526                     ; 915 				if (sicp_buf[7] == 0x04)
4528  038d c60008        	ld	a,_sicp_buf+7
4529  0390 a104          	cp	a,#4
4530  0392 2703          	jreq	L251
4531  0394 cc06d4        	jp	L5661
4532  0397               L251:
4533                     ; 917 					kickout_flag = 1;
4535  0397 721000c7      	bset	_UART1Flag4_,#0
4536  039b acd406d4      	jpf	L5661
4537  039f               L7751:
4538                     ; 926 			case 0xC0://BLE 网络模块重置指令
4538                     ; 927 				if (sicp_buf[7] == 0x02)
4541  039f c60008        	ld	a,_sicp_buf+7
4542  03a2 a102          	cp	a,#2
4543  03a4 2703          	jreq	L451
4544  03a6 cc06d4        	jp	L5661
4545  03a9               L451:
4546                     ; 929 					net_reset_flag = 1;
4548  03a9 721200c7      	bset	_UART1Flag4_,#1
4549  03ad acd406d4      	jpf	L5661
4550  03b1               L1061:
4551                     ; 932 			case 0x03://CMD-Data 
4551                     ; 933 				if (sicp_buf[7] == 0x01)//获取ST传感器信息
4553  03b1 c60008        	ld	a,_sicp_buf+7
4554  03b4 a101          	cp	a,#1
4555  03b6 262d          	jrne	L1571
4556                     ; 935 					if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32))
4558  03b8 c60009        	ld	a,_sicp_buf+8
4559  03bb a130          	cp	a,#48
4560  03bd 2626          	jrne	L1571
4562  03bf c6000a        	ld	a,_sicp_buf+9
4563  03c2 a132          	cp	a,#50
4564  03c4 261f          	jrne	L1571
4565                     ; 937 						send_message_length = 9;
4567  03c6 35090065      	mov	_send_message_length,#9
4568                     ; 938 						send_cmd = 0x20;
4570  03ca 35200064      	mov	_send_cmd,#32
4571                     ; 939 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4573  03ce 4b20          	push	#32
4574  03d0 4b09          	push	#9
4575  03d2 3b006b        	push	_ns_host_meshid_L
4576  03d5 c6006c        	ld	a,_ns_host_meshid_H
4577  03d8 97            	ld	xl,a
4578  03d9 c6006a        	ld	a,_rev_message_id
4579  03dc 95            	ld	xh,a
4580  03dd cd0000        	call	_send_header_payload_init
4582  03e0 5b03          	addw	sp,#3
4583                     ; 940 						UART2_Send_Data_Start();
4585  03e2 cd0000        	call	_UART2_Send_Data_Start
4587  03e5               L1571:
4588                     ; 943 				if (sicp_buf[7] == 0x02)//刷新ST传感器数据
4590  03e5 c60008        	ld	a,_sicp_buf+7
4591  03e8 a102          	cp	a,#2
4592  03ea 2623          	jrne	L5571
4593                     ; 945 					cmd_refresh_flag = 1;
4595  03ec 721400ca      	bset	_UART1Flag1_,#2
4596                     ; 946 					send_message_length = 6;
4598  03f0 35060065      	mov	_send_message_length,#6
4599                     ; 947 					send_cmd = 0xAA;
4601  03f4 35aa0064      	mov	_send_cmd,#170
4602                     ; 948 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4604  03f8 4baa          	push	#170
4605  03fa 4b06          	push	#6
4606  03fc 3b006b        	push	_ns_host_meshid_L
4607  03ff c6006c        	ld	a,_ns_host_meshid_H
4608  0402 97            	ld	xl,a
4609  0403 c6006a        	ld	a,_rev_message_id
4610  0406 95            	ld	xh,a
4611  0407 cd0000        	call	_send_header_payload_init
4613  040a 5b03          	addw	sp,#3
4614                     ; 949 					UART2_Send_Data_Start();
4616  040c cd0000        	call	_UART2_Send_Data_Start
4618  040f               L5571:
4619                     ; 951 				if (sicp_buf[7] == 0x03)//获取ST当前设备的状态(灯亮度、开关)
4621  040f c60008        	ld	a,_sicp_buf+7
4622  0412 a103          	cp	a,#3
4623  0414 2703          	jreq	L651
4624  0416 cc06d4        	jp	L5661
4625  0419               L651:
4626                     ; 953 					cmd_status_flag = 1;
4628  0419 721600ca      	bset	_UART1Flag1_,#3
4629                     ; 955 					send_message_length = 10;
4631  041d 350a0065      	mov	_send_message_length,#10
4632                     ; 956 					send_cmd = 0x06;
4634  0421 35060064      	mov	_send_cmd,#6
4635                     ; 957 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4637  0425 4b06          	push	#6
4638  0427 4b0a          	push	#10
4639  0429 3b006b        	push	_ns_host_meshid_L
4640  042c c6006c        	ld	a,_ns_host_meshid_H
4641  042f 97            	ld	xl,a
4642  0430 c6006a        	ld	a,_rev_message_id
4643  0433 95            	ld	xh,a
4644  0434 cd0000        	call	_send_header_payload_init
4646  0437 5b03          	addw	sp,#3
4647                     ; 958 					UART2_Send_Data_Start();
4649  0439 cd0000        	call	_UART2_Send_Data_Start
4651  043c acd406d4      	jpf	L5661
4652  0440               L3061:
4653                     ; 961 			case 0x56://打开或关闭ST开关
4653                     ; 962 				action_ctrlpad_flag = 1;
4655  0440 721800ca      	bset	_UART1Flag1_,#4
4656                     ; 963 				send_message_length = 10;
4658  0444 350a0065      	mov	_send_message_length,#10
4659                     ; 964 				action_ctrl_address = st1.st_ctrl_address = sicp_buf[7];			
4661  0448 550008007b    	mov	_st1+3,_sicp_buf+7
4662  044d 55007b0000    	mov	_action_ctrl_address,_st1+3
4663                     ; 965 				if(((sicp_buf[7] & 0x01) == 0x01) && (st1.st_pad1_status != sicp_buf[8]))
4665  0452 c60008        	ld	a,_sicp_buf+7
4666  0455 a401          	and	a,#1
4667  0457 a101          	cp	a,#1
4668  0459 261f          	jrne	L1671
4670  045b c6007e        	ld	a,_st1+6
4671  045e c10009        	cp	a,_sicp_buf+8
4672  0461 2717          	jreq	L1671
4673                     ; 966 					{st_pad1_ctrl = 1;st_pad1_confirm = 1;st1.st_pad1_status = sicp_buf[8];action_ctrl_num++;send_message_length += 5;}
4675  0463 721200c8      	bset	_UART1Flag3_,#1
4678  0467 721800c8      	bset	_UART1Flag3_,#4
4681  046b 550009007e    	mov	_st1+6,_sicp_buf+8
4684  0470 0c01          	inc	(OFST+0,sp)
4687  0472 c60065        	ld	a,_send_message_length
4688  0475 ab05          	add	a,#5
4689  0477 c70065        	ld	_send_message_length,a
4690  047a               L1671:
4691                     ; 967 				if(((sicp_buf[7] & 0x02) == 0x02) && (st1.st_pad2_status != sicp_buf[8]))
4693  047a c60008        	ld	a,_sicp_buf+7
4694  047d a402          	and	a,#2
4695  047f a102          	cp	a,#2
4696  0481 261f          	jrne	L3671
4698  0483 c6007f        	ld	a,_st1+7
4699  0486 c10009        	cp	a,_sicp_buf+8
4700  0489 2717          	jreq	L3671
4701                     ; 968 					{st_pad2_ctrl = 1;st_pad2_confirm = 1;st1.st_pad2_status = sicp_buf[8];action_ctrl_num++;send_message_length += 5;}
4703  048b 721400c8      	bset	_UART1Flag3_,#2
4706  048f 721a00c8      	bset	_UART1Flag3_,#5
4709  0493 550009007f    	mov	_st1+7,_sicp_buf+8
4712  0498 0c01          	inc	(OFST+0,sp)
4715  049a c60065        	ld	a,_send_message_length
4716  049d ab05          	add	a,#5
4717  049f c70065        	ld	_send_message_length,a
4718  04a2               L3671:
4719                     ; 969 				if(((sicp_buf[7] & 0x04) == 0x04) && (st1.st_pad3_status != sicp_buf[8]))
4721  04a2 c60008        	ld	a,_sicp_buf+7
4722  04a5 a404          	and	a,#4
4723  04a7 a104          	cp	a,#4
4724  04a9 261f          	jrne	L5671
4726  04ab c60080        	ld	a,_st1+8
4727  04ae c10009        	cp	a,_sicp_buf+8
4728  04b1 2717          	jreq	L5671
4729                     ; 970 					{st_pad3_ctrl = 1;st_pad3_confirm = 1;st1.st_pad3_status = sicp_buf[8];action_ctrl_num++;send_message_length += 5;}
4731  04b3 721600c8      	bset	_UART1Flag3_,#3
4734  04b7 721c00c8      	bset	_UART1Flag3_,#6
4737  04bb 5500090080    	mov	_st1+8,_sicp_buf+8
4740  04c0 0c01          	inc	(OFST+0,sp)
4743  04c2 c60065        	ld	a,_send_message_length
4744  04c5 ab05          	add	a,#5
4745  04c7 c70065        	ld	_send_message_length,a
4746  04ca               L5671:
4747                     ; 971 				if((sicp_buf[7] & 0x08) == 0x08)
4749  04ca c60008        	ld	a,_sicp_buf+7
4750  04cd a408          	and	a,#8
4751  04cf a108          	cp	a,#8
4752  04d1 2604          	jrne	L7671
4753                     ; 972 					st_led_ctrl = 1;
4755  04d3 721000c8      	bset	_UART1Flag3_,#0
4756  04d7               L7671:
4757                     ; 973 				st1.st_ctrl_value  = sicp_buf[8];
4759  04d7 550009007c    	mov	_st1+4,_sicp_buf+8
4760                     ; 974 				send_message_length += (action_ctrl_num+1);//增加发送1个字节表示action_ctrl_num
4762  04dc 7b01          	ld	a,(OFST+0,sp)
4763  04de 4c            	inc	a
4764  04df cb0065        	add	a,_send_message_length
4765  04e2 c70065        	ld	_send_message_length,a
4766                     ; 975 				send_cmd = 0xAA;
4768  04e5 35aa0064      	mov	_send_cmd,#170
4769                     ; 976 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4771  04e9 4baa          	push	#170
4772  04eb 3b0065        	push	_send_message_length
4773  04ee 3b006b        	push	_ns_host_meshid_L
4774  04f1 c6006c        	ld	a,_ns_host_meshid_H
4775  04f4 97            	ld	xl,a
4776  04f5 c6006a        	ld	a,_rev_message_id
4777  04f8 95            	ld	xh,a
4778  04f9 cd0000        	call	_send_header_payload_init
4780  04fc 5b03          	addw	sp,#3
4781                     ; 978 				UART2_Send_Data_Start();
4783  04fe cd0000        	call	_UART2_Send_Data_Start
4785                     ; 979 				break;
4787  0501 acd406d4      	jpf	L5661
4788  0505               L5061:
4789                     ; 980 			case 0x09://LED控制
4789                     ; 981 				led_ctrl_flag = 1;
4791  0505 721400c7      	bset	_UART1Flag4_,#2
4792                     ; 982 				switch(sicp_buf[7])
4794  0509 c60008        	ld	a,_sicp_buf+7
4796                     ; 1049 						break;
4797  050c a01f          	sub	a,#31
4798  050e 271d          	jreq	L7061
4799  0510 a010          	sub	a,#16
4800  0512 2768          	jreq	L1161
4801  0514 a010          	sub	a,#16
4802  0516 2603          	jrne	L061
4803  0518 cc05d5        	jp	L3161
4804  051b               L061:
4805  051b a010          	sub	a,#16
4806  051d 2603          	jrne	L261
4807  051f cc0624        	jp	L5161
4808  0522               L261:
4809  0522 a010          	sub	a,#16
4810  0524 2603          	jrne	L461
4811  0526 cc064b        	jp	L7161
4812  0529               L461:
4813  0529 acd406d4      	jpf	L5661
4814  052d               L7061:
4815                     ; 984 					case 0x1F://循环模式
4815                     ; 985 						st1.st_led_mode = 0x1F;
4817  052d 351f00b4      	mov	_st1+60,#31
4818                     ; 986 						st1.st_led_density = sicp_buf[8];
4820  0531 55000900b5    	mov	_st1+61,_sicp_buf+8
4821                     ; 987 						st1.st_led_speed = sicp_buf[9];
4823  0536 55000a00b6    	mov	_st1+62,_sicp_buf+9
4824                     ; 988 						st1.st_led_color1_H = sicp_buf[10];
4826  053b 55000b00b7    	mov	_st1+63,_sicp_buf+10
4827                     ; 989 						st1.st_led_color1_M = sicp_buf[11];
4829  0540 55000c00b8    	mov	_st1+64,_sicp_buf+11
4830                     ; 990 						st1.st_led_color1_L = sicp_buf[12];
4832  0545 55000d00b9    	mov	_st1+65,_sicp_buf+12
4833                     ; 991 						st1.st_led_color2_H = sicp_buf[13];
4835  054a 55000e00ba    	mov	_st1+66,_sicp_buf+13
4836                     ; 992 						st1.st_led_color2_M = sicp_buf[14];
4838  054f 55000f00bb    	mov	_st1+67,_sicp_buf+14
4839                     ; 993 						st1.st_led_color2_L = sicp_buf[15];
4841  0554 55001000bc    	mov	_st1+68,_sicp_buf+15
4842                     ; 994 						send_message_length = 6;
4844  0559 35060065      	mov	_send_message_length,#6
4845                     ; 995 						send_cmd = 0xAA;
4847  055d 35aa0064      	mov	_send_cmd,#170
4848                     ; 996 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4850  0561 4baa          	push	#170
4851  0563 4b06          	push	#6
4852  0565 3b006b        	push	_ns_host_meshid_L
4853  0568 c6006c        	ld	a,_ns_host_meshid_H
4854  056b 97            	ld	xl,a
4855  056c c6006a        	ld	a,_rev_message_id
4856  056f 95            	ld	xh,a
4857  0570 cd0000        	call	_send_header_payload_init
4859  0573 5b03          	addw	sp,#3
4860                     ; 998 						UART2_Send_Data_Start();
4862  0575 cd0000        	call	_UART2_Send_Data_Start
4864                     ; 999 						break;
4866  0578 acd406d4      	jpf	L5661
4867  057c               L1161:
4868                     ; 1000 					case 0x2F://呼吸灯模式
4868                     ; 1001 						st1.st_led_mode = 0x2F;
4870  057c 352f00b4      	mov	_st1+60,#47
4871                     ; 1002 						st1.st_led_in		= sicp_buf[8];
4873  0580 55000900bd    	mov	_st1+69,_sicp_buf+8
4874                     ; 1003 						st1.st_led_duration = sicp_buf[9];
4876  0585 55000a00be    	mov	_st1+70,_sicp_buf+9
4877                     ; 1004 						st1.st_led_out	= sicp_buf[10];
4879  058a 55000b00bf    	mov	_st1+71,_sicp_buf+10
4880                     ; 1005 						st1.st_led_blank = sicp_buf[11];
4882  058f 55000c00c0    	mov	_st1+72,_sicp_buf+11
4883                     ; 1006 						st1.st_led_color1_H = sicp_buf[12];
4885  0594 55000d00b7    	mov	_st1+63,_sicp_buf+12
4886                     ; 1007 						st1.st_led_color1_M = sicp_buf[13];
4888  0599 55000e00b8    	mov	_st1+64,_sicp_buf+13
4889                     ; 1008 						st1.st_led_color1_L = sicp_buf[14];
4891  059e 55000f00b9    	mov	_st1+65,_sicp_buf+14
4892                     ; 1009 						st1.st_led_color2_H = sicp_buf[15];
4894  05a3 55001000ba    	mov	_st1+66,_sicp_buf+15
4895                     ; 1010 						st1.st_led_color2_M = sicp_buf[16];
4897  05a8 55001100bb    	mov	_st1+67,_sicp_buf+16
4898                     ; 1011 						st1.st_led_color2_L = sicp_buf[17];
4900  05ad 55001200bc    	mov	_st1+68,_sicp_buf+17
4901                     ; 1012 						send_message_length = 6;
4903  05b2 35060065      	mov	_send_message_length,#6
4904                     ; 1013 						send_cmd = 0xAA;
4906  05b6 35aa0064      	mov	_send_cmd,#170
4907                     ; 1014 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4909  05ba 4baa          	push	#170
4910  05bc 4b06          	push	#6
4911  05be 3b006b        	push	_ns_host_meshid_L
4912  05c1 c6006c        	ld	a,_ns_host_meshid_H
4913  05c4 97            	ld	xl,a
4914  05c5 c6006a        	ld	a,_rev_message_id
4915  05c8 95            	ld	xh,a
4916  05c9 cd0000        	call	_send_header_payload_init
4918  05cc 5b03          	addw	sp,#3
4919                     ; 1016 						UART2_Send_Data_Start();
4921  05ce cd0000        	call	_UART2_Send_Data_Start
4923                     ; 1017 						break;
4925  05d1 acd406d4      	jpf	L5661
4926  05d5               L3161:
4927                     ; 1018 					case 0x3F://颜色变化模式，从一个主颜色渐变黑色再变到另一个主颜色
4927                     ; 1019 						st1.st_led_mode = 0x3F;
4929  05d5 353f00b4      	mov	_st1+60,#63
4930                     ; 1020 						st1.st_led_in		= sicp_buf[8];
4932  05d9 55000900bd    	mov	_st1+69,_sicp_buf+8
4933                     ; 1021 						st1.st_led_duration = sicp_buf[9];
4935  05de 55000a00be    	mov	_st1+70,_sicp_buf+9
4936                     ; 1022 						st1.st_led_color1_H = sicp_buf[10];
4938  05e3 55000b00b7    	mov	_st1+63,_sicp_buf+10
4939                     ; 1023 						st1.st_led_color1_M = sicp_buf[11];
4941  05e8 55000c00b8    	mov	_st1+64,_sicp_buf+11
4942                     ; 1024 						st1.st_led_color1_L = sicp_buf[12];
4944  05ed 55000d00b9    	mov	_st1+65,_sicp_buf+12
4945                     ; 1025 						st1.st_led_color2_H = sicp_buf[13];
4947  05f2 55000e00ba    	mov	_st1+66,_sicp_buf+13
4948                     ; 1026 						st1.st_led_color2_M = sicp_buf[14];
4950  05f7 55000f00bb    	mov	_st1+67,_sicp_buf+14
4951                     ; 1027 						st1.st_led_color2_L = sicp_buf[15];
4953  05fc 55001000bc    	mov	_st1+68,_sicp_buf+15
4954                     ; 1028 						send_message_length = 6;
4956  0601 35060065      	mov	_send_message_length,#6
4957                     ; 1029 						send_cmd = 0xAA;
4959  0605 35aa0064      	mov	_send_cmd,#170
4960                     ; 1030 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4962  0609 4baa          	push	#170
4963  060b 4b06          	push	#6
4964  060d 3b006b        	push	_ns_host_meshid_L
4965  0610 c6006c        	ld	a,_ns_host_meshid_H
4966  0613 97            	ld	xl,a
4967  0614 c6006a        	ld	a,_rev_message_id
4968  0617 95            	ld	xh,a
4969  0618 cd0000        	call	_send_header_payload_init
4971  061b 5b03          	addw	sp,#3
4972                     ; 1032 						UART2_Send_Data_Start();
4974  061d cd0000        	call	_UART2_Send_Data_Start
4976                     ; 1033 						break;
4978  0620 acd406d4      	jpf	L5661
4979  0624               L5161:
4980                     ; 1034 					case 0x4F://指示灯模式，把LED的显示权交给设备
4980                     ; 1035 						st1.st_led_mode = 0x4F;
4982  0624 354f00b4      	mov	_st1+60,#79
4983                     ; 1036 						send_message_length = 6;
4985  0628 35060065      	mov	_send_message_length,#6
4986                     ; 1037 						send_cmd = 0xAA;
4988  062c 35aa0064      	mov	_send_cmd,#170
4989                     ; 1038 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4991  0630 4baa          	push	#170
4992  0632 4b06          	push	#6
4993  0634 3b006b        	push	_ns_host_meshid_L
4994  0637 c6006c        	ld	a,_ns_host_meshid_H
4995  063a 97            	ld	xl,a
4996  063b c6006a        	ld	a,_rev_message_id
4997  063e 95            	ld	xh,a
4998  063f cd0000        	call	_send_header_payload_init
5000  0642 5b03          	addw	sp,#3
5001                     ; 1040 						UART2_Send_Data_Start();
5003  0644 cd0000        	call	_UART2_Send_Data_Start
5005                     ; 1041 						break;
5007  0647 acd406d4      	jpf	L5661
5008  064b               L7161:
5009                     ; 1042 					case 0x5F://关闭模式。关闭所有LED显示 
5009                     ; 1043 						st1.st_led_mode = 0x5F;
5011  064b 355f00b4      	mov	_st1+60,#95
5012                     ; 1044 						send_message_length = 6;
5014  064f 35060065      	mov	_send_message_length,#6
5015                     ; 1045 						send_cmd = 0xAA;
5017  0653 35aa0064      	mov	_send_cmd,#170
5018                     ; 1046 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5020  0657 4baa          	push	#170
5021  0659 4b06          	push	#6
5022  065b 3b006b        	push	_ns_host_meshid_L
5023  065e c6006c        	ld	a,_ns_host_meshid_H
5024  0661 97            	ld	xl,a
5025  0662 c6006a        	ld	a,_rev_message_id
5026  0665 95            	ld	xh,a
5027  0666 cd0000        	call	_send_header_payload_init
5029  0669 5b03          	addw	sp,#3
5030                     ; 1048 						UART2_Send_Data_Start();
5032  066b cd0000        	call	_UART2_Send_Data_Start
5034                     ; 1049 						break;
5036  066e 2064          	jra	L5661
5037  0670               L3771:
5038                     ; 1051 				break;
5040  0670 2062          	jra	L5661
5041  0672               L1261:
5042                     ; 1052 			case 0x05://用于加载预装的报警信息，若此方法激活，则忽略所有 LED方法
5042                     ; 1053 				load_alert_flag = 1;
5044  0672 721600c7      	bset	_UART1Flag4_,#3
5045                     ; 1054 				st1.st_load_alert = sicp_buf[7];
5047  0676 55000800c1    	mov	_st1+73,_sicp_buf+7
5048                     ; 1055 				send_message_length = 6;
5050  067b 35060065      	mov	_send_message_length,#6
5051                     ; 1056 				send_cmd = 0xAA;
5053  067f 35aa0064      	mov	_send_cmd,#170
5054                     ; 1057 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5056  0683 4baa          	push	#170
5057  0685 4b06          	push	#6
5058  0687 3b006b        	push	_ns_host_meshid_L
5059  068a c6006c        	ld	a,_ns_host_meshid_H
5060  068d 97            	ld	xl,a
5061  068e c6006a        	ld	a,_rev_message_id
5062  0691 95            	ld	xh,a
5063  0692 cd0000        	call	_send_header_payload_init
5065  0695 5b03          	addw	sp,#3
5066                     ; 1059 				UART2_Send_Data_Start();
5068  0697 cd0000        	call	_UART2_Send_Data_Start
5070                     ; 1060 				break;
5072  069a 2038          	jra	L5661
5073  069c               L3261:
5074                     ; 1061 			case 0xB0://Gateway	Mesh	ID	Broadcasting
5074                     ; 1062 				if(sicp_buf[2] == 0x9E){
5076  069c c60003        	ld	a,_sicp_buf+2
5077  069f a19e          	cp	a,#158
5078  06a1 2631          	jrne	L5661
5079                     ; 1063 					rev_host_mesh = 1;receipt_host_mesh = 1;
5081  06a3 721c00c9      	bset	_UART1Flag2_,#6
5084  06a7 721400c5      	bset	_UART1Flag6_,#2
5085                     ; 1064 					ns_host_meshid_H = sicp_buf[3];
5087  06ab 550004006c    	mov	_ns_host_meshid_H,_sicp_buf+3
5088                     ; 1065 					ns_host_meshid_L = sicp_buf[4];
5090  06b0 550005006b    	mov	_ns_host_meshid_L,_sicp_buf+4
5091                     ; 1066 					send_message_length = 6;
5093  06b5 35060065      	mov	_send_message_length,#6
5094                     ; 1067 					send_cmd = 0xAA;
5096  06b9 35aa0064      	mov	_send_cmd,#170
5097                     ; 1068 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5099  06bd 4baa          	push	#170
5100  06bf 4b06          	push	#6
5101  06c1 3b006b        	push	_ns_host_meshid_L
5102  06c4 c6006c        	ld	a,_ns_host_meshid_H
5103  06c7 97            	ld	xl,a
5104  06c8 c6006a        	ld	a,_rev_message_id
5105  06cb 95            	ld	xh,a
5106  06cc cd0000        	call	_send_header_payload_init
5108  06cf 5b03          	addw	sp,#3
5109                     ; 1069 					UART2_Send_Data_Start();
5111  06d1 cd0000        	call	_UART2_Send_Data_Start
5113  06d4               L5261:
5114                     ; 1072 			default:
5114                     ; 1073 				break;
5116  06d4               L5661:
5117                     ; 1076 		return TRUE;
5119  06d4 a601          	ld	a,#1
5122  06d6 5b01          	addw	sp,#1
5123  06d8 81            	ret
5124  06d9               L1661:
5125                     ; 1078 	else if (ble_ctrl_frame)
5127  06d9 c600ca        	ld	a,_UART1Flag1_
5128  06dc a540          	bcp	a,#64
5129  06de 2760          	jreq	L1002
5130                     ; 1080 		ble_ctrl_frame = 0;
5132  06e0 721d00ca      	bres	_UART1Flag1_,#6
5133                     ; 1081 		switch(sicp_buf[4])
5135  06e4 c60005        	ld	a,_sicp_buf+4
5137                     ; 1107 				break;
5138  06e7 4a            	dec	a
5139  06e8 2708          	jreq	L7261
5140  06ea 4a            	dec	a
5141  06eb 2724          	jreq	L1361
5142  06ed 4a            	dec	a
5143  06ee 2729          	jreq	L3361
5144  06f0 2049          	jra	L5002
5145  06f2               L7261:
5146                     ; 1083 			case 0x01://网络状态帧
5146                     ; 1084 				rev_bleheartbeat = 1;
5148  06f2 721e00ca      	bset	_UART1Flag1_,#7
5149                     ; 1085 				ns_signal = sicp_buf[5];
5151  06f6 5500060071    	mov	_ns_signal,_sicp_buf+5
5152                     ; 1086 				ns_status = sicp_buf[6];
5154  06fb 5500070070    	mov	_ns_status,_sicp_buf+6
5155                     ; 1087 				ns_phonenum = sicp_buf[7];
5157  0700 550008006f    	mov	_ns_phonenum,_sicp_buf+7
5158                     ; 1088 				ns_own_meshid_H = sicp_buf[8];
5160  0705 550009006e    	mov	_ns_own_meshid_H,_sicp_buf+8
5161                     ; 1089 				ns_own_meshid_L = sicp_buf[9];
5163  070a 55000a006d    	mov	_ns_own_meshid_L,_sicp_buf+9
5164                     ; 1092 				break;
5166  070f 202a          	jra	L5002
5167  0711               L1361:
5168                     ; 1093 			case 0x02://重置芯片，清空串口缓存，保留mesh连接
5168                     ; 1094 				Variable_Init();
5170  0711 cd0000        	call	_Variable_Init
5172                     ; 1095 				clear_sicp_buf();
5174  0714 cd0000        	call	_clear_sicp_buf
5176                     ; 1096 				break;
5178  0717 2022          	jra	L5002
5179  0719               L3361:
5180                     ; 1097 			case 0x03://重置芯片和网络，退出mesh连接
5180                     ; 1098 				Variable_Init();
5182  0719 cd0000        	call	_Variable_Init
5184                     ; 1099 				clear_sicp_buf();
5186  071c cd0000        	call	_clear_sicp_buf
5188                     ; 1100 				ns_signal = 0x00;
5190  071f 725f0071      	clr	_ns_signal
5191                     ; 1101 				ns_status = 0x00;
5193  0723 725f0070      	clr	_ns_status
5194                     ; 1102 				ns_phonenum = 0x00;
5196  0727 725f006f      	clr	_ns_phonenum
5197                     ; 1103 				ns_own_meshid_H = 0x00;
5199  072b 725f006e      	clr	_ns_own_meshid_H
5200                     ; 1104 				ns_own_meshid_L = 0x00;
5202  072f 725f006d      	clr	_ns_own_meshid_L
5203                     ; 1105 				ns_host_meshid_H = 0x80;
5205  0733 3580006c      	mov	_ns_host_meshid_H,#128
5206                     ; 1106 				ns_host_meshid_L = 0xFF;
5208  0737 35ff006b      	mov	_ns_host_meshid_L,#255
5209                     ; 1107 				break;
5211  073b               L5002:
5212                     ; 1138 		return TRUE;
5214  073b a601          	ld	a,#1
5217  073d 5b01          	addw	sp,#1
5218  073f 81            	ret
5219  0740               L1002:
5220                     ; 1142 		return FALSE;
5222  0740 4f            	clr	a
5225  0741 5b01          	addw	sp,#1
5226  0743 81            	ret
5281                     ; 1151 void reve_analyze_reply(void)
5281                     ; 1152 {
5282                     .text:	section	.text,new
5283  0000               _reve_analyze_reply:
5285  0000 89            	pushw	x
5286       00000002      OFST:	set	2
5289                     ; 1153 	if (rev_success)
5291  0001 c600ca        	ld	a,_UART1Flag1_
5292  0004 a501          	bcp	a,#1
5293  0006 271b          	jreq	L1202
5294                     ; 1155 		rev_success = 0;
5296  0008 721100ca      	bres	_UART1Flag1_,#0
5297                     ; 1156 		rev_header_anaylze(&rev_message_id,&rev_meshid_H,&rev_meshid_L,&rev_message_length);
5299  000c ae0068        	ldw	x,#_rev_message_length
5300  000f 89            	pushw	x
5301  0010 ae0066        	ldw	x,#_rev_meshid_L
5302  0013 89            	pushw	x
5303  0014 ae0067        	ldw	x,#_rev_meshid_H
5304  0017 89            	pushw	x
5305  0018 ae006a        	ldw	x,#_rev_message_id
5306  001b cd0000        	call	_rev_header_anaylze
5308  001e 5b06          	addw	sp,#6
5309                     ; 1157 		rev_payload_anaylze();
5311  0020 cd0000        	call	_rev_payload_anaylze
5313  0023               L1202:
5314                     ; 1165 	if (receipt_send_failed)
5316  0023 c600c6        	ld	a,_UART1Flag5_
5317  0026 a520          	bcp	a,#32
5318  0028 273a          	jreq	L3202
5319                     ; 1167 		receipt_send_failed = 0;
5321  002a 721b00c6      	bres	_UART1Flag5_,#5
5322                     ; 1168 		st_pad1_ctrl = st_pad_temp._flag_bit.bit0;
5324                     	btst		_st_pad_temp,#0
5325  0033 901300c8      	bccm	_UART1Flag3_,#1
5326                     ; 1169 		st_pad2_ctrl = st_pad_temp._flag_bit.bit1;
5328                     	btst		_st_pad_temp,#1
5329  003c 901500c8      	bccm	_UART1Flag3_,#2
5330                     ; 1170 		st_pad3_ctrl = st_pad_temp._flag_bit.bit2;
5332                     	btst		_st_pad_temp,#2
5333  0045 901700c8      	bccm	_UART1Flag3_,#3
5334                     ; 1171 		st_pad1_confirm = st_pad_temp._flag_bit.bit3;
5336                     	btst		_st_pad_temp,#3
5337  004e 901900c8      	bccm	_UART1Flag3_,#4
5338                     ; 1172 		st_pad2_confirm = st_pad_temp._flag_bit.bit4;
5340                     	btst		_st_pad_temp,#4
5341  0057 901b00c8      	bccm	_UART1Flag3_,#5
5342                     ; 1173 		st_pad3_confirm = st_pad_temp._flag_bit.bit5;
5344                     	btst		_st_pad_temp,#5
5345  0060 901d00c8      	bccm	_UART1Flag3_,#6
5346  0064               L3202:
5347                     ; 1176 	if (receipt_send_failed)
5349  0064 c600c6        	ld	a,_UART1Flag5_
5350  0067 a520          	bcp	a,#32
5351  0069 270e          	jreq	L5202
5352                     ; 1178 		receipt_send_failed = 0;
5354  006b 721b00c6      	bres	_UART1Flag5_,#5
5355                     ; 1179 		st1.st_ges_H = st1_st_ges_H_temp;
5357  006f 5500c40078    	mov	_st1,_st1_st_ges_H_temp
5358                     ; 1180 		st1.st_ges_L = st1_st_ges_L_temp;
5360  0074 5500c30079    	mov	_st1+1,_st1_st_ges_L_temp
5361  0079               L5202:
5362                     ; 1183 	if (st_pad1_ctrl | st_pad2_ctrl | st_pad3_ctrl)
5364  0079 4f            	clr	a
5365                     	btst	_UART1Flag3_,#3
5366  007f 49            	rlc	a
5367  0080 6b02          	ld	(OFST+0,sp),a
5368  0082 4f            	clr	a
5369                     	btst	_UART1Flag3_,#2
5370  0088 49            	rlc	a
5371  0089 6b01          	ld	(OFST-1,sp),a
5372  008b c600c8        	ld	a,_UART1Flag3_
5373  008e 44            	srl	a
5374  008f a401          	and	a,#1
5375  0091 1a01          	or	a,(OFST-1,sp)
5376  0093 1a02          	or	a,(OFST+0,sp)
5377  0095 2603          	jrne	L071
5378  0097 cc0278        	jp	L7202
5379  009a               L071:
5380                     ; 1186 		if(st_pad1_confirm | st_pad2_confirm | st_pad3_confirm)
5382  009a 4f            	clr	a
5383                     	btst	_UART1Flag3_,#6
5384  00a0 49            	rlc	a
5385  00a1 6b02          	ld	(OFST+0,sp),a
5386  00a3 4f            	clr	a
5387                     	btst	_UART1Flag3_,#5
5388  00a9 49            	rlc	a
5389  00aa 6b01          	ld	(OFST-1,sp),a
5390  00ac 4f            	clr	a
5391                     	btst	_UART1Flag3_,#4
5392  00b2 49            	rlc	a
5393  00b3 1a01          	or	a,(OFST-1,sp)
5394  00b5 1a02          	or	a,(OFST+0,sp)
5395  00b7 2603          	jrne	L271
5396  00b9 cc01f8        	jp	L1302
5397  00bc               L271:
5398                     ; 1188 			st_pad_temp._flag_bit.bit0 = st_pad1_ctrl;
5400                     	btst		_UART1Flag3_,#1
5401  00c1 901100c2      	bccm	_st_pad_temp,#0
5402                     ; 1189 			st_pad_temp._flag_bit.bit1 = st_pad2_ctrl;
5404                     	btst		_UART1Flag3_,#2
5405  00ca 901300c2      	bccm	_st_pad_temp,#1
5406                     ; 1190 			st_pad_temp._flag_bit.bit2 = st_pad3_ctrl;
5408                     	btst		_UART1Flag3_,#3
5409  00d3 901500c2      	bccm	_st_pad_temp,#2
5410                     ; 1191 			st_pad_temp._flag_bit.bit3 = st_pad1_confirm;
5412                     	btst		_UART1Flag3_,#4
5413  00dc 901700c2      	bccm	_st_pad_temp,#3
5414                     ; 1192 			st_pad_temp._flag_bit.bit4 = st_pad2_confirm;
5416                     	btst		_UART1Flag3_,#5
5417  00e5 901900c2      	bccm	_st_pad_temp,#4
5418                     ; 1193 			st_pad_temp._flag_bit.bit5 = st_pad3_confirm;
5420                     	btst		_UART1Flag3_,#6
5421  00ee 901b00c2      	bccm	_st_pad_temp,#5
5422                     ; 1195 				generate_messageid = random(TIM4->CNTR);
5424  00f2 c65344        	ld	a,21316
5425  00f5 cd0000        	call	_random
5427  00f8 c70061        	ld	_generate_messageid,a
5428                     ; 1196 				pad_set_message_id = generate_messageid;
5430  00fb 5500610073    	mov	_pad_set_message_id,_generate_messageid
5431                     ; 1197 				send_message_length = 8;
5433  0100 35080065      	mov	_send_message_length,#8
5434                     ; 1199 				if (st_pad1_confirm)//预设置按键1被触发
5436  0104 c600c8        	ld	a,_UART1Flag3_
5437  0107 a510          	bcp	a,#16
5438  0109 2720          	jreq	L3302
5439                     ; 1201 					send_cmd = st1.st_pad1_ctrl_action;
5441  010b 5500880064    	mov	_send_cmd,_st1+16
5442                     ; 1202 					st_pad1_ctrl = 0;
5444  0110 721300c8      	bres	_UART1Flag3_,#1
5445                     ; 1203 					send_header_payload_init(pad_set_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
5447  0114 3b0064        	push	_send_cmd
5448  0117 4b08          	push	#8
5449  0119 3b0086        	push	_st1+14
5450  011c c60085        	ld	a,_st1+13
5451  011f 97            	ld	xl,a
5452  0120 c60073        	ld	a,_pad_set_message_id
5453  0123 95            	ld	xh,a
5454  0124 cd0000        	call	_send_header_payload_init
5456  0127 5b03          	addw	sp,#3
5458  0129 204c          	jra	L5302
5459  012b               L3302:
5460                     ; 1205 				else if (st_pad2_confirm)
5462  012b c600c8        	ld	a,_UART1Flag3_
5463  012e a520          	bcp	a,#32
5464  0130 2720          	jreq	L7302
5465                     ; 1207 					send_cmd = st1.st_pad2_ctrl_action;
5467  0132 55008d0064    	mov	_send_cmd,_st1+21
5468                     ; 1208 					st_pad2_ctrl = 0;
5470  0137 721500c8      	bres	_UART1Flag3_,#2
5471                     ; 1209 					send_header_payload_init(pad_set_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
5473  013b 3b0064        	push	_send_cmd
5474  013e 4b08          	push	#8
5475  0140 3b008b        	push	_st1+19
5476  0143 c6008a        	ld	a,_st1+18
5477  0146 97            	ld	xl,a
5478  0147 c60073        	ld	a,_pad_set_message_id
5479  014a 95            	ld	xh,a
5480  014b cd0000        	call	_send_header_payload_init
5482  014e 5b03          	addw	sp,#3
5484  0150 2025          	jra	L5302
5485  0152               L7302:
5486                     ; 1211 				else if (st_pad3_confirm)
5488  0152 c600c8        	ld	a,_UART1Flag3_
5489  0155 a540          	bcp	a,#64
5490  0157 271e          	jreq	L5302
5491                     ; 1213 					send_cmd = st1.st_pad3_ctrl_action;
5493  0159 5500920064    	mov	_send_cmd,_st1+26
5494                     ; 1214 					st_pad3_ctrl = 0;
5496  015e 721700c8      	bres	_UART1Flag3_,#3
5497                     ; 1215 					send_header_payload_init(pad_set_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
5499  0162 3b0064        	push	_send_cmd
5500  0165 4b08          	push	#8
5501  0167 3b0090        	push	_st1+24
5502  016a c6008f        	ld	a,_st1+23
5503  016d 97            	ld	xl,a
5504  016e c60073        	ld	a,_pad_set_message_id
5505  0171 95            	ld	xh,a
5506  0172 cd0000        	call	_send_header_payload_init
5508  0175 5b03          	addw	sp,#3
5509  0177               L5302:
5510                     ; 1218 				UART2_Send_Data_Start();
5512  0177 cd0000        	call	_UART2_Send_Data_Start
5514                     ; 1219 				delay(300);
5516  017a ae012c        	ldw	x,#300
5517  017d cd0000        	call	_delay
5519                     ; 1222 				clear_send_buf();
5521  0180 cd0000        	call	_clear_send_buf
5523                     ; 1223 				send_message_length = 14;
5525  0183 350e0065      	mov	_send_message_length,#14
5526                     ; 1224 				send_cmd = 0x08;
5528  0187 35080064      	mov	_send_cmd,#8
5529                     ; 1225 				if (st_pad1_confirm)//预设置按键1被触发
5531  018b c600c8        	ld	a,_UART1Flag3_
5532  018e a510          	bcp	a,#16
5533  0190 271a          	jreq	L5402
5534                     ; 1227 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5536  0192 4b08          	push	#8
5537  0194 4b0e          	push	#14
5538  0196 3b006b        	push	_ns_host_meshid_L
5539  0199 c6006c        	ld	a,_ns_host_meshid_H
5540  019c 97            	ld	xl,a
5541  019d c60073        	ld	a,_pad_set_message_id
5542  01a0 95            	ld	xh,a
5543  01a1 cd0000        	call	_send_header_payload_init
5545  01a4 5b03          	addw	sp,#3
5546                     ; 1228 					st_pad1_confirm = 0;
5548  01a6 721900c8      	bres	_UART1Flag3_,#4
5550  01aa 2040          	jra	L7402
5551  01ac               L5402:
5552                     ; 1230 				else if (st_pad2_confirm)
5554  01ac c600c8        	ld	a,_UART1Flag3_
5555  01af a520          	bcp	a,#32
5556  01b1 271a          	jreq	L1502
5557                     ; 1233 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5559  01b3 4b08          	push	#8
5560  01b5 4b0e          	push	#14
5561  01b7 3b006b        	push	_ns_host_meshid_L
5562  01ba c6006c        	ld	a,_ns_host_meshid_H
5563  01bd 97            	ld	xl,a
5564  01be c60073        	ld	a,_pad_set_message_id
5565  01c1 95            	ld	xh,a
5566  01c2 cd0000        	call	_send_header_payload_init
5568  01c5 5b03          	addw	sp,#3
5569                     ; 1234 					st_pad2_confirm = 0;
5571  01c7 721b00c8      	bres	_UART1Flag3_,#5
5573  01cb 201f          	jra	L7402
5574  01cd               L1502:
5575                     ; 1236 				else if(st_pad3_confirm)
5577  01cd c600c8        	ld	a,_UART1Flag3_
5578  01d0 a540          	bcp	a,#64
5579  01d2 2718          	jreq	L7402
5580                     ; 1239 					send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5582  01d4 4b08          	push	#8
5583  01d6 4b0e          	push	#14
5584  01d8 3b006b        	push	_ns_host_meshid_L
5585  01db c6006c        	ld	a,_ns_host_meshid_H
5586  01de 97            	ld	xl,a
5587  01df c60073        	ld	a,_pad_set_message_id
5588  01e2 95            	ld	xh,a
5589  01e3 cd0000        	call	_send_header_payload_init
5591  01e6 5b03          	addw	sp,#3
5592                     ; 1240 					st_pad2_confirm = 0;
5594  01e8 721b00c8      	bres	_UART1Flag3_,#5
5595  01ec               L7402:
5596                     ; 1242 				UART2_Send_Data_Start();
5598  01ec cd0000        	call	_UART2_Send_Data_Start
5600                     ; 1243 				delay(10);
5602  01ef ae000a        	ldw	x,#10
5603  01f2 cd0000        	call	_delay
5606  01f5 cc0278        	jra	L7202
5607  01f8               L1302:
5608                     ; 1247 			generate_messageid = random(TIM4->CNTR);
5610  01f8 c65344        	ld	a,21316
5611  01fb cd0000        	call	_random
5613  01fe c70061        	ld	_generate_messageid,a
5614                     ; 1248 			pad_noset_message_id = generate_messageid;
5616  0201 5500610074    	mov	_pad_noset_message_id,_generate_messageid
5617                     ; 1249 			send_message_length = 7;
5619  0206 35070065      	mov	_send_message_length,#7
5620                     ; 1250 			send_cmd = 0x35;
5622  020a 35350064      	mov	_send_cmd,#53
5623                     ; 1251 			if (st_pad1_ctrl)
5625  020e c600c8        	ld	a,_UART1Flag3_
5626  0211 a502          	bcp	a,#2
5627  0213 271a          	jreq	L1602
5628                     ; 1253 				st_pad1_ctrl = 0;
5630  0215 721300c8      	bres	_UART1Flag3_,#1
5631                     ; 1254 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5633  0219 4b35          	push	#53
5634  021b 4b07          	push	#7
5635  021d 3b006b        	push	_ns_host_meshid_L
5636  0220 c6006c        	ld	a,_ns_host_meshid_H
5637  0223 97            	ld	xl,a
5638  0224 c60074        	ld	a,_pad_noset_message_id
5639  0227 95            	ld	xh,a
5640  0228 cd0000        	call	_send_header_payload_init
5642  022b 5b03          	addw	sp,#3
5644  022d 2040          	jra	L3602
5645  022f               L1602:
5646                     ; 1256 			else if (st_pad2_ctrl)
5648  022f c600c8        	ld	a,_UART1Flag3_
5649  0232 a504          	bcp	a,#4
5650  0234 271a          	jreq	L5602
5651                     ; 1258 				st_pad2_ctrl = 0;
5653  0236 721500c8      	bres	_UART1Flag3_,#2
5654                     ; 1259 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5656  023a 4b35          	push	#53
5657  023c 4b07          	push	#7
5658  023e 3b006b        	push	_ns_host_meshid_L
5659  0241 c6006c        	ld	a,_ns_host_meshid_H
5660  0244 97            	ld	xl,a
5661  0245 c60074        	ld	a,_pad_noset_message_id
5662  0248 95            	ld	xh,a
5663  0249 cd0000        	call	_send_header_payload_init
5665  024c 5b03          	addw	sp,#3
5667  024e 201f          	jra	L3602
5668  0250               L5602:
5669                     ; 1261 			else if (st_pad3_ctrl)
5671  0250 c600c8        	ld	a,_UART1Flag3_
5672  0253 a508          	bcp	a,#8
5673  0255 2718          	jreq	L3602
5674                     ; 1263 				st_pad3_ctrl = 0;
5676  0257 721700c8      	bres	_UART1Flag3_,#3
5677                     ; 1264 				send_header_payload_init(gesture_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5679  025b 4b35          	push	#53
5680  025d 4b07          	push	#7
5681  025f 3b006b        	push	_ns_host_meshid_L
5682  0262 c6006c        	ld	a,_ns_host_meshid_H
5683  0265 97            	ld	xl,a
5684  0266 c60076        	ld	a,_gesture_noset_message_id
5685  0269 95            	ld	xh,a
5686  026a cd0000        	call	_send_header_payload_init
5688  026d 5b03          	addw	sp,#3
5689  026f               L3602:
5690                     ; 1266 			UART2_Send_Data_Start();
5692  026f cd0000        	call	_UART2_Send_Data_Start
5694                     ; 1267 			delay(10);
5696  0272 ae000a        	ldw	x,#10
5697  0275 cd0000        	call	_delay
5699  0278               L7202:
5700                     ; 1274 	if(gest_detect){
5702  0278 c600c9        	ld	a,_UART1Flag2_
5703  027b a501          	bcp	a,#1
5704  027d 2603          	jrne	L471
5705  027f cc043b        	jp	L3702
5706  0282               L471:
5707                     ; 1275 		gest_detect = 0;
5709  0282 721100c9      	bres	_UART1Flag2_,#0
5710                     ; 1276 		gest_confirm();
5712  0286 cd0000        	call	_gest_confirm
5714                     ; 1277 		if ((st1.st_ges_H != 0x00) && (st1.st_ges_L != 0x00))
5716  0289 725d0078      	tnz	_st1
5717  028d 2603          	jrne	L671
5718  028f cc043b        	jp	L3702
5719  0292               L671:
5721  0292 725d0079      	tnz	_st1+1
5722  0296 2603          	jrne	L002
5723  0298 cc043b        	jp	L3702
5724  029b               L002:
5725                     ; 1279 			st1_st_ges_H_temp = st1.st_ges_H;
5727  029b 55007800c4    	mov	_st1_st_ges_H_temp,_st1
5728                     ; 1280 			st1_st_ges_L_temp = st1.st_ges_L;
5730  02a0 55007900c3    	mov	_st1_st_ges_L_temp,_st1+1
5731                     ; 1283 			if((!gest1_confirm) && (!gest2_confirm) && (!gest3_confirm) && (!gest4_confirm))
5733  02a5 c600c9        	ld	a,_UART1Flag2_
5734  02a8 a504          	bcp	a,#4
5735  02aa 2658          	jrne	L7702
5737  02ac c600c9        	ld	a,_UART1Flag2_
5738  02af a508          	bcp	a,#8
5739  02b1 2651          	jrne	L7702
5741  02b3 c600c9        	ld	a,_UART1Flag2_
5742  02b6 a510          	bcp	a,#16
5743  02b8 264a          	jrne	L7702
5745  02ba c600c9        	ld	a,_UART1Flag2_
5746  02bd a520          	bcp	a,#32
5747  02bf 2643          	jrne	L7702
5748                     ; 1285 				receipt_gesture1 = 0;//清除接收到该指令回执
5750  02c1 721500c6      	bres	_UART1Flag5_,#2
5751                     ; 1286 				generate_messageid = random(TIM4->CNTR);
5753  02c5 c65344        	ld	a,21316
5754  02c8 cd0000        	call	_random
5756  02cb c70061        	ld	_generate_messageid,a
5757                     ; 1287 				gesture_noset_message_id = generate_messageid;
5759  02ce 5500610076    	mov	_gesture_noset_message_id,_generate_messageid
5760                     ; 1289 				send_message_length = 8;
5762  02d3 35080065      	mov	_send_message_length,#8
5763                     ; 1290 				send_cmd = 0x29;
5765  02d7 35290064      	mov	_send_cmd,#41
5766                     ; 1291 				send_header_payload_init(gesture_noset_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5768  02db 4b29          	push	#41
5769  02dd 4b08          	push	#8
5770  02df 3b006d        	push	_ns_own_meshid_L
5771  02e2 c6006e        	ld	a,_ns_own_meshid_H
5772  02e5 97            	ld	xl,a
5773  02e6 c60076        	ld	a,_gesture_noset_message_id
5774  02e9 95            	ld	xh,a
5775  02ea cd0000        	call	_send_header_payload_init
5777  02ed 5b03          	addw	sp,#3
5778                     ; 1293 				UART2_Send_Data_Start();
5780  02ef cd0000        	call	_UART2_Send_Data_Start
5782                     ; 1294 				delay(10);
5784  02f2 ae000a        	ldw	x,#10
5785  02f5 cd0000        	call	_delay
5787                     ; 1295 				st1.st_ges_H = 0x00;
5789  02f8 725f0078      	clr	_st1
5790                     ; 1296 				st1.st_ges_L = 0x00;
5792  02fc 725f0079      	clr	_st1+1
5794  0300 ac3b043b      	jpf	L3702
5795  0304               L7702:
5796                     ; 1300 				receipt_gesture2 = 0;//清除接收到该指令回执
5798  0304 721700c6      	bres	_UART1Flag5_,#3
5799                     ; 1301 				generate_messageid = random(TIM4->CNTR);
5801  0308 c65344        	ld	a,21316
5802  030b cd0000        	call	_random
5804  030e c70061        	ld	_generate_messageid,a
5805                     ; 1302 				gesture_set_message_id = generate_messageid;
5807  0311 5500610075    	mov	_gesture_set_message_id,_generate_messageid
5808                     ; 1303 				send_message_length = 8;
5810  0316 35080065      	mov	_send_message_length,#8
5811                     ; 1305 				if (gest1_confirm)
5813  031a c600c9        	ld	a,_UART1Flag2_
5814  031d a504          	bcp	a,#4
5815  031f 271c          	jreq	L3012
5816                     ; 1307 					send_cmd = st1.st_ges1_ctrl_action_value;
5818  0321 5500a90064    	mov	_send_cmd,_st1+49
5819                     ; 1308 					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
5821  0326 3b0064        	push	_send_cmd
5822  0329 4b08          	push	#8
5823  032b 3b0097        	push	_st1+31
5824  032e c60096        	ld	a,_st1+30
5825  0331 97            	ld	xl,a
5826  0332 c60075        	ld	a,_gesture_set_message_id
5827  0335 95            	ld	xh,a
5828  0336 cd0000        	call	_send_header_payload_init
5830  0339 5b03          	addw	sp,#3
5832  033b 2067          	jra	L5012
5833  033d               L3012:
5834                     ; 1310 				else if (gest2_confirm)
5836  033d c600c9        	ld	a,_UART1Flag2_
5837  0340 a508          	bcp	a,#8
5838  0342 271c          	jreq	L7012
5839                     ; 1312 					send_cmd = st1.st_ges2_ctrl_action_value;
5841  0344 5500ac0064    	mov	_send_cmd,_st1+52
5842                     ; 1313 					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
5844  0349 3b0064        	push	_send_cmd
5845  034c 4b08          	push	#8
5846  034e 3b009c        	push	_st1+36
5847  0351 c6009b        	ld	a,_st1+35
5848  0354 97            	ld	xl,a
5849  0355 c60061        	ld	a,_generate_messageid
5850  0358 95            	ld	xh,a
5851  0359 cd0000        	call	_send_header_payload_init
5853  035c 5b03          	addw	sp,#3
5855  035e 2044          	jra	L5012
5856  0360               L7012:
5857                     ; 1315 				else if (gest3_confirm)
5859  0360 c600c9        	ld	a,_UART1Flag2_
5860  0363 a510          	bcp	a,#16
5861  0365 271c          	jreq	L3112
5862                     ; 1317 					send_cmd = st1.st_ges3_ctrl_action_value;
5864  0367 5500af0064    	mov	_send_cmd,_st1+55
5865                     ; 1318 					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
5867  036c 3b0064        	push	_send_cmd
5868  036f 4b08          	push	#8
5869  0371 3b00a1        	push	_st1+41
5870  0374 c600a0        	ld	a,_st1+40
5871  0377 97            	ld	xl,a
5872  0378 c60061        	ld	a,_generate_messageid
5873  037b 95            	ld	xh,a
5874  037c cd0000        	call	_send_header_payload_init
5876  037f 5b03          	addw	sp,#3
5878  0381 2021          	jra	L5012
5879  0383               L3112:
5880                     ; 1320 				else if (gest4_confirm)
5882  0383 c600c9        	ld	a,_UART1Flag2_
5883  0386 a520          	bcp	a,#32
5884  0388 271a          	jreq	L5012
5885                     ; 1322 					send_cmd = st1.st_ges4_ctrl_action_value;
5887  038a 5500b20064    	mov	_send_cmd,_st1+58
5888                     ; 1323 					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
5890  038f 3b0064        	push	_send_cmd
5891  0392 4b08          	push	#8
5892  0394 3b00a6        	push	_st1+46
5893  0397 c600a5        	ld	a,_st1+45
5894  039a 97            	ld	xl,a
5895  039b c60061        	ld	a,_generate_messageid
5896  039e 95            	ld	xh,a
5897  039f cd0000        	call	_send_header_payload_init
5899  03a2 5b03          	addw	sp,#3
5900  03a4               L5012:
5901                     ; 1326 				UART2_Send_Data_Start();
5903  03a4 cd0000        	call	_UART2_Send_Data_Start
5905                     ; 1328 				delay(300);
5907  03a7 ae012c        	ldw	x,#300
5908  03aa cd0000        	call	_delay
5910                     ; 1329 				clear_send_buf();
5912  03ad cd0000        	call	_clear_send_buf
5914                     ; 1330 				send_message_length = 14;
5916  03b0 350e0065      	mov	_send_message_length,#14
5917                     ; 1331 				send_cmd = 0x08;
5919  03b4 35080064      	mov	_send_cmd,#8
5920                     ; 1332 				if (gest1_confirm)
5922  03b8 c600c9        	ld	a,_UART1Flag2_
5923  03bb a504          	bcp	a,#4
5924  03bd 2716          	jreq	L1212
5925                     ; 1334 					send_header_payload_init(gesture_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5927  03bf 4b08          	push	#8
5928  03c1 4b0e          	push	#14
5929  03c3 3b006b        	push	_ns_host_meshid_L
5930  03c6 c6006c        	ld	a,_ns_host_meshid_H
5931  03c9 97            	ld	xl,a
5932  03ca c60075        	ld	a,_gesture_set_message_id
5933  03cd 95            	ld	xh,a
5934  03ce cd0000        	call	_send_header_payload_init
5936  03d1 5b03          	addw	sp,#3
5938  03d3 2055          	jra	L3212
5939  03d5               L1212:
5940                     ; 1336 				else if (gest2_confirm)
5942  03d5 c600c9        	ld	a,_UART1Flag2_
5943  03d8 a508          	bcp	a,#8
5944  03da 2716          	jreq	L5212
5945                     ; 1338 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5947  03dc 4b08          	push	#8
5948  03de 4b0e          	push	#14
5949  03e0 3b006b        	push	_ns_host_meshid_L
5950  03e3 c6006c        	ld	a,_ns_host_meshid_H
5951  03e6 97            	ld	xl,a
5952  03e7 c60061        	ld	a,_generate_messageid
5953  03ea 95            	ld	xh,a
5954  03eb cd0000        	call	_send_header_payload_init
5956  03ee 5b03          	addw	sp,#3
5958  03f0 2038          	jra	L3212
5959  03f2               L5212:
5960                     ; 1340 				else if (gest3_confirm)
5962  03f2 c600c9        	ld	a,_UART1Flag2_
5963  03f5 a510          	bcp	a,#16
5964  03f7 2716          	jreq	L1312
5965                     ; 1342 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5967  03f9 4b08          	push	#8
5968  03fb 4b0e          	push	#14
5969  03fd 3b006b        	push	_ns_host_meshid_L
5970  0400 c6006c        	ld	a,_ns_host_meshid_H
5971  0403 97            	ld	xl,a
5972  0404 c60061        	ld	a,_generate_messageid
5973  0407 95            	ld	xh,a
5974  0408 cd0000        	call	_send_header_payload_init
5976  040b 5b03          	addw	sp,#3
5978  040d 201b          	jra	L3212
5979  040f               L1312:
5980                     ; 1344 				else if (gest4_confirm)
5982  040f c600c9        	ld	a,_UART1Flag2_
5983  0412 a520          	bcp	a,#32
5984  0414 2714          	jreq	L3212
5985                     ; 1346 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5987  0416 4b08          	push	#8
5988  0418 4b0e          	push	#14
5989  041a 3b006b        	push	_ns_host_meshid_L
5990  041d c6006c        	ld	a,_ns_host_meshid_H
5991  0420 97            	ld	xl,a
5992  0421 c60061        	ld	a,_generate_messageid
5993  0424 95            	ld	xh,a
5994  0425 cd0000        	call	_send_header_payload_init
5996  0428 5b03          	addw	sp,#3
5997  042a               L3212:
5998                     ; 1349 				UART2_Send_Data_Start();
6000  042a cd0000        	call	_UART2_Send_Data_Start
6002                     ; 1350 				delay(10);
6004  042d ae000a        	ldw	x,#10
6005  0430 cd0000        	call	_delay
6007                     ; 1351 				st1.st_ges_H = 0x00;
6009  0433 725f0078      	clr	_st1
6010                     ; 1352 				st1.st_ges_L = 0x00;
6012  0437 725f0079      	clr	_st1+1
6013  043b               L3702:
6014                     ; 1359 	if ((st1.st_device_status & 0xFF) < 0xFF)//ST有故障,有0无1
6016  043b 9c            	rvf
6017  043c c6007a        	ld	a,_st1+2
6018  043f 5f            	clrw	x
6019  0440 97            	ld	xl,a
6020  0441 a300ff        	cpw	x,#255
6021  0444 2e3d          	jrsge	L7312
6022                     ; 1361 		send_fault_count++;
6024  0446 ce005d        	ldw	x,_send_fault_count
6025  0449 1c0001        	addw	x,#1
6026  044c cf005d        	ldw	_send_fault_count,x
6027                     ; 1362 		if (send_fault_count >= 500)
6029  044f ce005d        	ldw	x,_send_fault_count
6030  0452 a301f4        	cpw	x,#500
6031  0455 252c          	jrult	L7312
6032                     ; 1364 			send_fault_count = 0;
6034  0457 5f            	clrw	x
6035  0458 cf005d        	ldw	_send_fault_count,x
6036                     ; 1365 			generate_messageid = random(TIM4->CNTR);
6038  045b c65344        	ld	a,21316
6039  045e cd0000        	call	_random
6041  0461 c70061        	ld	_generate_messageid,a
6042                     ; 1366 			send_message_length = 7;
6044  0464 35070065      	mov	_send_message_length,#7
6045                     ; 1367 			send_cmd = 0x0A;
6047  0468 350a0064      	mov	_send_cmd,#10
6048                     ; 1368 			send_header_payload_init(generate_messageid,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
6050  046c 4b0a          	push	#10
6051  046e 4b07          	push	#7
6052  0470 3b006d        	push	_ns_own_meshid_L
6053  0473 c6006e        	ld	a,_ns_own_meshid_H
6054  0476 97            	ld	xl,a
6055  0477 c60061        	ld	a,_generate_messageid
6056  047a 95            	ld	xh,a
6057  047b cd0000        	call	_send_header_payload_init
6059  047e 5b03          	addw	sp,#3
6060                     ; 1370 			UART2_Send_Data_Start();
6062  0480 cd0000        	call	_UART2_Send_Data_Start
6064  0483               L7312:
6065                     ; 1373 }
6068  0483 85            	popw	x
6069  0484 81            	ret
6082                     	xref	_memcpy
6083                     	xref	_UART2_ITConfig
6084                     	xref	_UART2_Cmd
6085                     	xref	_UART2_Init
6086                     	xref	_UART2_DeInit
6087                     	xref	_rand
6088                     	xref	_malloc
6089                     	xref	_free
6090                     	xdef	_gest_confirm
6091                     	xdef	_pad_confirm
6092                     	xdef	_rev_payload_anaylze
6093                     	xdef	_rev_header_anaylze
6094                     	xdef	_send_header_payload_init
6095                     	xdef	_reve_analyze_reply
6096                     	xdef	_random
6097                     	xdef	_rev_deal
6098                     	xdef	_Check_Sum
6099                     	xdef	_clear_send_buf
6100                     	xdef	_clear_sicp_buf
6101                     	xdef	_UART2_Send_Data_Start
6102                     	xdef	_UART2_Send_Data_Init
6103                     	xdef	_UART2_RX_ISR
6104                     	xdef	_UART2_TX_ISR
6105                     	xdef	_Init_uart2
6106                     	xdef	_deleteNodeFromUart2TxSLHead
6107                     	xdef	_addNodeToUart2TxSLLast
6108                     	switch	.bss
6109  0000               _action_ctrl_address:
6110  0000 00            	ds.b	1
6111                     	xdef	_action_ctrl_address
6112  0001               _sicp_buf:
6113  0001 000000000000  	ds.b	30
6114                     	xdef	_sicp_buf
6115  001f               _rev_buf:
6116  001f 000000000000  	ds.b	30
6117                     	xdef	_rev_buf
6118  003d               _send_buf:
6119  003d 000000000000  	ds.b	30
6120                     	xdef	_send_buf
6121  005b               _send_failed_count:
6122  005b 0000          	ds.b	2
6123                     	xdef	_send_failed_count
6124  005d               _send_fault_count:
6125  005d 0000          	ds.b	2
6126                     	xdef	_send_fault_count
6127  005f               _rev_count:
6128  005f 00            	ds.b	1
6129                     	xdef	_rev_count
6130  0060               _send_count:
6131  0060 00            	ds.b	1
6132                     	xdef	_send_count
6133  0061               _generate_messageid:
6134  0061 00            	ds.b	1
6135                     	xdef	_generate_messageid
6136  0062               _send_meshid_L:
6137  0062 00            	ds.b	1
6138                     	xdef	_send_meshid_L
6139  0063               _send_meshid_H:
6140  0063 00            	ds.b	1
6141                     	xdef	_send_meshid_H
6142  0064               _send_cmd:
6143  0064 00            	ds.b	1
6144                     	xdef	_send_cmd
6145  0065               _send_message_length:
6146  0065 00            	ds.b	1
6147                     	xdef	_send_message_length
6148  0066               _rev_meshid_L:
6149  0066 00            	ds.b	1
6150                     	xdef	_rev_meshid_L
6151  0067               _rev_meshid_H:
6152  0067 00            	ds.b	1
6153                     	xdef	_rev_meshid_H
6154  0068               _rev_message_length:
6155  0068 00            	ds.b	1
6156                     	xdef	_rev_message_length
6157  0069               _rev_module_id:
6158  0069 00            	ds.b	1
6159                     	xdef	_rev_module_id
6160  006a               _rev_message_id:
6161  006a 00            	ds.b	1
6162                     	xdef	_rev_message_id
6163  006b               _ns_host_meshid_L:
6164  006b 00            	ds.b	1
6165                     	xdef	_ns_host_meshid_L
6166  006c               _ns_host_meshid_H:
6167  006c 00            	ds.b	1
6168                     	xdef	_ns_host_meshid_H
6169  006d               _ns_own_meshid_L:
6170  006d 00            	ds.b	1
6171                     	xdef	_ns_own_meshid_L
6172  006e               _ns_own_meshid_H:
6173  006e 00            	ds.b	1
6174                     	xdef	_ns_own_meshid_H
6175  006f               _ns_phonenum:
6176  006f 00            	ds.b	1
6177                     	xdef	_ns_phonenum
6178  0070               _ns_status:
6179  0070 00            	ds.b	1
6180                     	xdef	_ns_status
6181  0071               _ns_signal:
6182  0071 00            	ds.b	1
6183                     	xdef	_ns_signal
6184  0072               _action_notify_message_id:
6185  0072 00            	ds.b	1
6186                     	xdef	_action_notify_message_id
6187  0073               _pad_set_message_id:
6188  0073 00            	ds.b	1
6189                     	xdef	_pad_set_message_id
6190  0074               _pad_noset_message_id:
6191  0074 00            	ds.b	1
6192                     	xdef	_pad_noset_message_id
6193  0075               _gesture_set_message_id:
6194  0075 00            	ds.b	1
6195                     	xdef	_gesture_set_message_id
6196  0076               _gesture_noset_message_id:
6197  0076 00            	ds.b	1
6198                     	xdef	_gesture_noset_message_id
6199  0077               _device_info_message_id:
6200  0077 00            	ds.b	1
6201                     	xdef	_device_info_message_id
6202  0078               _st1:
6203  0078 000000000000  	ds.b	74
6204                     	xdef	_st1
6205  00c2               _st_pad_temp:
6206  00c2 00            	ds.b	1
6207                     	xdef	_st_pad_temp
6208  00c3               _st1_st_ges_L_temp:
6209  00c3 00            	ds.b	1
6210                     	xdef	_st1_st_ges_L_temp
6211  00c4               _st1_st_ges_H_temp:
6212  00c4 00            	ds.b	1
6213                     	xdef	_st1_st_ges_H_temp
6214  00c5               _UART1Flag6_:
6215  00c5 00            	ds.b	1
6216                     	xdef	_UART1Flag6_
6217  00c6               _UART1Flag5_:
6218  00c6 00            	ds.b	1
6219                     	xdef	_UART1Flag5_
6220  00c7               _UART1Flag4_:
6221  00c7 00            	ds.b	1
6222                     	xdef	_UART1Flag4_
6223  00c8               _UART1Flag3_:
6224  00c8 00            	ds.b	1
6225                     	xdef	_UART1Flag3_
6226  00c9               _UART1Flag2_:
6227  00c9 00            	ds.b	1
6228                     	xdef	_UART1Flag2_
6229  00ca               _UART1Flag1_:
6230  00ca 00            	ds.b	1
6231                     	xdef	_UART1Flag1_
6232  00cb               _uart2TxSLLast:
6233  00cb 0000          	ds.b	2
6234                     	xdef	_uart2TxSLLast
6235  00cd               _uart2TxSLHead:
6236  00cd 0000          	ds.b	2
6237                     	xdef	_uart2TxSLHead
6238  00cf               _mutex2:
6239  00cf 00            	ds.b	1
6240                     	xdef	_mutex2
6241                     	xref	_Variable_Init
6242                     	xref	_delay
6243                     	xref.b	c_x
6244                     	xref.b	c_y
6264                     	xref	c_idiv
6265                     	end
