   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
1062                     ; 23 u8 random(u8 xxx)  
1062                     ; 24 {  
1064                     .text:	section	.text,new
1065  0000               _random:
1067  0000 88            	push	a
1068  0001 89            	pushw	x
1069       00000002      OFST:	set	2
1072                     ; 26   for(iii=0;iii<xxx;iii++)  
1074  0002 0f02          	clr	(OFST+0,sp)
1076  0004 2011          	jra	L715
1077  0006               L315:
1078                     ; 28     value = rand() % (MAX + 1- MIN) + MIN; //获取一个随机数1~255
1080  0006 cd0000        	call	_rand
1082  0009 90ae00ff      	ldw	y,#255
1083  000d cd0000        	call	c_idiv
1085  0010 51            	exgw	x,y
1086  0011 9f            	ld	a,xl
1087  0012 4c            	inc	a
1088  0013 6b01          	ld	(OFST-1,sp),a
1089                     ; 26   for(iii=0;iii<xxx;iii++)  
1091  0015 0c02          	inc	(OFST+0,sp)
1092  0017               L715:
1095  0017 7b02          	ld	a,(OFST+0,sp)
1096  0019 1103          	cp	a,(OFST+1,sp)
1097  001b 25e9          	jrult	L315
1098                     ; 30   return value;  
1100  001d 7b01          	ld	a,(OFST-1,sp)
1103  001f 5b03          	addw	sp,#3
1104  0021 81            	ret
1131                     ; 39 void Init_uart2(void)
1131                     ; 40 {
1132                     .text:	section	.text,new
1133  0000               _Init_uart2:
1137                     ; 41 	UART2_DeInit();
1139  0000 cd0000        	call	_UART2_DeInit
1141                     ; 43 	UART2_Init((u32)57600,UART2_WORDLENGTH_8D,UART2_STOPBITS_1,UART2_PARITY_NO,UART2_SYNCMODE_CLOCK_DISABLE,	UART2_MODE_TXRX_ENABLE);
1143  0003 4b0c          	push	#12
1144  0005 4b80          	push	#128
1145  0007 4b00          	push	#0
1146  0009 4b00          	push	#0
1147  000b 4b00          	push	#0
1148  000d aee100        	ldw	x,#57600
1149  0010 89            	pushw	x
1150  0011 ae0000        	ldw	x,#0
1151  0014 89            	pushw	x
1152  0015 cd0000        	call	_UART2_Init
1154  0018 5b09          	addw	sp,#9
1155                     ; 44 	UART2_ITConfig(UART2_IT_TC,ENABLE);//发送完成中断
1157  001a 4b01          	push	#1
1158  001c ae0266        	ldw	x,#614
1159  001f cd0000        	call	_UART2_ITConfig
1161  0022 84            	pop	a
1162                     ; 45 	UART2_ITConfig(UART2_IT_RXNE_OR,ENABLE);//接收非空中断
1164  0023 4b01          	push	#1
1165  0025 ae0205        	ldw	x,#517
1166  0028 cd0000        	call	_UART2_ITConfig
1168  002b 84            	pop	a
1169                     ; 46 	UART2_Cmd(ENABLE);//启用uart1接口
1171  002c a601          	ld	a,#1
1172  002e cd0000        	call	_UART2_Cmd
1174                     ; 47 }
1177  0031 81            	ret
1203                     ; 55 void UART2_Send_Data_Init(void)
1203                     ; 56 {
1204                     .text:	section	.text,new
1205  0000               _UART2_Send_Data_Init:
1209                     ; 57 	send_buf[0] = 0xAA;
1211  0000 35aa003c      	mov	_send_buf,#170
1212                     ; 58 	send_buf[1] = 0xAA;
1214  0004 35aa003d      	mov	_send_buf+1,#170
1215                     ; 59 	send_buf[2] = 0x11;
1217  0008 3511003e      	mov	_send_buf+2,#17
1218                     ; 60 	send_buf[3] = 0x22;
1220  000c 3522003f      	mov	_send_buf+3,#34
1221                     ; 61 	send_buf[4] = 13;	//帧头及校验码不计入内
1223  0010 350d0040      	mov	_send_buf+4,#13
1224                     ; 62 	send_buf[5] = 0x01;
1226  0014 35010041      	mov	_send_buf+5,#1
1227                     ; 63 	send_buf[6] = 0x02;
1229  0018 35020042      	mov	_send_buf+6,#2
1230                     ; 64 	send_buf[7] = 0x03;
1232  001c 35030043      	mov	_send_buf+7,#3
1233                     ; 65 	send_buf[8] = 0x04;
1235  0020 35040044      	mov	_send_buf+8,#4
1236                     ; 66 	send_buf[9] = 0x05;
1238  0024 35050045      	mov	_send_buf+9,#5
1239                     ; 67 	send_buf[10] = 0x06;
1241  0028 35060046      	mov	_send_buf+10,#6
1242                     ; 68 	send_buf[11] = 0x07;
1244  002c 35070047      	mov	_send_buf+11,#7
1245                     ; 69 	send_buf[12] = 0x08;
1247  0030 35080048      	mov	_send_buf+12,#8
1248                     ; 70 	send_buf[13] = 0x09;
1250  0034 35090049      	mov	_send_buf+13,#9
1251                     ; 71 	send_buf[14] = 0x0A;
1253  0038 350a004a      	mov	_send_buf+14,#10
1254                     ; 72 	send_buf[15] = Check_Sum(send_buf,15);
1256  003c 4b0f          	push	#15
1257  003e ae003c        	ldw	x,#_send_buf
1258  0041 cd0000        	call	_Check_Sum
1260  0044 5b01          	addw	sp,#1
1261  0046 c7004b        	ld	_send_buf+15,a
1262                     ; 74 }
1265  0049 81            	ret
1291                     ; 81 void UART2_Send_Data_Start(void)
1291                     ; 82 {
1292                     .text:	section	.text,new
1293  0000               _UART2_Send_Data_Start:
1297                     ; 83 	UART2->DR = send_buf[0];
1299  0000 55003c5241    	mov	21057,_send_buf
1300                     ; 84 	send_count = 1;
1302  0005 3501005f      	mov	_send_count,#1
1303                     ; 85 }
1306  0009 81            	ret
1339                     ; 88 void clear_sicp_buf(void)
1339                     ; 89 {
1340                     .text:	section	.text,new
1341  0000               _clear_sicp_buf:
1343  0000 88            	push	a
1344       00000001      OFST:	set	1
1347                     ; 91 	for (i=0;i<30;i++)
1349  0001 0f01          	clr	(OFST+0,sp)
1350  0003               L765:
1351                     ; 93 		sicp_buf[i] = 0;
1353  0003 7b01          	ld	a,(OFST+0,sp)
1354  0005 5f            	clrw	x
1355  0006 97            	ld	xl,a
1356  0007 724f0000      	clr	(_sicp_buf,x)
1357                     ; 91 	for (i=0;i<30;i++)
1359  000b 0c01          	inc	(OFST+0,sp)
1362  000d 7b01          	ld	a,(OFST+0,sp)
1363  000f a11e          	cp	a,#30
1364  0011 25f0          	jrult	L765
1365                     ; 95 }
1368  0013 84            	pop	a
1369  0014 81            	ret
1402                     ; 98 void clear_send_buf(void)
1402                     ; 99 {
1403                     .text:	section	.text,new
1404  0000               _clear_send_buf:
1406  0000 88            	push	a
1407       00000001      OFST:	set	1
1410                     ; 101 	for (i=0;i<30;i++)
1412  0001 0f01          	clr	(OFST+0,sp)
1413  0003               L116:
1414                     ; 103 		send_buf[i] = 0;
1416  0003 7b01          	ld	a,(OFST+0,sp)
1417  0005 5f            	clrw	x
1418  0006 97            	ld	xl,a
1419  0007 724f003c      	clr	(_send_buf,x)
1420                     ; 101 	for (i=0;i<30;i++)
1422  000b 0c01          	inc	(OFST+0,sp)
1425  000d 7b01          	ld	a,(OFST+0,sp)
1426  000f a11e          	cp	a,#30
1427  0011 25f0          	jrult	L116
1428                     ; 105 }
1431  0013 84            	pop	a
1432  0014 81            	ret
1458                     ; 113 @interrupt void UART2_TX_ISR(void)
1458                     ; 114 {
1459                     .text:	section	.text,new
1460  0000               _UART2_TX_ISR:
1463  0000 be00          	ldw	x,c_x
1464  0002 89            	pushw	x
1467                     ; 118 	UART2->SR &= ~0x40;//清除发送完成标志位
1469  0003 721d5240      	bres	21056,#6
1470                     ; 119 	if (send_count < send_buf[5]+3)
1472  0007 9c            	rvf
1473  0008 c6005f        	ld	a,_send_count
1474  000b 5f            	clrw	x
1475  000c 97            	ld	xl,a
1476  000d c60041        	ld	a,_send_buf+5
1477  0010 905f          	clrw	y
1478  0012 9097          	ld	yl,a
1479  0014 72a90003      	addw	y,#3
1480  0018 bf01          	ldw	c_x+1,x
1481  001a 90b301        	cpw	y,c_x+1
1482  001d 2d11          	jrsle	L726
1483                     ; 121 		UART2->DR = send_buf[send_count];
1485  001f c6005f        	ld	a,_send_count
1486  0022 5f            	clrw	x
1487  0023 97            	ld	xl,a
1488  0024 d6003c        	ld	a,(_send_buf,x)
1489  0027 c75241        	ld	21057,a
1490                     ; 122 		send_count++;
1492  002a 725c005f      	inc	_send_count
1494  002e 2008          	jra	L136
1495  0030               L726:
1496                     ; 126 		send_count = 0;
1498  0030 725f005f      	clr	_send_count
1499                     ; 127 		rev_count = 0;
1501  0034 725f005e      	clr	_rev_count
1502  0038               L136:
1503                     ; 129 }
1506  0038 85            	popw	x
1507  0039 bf00          	ldw	c_x,x
1508  003b 80            	iret
1532                     ; 137 @interrupt void UART2_RX_ISR(void)
1532                     ; 138 {
1533                     .text:	section	.text,new
1534  0000               _UART2_RX_ISR:
1537  0000 3b0002        	push	c_x+2
1538  0003 be00          	ldw	x,c_x
1539  0005 89            	pushw	x
1540  0006 3b0002        	push	c_y+2
1541  0009 be00          	ldw	x,c_y
1542  000b 89            	pushw	x
1545                     ; 139 	rev_deal();
1547  000c cd0000        	call	_rev_deal
1549                     ; 140 }
1552  000f 85            	popw	x
1553  0010 bf00          	ldw	c_y,x
1554  0012 320002        	pop	c_y+2
1555  0015 85            	popw	x
1556  0016 bf00          	ldw	c_x,x
1557  0018 320002        	pop	c_x+2
1558  001b 80            	iret
1614                     ; 148 u8 Check_Sum(u8 *buf,u8 length)
1614                     ; 149 {
1615                     .text:	section	.text,new
1616  0000               _Check_Sum:
1618  0000 89            	pushw	x
1619  0001 89            	pushw	x
1620       00000002      OFST:	set	2
1623                     ; 151 	u8 result = *buf++;
1625  0002 1e03          	ldw	x,(OFST+1,sp)
1626  0004 1c0001        	addw	x,#1
1627  0007 1f03          	ldw	(OFST+1,sp),x
1628  0009 1d0001        	subw	x,#1
1629  000c f6            	ld	a,(x)
1630  000d 6b01          	ld	(OFST-1,sp),a
1631                     ; 152 	for(i = 1;i < length;i++)
1633  000f a601          	ld	a,#1
1634  0011 6b02          	ld	(OFST+0,sp),a
1636  0013 2011          	jra	L376
1637  0015               L766:
1638                     ; 154 		result ^= *buf++;
1640  0015 1e03          	ldw	x,(OFST+1,sp)
1641  0017 1c0001        	addw	x,#1
1642  001a 1f03          	ldw	(OFST+1,sp),x
1643  001c 1d0001        	subw	x,#1
1644  001f 7b01          	ld	a,(OFST-1,sp)
1645  0021 f8            	xor	a,	(x)
1646  0022 6b01          	ld	(OFST-1,sp),a
1647                     ; 152 	for(i = 1;i < length;i++)
1649  0024 0c02          	inc	(OFST+0,sp)
1650  0026               L376:
1653  0026 7b02          	ld	a,(OFST+0,sp)
1654  0028 1107          	cp	a,(OFST+5,sp)
1655  002a 25e9          	jrult	L766
1656                     ; 156 	return result;
1658  002c 7b01          	ld	a,(OFST-1,sp)
1661  002e 5b04          	addw	sp,#4
1662  0030 81            	ret
1720                     ; 164 void rev_deal(void)
1720                     ; 165 {
1721                     .text:	section	.text,new
1722  0000               _rev_deal:
1724  0000 89            	pushw	x
1725       00000002      OFST:	set	2
1728                     ; 168 	temp = (u8)UART2->DR;
1730  0001 c65241        	ld	a,21057
1731  0004 6b02          	ld	(OFST+0,sp),a
1732                     ; 169 	rev_buf[rev_count] = temp;
1734  0006 c6005e        	ld	a,_rev_count
1735  0009 5f            	clrw	x
1736  000a 97            	ld	xl,a
1737  000b 7b02          	ld	a,(OFST+0,sp)
1738  000d d7001e        	ld	(_rev_buf,x),a
1739                     ; 170 	rev_count++;
1741  0010 725c005e      	inc	_rev_count
1742                     ; 171 	switch(rev_count)
1744  0014 c6005e        	ld	a,_rev_count
1746                     ; 230 			break;
1747  0017 4a            	dec	a
1748  0018 2722          	jreq	L776
1749  001a 4a            	dec	a
1750  001b 2739          	jreq	L107
1751  001d 4a            	dec	a
1752  001e 2603          	jrne	L03
1753  0020 cc011c        	jp	L737
1754  0023               L03:
1755  0023 4a            	dec	a
1756  0024 2603          	jrne	L23
1757  0026 cc011c        	jp	L737
1758  0029               L23:
1759  0029 4a            	dec	a
1760  002a 2603          	jrne	L43
1761  002c cc011c        	jp	L737
1762  002f               L43:
1763  002f               L117:
1764                     ; 188 		default:
1764                     ; 189 			if (rev_count > 30)//防止接收错误后溢出
1766  002f c6005e        	ld	a,_rev_count
1767  0032 a11f          	cp	a,#31
1768  0034 253a          	jrult	L547
1769                     ; 191 				rev_count = 0;
1771  0036 725f005e      	clr	_rev_count
1772  003a 2034          	jra	L547
1773  003c               L776:
1774                     ; 173 		case 1:
1774                     ; 174 			if ((temp != 0xEE) && (temp != 0xDD))	rev_count = 0;
1776  003c 7b02          	ld	a,(OFST+0,sp)
1777  003e a1ee          	cp	a,#238
1778  0040 2603          	jrne	L63
1779  0042 cc011c        	jp	L737
1780  0045               L63:
1782  0045 7b02          	ld	a,(OFST+0,sp)
1783  0047 a1dd          	cp	a,#221
1784  0049 2603          	jrne	L04
1785  004b cc011c        	jp	L737
1786  004e               L04:
1789  004e 725f005e      	clr	_rev_count
1790  0052 ac1c011c      	jpf	L737
1791  0056               L107:
1792                     ; 176 		case 2:
1792                     ; 177 			if ((temp != 0xEE) && (temp != 0xDD)) rev_count = 0;
1794  0056 7b02          	ld	a,(OFST+0,sp)
1795  0058 a1ee          	cp	a,#238
1796  005a 2603          	jrne	L24
1797  005c cc011c        	jp	L737
1798  005f               L24:
1800  005f 7b02          	ld	a,(OFST+0,sp)
1801  0061 a1dd          	cp	a,#221
1802  0063 2603          	jrne	L44
1803  0065 cc011c        	jp	L737
1804  0068               L44:
1807  0068 725f005e      	clr	_rev_count
1808  006c ac1c011c      	jpf	L737
1809  0070               L547:
1810                     ; 193 			if ((rev_buf[0] == 0xEE)&&(rev_buf[1] == 0xEE))
1812  0070 c6001e        	ld	a,_rev_buf
1813  0073 a1ee          	cp	a,#238
1814  0075 265f          	jrne	L747
1816  0077 c6001f        	ld	a,_rev_buf+1
1817  007a a1ee          	cp	a,#238
1818  007c 2658          	jrne	L747
1819                     ; 195 				if (rev_count > rev_buf[5] + 2)//接收数据完成
1821  007e 9c            	rvf
1822  007f c6005e        	ld	a,_rev_count
1823  0082 5f            	clrw	x
1824  0083 97            	ld	xl,a
1825  0084 c60023        	ld	a,_rev_buf+5
1826  0087 905f          	clrw	y
1827  0089 9097          	ld	yl,a
1828  008b 905c          	incw	y
1829  008d 905c          	incw	y
1830  008f bf01          	ldw	c_x+1,x
1831  0091 90b301        	cpw	y,c_x+1
1832  0094 2ecf          	jrsge	L737
1833                     ; 197 					rev_count = 0;
1835  0096 725f005e      	clr	_rev_count
1836                     ; 198 					check_sum = Check_Sum(rev_buf,rev_buf[5] + 2);
1838  009a c60023        	ld	a,_rev_buf+5
1839  009d ab02          	add	a,#2
1840  009f 88            	push	a
1841  00a0 ae001e        	ldw	x,#_rev_buf
1842  00a3 cd0000        	call	_Check_Sum
1844  00a6 5b01          	addw	sp,#1
1845  00a8 6b02          	ld	(OFST+0,sp),a
1846                     ; 200 					if (check_sum == rev_buf[rev_buf[5] + 2])//校验正确	
1848  00aa c60023        	ld	a,_rev_buf+5
1849  00ad 5f            	clrw	x
1850  00ae 97            	ld	xl,a
1851  00af d60020        	ld	a,(_rev_buf+2,x)
1852  00b2 1102          	cp	a,(OFST+0,sp)
1853  00b4 261a          	jrne	L357
1854                     ; 202 						rev_success = 1;
1856  00b6 721000c8      	bset	_UART1Flag1_,#0
1857                     ; 203 						for (i = 0;i < 30;i++)
1859  00ba 0f02          	clr	(OFST+0,sp)
1860  00bc               L557:
1861                     ; 205 							sicp_buf[i] = rev_buf[i];
1863  00bc 7b02          	ld	a,(OFST+0,sp)
1864  00be 5f            	clrw	x
1865  00bf 97            	ld	xl,a
1866  00c0 d6001e        	ld	a,(_rev_buf,x)
1867  00c3 d70000        	ld	(_sicp_buf,x),a
1868                     ; 203 						for (i = 0;i < 30;i++)
1870  00c6 0c02          	inc	(OFST+0,sp)
1873  00c8 7b02          	ld	a,(OFST+0,sp)
1874  00ca a11e          	cp	a,#30
1875  00cc 25ee          	jrult	L557
1877  00ce 204c          	jra	L737
1878  00d0               L357:
1879                     ; 210 						rev_count = 0;
1881  00d0 725f005e      	clr	_rev_count
1882  00d4 2046          	jra	L737
1883  00d6               L747:
1884                     ; 214 			else if((rev_buf[0] == 0xDD)&&(rev_buf[1] == 0xDD))
1886  00d6 c6001e        	ld	a,_rev_buf
1887  00d9 a1dd          	cp	a,#221
1888  00db 263b          	jrne	L767
1890  00dd c6001f        	ld	a,_rev_buf+1
1891  00e0 a1dd          	cp	a,#221
1892  00e2 2634          	jrne	L767
1893                     ; 216 				if (rev_count > rev_buf[3] + 1)//接收数据完成
1895  00e4 9c            	rvf
1896  00e5 c6005e        	ld	a,_rev_count
1897  00e8 5f            	clrw	x
1898  00e9 97            	ld	xl,a
1899  00ea c60021        	ld	a,_rev_buf+3
1900  00ed 905f          	clrw	y
1901  00ef 9097          	ld	yl,a
1902  00f1 905c          	incw	y
1903  00f3 bf01          	ldw	c_x+1,x
1904  00f5 90b301        	cpw	y,c_x+1
1905  00f8 2e22          	jrsge	L737
1906                     ; 218 					rev_count = 0;
1908  00fa 725f005e      	clr	_rev_count
1909                     ; 219 					rev_success = 1;
1911  00fe 721000c8      	bset	_UART1Flag1_,#0
1912                     ; 220 					for (i = 0;i < 30;i++)
1914  0102 0f02          	clr	(OFST+0,sp)
1915  0104               L377:
1916                     ; 222 						sicp_buf[i] = rev_buf[i];
1918  0104 7b02          	ld	a,(OFST+0,sp)
1919  0106 5f            	clrw	x
1920  0107 97            	ld	xl,a
1921  0108 d6001e        	ld	a,(_rev_buf,x)
1922  010b d70000        	ld	(_sicp_buf,x),a
1923                     ; 220 					for (i = 0;i < 30;i++)
1925  010e 0c02          	inc	(OFST+0,sp)
1928  0110 7b02          	ld	a,(OFST+0,sp)
1929  0112 a11e          	cp	a,#30
1930  0114 25ee          	jrult	L377
1931  0116 2004          	jra	L737
1932  0118               L767:
1933                     ; 228 				rev_count = 0;
1935  0118 725f005e      	clr	_rev_count
1936  011c               L737:
1937                     ; 232 	if (UART2->SR & 0x20) //|| (UART2->SR & UART2_SR_OR))
1939  011c c65240        	ld	a,21056
1940  011f a520          	bcp	a,#32
1941  0121 2707          	jreq	L3001
1942                     ; 234 		temp2 = UART2->DR;
1944  0123 7b01          	ld	a,(OFST-1,sp)
1945  0125 97            	ld	xl,a
1946  0126 c65241        	ld	a,21057
1947  0129 97            	ld	xl,a
1948  012a               L3001:
1949                     ; 247 }
1952  012a 85            	popw	x
1953  012b 81            	ret
1978                     ; 255 void gest_confirm(void)
1978                     ; 256 {
1979                     .text:	section	.text,new
1980  0000               _gest_confirm:
1984                     ; 257 	if ((st1.st_ges_H == st1.st_ges1_ctrl_H) && (st1.st_ges_L == st1.st_ges1_ctrl_L))
1986  0000 c60076        	ld	a,_st1
1987  0003 c10092        	cp	a,_st1+28
1988  0006 260e          	jrne	L5101
1990  0008 c60077        	ld	a,_st1+1
1991  000b c10093        	cp	a,_st1+29
1992  000e 2606          	jrne	L5101
1993                     ; 259 		gest1_confirm = 1;
1995  0010 721400c7      	bset	_UART1Flag2_,#2
1997  0014 2004          	jra	L7101
1998  0016               L5101:
1999                     ; 263 		gest1_confirm = 0;
2001  0016 721500c7      	bres	_UART1Flag2_,#2
2002  001a               L7101:
2003                     ; 265 	if ((st1.st_ges_H == st1.st_ges2_ctrl_H) && (st1.st_ges_L == st1.st_ges2_ctrl_L))
2005  001a c60076        	ld	a,_st1
2006  001d c10097        	cp	a,_st1+33
2007  0020 260e          	jrne	L1201
2009  0022 c60077        	ld	a,_st1+1
2010  0025 c10098        	cp	a,_st1+34
2011  0028 2606          	jrne	L1201
2012                     ; 267 		gest2_confirm = 1;
2014  002a 721600c7      	bset	_UART1Flag2_,#3
2016  002e 2004          	jra	L3201
2017  0030               L1201:
2018                     ; 271 		gest2_confirm = 0;
2020  0030 721700c7      	bres	_UART1Flag2_,#3
2021  0034               L3201:
2022                     ; 273 	if ((st1.st_ges_H == st1.st_ges3_ctrl_H) && (st1.st_ges_L == st1.st_ges3_ctrl_L))
2024  0034 c60076        	ld	a,_st1
2025  0037 c1009c        	cp	a,_st1+38
2026  003a 260e          	jrne	L5201
2028  003c c60077        	ld	a,_st1+1
2029  003f c1009d        	cp	a,_st1+39
2030  0042 2606          	jrne	L5201
2031                     ; 275 		gest3_confirm = 1;
2033  0044 721800c7      	bset	_UART1Flag2_,#4
2035  0048 2004          	jra	L7201
2036  004a               L5201:
2037                     ; 279 		gest3_confirm = 0;
2039  004a 721900c7      	bres	_UART1Flag2_,#4
2040  004e               L7201:
2041                     ; 281 	if((st1.st_ges_H == st1.st_ges4_ctrl_H) && (st1.st_ges_L == st1.st_ges4_ctrl_L))
2043  004e c60076        	ld	a,_st1
2044  0051 c100a1        	cp	a,_st1+43
2045  0054 260e          	jrne	L1301
2047  0056 c60077        	ld	a,_st1+1
2048  0059 c100a2        	cp	a,_st1+44
2049  005c 2606          	jrne	L1301
2050                     ; 283 		gest4_confirm = 1;
2052  005e 721a00c7      	bset	_UART1Flag2_,#5
2054  0062 2004          	jra	L3301
2055  0064               L1301:
2056                     ; 287 		gest4_confirm = 0;
2058  0064 721b00c7      	bres	_UART1Flag2_,#5
2059  0068               L3301:
2060                     ; 289 }
2063  0068 81            	ret
2088                     ; 297 void pad_confirm(void)
2088                     ; 298 {
2089                     .text:	section	.text,new
2090  0000               _pad_confirm:
2094                     ; 299 	if(st_pad1_ctrl)
2096  0000 c600c6        	ld	a,_UART1Flag3_
2097  0003 a502          	bcp	a,#2
2098  0005 2724          	jreq	L5401
2099                     ; 301 		if ((st1.st_pad1_ctrl_meshid_H != 0x00) && (st1.st_pad1_ctrl_meshid_L != 0x00) && (st1.st_pad1_ctrl_boardid != 0x00))
2101  0007 725d0083      	tnz	_st1+13
2102  000b 2716          	jreq	L7401
2104  000d 725d0084      	tnz	_st1+14
2105  0011 2710          	jreq	L7401
2107  0013 725d0085      	tnz	_st1+15
2108  0017 270a          	jreq	L7401
2109                     ; 303 			st_pad1_confirm = 1;
2111  0019 721800c6      	bset	_UART1Flag3_,#4
2112                     ; 304 			st1.st_ctrl_address = 0x01;
2114  001d 35010079      	mov	_st1+3,#1
2116  0021 2008          	jra	L5401
2117  0023               L7401:
2118                     ; 308 			st_pad1_confirm = 0;
2120  0023 721900c6      	bres	_UART1Flag3_,#4
2121                     ; 309 			st1.st_ctrl_address = 0x00;
2123  0027 725f0079      	clr	_st1+3
2124  002b               L5401:
2125                     ; 313 	if(st_pad2_ctrl)
2127  002b c600c6        	ld	a,_UART1Flag3_
2128  002e a504          	bcp	a,#4
2129  0030 2724          	jreq	L3501
2130                     ; 315 		if ((st1.st_pad2_ctrl_meshid_H != 0x00) && (st1.st_pad2_ctrl_meshid_L != 0x00) && (st1.st_pad2_ctrl_boardid != 0x00))
2132  0032 725d0088      	tnz	_st1+18
2133  0036 2716          	jreq	L5501
2135  0038 725d0089      	tnz	_st1+19
2136  003c 2710          	jreq	L5501
2138  003e 725d008a      	tnz	_st1+20
2139  0042 270a          	jreq	L5501
2140                     ; 317 			st_pad2_confirm = 1;
2142  0044 721a00c6      	bset	_UART1Flag3_,#5
2143                     ; 318 			st1.st_ctrl_address = 0x02;
2145  0048 35020079      	mov	_st1+3,#2
2147  004c 2008          	jra	L3501
2148  004e               L5501:
2149                     ; 322 			st_pad2_confirm = 0;
2151  004e 721b00c6      	bres	_UART1Flag3_,#5
2152                     ; 323 			st1.st_ctrl_address = 0x00;
2154  0052 725f0079      	clr	_st1+3
2155  0056               L3501:
2156                     ; 326 	if(st_pad3_ctrl)
2158  0056 c600c6        	ld	a,_UART1Flag3_
2159  0059 a508          	bcp	a,#8
2160  005b 2724          	jreq	L1601
2161                     ; 328 		if ((st1.st_pad3_ctrl_meshid_H != 0x00) && (st1.st_pad3_ctrl_meshid_L != 0x00) && (st1.st_pad3_ctrl_boardid != 0x00))
2163  005d 725d008d      	tnz	_st1+23
2164  0061 2716          	jreq	L3601
2166  0063 725d008e      	tnz	_st1+24
2167  0067 2710          	jreq	L3601
2169  0069 725d008f      	tnz	_st1+25
2170  006d 270a          	jreq	L3601
2171                     ; 330 			st_pad3_confirm = 1;
2173  006f 721c00c6      	bset	_UART1Flag3_,#6
2174                     ; 331 			st1.st_ctrl_address = 0x04;
2176  0073 35040079      	mov	_st1+3,#4
2178  0077 2008          	jra	L1601
2179  0079               L3601:
2180                     ; 335 			st_pad3_confirm = 0;
2182  0079 721d00c6      	bres	_UART1Flag3_,#6
2183                     ; 336 			st1.st_ctrl_address = 0x00;
2185  007d 725f0079      	clr	_st1+3
2186  0081               L1601:
2187                     ; 339 }
2190  0081 81            	ret
2260                     ; 346 void send_header_payload_init(u8 id,u8 mesh_id_H,u8 mesh_id_L,u8 len ,u8 cmd)
2260                     ; 347 {
2261                     .text:	section	.text,new
2262  0000               _send_header_payload_init:
2264  0000 89            	pushw	x
2265       00000000      OFST:	set	0
2268                     ; 348 	send_buf[0] = 0xEE;
2270  0001 35ee003c      	mov	_send_buf,#238
2271                     ; 349 	send_buf[1] = 0xEE;
2273  0005 35ee003d      	mov	_send_buf+1,#238
2274                     ; 350 	send_buf[2] = id;
2276  0009 9e            	ld	a,xh
2277  000a c7003e        	ld	_send_buf+2,a
2278                     ; 351 	send_buf[3] = mesh_id_H;
2280  000d 9f            	ld	a,xl
2281  000e c7003f        	ld	_send_buf+3,a
2282                     ; 352 	send_buf[4] = mesh_id_L;
2284  0011 7b05          	ld	a,(OFST+5,sp)
2285  0013 c70040        	ld	_send_buf+4,a
2286                     ; 353 	send_buf[5] = len;
2288  0016 7b06          	ld	a,(OFST+6,sp)
2289  0018 c70041        	ld	_send_buf+5,a
2290                     ; 355 	switch(cmd)
2292  001b 7b07          	ld	a,(OFST+7,sp)
2294                     ; 610 			break;
2295  001d a006          	sub	a,#6
2296  001f 2756          	jreq	L1701
2297  0021 a002          	sub	a,#2
2298  0023 2603          	jrne	L45
2299  0025 cc031d        	jp	L7011
2300  0028               L45:
2301  0028 a002          	sub	a,#2
2302  002a 2603          	jrne	L65
2303  002c cc0257        	jp	L3011
2304  002f               L65:
2305  002f a016          	sub	a,#22
2306  0031 2727          	jreq	L7601
2307  0033 a009          	sub	a,#9
2308  0035 2603          	jrne	L06
2309  0037 cc00cf        	jp	L3701
2310  003a               L06:
2311  003a a00c          	sub	a,#12
2312  003c 2603          	jrne	L26
2313  003e cc00e6        	jp	L5701
2314  0041               L26:
2315  0041 a01c          	sub	a,#28
2316  0043 2603          	jrne	L46
2317  0045 cc0269        	jp	L5011
2318  0048               L46:
2319  0048 a059          	sub	a,#89
2320  004a 2603          	jrne	L66
2321  004c cc012d        	jp	L7701
2322  004f               L66:
2323  004f a00a          	sub	a,#10
2324  0051 2603          	jrne	L07
2325  0053 cc0231        	jp	L1011
2326  0056               L07:
2327  0056 ac910491      	jpf	L7311
2328  005a               L7601:
2329                     ; 357 		case 0x20://回复环境光和环境颜色
2329                     ; 358 			send_buf[6] = cmd;
2331  005a 7b07          	ld	a,(OFST+7,sp)
2332  005c c70042        	ld	_send_buf+6,a
2333                     ; 359 			send_buf[7] = st1.st_ambient_light;
2335  005f 55007f0043    	mov	_send_buf+7,_st1+9
2336                     ; 360 			send_buf[8] = st1.st_color_sense_L;
2338  0064 5500820044    	mov	_send_buf+8,_st1+12
2339                     ; 361 			send_buf[9] = st1.st_color_sense_M;
2341  0069 5500810045    	mov	_send_buf+9,_st1+11
2342                     ; 362 			send_buf[10] = st1.st_color_sense_H;
2344  006e 5500800046    	mov	_send_buf+10,_st1+10
2345                     ; 363 			break;
2347  0073 ac910491      	jpf	L7311
2348  0077               L1701:
2349                     ; 364 		case 0x06://回复心跳包，回复背光LED,及3个触控开关的状态
2349                     ; 365 			send_buf[6] = cmd;
2351  0077 7b07          	ld	a,(OFST+7,sp)
2352  0079 c70042        	ld	_send_buf+6,a
2353                     ; 366 			send_buf[7] = 0x00;//ST Module ID发0x00
2355  007c 725f0043      	clr	_send_buf+7
2356                     ; 367 			send_buf[8] = 0x00;
2358  0080 725f0044      	clr	_send_buf+8
2359                     ; 368 			if ((st1.st_device_status & 0x08)==0x08)	send_buf[8] = st1.st_pad1_status;
2361  0084 c60078        	ld	a,_st1+2
2362  0087 a408          	and	a,#8
2363  0089 a108          	cp	a,#8
2364  008b 2605          	jrne	L1411
2367  008d 55007c0044    	mov	_send_buf+8,_st1+6
2368  0092               L1411:
2369                     ; 369 			send_buf[9] = 0x00;
2371  0092 725f0045      	clr	_send_buf+9
2372                     ; 370 			if ((st1.st_device_status & 0x04)==0x04)	send_buf[9] = st1.st_pad2_status;
2374  0096 c60078        	ld	a,_st1+2
2375  0099 a404          	and	a,#4
2376  009b a104          	cp	a,#4
2377  009d 2605          	jrne	L3411
2380  009f 55007d0045    	mov	_send_buf+9,_st1+7
2381  00a4               L3411:
2382                     ; 371 			send_buf[10] = 0x00;
2384  00a4 725f0046      	clr	_send_buf+10
2385                     ; 372 			if ((st1.st_device_status & 0x02)==0x02)	send_buf[10]= st1.st_pad3_status;
2387  00a8 c60078        	ld	a,_st1+2
2388  00ab a402          	and	a,#2
2389  00ad a102          	cp	a,#2
2390  00af 2605          	jrne	L5411
2393  00b1 55007e0046    	mov	_send_buf+10,_st1+8
2394  00b6               L5411:
2395                     ; 373 			send_buf[11] = 0x00;
2397  00b6 725f0047      	clr	_send_buf+11
2398                     ; 374 			if ((st1.st_device_status & 0x01)==0x01)	send_buf[11]= st1.st_led_status;
2400  00ba c60078        	ld	a,_st1+2
2401  00bd a401          	and	a,#1
2402  00bf a101          	cp	a,#1
2403  00c1 2703          	jreq	L27
2404  00c3 cc0491        	jp	L7311
2405  00c6               L27:
2408  00c6 55007b0047    	mov	_send_buf+11,_st1+5
2409  00cb ac910491      	jpf	L7311
2410  00cf               L3701:
2411                     ; 376 		case 0x29://ST上报手势信息
2411                     ; 377 			send_buf[6] = cmd;
2413  00cf 7b07          	ld	a,(OFST+7,sp)
2414  00d1 c70042        	ld	_send_buf+6,a
2415                     ; 378 			send_buf[7] = st1.st_ges_H;
2417  00d4 5500760043    	mov	_send_buf+7,_st1
2418                     ; 379 			send_buf[8] = st1.st_ges_L;
2420  00d9 5500770044    	mov	_send_buf+8,_st1+1
2421                     ; 380 			send_buf[9] = 0x00;//ST Module ID 保留
2423  00de 725f0045      	clr	_send_buf+9
2424                     ; 381 			break;
2426  00e2 ac910491      	jpf	L7311
2427  00e6               L5701:
2428                     ; 382 		case 0x35:
2428                     ; 383 			send_buf[6] = cmd;
2430  00e6 7b07          	ld	a,(OFST+7,sp)
2431  00e8 c70042        	ld	_send_buf+6,a
2432                     ; 384 			if (st_pad1_ctrl)
2434  00eb c600c6        	ld	a,_UART1Flag3_
2435  00ee a502          	bcp	a,#2
2436  00f0 270e          	jreq	L1511
2437                     ; 386 				send_buf[7] = st1.st_pad1_ctrl_boardid;
2439  00f2 5500850043    	mov	_send_buf+7,_st1+15
2440                     ; 387 				send_buf[8] = st1.st_pad1_status;
2442  00f7 55007c0044    	mov	_send_buf+8,_st1+6
2444  00fc ac910491      	jpf	L7311
2445  0100               L1511:
2446                     ; 389 			else if (st_pad2_ctrl)
2448  0100 c600c6        	ld	a,_UART1Flag3_
2449  0103 a504          	bcp	a,#4
2450  0105 270e          	jreq	L5511
2451                     ; 391 				send_buf[7] = st1.st_pad2_ctrl_boardid;
2453  0107 55008a0043    	mov	_send_buf+7,_st1+20
2454                     ; 392 				send_buf[8] = st1.st_pad2_status;
2456  010c 55007d0044    	mov	_send_buf+8,_st1+7
2458  0111 ac910491      	jpf	L7311
2459  0115               L5511:
2460                     ; 394 			else if (st_pad3_ctrl)
2462  0115 c600c6        	ld	a,_UART1Flag3_
2463  0118 a508          	bcp	a,#8
2464  011a 2603          	jrne	L47
2465  011c cc0491        	jp	L7311
2466  011f               L47:
2467                     ; 396 				send_buf[7] = st1.st_pad3_ctrl_boardid;
2469  011f 55008f0043    	mov	_send_buf+7,_st1+25
2470                     ; 397 				send_buf[8] = st1.st_pad3_status;
2472  0124 55007e0044    	mov	_send_buf+8,_st1+8
2473  0129 ac910491      	jpf	L7311
2474  012d               L7701:
2475                     ; 400 		case 0xAA://发送回执
2475                     ; 401 		  if (action_ctrlpad_flag)
2477  012d c600c8        	ld	a,_UART1Flag1_
2478  0130 a510          	bcp	a,#16
2479  0132 2725          	jreq	L3611
2480                     ; 403 				action_ctrlpad_flag = 0;
2482  0134 721900c8      	bres	_UART1Flag1_,#4
2483                     ; 404 				send_buf[6] = cmd;
2485  0138 7b07          	ld	a,(OFST+7,sp)
2486  013a c70042        	ld	_send_buf+6,a
2487                     ; 405 				send_buf[7] = 0x05;//代表成功执行并返回模块状态
2489  013d 35050043      	mov	_send_buf+7,#5
2490                     ; 406 				send_buf[8] = st1.st_pad1_status;
2492  0141 55007c0044    	mov	_send_buf+8,_st1+6
2493                     ; 407 				send_buf[9] = st1.st_pad2_status;
2495  0146 55007d0045    	mov	_send_buf+9,_st1+7
2496                     ; 408 				send_buf[10] = st1.st_pad3_status;
2498  014b 55007e0046    	mov	_send_buf+10,_st1+8
2499                     ; 409 				send_buf[11] = st1.st_led_status;
2501  0150 55007b0047    	mov	_send_buf+11,_st1+5
2503  0155 ac910491      	jpf	L7311
2504  0159               L3611:
2505                     ; 411 			else if(led_ctrl_flag)
2507  0159 c600c5        	ld	a,_UART1Flag4_
2508  015c a504          	bcp	a,#4
2509  015e 2726          	jreq	L7611
2510                     ; 413 				led_ctrl_flag = 0;
2512  0160 721500c5      	bres	_UART1Flag4_,#2
2513                     ; 414 				send_buf[6] = cmd;
2515  0164 7b07          	ld	a,(OFST+7,sp)
2516  0166 c70042        	ld	_send_buf+6,a
2517                     ; 415 				send_buf[7] = 0x01;//代表指令执行成功
2519  0169 35010043      	mov	_send_buf+7,#1
2520                     ; 416 				if((st1.st_led_mode == 0x4F) ||	(st1.st_led_mode == 0x5F))
2522  016d c600b2        	ld	a,_st1+60
2523  0170 a14f          	cp	a,#79
2524  0172 270a          	jreq	L3711
2526  0174 c600b2        	ld	a,_st1+60
2527  0177 a15f          	cp	a,#95
2528  0179 2703          	jreq	L67
2529  017b cc0491        	jp	L7311
2530  017e               L67:
2531  017e               L3711:
2532                     ; 417 					send_buf[7] = 0x02;//代表成功接收数据
2534  017e 35020043      	mov	_send_buf+7,#2
2535  0182 ac910491      	jpf	L7311
2536  0186               L7611:
2537                     ; 419 			else if(load_alert_flag)
2539  0186 c600c5        	ld	a,_UART1Flag4_
2540  0189 a508          	bcp	a,#8
2541  018b 2711          	jreq	L7711
2542                     ; 421 				load_alert_flag = 0;
2544  018d 721700c5      	bres	_UART1Flag4_,#3
2545                     ; 422 				send_buf[6] = cmd;
2547  0191 7b07          	ld	a,(OFST+7,sp)
2548  0193 c70042        	ld	_send_buf+6,a
2549                     ; 423 				send_buf[7] = 0x01;//代表指令执行成功
2551  0196 35010043      	mov	_send_buf+7,#1
2553  019a ac910491      	jpf	L7311
2554  019e               L7711:
2555                     ; 425 			else if (cmd_refresh_flag)
2557  019e c600c8        	ld	a,_UART1Flag1_
2558  01a1 a504          	bcp	a,#4
2559  01a3 2711          	jreq	L3021
2560                     ; 427 				cmd_refresh_flag = 0;
2562  01a5 721500c8      	bres	_UART1Flag1_,#2
2563                     ; 428 				send_buf[6] = cmd;
2565  01a9 7b07          	ld	a,(OFST+7,sp)
2566  01ab c70042        	ld	_send_buf+6,a
2567                     ; 429 				send_buf[7] = 0x01;//代表指令执行成功
2569  01ae 35010043      	mov	_send_buf+7,#1
2571  01b2 ac910491      	jpf	L7311
2572  01b6               L3021:
2573                     ; 431 			else if(receipt_conf_pad1)
2575  01b6 c600c4        	ld	a,_UART1Flag5_
2576  01b9 a520          	bcp	a,#32
2577  01bb 2711          	jreq	L7021
2578                     ; 433 				receipt_conf_pad1 = 0;
2580  01bd 721b00c4      	bres	_UART1Flag5_,#5
2581                     ; 434 				send_buf[6] = cmd;
2583  01c1 7b07          	ld	a,(OFST+7,sp)
2584  01c3 c70042        	ld	_send_buf+6,a
2585                     ; 435 				send_buf[7] = 0x01;//代表指令执行成功
2587  01c6 35010043      	mov	_send_buf+7,#1
2589  01ca ac910491      	jpf	L7311
2590  01ce               L7021:
2591                     ; 437 			else if(receipt_conf_pad2)
2593  01ce c600c4        	ld	a,_UART1Flag5_
2594  01d1 a540          	bcp	a,#64
2595  01d3 2711          	jreq	L3121
2596                     ; 439 				receipt_conf_pad2 = 0;
2598  01d5 721d00c4      	bres	_UART1Flag5_,#6
2599                     ; 440 				send_buf[6] = cmd;
2601  01d9 7b07          	ld	a,(OFST+7,sp)
2602  01db c70042        	ld	_send_buf+6,a
2603                     ; 441 				send_buf[7] = 0x03;//代表指令执行失败
2605  01de 35030043      	mov	_send_buf+7,#3
2607  01e2 ac910491      	jpf	L7311
2608  01e6               L3121:
2609                     ; 443 			else if(receipt_conf_gest1)
2611  01e6 c600c3        	ld	a,_UART1Flag6_
2612  01e9 a501          	bcp	a,#1
2613  01eb 2711          	jreq	L7121
2614                     ; 445 				receipt_conf_gest1 = 0;
2616  01ed 721100c3      	bres	_UART1Flag6_,#0
2617                     ; 446 				send_buf[6] = cmd;
2619  01f1 7b07          	ld	a,(OFST+7,sp)
2620  01f3 c70042        	ld	_send_buf+6,a
2621                     ; 447 				send_buf[7] = 0x01;//代表指令执行成功
2623  01f6 35010043      	mov	_send_buf+7,#1
2625  01fa ac910491      	jpf	L7311
2626  01fe               L7121:
2627                     ; 449 			else if(receipt_conf_gest2)
2629  01fe c600c3        	ld	a,_UART1Flag6_
2630  0201 a502          	bcp	a,#2
2631  0203 2711          	jreq	L3221
2632                     ; 451 				receipt_conf_gest2 = 0;
2634  0205 721300c3      	bres	_UART1Flag6_,#1
2635                     ; 452 				send_buf[6] = cmd;
2637  0209 7b07          	ld	a,(OFST+7,sp)
2638  020b c70042        	ld	_send_buf+6,a
2639                     ; 453 				send_buf[7] = 0x03;//代表指令执行失败
2641  020e 35030043      	mov	_send_buf+7,#3
2643  0212 ac910491      	jpf	L7311
2644  0216               L3221:
2645                     ; 455 			else if(receipt_device_info2)
2647  0216 c600c4        	ld	a,_UART1Flag5_
2648  0219 a501          	bcp	a,#1
2649  021b 2603          	jrne	L001
2650  021d cc0491        	jp	L7311
2651  0220               L001:
2652                     ; 457 				receipt_device_info2 = 0;
2654  0220 721100c4      	bres	_UART1Flag5_,#0
2655                     ; 458 				send_buf[6] = cmd;
2657  0224 7b07          	ld	a,(OFST+7,sp)
2658  0226 c70042        	ld	_send_buf+6,a
2659                     ; 459 				send_buf[7] = 0x03;//代表指令执行失败
2661  0229 35030043      	mov	_send_buf+7,#3
2662  022d ac910491      	jpf	L7311
2663  0231               L1011:
2664                     ; 462 		case 0xB4://ST回复设备信息
2664                     ; 463 			send_buf[6] = cmd;
2666  0231 7b07          	ld	a,(OFST+7,sp)
2667  0233 c70042        	ld	_send_buf+6,a
2668                     ; 464 			send_buf[7] = 0x11;//UUID
2670  0236 35110043      	mov	_send_buf+7,#17
2671                     ; 465 			send_buf[8] = 0x11;
2673  023a 35110044      	mov	_send_buf+8,#17
2674                     ; 466 			send_buf[9] = 0x11;
2676  023e 35110045      	mov	_send_buf+9,#17
2677                     ; 467 			send_buf[10] = 0x11;
2679  0242 35110046      	mov	_send_buf+10,#17
2680                     ; 468 			send_buf[11] = 0x63;//设备型号
2682  0246 35630047      	mov	_send_buf+11,#99
2683                     ; 469 			send_buf[12] = 0x00;//固件版本
2685  024a 725f0048      	clr	_send_buf+12
2686                     ; 470 			send_buf[13] = st1.st_device_status;
2688  024e 5500780049    	mov	_send_buf+13,_st1+2
2689                     ; 471 			break;
2691  0253 ac910491      	jpf	L7311
2692  0257               L3011:
2693                     ; 472 		case 0x0A://汇报 Seraph相关设备故障 
2693                     ; 473 			send_buf[6] = cmd;
2695  0257 7b07          	ld	a,(OFST+7,sp)
2696  0259 c70042        	ld	_send_buf+6,a
2697                     ; 474 			send_buf[7] = 0xB4;
2699  025c 35b40043      	mov	_send_buf+7,#180
2700                     ; 475 			send_buf[8] = st1.st_device_status;
2702  0260 5500780044    	mov	_send_buf+8,_st1+2
2703                     ; 476 			break;
2705  0265 ac910491      	jpf	L7311
2706  0269               L5011:
2707                     ; 477 		case 0x51://ST被触发判断需要向SC 发送指令	预设值指令手势
2707                     ; 478 			send_buf[6] = cmd;
2709  0269 7b07          	ld	a,(OFST+7,sp)
2710  026b c70042        	ld	_send_buf+6,a
2711                     ; 479 			if(gest1_confirm)
2713  026e c600c7        	ld	a,_UART1Flag2_
2714  0271 a504          	bcp	a,#4
2715  0273 2712          	jreq	L1321
2716                     ; 481 				send_buf[7] = st1.st_ges1_ctrl_boardid;
2718  0275 5500960043    	mov	_send_buf+7,_st1+32
2719                     ; 482 				send_buf[8] = st1.st_ges1_ctrl_action_value;
2721  027a 5500a70044    	mov	_send_buf+8,_st1+49
2722                     ; 483 				send_buf[9] = 0x00;
2724  027f 725f0045      	clr	_send_buf+9
2726  0283 ac910491      	jpf	L7311
2727  0287               L1321:
2728                     ; 485 			else if(gest2_confirm)
2730  0287 c600c7        	ld	a,_UART1Flag2_
2731  028a a508          	bcp	a,#8
2732  028c 2712          	jreq	L5321
2733                     ; 487 				send_buf[7] = st1.st_ges2_ctrl_boardid;
2735  028e 55009b0043    	mov	_send_buf+7,_st1+37
2736                     ; 488 				send_buf[8] = st1.st_ges2_ctrl_action_value;
2738  0293 5500aa0044    	mov	_send_buf+8,_st1+52
2739                     ; 489 				send_buf[9] = 0x00;
2741  0298 725f0045      	clr	_send_buf+9
2743  029c ac910491      	jpf	L7311
2744  02a0               L5321:
2745                     ; 491 			else if(gest3_confirm)
2747  02a0 c600c7        	ld	a,_UART1Flag2_
2748  02a3 a510          	bcp	a,#16
2749  02a5 2712          	jreq	L1421
2750                     ; 493 				send_buf[7] = st1.st_ges3_ctrl_boardid;
2752  02a7 5500a00043    	mov	_send_buf+7,_st1+42
2753                     ; 494 				send_buf[8] = st1.st_ges3_ctrl_action_value;
2755  02ac 5500ad0044    	mov	_send_buf+8,_st1+55
2756                     ; 495 				send_buf[9] = 0x00;
2758  02b1 725f0045      	clr	_send_buf+9
2760  02b5 ac910491      	jpf	L7311
2761  02b9               L1421:
2762                     ; 497 			else if(gest4_confirm)
2764  02b9 c600c7        	ld	a,_UART1Flag2_
2765  02bc a520          	bcp	a,#32
2766  02be 2712          	jreq	L5421
2767                     ; 499 				send_buf[7] = st1.st_ges4_ctrl_boardid;
2769  02c0 5500a50043    	mov	_send_buf+7,_st1+47
2770                     ; 500 				send_buf[8] = st1.st_ges4_ctrl_action_value;
2772  02c5 5500b00044    	mov	_send_buf+8,_st1+58
2773                     ; 501 				send_buf[9] = 0x00;
2775  02ca 725f0045      	clr	_send_buf+9
2777  02ce ac910491      	jpf	L7311
2778  02d2               L5421:
2779                     ; 503 			else if(st_pad1_confirm)
2781  02d2 c600c6        	ld	a,_UART1Flag3_
2782  02d5 a510          	bcp	a,#16
2783  02d7 2711          	jreq	L1521
2784                     ; 505 				send_buf[7] = st1.st_pad1_ctrl_boardid;
2786  02d9 5500850043    	mov	_send_buf+7,_st1+15
2787                     ; 506 				send_buf[8] = 0x00;
2789  02de 725f0044      	clr	_send_buf+8
2790                     ; 507 				send_buf[9] = 0x00;
2792  02e2 725f0045      	clr	_send_buf+9
2794  02e6 ac910491      	jpf	L7311
2795  02ea               L1521:
2796                     ; 509 			else if(st_pad2_confirm)
2798  02ea c600c6        	ld	a,_UART1Flag3_
2799  02ed a520          	bcp	a,#32
2800  02ef 2711          	jreq	L5521
2801                     ; 511 				send_buf[7] = st1.st_pad2_ctrl_boardid;
2803  02f1 55008a0043    	mov	_send_buf+7,_st1+20
2804                     ; 512 				send_buf[8] = 0x00;
2806  02f6 725f0044      	clr	_send_buf+8
2807                     ; 513 				send_buf[9] = 0x00;
2809  02fa 725f0045      	clr	_send_buf+9
2811  02fe ac910491      	jpf	L7311
2812  0302               L5521:
2813                     ; 515 			else if(st_pad3_confirm)
2815  0302 c600c6        	ld	a,_UART1Flag3_
2816  0305 a540          	bcp	a,#64
2817  0307 2603          	jrne	L201
2818  0309 cc0491        	jp	L7311
2819  030c               L201:
2820                     ; 517 				send_buf[7] = st1.st_pad3_ctrl_boardid;
2822  030c 55008f0043    	mov	_send_buf+7,_st1+25
2823                     ; 518 				send_buf[8] = 0x00;
2825  0311 725f0044      	clr	_send_buf+8
2826                     ; 519 				send_buf[9] = 0x00;
2828  0315 725f0045      	clr	_send_buf+9
2829  0319 ac910491      	jpf	L7311
2830  031d               L7011:
2831                     ; 523 		case 0x08://ST被触发异步向 SS 推送触发器数值和判断结果
2831                     ; 524 			send_buf[6] = cmd;
2833  031d 7b07          	ld	a,(OFST+7,sp)
2834  031f c70042        	ld	_send_buf+6,a
2835                     ; 526 			if(gest1_confirm)
2837  0322 c600c7        	ld	a,_UART1Flag2_
2838  0325 a504          	bcp	a,#4
2839  0327 2730          	jreq	L3621
2840                     ; 528 				send_buf[7] = 0x02;//触发器是手势
2842  0329 35020043      	mov	_send_buf+7,#2
2843                     ; 529 				send_buf[8] = st1.st_ges1_ctrl_H;
2845  032d 5500920044    	mov	_send_buf+8,_st1+28
2846                     ; 530 				send_buf[9] = st1.st_ges1_ctrl_L;
2848  0332 5500930045    	mov	_send_buf+9,_st1+29
2849                     ; 531 				send_buf[10] = st1.st_ges1_ctrl_meshid_H;
2851  0337 5500940046    	mov	_send_buf+10,_st1+30
2852                     ; 532 				send_buf[11] = st1.st_ges1_ctrl_meshid_L;
2854  033c 5500950047    	mov	_send_buf+11,_st1+31
2855                     ; 533 				send_buf[12] = st1.st_ges1_ctrl_action;
2857  0341 5500a60048    	mov	_send_buf+12,_st1+48
2858                     ; 534 				send_buf[13] = st1.st_ges1_ctrl_boardid;
2860  0346 5500960049    	mov	_send_buf+13,_st1+32
2861                     ; 535 				send_buf[14] = st1.st_ges1_ctrl_action_value;
2863  034b 5500a7004a    	mov	_send_buf+14,_st1+49
2864                     ; 536 				send_buf[15] = st1.st_ges1_ctrl_action_time;
2866  0350 5500a8004b    	mov	_send_buf+15,_st1+50
2868  0355 ac910491      	jpf	L7311
2869  0359               L3621:
2870                     ; 538 			else if(gest2_confirm)
2872  0359 c600c7        	ld	a,_UART1Flag2_
2873  035c a508          	bcp	a,#8
2874  035e 2730          	jreq	L7621
2875                     ; 540 				send_buf[7] = 0x02;
2877  0360 35020043      	mov	_send_buf+7,#2
2878                     ; 541 				send_buf[8] = st1.st_ges2_ctrl_H;
2880  0364 5500970044    	mov	_send_buf+8,_st1+33
2881                     ; 542 				send_buf[9] = st1.st_ges2_ctrl_L;
2883  0369 5500980045    	mov	_send_buf+9,_st1+34
2884                     ; 543 				send_buf[10] = st1.st_ges2_ctrl_meshid_H;
2886  036e 5500990046    	mov	_send_buf+10,_st1+35
2887                     ; 544 				send_buf[11] = st1.st_ges2_ctrl_meshid_L;
2889  0373 55009a0047    	mov	_send_buf+11,_st1+36
2890                     ; 545 				send_buf[12] = st1.st_ges2_ctrl_action;
2892  0378 5500a90048    	mov	_send_buf+12,_st1+51
2893                     ; 546 				send_buf[13] = st1.st_ges2_ctrl_boardid;
2895  037d 55009b0049    	mov	_send_buf+13,_st1+37
2896                     ; 547 				send_buf[14] = st1.st_ges2_ctrl_action_value;
2898  0382 5500aa004a    	mov	_send_buf+14,_st1+52
2899                     ; 548 				send_buf[15] = st1.st_ges2_ctrl_action_time;
2901  0387 5500ab004b    	mov	_send_buf+15,_st1+53
2903  038c ac910491      	jpf	L7311
2904  0390               L7621:
2905                     ; 550 			else if(gest3_confirm)
2907  0390 c600c7        	ld	a,_UART1Flag2_
2908  0393 a510          	bcp	a,#16
2909  0395 2730          	jreq	L3721
2910                     ; 552 				send_buf[7] = 0x02;
2912  0397 35020043      	mov	_send_buf+7,#2
2913                     ; 553 				send_buf[8] = st1.st_ges3_ctrl_H;
2915  039b 55009c0044    	mov	_send_buf+8,_st1+38
2916                     ; 554 				send_buf[9] = st1.st_ges3_ctrl_L;
2918  03a0 55009d0045    	mov	_send_buf+9,_st1+39
2919                     ; 555 				send_buf[10] = st1.st_ges3_ctrl_meshid_H;
2921  03a5 55009e0046    	mov	_send_buf+10,_st1+40
2922                     ; 556 				send_buf[11] = st1.st_ges3_ctrl_meshid_L;
2924  03aa 55009f0047    	mov	_send_buf+11,_st1+41
2925                     ; 557 				send_buf[12] = st1.st_ges3_ctrl_action;
2927  03af 5500ac0048    	mov	_send_buf+12,_st1+54
2928                     ; 558 				send_buf[13] = st1.st_ges3_ctrl_boardid;
2930  03b4 5500a00049    	mov	_send_buf+13,_st1+42
2931                     ; 559 				send_buf[14] = st1.st_ges3_ctrl_action_value;
2933  03b9 5500ad004a    	mov	_send_buf+14,_st1+55
2934                     ; 560 				send_buf[15] = st1.st_ges3_ctrl_action_time;
2936  03be 5500ae004b    	mov	_send_buf+15,_st1+56
2938  03c3 ac910491      	jpf	L7311
2939  03c7               L3721:
2940                     ; 562 			else if(gest4_confirm)
2942  03c7 c600c7        	ld	a,_UART1Flag2_
2943  03ca a520          	bcp	a,#32
2944  03cc 272f          	jreq	L7721
2945                     ; 564 				send_buf[7] = 0x02;
2947  03ce 35020043      	mov	_send_buf+7,#2
2948                     ; 565 				send_buf[8] = st1.st_ges4_ctrl_H;
2950  03d2 5500a10044    	mov	_send_buf+8,_st1+43
2951                     ; 566 				send_buf[9] = st1.st_ges4_ctrl_L;
2953  03d7 5500a20045    	mov	_send_buf+9,_st1+44
2954                     ; 567 				send_buf[10] = st1.st_ges4_ctrl_meshid_H;
2956  03dc 5500a30046    	mov	_send_buf+10,_st1+45
2957                     ; 568 				send_buf[11] = st1.st_ges4_ctrl_meshid_L;
2959  03e1 5500a40047    	mov	_send_buf+11,_st1+46
2960                     ; 569 				send_buf[12] = st1.st_ges4_ctrl_action;
2962  03e6 5500af0048    	mov	_send_buf+12,_st1+57
2963                     ; 570 				send_buf[13] = st1.st_ges4_ctrl_boardid;
2965  03eb 5500a50049    	mov	_send_buf+13,_st1+47
2966                     ; 571 				send_buf[14] = st1.st_ges4_ctrl_action_value;
2968  03f0 5500b0004a    	mov	_send_buf+14,_st1+58
2969                     ; 572 				send_buf[15] = 0x00;
2971  03f5 725f004b      	clr	_send_buf+15
2973  03f9 ac910491      	jpf	L7311
2974  03fd               L7721:
2975                     ; 574 			else if(st_pad1_confirm)
2977  03fd c600c6        	ld	a,_UART1Flag3_
2978  0400 a510          	bcp	a,#16
2979  0402 272b          	jreq	L3031
2980                     ; 576 				send_buf[7] = 0x01;//触发器是按键
2982  0404 35010043      	mov	_send_buf+7,#1
2983                     ; 577 				send_buf[8] = 0x00;
2985  0408 725f0044      	clr	_send_buf+8
2986                     ; 578 				send_buf[9] = st1.st_ctrl_address;
2988  040c 5500790045    	mov	_send_buf+9,_st1+3
2989                     ; 579 				send_buf[10] = st1.st_pad1_ctrl_meshid_H;
2991  0411 5500830046    	mov	_send_buf+10,_st1+13
2992                     ; 580 				send_buf[11] = st1.st_pad1_ctrl_meshid_L;
2994  0416 5500840047    	mov	_send_buf+11,_st1+14
2995                     ; 581 				send_buf[12] = st1.st_pad1_ctrl_action;
2997  041b 5500860048    	mov	_send_buf+12,_st1+16
2998                     ; 582 				send_buf[13] = st1.st_pad1_ctrl_boardid;
3000  0420 5500850049    	mov	_send_buf+13,_st1+15
3001                     ; 583 				send_buf[14] = 0x00;
3003  0425 725f004a      	clr	_send_buf+14
3004                     ; 584 				send_buf[15] = 0x00;
3006  0429 725f004b      	clr	_send_buf+15
3008  042d 2062          	jra	L7311
3009  042f               L3031:
3010                     ; 586 			else if(st_pad2_confirm)
3012  042f c600c6        	ld	a,_UART1Flag3_
3013  0432 a520          	bcp	a,#32
3014  0434 272b          	jreq	L7031
3015                     ; 588 				send_buf[7] = 0x01;//触发器是按键
3017  0436 35010043      	mov	_send_buf+7,#1
3018                     ; 589 				send_buf[8] = 0x00;
3020  043a 725f0044      	clr	_send_buf+8
3021                     ; 590 				send_buf[9] = st1.st_ctrl_address;
3023  043e 5500790045    	mov	_send_buf+9,_st1+3
3024                     ; 591 				send_buf[10] = st1.st_pad2_ctrl_meshid_H;
3026  0443 5500880046    	mov	_send_buf+10,_st1+18
3027                     ; 592 				send_buf[11] = st1.st_pad2_ctrl_meshid_L;
3029  0448 5500890047    	mov	_send_buf+11,_st1+19
3030                     ; 593 				send_buf[12] = st1.st_pad2_ctrl_action;
3032  044d 55008b0048    	mov	_send_buf+12,_st1+21
3033                     ; 594 				send_buf[13] = st1.st_pad2_ctrl_boardid;
3035  0452 55008a0049    	mov	_send_buf+13,_st1+20
3036                     ; 595 				send_buf[14] = 0x00;
3038  0457 725f004a      	clr	_send_buf+14
3039                     ; 596 				send_buf[15] = 0x00;
3041  045b 725f004b      	clr	_send_buf+15
3043  045f 2030          	jra	L7311
3044  0461               L7031:
3045                     ; 598 			else if(st_pad3_confirm)
3047  0461 c600c6        	ld	a,_UART1Flag3_
3048  0464 a540          	bcp	a,#64
3049  0466 2729          	jreq	L7311
3050                     ; 600 				send_buf[7] = 0x01;//触发器是按键
3052  0468 35010043      	mov	_send_buf+7,#1
3053                     ; 601 				send_buf[8] = 0x00;
3055  046c 725f0044      	clr	_send_buf+8
3056                     ; 602 				send_buf[9] = st1.st_ctrl_address;
3058  0470 5500790045    	mov	_send_buf+9,_st1+3
3059                     ; 603 				send_buf[10] = st1.st_pad3_ctrl_meshid_H;
3061  0475 55008d0046    	mov	_send_buf+10,_st1+23
3062                     ; 604 				send_buf[11] = st1.st_pad3_ctrl_meshid_L;
3064  047a 55008e0047    	mov	_send_buf+11,_st1+24
3065                     ; 605 				send_buf[12] = st1.st_pad3_ctrl_action;
3067  047f 5500900048    	mov	_send_buf+12,_st1+26
3068                     ; 606 				send_buf[13] = st1.st_pad3_ctrl_boardid;
3070  0484 55008f0049    	mov	_send_buf+13,_st1+25
3071                     ; 607 				send_buf[14] = 0x00;
3073  0489 725f004a      	clr	_send_buf+14
3074                     ; 608 				send_buf[15] = 0x00;
3076  048d 725f004b      	clr	_send_buf+15
3077  0491               L7311:
3078                     ; 612 	send_buf[len+2] = Check_Sum((send_buf+2),len);
3080  0491 7b06          	ld	a,(OFST+6,sp)
3081  0493 5f            	clrw	x
3082  0494 97            	ld	xl,a
3083  0495 89            	pushw	x
3084  0496 7b08          	ld	a,(OFST+8,sp)
3085  0498 88            	push	a
3086  0499 ae003e        	ldw	x,#_send_buf+2
3087  049c cd0000        	call	_Check_Sum
3089  049f 5b01          	addw	sp,#1
3090  04a1 85            	popw	x
3091  04a2 d7003e        	ld	(_send_buf+2,x),a
3092                     ; 613 }
3095  04a5 85            	popw	x
3096  04a6 81            	ret
3163                     ; 631 void rev_header_anaylze(u8 *message_id,u8 *mesh_id_H,u8 *mesh_id_L,u8 *message_length)
3163                     ; 632 {
3164                     .text:	section	.text,new
3165  0000               _rev_header_anaylze:
3167  0000 89            	pushw	x
3168       00000000      OFST:	set	0
3171                     ; 633 	if ((sicp_buf[0] == 0xEE) && (sicp_buf[1]== 0xEE))
3173  0001 c60000        	ld	a,_sicp_buf
3174  0004 a1ee          	cp	a,#238
3175  0006 2623          	jrne	L7431
3177  0008 c60001        	ld	a,_sicp_buf+1
3178  000b a1ee          	cp	a,#238
3179  000d 261c          	jrne	L7431
3180                     ; 635 		ble_data_frame = 1;
3182  000f 721a00c8      	bset	_UART1Flag1_,#5
3183                     ; 636 		*message_id = sicp_buf[2];
3185  0013 c60002        	ld	a,_sicp_buf+2
3186  0016 f7            	ld	(x),a
3187                     ; 637 		*mesh_id_H = sicp_buf[3];
3189  0017 1e05          	ldw	x,(OFST+5,sp)
3190  0019 c60003        	ld	a,_sicp_buf+3
3191  001c f7            	ld	(x),a
3192                     ; 638 		*mesh_id_L = sicp_buf[4];
3194  001d 1e07          	ldw	x,(OFST+7,sp)
3195  001f c60004        	ld	a,_sicp_buf+4
3196  0022 f7            	ld	(x),a
3197                     ; 639 		*message_length = sicp_buf[5];
3199  0023 1e09          	ldw	x,(OFST+9,sp)
3200  0025 c60005        	ld	a,_sicp_buf+5
3201  0028 f7            	ld	(x),a
3203  0029 2018          	jra	L1531
3204  002b               L7431:
3205                     ; 642 	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))//Network	Status	Reporting	
3207  002b c60000        	ld	a,_sicp_buf
3208  002e a1dd          	cp	a,#221
3209  0030 2611          	jrne	L1531
3211  0032 c60001        	ld	a,_sicp_buf+1
3212  0035 a1dd          	cp	a,#221
3213  0037 260a          	jrne	L1531
3214                     ; 644 		ble_ctrl_frame = 1;
3216  0039 721c00c8      	bset	_UART1Flag1_,#6
3217                     ; 645 		*message_length = sicp_buf[3];
3219  003d 1e09          	ldw	x,(OFST+9,sp)
3220  003f c60003        	ld	a,_sicp_buf+3
3221  0042 f7            	ld	(x),a
3222  0043               L1531:
3223                     ; 652 }
3226  0043 85            	popw	x
3227  0044 81            	ret
3294                     ; 659 bool rev_payload_anaylze(void)
3294                     ; 660 {
3295                     .text:	section	.text,new
3296  0000               _rev_payload_anaylze:
3298  0000 89            	pushw	x
3299       00000002      OFST:	set	2
3302                     ; 662 	if (ble_data_frame)
3304  0001 c600c8        	ld	a,_UART1Flag1_
3305  0004 a520          	bcp	a,#32
3306  0006 2603          	jrne	L211
3307  0008 cc05ff        	jp	L5341
3308  000b               L211:
3309                     ; 664 		ble_data_frame = 0;
3311  000b 721b00c8      	bres	_UART1Flag1_,#5
3312                     ; 665 		switch(sicp_buf[6])
3314  000f c60006        	ld	a,_sicp_buf+6
3316                     ; 971 			default:
3316                     ; 972 				break;
3317  0012 a003          	sub	a,#3
3318  0014 2603          	jrne	L411
3319  0016 cc0376        	jp	L3631
3320  0019               L411:
3321  0019 4a            	dec	a
3322  001a 2726          	jreq	L5531
3323  001c 4a            	dec	a
3324  001d 2603          	jrne	L611
3325  001f cc05d3        	jp	L3041
3326  0022               L611:
3327  0022 a004          	sub	a,#4
3328  0024 2603          	jrne	L021
3329  0026 cc046a        	jp	L7631
3330  0029               L021:
3331  0029 a04d          	sub	a,#77
3332  002b 2603          	jrne	L221
3333  002d cc0405        	jp	L5631
3334  0030               L221:
3335  0030 a054          	sub	a,#84
3336  0032 2603          	jrne	L421
3337  0034 cc0352        	jp	L7531
3338  0037               L421:
3339  0037 a016          	sub	a,#22
3340  0039 2603          	jrne	L621
3341  003b cc0364        	jp	L1631
3342  003e               L621:
3343  003e acfb05fb      	jpf	L1441
3344  0042               L5531:
3345                     ; 667 			case 0x04://SS向ST发送配置信息
3345                     ; 668 				receipt_device_info1 = 1;
3347  0042 721000c4      	bset	_UART1Flag5_,#0
3348                     ; 671 					if (sicp_buf[7] == 0x01)//设置ST按键作用
3350  0046 c60007        	ld	a,_sicp_buf+7
3351  0049 a101          	cp	a,#1
3352  004b 2703          	jreq	L031
3353  004d cc015a        	jp	L3441
3354  0050               L031:
3355                     ; 673 						kickout_flag = 0;
3357  0050 721100c5      	bres	_UART1Flag4_,#0
3358                     ; 674 						net_reset_flag = 0;
3360  0054 721300c5      	bres	_UART1Flag4_,#1
3361                     ; 675 						if ((sicp_buf[8] & 0x01) == 0x01)//设置通道1
3363  0058 c60008        	ld	a,_sicp_buf+8
3364  005b a401          	and	a,#1
3365  005d a101          	cp	a,#1
3366  005f 2640          	jrne	L5441
3367                     ; 677 							st1.st_pad1_ctrl_meshid_H = sicp_buf[10];
3369  0061 55000a0083    	mov	_st1+13,_sicp_buf+10
3370                     ; 678 							st1.st_pad1_ctrl_meshid_L = sicp_buf[11];
3372  0066 55000b0084    	mov	_st1+14,_sicp_buf+11
3373                     ; 679 							st1.st_pad1_ctrl_boardid 	= sicp_buf[12];
3375  006b 55000c0085    	mov	_st1+15,_sicp_buf+12
3376                     ; 680 							st1.st_pad1_ctrl_action   = sicp_buf[13];
3378  0070 55000d0086    	mov	_st1+16,_sicp_buf+13
3379                     ; 681 							st1.st_pad1_ctrl_action_value = sicp_buf[14];
3381  0075 55000e0087    	mov	_st1+17,_sicp_buf+14
3382                     ; 682 							receipt_conf_pad1 = 1;
3384  007a 721a00c4      	bset	_UART1Flag5_,#5
3385                     ; 683 							send_message_length = 6;
3387  007e 35060064      	mov	_send_message_length,#6
3388                     ; 684 							send_cmd = 0xAA;
3390  0082 35aa0063      	mov	_send_cmd,#170
3391                     ; 685 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3393  0086 4baa          	push	#170
3394  0088 4b06          	push	#6
3395  008a 3b006c        	push	_ns_own_meshid_L
3396  008d c6006d        	ld	a,_ns_own_meshid_H
3397  0090 97            	ld	xl,a
3398  0091 c60069        	ld	a,_rev_message_id
3399  0094 95            	ld	xh,a
3400  0095 cd0000        	call	_send_header_payload_init
3402  0098 5b03          	addw	sp,#3
3403                     ; 686 							UART2_Send_Data_Start();
3405  009a cd0000        	call	_UART2_Send_Data_Start
3407                     ; 687 							break;
3409  009d acfb05fb      	jpf	L1441
3410  00a1               L5441:
3411                     ; 689 						else if ((sicp_buf[8] & 0x02) == 0x02)//设置通道2
3413  00a1 c60008        	ld	a,_sicp_buf+8
3414  00a4 a402          	and	a,#2
3415  00a6 a102          	cp	a,#2
3416  00a8 2640          	jrne	L1541
3417                     ; 691 							st1.st_pad2_ctrl_meshid_H = sicp_buf[10];
3419  00aa 55000a0088    	mov	_st1+18,_sicp_buf+10
3420                     ; 692 							st1.st_pad2_ctrl_meshid_L = sicp_buf[11];
3422  00af 55000b0089    	mov	_st1+19,_sicp_buf+11
3423                     ; 693 							st1.st_pad2_ctrl_boardid 	= sicp_buf[12];
3425  00b4 55000c008a    	mov	_st1+20,_sicp_buf+12
3426                     ; 694 							st1.st_pad2_ctrl_action   = sicp_buf[13];
3428  00b9 55000d008b    	mov	_st1+21,_sicp_buf+13
3429                     ; 695 							st1.st_pad2_ctrl_action_value = sicp_buf[14];
3431  00be 55000e008c    	mov	_st1+22,_sicp_buf+14
3432                     ; 696 							receipt_conf_pad1 = 1;
3434  00c3 721a00c4      	bset	_UART1Flag5_,#5
3435                     ; 697 							send_message_length = 6;
3437  00c7 35060064      	mov	_send_message_length,#6
3438                     ; 698 							send_cmd = 0xAA;
3440  00cb 35aa0063      	mov	_send_cmd,#170
3441                     ; 699 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3443  00cf 4baa          	push	#170
3444  00d1 4b06          	push	#6
3445  00d3 3b006c        	push	_ns_own_meshid_L
3446  00d6 c6006d        	ld	a,_ns_own_meshid_H
3447  00d9 97            	ld	xl,a
3448  00da c60069        	ld	a,_rev_message_id
3449  00dd 95            	ld	xh,a
3450  00de cd0000        	call	_send_header_payload_init
3452  00e1 5b03          	addw	sp,#3
3453                     ; 700 							UART2_Send_Data_Start();
3455  00e3 cd0000        	call	_UART2_Send_Data_Start
3457                     ; 701 							break;
3459  00e6 acfb05fb      	jpf	L1441
3460  00ea               L1541:
3461                     ; 703 						else if ((sicp_buf[8] & 0x04) == 0x04)//设置通道3
3463  00ea c60008        	ld	a,_sicp_buf+8
3464  00ed a404          	and	a,#4
3465  00ef a104          	cp	a,#4
3466  00f1 2640          	jrne	L5541
3467                     ; 705 							st1.st_pad3_ctrl_meshid_H = sicp_buf[10];
3469  00f3 55000a008d    	mov	_st1+23,_sicp_buf+10
3470                     ; 706 							st1.st_pad3_ctrl_meshid_L = sicp_buf[11];
3472  00f8 55000b008e    	mov	_st1+24,_sicp_buf+11
3473                     ; 707 							st1.st_pad3_ctrl_boardid 	= sicp_buf[12];
3475  00fd 55000c008f    	mov	_st1+25,_sicp_buf+12
3476                     ; 708 							st1.st_pad3_ctrl_action   = sicp_buf[13];
3478  0102 55000d0090    	mov	_st1+26,_sicp_buf+13
3479                     ; 709 							st1.st_pad3_ctrl_action_value = sicp_buf[14];
3481  0107 55000e0091    	mov	_st1+27,_sicp_buf+14
3482                     ; 710 							receipt_conf_pad1 = 1;
3484  010c 721a00c4      	bset	_UART1Flag5_,#5
3485                     ; 711 							send_message_length = 6;
3487  0110 35060064      	mov	_send_message_length,#6
3488                     ; 712 							send_cmd = 0xAA;
3490  0114 35aa0063      	mov	_send_cmd,#170
3491                     ; 713 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3493  0118 4baa          	push	#170
3494  011a 4b06          	push	#6
3495  011c 3b006c        	push	_ns_own_meshid_L
3496  011f c6006d        	ld	a,_ns_own_meshid_H
3497  0122 97            	ld	xl,a
3498  0123 c60069        	ld	a,_rev_message_id
3499  0126 95            	ld	xh,a
3500  0127 cd0000        	call	_send_header_payload_init
3502  012a 5b03          	addw	sp,#3
3503                     ; 714 							UART2_Send_Data_Start();
3505  012c cd0000        	call	_UART2_Send_Data_Start
3507                     ; 715 							break;
3509  012f acfb05fb      	jpf	L1441
3510  0133               L5541:
3511                     ; 719 							receipt_conf_pad2 = 1;
3513  0133 721c00c4      	bset	_UART1Flag5_,#6
3514                     ; 720 							send_message_length = 6;
3516  0137 35060064      	mov	_send_message_length,#6
3517                     ; 721 							send_cmd = 0xAA;
3519  013b 35aa0063      	mov	_send_cmd,#170
3520                     ; 722 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3522  013f 4baa          	push	#170
3523  0141 4b06          	push	#6
3524  0143 3b006c        	push	_ns_own_meshid_L
3525  0146 c6006d        	ld	a,_ns_own_meshid_H
3526  0149 97            	ld	xl,a
3527  014a c60069        	ld	a,_rev_message_id
3528  014d 95            	ld	xh,a
3529  014e cd0000        	call	_send_header_payload_init
3531  0151 5b03          	addw	sp,#3
3532                     ; 723 							UART2_Send_Data_Start();
3534  0153 cd0000        	call	_UART2_Send_Data_Start
3536                     ; 724 							break;
3538  0156 acfb05fb      	jpf	L1441
3539  015a               L3441:
3540                     ; 728 					if (sicp_buf[7] == 0x02)//设置ST手势作用
3542  015a c60007        	ld	a,_sicp_buf+7
3543  015d a102          	cp	a,#2
3544  015f 2703          	jreq	L231
3545  0161 cc05fb        	jp	L1441
3546  0164               L231:
3547                     ; 730 						kickout_flag = 0;
3549  0164 721100c5      	bres	_UART1Flag4_,#0
3550                     ; 731 						net_reset_flag = 0;
3552  0168 721300c5      	bres	_UART1Flag4_,#1
3553                     ; 733 						if((sicp_buf[8] != st1.st_ges1_ctrl_H) && (sicp_buf[9] != st1.st_ges1_ctrl_L))//第一个预设置手势
3555  016c c60008        	ld	a,_sicp_buf+8
3556  016f c10092        	cp	a,_st1+28
3557  0172 2752          	jreq	L3641
3559  0174 c60009        	ld	a,_sicp_buf+9
3560  0177 c10093        	cp	a,_st1+29
3561  017a 274a          	jreq	L3641
3562                     ; 735 							st1.st_ges1_ctrl_H						= sicp_buf[8];
3564  017c 5500080092    	mov	_st1+28,_sicp_buf+8
3565                     ; 736 							st1.st_ges1_ctrl_L						= sicp_buf[9];
3567  0181 5500090093    	mov	_st1+29,_sicp_buf+9
3568                     ; 737 							st1.st_ges1_ctrl_meshid_H 		= sicp_buf[10];
3570  0186 55000a0094    	mov	_st1+30,_sicp_buf+10
3571                     ; 738 							st1.st_ges1_ctrl_meshid_L 		= sicp_buf[11];
3573  018b 55000b0095    	mov	_st1+31,_sicp_buf+11
3574                     ; 739 							st1.st_ges1_ctrl_boardid 			= sicp_buf[12];
3576  0190 55000c0096    	mov	_st1+32,_sicp_buf+12
3577                     ; 740 							st1.st_ges1_ctrl_action				= sicp_buf[13];
3579  0195 55000d00a6    	mov	_st1+48,_sicp_buf+13
3580                     ; 741 							st1.st_ges1_ctrl_action_value = sicp_buf[14];
3582  019a 55000e00a7    	mov	_st1+49,_sicp_buf+14
3583                     ; 743 							receipt_conf_gest1 = 1;
3585  019f 721000c3      	bset	_UART1Flag6_,#0
3586                     ; 744 							send_message_length = 6;
3588  01a3 35060064      	mov	_send_message_length,#6
3589                     ; 745 							send_cmd = 0xAA;
3591  01a7 35aa0063      	mov	_send_cmd,#170
3592                     ; 746 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3594  01ab 4baa          	push	#170
3595  01ad 4b06          	push	#6
3596  01af 3b006c        	push	_ns_own_meshid_L
3597  01b2 c6006d        	ld	a,_ns_own_meshid_H
3598  01b5 97            	ld	xl,a
3599  01b6 c60069        	ld	a,_rev_message_id
3600  01b9 95            	ld	xh,a
3601  01ba cd0000        	call	_send_header_payload_init
3603  01bd 5b03          	addw	sp,#3
3604                     ; 747 							UART2_Send_Data_Start();
3606  01bf cd0000        	call	_UART2_Send_Data_Start
3608                     ; 748 							break;
3610  01c2 acfb05fb      	jpf	L1441
3611  01c6               L3641:
3612                     ; 750 						else if((sicp_buf[8] != st1.st_ges2_ctrl_H) && (sicp_buf[9] != st1.st_ges2_ctrl_L))//第二个预设置手势
3614  01c6 c60008        	ld	a,_sicp_buf+8
3615  01c9 c10097        	cp	a,_st1+33
3616  01cc 2752          	jreq	L7641
3618  01ce c60009        	ld	a,_sicp_buf+9
3619  01d1 c10098        	cp	a,_st1+34
3620  01d4 274a          	jreq	L7641
3621                     ; 752 							st1.st_ges2_ctrl_H						= sicp_buf[8];
3623  01d6 5500080097    	mov	_st1+33,_sicp_buf+8
3624                     ; 753 							st1.st_ges2_ctrl_L						= sicp_buf[9];
3626  01db 5500090098    	mov	_st1+34,_sicp_buf+9
3627                     ; 754 							st1.st_ges2_ctrl_meshid_H 		= sicp_buf[10];
3629  01e0 55000a0099    	mov	_st1+35,_sicp_buf+10
3630                     ; 755 							st1.st_ges2_ctrl_meshid_L 		= sicp_buf[11];
3632  01e5 55000b009a    	mov	_st1+36,_sicp_buf+11
3633                     ; 756 							st1.st_ges2_ctrl_boardid 			= sicp_buf[12];
3635  01ea 55000c009b    	mov	_st1+37,_sicp_buf+12
3636                     ; 757 							st1.st_ges2_ctrl_action				= sicp_buf[13];
3638  01ef 55000d00a9    	mov	_st1+51,_sicp_buf+13
3639                     ; 758 							st1.st_ges2_ctrl_action_value = sicp_buf[14];
3641  01f4 55000e00aa    	mov	_st1+52,_sicp_buf+14
3642                     ; 760 							receipt_conf_gest1 = 1;
3644  01f9 721000c3      	bset	_UART1Flag6_,#0
3645                     ; 761 							send_message_length = 6;
3647  01fd 35060064      	mov	_send_message_length,#6
3648                     ; 762 							send_cmd = 0xAA;
3650  0201 35aa0063      	mov	_send_cmd,#170
3651                     ; 763 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3653  0205 4baa          	push	#170
3654  0207 4b06          	push	#6
3655  0209 3b006c        	push	_ns_own_meshid_L
3656  020c c6006d        	ld	a,_ns_own_meshid_H
3657  020f 97            	ld	xl,a
3658  0210 c60069        	ld	a,_rev_message_id
3659  0213 95            	ld	xh,a
3660  0214 cd0000        	call	_send_header_payload_init
3662  0217 5b03          	addw	sp,#3
3663                     ; 764 							UART2_Send_Data_Start();
3665  0219 cd0000        	call	_UART2_Send_Data_Start
3667                     ; 765 							break;
3669  021c acfb05fb      	jpf	L1441
3670  0220               L7641:
3671                     ; 767 						else if((sicp_buf[8] != st1.st_ges3_ctrl_H) && (sicp_buf[9] != st1.st_ges3_ctrl_L))//第三个预设置手势
3673  0220 c60008        	ld	a,_sicp_buf+8
3674  0223 c1009c        	cp	a,_st1+38
3675  0226 2752          	jreq	L3741
3677  0228 c60009        	ld	a,_sicp_buf+9
3678  022b c1009d        	cp	a,_st1+39
3679  022e 274a          	jreq	L3741
3680                     ; 769 							st1.st_ges3_ctrl_H						= sicp_buf[8];
3682  0230 550008009c    	mov	_st1+38,_sicp_buf+8
3683                     ; 770 							st1.st_ges3_ctrl_L						= sicp_buf[9];
3685  0235 550009009d    	mov	_st1+39,_sicp_buf+9
3686                     ; 771 							st1.st_ges3_ctrl_meshid_H 		= sicp_buf[10];
3688  023a 55000a009e    	mov	_st1+40,_sicp_buf+10
3689                     ; 772 							st1.st_ges3_ctrl_meshid_L 		= sicp_buf[11];
3691  023f 55000b009f    	mov	_st1+41,_sicp_buf+11
3692                     ; 773 							st1.st_ges3_ctrl_boardid 			= sicp_buf[12];
3694  0244 55000c00a0    	mov	_st1+42,_sicp_buf+12
3695                     ; 774 							st1.st_ges3_ctrl_action				= sicp_buf[13];
3697  0249 55000d00ac    	mov	_st1+54,_sicp_buf+13
3698                     ; 775 							st1.st_ges3_ctrl_action_value = sicp_buf[14];
3700  024e 55000e00ad    	mov	_st1+55,_sicp_buf+14
3701                     ; 777 							receipt_conf_gest1 = 1;
3703  0253 721000c3      	bset	_UART1Flag6_,#0
3704                     ; 778 							send_message_length = 6;
3706  0257 35060064      	mov	_send_message_length,#6
3707                     ; 779 							send_cmd = 0xAA;
3709  025b 35aa0063      	mov	_send_cmd,#170
3710                     ; 780 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3712  025f 4baa          	push	#170
3713  0261 4b06          	push	#6
3714  0263 3b006c        	push	_ns_own_meshid_L
3715  0266 c6006d        	ld	a,_ns_own_meshid_H
3716  0269 97            	ld	xl,a
3717  026a c60069        	ld	a,_rev_message_id
3718  026d 95            	ld	xh,a
3719  026e cd0000        	call	_send_header_payload_init
3721  0271 5b03          	addw	sp,#3
3722                     ; 781 							UART2_Send_Data_Start();
3724  0273 cd0000        	call	_UART2_Send_Data_Start
3726                     ; 782 							break;
3728  0276 acfb05fb      	jpf	L1441
3729  027a               L3741:
3730                     ; 784 						else if((sicp_buf[8] != st1.st_ges4_ctrl_H) && (sicp_buf[9] != st1.st_ges4_ctrl_L))//第三个预设置手势
3732  027a c60008        	ld	a,_sicp_buf+8
3733  027d c100a1        	cp	a,_st1+43
3734  0280 2752          	jreq	L7741
3736  0282 c60009        	ld	a,_sicp_buf+9
3737  0285 c100a2        	cp	a,_st1+44
3738  0288 274a          	jreq	L7741
3739                     ; 786 							st1.st_ges4_ctrl_H						= sicp_buf[8];
3741  028a 55000800a1    	mov	_st1+43,_sicp_buf+8
3742                     ; 787 							st1.st_ges4_ctrl_L						= sicp_buf[9];
3744  028f 55000900a2    	mov	_st1+44,_sicp_buf+9
3745                     ; 788 							st1.st_ges4_ctrl_meshid_H 		= sicp_buf[10];
3747  0294 55000a00a3    	mov	_st1+45,_sicp_buf+10
3748                     ; 789 							st1.st_ges4_ctrl_meshid_L 		= sicp_buf[11];
3750  0299 55000b00a4    	mov	_st1+46,_sicp_buf+11
3751                     ; 790 							st1.st_ges4_ctrl_boardid 			= sicp_buf[12];
3753  029e 55000c00a5    	mov	_st1+47,_sicp_buf+12
3754                     ; 791 							st1.st_ges4_ctrl_action				= sicp_buf[13];
3756  02a3 55000d00af    	mov	_st1+57,_sicp_buf+13
3757                     ; 792 							st1.st_ges4_ctrl_action_value = sicp_buf[14];
3759  02a8 55000e00b0    	mov	_st1+58,_sicp_buf+14
3760                     ; 794 							receipt_conf_gest1 = 1;
3762  02ad 721000c3      	bset	_UART1Flag6_,#0
3763                     ; 795 							send_message_length = 6;
3765  02b1 35060064      	mov	_send_message_length,#6
3766                     ; 796 							send_cmd = 0xAA;
3768  02b5 35aa0063      	mov	_send_cmd,#170
3769                     ; 797 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3771  02b9 4baa          	push	#170
3772  02bb 4b06          	push	#6
3773  02bd 3b006c        	push	_ns_own_meshid_L
3774  02c0 c6006d        	ld	a,_ns_own_meshid_H
3775  02c3 97            	ld	xl,a
3776  02c4 c60069        	ld	a,_rev_message_id
3777  02c7 95            	ld	xh,a
3778  02c8 cd0000        	call	_send_header_payload_init
3780  02cb 5b03          	addw	sp,#3
3781                     ; 798 							UART2_Send_Data_Start();
3783  02cd cd0000        	call	_UART2_Send_Data_Start
3785                     ; 799 							break;
3787  02d0 acfb05fb      	jpf	L1441
3788  02d4               L7741:
3789                     ; 801 						else if(((sicp_buf[8] == st1.st_ges1_ctrl_H) && (sicp_buf[9] == st1.st_ges1_ctrl_L))
3789                     ; 802 										|| ((sicp_buf[8] == st1.st_ges2_ctrl_H) && (sicp_buf[9] == st1.st_ges2_ctrl_L))
3789                     ; 803 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L))
3789                     ; 804 										|| ((sicp_buf[8] == st1.st_ges3_ctrl_H) && (sicp_buf[9] == st1.st_ges3_ctrl_L)))
3791  02d4 c60008        	ld	a,_sicp_buf+8
3792  02d7 c10092        	cp	a,_st1+28
3793  02da 2608          	jrne	L7051
3795  02dc c60009        	ld	a,_sicp_buf+9
3796  02df c10093        	cp	a,_st1+29
3797  02e2 2720          	jreq	L5051
3798  02e4               L7051:
3800  02e4 c60008        	ld	a,_sicp_buf+8
3801  02e7 c10097        	cp	a,_st1+33
3802  02ea 2608          	jrne	L3151
3804  02ec c60009        	ld	a,_sicp_buf+9
3805  02ef c10098        	cp	a,_st1+34
3806  02f2 2710          	jreq	L5051
3807  02f4               L3151:
3809  02f4 c60008        	ld	a,_sicp_buf+8
3810  02f7 c1009c        	cp	a,_st1+38
3811  02fa 262f          	jrne	L3051
3813  02fc c60009        	ld	a,_sicp_buf+9
3814  02ff c1009d        	cp	a,_st1+39
3815  0302 2627          	jrne	L3051
3816  0304               L5051:
3817                     ; 806 							receipt_conf_gest1 = 1;
3819  0304 721000c3      	bset	_UART1Flag6_,#0
3820                     ; 807 							send_message_length = 6;
3822  0308 35060064      	mov	_send_message_length,#6
3823                     ; 808 							send_cmd = 0xAA;
3825  030c 35aa0063      	mov	_send_cmd,#170
3826                     ; 809 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3828  0310 4baa          	push	#170
3829  0312 4b06          	push	#6
3830  0314 3b006c        	push	_ns_own_meshid_L
3831  0317 c6006d        	ld	a,_ns_own_meshid_H
3832  031a 97            	ld	xl,a
3833  031b c60069        	ld	a,_rev_message_id
3834  031e 95            	ld	xh,a
3835  031f cd0000        	call	_send_header_payload_init
3837  0322 5b03          	addw	sp,#3
3838                     ; 810 							UART2_Send_Data_Start();
3840  0324 cd0000        	call	_UART2_Send_Data_Start
3842                     ; 811 							break;
3844  0327 acfb05fb      	jpf	L1441
3845  032b               L3051:
3846                     ; 815 							receipt_conf_gest2 = 1;
3848  032b 721200c3      	bset	_UART1Flag6_,#1
3849                     ; 816 							send_message_length = 6;
3851  032f 35060064      	mov	_send_message_length,#6
3852                     ; 817 							send_cmd = 0xAA;
3854  0333 35aa0063      	mov	_send_cmd,#170
3855                     ; 818 							send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3857  0337 4baa          	push	#170
3858  0339 4b06          	push	#6
3859  033b 3b006c        	push	_ns_own_meshid_L
3860  033e c6006d        	ld	a,_ns_own_meshid_H
3861  0341 97            	ld	xl,a
3862  0342 c60069        	ld	a,_rev_message_id
3863  0345 95            	ld	xh,a
3864  0346 cd0000        	call	_send_header_payload_init
3866  0349 5b03          	addw	sp,#3
3867                     ; 819 							UART2_Send_Data_Start();
3869  034b cd0000        	call	_UART2_Send_Data_Start
3871                     ; 820 							break;
3873  034e acfb05fb      	jpf	L1441
3874  0352               L7531:
3875                     ; 825 			case 0xAA://SS回复ST的Device Info，Kick Out踢出
3875                     ; 826 				if (sicp_buf[7] == 0x04)
3877  0352 c60007        	ld	a,_sicp_buf+7
3878  0355 a104          	cp	a,#4
3879  0357 2703          	jreq	L431
3880  0359 cc05fb        	jp	L1441
3881  035c               L431:
3882                     ; 828 					kickout_flag = 1;
3884  035c 721000c5      	bset	_UART1Flag4_,#0
3885  0360 acfb05fb      	jpf	L1441
3886  0364               L1631:
3887                     ; 837 			case 0xC0://BLE 网络模块重置指令
3887                     ; 838 				if (sicp_buf[7] == 0x02)
3890  0364 c60007        	ld	a,_sicp_buf+7
3891  0367 a102          	cp	a,#2
3892  0369 2703          	jreq	L631
3893  036b cc05fb        	jp	L1441
3894  036e               L631:
3895                     ; 840 					net_reset_flag = 1;
3897  036e 721200c5      	bset	_UART1Flag4_,#1
3898  0372 acfb05fb      	jpf	L1441
3899  0376               L3631:
3900                     ; 843 			case 0x03://CMD-Data 
3900                     ; 844 				if (sicp_buf[7] == 0x01)//获取ST传感器信息
3902  0376 c60007        	ld	a,_sicp_buf+7
3903  0379 a101          	cp	a,#1
3904  037b 262d          	jrne	L3251
3905                     ; 846 					if ((sicp_buf[8] == 0x30) && (sicp_buf[9] == 0x32))
3907  037d c60008        	ld	a,_sicp_buf+8
3908  0380 a130          	cp	a,#48
3909  0382 2626          	jrne	L3251
3911  0384 c60009        	ld	a,_sicp_buf+9
3912  0387 a132          	cp	a,#50
3913  0389 261f          	jrne	L3251
3914                     ; 848 						send_message_length = 9;
3916  038b 35090064      	mov	_send_message_length,#9
3917                     ; 849 						send_cmd = 0x20;
3919  038f 35200063      	mov	_send_cmd,#32
3920                     ; 850 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3922  0393 4b20          	push	#32
3923  0395 4b09          	push	#9
3924  0397 3b006c        	push	_ns_own_meshid_L
3925  039a c6006d        	ld	a,_ns_own_meshid_H
3926  039d 97            	ld	xl,a
3927  039e c60069        	ld	a,_rev_message_id
3928  03a1 95            	ld	xh,a
3929  03a2 cd0000        	call	_send_header_payload_init
3931  03a5 5b03          	addw	sp,#3
3932                     ; 851 						UART2_Send_Data_Start();
3934  03a7 cd0000        	call	_UART2_Send_Data_Start
3936  03aa               L3251:
3937                     ; 854 				if (sicp_buf[7] == 0x02)//刷新ST传感器数据
3939  03aa c60007        	ld	a,_sicp_buf+7
3940  03ad a102          	cp	a,#2
3941  03af 2623          	jrne	L7251
3942                     ; 856 					cmd_refresh_flag = 1;
3944  03b1 721400c8      	bset	_UART1Flag1_,#2
3945                     ; 857 					send_message_length = 6;
3947  03b5 35060064      	mov	_send_message_length,#6
3948                     ; 858 					send_cmd = 0xAA;
3950  03b9 35aa0063      	mov	_send_cmd,#170
3951                     ; 859 					send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3953  03bd 4baa          	push	#170
3954  03bf 4b06          	push	#6
3955  03c1 3b006c        	push	_ns_own_meshid_L
3956  03c4 c6006d        	ld	a,_ns_own_meshid_H
3957  03c7 97            	ld	xl,a
3958  03c8 c60069        	ld	a,_rev_message_id
3959  03cb 95            	ld	xh,a
3960  03cc cd0000        	call	_send_header_payload_init
3962  03cf 5b03          	addw	sp,#3
3963                     ; 860 					UART2_Send_Data_Start();
3965  03d1 cd0000        	call	_UART2_Send_Data_Start
3967  03d4               L7251:
3968                     ; 862 				if (sicp_buf[7] == 0x03)//获取ST当前设备的状态(灯亮度、开关)
3970  03d4 c60007        	ld	a,_sicp_buf+7
3971  03d7 a103          	cp	a,#3
3972  03d9 2703          	jreq	L041
3973  03db cc05fb        	jp	L1441
3974  03de               L041:
3975                     ; 864 					cmd_status_flag = 1;
3977  03de 721600c8      	bset	_UART1Flag1_,#3
3978                     ; 866 					send_message_length = 10;
3980  03e2 350a0064      	mov	_send_message_length,#10
3981                     ; 867 					send_cmd = 0x06;
3983  03e6 35060063      	mov	_send_cmd,#6
3984                     ; 868 					send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
3986  03ea 4b06          	push	#6
3987  03ec 4b0a          	push	#10
3988  03ee 3b006c        	push	_ns_own_meshid_L
3989  03f1 c6006d        	ld	a,_ns_own_meshid_H
3990  03f4 97            	ld	xl,a
3991  03f5 c60069        	ld	a,_rev_message_id
3992  03f8 95            	ld	xh,a
3993  03f9 cd0000        	call	_send_header_payload_init
3995  03fc 5b03          	addw	sp,#3
3996                     ; 869 					UART2_Send_Data_Start();
3998  03fe cd0000        	call	_UART2_Send_Data_Start
4000  0401 acfb05fb      	jpf	L1441
4001  0405               L5631:
4002                     ; 872 			case 0x56://打开或关闭ST开关
4002                     ; 873 				action_ctrlpad_flag = 1;
4004  0405 721800c8      	bset	_UART1Flag1_,#4
4005                     ; 874 				st1.st_ctrl_address = sicp_buf[7];
4007  0409 5500070079    	mov	_st1+3,_sicp_buf+7
4008                     ; 875 				if((sicp_buf[7] & 0x01) == 0x01)
4010  040e c60007        	ld	a,_sicp_buf+7
4011  0411 a401          	and	a,#1
4012  0413 a101          	cp	a,#1
4013  0415 2604          	jrne	L3351
4014                     ; 876 					st_pad1_ctrl = 1;
4016  0417 721200c6      	bset	_UART1Flag3_,#1
4017  041b               L3351:
4018                     ; 877 				if((sicp_buf[7] & 0x02) == 0x02)
4020  041b c60007        	ld	a,_sicp_buf+7
4021  041e a402          	and	a,#2
4022  0420 a102          	cp	a,#2
4023  0422 2604          	jrne	L5351
4024                     ; 878 					st_pad2_ctrl = 1;
4026  0424 721400c6      	bset	_UART1Flag3_,#2
4027  0428               L5351:
4028                     ; 879 				if((sicp_buf[7] & 0x04) == 0x04)
4030  0428 c60007        	ld	a,_sicp_buf+7
4031  042b a404          	and	a,#4
4032  042d a104          	cp	a,#4
4033  042f 2604          	jrne	L7351
4034                     ; 880 					st_pad3_ctrl = 1;
4036  0431 721600c6      	bset	_UART1Flag3_,#3
4037  0435               L7351:
4038                     ; 881 				if((sicp_buf[7] & 0x08) == 0x08)
4040  0435 c60007        	ld	a,_sicp_buf+7
4041  0438 a408          	and	a,#8
4042  043a a108          	cp	a,#8
4043  043c 2604          	jrne	L1451
4044                     ; 882 					st_led_ctrl = 1;
4046  043e 721000c6      	bset	_UART1Flag3_,#0
4047  0442               L1451:
4048                     ; 883 				st1.st_ctrl_value  = sicp_buf[8];
4050  0442 550008007a    	mov	_st1+4,_sicp_buf+8
4051                     ; 884 				send_message_length = 10;
4053  0447 350a0064      	mov	_send_message_length,#10
4054                     ; 885 				send_cmd = 0xAA;
4056  044b 35aa0063      	mov	_send_cmd,#170
4057                     ; 886 				send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4059  044f 4baa          	push	#170
4060  0451 4b0a          	push	#10
4061  0453 3b006c        	push	_ns_own_meshid_L
4062  0456 c6006d        	ld	a,_ns_own_meshid_H
4063  0459 97            	ld	xl,a
4064  045a c60069        	ld	a,_rev_message_id
4065  045d 95            	ld	xh,a
4066  045e cd0000        	call	_send_header_payload_init
4068  0461 5b03          	addw	sp,#3
4069                     ; 888 				UART2_Send_Data_Start();
4071  0463 cd0000        	call	_UART2_Send_Data_Start
4073                     ; 889 				break;
4075  0466 acfb05fb      	jpf	L1441
4076  046a               L7631:
4077                     ; 890 			case 0x09://LED控制
4077                     ; 891 				led_ctrl_flag = 1;
4079  046a 721400c5      	bset	_UART1Flag4_,#2
4080                     ; 892 				switch(sicp_buf[7])
4082  046e c60007        	ld	a,_sicp_buf+7
4084                     ; 959 						break;
4085  0471 a01f          	sub	a,#31
4086  0473 271d          	jreq	L1731
4087  0475 a010          	sub	a,#16
4088  0477 2768          	jreq	L3731
4089  0479 a010          	sub	a,#16
4090  047b 2603          	jrne	L241
4091  047d cc053a        	jp	L5731
4092  0480               L241:
4093  0480 a010          	sub	a,#16
4094  0482 2603          	jrne	L441
4095  0484 cc0587        	jp	L7731
4096  0487               L441:
4097  0487 a010          	sub	a,#16
4098  0489 2603          	jrne	L641
4099  048b cc05ac        	jp	L1041
4100  048e               L641:
4101  048e acfb05fb      	jpf	L1441
4102  0492               L1731:
4103                     ; 894 					case 0x1F://循环模式
4103                     ; 895 						st1.st_led_mode = 0x1F;
4105  0492 351f00b2      	mov	_st1+60,#31
4106                     ; 896 						st1.st_led_density = sicp_buf[8];
4108  0496 55000800b3    	mov	_st1+61,_sicp_buf+8
4109                     ; 897 						st1.st_led_speed = sicp_buf[9];
4111  049b 55000900b4    	mov	_st1+62,_sicp_buf+9
4112                     ; 898 						st1.st_led_color1_H = sicp_buf[10];
4114  04a0 55000a00b5    	mov	_st1+63,_sicp_buf+10
4115                     ; 899 						st1.st_led_color1_M = sicp_buf[11];
4117  04a5 55000b00b6    	mov	_st1+64,_sicp_buf+11
4118                     ; 900 						st1.st_led_color1_L = sicp_buf[12];
4120  04aa 55000c00b7    	mov	_st1+65,_sicp_buf+12
4121                     ; 901 						st1.st_led_color2_H = sicp_buf[13];
4123  04af 55000d00b8    	mov	_st1+66,_sicp_buf+13
4124                     ; 902 						st1.st_led_color2_M = sicp_buf[14];
4126  04b4 55000e00b9    	mov	_st1+67,_sicp_buf+14
4127                     ; 903 						st1.st_led_color2_L = sicp_buf[15];
4129  04b9 55000f00ba    	mov	_st1+68,_sicp_buf+15
4130                     ; 904 						send_message_length = 6;
4132  04be 35060064      	mov	_send_message_length,#6
4133                     ; 905 						send_cmd = 0xAA;
4135  04c2 35aa0063      	mov	_send_cmd,#170
4136                     ; 906 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4138  04c6 4baa          	push	#170
4139  04c8 4b06          	push	#6
4140  04ca 3b006c        	push	_ns_own_meshid_L
4141  04cd c6006d        	ld	a,_ns_own_meshid_H
4142  04d0 97            	ld	xl,a
4143  04d1 c60069        	ld	a,_rev_message_id
4144  04d4 95            	ld	xh,a
4145  04d5 cd0000        	call	_send_header_payload_init
4147  04d8 5b03          	addw	sp,#3
4148                     ; 908 						UART2_Send_Data_Start();
4150  04da cd0000        	call	_UART2_Send_Data_Start
4152                     ; 909 						break;
4154  04dd acfb05fb      	jpf	L1441
4155  04e1               L3731:
4156                     ; 910 					case 0x2F://呼吸灯模式
4156                     ; 911 						st1.st_led_mode = 0x2F;
4158  04e1 352f00b2      	mov	_st1+60,#47
4159                     ; 912 						st1.st_led_in		= sicp_buf[8];
4161  04e5 55000800bb    	mov	_st1+69,_sicp_buf+8
4162                     ; 913 						st1.st_led_duration = sicp_buf[9];
4164  04ea 55000900bc    	mov	_st1+70,_sicp_buf+9
4165                     ; 914 						st1.st_led_out	= sicp_buf[10];
4167  04ef 55000a00bd    	mov	_st1+71,_sicp_buf+10
4168                     ; 915 						st1.st_led_blank = sicp_buf[11];
4170  04f4 55000b00be    	mov	_st1+72,_sicp_buf+11
4171                     ; 916 						st1.st_led_color1_H = sicp_buf[12];
4173  04f9 55000c00b5    	mov	_st1+63,_sicp_buf+12
4174                     ; 917 						st1.st_led_color1_M = sicp_buf[13];
4176  04fe 55000d00b6    	mov	_st1+64,_sicp_buf+13
4177                     ; 918 						st1.st_led_color1_L = sicp_buf[14];
4179  0503 55000e00b7    	mov	_st1+65,_sicp_buf+14
4180                     ; 919 						st1.st_led_color2_H = sicp_buf[15];
4182  0508 55000f00b8    	mov	_st1+66,_sicp_buf+15
4183                     ; 920 						st1.st_led_color2_M = sicp_buf[16];
4185  050d 55001000b9    	mov	_st1+67,_sicp_buf+16
4186                     ; 921 						st1.st_led_color2_L = sicp_buf[17];
4188  0512 55001100ba    	mov	_st1+68,_sicp_buf+17
4189                     ; 922 						send_message_length = 6;
4191  0517 35060064      	mov	_send_message_length,#6
4192                     ; 923 						send_cmd = 0xAA;
4194  051b 35aa0063      	mov	_send_cmd,#170
4195                     ; 924 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4197  051f 4baa          	push	#170
4198  0521 4b06          	push	#6
4199  0523 3b006c        	push	_ns_own_meshid_L
4200  0526 c6006d        	ld	a,_ns_own_meshid_H
4201  0529 97            	ld	xl,a
4202  052a c60069        	ld	a,_rev_message_id
4203  052d 95            	ld	xh,a
4204  052e cd0000        	call	_send_header_payload_init
4206  0531 5b03          	addw	sp,#3
4207                     ; 926 						UART2_Send_Data_Start();
4209  0533 cd0000        	call	_UART2_Send_Data_Start
4211                     ; 927 						break;
4213  0536 acfb05fb      	jpf	L1441
4214  053a               L5731:
4215                     ; 928 					case 0x3F://颜色变化模式，从一个主颜色渐变黑色再变到另一个主颜色
4215                     ; 929 						st1.st_led_mode = 0x3F;
4217  053a 353f00b2      	mov	_st1+60,#63
4218                     ; 930 						st1.st_led_in		= sicp_buf[8];
4220  053e 55000800bb    	mov	_st1+69,_sicp_buf+8
4221                     ; 931 						st1.st_led_duration = sicp_buf[9];
4223  0543 55000900bc    	mov	_st1+70,_sicp_buf+9
4224                     ; 932 						st1.st_led_color1_H = sicp_buf[10];
4226  0548 55000a00b5    	mov	_st1+63,_sicp_buf+10
4227                     ; 933 						st1.st_led_color1_M = sicp_buf[11];
4229  054d 55000b00b6    	mov	_st1+64,_sicp_buf+11
4230                     ; 934 						st1.st_led_color1_L = sicp_buf[12];
4232  0552 55000c00b7    	mov	_st1+65,_sicp_buf+12
4233                     ; 935 						st1.st_led_color2_H = sicp_buf[13];
4235  0557 55000d00b8    	mov	_st1+66,_sicp_buf+13
4236                     ; 936 						st1.st_led_color2_M = sicp_buf[14];
4238  055c 55000e00b9    	mov	_st1+67,_sicp_buf+14
4239                     ; 937 						st1.st_led_color2_L = sicp_buf[15];
4241  0561 55000f00ba    	mov	_st1+68,_sicp_buf+15
4242                     ; 938 						send_message_length = 6;
4244  0566 35060064      	mov	_send_message_length,#6
4245                     ; 939 						send_cmd = 0xAA;
4247  056a 35aa0063      	mov	_send_cmd,#170
4248                     ; 940 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4250  056e 4baa          	push	#170
4251  0570 4b06          	push	#6
4252  0572 3b006c        	push	_ns_own_meshid_L
4253  0575 c6006d        	ld	a,_ns_own_meshid_H
4254  0578 97            	ld	xl,a
4255  0579 c60069        	ld	a,_rev_message_id
4256  057c 95            	ld	xh,a
4257  057d cd0000        	call	_send_header_payload_init
4259  0580 5b03          	addw	sp,#3
4260                     ; 942 						UART2_Send_Data_Start();
4262  0582 cd0000        	call	_UART2_Send_Data_Start
4264                     ; 943 						break;
4266  0585 2074          	jra	L1441
4267  0587               L7731:
4268                     ; 944 					case 0x4F://指示灯模式，把LED的显示权交给设备
4268                     ; 945 						st1.st_led_mode = 0x4F;
4270  0587 354f00b2      	mov	_st1+60,#79
4271                     ; 946 						send_message_length = 6;
4273  058b 35060064      	mov	_send_message_length,#6
4274                     ; 947 						send_cmd = 0xAA;
4276  058f 35aa0063      	mov	_send_cmd,#170
4277                     ; 948 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4279  0593 4baa          	push	#170
4280  0595 4b06          	push	#6
4281  0597 3b006c        	push	_ns_own_meshid_L
4282  059a c6006d        	ld	a,_ns_own_meshid_H
4283  059d 97            	ld	xl,a
4284  059e c60069        	ld	a,_rev_message_id
4285  05a1 95            	ld	xh,a
4286  05a2 cd0000        	call	_send_header_payload_init
4288  05a5 5b03          	addw	sp,#3
4289                     ; 950 						UART2_Send_Data_Start();
4291  05a7 cd0000        	call	_UART2_Send_Data_Start
4293                     ; 951 						break;
4295  05aa 204f          	jra	L1441
4296  05ac               L1041:
4297                     ; 952 					case 0x5F://关闭模式。关闭所有LED显示 
4297                     ; 953 						st1.st_led_mode = 0x5F;
4299  05ac 355f00b2      	mov	_st1+60,#95
4300                     ; 954 						send_message_length = 6;
4302  05b0 35060064      	mov	_send_message_length,#6
4303                     ; 955 						send_cmd = 0xAA;
4305  05b4 35aa0063      	mov	_send_cmd,#170
4306                     ; 956 						send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4308  05b8 4baa          	push	#170
4309  05ba 4b06          	push	#6
4310  05bc 3b006c        	push	_ns_own_meshid_L
4311  05bf c6006d        	ld	a,_ns_own_meshid_H
4312  05c2 97            	ld	xl,a
4313  05c3 c60069        	ld	a,_rev_message_id
4314  05c6 95            	ld	xh,a
4315  05c7 cd0000        	call	_send_header_payload_init
4317  05ca 5b03          	addw	sp,#3
4318                     ; 958 						UART2_Send_Data_Start();
4320  05cc cd0000        	call	_UART2_Send_Data_Start
4322                     ; 959 						break;
4324  05cf 202a          	jra	L1441
4325  05d1               L5451:
4326                     ; 961 				break;
4328  05d1 2028          	jra	L1441
4329  05d3               L3041:
4330                     ; 962 			case 0x05://用于加载预装的报警信息，若此方法激活，则忽略所有 LED方法
4330                     ; 963 				load_alert_flag = 1;
4332  05d3 721600c5      	bset	_UART1Flag4_,#3
4333                     ; 964 				st1.st_load_alert = sicp_buf[7];
4335  05d7 55000700bf    	mov	_st1+73,_sicp_buf+7
4336                     ; 965 				send_message_length = 6;
4338  05dc 35060064      	mov	_send_message_length,#6
4339                     ; 966 				send_cmd = 0xAA;
4341  05e0 35aa0063      	mov	_send_cmd,#170
4342                     ; 967 				send_header_payload_init(rev_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4344  05e4 4baa          	push	#170
4345  05e6 4b06          	push	#6
4346  05e8 3b006c        	push	_ns_own_meshid_L
4347  05eb c6006d        	ld	a,_ns_own_meshid_H
4348  05ee 97            	ld	xl,a
4349  05ef c60069        	ld	a,_rev_message_id
4350  05f2 95            	ld	xh,a
4351  05f3 cd0000        	call	_send_header_payload_init
4353  05f6 5b03          	addw	sp,#3
4354                     ; 969 				UART2_Send_Data_Start();
4356  05f8 cd0000        	call	_UART2_Send_Data_Start
4358                     ; 970 				break;
4360  05fb               L5041:
4361                     ; 971 			default:
4361                     ; 972 				break;
4363  05fb               L1441:
4364                     ; 975 		return TRUE;
4366  05fb a601          	ld	a,#1
4369  05fd 85            	popw	x
4370  05fe 81            	ret
4371  05ff               L5341:
4372                     ; 977 	else if (ble_ctrl_frame)
4374  05ff c600c8        	ld	a,_UART1Flag1_
4375  0602 a540          	bcp	a,#64
4376  0604 2603          	jrne	L051
4377  0606 cc06be        	jp	L1551
4378  0609               L051:
4379                     ; 979 		ble_ctrl_frame = 0;
4381  0609 721d00c8      	bres	_UART1Flag1_,#6
4382                     ; 980 		switch(sicp_buf[4])
4384  060d c60004        	ld	a,_sicp_buf+4
4385  0610 a101          	cp	a,#1
4386  0612 2623          	jrne	L5551
4389  0614               L7041:
4390                     ; 982 			case 0x01://网络状态帧
4390                     ; 983 				ns_signal = sicp_buf[5];
4392  0614 5500050070    	mov	_ns_signal,_sicp_buf+5
4393                     ; 984 				ns_status = sicp_buf[6];
4395  0619 550006006f    	mov	_ns_status,_sicp_buf+6
4396                     ; 985 				ns_phonenum = sicp_buf[7];
4398  061e 550007006e    	mov	_ns_phonenum,_sicp_buf+7
4399                     ; 986 				ns_own_meshid_H = sicp_buf[8];
4401  0623 550008006d    	mov	_ns_own_meshid_H,_sicp_buf+8
4402                     ; 987 				ns_own_meshid_L = sicp_buf[9];
4404  0628 550009006c    	mov	_ns_own_meshid_L,_sicp_buf+9
4405                     ; 988 				ns_host_meshid_H = sicp_buf[10];
4407  062d 55000a006b    	mov	_ns_host_meshid_H,_sicp_buf+10
4408                     ; 989 				ns_host_meshid_L = sicp_buf[11];
4410  0632 55000b006a    	mov	_ns_host_meshid_L,_sicp_buf+11
4411                     ; 990 				break;
4413  0637               L1141:
4414                     ; 991 			case 0x02://重置芯片，清空串口缓存，保留mesh连接
4414                     ; 992 				break;
4416  0637               L3141:
4417                     ; 993 			case 0x03://重置芯片和网络，退出mesh连接
4417                     ; 994 				break;
4419  0637               L5551:
4420                     ; 996 		generate_messageid = 0x86;//for debug
4422  0637 35860060      	mov	_generate_messageid,#134
4423                     ; 998 		device_info_message_id = generate_messageid;
4425  063b 35860075      	mov	_device_info_message_id,#134
4426                     ; 1000 		if ((((u16)(ns_own_meshid_H<<8) + (u16)ns_own_meshid_L) > 0)
4426                     ; 1001 			&& (((u16)(ns_host_meshid_H<<8) + (u16)ns_host_meshid_L) > 0))
4428  063f c6006c        	ld	a,_ns_own_meshid_L
4429  0642 5f            	clrw	x
4430  0643 97            	ld	xl,a
4431  0644 1f01          	ldw	(OFST-1,sp),x
4432  0646 c6006d        	ld	a,_ns_own_meshid_H
4433  0649 5f            	clrw	x
4434  064a 97            	ld	xl,a
4435  064b 4f            	clr	a
4436  064c 02            	rlwa	x,a
4437  064d 72fb01        	addw	x,(OFST-1,sp)
4438  0650 2740          	jreq	L7551
4440  0652 c6006a        	ld	a,_ns_host_meshid_L
4441  0655 5f            	clrw	x
4442  0656 97            	ld	xl,a
4443  0657 1f01          	ldw	(OFST-1,sp),x
4444  0659 c6006b        	ld	a,_ns_host_meshid_H
4445  065c 5f            	clrw	x
4446  065d 97            	ld	xl,a
4447  065e 4f            	clr	a
4448  065f 02            	rlwa	x,a
4449  0660 72fb01        	addw	x,(OFST-1,sp)
4450  0663 272d          	jreq	L7551
4451                     ; 1003 			if (!receipt_device_info1)
4453  0665 c600c4        	ld	a,_UART1Flag5_
4454  0668 a501          	bcp	a,#1
4455  066a 264e          	jrne	L3651
4456                     ; 1007 				send_message_length = 12;
4458  066c 350c0064      	mov	_send_message_length,#12
4459                     ; 1008 				send_cmd = 0xB4;
4461  0670 35b40063      	mov	_send_cmd,#180
4462                     ; 1009 				send_header_payload_init(device_info_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4464  0674 4bb4          	push	#180
4465  0676 4b0c          	push	#12
4466  0678 3b006c        	push	_ns_own_meshid_L
4467  067b c6006d        	ld	a,_ns_own_meshid_H
4468  067e 97            	ld	xl,a
4469  067f a686          	ld	a,#134
4470  0681 95            	ld	xh,a
4471  0682 cd0000        	call	_send_header_payload_init
4473  0685 5b03          	addw	sp,#3
4474                     ; 1011 				UART2_Send_Data_Start();
4476  0687 cd0000        	call	_UART2_Send_Data_Start
4478                     ; 1012 				delay(10);
4480  068a ae000a        	ldw	x,#10
4481  068d cd0000        	call	_delay
4483  0690 2028          	jra	L3651
4484  0692               L7551:
4485                     ; 1017 			receipt_device_info2 = 1;
4487  0692 721000c4      	bset	_UART1Flag5_,#0
4488                     ; 1018 			send_message_length = 6;
4490  0696 35060064      	mov	_send_message_length,#6
4491                     ; 1019 			send_cmd = 0xAA;
4493  069a 35aa0063      	mov	_send_cmd,#170
4494                     ; 1020 			send_header_payload_init(device_info_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
4496  069e 4baa          	push	#170
4497  06a0 4b06          	push	#6
4498  06a2 3b006c        	push	_ns_own_meshid_L
4499  06a5 c6006d        	ld	a,_ns_own_meshid_H
4500  06a8 97            	ld	xl,a
4501  06a9 a686          	ld	a,#134
4502  06ab 95            	ld	xh,a
4503  06ac cd0000        	call	_send_header_payload_init
4505  06af 5b03          	addw	sp,#3
4506                     ; 1021 			UART2_Send_Data_Start();
4508  06b1 cd0000        	call	_UART2_Send_Data_Start
4510                     ; 1022 			delay(10);
4512  06b4 ae000a        	ldw	x,#10
4513  06b7 cd0000        	call	_delay
4515  06ba               L3651:
4516                     ; 1024 		return TRUE;
4518  06ba a601          	ld	a,#1
4520  06bc 2001          	jra	L011
4521  06be               L1551:
4522                     ; 1028 		return FALSE;
4524  06be 4f            	clr	a
4526  06bf               L011:
4528  06bf 85            	popw	x
4529  06c0 81            	ret
4580                     ; 1037 void reve_analyze_reply(void)
4580                     ; 1038 {
4581                     .text:	section	.text,new
4582  0000               _reve_analyze_reply:
4584  0000 89            	pushw	x
4585       00000002      OFST:	set	2
4588                     ; 1039 	if (rev_success)
4590  0001 c600c8        	ld	a,_UART1Flag1_
4591  0004 a501          	bcp	a,#1
4592  0006 271b          	jreq	L7751
4593                     ; 1041 		rev_success = 0;
4595  0008 721100c8      	bres	_UART1Flag1_,#0
4596                     ; 1042 		rev_header_anaylze(&rev_message_id,&rev_meshid_H,&rev_meshid_L,&rev_message_length);
4598  000c ae0067        	ldw	x,#_rev_message_length
4599  000f 89            	pushw	x
4600  0010 ae0065        	ldw	x,#_rev_meshid_L
4601  0013 89            	pushw	x
4602  0014 ae0066        	ldw	x,#_rev_meshid_H
4603  0017 89            	pushw	x
4604  0018 ae0069        	ldw	x,#_rev_message_id
4605  001b cd0000        	call	_rev_header_anaylze
4607  001e 5b06          	addw	sp,#6
4608                     ; 1043 		rev_payload_anaylze();
4610  0020 cd0000        	call	_rev_payload_anaylze
4612  0023               L7751:
4613                     ; 1051 	if (receipt_send_failed)
4615  0023 c600c4        	ld	a,_UART1Flag5_
4616  0026 a510          	bcp	a,#16
4617  0028 273a          	jreq	L1061
4618                     ; 1053 		receipt_send_failed = 0;
4620  002a 721900c4      	bres	_UART1Flag5_,#4
4621                     ; 1054 		st_pad1_ctrl = st_pad_temp._flag_bit.bit0;
4623                     	btst		_st_pad_temp,#0
4624  0033 901300c6      	bccm	_UART1Flag3_,#1
4625                     ; 1055 		st_pad2_ctrl = st_pad_temp._flag_bit.bit1;
4627                     	btst		_st_pad_temp,#1
4628  003c 901500c6      	bccm	_UART1Flag3_,#2
4629                     ; 1056 		st_pad3_ctrl = st_pad_temp._flag_bit.bit2;
4631                     	btst		_st_pad_temp,#2
4632  0045 901700c6      	bccm	_UART1Flag3_,#3
4633                     ; 1057 		st_pad1_confirm = st_pad_temp._flag_bit.bit3;
4635                     	btst		_st_pad_temp,#3
4636  004e 901900c6      	bccm	_UART1Flag3_,#4
4637                     ; 1058 		st_pad2_confirm = st_pad_temp._flag_bit.bit4;
4639                     	btst		_st_pad_temp,#4
4640  0057 901b00c6      	bccm	_UART1Flag3_,#5
4641                     ; 1059 		st_pad3_confirm = st_pad_temp._flag_bit.bit5;
4643                     	btst		_st_pad_temp,#5
4644  0060 901d00c6      	bccm	_UART1Flag3_,#6
4645  0064               L1061:
4646                     ; 1062 	if (receipt_send_failed)
4648  0064 c600c4        	ld	a,_UART1Flag5_
4649  0067 a510          	bcp	a,#16
4650  0069 270e          	jreq	L3061
4651                     ; 1064 		receipt_send_failed = 0;
4653  006b 721900c4      	bres	_UART1Flag5_,#4
4654                     ; 1065 		st1.st_ges_H = st1_st_ges_H_temp;
4656  006f 5500c20076    	mov	_st1,_st1_st_ges_H_temp
4657                     ; 1066 		st1.st_ges_L = st1_st_ges_L_temp;
4659  0074 5500c10077    	mov	_st1+1,_st1_st_ges_L_temp
4660  0079               L3061:
4661                     ; 1069 	if (st_pad1_ctrl | st_pad2_ctrl | st_pad3_ctrl)
4663  0079 4f            	clr	a
4664                     	btst	_UART1Flag3_,#3
4665  007f 49            	rlc	a
4666  0080 6b02          	ld	(OFST+0,sp),a
4667  0082 4f            	clr	a
4668                     	btst	_UART1Flag3_,#2
4669  0088 49            	rlc	a
4670  0089 6b01          	ld	(OFST-1,sp),a
4671  008b c600c6        	ld	a,_UART1Flag3_
4672  008e 44            	srl	a
4673  008f a401          	and	a,#1
4674  0091 1a01          	or	a,(OFST-1,sp)
4675  0093 1a02          	or	a,(OFST+0,sp)
4676  0095 2603          	jrne	L451
4677  0097 cc0256        	jp	L5061
4678  009a               L451:
4679                     ; 1072 		if(st_pad1_confirm | st_pad2_confirm | st_pad3_confirm)
4681  009a 4f            	clr	a
4682                     	btst	_UART1Flag3_,#6
4683  00a0 49            	rlc	a
4684  00a1 6b02          	ld	(OFST+0,sp),a
4685  00a3 4f            	clr	a
4686                     	btst	_UART1Flag3_,#5
4687  00a9 49            	rlc	a
4688  00aa 6b01          	ld	(OFST-1,sp),a
4689  00ac 4f            	clr	a
4690                     	btst	_UART1Flag3_,#4
4691  00b2 49            	rlc	a
4692  00b3 1a01          	or	a,(OFST-1,sp)
4693  00b5 1a02          	or	a,(OFST+0,sp)
4694  00b7 2603          	jrne	L651
4695  00b9 cc01e4        	jp	L7061
4696  00bc               L651:
4697                     ; 1074 			st_pad_temp._flag_bit.bit0 = st_pad1_ctrl;
4699                     	btst		_UART1Flag3_,#1
4700  00c1 901100c0      	bccm	_st_pad_temp,#0
4701                     ; 1075 			st_pad_temp._flag_bit.bit1 = st_pad2_ctrl;
4703                     	btst		_UART1Flag3_,#2
4704  00ca 901300c0      	bccm	_st_pad_temp,#1
4705                     ; 1076 			st_pad_temp._flag_bit.bit2 = st_pad3_ctrl;
4707                     	btst		_UART1Flag3_,#3
4708  00d3 901500c0      	bccm	_st_pad_temp,#2
4709                     ; 1077 			st_pad_temp._flag_bit.bit3 = st_pad1_confirm;
4711                     	btst		_UART1Flag3_,#4
4712  00dc 901700c0      	bccm	_st_pad_temp,#3
4713                     ; 1078 			st_pad_temp._flag_bit.bit4 = st_pad2_confirm;
4715                     	btst		_UART1Flag3_,#5
4716  00e5 901900c0      	bccm	_st_pad_temp,#4
4717                     ; 1079 			st_pad_temp._flag_bit.bit5 = st_pad3_confirm;
4719                     	btst		_UART1Flag3_,#6
4720  00ee 901b00c0      	bccm	_st_pad_temp,#5
4721                     ; 1081 				generate_messageid = random(TIM4->CNTR);
4723  00f2 c65344        	ld	a,21316
4724  00f5 cd0000        	call	_random
4726  00f8 c70060        	ld	_generate_messageid,a
4727                     ; 1082 				send_message_length = 8;
4729  00fb 35080064      	mov	_send_message_length,#8
4730                     ; 1083 				send_cmd = 0x51;
4732  00ff 35510063      	mov	_send_cmd,#81
4733                     ; 1084 				if (st_pad1_confirm)//预设置按键1被触发
4735  0103 c600c6        	ld	a,_UART1Flag3_
4736  0106 a510          	bcp	a,#16
4737  0108 271a          	jreq	L1161
4738                     ; 1086 					st_pad1_ctrl = 0;
4740  010a 721300c6      	bres	_UART1Flag3_,#1
4741                     ; 1087 					send_header_payload_init(gesture_noset_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
4743  010e 4b51          	push	#81
4744  0110 4b08          	push	#8
4745  0112 3b0084        	push	_st1+14
4746  0115 c60083        	ld	a,_st1+13
4747  0118 97            	ld	xl,a
4748  0119 c60074        	ld	a,_gesture_noset_message_id
4749  011c 95            	ld	xh,a
4750  011d cd0000        	call	_send_header_payload_init
4752  0120 5b03          	addw	sp,#3
4754  0122 2040          	jra	L3161
4755  0124               L1161:
4756                     ; 1089 				else if (st_pad2_confirm)
4758  0124 c600c6        	ld	a,_UART1Flag3_
4759  0127 a520          	bcp	a,#32
4760  0129 271a          	jreq	L5161
4761                     ; 1091 					st_pad2_ctrl = 0;
4763  012b 721500c6      	bres	_UART1Flag3_,#2
4764                     ; 1092 					send_header_payload_init(gesture_noset_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
4766  012f 4b51          	push	#81
4767  0131 4b08          	push	#8
4768  0133 3b0089        	push	_st1+19
4769  0136 c60088        	ld	a,_st1+18
4770  0139 97            	ld	xl,a
4771  013a c60074        	ld	a,_gesture_noset_message_id
4772  013d 95            	ld	xh,a
4773  013e cd0000        	call	_send_header_payload_init
4775  0141 5b03          	addw	sp,#3
4777  0143 201f          	jra	L3161
4778  0145               L5161:
4779                     ; 1094 				else if (st_pad3_confirm)
4781  0145 c600c6        	ld	a,_UART1Flag3_
4782  0148 a540          	bcp	a,#64
4783  014a 2718          	jreq	L3161
4784                     ; 1096 					st_pad3_ctrl = 0;
4786  014c 721700c6      	bres	_UART1Flag3_,#3
4787                     ; 1097 					send_header_payload_init(gesture_noset_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
4789  0150 4b51          	push	#81
4790  0152 4b08          	push	#8
4791  0154 3b008e        	push	_st1+24
4792  0157 c6008d        	ld	a,_st1+23
4793  015a 97            	ld	xl,a
4794  015b c60074        	ld	a,_gesture_noset_message_id
4795  015e 95            	ld	xh,a
4796  015f cd0000        	call	_send_header_payload_init
4798  0162 5b03          	addw	sp,#3
4799  0164               L3161:
4800                     ; 1100 				UART2_Send_Data_Start();
4802  0164 cd0000        	call	_UART2_Send_Data_Start
4804                     ; 1101 				delay(10);
4806  0167 ae000a        	ldw	x,#10
4807  016a cd0000        	call	_delay
4809                     ; 1104 				clear_send_buf();
4811  016d cd0000        	call	_clear_send_buf
4813                     ; 1105 				send_message_length = 14;
4815  0170 350e0064      	mov	_send_message_length,#14
4816                     ; 1106 				send_cmd = 0x08;
4818  0174 35080063      	mov	_send_cmd,#8
4819                     ; 1107 				if (st_pad1_confirm)//预设置按键1被触发
4821  0178 c600c6        	ld	a,_UART1Flag3_
4822  017b a510          	bcp	a,#16
4823  017d 271a          	jreq	L3261
4824                     ; 1109 					st_pad1_confirm = 0;
4826  017f 721900c6      	bres	_UART1Flag3_,#4
4827                     ; 1110 					send_header_payload_init(gesture_noset_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
4829  0183 4b08          	push	#8
4830  0185 4b0e          	push	#14
4831  0187 3b0084        	push	_st1+14
4832  018a c60083        	ld	a,_st1+13
4833  018d 97            	ld	xl,a
4834  018e c60074        	ld	a,_gesture_noset_message_id
4835  0191 95            	ld	xh,a
4836  0192 cd0000        	call	_send_header_payload_init
4838  0195 5b03          	addw	sp,#3
4840  0197 2040          	jra	L5261
4841  0199               L3261:
4842                     ; 1112 				else if (st_pad2_confirm)
4844  0199 c600c6        	ld	a,_UART1Flag3_
4845  019c a520          	bcp	a,#32
4846  019e 271a          	jreq	L7261
4847                     ; 1114 					st_pad2_confirm = 0;
4849  01a0 721b00c6      	bres	_UART1Flag3_,#5
4850                     ; 1115 					send_header_payload_init(gesture_noset_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
4852  01a4 4b08          	push	#8
4853  01a6 4b0e          	push	#14
4854  01a8 3b0089        	push	_st1+19
4855  01ab c60088        	ld	a,_st1+18
4856  01ae 97            	ld	xl,a
4857  01af c60074        	ld	a,_gesture_noset_message_id
4858  01b2 95            	ld	xh,a
4859  01b3 cd0000        	call	_send_header_payload_init
4861  01b6 5b03          	addw	sp,#3
4863  01b8 201f          	jra	L5261
4864  01ba               L7261:
4865                     ; 1117 				else if(st_pad3_confirm)
4867  01ba c600c6        	ld	a,_UART1Flag3_
4868  01bd a540          	bcp	a,#64
4869  01bf 2718          	jreq	L5261
4870                     ; 1119 					st_pad2_confirm = 0;
4872  01c1 721b00c6      	bres	_UART1Flag3_,#5
4873                     ; 1120 					send_header_payload_init(gesture_noset_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
4875  01c5 4b08          	push	#8
4876  01c7 4b0e          	push	#14
4877  01c9 3b008e        	push	_st1+24
4878  01cc c6008d        	ld	a,_st1+23
4879  01cf 97            	ld	xl,a
4880  01d0 c60074        	ld	a,_gesture_noset_message_id
4881  01d3 95            	ld	xh,a
4882  01d4 cd0000        	call	_send_header_payload_init
4884  01d7 5b03          	addw	sp,#3
4885  01d9               L5261:
4886                     ; 1122 				UART2_Send_Data_Start();
4888  01d9 cd0000        	call	_UART2_Send_Data_Start
4890                     ; 1123 				delay(10);
4892  01dc ae000a        	ldw	x,#10
4893  01df cd0000        	call	_delay
4896  01e2 2072          	jra	L5061
4897  01e4               L7061:
4898                     ; 1127 			send_message_length = 7;
4900  01e4 35070064      	mov	_send_message_length,#7
4901                     ; 1128 			send_cmd = 0x35;
4903  01e8 35350063      	mov	_send_cmd,#53
4904                     ; 1129 			if (st_pad1_ctrl)
4906  01ec c600c6        	ld	a,_UART1Flag3_
4907  01ef a502          	bcp	a,#2
4908  01f1 271a          	jreq	L7361
4909                     ; 1131 				st_pad1_ctrl = 0;
4911  01f3 721300c6      	bres	_UART1Flag3_,#1
4912                     ; 1132 				send_header_payload_init(gesture_noset_message_id,st1.st_pad1_ctrl_meshid_H,st1.st_pad1_ctrl_meshid_L,send_message_length,send_cmd);
4914  01f7 4b35          	push	#53
4915  01f9 4b07          	push	#7
4916  01fb 3b0084        	push	_st1+14
4917  01fe c60083        	ld	a,_st1+13
4918  0201 97            	ld	xl,a
4919  0202 c60074        	ld	a,_gesture_noset_message_id
4920  0205 95            	ld	xh,a
4921  0206 cd0000        	call	_send_header_payload_init
4923  0209 5b03          	addw	sp,#3
4925  020b 2040          	jra	L1461
4926  020d               L7361:
4927                     ; 1134 			else if (st_pad2_ctrl)
4929  020d c600c6        	ld	a,_UART1Flag3_
4930  0210 a504          	bcp	a,#4
4931  0212 271a          	jreq	L3461
4932                     ; 1136 				st_pad2_ctrl = 0;
4934  0214 721500c6      	bres	_UART1Flag3_,#2
4935                     ; 1137 				send_header_payload_init(gesture_noset_message_id,st1.st_pad2_ctrl_meshid_H,st1.st_pad2_ctrl_meshid_L,send_message_length,send_cmd);
4937  0218 4b35          	push	#53
4938  021a 4b07          	push	#7
4939  021c 3b0089        	push	_st1+19
4940  021f c60088        	ld	a,_st1+18
4941  0222 97            	ld	xl,a
4942  0223 c60074        	ld	a,_gesture_noset_message_id
4943  0226 95            	ld	xh,a
4944  0227 cd0000        	call	_send_header_payload_init
4946  022a 5b03          	addw	sp,#3
4948  022c 201f          	jra	L1461
4949  022e               L3461:
4950                     ; 1139 			else if (st_pad3_ctrl)
4952  022e c600c6        	ld	a,_UART1Flag3_
4953  0231 a508          	bcp	a,#8
4954  0233 2718          	jreq	L1461
4955                     ; 1141 				st_pad3_ctrl = 0;
4957  0235 721700c6      	bres	_UART1Flag3_,#3
4958                     ; 1142 				send_header_payload_init(gesture_noset_message_id,st1.st_pad3_ctrl_meshid_H,st1.st_pad3_ctrl_meshid_L,send_message_length,send_cmd);
4960  0239 4b35          	push	#53
4961  023b 4b07          	push	#7
4962  023d 3b008e        	push	_st1+24
4963  0240 c6008d        	ld	a,_st1+23
4964  0243 97            	ld	xl,a
4965  0244 c60074        	ld	a,_gesture_noset_message_id
4966  0247 95            	ld	xh,a
4967  0248 cd0000        	call	_send_header_payload_init
4969  024b 5b03          	addw	sp,#3
4970  024d               L1461:
4971                     ; 1144 			UART2_Send_Data_Start();
4973  024d cd0000        	call	_UART2_Send_Data_Start
4975                     ; 1145 			delay(10);
4977  0250 ae000a        	ldw	x,#10
4978  0253 cd0000        	call	_delay
4980  0256               L5061:
4981                     ; 1152 	if(gest_detect){
4983  0256 c600c7        	ld	a,_UART1Flag2_
4984  0259 a501          	bcp	a,#1
4985  025b 2603          	jrne	L061
4986  025d cc0405        	jp	L1561
4987  0260               L061:
4988                     ; 1153 		gest_detect = 0;
4990  0260 721100c7      	bres	_UART1Flag2_,#0
4991                     ; 1154 		gest_confirm();
4993  0264 cd0000        	call	_gest_confirm
4995                     ; 1155 		if ((st1.st_ges_H != 0x00) && (st1.st_ges_L != 0x00))
4997  0267 725d0076      	tnz	_st1
4998  026b 2603          	jrne	L261
4999  026d cc0405        	jp	L1561
5000  0270               L261:
5002  0270 725d0077      	tnz	_st1+1
5003  0274 2603          	jrne	L461
5004  0276 cc0405        	jp	L1561
5005  0279               L461:
5006                     ; 1157 			st1_st_ges_H_temp = st1.st_ges_H;
5008  0279 55007600c2    	mov	_st1_st_ges_H_temp,_st1
5009                     ; 1158 			st1_st_ges_L_temp = st1.st_ges_L;
5011  027e 55007700c1    	mov	_st1_st_ges_L_temp,_st1+1
5012                     ; 1161 			if((!gest1_confirm) && (!gest2_confirm) && (!gest3_confirm) && (!gest4_confirm))
5014  0283 c600c7        	ld	a,_UART1Flag2_
5015  0286 a504          	bcp	a,#4
5016  0288 2658          	jrne	L5561
5018  028a c600c7        	ld	a,_UART1Flag2_
5019  028d a508          	bcp	a,#8
5020  028f 2651          	jrne	L5561
5022  0291 c600c7        	ld	a,_UART1Flag2_
5023  0294 a510          	bcp	a,#16
5024  0296 264a          	jrne	L5561
5026  0298 c600c7        	ld	a,_UART1Flag2_
5027  029b a520          	bcp	a,#32
5028  029d 2643          	jrne	L5561
5029                     ; 1163 				receipt_gesture1 = 0;//清除接收到该指令回执
5031  029f 721300c4      	bres	_UART1Flag5_,#1
5032                     ; 1164 				generate_messageid = random(TIM4->CNTR);
5034  02a3 c65344        	ld	a,21316
5035  02a6 cd0000        	call	_random
5037  02a9 c70060        	ld	_generate_messageid,a
5038                     ; 1165 				gesture_noset_message_id = generate_messageid;
5040  02ac 5500600074    	mov	_gesture_noset_message_id,_generate_messageid
5041                     ; 1167 				send_message_length = 8;
5043  02b1 35080064      	mov	_send_message_length,#8
5044                     ; 1168 				send_cmd = 0x29;
5046  02b5 35290063      	mov	_send_cmd,#41
5047                     ; 1169 				send_header_payload_init(gesture_noset_message_id,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5049  02b9 4b29          	push	#41
5050  02bb 4b08          	push	#8
5051  02bd 3b006c        	push	_ns_own_meshid_L
5052  02c0 c6006d        	ld	a,_ns_own_meshid_H
5053  02c3 97            	ld	xl,a
5054  02c4 c60074        	ld	a,_gesture_noset_message_id
5055  02c7 95            	ld	xh,a
5056  02c8 cd0000        	call	_send_header_payload_init
5058  02cb 5b03          	addw	sp,#3
5059                     ; 1171 				UART2_Send_Data_Start();
5061  02cd cd0000        	call	_UART2_Send_Data_Start
5063                     ; 1172 				delay(10);
5065  02d0 ae000a        	ldw	x,#10
5066  02d3 cd0000        	call	_delay
5068                     ; 1173 				st1.st_ges_H = 0x00;
5070  02d6 725f0076      	clr	_st1
5071                     ; 1174 				st1.st_ges_L = 0x00;
5073  02da 725f0077      	clr	_st1+1
5075  02de ac050405      	jpf	L1561
5076  02e2               L5561:
5077                     ; 1178 				receipt_gesture2 = 0;//清除接收到该指令回执
5079  02e2 721500c4      	bres	_UART1Flag5_,#2
5080                     ; 1179 				generate_messageid = random(TIM4->CNTR);
5082  02e6 c65344        	ld	a,21316
5083  02e9 cd0000        	call	_random
5085  02ec c70060        	ld	_generate_messageid,a
5086                     ; 1180 				gesture_set_message_id = generate_messageid;
5088  02ef 5500600073    	mov	_gesture_set_message_id,_generate_messageid
5089                     ; 1181 				send_message_length = 8;
5091  02f4 35080064      	mov	_send_message_length,#8
5092                     ; 1182 				send_cmd = 0x51;
5094  02f8 35510063      	mov	_send_cmd,#81
5095                     ; 1183 				if (gest1_confirm)
5097  02fc c600c7        	ld	a,_UART1Flag2_
5098  02ff a504          	bcp	a,#4
5099  0301 2716          	jreq	L1661
5100                     ; 1185 					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
5102  0303 4b51          	push	#81
5103  0305 4b08          	push	#8
5104  0307 3b0095        	push	_st1+31
5105  030a c60094        	ld	a,_st1+30
5106  030d 97            	ld	xl,a
5107  030e c60073        	ld	a,_gesture_set_message_id
5108  0311 95            	ld	xh,a
5109  0312 cd0000        	call	_send_header_payload_init
5111  0315 5b03          	addw	sp,#3
5113  0317 2055          	jra	L3661
5114  0319               L1661:
5115                     ; 1187 				else if (gest2_confirm)
5117  0319 c600c7        	ld	a,_UART1Flag2_
5118  031c a508          	bcp	a,#8
5119  031e 2716          	jreq	L5661
5120                     ; 1189 					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
5122  0320 4b51          	push	#81
5123  0322 4b08          	push	#8
5124  0324 3b009a        	push	_st1+36
5125  0327 c60099        	ld	a,_st1+35
5126  032a 97            	ld	xl,a
5127  032b c60060        	ld	a,_generate_messageid
5128  032e 95            	ld	xh,a
5129  032f cd0000        	call	_send_header_payload_init
5131  0332 5b03          	addw	sp,#3
5133  0334 2038          	jra	L3661
5134  0336               L5661:
5135                     ; 1191 				else if (gest3_confirm)
5137  0336 c600c7        	ld	a,_UART1Flag2_
5138  0339 a510          	bcp	a,#16
5139  033b 2716          	jreq	L1761
5140                     ; 1193 					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
5142  033d 4b51          	push	#81
5143  033f 4b08          	push	#8
5144  0341 3b009f        	push	_st1+41
5145  0344 c6009e        	ld	a,_st1+40
5146  0347 97            	ld	xl,a
5147  0348 c60060        	ld	a,_generate_messageid
5148  034b 95            	ld	xh,a
5149  034c cd0000        	call	_send_header_payload_init
5151  034f 5b03          	addw	sp,#3
5153  0351 201b          	jra	L3661
5154  0353               L1761:
5155                     ; 1195 				else if (gest4_confirm)
5157  0353 c600c7        	ld	a,_UART1Flag2_
5158  0356 a520          	bcp	a,#32
5159  0358 2714          	jreq	L3661
5160                     ; 1197 					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
5162  035a 4b51          	push	#81
5163  035c 4b08          	push	#8
5164  035e 3b00a4        	push	_st1+46
5165  0361 c600a3        	ld	a,_st1+45
5166  0364 97            	ld	xl,a
5167  0365 c60060        	ld	a,_generate_messageid
5168  0368 95            	ld	xh,a
5169  0369 cd0000        	call	_send_header_payload_init
5171  036c 5b03          	addw	sp,#3
5172  036e               L3661:
5173                     ; 1200 				UART2_Send_Data_Start();
5175  036e cd0000        	call	_UART2_Send_Data_Start
5177                     ; 1202 				delay(10);
5179  0371 ae000a        	ldw	x,#10
5180  0374 cd0000        	call	_delay
5182                     ; 1203 				clear_send_buf();
5184  0377 cd0000        	call	_clear_send_buf
5186                     ; 1204 				send_message_length = 14;
5188  037a 350e0064      	mov	_send_message_length,#14
5189                     ; 1205 				send_cmd = 0x08;
5191  037e 35080063      	mov	_send_cmd,#8
5192                     ; 1206 				if (gest1_confirm)
5194  0382 c600c7        	ld	a,_UART1Flag2_
5195  0385 a504          	bcp	a,#4
5196  0387 2716          	jreq	L7761
5197                     ; 1208 					send_header_payload_init(gesture_set_message_id,st1.st_ges1_ctrl_meshid_H,st1.st_ges1_ctrl_meshid_L,send_message_length,send_cmd);
5199  0389 4b08          	push	#8
5200  038b 4b0e          	push	#14
5201  038d 3b0095        	push	_st1+31
5202  0390 c60094        	ld	a,_st1+30
5203  0393 97            	ld	xl,a
5204  0394 c60073        	ld	a,_gesture_set_message_id
5205  0397 95            	ld	xh,a
5206  0398 cd0000        	call	_send_header_payload_init
5208  039b 5b03          	addw	sp,#3
5210  039d 2055          	jra	L1071
5211  039f               L7761:
5212                     ; 1210 				else if (gest2_confirm)
5214  039f c600c7        	ld	a,_UART1Flag2_
5215  03a2 a508          	bcp	a,#8
5216  03a4 2716          	jreq	L3071
5217                     ; 1212 					send_header_payload_init(generate_messageid,st1.st_ges2_ctrl_meshid_H,st1.st_ges2_ctrl_meshid_L,send_message_length,send_cmd);
5219  03a6 4b08          	push	#8
5220  03a8 4b0e          	push	#14
5221  03aa 3b009a        	push	_st1+36
5222  03ad c60099        	ld	a,_st1+35
5223  03b0 97            	ld	xl,a
5224  03b1 c60060        	ld	a,_generate_messageid
5225  03b4 95            	ld	xh,a
5226  03b5 cd0000        	call	_send_header_payload_init
5228  03b8 5b03          	addw	sp,#3
5230  03ba 2038          	jra	L1071
5231  03bc               L3071:
5232                     ; 1214 				else if (gest3_confirm)
5234  03bc c600c7        	ld	a,_UART1Flag2_
5235  03bf a510          	bcp	a,#16
5236  03c1 2716          	jreq	L7071
5237                     ; 1216 					send_header_payload_init(generate_messageid,st1.st_ges3_ctrl_meshid_H,st1.st_ges3_ctrl_meshid_L,send_message_length,send_cmd);
5239  03c3 4b08          	push	#8
5240  03c5 4b0e          	push	#14
5241  03c7 3b009f        	push	_st1+41
5242  03ca c6009e        	ld	a,_st1+40
5243  03cd 97            	ld	xl,a
5244  03ce c60060        	ld	a,_generate_messageid
5245  03d1 95            	ld	xh,a
5246  03d2 cd0000        	call	_send_header_payload_init
5248  03d5 5b03          	addw	sp,#3
5250  03d7 201b          	jra	L1071
5251  03d9               L7071:
5252                     ; 1218 				else if (gest4_confirm)
5254  03d9 c600c7        	ld	a,_UART1Flag2_
5255  03dc a520          	bcp	a,#32
5256  03de 2714          	jreq	L1071
5257                     ; 1220 					send_header_payload_init(generate_messageid,st1.st_ges4_ctrl_meshid_H,st1.st_ges4_ctrl_meshid_L,send_message_length,send_cmd);
5259  03e0 4b08          	push	#8
5260  03e2 4b0e          	push	#14
5261  03e4 3b00a4        	push	_st1+46
5262  03e7 c600a3        	ld	a,_st1+45
5263  03ea 97            	ld	xl,a
5264  03eb c60060        	ld	a,_generate_messageid
5265  03ee 95            	ld	xh,a
5266  03ef cd0000        	call	_send_header_payload_init
5268  03f2 5b03          	addw	sp,#3
5269  03f4               L1071:
5270                     ; 1223 				UART2_Send_Data_Start();
5272  03f4 cd0000        	call	_UART2_Send_Data_Start
5274                     ; 1224 				delay(10);
5276  03f7 ae000a        	ldw	x,#10
5277  03fa cd0000        	call	_delay
5279                     ; 1225 				st1.st_ges_H = 0x00;
5281  03fd 725f0076      	clr	_st1
5282                     ; 1226 				st1.st_ges_L = 0x00;
5284  0401 725f0077      	clr	_st1+1
5285  0405               L1561:
5286                     ; 1233 	if ((st1.st_device_status & 0xFF) < 0xFF)//ST有故障,有0无1
5288  0405 9c            	rvf
5289  0406 c60078        	ld	a,_st1+2
5290  0409 5f            	clrw	x
5291  040a 97            	ld	xl,a
5292  040b a300ff        	cpw	x,#255
5293  040e 2e3d          	jrsge	L5171
5294                     ; 1235 		send_fault_count++;
5296  0410 ce005c        	ldw	x,_send_fault_count
5297  0413 1c0001        	addw	x,#1
5298  0416 cf005c        	ldw	_send_fault_count,x
5299                     ; 1236 		if (send_fault_count >= 500)
5301  0419 ce005c        	ldw	x,_send_fault_count
5302  041c a301f4        	cpw	x,#500
5303  041f 252c          	jrult	L5171
5304                     ; 1238 			send_fault_count = 0;
5306  0421 5f            	clrw	x
5307  0422 cf005c        	ldw	_send_fault_count,x
5308                     ; 1239 			generate_messageid = random(TIM4->CNTR);
5310  0425 c65344        	ld	a,21316
5311  0428 cd0000        	call	_random
5313  042b c70060        	ld	_generate_messageid,a
5314                     ; 1240 			send_message_length = 7;
5316  042e 35070064      	mov	_send_message_length,#7
5317                     ; 1241 			send_cmd = 0x0A;
5319  0432 350a0063      	mov	_send_cmd,#10
5320                     ; 1242 			send_header_payload_init(generate_messageid,ns_own_meshid_H,ns_own_meshid_L,send_message_length,send_cmd);
5322  0436 4b0a          	push	#10
5323  0438 4b07          	push	#7
5324  043a 3b006c        	push	_ns_own_meshid_L
5325  043d c6006d        	ld	a,_ns_own_meshid_H
5326  0440 97            	ld	xl,a
5327  0441 c60060        	ld	a,_generate_messageid
5328  0444 95            	ld	xh,a
5329  0445 cd0000        	call	_send_header_payload_init
5331  0448 5b03          	addw	sp,#3
5332                     ; 1244 			UART2_Send_Data_Start();
5334  044a cd0000        	call	_UART2_Send_Data_Start
5336  044d               L5171:
5337                     ; 1247 }
5340  044d 85            	popw	x
5341  044e 81            	ret
5354                     	xref	_UART2_ITConfig
5355                     	xref	_UART2_Cmd
5356                     	xref	_UART2_Init
5357                     	xref	_UART2_DeInit
5358                     	xref	_rand
5359                     	xdef	_gest_confirm
5360                     	xdef	_pad_confirm
5361                     	xdef	_rev_payload_anaylze
5362                     	xdef	_rev_header_anaylze
5363                     	xdef	_send_header_payload_init
5364                     	xdef	_reve_analyze_reply
5365                     	xdef	_random
5366                     	xdef	_rev_deal
5367                     	xdef	_Check_Sum
5368                     	xdef	_clear_send_buf
5369                     	xdef	_clear_sicp_buf
5370                     	xdef	_UART2_Send_Data_Start
5371                     	xdef	_UART2_Send_Data_Init
5372                     	xdef	_UART2_RX_ISR
5373                     	xdef	_UART2_TX_ISR
5374                     	xdef	_Init_uart2
5375                     	switch	.bss
5376  0000               _sicp_buf:
5377  0000 000000000000  	ds.b	30
5378                     	xdef	_sicp_buf
5379  001e               _rev_buf:
5380  001e 000000000000  	ds.b	30
5381                     	xdef	_rev_buf
5382  003c               _send_buf:
5383  003c 000000000000  	ds.b	30
5384                     	xdef	_send_buf
5385  005a               _send_failed_count:
5386  005a 0000          	ds.b	2
5387                     	xdef	_send_failed_count
5388  005c               _send_fault_count:
5389  005c 0000          	ds.b	2
5390                     	xdef	_send_fault_count
5391  005e               _rev_count:
5392  005e 00            	ds.b	1
5393                     	xdef	_rev_count
5394  005f               _send_count:
5395  005f 00            	ds.b	1
5396                     	xdef	_send_count
5397  0060               _generate_messageid:
5398  0060 00            	ds.b	1
5399                     	xdef	_generate_messageid
5400  0061               _send_meshid_L:
5401  0061 00            	ds.b	1
5402                     	xdef	_send_meshid_L
5403  0062               _send_meshid_H:
5404  0062 00            	ds.b	1
5405                     	xdef	_send_meshid_H
5406  0063               _send_cmd:
5407  0063 00            	ds.b	1
5408                     	xdef	_send_cmd
5409  0064               _send_message_length:
5410  0064 00            	ds.b	1
5411                     	xdef	_send_message_length
5412  0065               _rev_meshid_L:
5413  0065 00            	ds.b	1
5414                     	xdef	_rev_meshid_L
5415  0066               _rev_meshid_H:
5416  0066 00            	ds.b	1
5417                     	xdef	_rev_meshid_H
5418  0067               _rev_message_length:
5419  0067 00            	ds.b	1
5420                     	xdef	_rev_message_length
5421  0068               _rev_module_id:
5422  0068 00            	ds.b	1
5423                     	xdef	_rev_module_id
5424  0069               _rev_message_id:
5425  0069 00            	ds.b	1
5426                     	xdef	_rev_message_id
5427  006a               _ns_host_meshid_L:
5428  006a 00            	ds.b	1
5429                     	xdef	_ns_host_meshid_L
5430  006b               _ns_host_meshid_H:
5431  006b 00            	ds.b	1
5432                     	xdef	_ns_host_meshid_H
5433  006c               _ns_own_meshid_L:
5434  006c 00            	ds.b	1
5435                     	xdef	_ns_own_meshid_L
5436  006d               _ns_own_meshid_H:
5437  006d 00            	ds.b	1
5438                     	xdef	_ns_own_meshid_H
5439  006e               _ns_phonenum:
5440  006e 00            	ds.b	1
5441                     	xdef	_ns_phonenum
5442  006f               _ns_status:
5443  006f 00            	ds.b	1
5444                     	xdef	_ns_status
5445  0070               _ns_signal:
5446  0070 00            	ds.b	1
5447                     	xdef	_ns_signal
5448  0071               _action_notify_message_id:
5449  0071 00            	ds.b	1
5450                     	xdef	_action_notify_message_id
5451  0072               _pad_noset_message_id:
5452  0072 00            	ds.b	1
5453                     	xdef	_pad_noset_message_id
5454  0073               _gesture_set_message_id:
5455  0073 00            	ds.b	1
5456                     	xdef	_gesture_set_message_id
5457  0074               _gesture_noset_message_id:
5458  0074 00            	ds.b	1
5459                     	xdef	_gesture_noset_message_id
5460  0075               _device_info_message_id:
5461  0075 00            	ds.b	1
5462                     	xdef	_device_info_message_id
5463  0076               _st1:
5464  0076 000000000000  	ds.b	74
5465                     	xdef	_st1
5466  00c0               _st_pad_temp:
5467  00c0 00            	ds.b	1
5468                     	xdef	_st_pad_temp
5469  00c1               _st1_st_ges_L_temp:
5470  00c1 00            	ds.b	1
5471                     	xdef	_st1_st_ges_L_temp
5472  00c2               _st1_st_ges_H_temp:
5473  00c2 00            	ds.b	1
5474                     	xdef	_st1_st_ges_H_temp
5475  00c3               _UART1Flag6_:
5476  00c3 00            	ds.b	1
5477                     	xdef	_UART1Flag6_
5478  00c4               _UART1Flag5_:
5479  00c4 00            	ds.b	1
5480                     	xdef	_UART1Flag5_
5481  00c5               _UART1Flag4_:
5482  00c5 00            	ds.b	1
5483                     	xdef	_UART1Flag4_
5484  00c6               _UART1Flag3_:
5485  00c6 00            	ds.b	1
5486                     	xdef	_UART1Flag3_
5487  00c7               _UART1Flag2_:
5488  00c7 00            	ds.b	1
5489                     	xdef	_UART1Flag2_
5490  00c8               _UART1Flag1_:
5491  00c8 00            	ds.b	1
5492                     	xdef	_UART1Flag1_
5493                     	xref	_delay
5494                     	xref.b	c_x
5495                     	xref.b	c_y
5515                     	xref	c_idiv
5516                     	end
