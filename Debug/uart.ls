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
2760                     ; 414 void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len ,u8 cmd)
2760                     ; 415 {
2761                     .text:	section	.text,new
2762  0000               _send_header_payload_init:
2764  0000 89            	pushw	x
2765       00000000      OFST:	set	0
2768                     ; 416 	send_buf[0] = 0xEE;
2770  0001 35ee003d      	mov	_send_buf,#238
2771                     ; 417 	send_buf[1] = 0xEE;
2773  0005 35ee003e      	mov	_send_buf+1,#238
2774                     ; 418 	send_buf[2] = id;
2776  0009 9e            	ld	a,xh
2777  000a c7003f        	ld	_send_buf+2,a
2778                     ; 419 	send_buf[3] = mesh_id_H;
2780  000d 9f            	ld	a,xl
2781  000e c70040        	ld	_send_buf+3,a
2782                     ; 420 	send_buf[4] = mesh_id_L;
2784  0011 7b05          	ld	a,(OFST+5,sp)
2785  0013 c70041        	ld	_send_buf+4,a
2786                     ; 421 	send_buf[5] = len;
2788  0016 7b06          	ld	a,(OFST+6,sp)
2789  0018 c70042        	ld	_send_buf+5,a
2790                     ; 423 	switch(cmd)
2792  001b 7b07          	ld	a,(OFST+7,sp)
2794                     ; 700 			break;
2795  001d a006          	sub	a,#6
2796  001f 2761          	jreq	L3621
2797  0021 a002          	sub	a,#2
2798  0023 2603          	jrne	L66
2799  0025 cc037a        	jp	L1031
2800  0028               L66:
2801  0028 a002          	sub	a,#2
2802  002a 2603          	jrne	L07
2803  002c cc0294        	jp	L5721
2804  002f               L07:
2805  002f a016          	sub	a,#22
2806  0031 272e          	jreq	L1621
2807  0033 a009          	sub	a,#9
2808  0035 2603          	jrne	L27
2809  0037 cc00de        	jp	L5621
2810  003a               L27:
2811  003a a00c          	sub	a,#12
2812  003c 2603          	jrne	L47
2813  003e cc00f5        	jp	L7621
2814  0041               L47:
2815  0041 a01c          	sub	a,#28
2816  0043 2603          	jrne	L67
2817  0045 cc02a6        	jp	L7721
2818  0048               L67:
2819  0048 a004          	sub	a,#4
2820  004a 2603          	jrne	L001
2821  004c cc02a6        	jp	L7721
2822  004f               L001:
2823  004f a055          	sub	a,#85
2824  0051 2603          	jrne	L201
2825  0053 cc014e        	jp	L1721
2826  0056               L201:
2827  0056 a00a          	sub	a,#10
2828  0058 2603          	jrne	L401
2829  005a cc026e        	jp	L3721
2830  005d               L401:
2831  005d acf104f1      	jpf	L1331
2832  0061               L1621:
2833                     ; 425 		case 0x20://回复环境光和环境颜色
2833                     ; 426 			send_buf[1] = 0xAA;
2835  0061 35aa003e      	mov	_send_buf+1,#170
2836                     ; 427 			send_buf[6] = cmd;
2838  0065 7b07          	ld	a,(OFST+7,sp)
2839  0067 c70043        	ld	_send_buf+6,a
2840                     ; 428 			send_buf[7] = st1.st_ambient_light;
2842  006a 5500810044    	mov	_send_buf+7,_st1+9
2843                     ; 429 			send_buf[8] = st1.st_color_sense_L;
2845  006f 5500840045    	mov	_send_buf+8,_st1+12
2846                     ; 430 			send_buf[9] = st1.st_color_sense_M;
2848  0074 5500830046    	mov	_send_buf+9,_st1+11
2849                     ; 431 			send_buf[10] = st1.st_color_sense_H;
2851  0079 5500820047    	mov	_send_buf+10,_st1+10
2852                     ; 432 			break;
2854  007e acf104f1      	jpf	L1331
2855  0082               L3621:
2856                     ; 433 		case 0x06://回复心跳包，回复背光LED,及3个触控开关的状态
2856                     ; 434 			send_buf[1] = 0xAA;
2858  0082 35aa003e      	mov	_send_buf+1,#170
2859                     ; 435 			send_buf[6] = cmd;
2861  0086 7b07          	ld	a,(OFST+7,sp)
2862  0088 c70043        	ld	_send_buf+6,a
2863                     ; 436 			send_buf[7] = 0x00;//ST Module ID发0x00
2865  008b 725f0044      	clr	_send_buf+7
2866                     ; 437 			send_buf[8] = 0x00;
2868  008f 725f0045      	clr	_send_buf+8
2869                     ; 438 			if ((st1.st_device_status & 0x08)==0x08)	send_buf[8] = st1.st_pad1_status;
2871  0093 c6007a        	ld	a,_st1+2
2872  0096 a408          	and	a,#8
2873  0098 a108          	cp	a,#8
2874  009a 2605          	jrne	L3331
2877  009c 55007e0045    	mov	_send_buf+8,_st1+6
2878  00a1               L3331:
2879                     ; 439 			send_buf[9] = 0x00;
2881  00a1 725f0046      	clr	_send_buf+9
2882                     ; 440 			if ((st1.st_device_status & 0x04)==0x04)	send_buf[9] = st1.st_pad2_status;
2884  00a5 c6007a        	ld	a,_st1+2
2885  00a8 a404          	and	a,#4
2886  00aa a104          	cp	a,#4
2887  00ac 2605          	jrne	L5331
2890  00ae 55007f0046    	mov	_send_buf+9,_st1+7
2891  00b3               L5331:
2892                     ; 441 			send_buf[10] = 0x00;
2894  00b3 725f0047      	clr	_send_buf+10
2895                     ; 442 			if ((st1.st_device_status & 0x02)==0x02)	send_buf[10]= st1.st_pad3_status;
2897  00b7 c6007a        	ld	a,_st1+2
2898  00ba a402          	and	a,#2
2899  00bc a102          	cp	a,#2
2900  00be 2605          	jrne	L7331
2903  00c0 5500800047    	mov	_send_buf+10,_st1+8
2904  00c5               L7331:
2905                     ; 443 			send_buf[11] = 0x00;
2907  00c5 725f0048      	clr	_send_buf+11
2908                     ; 444 			if ((st1.st_device_status & 0x01)==0x01)	send_buf[11]= st1.st_led_status;
2910  00c9 c6007a        	ld	a,_st1+2
2911  00cc a401          	and	a,#1
2912  00ce a101          	cp	a,#1
2913  00d0 2703          	jreq	L601
2914  00d2 cc04f1        	jp	L1331
2915  00d5               L601:
2918  00d5 55007d0048    	mov	_send_buf+11,_st1+5
2919  00da acf104f1      	jpf	L1331
2920  00de               L5621:
2921                     ; 446 		case 0x29://ST上报手势信息
2921                     ; 447 			send_buf[6] = cmd;
2923  00de 7b07          	ld	a,(OFST+7,sp)
2924  00e0 c70043        	ld	_send_buf+6,a
2925                     ; 448 			send_buf[7] = st1.st_ges_H;
2927  00e3 5500780044    	mov	_send_buf+7,_st1
2928                     ; 449 			send_buf[8] = st1.st_ges_L;
2930  00e8 5500790045    	mov	_send_buf+8,_st1+1
2931                     ; 450 			send_buf[9] = 0x00;//ST Module ID 保留
2933  00ed 725f0046      	clr	_send_buf+9
2934                     ; 451 			break;
2936  00f1 acf104f1      	jpf	L1331
2937  00f5               L7621:
2938                     ; 452 		case 0x35:
2938                     ; 453 			send_buf[6] = cmd;
2940  00f5 7b07          	ld	a,(OFST+7,sp)
2941  00f7 c70043        	ld	_send_buf+6,a
2942                     ; 454 			if((st_pad1_ctrl) || (st_pad2_ctrl) || (st_pad3_ctrl)){
2944  00fa c600c8        	ld	a,_UART1Flag3_
2945  00fd a502          	bcp	a,#2
2946  00ff 2611          	jrne	L5431
2948  0101 c600c8        	ld	a,_UART1Flag3_
2949  0104 a504          	bcp	a,#4
2950  0106 260a          	jrne	L5431
2952  0108 c600c8        	ld	a,_UART1Flag3_
2953  010b a508          	bcp	a,#8
2954  010d 2603          	jrne	L011
2955  010f cc04f1        	jp	L1331
2956  0112               L011:
2957  0112               L5431:
2958                     ; 455 				if (st_pad1_ctrl)
2960  0112 c600c8        	ld	a,_UART1Flag3_
2961  0115 a502          	bcp	a,#2
2962  0117 270d          	jreq	L1531
2963                     ; 457 					send_buf[7] = 0x01;
2965  0119 35010044      	mov	_send_buf+7,#1
2966                     ; 458 					send_buf[8] = st1.st_pad1_status;
2968  011d 55007e0045    	mov	_send_buf+8,_st1+6
2969                     ; 459 					break;
2971  0122 acf104f1      	jpf	L1331
2972  0126               L1531:
2973                     ; 461 				if (st_pad2_ctrl)
2975  0126 c600c8        	ld	a,_UART1Flag3_
2976  0129 a504          	bcp	a,#4
2977  012b 270d          	jreq	L3531
2978                     ; 463 					send_buf[7] = 0x02;
2980  012d 35020044      	mov	_send_buf+7,#2
2981                     ; 464 					send_buf[8] = st1.st_pad2_status;
2983  0131 55007f0045    	mov	_send_buf+8,_st1+7
2984                     ; 465 					break;
2986  0136 acf104f1      	jpf	L1331
2987  013a               L3531:
2988                     ; 467 				if (st_pad3_ctrl)
2990  013a c600c8        	ld	a,_UART1Flag3_
2991  013d a508          	bcp	a,#8
2992  013f 270d          	jreq	L1721
2993                     ; 469 					send_buf[7] = 0x04;
2995  0141 35040044      	mov	_send_buf+7,#4
2996                     ; 470 					send_buf[8] = st1.st_pad3_status;
2998  0145 5500800045    	mov	_send_buf+8,_st1+8
2999                     ; 471 					break;
3001  014a acf104f1      	jpf	L1331
3002  014e               L1721:
3003                     ; 476 		case 0xAA://发送回执
3003                     ; 477 			send_buf[1] = 0xAA;
3005  014e 35aa003e      	mov	_send_buf+1,#170
3006                     ; 478 		  if (action_ctrlpad_flag)
3008  0152 c600ca        	ld	a,_UART1Flag1_
3009  0155 a510          	bcp	a,#16
3010  0157 2725          	jreq	L1631
3011                     ; 480 				action_ctrlpad_flag = 0;
3013  0159 721900ca      	bres	_UART1Flag1_,#4
3014                     ; 481 				send_buf[6] = cmd;
3016  015d 7b07          	ld	a,(OFST+7,sp)
3017  015f c70043        	ld	_send_buf+6,a
3018                     ; 482 				send_buf[7] = 0x05;//代表成功执行并返回模块状态
3020  0162 35050044      	mov	_send_buf+7,#5
3021                     ; 483 				send_buf[8] = st1.st_pad1_status;
3023  0166 55007e0045    	mov	_send_buf+8,_st1+6
3024                     ; 484 				send_buf[9] = st1.st_pad2_status;
3026  016b 55007f0046    	mov	_send_buf+9,_st1+7
3027                     ; 485 				send_buf[10] = st1.st_pad3_status;
3029  0170 5500800047    	mov	_send_buf+10,_st1+8
3030                     ; 486 				send_buf[11] = st1.st_led_status;
3032  0175 55007d0048    	mov	_send_buf+11,_st1+5
3034  017a acf104f1      	jpf	L1331
3035  017e               L1631:
3036                     ; 489 			else if(led_ctrl_flag)
3038  017e c600c7        	ld	a,_UART1Flag4_
3039  0181 a504          	bcp	a,#4
3040  0183 2726          	jreq	L5631
3041                     ; 491 				led_ctrl_flag = 0;
3043  0185 721500c7      	bres	_UART1Flag4_,#2
3044                     ; 492 				send_buf[6] = cmd;
3046  0189 7b07          	ld	a,(OFST+7,sp)
3047  018b c70043        	ld	_send_buf+6,a
3048                     ; 493 				send_buf[7] = 0x01;//代表指令执行成功
3050  018e 35010044      	mov	_send_buf+7,#1
3051                     ; 494 				if((st1.st_led_mode == 0x4F) ||	(st1.st_led_mode == 0x5F))
3053  0192 c600b4        	ld	a,_st1+60
3054  0195 a14f          	cp	a,#79
3055  0197 270a          	jreq	L1731
3057  0199 c600b4        	ld	a,_st1+60
3058  019c a15f          	cp	a,#95
3059  019e 2703          	jreq	L211
3060  01a0 cc04f1        	jp	L1331
3061  01a3               L211:
3062  01a3               L1731:
3063                     ; 495 					send_buf[7] = 0x02;//代表成功接收数据
3065  01a3 35020044      	mov	_send_buf+7,#2
3066  01a7 acf104f1      	jpf	L1331
3067  01ab               L5631:
3068                     ; 497 			else if(load_alert_flag)
3070  01ab c600c7        	ld	a,_UART1Flag4_
3071  01ae a508          	bcp	a,#8
3072  01b0 2711          	jreq	L5731
3073                     ; 499 				load_alert_flag = 0;
3075  01b2 721700c7      	bres	_UART1Flag4_,#3
3076                     ; 500 				send_buf[6] = cmd;
3078  01b6 7b07          	ld	a,(OFST+7,sp)
3079  01b8 c70043        	ld	_send_buf+6,a
3080                     ; 501 				send_buf[7] = 0x01;//代表指令执行成功
3082  01bb 35010044      	mov	_send_buf+7,#1
3084  01bf acf104f1      	jpf	L1331
3085  01c3               L5731:
3086                     ; 503 			else if (cmd_refresh_flag)
3088  01c3 c600ca        	ld	a,_UART1Flag1_
3089  01c6 a504          	bcp	a,#4
3090  01c8 2711          	jreq	L1041
3091                     ; 505 				cmd_refresh_flag = 0;
3093  01ca 721500ca      	bres	_UART1Flag1_,#2
3094                     ; 506 				send_buf[6] = cmd;
3096  01ce 7b07          	ld	a,(OFST+7,sp)
3097  01d0 c70043        	ld	_send_buf+6,a
3098                     ; 507 				send_buf[7] = 0x01;//代表指令执行成功
3100  01d3 35010044      	mov	_send_buf+7,#1
3102  01d7 acf104f1      	jpf	L1331
3103  01db               L1041:
3104                     ; 509 			else if(receipt_conf_pad1)
3106  01db c600c6        	ld	a,_UART1Flag5_
3107  01de a540          	bcp	a,#64
3108  01e0 2711          	jreq	L5041
3109                     ; 511 				receipt_conf_pad1 = 0;
3111  01e2 721d00c6      	bres	_UART1Flag5_,#6
3112                     ; 512 				send_buf[6] = cmd;
3114  01e6 7b07          	ld	a,(OFST+7,sp)
3115  01e8 c70043        	ld	_send_buf+6,a
3116                     ; 513 				send_buf[7] = 0x01;//代表指令执行成功
3118  01eb 35010044      	mov	_send_buf+7,#1
3120  01ef acf104f1      	jpf	L1331
3121  01f3               L5041:
3122                     ; 515 			else if(receipt_conf_pad2)
3124  01f3 c600c6        	ld	a,_UART1Flag5_
3125  01f6 a580          	bcp	a,#128
3126  01f8 2711          	jreq	L1141
3127                     ; 517 				receipt_conf_pad2 = 0;
3129  01fa 721f00c6      	bres	_UART1Flag5_,#7
3130                     ; 518 				send_buf[6] = cmd;
3132  01fe 7b07          	ld	a,(OFST+7,sp)
3133  0200 c70043        	ld	_send_buf+6,a
3134                     ; 519 				send_buf[7] = 0x03;//代表指令执行失败
3136  0203 35030044      	mov	_send_buf+7,#3
3138  0207 acf104f1      	jpf	L1331
3139  020b               L1141:
3140                     ; 521 			else if(receipt_conf_gest1)
3142  020b c600c5        	ld	a,_UART1Flag6_
3143  020e a501          	bcp	a,#1
3144  0210 2711          	jreq	L5141
3145                     ; 523 				receipt_conf_gest1 = 0;
3147  0212 721100c5      	bres	_UART1Flag6_,#0
3148                     ; 524 				send_buf[6] = cmd;
3150  0216 7b07          	ld	a,(OFST+7,sp)
3151  0218 c70043        	ld	_send_buf+6,a
3152                     ; 525 				send_buf[7] = 0x01;//代表指令执行成功
3154  021b 35010044      	mov	_send_buf+7,#1
3156  021f acf104f1      	jpf	L1331
3157  0223               L5141:
3158                     ; 527 			else if(receipt_conf_gest2)
3160  0223 c600c5        	ld	a,_UART1Flag6_
3161  0226 a502          	bcp	a,#2
3162  0228 2711          	jreq	L1241
3163                     ; 529 				receipt_conf_gest2 = 0;
3165  022a 721300c5      	bres	_UART1Flag6_,#1
3166                     ; 530 				send_buf[6] = cmd;
3168  022e 7b07          	ld	a,(OFST+7,sp)
3169  0230 c70043        	ld	_send_buf+6,a
3170                     ; 531 				send_buf[7] = 0x03;//代表指令执行失败
3172  0233 35030044      	mov	_send_buf+7,#3
3174  0237 acf104f1      	jpf	L1331
3175  023b               L1241:
3176                     ; 533 			else if(receipt_device_info2)
3178  023b c600c6        	ld	a,_UART1Flag5_
3179  023e a502          	bcp	a,#2
3180  0240 2711          	jreq	L5241
3181                     ; 535 				receipt_device_info2 = 0;
3183  0242 721300c6      	bres	_UART1Flag5_,#1
3184                     ; 536 				send_buf[6] = cmd;
3186  0246 7b07          	ld	a,(OFST+7,sp)
3187  0248 c70043        	ld	_send_buf+6,a
3188                     ; 537 				send_buf[7] = 0x03;//代表指令执行失败
3190  024b 35030044      	mov	_send_buf+7,#3
3192  024f acf104f1      	jpf	L1331
3193  0253               L5241:
3194                     ; 539 			else if(receipt_host_mesh)
3196  0253 c600c5        	ld	a,_UART1Flag6_
3197  0256 a504          	bcp	a,#4
3198  0258 2603          	jrne	L411
3199  025a cc04f1        	jp	L1331
3200  025d               L411:
3201                     ; 541 				receipt_host_mesh = 0;
3203  025d 721500c5      	bres	_UART1Flag6_,#2
3204                     ; 542 				send_buf[6] = cmd;
3206  0261 7b07          	ld	a,(OFST+7,sp)
3207  0263 c70043        	ld	_send_buf+6,a
3208                     ; 543 				send_buf[7] = 0x02;//代表指令接收成功
3210  0266 35020044      	mov	_send_buf+7,#2
3211  026a acf104f1      	jpf	L1331
3212  026e               L3721:
3213                     ; 546 		case 0xB4://ST回复设备信息
3213                     ; 547 			send_buf[6] = cmd;
3215  026e 7b07          	ld	a,(OFST+7,sp)
3216  0270 c70043        	ld	_send_buf+6,a
3217                     ; 548 			send_buf[7] = 0xAA;//UUID
3219  0273 35aa0044      	mov	_send_buf+7,#170
3220                     ; 549 			send_buf[8] = 0x55;
3222  0277 35550045      	mov	_send_buf+8,#85
3223                     ; 550 			send_buf[9] = 0xAB;
3225  027b 35ab0046      	mov	_send_buf+9,#171
3226                     ; 551 			send_buf[10] = 0x70;
3228  027f 35700047      	mov	_send_buf+10,#112
3229                     ; 552 			send_buf[11] = 0x63;//设备型号
3231  0283 35630048      	mov	_send_buf+11,#99
3232                     ; 553 			send_buf[12] = 0x00;//固件版本
3234  0287 725f0049      	clr	_send_buf+12
3235                     ; 554 			send_buf[13] = st1.st_device_status;
3237  028b 55007a004a    	mov	_send_buf+13,_st1+2
3238                     ; 555 			break;
3240  0290 acf104f1      	jpf	L1331
3241  0294               L5721:
3242                     ; 556 		case 0x0A://汇报 Seraph相关设备故障 
3242                     ; 557 			send_buf[6] = cmd;
3244  0294 7b07          	ld	a,(OFST+7,sp)
3245  0296 c70043        	ld	_send_buf+6,a
3246                     ; 558 			send_buf[7] = 0xB4;
3248  0299 35b40044      	mov	_send_buf+7,#180
3249                     ; 559 			send_buf[8] = st1.st_device_status;
3251  029d 55007a0045    	mov	_send_buf+8,_st1+2
3252                     ; 560 			break;
3254  02a2 acf104f1      	jpf	L1331
3255  02a6               L7721:
3256                     ; 561 		case 0x51://ST被触发判断需要向SC 发送指令	预设值指令手势
3256                     ; 562 		case 0x55:
3256                     ; 563 			send_buf[6] = cmd;
3258  02a6 7b07          	ld	a,(OFST+7,sp)
3259  02a8 c70043        	ld	_send_buf+6,a
3260                     ; 564 			if(gest1_confirm)
3262  02ab c600c9        	ld	a,_UART1Flag2_
3263  02ae a504          	bcp	a,#4
3264  02b0 2710          	jreq	L3341
3265                     ; 566 				send_buf[7] = st1.st_ges1_ctrl_boardid;
3267  02b2 5500980044    	mov	_send_buf+7,_st1+32
3268                     ; 567 				send_buf[8] = st1.st_ges1_ctrl_action_value;
3270  02b7 5500a90045    	mov	_send_buf+8,_st1+49
3271                     ; 568 				send_buf[9] = 0x1E;
3273  02bc 351e0046      	mov	_send_buf+9,#30
3275  02c0 2043          	jra	L5341
3276  02c2               L3341:
3277                     ; 570 			else if(gest2_confirm)
3279  02c2 c600c9        	ld	a,_UART1Flag2_
3280  02c5 a508          	bcp	a,#8
3281  02c7 2710          	jreq	L7341
3282                     ; 572 				send_buf[7] = st1.st_ges2_ctrl_boardid;
3284  02c9 55009d0044    	mov	_send_buf+7,_st1+37
3285                     ; 573 				send_buf[8] = st1.st_ges2_ctrl_action_value;
3287  02ce 5500ac0045    	mov	_send_buf+8,_st1+52
3288                     ; 574 				send_buf[9] = 0x1E;
3290  02d3 351e0046      	mov	_send_buf+9,#30
3292  02d7 202c          	jra	L5341
3293  02d9               L7341:
3294                     ; 576 			else if(gest3_confirm)
3296  02d9 c600c9        	ld	a,_UART1Flag2_
3297  02dc a510          	bcp	a,#16
3298  02de 2710          	jreq	L3441
3299                     ; 578 				send_buf[7] = st1.st_ges3_ctrl_boardid;
3301  02e0 5500a20044    	mov	_send_buf+7,_st1+42
3302                     ; 579 				send_buf[8] = st1.st_ges3_ctrl_action_value;
3304  02e5 5500af0045    	mov	_send_buf+8,_st1+55
3305                     ; 580 				send_buf[9] = 0x1E;
3307  02ea 351e0046      	mov	_send_buf+9,#30
3309  02ee 2015          	jra	L5341
3310  02f0               L3441:
3311                     ; 582 			else if(gest4_confirm)
3313  02f0 c600c9        	ld	a,_UART1Flag2_
3314  02f3 a520          	bcp	a,#32
3315  02f5 270e          	jreq	L5341
3316                     ; 584 				send_buf[7] = st1.st_ges4_ctrl_boardid;
3318  02f7 5500a70044    	mov	_send_buf+7,_st1+47
3319                     ; 585 				send_buf[8] = st1.st_ges4_ctrl_action_value;
3321  02fc 5500b20045    	mov	_send_buf+8,_st1+58
3322                     ; 586 				send_buf[9] = 0x1E;
3324  0301 351e0046      	mov	_send_buf+9,#30
3325  0305               L5341:
3326                     ; 588 			if(st_pad1_confirm)
3328  0305 c600c8        	ld	a,_UART1Flag3_
3329  0308 a510          	bcp	a,#16
3330  030a 271f          	jreq	L1541
3331                     ; 590 				send_buf[7] = st1.st_pad1_ctrl_boardid;
3333  030c 5500870044    	mov	_send_buf+7,_st1+15
3334                     ; 591 				if(cmd == 0x51)	send_buf[8] = st1.st_pad1_ctrl_action_value;//说明是调光
3336  0311 7b07          	ld	a,(OFST+7,sp)
3337  0313 a151          	cp	a,#81
3338  0315 2607          	jrne	L3541
3341  0317 5500890045    	mov	_send_buf+8,_st1+17
3343  031c 2005          	jra	L5541
3344  031e               L3541:
3345                     ; 592 				else						send_buf[8] = st1.st_pad1_status;
3347  031e 55007e0045    	mov	_send_buf+8,_st1+6
3348  0323               L5541:
3349                     ; 593 				send_buf[9] = 0x1E;
3351  0323 351e0046      	mov	_send_buf+9,#30
3352                     ; 594 				break;
3354  0327 acf104f1      	jpf	L1331
3355  032b               L1541:
3356                     ; 596 			else if(st_pad2_confirm)
3358  032b c600c8        	ld	a,_UART1Flag3_
3359  032e a520          	bcp	a,#32
3360  0330 271f          	jreq	L1641
3361                     ; 598 				send_buf[7] = st1.st_pad2_ctrl_boardid;
3363  0332 55008c0044    	mov	_send_buf+7,_st1+20
3364                     ; 599 				if(cmd == 0x51)	send_buf[8] = st1.st_pad2_ctrl_action_value;//说明是调光
3366  0337 7b07          	ld	a,(OFST+7,sp)
3367  0339 a151          	cp	a,#81
3368  033b 2607          	jrne	L3641
3371  033d 55008e0045    	mov	_send_buf+8,_st1+22
3373  0342 2005          	jra	L5641
3374  0344               L3641:
3375                     ; 600 				else						send_buf[8] = st1.st_pad2_status;
3377  0344 55007f0045    	mov	_send_buf+8,_st1+7
3378  0349               L5641:
3379                     ; 601 				send_buf[9] = 0x1E;
3381  0349 351e0046      	mov	_send_buf+9,#30
3382                     ; 602 				break;
3384  034d acf104f1      	jpf	L1331
3385  0351               L1641:
3386                     ; 604 			else if(st_pad3_confirm)
3388  0351 c600c8        	ld	a,_UART1Flag3_
3389  0354 a540          	bcp	a,#64
3390  0356 2603          	jrne	L611
3391  0358 cc04f1        	jp	L1331
3392  035b               L611:
3393                     ; 606 				send_buf[7] = st1.st_pad3_ctrl_boardid;
3395  035b 5500910044    	mov	_send_buf+7,_st1+25
3396                     ; 607 				if(cmd == 0x51)	send_buf[8] = st1.st_pad3_ctrl_action_value;//说明是调光
3398  0360 7b07          	ld	a,(OFST+7,sp)
3399  0362 a151          	cp	a,#81
3400  0364 2607          	jrne	L3741
3403  0366 5500930045    	mov	_send_buf+8,_st1+27
3405  036b 2005          	jra	L5741
3406  036d               L3741:
3407                     ; 608 				else						send_buf[8] = st1.st_pad3_status;
3409  036d 5500800045    	mov	_send_buf+8,_st1+8
3410  0372               L5741:
3411                     ; 609 				send_buf[9] = 0x1E;
3413  0372 351e0046      	mov	_send_buf+9,#30
3414                     ; 610 				break;
3416  0376 acf104f1      	jpf	L1331
3417  037a               L1031:
3418                     ; 614 		case 0x08://ST被触发异步向 SS 推送触发器数值和判断结果
3418                     ; 615 			send_buf[6] = cmd;
3420  037a 7b07          	ld	a,(OFST+7,sp)
3421  037c c70043        	ld	_send_buf+6,a
3422                     ; 616 			if(gest1_confirm)
3424  037f c600c9        	ld	a,_UART1Flag2_
3425  0382 a504          	bcp	a,#4
3426  0384 2730          	jreq	L7741
3427                     ; 618 				send_buf[7] = 0x02;//触发器是手势
3429  0386 35020044      	mov	_send_buf+7,#2
3430                     ; 619 				send_buf[8] = st1.st_ges1_ctrl_H;
3432  038a 5500940045    	mov	_send_buf+8,_st1+28
3433                     ; 620 				send_buf[9] = st1.st_ges1_ctrl_L;
3435  038f 5500950046    	mov	_send_buf+9,_st1+29
3436                     ; 621 				send_buf[10] = st1.st_ges1_ctrl_meshid_H;
3438  0394 5500960047    	mov	_send_buf+10,_st1+30
3439                     ; 622 				send_buf[11] = st1.st_ges1_ctrl_meshid_L;
3441  0399 5500970048    	mov	_send_buf+11,_st1+31
3442                     ; 623 				send_buf[12] = st1.st_ges1_ctrl_action;
3444  039e 5500a80049    	mov	_send_buf+12,_st1+48
3445                     ; 624 				send_buf[13] = st1.st_ges1_ctrl_boardid;
3447  03a3 550098004a    	mov	_send_buf+13,_st1+32
3448                     ; 625 				send_buf[14] = st1.st_ges1_ctrl_action_value;
3450  03a8 5500a9004b    	mov	_send_buf+14,_st1+49
3451                     ; 626 				send_buf[15] = st1.st_ges1_ctrl_action_time;
3453  03ad 5500aa004c    	mov	_send_buf+15,_st1+50
3455  03b2 acf104f1      	jpf	L1331
3456  03b6               L7741:
3457                     ; 628 			else if(gest2_confirm)
3459  03b6 c600c9        	ld	a,_UART1Flag2_
3460  03b9 a508          	bcp	a,#8
3461  03bb 2730          	jreq	L3051
3462                     ; 630 				send_buf[7] = 0x02;
3464  03bd 35020044      	mov	_send_buf+7,#2
3465                     ; 631 				send_buf[8] = st1.st_ges2_ctrl_H;
3467  03c1 5500990045    	mov	_send_buf+8,_st1+33
3468                     ; 632 				send_buf[9] = st1.st_ges2_ctrl_L;
3470  03c6 55009a0046    	mov	_send_buf+9,_st1+34
3471                     ; 633 				send_buf[10] = st1.st_ges2_ctrl_meshid_H;
3473  03cb 55009b0047    	mov	_send_buf+10,_st1+35
3474                     ; 634 				send_buf[11] = st1.st_ges2_ctrl_meshid_L;
3476  03d0 55009c0048    	mov	_send_buf+11,_st1+36
3477                     ; 635 				send_buf[12] = st1.st_ges2_ctrl_action;
3479  03d5 5500ab0049    	mov	_send_buf+12,_st1+51
3480                     ; 636 				send_buf[13] = st1.st_ges2_ctrl_boardid;
3482  03da 55009d004a    	mov	_send_buf+13,_st1+37
3483                     ; 637 				send_buf[14] = st1.st_ges2_ctrl_action_value;
3485  03df 5500ac004b    	mov	_send_buf+14,_st1+52
3486                     ; 638 				send_buf[15] = st1.st_ges2_ctrl_action_time;
3488  03e4 5500ad004c    	mov	_send_buf+15,_st1+53
3490  03e9 acf104f1      	jpf	L1331
3491  03ed               L3051:
3492                     ; 640 			else if(gest3_confirm)
3494  03ed c600c9        	ld	a,_UART1Flag2_
3495  03f0 a510          	bcp	a,#16
3496  03f2 2730          	jreq	L7051
3497                     ; 642 				send_buf[7] = 0x02;
3499  03f4 35020044      	mov	_send_buf+7,#2
3500                     ; 643 				send_buf[8] = st1.st_ges3_ctrl_H;
3502  03f8 55009e0045    	mov	_send_buf+8,_st1+38
3503                     ; 644 				send_buf[9] = st1.st_ges3_ctrl_L;
3505  03fd 55009f0046    	mov	_send_buf+9,_st1+39
3506                     ; 645 				send_buf[10] = st1.st_ges3_ctrl_meshid_H;
3508  0402 5500a00047    	mov	_send_buf+10,_st1+40
3509                     ; 646 				send_buf[11] = st1.st_ges3_ctrl_meshid_L;
3511  0407 5500a10048    	mov	_send_buf+11,_st1+41
3512                     ; 647 				send_buf[12] = st1.st_ges3_ctrl_action;
3514  040c 5500ae0049    	mov	_send_buf+12,_st1+54
3515                     ; 648 				send_buf[13] = st1.st_ges3_ctrl_boardid;
3517  0411 5500a2004a    	mov	_send_buf+13,_st1+42
3518                     ; 649 				send_buf[14] = st1.st_ges3_ctrl_action_value;
3520  0416 5500af004b    	mov	_send_buf+14,_st1+55
3521                     ; 650 				send_buf[15] = st1.st_ges3_ctrl_action_time;
3523  041b 5500b0004c    	mov	_send_buf+15,_st1+56
3525  0420 acf104f1      	jpf	L1331
3526  0424               L7051:
3527                     ; 652 			else if(gest4_confirm)
3529  0424 c600c9        	ld	a,_UART1Flag2_
3530  0427 a520          	bcp	a,#32
3531  0429 272f          	jreq	L3151
3532                     ; 654 				send_buf[7] = 0x02;
3534  042b 35020044      	mov	_send_buf+7,#2
3535                     ; 655 				send_buf[8] = st1.st_ges4_ctrl_H;
3537  042f 5500a30045    	mov	_send_buf+8,_st1+43
3538                     ; 656 				send_buf[9] = st1.st_ges4_ctrl_L;
3540  0434 5500a40046    	mov	_send_buf+9,_st1+44
3541                     ; 657 				send_buf[10] = st1.st_ges4_ctrl_meshid_H;
3543  0439 5500a50047    	mov	_send_buf+10,_st1+45
3544                     ; 658 				send_buf[11] = st1.st_ges4_ctrl_meshid_L;
3546  043e 5500a60048    	mov	_send_buf+11,_st1+46
3547                     ; 659 				send_buf[12] = st1.st_ges4_ctrl_action;
3549  0443 5500b10049    	mov	_send_buf+12,_st1+57
3550                     ; 660 				send_buf[13] = st1.st_ges4_ctrl_boardid;
3552  0448 5500a7004a    	mov	_send_buf+13,_st1+47
3553                     ; 661 				send_buf[14] = st1.st_ges4_ctrl_action_value;
3555  044d 5500b2004b    	mov	_send_buf+14,_st1+58
3556                     ; 662 				send_buf[15] = 0x00;
3558  0452 725f004c      	clr	_send_buf+15
3560  0456 acf104f1      	jpf	L1331
3561  045a               L3151:
3562                     ; 664 			else if(st_pad1_confirm)
3564  045a c600c8        	ld	a,_UART1Flag3_
3565  045d a510          	bcp	a,#16
3566  045f 272c          	jreq	L7151
3567                     ; 666 				send_buf[7] = 0x01;//触发器是按键
3569  0461 35010044      	mov	_send_buf+7,#1
3570                     ; 667 				send_buf[8] = 0x00;
3572  0465 725f0045      	clr	_send_buf+8
3573                     ; 668 				send_buf[9] = st1.st_ctrl_address;
3575  0469 55007b0046    	mov	_send_buf+9,_st1+3
3576                     ; 669 				send_buf[10] = st1.st_pad1_ctrl_meshid_H;
3578  046e 5500850047    	mov	_send_buf+10,_st1+13
3579                     ; 670 				send_buf[11] = st1.st_pad1_ctrl_meshid_L;
3581  0473 5500860048    	mov	_send_buf+11,_st1+14
3582                     ; 671 				send_buf[12] = st1.st_pad1_ctrl_action;
3584  0478 5500880049    	mov	_send_buf+12,_st1+16
3585                     ; 672 				send_buf[13] = st1.st_pad1_ctrl_boardid;
3587  047d 550087004a    	mov	_send_buf+13,_st1+15
3588                     ; 673 				send_buf[14] = st1.st_pad1_status;
3590  0482 55007e004b    	mov	_send_buf+14,_st1+6
3591                     ; 674 				send_buf[15] = 0x00;
3593  0487 725f004c      	clr	_send_buf+15
3595  048b 2064          	jra	L1331
3596  048d               L7151:
3597                     ; 676 			else if(st_pad2_confirm)
3599  048d c600c8        	ld	a,_UART1Flag3_
3600  0490 a520          	bcp	a,#32
3601  0492 272c          	jreq	L3251
3602                     ; 678 				send_buf[7] = 0x01;//触发器是按键
3604  0494 35010044      	mov	_send_buf+7,#1
3605                     ; 679 				send_buf[8] = 0x00;
3607  0498 725f0045      	clr	_send_buf+8
3608                     ; 680 				send_buf[9] = st1.st_ctrl_address;
3610  049c 55007b0046    	mov	_send_buf+9,_st1+3
3611                     ; 681 				send_buf[10] = st1.st_pad2_ctrl_meshid_H;
3613  04a1 55008a0047    	mov	_send_buf+10,_st1+18
3614                     ; 682 				send_buf[11] = st1.st_pad2_ctrl_meshid_L;
3616  04a6 55008b0048    	mov	_send_buf+11,_st1+19
3617                     ; 683 				send_buf[12] = st1.st_pad2_ctrl_action;
3619  04ab 55008d0049    	mov	_send_buf+12,_st1+21
3620                     ; 684 				send_buf[13] = st1.st_pad2_ctrl_boardid;
3622  04b0 55008c004a    	mov	_send_buf+13,_st1+20
3623                     ; 685 				send_buf[14] = st1.st_pad2_status;
3625  04b5 55007f004b    	mov	_send_buf+14,_st1+7
3626                     ; 686 				send_buf[15] = 0x00;
3628  04ba 725f004c      	clr	_send_buf+15
3630  04be 2031          	jra	L1331
3631  04c0               L3251:
3632                     ; 688 			else if(st_pad3_confirm)
3634  04c0 c600c8        	ld	a,_UART1Flag3_
3635  04c3 a540          	bcp	a,#64
3636  04c5 272a          	jreq	L1331
3637                     ; 690 				send_buf[7] = 0x01;//触发器是按键
3639  04c7 35010044      	mov	_send_buf+7,#1
3640                     ; 691 				send_buf[8] = 0x00;
3642  04cb 725f0045      	clr	_send_buf+8
3643                     ; 692 				send_buf[9] = st1.st_ctrl_address;
3645  04cf 55007b0046    	mov	_send_buf+9,_st1+3
3646                     ; 693 				send_buf[10] = st1.st_pad3_ctrl_meshid_H;
3648  04d4 55008f0047    	mov	_send_buf+10,_st1+23
3649                     ; 694 				send_buf[11] = st1.st_pad3_ctrl_meshid_L;
3651  04d9 5500900048    	mov	_send_buf+11,_st1+24
3652                     ; 695 				send_buf[12] = st1.st_pad3_ctrl_action;
3654  04de 5500920049    	mov	_send_buf+12,_st1+26
3655                     ; 696 				send_buf[13] = st1.st_pad3_ctrl_boardid;
3657  04e3 550091004a    	mov	_send_buf+13,_st1+25
3658                     ; 697 				send_buf[14] = st1.st_pad3_status;
3660  04e8 550080004b    	mov	_send_buf+14,_st1+8
3661                     ; 698 				send_buf[15] = 0x00;
3663  04ed 725f004c      	clr	_send_buf+15
3664  04f1               L1331:
3665                     ; 702 	send_buf[len+2] = Check_Sum((send_buf+2),len);
3667  04f1 7b06          	ld	a,(OFST+6,sp)
3668  04f3 5f            	clrw	x
3669  04f4 97            	ld	xl,a
3670  04f5 89            	pushw	x
3671  04f6 7b08          	ld	a,(OFST+8,sp)
3672  04f8 88            	push	a
3673  04f9 ae003f        	ldw	x,#_send_buf+2
3674  04fc cd0000        	call	_Check_Sum
3676  04ff 5b01          	addw	sp,#1
3677  0501 85            	popw	x
3678  0502 d7003f        	ld	(_send_buf+2,x),a
3679                     ; 704 }
3682  0505 85            	popw	x
3683  0506 81            	ret
3750                     ; 722 void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length)
3750                     ; 723 {
3751                     .text:	section	.text,new
3752  0000               _rev_header_anaylze:
3754  0000 89            	pushw	x
3755       00000000      OFST:	set	0
3758                     ; 724 	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
3760  0001 c60001        	ld	a,_sicp_buf
3761  0004 a1ee          	cp	a,#238
3762  0006 262c          	jrne	L3651
3764  0008 c60002        	ld	a,_sicp_buf+1
3765  000b a1ee          	cp	a,#238
3766  000d 2707          	jreq	L5651
3768  000f c60002        	ld	a,_sicp_buf+1
3769  0012 a1aa          	cp	a,#170
3770  0014 261e          	jrne	L3651
3771  0016               L5651:
3772                     ; 726 		ble_data_frame = 1;
3774  0016 721a00ca      	bset	_UART1Flag1_,#5
3775                     ; 727 		*message_id = sicp_buf[2];
3777  001a 1e01          	ldw	x,(OFST+1,sp)
3778  001c c60003        	ld	a,_sicp_buf+2
3779  001f f7            	ld	(x),a
3780                     ; 728 		*mesh_id_H = sicp_buf[3];
3782  0020 1e05          	ldw	x,(OFST+5,sp)
3783  0022 c60004        	ld	a,_sicp_buf+3
3784  0025 f7            	ld	(x),a
3785                     ; 729 		*mesh_id_L = sicp_buf[4];
3787  0026 1e07          	ldw	x,(OFST+7,sp)
3788  0028 c60005        	ld	a,_sicp_buf+4
3789  002b f7            	ld	(x),a
3790                     ; 730 		*message_length = sicp_buf[5];
3792  002c 1e09          	ldw	x,(OFST+9,sp)
3793  002e c60006        	ld	a,_sicp_buf+5
3794  0031 f7            	ld	(x),a
3796  0032 2018          	jra	L7651
3797  0034               L3651:
3798                     ; 733 	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))//Network	Status	Reporting	
3800  0034 c60001        	ld	a,_sicp_buf
3801  0037 a1dd          	cp	a,#221
3802  0039 2611          	jrne	L7651
3804  003b c60002        	ld	a,_sicp_buf+1
3805  003e a1dd          	cp	a,#221
3806  0040 260a          	jrne	L7651
3807                     ; 735 		ble_ctrl_frame = 1;
3809  0042 721c00ca      	bset	_UART1Flag1_,#6
3810                     ; 736 		*message_length = sicp_buf[3];
3812  0046 1e09          	ldw	x,(OFST+9,sp)
3813  0048 c60004        	ld	a,_sicp_buf+3
3814  004b f7            	ld	(x),a
3815  004c               L7651:
3816                     ; 743 }
3819  004c 85            	popw	x
3820  004d 81            	ret
3897                     ; 750 bool rev_payload_anaylze(void)
3897                     ; 751 {
3898                     .text:	section	.text,new
3899  0000               _rev_payload_anaylze:
3901  0000 88            	push	a
3902       00000001      OFST:	set	1
3905                     ; 752 	u8 action_ctrl_num = 0;
3907  0001 0f01          	clr	(OFST+0,sp)
3908                     ; 753 	if (ble_data_frame)
3910  0003 c600ca        	ld	a,_UART1Flag1_
3911  0006 a520          	bcp	a,#32
3912  0008 2603          	jrne	L421
3913  000a cc06b7        	jp	L1661
3914  000d               L421:
3915                     ; 755 		ble_data_frame = 0;
3917  000d 721b00ca      	bres	_UART1Flag1_,#5
3918                     ; 756 		switch(sicp_buf[6])
3920  0011 c60007        	ld	a,_sicp_buf+6
3922                     ; 1075 			default:
3922                     ; 1076 				break;
3923  0014 a003          	sub	a,#3
3924  0016 2603          	jrne	L621
3925  0018 cc03b1        	jp	L1061
3926  001b               L621:
3927  001b 4a            	dec	a
3928  001c 272d          	jreq	L3751
3929  001e 4a            	dec	a
3930  001f 2603          	jrne	L031
3931  0021 cc0650        	jp	L1261
3932  0024               L031:
3933  0024 a004          	sub	a,#4
3934  0026 2603          	jrne	L231
3935  0028 cc04e3        	jp	L5061
3936  002b               L231:
3937  002b a04d          	sub	a,#77
3938  002d 2603          	jrne	L431
3939  002f cc0440        	jp	L3061
3940  0032               L431:
3941  0032 a054          	sub	a,#84
3942  0034 2603          	jrne	L631
3943  0036 cc038d        	jp	L5751
3944  0039               L631:
3945  0039 a006          	sub	a,#6
3946  003b 2603          	jrne	L041
3947  003d cc067a        	jp	L3261
3948  0040               L041:
3949  0040 a010          	sub	a,#16
3950  0042 2603          	jrne	L241
3951  0044 cc039f        	jp	L7751
3952  0047               L241:
3953  0047 acb206b2      	jpf	L5661
3954  004b               L3751:
3955                     ; 758 			case 0x04://SS向ST发送配置信息
3955                     ; 759 				receipt_device_info1 = 1;
3957  004b 721000c6      	bset	_UART1Flag5_,#0
3958                     ; 762 					if (sicp_buf[7] == 0x01)//设置ST按键作用
3960  004f c60008        	ld	a,_sicp_buf+7
3961  0052 a101          	cp	a,#1
3962  0054 2703          	jreq	L441
3963  0056 cc015d        	jp	L7661
3964  0059               L441:
3965                     ; 764 						kickout_flag = 0;
3967  0059 721100c7      	bres	_UART1Flag4_,#0
3968                     ; 765 						net_reset_flag = 0;
3970  005d 721300c7      	bres	_UART1Flag4_,#1
3971                     ; 766 						if (sicp_buf[8] == 1)//设置通道1
3973  0061 c60009        	ld	a,_sicp_buf+8
3974  0064 a101          	cp	a,#1
3975  0066 2640          	jrne	L1761
3976                     ; 768 							st1.st_pad1_ctrl_meshid_H = sicp_buf[10];
3978  0068 55000b0085    	mov	_st1+13,_sicp_buf+10
3979                     ; 769 							st1.st_pad1_ctrl_meshid_L = sicp_buf[11];
3981  006d 55000c0086    	mov	_st1+14,_sicp_buf+11
3982                     ; 770 							st1.st_pad1_ctrl_boardid 	= sicp_buf[12];
3984  0072 55000d0087    	mov	_st1+15,_sicp_buf+12
3985                     ; 771 							st1.st_pad1_ctrl_action   = sicp_buf[13];
3987  0077 55000e0088    	mov	_st1+16,_sicp_buf+13
3988                     ; 772 							st1.st_pad1_ctrl_action_value = sicp_buf[14];
3990  007c 55000f0089    	mov	_st1+17,_sicp_buf+14
3991                     ; 773 							receipt_conf_pad1 = 1;
3993  0081 721c00c6      	bset	_UART1Flag5_,#6
3994                     ; 774 							send_message_length = 6;
3996  0085 35060065      	mov	_send_message_length,#6
3997                     ; 775 							send_cmd = 0xAA;
3999  0089 35aa0064      	mov	_send_cmd,#170
4000                     ; 776 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4002  008d 4baa          	push	#170
4003  008f 4b06          	push	#6
4004  0091 3b006b        	push	_ns_host_meshid_L
4005  0094 c6006c        	ld	a,_ns_host_meshid_H
4006  0097 97            	ld	xl,a
4007  0098 c6006a        	ld	a,_rev_message_id
4008  009b 95            	ld	xh,a
4009  009c cd0000        	call	_send_header_payload_init
4011  009f 5b03          	addw	sp,#3
4012                     ; 777 							UART2_Send_Data_Start();
4014  00a1 cd0000        	call	_UART2_Send_Data_Start
4016                     ; 778 							break;
4018  00a4 acb206b2      	jpf	L5661
4019  00a8               L1761:
4020                     ; 780 						else if (sicp_buf[8] == 2)//设置通道2
4022  00a8 c60009        	ld	a,_sicp_buf+8
4023  00ab a102          	cp	a,#2
4024  00ad 2640          	jrne	L5761
4025                     ; 782 							st1.st_pad2_ctrl_meshid_H = sicp_buf[10];
4027  00af 55000b008a    	mov	_st1+18,_sicp_buf+10
4028                     ; 783 							st1.st_pad2_ctrl_meshid_L = sicp_buf[11];
4030  00b4 55000c008b    	mov	_st1+19,_sicp_buf+11
4031                     ; 784 							st1.st_pad2_ctrl_boardid 	= sicp_buf[12];
4033  00b9 55000d008c    	mov	_st1+20,_sicp_buf+12
4034                     ; 785 							st1.st_pad2_ctrl_action   = sicp_buf[13];
4036  00be 55000e008d    	mov	_st1+21,_sicp_buf+13
4037                     ; 786 							st1.st_pad2_ctrl_action_value = sicp_buf[14];
4039  00c3 55000f008e    	mov	_st1+22,_sicp_buf+14
4040                     ; 787 							receipt_conf_pad1 = 1;
4042  00c8 721c00c6      	bset	_UART1Flag5_,#6
4043                     ; 788 							send_message_length = 6;
4045  00cc 35060065      	mov	_send_message_length,#6
4046                     ; 789 							send_cmd = 0xAA;
4048  00d0 35aa0064      	mov	_send_cmd,#170
4049                     ; 790 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4051  00d4 4baa          	push	#170
4052  00d6 4b06          	push	#6
4053  00d8 3b006b        	push	_ns_host_meshid_L
4054  00db c6006c        	ld	a,_ns_host_meshid_H
4055  00de 97            	ld	xl,a
4056  00df c6006a        	ld	a,_rev_message_id
4057  00e2 95            	ld	xh,a
4058  00e3 cd0000        	call	_send_header_payload_init
4060  00e6 5b03          	addw	sp,#3
4061                     ; 791 							UART2_Send_Data_Start();
4063  00e8 cd0000        	call	_UART2_Send_Data_Start
4065                     ; 792 							break;
4067  00eb acb206b2      	jpf	L5661
4068  00ef               L5761:
4069                     ; 794 						else if (sicp_buf[8] == 3)//设置通道3
4071  00ef c60009        	ld	a,_sicp_buf+8
4072  00f2 a103          	cp	a,#3
4073  00f4 2640          	jrne	L1071
4074                     ; 796 							st1.st_pad3_ctrl_meshid_H = sicp_buf[10];
4076  00f6 55000b008f    	mov	_st1+23,_sicp_buf+10
4077                     ; 797 							st1.st_pad3_ctrl_meshid_L = sicp_buf[11];
4079  00fb 55000c0090    	mov	_st1+24,_sicp_buf+11
4080                     ; 798 							st1.st_pad3_ctrl_boardid 	= sicp_buf[12];
4082  0100 55000d0091    	mov	_st1+25,_sicp_buf+12
4083                     ; 799 							st1.st_pad3_ctrl_action   = sicp_buf[13];
4085  0105 55000e0092    	mov	_st1+26,_sicp_buf+13
4086                     ; 800 							st1.st_pad3_ctrl_action_value = sicp_buf[14];
4088  010a 55000f0093    	mov	_st1+27,_sicp_buf+14
4089                     ; 801 							receipt_conf_pad1 = 1;
4091  010f 721c00c6      	bset	_UART1Flag5_,#6
4092                     ; 802 							send_message_length = 6;
4094  0113 35060065      	mov	_send_message_length,#6
4095                     ; 803 							send_cmd = 0xAA;
4097  0117 35aa0064      	mov	_send_cmd,#170
4098                     ; 804 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4100  011b 4baa          	push	#170
4101  011d 4b06          	push	#6
4102  011f 3b006b        	push	_ns_host_meshid_L
4103  0122 c6006c        	ld	a,_ns_host_meshid_H
4104  0125 97            	ld	xl,a
4105  0126 c6006a        	ld	a,_rev_message_id
4106  0129 95            	ld	xh,a
4107  012a cd0000        	call	_send_header_payload_init
4109  012d 5b03          	addw	sp,#3
4110                     ; 805 							UART2_Send_Data_Start();
4112  012f cd0000        	call	_UART2_Send_Data_Start
4114                     ; 806 							break;
4116  0132 acb206b2      	jpf	L5661
4117  0136               L1071:
4118                     ; 810 							receipt_conf_pad2 = 1;
4120  0136 721e00c6      	bset	_UART1Flag5_,#7
4121                     ; 811 							send_message_length = 6;
4123  013a 35060065      	mov	_send_message_length,#6
4124                     ; 812 							send_cmd = 0xAA;
4126  013e 35aa0064      	mov	_send_cmd,#170
4127                     ; 813 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4129  0142 4baa          	push	#170
4130  0144 4b06          	push	#6
4131  0146 3b006b        	push	_ns_host_meshid_L
4132  0149 c6006c        	ld	a,_ns_host_meshid_H
4133  014c 97            	ld	xl,a
4134  014d c6006a        	ld	a,_rev_message_id
4135  0150 95            	ld	xh,a
4136  0151 cd0000        	call	_send_header_payload_init
4138  0154 5b03          	addw	sp,#3
4139                     ; 814 							UART2_Send_Data_Start();
4141  0156 cd0000        	call	_UART2_Send_Data_Start
4143                     ; 815 							break;
4145  0159 acb206b2      	jpf	L5661
4146  015d               L7661:
4147                     ; 819 					else if (sicp_buf[7] == 0x02)//设置ST手势作用
4149  015d c60008        	ld	a,_sicp_buf+7
4150  0160 a102          	cp	a,#2
4151  0162 2703          	jreq	L641
4152  0164 cc06b2        	jp	L5661
4153  0167               L641:
4154                     ; 821 						kickout_flag = 0;
4156  0167 721100c7      	bres	_UART1Flag4_,#0
4157                     ; 822 						net_reset_flag = 0;
4159  016b 721300c7      	bres	_UART1Flag4_,#1
4160                     ; 824 						if((st1.st_ges1_ctrl_H == 0x11) && (st1.st_ges1_ctrl_L == 0x11) && (sicp_buf[8] != st1.st_ges1_ctrl_H) && (sicp_buf[9] != st1.st_ges1_ctrl_L))//第一个预设置手势
4162  016f c60094        	ld	a,_st1+28
4163  0172 a111          	cp	a,#17
4164  0174 2661          	jrne	L1171
4166  0176 c60095        	ld	a,_st1+29
4167  0179 a111          	cp	a,#17
4168  017b 265a          	jrne	L1171
4170  017d c60009        	ld	a,_sicp_buf+8
4171  0180 c10094        	cp	a,_st1+28
4172  0183 2752          	jreq	L1171
4174  0185 c6000a        	ld	a,_sicp_buf+9
4175  0188 c10095        	cp	a,_st1+29
4176  018b 274a          	jreq	L1171
4177                     ; 826 							st1.st_ges1_ctrl_H						= sicp_buf[8];
4179  018d 5500090094    	mov	_st1+28,_sicp_buf+8
4180                     ; 827 							st1.st_ges1_ctrl_L						= sicp_buf[9];
4182  0192 55000a0095    	mov	_st1+29,_sicp_buf+9
4183                     ; 828 							st1.st_ges1_ctrl_meshid_H 		= sicp_buf[10];
4185  0197 55000b0096    	mov	_st1+30,_sicp_buf+10
4186                     ; 829 							st1.st_ges1_ctrl_meshid_L 		= sicp_buf[11];
4188  019c 55000c0097    	mov	_st1+31,_sicp_buf+11
4189                     ; 830 							st1.st_ges1_ctrl_boardid 			= sicp_buf[12];
4191  01a1 55000d0098    	mov	_st1+32,_sicp_buf+12
4192                     ; 831 							st1.st_ges1_ctrl_action				= sicp_buf[13];
4194  01a6 55000e00a8    	mov	_st1+48,_sicp_buf+13
4195                     ; 832 							st1.st_ges1_ctrl_action_value = sicp_buf[14];
4197  01ab 55000f00a9    	mov	_st1+49,_sicp_buf+14
4198                     ; 834 							receipt_conf_gest1 = 1;
4200  01b0 721000c5      	bset	_UART1Flag6_,#0
4201                     ; 835 							send_message_length = 6;
4203  01b4 35060065      	mov	_send_message_length,#6
4204                     ; 836 							send_cmd = 0xAA;
4206  01b8 35aa0064      	mov	_send_cmd,#170
4207                     ; 837 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4209  01bc 4baa          	push	#170
4210  01be 4b06          	push	#6
4211  01c0 3b006b        	push	_ns_host_meshid_L
4212  01c3 c6006c        	ld	a,_ns_host_meshid_H
4213  01c6 97            	ld	xl,a
4214  01c7 c6006a        	ld	a,_rev_message_id
4215  01ca 95            	ld	xh,a
4216  01cb cd0000        	call	_send_header_payload_init
4218  01ce 5b03          	addw	sp,#3
4219                     ; 838 							UART2_Send_Data_Start();
4221  01d0 cd0000        	call	_UART2_Send_Data_Start
4223                     ; 839 							break;
4225  01d3 acb206b2      	jpf	L5661
4226  01d7               L1171:
4227                     ; 841 						else if((st1.st_ges2_ctrl_H == 0x11) && (st1.st_ges2_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges2_ctrl_H) && (sicp_buf[9] != st1.st_ges2_ctrl_L))//第二个预设置手势
4229  01d7 c60099        	ld	a,_st1+33
4230  01da a111          	cp	a,#17
4231  01dc 2661          	jrne	L5171
4233  01de c6009a        	ld	a,_st1+34
4234  01e1 a111          	cp	a,#17
4235  01e3 265a          	jrne	L5171
4237  01e5 c60009        	ld	a,_sicp_buf+8
4238  01e8 c10099        	cp	a,_st1+33
4239  01eb 2752          	jreq	L5171
4241  01ed c6000a        	ld	a,_sicp_buf+9
4242  01f0 c1009a        	cp	a,_st1+34
4243  01f3 274a          	jreq	L5171
4244                     ; 843 							st1.st_ges2_ctrl_H						= sicp_buf[8];
4246  01f5 5500090099    	mov	_st1+33,_sicp_buf+8
4247                     ; 844 							st1.st_ges2_ctrl_L						= sicp_buf[9];
4249  01fa 55000a009a    	mov	_st1+34,_sicp_buf+9
4250                     ; 845 							st1.st_ges2_ctrl_meshid_H 		= sicp_buf[10];
4252  01ff 55000b009b    	mov	_st1+35,_sicp_buf+10
4253                     ; 846 							st1.st_ges2_ctrl_meshid_L 		= sicp_buf[11];
4255  0204 55000c009c    	mov	_st1+36,_sicp_buf+11
4256                     ; 847 							st1.st_ges2_ctrl_boardid 			= sicp_buf[12];
4258  0209 55000d009d    	mov	_st1+37,_sicp_buf+12
4259                     ; 848 							st1.st_ges2_ctrl_action				= sicp_buf[13];
4261  020e 55000e00ab    	mov	_st1+51,_sicp_buf+13
4262                     ; 849 							st1.st_ges2_ctrl_action_value = sicp_buf[14];
4264  0213 55000f00ac    	mov	_st1+52,_sicp_buf+14
4265                     ; 851 							receipt_conf_gest1 = 1;
4267  0218 721000c5      	bset	_UART1Flag6_,#0
4268                     ; 852 							send_message_length = 6;
4270  021c 35060065      	mov	_send_message_length,#6
4271                     ; 853 							send_cmd = 0xAA;
4273  0220 35aa0064      	mov	_send_cmd,#170
4274                     ; 854 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4276  0224 4baa          	push	#170
4277  0226 4b06          	push	#6
4278  0228 3b006b        	push	_ns_host_meshid_L
4279  022b c6006c        	ld	a,_ns_host_meshid_H
4280  022e 97            	ld	xl,a
4281  022f c6006a        	ld	a,_rev_message_id
4282  0232 95            	ld	xh,a
4283  0233 cd0000        	call	_send_header_payload_init
4285  0236 5b03          	addw	sp,#3
4286                     ; 855 							UART2_Send_Data_Start();
4288  0238 cd0000        	call	_UART2_Send_Data_Start
4290                     ; 856 							break;
4292  023b acb206b2      	jpf	L5661
4293  023f               L5171:
4294                     ; 858 						else if((st1.st_ges3_ctrl_H == 0x11) && (st1.st_ges3_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges3_ctrl_H) && (sicp_buf[9] != st1.st_ges3_ctrl_L))//第三个预设置手势
4296  023f c6009e        	ld	a,_st1+38
4297  0242 a111          	cp	a,#17
4298  0244 2661          	jrne	L1271
4300  0246 c6009f        	ld	a,_st1+39
4301  0249 a111          	cp	a,#17
4302  024b 265a          	jrne	L1271
4304  024d c60009        	ld	a,_sicp_buf+8
4305  0250 c1009e        	cp	a,_st1+38
4306  0253 2752          	jreq	L1271
4308  0255 c6000a        	ld	a,_sicp_buf+9
4309  0258 c1009f        	cp	a,_st1+39
4310  025b 274a          	jreq	L1271
4311                     ; 860 							st1.st_ges3_ctrl_H						= sicp_buf[8];
4313  025d 550009009e    	mov	_st1+38,_sicp_buf+8
4314                     ; 861 							st1.st_ges3_ctrl_L						= sicp_buf[9];
4316  0262 55000a009f    	mov	_st1+39,_sicp_buf+9
4317                     ; 862 							st1.st_ges3_ctrl_meshid_H 		= sicp_buf[10];
4319  0267 55000b00a0    	mov	_st1+40,_sicp_buf+10
4320                     ; 863 							st1.st_ges3_ctrl_meshid_L 		= sicp_buf[11];
4322  026c 55000c00a1    	mov	_st1+41,_sicp_buf+11
4323                     ; 864 							st1.st_ges3_ctrl_boardid 			= sicp_buf[12];
4325  0271 55000d00a2    	mov	_st1+42,_sicp_buf+12
4326                     ; 865 							st1.st_ges3_ctrl_action				= sicp_buf[13];
4328  0276 55000e00ae    	mov	_st1+54,_sicp_buf+13
4329                     ; 866 							st1.st_ges3_ctrl_action_value = sicp_buf[14];
4331  027b 55000f00af    	mov	_st1+55,_sicp_buf+14
4332                     ; 868 							receipt_conf_gest1 = 1;
4334  0280 721000c5      	bset	_UART1Flag6_,#0
4335                     ; 869 							send_message_length = 6;
4337  0284 35060065      	mov	_send_message_length,#6
4338                     ; 870 							send_cmd = 0xAA;
4340  0288 35aa0064      	mov	_send_cmd,#170
4341                     ; 871 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4343  028c 4baa          	push	#170
4344  028e 4b06          	push	#6
4345  0290 3b006b        	push	_ns_host_meshid_L
4346  0293 c6006c        	ld	a,_ns_host_meshid_H
4347  0296 97            	ld	xl,a
4348  0297 c6006a        	ld	a,_rev_message_id
4349  029a 95            	ld	xh,a
4350  029b cd0000        	call	_send_header_payload_init
4352  029e 5b03          	addw	sp,#3
4353                     ; 872 							UART2_Send_Data_Start();
4355  02a0 cd0000        	call	_UART2_Send_Data_Start
4357                     ; 873 							break;
4359  02a3 acb206b2      	jpf	L5661
4360  02a7               L1271:
4361                     ; 875 						else if((st1.st_ges4_ctrl_H == 0x11) && (st1.st_ges4_ctrl_L == 0x11) &&(sicp_buf[8] != st1.st_ges4_ctrl_H) && (sicp_buf[9] != st1.st_ges4_ctrl_L))//第三个预设置手势
4363  02a7 c600a3        	ld	a,_st1+43
4364  02aa a111          	cp	a,#17
4365  02ac 2661          	jrne	L5271
4367  02ae c600a4        	ld	a,_st1+44
4368  02b1 a111          	cp	a,#17
4369  02b3 265a          	jrne	L5271
4371  02b5 c60009        	ld	a,_sicp_buf+8
4372  02b8 c100a3        	cp	a,_st1+43
4373  02bb 2752          	jreq	L5271
4375  02bd c6000a        	ld	a,_sicp_buf+9
4376  02c0 c100a4        	cp	a,_st1+44
4377  02c3 274a          	jreq	L5271
4378                     ; 877 							st1.st_ges4_ctrl_H						= sicp_buf[8];
4380  02c5 55000900a3    	mov	_st1+43,_sicp_buf+8
4381                     ; 878 							st1.st_ges4_ctrl_L						= sicp_buf[9];
4383  02ca 55000a00a4    	mov	_st1+44,_sicp_buf+9
4384                     ; 879 							st1.st_ges4_ctrl_meshid_H 		= sicp_buf[10];
4386  02cf 55000b00a5    	mov	_st1+45,_sicp_buf+10
4387                     ; 880 							st1.st_ges4_ctrl_meshid_L 		= sicp_buf[11];
4389  02d4 55000c00a6    	mov	_st1+46,_sicp_buf+11
4390                     ; 881 							st1.st_ges4_ctrl_boardid 			= sicp_buf[12];
4392  02d9 55000d00a7    	mov	_st1+47,_sicp_buf+12
4393                     ; 882 							st1.st_ges4_ctrl_action				= sicp_buf[13];
4395  02de 55000e00b1    	mov	_st1+57,_sicp_buf+13
4396                     ; 883 							st1.st_ges4_ctrl_action_value = sicp_buf[14];
4398  02e3 55000f00b2    	mov	_st1+58,_sicp_buf+14
4399                     ; 885 							receipt_conf_gest1 = 1;
4401  02e8 721000c5      	bset	_UART1Flag6_,#0
4402                     ; 886 							send_message_length = 6;
4404  02ec 35060065      	mov	_send_message_length,#6
4405                     ; 887 							send_cmd = 0xAA;
4407  02f0 35aa0064      	mov	_send_cmd,#170
4408                     ; 888 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4410  02f4 4baa          	push	#170
4411  02f6 4b06          	push	#6
4412  02f8 3b006b        	push	_ns_host_meshid_L
4413  02fb c6006c        	ld	a,_ns_host_meshid_H
4414  02fe 97            	ld	xl,a
4415  02ff c6006a        	ld	a,_rev_message_id
4416  0302 95            	ld	xh,a
4417  0303 cd0000        	call	_send_header_payload_init
4419  0306 5b03          	addw	sp,#3
4420                     ; 889 							UART2_Send_Data_Start();
4422  0308 cd0000        	call	_UART2_Send_Data_Start
4424                     ; 890 							break;
4426  030b acb206b2      	jpf	L5661
4427  030f               L5271:
4428                     ; 892 						else if(((sicp_buf[8] == st1.st_ges1_ctrl_H) && (sicp_buf[9] == st1.st_ges1_ctrl_L))
4428                     ; 893 										|| ((sicp_buf[8] == st1.st_ges2_ctrl_H) && (sicp_buf[9] == st1.st_ges2_ctrl_L))
4428                     ; 894 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L))
4428                     ; 895 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L)))
4430  030f c60009        	ld	a,_sicp_buf+8
4431  0312 c10094        	cp	a,_st1+28
4432  0315 2608          	jrne	L5371
4434  0317 c6000a        	ld	a,_sicp_buf+9
4435  031a c10095        	cp	a,_st1+29
4436  031d 2720          	jreq	L3371
4437  031f               L5371:
4439  031f c60009        	ld	a,_sicp_buf+8
4440  0322 c10099        	cp	a,_st1+33
4441  0325 2608          	jrne	L1471
4443  0327 c6000a        	ld	a,_sicp_buf+9
4444  032a c1009a        	cp	a,_st1+34
4445  032d 2710          	jreq	L3371
4446  032f               L1471:
4448  032f c60009        	ld	a,_sicp_buf+8
4449  0332 c1009e        	cp	a,_st1+38
4450  0335 262f          	jrne	L1371
4452  0337 c6000a        	ld	a,_sicp_buf+9
4453  033a c1009f        	cp	a,_st1+39
4454  033d 2627          	jrne	L1371
4455  033f               L3371:
4456                     ; 897 							receipt_conf_gest1 = 1;
4458  033f 721000c5      	bset	_UART1Flag6_,#0
4459                     ; 898 							send_message_length = 6;
4461  0343 35060065      	mov	_send_message_length,#6
4462                     ; 899 							send_cmd = 0xAA;
4464  0347 35aa0064      	mov	_send_cmd,#170
4465                     ; 900 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4467  034b 4baa          	push	#170
4468  034d 4b06          	push	#6
4469  034f 3b006b        	push	_ns_host_meshid_L
4470  0352 c6006c        	ld	a,_ns_host_meshid_H
4471  0355 97            	ld	xl,a
4472  0356 c6006a        	ld	a,_rev_message_id
4473  0359 95            	ld	xh,a
4474  035a cd0000        	call	_send_header_payload_init
4476  035d 5b03          	addw	sp,#3
4477                     ; 901 							UART2_Send_Data_Start();
4479  035f cd0000        	call	_UART2_Send_Data_Start
4481                     ; 902 							break;
4483  0362 acb206b2      	jpf	L5661
4484  0366               L1371:
4485                     ; 906 							receipt_conf_gest2 = 1;
4487  0366 721200c5      	bset	_UART1Flag6_,#1
4488                     ; 907 							send_message_length = 6;
4490  036a 35060065      	mov	_send_message_length,#6
4491                     ; 908 							send_cmd = 0xAA;
4493  036e 35aa0064      	mov	_send_cmd,#170
4494                     ; 909 							send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4496  0372 4baa          	push	#170
4497  0374 4b06          	push	#6
4498  0376 3b006b        	push	_ns_host_meshid_L
4499  0379 c6006c        	ld	a,_ns_host_meshid_H
4500  037c 97            	ld	xl,a
4501  037d c6006a        	ld	a,_rev_message_id
4502  0380 95            	ld	xh,a
4503  0381 cd0000        	call	_send_header_payload_init
4505  0384 5b03          	addw	sp,#3
4506                     ; 910 							UART2_Send_Data_Start();
4508  0386 cd0000        	call	_UART2_Send_Data_Start
4510                     ; 911 							break;
4512  0389 acb206b2      	jpf	L5661
4513  038d               L5751:
4514                     ; 916 			case 0xAA://SS回复ST的Device Info，Kick Out踢出
4514                     ; 917 				if (sicp_buf[7] == 0x04)
4516  038d c60008        	ld	a,_sicp_buf+7
4517  0390 a104          	cp	a,#4
4518  0392 2703          	jreq	L051
4519  0394 cc06b2        	jp	L5661
4520  0397               L051:
4521                     ; 919 					kickout_flag = 1;
4523  0397 721000c7      	bset	_UART1Flag4_,#0
4524  039b acb206b2      	jpf	L5661
4525  039f               L7751:
4526                     ; 928 			case 0xC0://BLE 网络模块重置指令
4526                     ; 929 				if (sicp_buf[7] == 0x02)
4529  039f c60008        	ld	a,_sicp_buf+7
4530  03a2 a102          	cp	a,#2
4531  03a4 2703          	jreq	L251
4532  03a6 cc06b2        	jp	L5661
4533  03a9               L251:
4534                     ; 931 					net_reset_flag = 1;
4536  03a9 721200c7      	bset	_UART1Flag4_,#1
4537  03ad acb206b2      	jpf	L5661
4538  03b1               L1061:
4539                     ; 934 			case 0x03://CMD-Data 
4539                     ; 935 				if (sicp_buf[7] == 0x01)//获取ST传感器信息
4541  03b1 c60008        	ld	a,_sicp_buf+7
4542  03b4 a101          	cp	a,#1
4543  03b6 262d          	jrne	L1571
4544                     ; 937 					if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32))
4546  03b8 c60009        	ld	a,_sicp_buf+8
4547  03bb a130          	cp	a,#48
4548  03bd 2626          	jrne	L1571
4550  03bf c6000a        	ld	a,_sicp_buf+9
4551  03c2 a132          	cp	a,#50
4552  03c4 261f          	jrne	L1571
4553                     ; 939 						send_message_length = 9;
4555  03c6 35090065      	mov	_send_message_length,#9
4556                     ; 940 						send_cmd = 0x20;
4558  03ca 35200064      	mov	_send_cmd,#32
4559                     ; 941 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4561  03ce 4b20          	push	#32
4562  03d0 4b09          	push	#9
4563  03d2 3b006b        	push	_ns_host_meshid_L
4564  03d5 c6006c        	ld	a,_ns_host_meshid_H
4565  03d8 97            	ld	xl,a
4566  03d9 c6006a        	ld	a,_rev_message_id
4567  03dc 95            	ld	xh,a
4568  03dd cd0000        	call	_send_header_payload_init
4570  03e0 5b03          	addw	sp,#3
4571                     ; 942 						UART2_Send_Data_Start();
4573  03e2 cd0000        	call	_UART2_Send_Data_Start
4575  03e5               L1571:
4576                     ; 945 				if (sicp_buf[7] == 0x02)//刷新ST传感器数据
4578  03e5 c60008        	ld	a,_sicp_buf+7
4579  03e8 a102          	cp	a,#2
4580  03ea 2623          	jrne	L5571
4581                     ; 947 					cmd_refresh_flag = 1;
4583  03ec 721400ca      	bset	_UART1Flag1_,#2
4584                     ; 948 					send_message_length = 6;
4586  03f0 35060065      	mov	_send_message_length,#6
4587                     ; 949 					send_cmd = 0xAA;
4589  03f4 35aa0064      	mov	_send_cmd,#170
4590                     ; 950 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4592  03f8 4baa          	push	#170
4593  03fa 4b06          	push	#6
4594  03fc 3b006b        	push	_ns_host_meshid_L
4595  03ff c6006c        	ld	a,_ns_host_meshid_H
4596  0402 97            	ld	xl,a
4597  0403 c6006a        	ld	a,_rev_message_id
4598  0406 95            	ld	xh,a
4599  0407 cd0000        	call	_send_header_payload_init
4601  040a 5b03          	addw	sp,#3
4602                     ; 951 					UART2_Send_Data_Start();
4604  040c cd0000        	call	_UART2_Send_Data_Start
4606  040f               L5571:
4607                     ; 953 				if (sicp_buf[7] == 0x03)//获取ST当前设备的状态(灯亮度、开关)
4609  040f c60008        	ld	a,_sicp_buf+7
4610  0412 a103          	cp	a,#3
4611  0414 2703          	jreq	L451
4612  0416 cc06b2        	jp	L5661
4613  0419               L451:
4614                     ; 955 					cmd_status_flag = 1;
4616  0419 721600ca      	bset	_UART1Flag1_,#3
4617                     ; 957 					send_message_length = 10;
4619  041d 350a0065      	mov	_send_message_length,#10
4620                     ; 958 					send_cmd = 0x06;
4622  0421 35060064      	mov	_send_cmd,#6
4623                     ; 959 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4625  0425 4b06          	push	#6
4626  0427 4b0a          	push	#10
4627  0429 3b006b        	push	_ns_host_meshid_L
4628  042c c6006c        	ld	a,_ns_host_meshid_H
4629  042f 97            	ld	xl,a
4630  0430 c6006a        	ld	a,_rev_message_id
4631  0433 95            	ld	xh,a
4632  0434 cd0000        	call	_send_header_payload_init
4634  0437 5b03          	addw	sp,#3
4635                     ; 960 					UART2_Send_Data_Start();
4637  0439 cd0000        	call	_UART2_Send_Data_Start
4639  043c acb206b2      	jpf	L5661
4640  0440               L3061:
4641                     ; 963 			case 0x56://打开或关闭ST开关
4641                     ; 964 				action_ctrlpad_flag = 1;
4643  0440 721800ca      	bset	_UART1Flag1_,#4
4644                     ; 966 				action_ctrl_address = st1.st_ctrl_address = sicp_buf[7];			
4646  0444 550008007b    	mov	_st1+3,_sicp_buf+7
4647  0449 55007b0000    	mov	_action_ctrl_address,_st1+3
4648                     ; 967 				if(((sicp_buf[7] & 0x01) == 0x01) && (st1.st_pad1_status != sicp_buf[8]))
4650  044e c60008        	ld	a,_sicp_buf+7
4651  0451 a401          	and	a,#1
4652  0453 a101          	cp	a,#1
4653  0455 2617          	jrne	L1671
4655  0457 c6007e        	ld	a,_st1+6
4656  045a c10009        	cp	a,_sicp_buf+8
4657  045d 270f          	jreq	L1671
4658                     ; 968 					{st_pad1_ctrl = 1;st_pad1_confirm = 1;st1.st_pad1_status = sicp_buf[8];action_ctrl_num++;}
4660  045f 721200c8      	bset	_UART1Flag3_,#1
4663  0463 721800c8      	bset	_UART1Flag3_,#4
4666  0467 550009007e    	mov	_st1+6,_sicp_buf+8
4669  046c 0c01          	inc	(OFST+0,sp)
4670  046e               L1671:
4671                     ; 969 				if(((sicp_buf[7] & 0x02) == 0x02) && (st1.st_pad2_status != sicp_buf[8]))
4673  046e c60008        	ld	a,_sicp_buf+7
4674  0471 a402          	and	a,#2
4675  0473 a102          	cp	a,#2
4676  0475 2617          	jrne	L3671
4678  0477 c6007f        	ld	a,_st1+7
4679  047a c10009        	cp	a,_sicp_buf+8
4680  047d 270f          	jreq	L3671
4681                     ; 970 					{st_pad2_ctrl = 1;st_pad2_confirm = 1;st1.st_pad2_status = sicp_buf[8];action_ctrl_num++;}
4683  047f 721400c8      	bset	_UART1Flag3_,#2
4686  0483 721a00c8      	bset	_UART1Flag3_,#5
4689  0487 550009007f    	mov	_st1+7,_sicp_buf+8
4692  048c 0c01          	inc	(OFST+0,sp)
4693  048e               L3671:
4694                     ; 971 				if(((sicp_buf[7] & 0x04) == 0x04) && (st1.st_pad3_status != sicp_buf[8]))
4696  048e c60008        	ld	a,_sicp_buf+7
4697  0491 a404          	and	a,#4
4698  0493 a104          	cp	a,#4
4699  0495 2617          	jrne	L5671
4701  0497 c60080        	ld	a,_st1+8
4702  049a c10009        	cp	a,_sicp_buf+8
4703  049d 270f          	jreq	L5671
4704                     ; 972 					{st_pad3_ctrl = 1;st_pad3_confirm = 1;st1.st_pad3_status = sicp_buf[8];action_ctrl_num++;}
4706  049f 721600c8      	bset	_UART1Flag3_,#3
4709  04a3 721c00c8      	bset	_UART1Flag3_,#6
4712  04a7 5500090080    	mov	_st1+8,_sicp_buf+8
4715  04ac 0c01          	inc	(OFST+0,sp)
4716  04ae               L5671:
4717                     ; 973 				if((sicp_buf[7] & 0x08) == 0x08)
4719  04ae c60008        	ld	a,_sicp_buf+7
4720  04b1 a408          	and	a,#8
4721  04b3 a108          	cp	a,#8
4722  04b5 2604          	jrne	L7671
4723                     ; 974 					st_led_ctrl = 1;
4725  04b7 721000c8      	bset	_UART1Flag3_,#0
4726  04bb               L7671:
4727                     ; 975 				st1.st_ctrl_value  = sicp_buf[8];
4729  04bb 550009007c    	mov	_st1+4,_sicp_buf+8
4730                     ; 977 				send_message_length = 10;
4732  04c0 350a0065      	mov	_send_message_length,#10
4733                     ; 978 				send_cmd = 0xAA;
4735  04c4 35aa0064      	mov	_send_cmd,#170
4736                     ; 979 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4738  04c8 4baa          	push	#170
4739  04ca 4b0a          	push	#10
4740  04cc 3b006b        	push	_ns_host_meshid_L
4741  04cf c6006c        	ld	a,_ns_host_meshid_H
4742  04d2 97            	ld	xl,a
4743  04d3 c6006a        	ld	a,_rev_message_id
4744  04d6 95            	ld	xh,a
4745  04d7 cd0000        	call	_send_header_payload_init
4747  04da 5b03          	addw	sp,#3
4748                     ; 981 				UART2_Send_Data_Start();
4750  04dc cd0000        	call	_UART2_Send_Data_Start
4752                     ; 982 				break;
4754  04df acb206b2      	jpf	L5661
4755  04e3               L5061:
4756                     ; 983 			case 0x09://LED控制
4756                     ; 984 				led_ctrl_flag = 1;
4758  04e3 721400c7      	bset	_UART1Flag4_,#2
4759                     ; 985 				switch(sicp_buf[7])
4761  04e7 c60008        	ld	a,_sicp_buf+7
4763                     ; 1052 						break;
4764  04ea a01f          	sub	a,#31
4765  04ec 271d          	jreq	L7061
4766  04ee a010          	sub	a,#16
4767  04f0 2768          	jreq	L1161
4768  04f2 a010          	sub	a,#16
4769  04f4 2603          	jrne	L651
4770  04f6 cc05b3        	jp	L3161
4771  04f9               L651:
4772  04f9 a010          	sub	a,#16
4773  04fb 2603          	jrne	L061
4774  04fd cc0602        	jp	L5161
4775  0500               L061:
4776  0500 a010          	sub	a,#16
4777  0502 2603          	jrne	L261
4778  0504 cc0629        	jp	L7161
4779  0507               L261:
4780  0507 acb206b2      	jpf	L5661
4781  050b               L7061:
4782                     ; 987 					case 0x1F://循环模式
4782                     ; 988 						st1.st_led_mode = 0x1F;
4784  050b 351f00b4      	mov	_st1+60,#31
4785                     ; 989 						st1.st_led_density = sicp_buf[8];
4787  050f 55000900b5    	mov	_st1+61,_sicp_buf+8
4788                     ; 990 						st1.st_led_speed = sicp_buf[9];
4790  0514 55000a00b6    	mov	_st1+62,_sicp_buf+9
4791                     ; 991 						st1.st_led_color1_H = sicp_buf[10];
4793  0519 55000b00b7    	mov	_st1+63,_sicp_buf+10
4794                     ; 992 						st1.st_led_color1_M = sicp_buf[11];
4796  051e 55000c00b8    	mov	_st1+64,_sicp_buf+11
4797                     ; 993 						st1.st_led_color1_L = sicp_buf[12];
4799  0523 55000d00b9    	mov	_st1+65,_sicp_buf+12
4800                     ; 994 						st1.st_led_color2_H = sicp_buf[13];
4802  0528 55000e00ba    	mov	_st1+66,_sicp_buf+13
4803                     ; 995 						st1.st_led_color2_M = sicp_buf[14];
4805  052d 55000f00bb    	mov	_st1+67,_sicp_buf+14
4806                     ; 996 						st1.st_led_color2_L = sicp_buf[15];
4808  0532 55001000bc    	mov	_st1+68,_sicp_buf+15
4809                     ; 997 						send_message_length = 6;
4811  0537 35060065      	mov	_send_message_length,#6
4812                     ; 998 						send_cmd = 0xAA;
4814  053b 35aa0064      	mov	_send_cmd,#170
4815                     ; 999 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4817  053f 4baa          	push	#170
4818  0541 4b06          	push	#6
4819  0543 3b006b        	push	_ns_host_meshid_L
4820  0546 c6006c        	ld	a,_ns_host_meshid_H
4821  0549 97            	ld	xl,a
4822  054a c6006a        	ld	a,_rev_message_id
4823  054d 95            	ld	xh,a
4824  054e cd0000        	call	_send_header_payload_init
4826  0551 5b03          	addw	sp,#3
4827                     ; 1001 						UART2_Send_Data_Start();
4829  0553 cd0000        	call	_UART2_Send_Data_Start
4831                     ; 1002 						break;
4833  0556 acb206b2      	jpf	L5661
4834  055a               L1161:
4835                     ; 1003 					case 0x2F://呼吸灯模式
4835                     ; 1004 						st1.st_led_mode = 0x2F;
4837  055a 352f00b4      	mov	_st1+60,#47
4838                     ; 1005 						st1.st_led_in		= sicp_buf[8];
4840  055e 55000900bd    	mov	_st1+69,_sicp_buf+8
4841                     ; 1006 						st1.st_led_duration = sicp_buf[9];
4843  0563 55000a00be    	mov	_st1+70,_sicp_buf+9
4844                     ; 1007 						st1.st_led_out	= sicp_buf[10];
4846  0568 55000b00bf    	mov	_st1+71,_sicp_buf+10
4847                     ; 1008 						st1.st_led_blank = sicp_buf[11];
4849  056d 55000c00c0    	mov	_st1+72,_sicp_buf+11
4850                     ; 1009 						st1.st_led_color1_H = sicp_buf[12];
4852  0572 55000d00b7    	mov	_st1+63,_sicp_buf+12
4853                     ; 1010 						st1.st_led_color1_M = sicp_buf[13];
4855  0577 55000e00b8    	mov	_st1+64,_sicp_buf+13
4856                     ; 1011 						st1.st_led_color1_L = sicp_buf[14];
4858  057c 55000f00b9    	mov	_st1+65,_sicp_buf+14
4859                     ; 1012 						st1.st_led_color2_H = sicp_buf[15];
4861  0581 55001000ba    	mov	_st1+66,_sicp_buf+15
4862                     ; 1013 						st1.st_led_color2_M = sicp_buf[16];
4864  0586 55001100bb    	mov	_st1+67,_sicp_buf+16
4865                     ; 1014 						st1.st_led_color2_L = sicp_buf[17];
4867  058b 55001200bc    	mov	_st1+68,_sicp_buf+17
4868                     ; 1015 						send_message_length = 6;
4870  0590 35060065      	mov	_send_message_length,#6
4871                     ; 1016 						send_cmd = 0xAA;
4873  0594 35aa0064      	mov	_send_cmd,#170
4874                     ; 1017 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4876  0598 4baa          	push	#170
4877  059a 4b06          	push	#6
4878  059c 3b006b        	push	_ns_host_meshid_L
4879  059f c6006c        	ld	a,_ns_host_meshid_H
4880  05a2 97            	ld	xl,a
4881  05a3 c6006a        	ld	a,_rev_message_id
4882  05a6 95            	ld	xh,a
4883  05a7 cd0000        	call	_send_header_payload_init
4885  05aa 5b03          	addw	sp,#3
4886                     ; 1019 						UART2_Send_Data_Start();
4888  05ac cd0000        	call	_UART2_Send_Data_Start
4890                     ; 1020 						break;
4892  05af acb206b2      	jpf	L5661
4893  05b3               L3161:
4894                     ; 1021 					case 0x3F://颜色变化模式，从一个主颜色渐变黑色再变到另一个主颜色
4894                     ; 1022 						st1.st_led_mode = 0x3F;
4896  05b3 353f00b4      	mov	_st1+60,#63
4897                     ; 1023 						st1.st_led_in		= sicp_buf[8];
4899  05b7 55000900bd    	mov	_st1+69,_sicp_buf+8
4900                     ; 1024 						st1.st_led_duration = sicp_buf[9];
4902  05bc 55000a00be    	mov	_st1+70,_sicp_buf+9
4903                     ; 1025 						st1.st_led_color1_H = sicp_buf[10];
4905  05c1 55000b00b7    	mov	_st1+63,_sicp_buf+10
4906                     ; 1026 						st1.st_led_color1_M = sicp_buf[11];
4908  05c6 55000c00b8    	mov	_st1+64,_sicp_buf+11
4909                     ; 1027 						st1.st_led_color1_L = sicp_buf[12];
4911  05cb 55000d00b9    	mov	_st1+65,_sicp_buf+12
4912                     ; 1028 						st1.st_led_color2_H = sicp_buf[13];
4914  05d0 55000e00ba    	mov	_st1+66,_sicp_buf+13
4915                     ; 1029 						st1.st_led_color2_M = sicp_buf[14];
4917  05d5 55000f00bb    	mov	_st1+67,_sicp_buf+14
4918                     ; 1030 						st1.st_led_color2_L = sicp_buf[15];
4920  05da 55001000bc    	mov	_st1+68,_sicp_buf+15
4921                     ; 1031 						send_message_length = 6;
4923  05df 35060065      	mov	_send_message_length,#6
4924                     ; 1032 						send_cmd = 0xAA;
4926  05e3 35aa0064      	mov	_send_cmd,#170
4927                     ; 1033 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4929  05e7 4baa          	push	#170
4930  05e9 4b06          	push	#6
4931  05eb 3b006b        	push	_ns_host_meshid_L
4932  05ee c6006c        	ld	a,_ns_host_meshid_H
4933  05f1 97            	ld	xl,a
4934  05f2 c6006a        	ld	a,_rev_message_id
4935  05f5 95            	ld	xh,a
4936  05f6 cd0000        	call	_send_header_payload_init
4938  05f9 5b03          	addw	sp,#3
4939                     ; 1035 						UART2_Send_Data_Start();
4941  05fb cd0000        	call	_UART2_Send_Data_Start
4943                     ; 1036 						break;
4945  05fe acb206b2      	jpf	L5661
4946  0602               L5161:
4947                     ; 1037 					case 0x4F://指示灯模式，把LED的显示权交给设备
4947                     ; 1038 						st1.st_led_mode = 0x4F;
4949  0602 354f00b4      	mov	_st1+60,#79
4950                     ; 1039 						send_message_length = 6;
4952  0606 35060065      	mov	_send_message_length,#6
4953                     ; 1040 						send_cmd = 0xAA;
4955  060a 35aa0064      	mov	_send_cmd,#170
4956                     ; 1041 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4958  060e 4baa          	push	#170
4959  0610 4b06          	push	#6
4960  0612 3b006b        	push	_ns_host_meshid_L
4961  0615 c6006c        	ld	a,_ns_host_meshid_H
4962  0618 97            	ld	xl,a
4963  0619 c6006a        	ld	a,_rev_message_id
4964  061c 95            	ld	xh,a
4965  061d cd0000        	call	_send_header_payload_init
4967  0620 5b03          	addw	sp,#3
4968                     ; 1043 						UART2_Send_Data_Start();
4970  0622 cd0000        	call	_UART2_Send_Data_Start
4972                     ; 1044 						break;
4974  0625 acb206b2      	jpf	L5661
4975  0629               L7161:
4976                     ; 1045 					case 0x5F://关闭模式。关闭所有LED显示 
4976                     ; 1046 						st1.st_led_mode = 0x5F;
4978  0629 355f00b4      	mov	_st1+60,#95
4979                     ; 1047 						send_message_length = 6;
4981  062d 35060065      	mov	_send_message_length,#6
4982                     ; 1048 						send_cmd = 0xAA;
4984  0631 35aa0064      	mov	_send_cmd,#170
4985                     ; 1049 						send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
4987  0635 4baa          	push	#170
4988  0637 4b06          	push	#6
4989  0639 3b006b        	push	_ns_host_meshid_L
4990  063c c6006c        	ld	a,_ns_host_meshid_H
4991  063f 97            	ld	xl,a
4992  0640 c6006a        	ld	a,_rev_message_id
4993  0643 95            	ld	xh,a
4994  0644 cd0000        	call	_send_header_payload_init
4996  0647 5b03          	addw	sp,#3
4997                     ; 1051 						UART2_Send_Data_Start();
4999  0649 cd0000        	call	_UART2_Send_Data_Start
5001                     ; 1052 						break;
5003  064c 2064          	jra	L5661
5004  064e               L3771:
5005                     ; 1054 				break;
5007  064e 2062          	jra	L5661
5008  0650               L1261:
5009                     ; 1055 			case 0x05://用于加载预装的报警信息，若此方法激活，则忽略所有 LED方法
5009                     ; 1056 				load_alert_flag = 1;
5011  0650 721600c7      	bset	_UART1Flag4_,#3
5012                     ; 1057 				st1.st_load_alert = sicp_buf[7];
5014  0654 55000800c1    	mov	_st1+73,_sicp_buf+7
5015                     ; 1058 				send_message_length = 6;
5017  0659 35060065      	mov	_send_message_length,#6
5018                     ; 1059 				send_cmd = 0xAA;
5020  065d 35aa0064      	mov	_send_cmd,#170
5021                     ; 1060 				send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5023  0661 4baa          	push	#170
5024  0663 4b06          	push	#6
5025  0665 3b006b        	push	_ns_host_meshid_L
5026  0668 c6006c        	ld	a,_ns_host_meshid_H
5027  066b 97            	ld	xl,a
5028  066c c6006a        	ld	a,_rev_message_id
5029  066f 95            	ld	xh,a
5030  0670 cd0000        	call	_send_header_payload_init
5032  0673 5b03          	addw	sp,#3
5033                     ; 1062 				UART2_Send_Data_Start();
5035  0675 cd0000        	call	_UART2_Send_Data_Start
5037                     ; 1063 				break;
5039  0678 2038          	jra	L5661
5040  067a               L3261:
5041                     ; 1064 			case 0xB0://Gateway	Mesh	ID	Broadcasting
5041                     ; 1065 				if(sicp_buf[2] == 0x9E){
5043  067a c60003        	ld	a,_sicp_buf+2
5044  067d a19e          	cp	a,#158
5045  067f 2631          	jrne	L5661
5046                     ; 1066 					rev_host_mesh = 1;receipt_host_mesh = 1;
5048  0681 721c00c9      	bset	_UART1Flag2_,#6
5051  0685 721400c5      	bset	_UART1Flag6_,#2
5052                     ; 1067 					ns_host_meshid_H = sicp_buf[3];
5054  0689 550004006c    	mov	_ns_host_meshid_H,_sicp_buf+3
5055                     ; 1068 					ns_host_meshid_L = sicp_buf[4];
5057  068e 550005006b    	mov	_ns_host_meshid_L,_sicp_buf+4
5058                     ; 1069 					send_message_length = 6;
5060  0693 35060065      	mov	_send_message_length,#6
5061                     ; 1070 					send_cmd = 0xAA;
5063  0697 35aa0064      	mov	_send_cmd,#170
5064                     ; 1071 					send_header_payload_init(rev_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5066  069b 4baa          	push	#170
5067  069d 4b06          	push	#6
5068  069f 3b006b        	push	_ns_host_meshid_L
5069  06a2 c6006c        	ld	a,_ns_host_meshid_H
5070  06a5 97            	ld	xl,a
5071  06a6 c6006a        	ld	a,_rev_message_id
5072  06a9 95            	ld	xh,a
5073  06aa cd0000        	call	_send_header_payload_init
5075  06ad 5b03          	addw	sp,#3
5076                     ; 1072 					UART2_Send_Data_Start();
5078  06af cd0000        	call	_UART2_Send_Data_Start
5080  06b2               L5261:
5081                     ; 1075 			default:
5081                     ; 1076 				break;
5083  06b2               L5661:
5084                     ; 1079 		return TRUE;
5086  06b2 a601          	ld	a,#1
5089  06b4 5b01          	addw	sp,#1
5090  06b6 81            	ret
5091  06b7               L1661:
5092                     ; 1081 	else if (ble_ctrl_frame)
5094  06b7 c600ca        	ld	a,_UART1Flag1_
5095  06ba a540          	bcp	a,#64
5096  06bc 2760          	jreq	L1002
5097                     ; 1083 		ble_ctrl_frame = 0;
5099  06be 721d00ca      	bres	_UART1Flag1_,#6
5100                     ; 1084 		switch(sicp_buf[4])
5102  06c2 c60005        	ld	a,_sicp_buf+4
5104                     ; 1110 				break;
5105  06c5 4a            	dec	a
5106  06c6 2708          	jreq	L7261
5107  06c8 4a            	dec	a
5108  06c9 2724          	jreq	L1361
5109  06cb 4a            	dec	a
5110  06cc 2729          	jreq	L3361
5111  06ce 2049          	jra	L5002
5112  06d0               L7261:
5113                     ; 1086 			case 0x01://网络状态帧
5113                     ; 1087 				rev_bleheartbeat = 1;
5115  06d0 721e00ca      	bset	_UART1Flag1_,#7
5116                     ; 1088 				ns_signal = sicp_buf[5];
5118  06d4 5500060071    	mov	_ns_signal,_sicp_buf+5
5119                     ; 1089 				ns_status = sicp_buf[6];
5121  06d9 5500070070    	mov	_ns_status,_sicp_buf+6
5122                     ; 1090 				ns_phonenum = sicp_buf[7];
5124  06de 550008006f    	mov	_ns_phonenum,_sicp_buf+7
5125                     ; 1091 				ns_own_meshid_H = sicp_buf[8];
5127  06e3 550009006e    	mov	_ns_own_meshid_H,_sicp_buf+8
5128                     ; 1092 				ns_own_meshid_L = sicp_buf[9];
5130  06e8 55000a006d    	mov	_ns_own_meshid_L,_sicp_buf+9
5131                     ; 1095 				break;
5133  06ed 202a          	jra	L5002
5134  06ef               L1361:
5135                     ; 1096 			case 0x02://重置芯片，清空串口缓存，保留mesh连接
5135                     ; 1097 				Variable_Init();
5137  06ef cd0000        	call	_Variable_Init
5139                     ; 1098 				clear_sicp_buf();
5141  06f2 cd0000        	call	_clear_sicp_buf
5143                     ; 1099 				break;
5145  06f5 2022          	jra	L5002
5146  06f7               L3361:
5147                     ; 1100 			case 0x03://重置芯片和网络，退出mesh连接
5147                     ; 1101 				Variable_Init();
5149  06f7 cd0000        	call	_Variable_Init
5151                     ; 1102 				clear_sicp_buf();
5153  06fa cd0000        	call	_clear_sicp_buf
5155                     ; 1103 				ns_signal = 0x00;
5157  06fd 725f0071      	clr	_ns_signal
5158                     ; 1104 				ns_status = 0x00;
5160  0701 725f0070      	clr	_ns_status
5161                     ; 1105 				ns_phonenum = 0x00;
5163  0705 725f006f      	clr	_ns_phonenum
5164                     ; 1106 				ns_own_meshid_H = 0x00;
5166  0709 725f006e      	clr	_ns_own_meshid_H
5167                     ; 1107 				ns_own_meshid_L = 0x00;
5169  070d 725f006d      	clr	_ns_own_meshid_L
5170                     ; 1108 				ns_host_meshid_H = 0x80;
5172  0711 3580006c      	mov	_ns_host_meshid_H,#128
5173                     ; 1109 				ns_host_meshid_L = 0xFF;
5175  0715 35ff006b      	mov	_ns_host_meshid_L,#255
5176                     ; 1110 				break;
5178  0719               L5002:
5179                     ; 1141 		return TRUE;
5181  0719 a601          	ld	a,#1
5184  071b 5b01          	addw	sp,#1
5185  071d 81            	ret
5186  071e               L1002:
5187                     ; 1145 		return FALSE;
5189  071e 4f            	clr	a
5192  071f 5b01          	addw	sp,#1
5193  0721 81            	ret
5248                     ; 1154 void reve_analyze_reply(void)
5248                     ; 1155 {
5249                     .text:	section	.text,new
5250  0000               _reve_analyze_reply:
5252  0000 89            	pushw	x
5253       00000002      OFST:	set	2
5256                     ; 1156 	if (rev_success)
5258  0001 c600ca        	ld	a,_UART1Flag1_
5259  0004 a501          	bcp	a,#1
5260  0006 271b          	jreq	L1202
5261                     ; 1158 		rev_success = 0;
5263  0008 721100ca      	bres	_UART1Flag1_,#0
5264                     ; 1159 		rev_header_anaylze(&rev_message_id,&rev_meshid_H,&rev_meshid_L,&rev_message_length);
5266  000c ae0068        	ldw	x,#_rev_message_length
5267  000f 89            	pushw	x
5268  0010 ae0066        	ldw	x,#_rev_meshid_L
5269  0013 89            	pushw	x
5270  0014 ae0067        	ldw	x,#_rev_meshid_H
5271  0017 89            	pushw	x
5272  0018 ae006a        	ldw	x,#_rev_message_id
5273  001b cd0000        	call	_rev_header_anaylze
5275  001e 5b06          	addw	sp,#6
5276                     ; 1160 		rev_payload_anaylze();
5278  0020 cd0000        	call	_rev_payload_anaylze
5280  0023               L1202:
5281                     ; 1168 	if (receipt_send_failed)
5283  0023 c600c6        	ld	a,_UART1Flag5_
5284  0026 a520          	bcp	a,#32
5285  0028 273a          	jreq	L3202
5286                     ; 1170 		receipt_send_failed = 0;
5288  002a 721b00c6      	bres	_UART1Flag5_,#5
5289                     ; 1171 		st_pad1_ctrl = st_pad_temp._flag_bit.bit0;
5291                     	btst		_st_pad_temp,#0
5292  0033 901300c8      	bccm	_UART1Flag3_,#1
5293                     ; 1172 		st_pad2_ctrl = st_pad_temp._flag_bit.bit1;
5295                     	btst		_st_pad_temp,#1
5296  003c 901500c8      	bccm	_UART1Flag3_,#2
5297                     ; 1173 		st_pad3_ctrl = st_pad_temp._flag_bit.bit2;
5299                     	btst		_st_pad_temp,#2
5300  0045 901700c8      	bccm	_UART1Flag3_,#3
5301                     ; 1174 		st_pad1_confirm = st_pad_temp._flag_bit.bit3;
5303                     	btst		_st_pad_temp,#3
5304  004e 901900c8      	bccm	_UART1Flag3_,#4
5305                     ; 1175 		st_pad2_confirm = st_pad_temp._flag_bit.bit4;
5307                     	btst		_st_pad_temp,#4
5308  0057 901b00c8      	bccm	_UART1Flag3_,#5
5309                     ; 1176 		st_pad3_confirm = st_pad_temp._flag_bit.bit5;
5311                     	btst		_st_pad_temp,#5
5312  0060 901d00c8      	bccm	_UART1Flag3_,#6
5313  0064               L3202:
5314                     ; 1179 	if (receipt_send_failed)
5316  0064 c600c6        	ld	a,_UART1Flag5_
5317  0067 a520          	bcp	a,#32
5318  0069 270e          	jreq	L5202
5319                     ; 1181 		receipt_send_failed = 0;
5321  006b 721b00c6      	bres	_UART1Flag5_,#5
5322                     ; 1182 		st1.st_ges_H = st1_st_ges_H_temp;
5324  006f 5500c40078    	mov	_st1,_st1_st_ges_H_temp
5325                     ; 1183 		st1.st_ges_L = st1_st_ges_L_temp;
5327  0074 5500c30079    	mov	_st1+1,_st1_st_ges_L_temp
5328  0079               L5202:
5329                     ; 1186 	if (st_pad1_ctrl | st_pad2_ctrl | st_pad3_ctrl)
5331  0079 4f            	clr	a
5332                     	btst	_UART1Flag3_,#3
5333  007f 49            	rlc	a
5334  0080 6b02          	ld	(OFST+0,sp),a
5335  0082 4f            	clr	a
5336                     	btst	_UART1Flag3_,#2
5337  0088 49            	rlc	a
5338  0089 6b01          	ld	(OFST-1,sp),a
5339  008b c600c8        	ld	a,_UART1Flag3_
5340  008e 44            	srl	a
5341  008f a401          	and	a,#1
5342  0091 1a01          	or	a,(OFST-1,sp)
5343  0093 1a02          	or	a,(OFST+0,sp)
5344  0095 2603          	jrne	L661
5345  0097 cc02c6        	jp	L7202
5346  009a               L661:
5347                     ; 1189 		if(st_pad1_confirm | st_pad2_confirm | st_pad3_confirm)
5349  009a 4f            	clr	a
5350                     	btst	_UART1Flag3_,#6
5351  00a0 49            	rlc	a
5352  00a1 6b02          	ld	(OFST+0,sp),a
5353  00a3 4f            	clr	a
5354                     	btst	_UART1Flag3_,#5
5355  00a9 49            	rlc	a
5356  00aa 6b01          	ld	(OFST-1,sp),a
5357  00ac 4f            	clr	a
5358                     	btst	_UART1Flag3_,#4
5359  00b2 49            	rlc	a
5360  00b3 1a01          	or	a,(OFST-1,sp)
5361  00b5 1a02          	or	a,(OFST+0,sp)
5362  00b7 2603          	jrne	L071
5363  00b9 cc0234        	jp	L1302
5364  00bc               L071:
5365                     ; 1191 			delay(200);
5367  00bc ae00c8        	ldw	x,#200
5368  00bf cd0000        	call	_delay
5370                     ; 1192 			st_pad_temp._flag_bit.bit0 = st_pad1_ctrl;
5372                     	btst		_UART1Flag3_,#1
5373  00c7 901100c2      	bccm	_st_pad_temp,#0
5374                     ; 1193 			st_pad_temp._flag_bit.bit1 = st_pad2_ctrl;
5376                     	btst		_UART1Flag3_,#2
5377  00d0 901300c2      	bccm	_st_pad_temp,#1
5378                     ; 1194 			st_pad_temp._flag_bit.bit2 = st_pad3_ctrl;
5380                     	btst		_UART1Flag3_,#3
5381  00d9 901500c2      	bccm	_st_pad_temp,#2
5382                     ; 1195 			st_pad_temp._flag_bit.bit3 = st_pad1_confirm;
5384                     	btst		_UART1Flag3_,#4
5385  00e2 901700c2      	bccm	_st_pad_temp,#3
5386                     ; 1196 			st_pad_temp._flag_bit.bit4 = st_pad2_confirm;
5388                     	btst		_UART1Flag3_,#5
5389  00eb 901900c2      	bccm	_st_pad_temp,#4
5390                     ; 1197 			st_pad_temp._flag_bit.bit5 = st_pad3_confirm;
5392                     	btst		_UART1Flag3_,#6
5393  00f4 901b00c2      	bccm	_st_pad_temp,#5
5394                     ; 1200 				pad_set_message_id = 0x9F;//固定为0x9F
5396  00f8 359f0073      	mov	_pad_set_message_id,#159
5397                     ; 1203 				if (st_pad1_confirm)//预设置按键1被触发
5399  00fc c600c8        	ld	a,_UART1Flag3_
5400  00ff a510          	bcp	a,#16
5401  0101 275d          	jreq	L3302
5402                     ; 1205 					send_message_length = 8;
5404  0103 35080065      	mov	_send_message_length,#8
5405                     ; 1206 					send_cmd = st1.st_pad1_ctrl_action;
5407  0107 5500880064    	mov	_send_cmd,_st1+16
5408                     ; 1207 					st_pad1_ctrl = 0;
5410  010c 721300c8      	bres	_UART1Flag3_,#1
5411                     ; 1208 					send_header_payload_init(pad_set_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
5413  0110 3b0064        	push	_send_cmd
5414  0113 4b08          	push	#8
5415  0115 3b0086        	push	_st1+14
5416  0118 c60085        	ld	a,_st1+13
5417  011b 97            	ld	xl,a
5418  011c a69f          	ld	a,#159
5419  011e 95            	ld	xh,a
5420  011f cd0000        	call	_send_header_payload_init
5422  0122 5b03          	addw	sp,#3
5423                     ; 1209 					UART2_Send_Data_Start();
5425  0124 cd0000        	call	_UART2_Send_Data_Start
5427                     ; 1210 					delay(200);
5429  0127 ae00c8        	ldw	x,#200
5430  012a cd0000        	call	_delay
5432                     ; 1212 					clear_send_buf();
5434  012d cd0000        	call	_clear_send_buf
5436                     ; 1213 					send_message_length = 14;
5438  0130 350e0065      	mov	_send_message_length,#14
5439                     ; 1214 					send_cmd = 0x08;
5441  0134 35080064      	mov	_send_cmd,#8
5442                     ; 1215 					if (st_pad1_confirm)//预设置按键1被触发
5444  0138 c600c8        	ld	a,_UART1Flag3_
5445  013b a510          	bcp	a,#16
5446  013d 2721          	jreq	L3302
5447                     ; 1217 						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5449  013f 4b08          	push	#8
5450  0141 4b0e          	push	#14
5451  0143 3b006b        	push	_ns_host_meshid_L
5452  0146 c6006c        	ld	a,_ns_host_meshid_H
5453  0149 97            	ld	xl,a
5454  014a c60073        	ld	a,_pad_set_message_id
5455  014d 95            	ld	xh,a
5456  014e cd0000        	call	_send_header_payload_init
5458  0151 5b03          	addw	sp,#3
5459                     ; 1218 						st_pad1_confirm = 0;
5461  0153 721900c8      	bres	_UART1Flag3_,#4
5462                     ; 1219 						UART2_Send_Data_Start();
5464  0157 cd0000        	call	_UART2_Send_Data_Start
5466                     ; 1220 						delay(200);
5468  015a ae00c8        	ldw	x,#200
5469  015d cd0000        	call	_delay
5471  0160               L3302:
5472                     ; 1223 				if (st_pad2_confirm)
5474  0160 c600c8        	ld	a,_UART1Flag3_
5475  0163 a520          	bcp	a,#32
5476  0165 275e          	jreq	L7302
5477                     ; 1225 					send_message_length = 8;
5479  0167 35080065      	mov	_send_message_length,#8
5480                     ; 1226 					send_cmd = st1.st_pad2_ctrl_action;
5482  016b 55008d0064    	mov	_send_cmd,_st1+21
5483                     ; 1227 					st_pad2_ctrl = 0;
5485  0170 721500c8      	bres	_UART1Flag3_,#2
5486                     ; 1228 					send_header_payload_init(pad_set_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
5488  0174 3b0064        	push	_send_cmd
5489  0177 4b08          	push	#8
5490  0179 3b008b        	push	_st1+19
5491  017c c6008a        	ld	a,_st1+18
5492  017f 97            	ld	xl,a
5493  0180 c60073        	ld	a,_pad_set_message_id
5494  0183 95            	ld	xh,a
5495  0184 cd0000        	call	_send_header_payload_init
5497  0187 5b03          	addw	sp,#3
5498                     ; 1229 					UART2_Send_Data_Start();
5500  0189 cd0000        	call	_UART2_Send_Data_Start
5502                     ; 1230 					delay(200);
5504  018c ae00c8        	ldw	x,#200
5505  018f cd0000        	call	_delay
5507                     ; 1232 					clear_send_buf();
5509  0192 cd0000        	call	_clear_send_buf
5511                     ; 1233 					send_message_length = 14;
5513  0195 350e0065      	mov	_send_message_length,#14
5514                     ; 1234 					send_cmd = 0x08;
5516  0199 35080064      	mov	_send_cmd,#8
5517                     ; 1235 					if (st_pad2_confirm)
5519  019d c600c8        	ld	a,_UART1Flag3_
5520  01a0 a520          	bcp	a,#32
5521  01a2 2721          	jreq	L7302
5522                     ; 1238 						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5524  01a4 4b08          	push	#8
5525  01a6 4b0e          	push	#14
5526  01a8 3b006b        	push	_ns_host_meshid_L
5527  01ab c6006c        	ld	a,_ns_host_meshid_H
5528  01ae 97            	ld	xl,a
5529  01af c60073        	ld	a,_pad_set_message_id
5530  01b2 95            	ld	xh,a
5531  01b3 cd0000        	call	_send_header_payload_init
5533  01b6 5b03          	addw	sp,#3
5534                     ; 1239 						st_pad2_confirm = 0;
5536  01b8 721b00c8      	bres	_UART1Flag3_,#5
5537                     ; 1240 						UART2_Send_Data_Start();
5539  01bc cd0000        	call	_UART2_Send_Data_Start
5541                     ; 1241 						delay(200);
5543  01bf ae00c8        	ldw	x,#200
5544  01c2 cd0000        	call	_delay
5546  01c5               L7302:
5547                     ; 1245 				if (st_pad3_confirm)
5549  01c5 c600c8        	ld	a,_UART1Flag3_
5550  01c8 a540          	bcp	a,#64
5551  01ca 2603          	jrne	L271
5552  01cc cc02c6        	jp	L7202
5553  01cf               L271:
5554                     ; 1247 					send_message_length = 8;
5556  01cf 35080065      	mov	_send_message_length,#8
5557                     ; 1248 					send_cmd = st1.st_pad3_ctrl_action;
5559  01d3 5500920064    	mov	_send_cmd,_st1+26
5560                     ; 1249 					st_pad3_ctrl = 0;
5562  01d8 721700c8      	bres	_UART1Flag3_,#3
5563                     ; 1250 					send_header_payload_init(pad_set_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
5565  01dc 3b0064        	push	_send_cmd
5566  01df 4b08          	push	#8
5567  01e1 3b0090        	push	_st1+24
5568  01e4 c6008f        	ld	a,_st1+23
5569  01e7 97            	ld	xl,a
5570  01e8 c60073        	ld	a,_pad_set_message_id
5571  01eb 95            	ld	xh,a
5572  01ec cd0000        	call	_send_header_payload_init
5574  01ef 5b03          	addw	sp,#3
5575                     ; 1251 					UART2_Send_Data_Start();
5577  01f1 cd0000        	call	_UART2_Send_Data_Start
5579                     ; 1252 					delay(200);
5581  01f4 ae00c8        	ldw	x,#200
5582  01f7 cd0000        	call	_delay
5584                     ; 1254 					clear_send_buf();
5586  01fa cd0000        	call	_clear_send_buf
5588                     ; 1255 					send_message_length = 14;
5590  01fd 350e0065      	mov	_send_message_length,#14
5591                     ; 1256 					send_cmd = 0x08;
5593  0201 35080064      	mov	_send_cmd,#8
5594                     ; 1257 					if(st_pad3_confirm)
5596  0205 c600c8        	ld	a,_UART1Flag3_
5597  0208 a540          	bcp	a,#64
5598  020a 2603          	jrne	L471
5599  020c cc02c6        	jp	L7202
5600  020f               L471:
5601                     ; 1260 						send_header_payload_init(pad_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5603  020f 4b08          	push	#8
5604  0211 4b0e          	push	#14
5605  0213 3b006b        	push	_ns_host_meshid_L
5606  0216 c6006c        	ld	a,_ns_host_meshid_H
5607  0219 97            	ld	xl,a
5608  021a c60073        	ld	a,_pad_set_message_id
5609  021d 95            	ld	xh,a
5610  021e cd0000        	call	_send_header_payload_init
5612  0221 5b03          	addw	sp,#3
5613                     ; 1261 						st_pad3_confirm = 0;
5615  0223 721d00c8      	bres	_UART1Flag3_,#6
5616                     ; 1262 						UART2_Send_Data_Start();
5618  0227 cd0000        	call	_UART2_Send_Data_Start
5620                     ; 1263 						delay(200);
5622  022a ae00c8        	ldw	x,#200
5623  022d cd0000        	call	_delay
5625  0230 acc602c6      	jpf	L7202
5626  0234               L1302:
5627                     ; 1271 			generate_messageid = random(TIM4->CNTR);
5629  0234 c65344        	ld	a,21316
5630  0237 cd0000        	call	_random
5632  023a c70061        	ld	_generate_messageid,a
5633                     ; 1272 			pad_noset_message_id = generate_messageid;
5635  023d 5500610074    	mov	_pad_noset_message_id,_generate_messageid
5636                     ; 1273 			send_message_length = 7;
5638  0242 35070065      	mov	_send_message_length,#7
5639                     ; 1274 			send_cmd = 0x35;
5641  0246 35350064      	mov	_send_cmd,#53
5642                     ; 1275 			if (st_pad1_ctrl)
5644  024a c600c8        	ld	a,_UART1Flag3_
5645  024d a502          	bcp	a,#2
5646  024f 2721          	jreq	L1502
5647                     ; 1278 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5649  0251 4b35          	push	#53
5650  0253 4b07          	push	#7
5651  0255 3b006b        	push	_ns_host_meshid_L
5652  0258 c6006c        	ld	a,_ns_host_meshid_H
5653  025b 97            	ld	xl,a
5654  025c c60074        	ld	a,_pad_noset_message_id
5655  025f 95            	ld	xh,a
5656  0260 cd0000        	call	_send_header_payload_init
5658  0263 5b03          	addw	sp,#3
5659                     ; 1279 				st_pad1_ctrl = 0;
5661  0265 721300c8      	bres	_UART1Flag3_,#1
5662                     ; 1280 				UART2_Send_Data_Start();
5664  0269 cd0000        	call	_UART2_Send_Data_Start
5666                     ; 1281 				delay(200);
5668  026c ae00c8        	ldw	x,#200
5669  026f cd0000        	call	_delay
5671  0272               L1502:
5672                     ; 1283 			if (st_pad2_ctrl)
5674  0272 c600c8        	ld	a,_UART1Flag3_
5675  0275 a504          	bcp	a,#4
5676  0277 2723          	jreq	L3502
5677                     ; 1286 				send_header_payload_init(pad_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5679  0279 3b0064        	push	_send_cmd
5680  027c 3b0065        	push	_send_message_length
5681  027f 3b006b        	push	_ns_host_meshid_L
5682  0282 c6006c        	ld	a,_ns_host_meshid_H
5683  0285 97            	ld	xl,a
5684  0286 c60074        	ld	a,_pad_noset_message_id
5685  0289 95            	ld	xh,a
5686  028a cd0000        	call	_send_header_payload_init
5688  028d 5b03          	addw	sp,#3
5689                     ; 1287 				st_pad2_ctrl = 0;
5691  028f 721500c8      	bres	_UART1Flag3_,#2
5692                     ; 1288 				UART2_Send_Data_Start();
5694  0293 cd0000        	call	_UART2_Send_Data_Start
5696                     ; 1289 			delay(200);
5698  0296 ae00c8        	ldw	x,#200
5699  0299 cd0000        	call	_delay
5701  029c               L3502:
5702                     ; 1291 			if (st_pad3_ctrl)
5704  029c c600c8        	ld	a,_UART1Flag3_
5705  029f a508          	bcp	a,#8
5706  02a1 2723          	jreq	L7202
5707                     ; 1294 				send_header_payload_init(gesture_noset_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5709  02a3 3b0064        	push	_send_cmd
5710  02a6 3b0065        	push	_send_message_length
5711  02a9 3b006b        	push	_ns_host_meshid_L
5712  02ac c6006c        	ld	a,_ns_host_meshid_H
5713  02af 97            	ld	xl,a
5714  02b0 c60076        	ld	a,_gesture_noset_message_id
5715  02b3 95            	ld	xh,a
5716  02b4 cd0000        	call	_send_header_payload_init
5718  02b7 5b03          	addw	sp,#3
5719                     ; 1295 				st_pad3_ctrl = 0;
5721  02b9 721700c8      	bres	_UART1Flag3_,#3
5722                     ; 1296 				UART2_Send_Data_Start();
5724  02bd cd0000        	call	_UART2_Send_Data_Start
5726                     ; 1297 				delay(200);
5728  02c0 ae00c8        	ldw	x,#200
5729  02c3 cd0000        	call	_delay
5731  02c6               L7202:
5732                     ; 1306 	if(gest_detect){
5734  02c6 c600c9        	ld	a,_UART1Flag2_
5735  02c9 a501          	bcp	a,#1
5736  02cb 2603          	jrne	L671
5737  02cd cc0499        	jp	L7502
5738  02d0               L671:
5739                     ; 1307 		gest_detect = 0;
5741  02d0 721100c9      	bres	_UART1Flag2_,#0
5742                     ; 1308 		gest_confirm();
5744  02d4 cd0000        	call	_gest_confirm
5746                     ; 1309 		if ((st1.st_ges_H != 0x00) && (st1.st_ges_L != 0x00))
5748  02d7 725d0078      	tnz	_st1
5749  02db 2603          	jrne	L002
5750  02dd cc0499        	jp	L7502
5751  02e0               L002:
5753  02e0 725d0079      	tnz	_st1+1
5754  02e4 2603          	jrne	L202
5755  02e6 cc0499        	jp	L7502
5756  02e9               L202:
5757                     ; 1311 			st1_st_ges_H_temp = st1.st_ges_H;
5759  02e9 55007800c4    	mov	_st1_st_ges_H_temp,_st1
5760                     ; 1312 			st1_st_ges_L_temp = st1.st_ges_L;
5762  02ee 55007900c3    	mov	_st1_st_ges_L_temp,_st1+1
5763                     ; 1315 			if((!gest1_confirm) && (!gest2_confirm) && (!gest3_confirm) && (!gest4_confirm))
5765  02f3 c600c9        	ld	a,_UART1Flag2_
5766  02f6 a504          	bcp	a,#4
5767  02f8 2658          	jrne	L3602
5769  02fa c600c9        	ld	a,_UART1Flag2_
5770  02fd a508          	bcp	a,#8
5771  02ff 2651          	jrne	L3602
5773  0301 c600c9        	ld	a,_UART1Flag2_
5774  0304 a510          	bcp	a,#16
5775  0306 264a          	jrne	L3602
5777  0308 c600c9        	ld	a,_UART1Flag2_
5778  030b a520          	bcp	a,#32
5779  030d 2643          	jrne	L3602
5780                     ; 1317 				receipt_gesture1 = 0;//清除接收到该指令回执
5782  030f 721500c6      	bres	_UART1Flag5_,#2
5783                     ; 1318 				generate_messageid = random(TIM4->CNTR);
5785  0313 c65344        	ld	a,21316
5786  0316 cd0000        	call	_random
5788  0319 c70061        	ld	_generate_messageid,a
5789                     ; 1319 				gesture_noset_message_id = generate_messageid;
5791  031c 5500610076    	mov	_gesture_noset_message_id,_generate_messageid
5792                     ; 1321 				send_message_length = 8;
5794  0321 35080065      	mov	_send_message_length,#8
5795                     ; 1322 				send_cmd = 0x29;
5797  0325 35290064      	mov	_send_cmd,#41
5798                     ; 1323 				send_header_payload_init(gesture_noset_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5800  0329 4b29          	push	#41
5801  032b 4b08          	push	#8
5802  032d 3b006d        	push	_ns_own_meshid_L
5803  0330 c6006e        	ld	a,_ns_own_meshid_H
5804  0333 97            	ld	xl,a
5805  0334 c60076        	ld	a,_gesture_noset_message_id
5806  0337 95            	ld	xh,a
5807  0338 cd0000        	call	_send_header_payload_init
5809  033b 5b03          	addw	sp,#3
5810                     ; 1325 				UART2_Send_Data_Start();
5812  033d cd0000        	call	_UART2_Send_Data_Start
5814                     ; 1326 				delay(200);
5816  0340 ae00c8        	ldw	x,#200
5817  0343 cd0000        	call	_delay
5819                     ; 1327 				st1.st_ges_H = 0x00;
5821  0346 725f0078      	clr	_st1
5822                     ; 1328 				st1.st_ges_L = 0x00;
5824  034a 725f0079      	clr	_st1+1
5826  034e ac990499      	jpf	L7502
5827  0352               L3602:
5828                     ; 1332 				receipt_gesture2 = 0;//清除接收到该指令回执
5830  0352 721700c6      	bres	_UART1Flag5_,#3
5831                     ; 1333 				generate_messageid = random(TIM4->CNTR);
5833  0356 c65344        	ld	a,21316
5834  0359 cd0000        	call	_random
5836  035c c70061        	ld	_generate_messageid,a
5837                     ; 1334 				gesture_set_message_id = generate_messageid;
5839  035f 5500610075    	mov	_gesture_set_message_id,_generate_messageid
5840                     ; 1335 				send_message_length = 8;
5842  0364 35080065      	mov	_send_message_length,#8
5843                     ; 1337 				if (gest1_confirm)
5845  0368 c600c9        	ld	a,_UART1Flag2_
5846  036b a504          	bcp	a,#4
5847  036d 271c          	jreq	L7602
5848                     ; 1339 					send_cmd = st1.st_ges1_ctrl_action_value;
5850  036f 5500a90064    	mov	_send_cmd,_st1+49
5851                     ; 1340 					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
5853  0374 3b0064        	push	_send_cmd
5854  0377 4b08          	push	#8
5855  0379 3b0097        	push	_st1+31
5856  037c c60096        	ld	a,_st1+30
5857  037f 97            	ld	xl,a
5858  0380 c60075        	ld	a,_gesture_set_message_id
5859  0383 95            	ld	xh,a
5860  0384 cd0000        	call	_send_header_payload_init
5862  0387 5b03          	addw	sp,#3
5864  0389 2067          	jra	L1702
5865  038b               L7602:
5866                     ; 1342 				else if (gest2_confirm)
5868  038b c600c9        	ld	a,_UART1Flag2_
5869  038e a508          	bcp	a,#8
5870  0390 271c          	jreq	L3702
5871                     ; 1344 					send_cmd = st1.st_ges2_ctrl_action_value;
5873  0392 5500ac0064    	mov	_send_cmd,_st1+52
5874                     ; 1345 					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
5876  0397 3b0064        	push	_send_cmd
5877  039a 4b08          	push	#8
5878  039c 3b009c        	push	_st1+36
5879  039f c6009b        	ld	a,_st1+35
5880  03a2 97            	ld	xl,a
5881  03a3 c60061        	ld	a,_generate_messageid
5882  03a6 95            	ld	xh,a
5883  03a7 cd0000        	call	_send_header_payload_init
5885  03aa 5b03          	addw	sp,#3
5887  03ac 2044          	jra	L1702
5888  03ae               L3702:
5889                     ; 1347 				else if (gest3_confirm)
5891  03ae c600c9        	ld	a,_UART1Flag2_
5892  03b1 a510          	bcp	a,#16
5893  03b3 271c          	jreq	L7702
5894                     ; 1349 					send_cmd = st1.st_ges3_ctrl_action_value;
5896  03b5 5500af0064    	mov	_send_cmd,_st1+55
5897                     ; 1350 					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
5899  03ba 3b0064        	push	_send_cmd
5900  03bd 4b08          	push	#8
5901  03bf 3b00a1        	push	_st1+41
5902  03c2 c600a0        	ld	a,_st1+40
5903  03c5 97            	ld	xl,a
5904  03c6 c60061        	ld	a,_generate_messageid
5905  03c9 95            	ld	xh,a
5906  03ca cd0000        	call	_send_header_payload_init
5908  03cd 5b03          	addw	sp,#3
5910  03cf 2021          	jra	L1702
5911  03d1               L7702:
5912                     ; 1352 				else if (gest4_confirm)
5914  03d1 c600c9        	ld	a,_UART1Flag2_
5915  03d4 a520          	bcp	a,#32
5916  03d6 271a          	jreq	L1702
5917                     ; 1354 					send_cmd = st1.st_ges4_ctrl_action_value;
5919  03d8 5500b20064    	mov	_send_cmd,_st1+58
5920                     ; 1355 					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
5922  03dd 3b0064        	push	_send_cmd
5923  03e0 4b08          	push	#8
5924  03e2 3b00a6        	push	_st1+46
5925  03e5 c600a5        	ld	a,_st1+45
5926  03e8 97            	ld	xl,a
5927  03e9 c60061        	ld	a,_generate_messageid
5928  03ec 95            	ld	xh,a
5929  03ed cd0000        	call	_send_header_payload_init
5931  03f0 5b03          	addw	sp,#3
5932  03f2               L1702:
5933                     ; 1358 				UART2_Send_Data_Start();
5935  03f2 cd0000        	call	_UART2_Send_Data_Start
5937                     ; 1359 				delay(200);
5939  03f5 ae00c8        	ldw	x,#200
5940  03f8 cd0000        	call	_delay
5942                     ; 1362 				clear_send_buf();
5944  03fb cd0000        	call	_clear_send_buf
5946                     ; 1363 				send_message_length = 14;
5948  03fe 350e0065      	mov	_send_message_length,#14
5949                     ; 1364 				send_cmd = 0x08;
5951  0402 35080064      	mov	_send_cmd,#8
5952                     ; 1365 				if (gest1_confirm)
5954  0406 c600c9        	ld	a,_UART1Flag2_
5955  0409 a504          	bcp	a,#4
5956  040b 271a          	jreq	L5012
5957                     ; 1367 					send_header_payload_init(gesture_set_message_id,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5959  040d 4b08          	push	#8
5960  040f 4b0e          	push	#14
5961  0411 3b006b        	push	_ns_host_meshid_L
5962  0414 c6006c        	ld	a,_ns_host_meshid_H
5963  0417 97            	ld	xl,a
5964  0418 c60075        	ld	a,_gesture_set_message_id
5965  041b 95            	ld	xh,a
5966  041c cd0000        	call	_send_header_payload_init
5968  041f 5b03          	addw	sp,#3
5969                     ; 1368 					gest1_confirm = 0;
5971  0421 721500c9      	bres	_UART1Flag2_,#2
5973  0425 2061          	jra	L7012
5974  0427               L5012:
5975                     ; 1370 				else if (gest2_confirm)
5977  0427 c600c9        	ld	a,_UART1Flag2_
5978  042a a508          	bcp	a,#8
5979  042c 271a          	jreq	L1112
5980                     ; 1372 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
5982  042e 4b08          	push	#8
5983  0430 4b0e          	push	#14
5984  0432 3b006b        	push	_ns_host_meshid_L
5985  0435 c6006c        	ld	a,_ns_host_meshid_H
5986  0438 97            	ld	xl,a
5987  0439 c60061        	ld	a,_generate_messageid
5988  043c 95            	ld	xh,a
5989  043d cd0000        	call	_send_header_payload_init
5991  0440 5b03          	addw	sp,#3
5992                     ; 1373 					gest2_confirm = 0;
5994  0442 721700c9      	bres	_UART1Flag2_,#3
5996  0446 2040          	jra	L7012
5997  0448               L1112:
5998                     ; 1375 				else if (gest3_confirm)
6000  0448 c600c9        	ld	a,_UART1Flag2_
6001  044b a510          	bcp	a,#16
6002  044d 271a          	jreq	L5112
6003                     ; 1377 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
6005  044f 4b08          	push	#8
6006  0451 4b0e          	push	#14
6007  0453 3b006b        	push	_ns_host_meshid_L
6008  0456 c6006c        	ld	a,_ns_host_meshid_H
6009  0459 97            	ld	xl,a
6010  045a c60061        	ld	a,_generate_messageid
6011  045d 95            	ld	xh,a
6012  045e cd0000        	call	_send_header_payload_init
6014  0461 5b03          	addw	sp,#3
6015                     ; 1378 					gest3_confirm = 0;
6017  0463 721900c9      	bres	_UART1Flag2_,#4
6019  0467 201f          	jra	L7012
6020  0469               L5112:
6021                     ; 1380 				else if (gest4_confirm)
6023  0469 c600c9        	ld	a,_UART1Flag2_
6024  046c a520          	bcp	a,#32
6025  046e 2718          	jreq	L7012
6026                     ; 1382 					send_header_payload_init(generate_messageid,ns_host_meshid_H,ns_host_meshid_L,send_message_length,send_cmd);
6028  0470 4b08          	push	#8
6029  0472 4b0e          	push	#14
6030  0474 3b006b        	push	_ns_host_meshid_L
6031  0477 c6006c        	ld	a,_ns_host_meshid_H
6032  047a 97            	ld	xl,a
6033  047b c60061        	ld	a,_generate_messageid
6034  047e 95            	ld	xh,a
6035  047f cd0000        	call	_send_header_payload_init
6037  0482 5b03          	addw	sp,#3
6038                     ; 1383 					gest4_confirm = 0;
6040  0484 721b00c9      	bres	_UART1Flag2_,#5
6041  0488               L7012:
6042                     ; 1386 				UART2_Send_Data_Start();
6044  0488 cd0000        	call	_UART2_Send_Data_Start
6046                     ; 1387 				delay(200);
6048  048b ae00c8        	ldw	x,#200
6049  048e cd0000        	call	_delay
6051                     ; 1388 				st1.st_ges_H = 0x00;
6053  0491 725f0078      	clr	_st1
6054                     ; 1389 				st1.st_ges_L = 0x00;
6056  0495 725f0079      	clr	_st1+1
6057  0499               L7502:
6058                     ; 1396 	if ((st1.st_device_status & 0xFF) < 0xFF)//ST有故障,有0无1
6060  0499 9c            	rvf
6061  049a c6007a        	ld	a,_st1+2
6062  049d 5f            	clrw	x
6063  049e 97            	ld	xl,a
6064  049f a300ff        	cpw	x,#255
6065  04a2 2e3d          	jrsge	L3212
6066                     ; 1398 		send_fault_count++;
6068  04a4 ce005d        	ldw	x,_send_fault_count
6069  04a7 1c0001        	addw	x,#1
6070  04aa cf005d        	ldw	_send_fault_count,x
6071                     ; 1399 		if (send_fault_count >= 500)
6073  04ad ce005d        	ldw	x,_send_fault_count
6074  04b0 a301f4        	cpw	x,#500
6075  04b3 252c          	jrult	L3212
6076                     ; 1401 			send_fault_count = 0;
6078  04b5 5f            	clrw	x
6079  04b6 cf005d        	ldw	_send_fault_count,x
6080                     ; 1402 			generate_messageid = random(TIM4->CNTR);
6082  04b9 c65344        	ld	a,21316
6083  04bc cd0000        	call	_random
6085  04bf c70061        	ld	_generate_messageid,a
6086                     ; 1403 			send_message_length = 7;
6088  04c2 35070065      	mov	_send_message_length,#7
6089                     ; 1404 			send_cmd = 0x0A;
6091  04c6 350a0064      	mov	_send_cmd,#10
6092                     ; 1405 			send_header_payload_init(generate_messageid,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
6094  04ca 4b0a          	push	#10
6095  04cc 4b07          	push	#7
6096  04ce 3b006d        	push	_ns_own_meshid_L
6097  04d1 c6006e        	ld	a,_ns_own_meshid_H
6098  04d4 97            	ld	xl,a
6099  04d5 c60061        	ld	a,_generate_messageid
6100  04d8 95            	ld	xh,a
6101  04d9 cd0000        	call	_send_header_payload_init
6103  04dc 5b03          	addw	sp,#3
6104                     ; 1407 			UART2_Send_Data_Start();
6106  04de cd0000        	call	_UART2_Send_Data_Start
6108  04e1               L3212:
6109                     ; 1410 }
6112  04e1 85            	popw	x
6113  04e2 81            	ret
6126                     	xref	_memcpy
6127                     	xref	_UART2_ITConfig
6128                     	xref	_UART2_Cmd
6129                     	xref	_UART2_Init
6130                     	xref	_UART2_DeInit
6131                     	xref	_rand
6132                     	xref	_malloc
6133                     	xref	_free
6134                     	xdef	_gest_confirm
6135                     	xdef	_pad_confirm
6136                     	xdef	_rev_payload_anaylze
6137                     	xdef	_rev_header_anaylze
6138                     	xdef	_send_header_payload_init
6139                     	xdef	_reve_analyze_reply
6140                     	xdef	_random
6141                     	xdef	_rev_deal
6142                     	xdef	_Check_Sum
6143                     	xdef	_clear_send_buf
6144                     	xdef	_clear_sicp_buf
6145                     	xdef	_UART2_Send_Data_Start
6146                     	xdef	_UART2_Send_Data_Init
6147                     	xdef	_UART2_RX_ISR
6148                     	xdef	_UART2_TX_ISR
6149                     	xdef	_Init_uart2
6150                     	xdef	_deleteNodeFromUart2TxSLHead
6151                     	xdef	_addNodeToUart2TxSLLast
6152                     	switch	.bss
6153  0000               _action_ctrl_address:
6154  0000 00            	ds.b	1
6155                     	xdef	_action_ctrl_address
6156  0001               _sicp_buf:
6157  0001 000000000000  	ds.b	30
6158                     	xdef	_sicp_buf
6159  001f               _rev_buf:
6160  001f 000000000000  	ds.b	30
6161                     	xdef	_rev_buf
6162  003d               _send_buf:
6163  003d 000000000000  	ds.b	30
6164                     	xdef	_send_buf
6165  005b               _send_failed_count:
6166  005b 0000          	ds.b	2
6167                     	xdef	_send_failed_count
6168  005d               _send_fault_count:
6169  005d 0000          	ds.b	2
6170                     	xdef	_send_fault_count
6171  005f               _rev_count:
6172  005f 00            	ds.b	1
6173                     	xdef	_rev_count
6174  0060               _send_count:
6175  0060 00            	ds.b	1
6176                     	xdef	_send_count
6177  0061               _generate_messageid:
6178  0061 00            	ds.b	1
6179                     	xdef	_generate_messageid
6180  0062               _send_meshid_L:
6181  0062 00            	ds.b	1
6182                     	xdef	_send_meshid_L
6183  0063               _send_meshid_H:
6184  0063 00            	ds.b	1
6185                     	xdef	_send_meshid_H
6186  0064               _send_cmd:
6187  0064 00            	ds.b	1
6188                     	xdef	_send_cmd
6189  0065               _send_message_length:
6190  0065 00            	ds.b	1
6191                     	xdef	_send_message_length
6192  0066               _rev_meshid_L:
6193  0066 00            	ds.b	1
6194                     	xdef	_rev_meshid_L
6195  0067               _rev_meshid_H:
6196  0067 00            	ds.b	1
6197                     	xdef	_rev_meshid_H
6198  0068               _rev_message_length:
6199  0068 00            	ds.b	1
6200                     	xdef	_rev_message_length
6201  0069               _rev_module_id:
6202  0069 00            	ds.b	1
6203                     	xdef	_rev_module_id
6204  006a               _rev_message_id:
6205  006a 00            	ds.b	1
6206                     	xdef	_rev_message_id
6207  006b               _ns_host_meshid_L:
6208  006b 00            	ds.b	1
6209                     	xdef	_ns_host_meshid_L
6210  006c               _ns_host_meshid_H:
6211  006c 00            	ds.b	1
6212                     	xdef	_ns_host_meshid_H
6213  006d               _ns_own_meshid_L:
6214  006d 00            	ds.b	1
6215                     	xdef	_ns_own_meshid_L
6216  006e               _ns_own_meshid_H:
6217  006e 00            	ds.b	1
6218                     	xdef	_ns_own_meshid_H
6219  006f               _ns_phonenum:
6220  006f 00            	ds.b	1
6221                     	xdef	_ns_phonenum
6222  0070               _ns_status:
6223  0070 00            	ds.b	1
6224                     	xdef	_ns_status
6225  0071               _ns_signal:
6226  0071 00            	ds.b	1
6227                     	xdef	_ns_signal
6228  0072               _action_notify_message_id:
6229  0072 00            	ds.b	1
6230                     	xdef	_action_notify_message_id
6231  0073               _pad_set_message_id:
6232  0073 00            	ds.b	1
6233                     	xdef	_pad_set_message_id
6234  0074               _pad_noset_message_id:
6235  0074 00            	ds.b	1
6236                     	xdef	_pad_noset_message_id
6237  0075               _gesture_set_message_id:
6238  0075 00            	ds.b	1
6239                     	xdef	_gesture_set_message_id
6240  0076               _gesture_noset_message_id:
6241  0076 00            	ds.b	1
6242                     	xdef	_gesture_noset_message_id
6243  0077               _device_info_message_id:
6244  0077 00            	ds.b	1
6245                     	xdef	_device_info_message_id
6246  0078               _st1:
6247  0078 000000000000  	ds.b	74
6248                     	xdef	_st1
6249  00c2               _st_pad_temp:
6250  00c2 00            	ds.b	1
6251                     	xdef	_st_pad_temp
6252  00c3               _st1_st_ges_L_temp:
6253  00c3 00            	ds.b	1
6254                     	xdef	_st1_st_ges_L_temp
6255  00c4               _st1_st_ges_H_temp:
6256  00c4 00            	ds.b	1
6257                     	xdef	_st1_st_ges_H_temp
6258  00c5               _UART1Flag6_:
6259  00c5 00            	ds.b	1
6260                     	xdef	_UART1Flag6_
6261  00c6               _UART1Flag5_:
6262  00c6 00            	ds.b	1
6263                     	xdef	_UART1Flag5_
6264  00c7               _UART1Flag4_:
6265  00c7 00            	ds.b	1
6266                     	xdef	_UART1Flag4_
6267  00c8               _UART1Flag3_:
6268  00c8 00            	ds.b	1
6269                     	xdef	_UART1Flag3_
6270  00c9               _UART1Flag2_:
6271  00c9 00            	ds.b	1
6272                     	xdef	_UART1Flag2_
6273  00ca               _UART1Flag1_:
6274  00ca 00            	ds.b	1
6275                     	xdef	_UART1Flag1_
6276  00cb               _uart2TxSLLast:
6277  00cb 0000          	ds.b	2
6278                     	xdef	_uart2TxSLLast
6279  00cd               _uart2TxSLHead:
6280  00cd 0000          	ds.b	2
6281                     	xdef	_uart2TxSLHead
6282  00cf               _mutex2:
6283  00cf 00            	ds.b	1
6284                     	xdef	_mutex2
6285                     	xref	_Variable_Init
6286                     	xref	_delay
6287                     	xref.b	c_x
6288                     	xref.b	c_y
6308                     	xref	c_idiv
6309                     	end
