   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
1050                     	switch	.data
1051  0000               _BLE_uart:
1052  0000 00            	dc.b	0
1053  0001 000000000000  	ds.b	67
1115                     ; 30 u8 Check_Sum(u8 *buf, u8 length)
1115                     ; 31 {
1117                     .text:	section	.text,new
1118  0000               _Check_Sum:
1120  0000 89            	pushw	x
1121  0001 89            	pushw	x
1122       00000002      OFST:	set	2
1125                     ; 32 	u8 i, result = *buf++;
1127  0002 1e03          	ldw	x,(OFST+1,sp)
1128  0004 1c0001        	addw	x,#1
1129  0007 1f03          	ldw	(OFST+1,sp),x
1130  0009 1d0001        	subw	x,#1
1131  000c f6            	ld	a,(x)
1132  000d 6b01          	ld	(OFST-1,sp),a
1133                     ; 34 	for(i = 1; i < length; i++){
1135  000f a601          	ld	a,#1
1136  0011 6b02          	ld	(OFST+0,sp),a
1138  0013 2011          	jra	L736
1139  0015               L336:
1140                     ; 35 		result ^= *buf++;
1142  0015 1e03          	ldw	x,(OFST+1,sp)
1143  0017 1c0001        	addw	x,#1
1144  001a 1f03          	ldw	(OFST+1,sp),x
1145  001c 1d0001        	subw	x,#1
1146  001f 7b01          	ld	a,(OFST-1,sp)
1147  0021 f8            	xor	a,	(x)
1148  0022 6b01          	ld	(OFST-1,sp),a
1149                     ; 34 	for(i = 1; i < length; i++){
1151  0024 0c02          	inc	(OFST+0,sp)
1152  0026               L736:
1155  0026 7b02          	ld	a,(OFST+0,sp)
1156  0028 1107          	cp	a,(OFST+5,sp)
1157  002a 25e9          	jrult	L336
1158                     ; 37 	return result;
1160  002c 7b01          	ld	a,(OFST-1,sp)
1163  002e 5b04          	addw	sp,#4
1164  0030 81            	ret
1191                     ; 43 void BLE_uart_init(void)
1191                     ; 44 {
1192                     .text:	section	.text,new
1193  0000               _BLE_uart_init:
1197                     ; 45 	UART1_DeInit();
1199  0000 cd0000        	call	_UART1_DeInit
1201                     ; 47 	UART1_Init((u32)57600, UART1_WORDLENGTH_8D, UART1_STOPBITS_1, UART1_PARITY_NO, UART1_SYNCMODE_CLOCK_DISABLE, UART1_MODE_TXRX_ENABLE);
1203  0003 4b0c          	push	#12
1204  0005 4b80          	push	#128
1205  0007 4b00          	push	#0
1206  0009 4b00          	push	#0
1207  000b 4b00          	push	#0
1208  000d aee100        	ldw	x,#57600
1209  0010 89            	pushw	x
1210  0011 ae0000        	ldw	x,#0
1211  0014 89            	pushw	x
1212  0015 cd0000        	call	_UART1_Init
1214  0018 5b09          	addw	sp,#9
1215                     ; 48 	UART1_ITConfig(UART1_IT_TC, ENABLE);			/* 发送完成中断 */
1217  001a 4b01          	push	#1
1218  001c ae0266        	ldw	x,#614
1219  001f cd0000        	call	_UART1_ITConfig
1221  0022 84            	pop	a
1222                     ; 49 	UART1_ITConfig(UART1_IT_RXNE_OR, ENABLE);		/*接收非空中断 */
1224  0023 4b01          	push	#1
1225  0025 ae0205        	ldw	x,#517
1226  0028 cd0000        	call	_UART1_ITConfig
1228  002b 84            	pop	a
1229                     ; 50 	UART1_Cmd(ENABLE);		/* 启用uart1接口 */
1231  002c a601          	ld	a,#1
1232  002e cd0000        	call	_UART1_Cmd
1234                     ; 51 }
1237  0031 81            	ret
1262                     ; 58 void BLE_uart_send_until_finish(void)
1262                     ; 59 {
1263                     .text:	section	.text,new
1264  0000               _BLE_uart_send_until_finish:
1268                     ; 60 	BLE_uart.txCnt = 1;
1270  0000 35010001      	mov	_BLE_uart+1,#1
1271                     ; 61 	BLE_uart.txLen = BLE_uart.txBuf[5] + 3;
1273  0004 c60029        	ld	a,_BLE_uart+41
1274  0007 ab03          	add	a,#3
1275  0009 c70000        	ld	_BLE_uart,a
1276                     ; 63 	BLE_UART->DR = BLE_uart.txBuf[0];
1278  000c 5500245231    	mov	21041,_BLE_uart+36
1280  0011               L766:
1281                     ; 65 	while(BLE_uart.txCnt);		//等待发送结束 
1283  0011 725d0001      	tnz	_BLE_uart+1
1284  0015 26fa          	jrne	L766
1285                     ; 67 }
1288  0017 81            	ret
1312                     ; 73 @interrupt void BLE_UART_TX_ISR(void)
1312                     ; 74 {
1313                     .text:	section	.text,new
1314  0000               _BLE_UART_TX_ISR:
1319                     ; 79 	BLE_UART->SR &= ~0x40;	//清除发送完成标志位
1321  0000 721d5230      	bres	21040,#6
1322                     ; 81 	if (BLE_uart.txCnt < BLE_uart.txLen){
1324  0004 c60001        	ld	a,_BLE_uart+1
1325  0007 c10000        	cp	a,_BLE_uart
1326  000a 2411          	jruge	L307
1327                     ; 83 		BLE_UART->DR = BLE_uart.txBuf[BLE_uart.txCnt];
1329  000c c60001        	ld	a,_BLE_uart+1
1330  000f 5f            	clrw	x
1331  0010 97            	ld	xl,a
1332  0011 d60024        	ld	a,(_BLE_uart+36,x)
1333  0014 c75231        	ld	21041,a
1334                     ; 84 		BLE_uart.txCnt++;
1336  0017 725c0001      	inc	_BLE_uart+1
1338  001b 2008          	jra	L507
1339  001d               L307:
1340                     ; 88 		BLE_uart.txLen = 0;
1342  001d 725f0000      	clr	_BLE_uart
1343                     ; 89 		BLE_uart.txCnt = 0;
1345  0021 725f0001      	clr	_BLE_uart+1
1346  0025               L507:
1347                     ; 91 }
1350  0025 80            	iret
1400                     ; 96 @interrupt void BLE_UART_RX_ISR(void)
1400                     ; 97 {
1401                     .text:	section	.text,new
1402  0000               _BLE_UART_RX_ISR:
1405       00000001      OFST:	set	1
1406  0000 3b0002        	push	c_x+2
1407  0003 be00          	ldw	x,c_x
1408  0005 89            	pushw	x
1409  0006 3b0002        	push	c_y+2
1410  0009 be00          	ldw	x,c_y
1411  000b 89            	pushw	x
1412  000c 88            	push	a
1415                     ; 101 	temp = (u8)BLE_UART->DR;
1417  000d c65231        	ld	a,21041
1418  0010 6b01          	ld	(OFST+0,sp),a
1419                     ; 102 	BLE_uart.rxBuf[BLE_uart.rxCnt] = temp;
1421  0012 c60002        	ld	a,_BLE_uart+2
1422  0015 5f            	clrw	x
1423  0016 97            	ld	xl,a
1424  0017 7b01          	ld	a,(OFST+0,sp)
1425  0019 d70004        	ld	(_BLE_uart+4,x),a
1426                     ; 103 	BLE_uart.rxCnt++;
1428  001c 725c0002      	inc	_BLE_uart+2
1429                     ; 105 	switch(BLE_uart.rxCnt)
1431  0020 c60002        	ld	a,_BLE_uart+2
1433                     ; 162 			break;
1434  0023 4a            	dec	a
1435  0024 2722          	jreq	L707
1436  0026 4a            	dec	a
1437  0027 2739          	jreq	L117
1438  0029 4a            	dec	a
1439  002a 2603          	jrne	L61
1440  002c cc0148        	jp	L547
1441  002f               L61:
1442  002f 4a            	dec	a
1443  0030 2603          	jrne	L02
1444  0032 cc0148        	jp	L547
1445  0035               L02:
1446  0035 4a            	dec	a
1447  0036 2603          	jrne	L22
1448  0038 cc0148        	jp	L547
1449  003b               L22:
1450  003b               L127:
1451                     ; 119 		default:
1451                     ; 120 			if (BLE_uart.rxCnt >= UART_BUF_LEN){			/* 防止接收错误后溢出 */		
1453  003b c60002        	ld	a,_BLE_uart+2
1454  003e a120          	cp	a,#32
1455  0040 2543          	jrult	L357
1456                     ; 121 				BLE_uart.rxCnt = 0;
1458  0042 725f0002      	clr	_BLE_uart+2
1459  0046 203d          	jra	L357
1460  0048               L707:
1461                     ; 107 		case 1:
1461                     ; 108 			if ((temp != 0xEE) && (temp != 0xDD))	BLE_uart.rxCnt = 0;
1463  0048 7b01          	ld	a,(OFST+0,sp)
1464  004a a1ee          	cp	a,#238
1465  004c 2603          	jrne	L42
1466  004e cc0148        	jp	L547
1467  0051               L42:
1469  0051 7b01          	ld	a,(OFST+0,sp)
1470  0053 a1dd          	cp	a,#221
1471  0055 2603          	jrne	L62
1472  0057 cc0148        	jp	L547
1473  005a               L62:
1476  005a 725f0002      	clr	_BLE_uart+2
1477  005e ac480148      	jpf	L547
1478  0062               L117:
1479                     ; 110 		case 2:
1479                     ; 111 			if ((temp != 0xEE) && (temp != 0xDD) && (temp != 0xAA)) BLE_uart.rxCnt = 0;
1481  0062 7b01          	ld	a,(OFST+0,sp)
1482  0064 a1ee          	cp	a,#238
1483  0066 2603          	jrne	L03
1484  0068 cc0148        	jp	L547
1485  006b               L03:
1487  006b 7b01          	ld	a,(OFST+0,sp)
1488  006d a1dd          	cp	a,#221
1489  006f 2603          	jrne	L23
1490  0071 cc0148        	jp	L547
1491  0074               L23:
1493  0074 7b01          	ld	a,(OFST+0,sp)
1494  0076 a1aa          	cp	a,#170
1495  0078 2603          	jrne	L43
1496  007a cc0148        	jp	L547
1497  007d               L43:
1500  007d 725f0002      	clr	_BLE_uart+2
1501  0081 ac480148      	jpf	L547
1502  0085               L357:
1503                     ; 123 			if ((BLE_uart.rxBuf[0] == 0xEE)&&((BLE_uart.rxBuf[1] == 0xEE) ||(BLE_uart.rxBuf[1] == 0xAA))){
1505  0085 c60004        	ld	a,_BLE_uart+4
1506  0088 a1ee          	cp	a,#238
1507  008a 266a          	jrne	L557
1509  008c c60005        	ld	a,_BLE_uart+5
1510  008f a1ee          	cp	a,#238
1511  0091 2707          	jreq	L757
1513  0093 c60005        	ld	a,_BLE_uart+5
1514  0096 a1aa          	cp	a,#170
1515  0098 265c          	jrne	L557
1516  009a               L757:
1517                     ; 124 				if (BLE_uart.rxCnt > BLE_uart.rxBuf[5] + 2){//接收数据完成
1519  009a 9c            	rvf
1520  009b c60002        	ld	a,_BLE_uart+2
1521  009e 5f            	clrw	x
1522  009f 97            	ld	xl,a
1523  00a0 c60009        	ld	a,_BLE_uart+9
1524  00a3 905f          	clrw	y
1525  00a5 9097          	ld	yl,a
1526  00a7 905c          	incw	y
1527  00a9 905c          	incw	y
1528  00ab bf01          	ldw	c_x+1,x
1529  00ad 90b301        	cpw	y,c_x+1
1530  00b0 2f03          	jrslt	L63
1531  00b2 cc0148        	jp	L547
1532  00b5               L63:
1533                     ; 126 					check_sum = Check_Sum((BLE_uart.rxBuf + 2), BLE_uart.rxBuf[5]);
1535  00b5 3b0009        	push	_BLE_uart+9
1536  00b8 ae0006        	ldw	x,#_BLE_uart+6
1537  00bb cd0000        	call	_Check_Sum
1539  00be 5b01          	addw	sp,#1
1540  00c0 6b01          	ld	(OFST+0,sp),a
1541                     ; 128 					if (check_sum == BLE_uart.rxBuf[BLE_uart.rxBuf[5] + 2]){//校验正确
1543  00c2 c60009        	ld	a,_BLE_uart+9
1544  00c5 5f            	clrw	x
1545  00c6 97            	ld	xl,a
1546  00c7 d60006        	ld	a,(_BLE_uart+6,x)
1547  00ca 1101          	cp	a,(OFST+0,sp)
1548  00cc 2622          	jrne	L367
1549                     ; 130 						if (rev_success == 0){		//前一包数据已处理完成
1551  00ce c600af        	ld	a,_UART1Flag1_
1552  00d1 a501          	bcp	a,#1
1553  00d3 261b          	jrne	L367
1554                     ; 132 							rev_success = 1;
1556  00d5 721000af      	bset	_UART1Flag1_,#0
1557                     ; 133 							for (i = 0; i < BLE_uart.rxCnt; i++){
1559  00d9 0f01          	clr	(OFST+0,sp)
1561  00db 200c          	jra	L377
1562  00dd               L767:
1563                     ; 134 								sicp_buf[i] = BLE_uart.rxBuf[i];
1565  00dd 7b01          	ld	a,(OFST+0,sp)
1566  00df 5f            	clrw	x
1567  00e0 97            	ld	xl,a
1568  00e1 d60004        	ld	a,(_BLE_uart+4,x)
1569  00e4 d70000        	ld	(_sicp_buf,x),a
1570                     ; 133 							for (i = 0; i < BLE_uart.rxCnt; i++){
1572  00e7 0c01          	inc	(OFST+0,sp)
1573  00e9               L377:
1576  00e9 7b01          	ld	a,(OFST+0,sp)
1577  00eb c10002        	cp	a,_BLE_uart+2
1578  00ee 25ed          	jrult	L767
1579  00f0               L367:
1580                     ; 139 					BLE_uart.rxCnt = 0;
1582  00f0 725f0002      	clr	_BLE_uart+2
1583  00f4 2052          	jra	L547
1584  00f6               L557:
1585                     ; 143 			else if((BLE_uart.rxBuf[0] == 0xDD) && (BLE_uart.rxBuf[1] == 0xDD)){
1587  00f6 c60004        	ld	a,_BLE_uart+4
1588  00f9 a1dd          	cp	a,#221
1589  00fb 2647          	jrne	L1001
1591  00fd c60005        	ld	a,_BLE_uart+5
1592  0100 a1dd          	cp	a,#221
1593  0102 2640          	jrne	L1001
1594                     ; 145 				if (BLE_uart.rxCnt > BLE_uart.rxBuf[3] + 2){	//接收数据完成
1596  0104 9c            	rvf
1597  0105 c60002        	ld	a,_BLE_uart+2
1598  0108 5f            	clrw	x
1599  0109 97            	ld	xl,a
1600  010a c60007        	ld	a,_BLE_uart+7
1601  010d 905f          	clrw	y
1602  010f 9097          	ld	yl,a
1603  0111 905c          	incw	y
1604  0113 905c          	incw	y
1605  0115 bf01          	ldw	c_x+1,x
1606  0117 90b301        	cpw	y,c_x+1
1607  011a 2e2c          	jrsge	L547
1608                     ; 147 					if (rev_success == 0){		//前一包数据已处理完成
1610  011c c600af        	ld	a,_UART1Flag1_
1611  011f a501          	bcp	a,#1
1612  0121 261b          	jrne	L5001
1613                     ; 149 						rev_success = 1;
1615  0123 721000af      	bset	_UART1Flag1_,#0
1616                     ; 150 						for (i = 0; i < BLE_uart.rxCnt; i++){
1618  0127 0f01          	clr	(OFST+0,sp)
1620  0129 200c          	jra	L3101
1621  012b               L7001:
1622                     ; 152 							sicp_buf[i] = BLE_uart.rxBuf[i];
1624  012b 7b01          	ld	a,(OFST+0,sp)
1625  012d 5f            	clrw	x
1626  012e 97            	ld	xl,a
1627  012f d60004        	ld	a,(_BLE_uart+4,x)
1628  0132 d70000        	ld	(_sicp_buf,x),a
1629                     ; 150 						for (i = 0; i < BLE_uart.rxCnt; i++){
1631  0135 0c01          	inc	(OFST+0,sp)
1632  0137               L3101:
1635  0137 7b01          	ld	a,(OFST+0,sp)
1636  0139 c10002        	cp	a,_BLE_uart+2
1637  013c 25ed          	jrult	L7001
1638  013e               L5001:
1639                     ; 156 					BLE_uart.rxCnt = 0;
1641  013e 725f0002      	clr	_BLE_uart+2
1642  0142 2004          	jra	L547
1643  0144               L1001:
1644                     ; 160 				BLE_uart.rxCnt = 0;
1646  0144 725f0002      	clr	_BLE_uart+2
1647  0148               L547:
1648                     ; 166 	if (BLE_UART->SR & 0x20) 
1650  0148 c65230        	ld	a,21040
1651  014b a520          	bcp	a,#32
1652  014d 2707          	jreq	L1201
1653                     ; 168 		temp = BLE_UART->DR;
1655  014f 7b01          	ld	a,(OFST+0,sp)
1656  0151 97            	ld	xl,a
1657  0152 c65231        	ld	a,21041
1658  0155 97            	ld	xl,a
1659  0156               L1201:
1660                     ; 171 }
1663  0156 84            	pop	a
1664  0157 85            	popw	x
1665  0158 bf00          	ldw	c_y,x
1666  015a 320002        	pop	c_y+2
1667  015d 85            	popw	x
1668  015e bf00          	ldw	c_x,x
1669  0160 320002        	pop	c_x+2
1670  0163 80            	iret
1741                     ; 177 void send_action_without_setted(u8 num, CTRL_TYPE type)
1741                     ; 178 {
1742                     .text:	section	.text,new
1743  0000               _send_action_without_setted:
1745  0000 89            	pushw	x
1746       00000000      OFST:	set	0
1749                     ; 179 	BLE_uart.txBuf[0] = 0xEE;
1751  0001 35ee0024      	mov	_BLE_uart+36,#238
1752                     ; 180 	BLE_uart.txBuf[1] = 0xEE;
1754  0005 35ee0025      	mov	_BLE_uart+37,#238
1755                     ; 181 	BLE_uart.txBuf[2] = sicp_get_message_id();
1757  0009 cd0000        	call	_sicp_get_message_id
1759  000c c70026        	ld	_BLE_uart+38,a
1760                     ; 182 	BLE_uart.txBuf[3] = ns_host_meshid_H;
1762  000f 5500280027    	mov	_BLE_uart+39,_ns_host_meshid_H
1763                     ; 183 	BLE_uart.txBuf[4] = ns_host_meshid_L;
1765  0014 5500270028    	mov	_BLE_uart+40,_ns_host_meshid_L
1766                     ; 184 	BLE_uart.txBuf[5] = 7;
1768  0019 35070029      	mov	_BLE_uart+41,#7
1769                     ; 186 	if(type == KEYPAD_CTRL){
1771  001d 7b02          	ld	a,(OFST+2,sp)
1772  001f a101          	cp	a,#1
1773  0021 261a          	jrne	L3501
1774                     ; 188 		BLE_uart.txBuf[6] = 0x35;		//触发器是按键
1776  0023 3535002a      	mov	_BLE_uart+42,#53
1777                     ; 189 		BLE_uart.txBuf[7] = BIT[num];
1779  0027 7b01          	ld	a,(OFST+1,sp)
1780  0029 5f            	clrw	x
1781  002a 97            	ld	xl,a
1782  002b d60000        	ld	a,(_BIT,x)
1783  002e c7002b        	ld	_BLE_uart+43,a
1784                     ; 190 		BLE_uart.txBuf[8] = st1.keypad[num].status;
1786  0031 7b01          	ld	a,(OFST+1,sp)
1787  0033 97            	ld	xl,a
1788  0034 a60b          	ld	a,#11
1789  0036 42            	mul	x,a
1790  0037 d60052        	ld	a,(_st1+36,x)
1791  003a c7002c        	ld	_BLE_uart+44,a
1792  003d               L3501:
1793                     ; 194 	if(type == GESTURE_CTRL){
1795  003d 7b02          	ld	a,(OFST+2,sp)
1796  003f a102          	cp	a,#2
1797  0041 260e          	jrne	L5501
1798                     ; 196 		BLE_uart.txBuf[6] = 0x29;		//触发器是手势
1800  0043 3529002a      	mov	_BLE_uart+42,#41
1801                     ; 197 		BLE_uart.txBuf[7] = st1.ges_h;
1803  0047 55004e002b    	mov	_BLE_uart+43,_st1+32
1804                     ; 198 		BLE_uart.txBuf[8] = st1.ges_l;
1806  004c 55004f002c    	mov	_BLE_uart+44,_st1+33
1807  0051               L5501:
1808                     ; 202 	BLE_uart.txBuf[9] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
1810  0051 3b0029        	push	_BLE_uart+41
1811  0054 ae0026        	ldw	x,#_BLE_uart+38
1812  0057 cd0000        	call	_Check_Sum
1814  005a 5b01          	addw	sp,#1
1815  005c c7002d        	ld	_BLE_uart+45,a
1816                     ; 204 	BLE_uart_send_until_finish();
1818  005f cd0000        	call	_BLE_uart_send_until_finish
1820                     ; 206 }
1823  0062 85            	popw	x
1824  0063 81            	ret
1874                     ; 213 void send_action_sync(u8 num, CTRL_TYPE type)
1874                     ; 214 {
1875                     .text:	section	.text,new
1876  0000               _send_action_sync:
1878  0000 89            	pushw	x
1879       00000000      OFST:	set	0
1882                     ; 215 	BLE_uart.txBuf[0] = 0xEE;
1884  0001 35ee0024      	mov	_BLE_uart+36,#238
1885                     ; 216 	BLE_uart.txBuf[1] = 0xEE;
1887  0005 35ee0025      	mov	_BLE_uart+37,#238
1888                     ; 217 	BLE_uart.txBuf[2] = sicp_get_message_id();
1890  0009 cd0000        	call	_sicp_get_message_id
1892  000c c70026        	ld	_BLE_uart+38,a
1893                     ; 218 	BLE_uart.txBuf[3] = ns_host_meshid_H;
1895  000f 5500280027    	mov	_BLE_uart+39,_ns_host_meshid_H
1896                     ; 219 	BLE_uart.txBuf[4] = ns_host_meshid_L;
1898  0014 5500270028    	mov	_BLE_uart+40,_ns_host_meshid_L
1899                     ; 220 	BLE_uart.txBuf[5] = 14;	
1901  0019 350e0029      	mov	_BLE_uart+41,#14
1902                     ; 221 	BLE_uart.txBuf[6] = 0x08;	
1904  001d 3508002a      	mov	_BLE_uart+42,#8
1905                     ; 223 	if(type == KEYPAD_CTRL){
1907  0021 7b02          	ld	a,(OFST+2,sp)
1908  0023 a101          	cp	a,#1
1909  0025 265a          	jrne	L7701
1910                     ; 225 		BLE_uart.txBuf[7] = 0x01;		//触发器是按键
1912  0027 3501002b      	mov	_BLE_uart+43,#1
1913                     ; 226 		BLE_uart.txBuf[8] = 0x00;
1915  002b 725f002c      	clr	_BLE_uart+44
1916                     ; 227 		BLE_uart.txBuf[9] = BIT[num];	
1918  002f 7b01          	ld	a,(OFST+1,sp)
1919  0031 5f            	clrw	x
1920  0032 97            	ld	xl,a
1921  0033 d60000        	ld	a,(_BIT,x)
1922  0036 c7002d        	ld	_BLE_uart+45,a
1923                     ; 228 		BLE_uart.txBuf[10] = st1.keypad[num].meshid_h;
1925  0039 7b01          	ld	a,(OFST+1,sp)
1926  003b 97            	ld	xl,a
1927  003c a60b          	ld	a,#11
1928  003e 42            	mul	x,a
1929  003f d60055        	ld	a,(_st1+39,x)
1930  0042 c7002e        	ld	_BLE_uart+46,a
1931                     ; 229 		BLE_uart.txBuf[11] = st1.keypad[num].meshid_l;
1933  0045 7b01          	ld	a,(OFST+1,sp)
1934  0047 97            	ld	xl,a
1935  0048 a60b          	ld	a,#11
1936  004a 42            	mul	x,a
1937  004b d60056        	ld	a,(_st1+40,x)
1938  004e c7002f        	ld	_BLE_uart+47,a
1939                     ; 230 		BLE_uart.txBuf[12] = st1.keypad[num].action;
1941  0051 7b01          	ld	a,(OFST+1,sp)
1942  0053 97            	ld	xl,a
1943  0054 a60b          	ld	a,#11
1944  0056 42            	mul	x,a
1945  0057 d60058        	ld	a,(_st1+42,x)
1946  005a c70030        	ld	_BLE_uart+48,a
1947                     ; 231 		BLE_uart.txBuf[13] = st1.keypad[num].boardid;
1949  005d 7b01          	ld	a,(OFST+1,sp)
1950  005f 97            	ld	xl,a
1951  0060 a60b          	ld	a,#11
1952  0062 42            	mul	x,a
1953  0063 d60057        	ld	a,(_st1+41,x)
1954  0066 c70031        	ld	_BLE_uart+49,a
1955                     ; 232 		BLE_uart.txBuf[14] = st1.keypad[num].status;
1957  0069 7b01          	ld	a,(OFST+1,sp)
1958  006b 97            	ld	xl,a
1959  006c a60b          	ld	a,#11
1960  006e 42            	mul	x,a
1961  006f d60052        	ld	a,(_st1+36,x)
1962  0072 c70032        	ld	_BLE_uart+50,a
1963                     ; 233 		BLE_uart.txBuf[15] = st1.keypad[num].time;
1965  0075 7b01          	ld	a,(OFST+1,sp)
1966  0077 97            	ld	xl,a
1967  0078 a60b          	ld	a,#11
1968  007a 42            	mul	x,a
1969  007b d6005a        	ld	a,(_st1+44,x)
1970  007e c70033        	ld	_BLE_uart+51,a
1971  0081               L7701:
1972                     ; 236 	if(type == GESTURE_CTRL){
1974  0081 7b02          	ld	a,(OFST+2,sp)
1975  0083 a102          	cp	a,#2
1976  0085 2664          	jrne	L1011
1977                     ; 238 		BLE_uart.txBuf[7] = 0x02; 		//触发器是手势
1979  0087 3502002b      	mov	_BLE_uart+43,#2
1980                     ; 239 		BLE_uart.txBuf[8] = st1.gesture[num].ges_h;
1982  008b 7b01          	ld	a,(OFST+1,sp)
1983  008d 97            	ld	xl,a
1984  008e a60a          	ld	a,#10
1985  0090 42            	mul	x,a
1986  0091 d60073        	ld	a,(_st1+69,x)
1987  0094 c7002c        	ld	_BLE_uart+44,a
1988                     ; 240 		BLE_uart.txBuf[9] = st1.gesture[num].ges_l;
1990  0097 7b01          	ld	a,(OFST+1,sp)
1991  0099 97            	ld	xl,a
1992  009a a60a          	ld	a,#10
1993  009c 42            	mul	x,a
1994  009d d60074        	ld	a,(_st1+70,x)
1995  00a0 c7002d        	ld	_BLE_uart+45,a
1996                     ; 241 		BLE_uart.txBuf[10] = st1.gesture[num].meshid_h;
1998  00a3 7b01          	ld	a,(OFST+1,sp)
1999  00a5 97            	ld	xl,a
2000  00a6 a60a          	ld	a,#10
2001  00a8 42            	mul	x,a
2002  00a9 d60075        	ld	a,(_st1+71,x)
2003  00ac c7002e        	ld	_BLE_uart+46,a
2004                     ; 242 		BLE_uart.txBuf[11] = st1.gesture[num].meshid_l;
2006  00af 7b01          	ld	a,(OFST+1,sp)
2007  00b1 97            	ld	xl,a
2008  00b2 a60a          	ld	a,#10
2009  00b4 42            	mul	x,a
2010  00b5 d60076        	ld	a,(_st1+72,x)
2011  00b8 c7002f        	ld	_BLE_uart+47,a
2012                     ; 243 		BLE_uart.txBuf[12] = st1.gesture[num].action;
2014  00bb 7b01          	ld	a,(OFST+1,sp)
2015  00bd 97            	ld	xl,a
2016  00be a60a          	ld	a,#10
2017  00c0 42            	mul	x,a
2018  00c1 d60078        	ld	a,(_st1+74,x)
2019  00c4 c70030        	ld	_BLE_uart+48,a
2020                     ; 244 		BLE_uart.txBuf[13] = st1.gesture[num].boardid;
2022  00c7 7b01          	ld	a,(OFST+1,sp)
2023  00c9 97            	ld	xl,a
2024  00ca a60a          	ld	a,#10
2025  00cc 42            	mul	x,a
2026  00cd d60077        	ld	a,(_st1+73,x)
2027  00d0 c70031        	ld	_BLE_uart+49,a
2028                     ; 245 		BLE_uart.txBuf[14] = st1.gesture[num].value;
2030  00d3 7b01          	ld	a,(OFST+1,sp)
2031  00d5 97            	ld	xl,a
2032  00d6 a60a          	ld	a,#10
2033  00d8 42            	mul	x,a
2034  00d9 d60079        	ld	a,(_st1+75,x)
2035  00dc c70032        	ld	_BLE_uart+50,a
2036                     ; 246 		BLE_uart.txBuf[15] = st1.gesture[num].time;
2038  00df 7b01          	ld	a,(OFST+1,sp)
2039  00e1 97            	ld	xl,a
2040  00e2 a60a          	ld	a,#10
2041  00e4 42            	mul	x,a
2042  00e5 d6007a        	ld	a,(_st1+76,x)
2043  00e8 c70033        	ld	_BLE_uart+51,a
2044  00eb               L1011:
2045                     ; 249 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
2047  00eb c60029        	ld	a,_BLE_uart+41
2048  00ee 5f            	clrw	x
2049  00ef 97            	ld	xl,a
2050  00f0 89            	pushw	x
2051  00f1 3b0029        	push	_BLE_uart+41
2052  00f4 ae0026        	ldw	x,#_BLE_uart+38
2053  00f7 cd0000        	call	_Check_Sum
2055  00fa 5b01          	addw	sp,#1
2056  00fc 85            	popw	x
2057  00fd d70026        	ld	(_BLE_uart+38,x),a
2058                     ; 251 	BLE_uart_send_until_finish();
2060  0100 cd0000        	call	_BLE_uart_send_until_finish
2062                     ; 253 }
2065  0103 85            	popw	x
2066  0104 81            	ret
2113                     ; 259 void send_action_ctrl(u8 num, CTRL_TYPE type)
2113                     ; 260 {
2114                     .text:	section	.text,new
2115  0000               _send_action_ctrl:
2117  0000 89            	pushw	x
2118       00000000      OFST:	set	0
2121                     ; 261 	BLE_uart.txBuf[0] = 0xEE;
2123  0001 35ee0024      	mov	_BLE_uart+36,#238
2124                     ; 262 	BLE_uart.txBuf[1] = 0xEE;
2126  0005 35ee0025      	mov	_BLE_uart+37,#238
2127                     ; 263 	BLE_uart.txBuf[2] = sicp_get_message_id();
2129  0009 cd0000        	call	_sicp_get_message_id
2131  000c c70026        	ld	_BLE_uart+38,a
2132                     ; 265 	if(type == KEYPAD_CTRL){
2134  000f 7b02          	ld	a,(OFST+2,sp)
2135  0011 a101          	cp	a,#1
2136  0013 264c          	jrne	L3211
2137                     ; 266 		BLE_uart.txBuf[3] = st1.keypad[num].meshid_h;
2139  0015 7b01          	ld	a,(OFST+1,sp)
2140  0017 97            	ld	xl,a
2141  0018 a60b          	ld	a,#11
2142  001a 42            	mul	x,a
2143  001b d60055        	ld	a,(_st1+39,x)
2144  001e c70027        	ld	_BLE_uart+39,a
2145                     ; 267 		BLE_uart.txBuf[4] = st1.keypad[num].meshid_l;
2147  0021 7b01          	ld	a,(OFST+1,sp)
2148  0023 97            	ld	xl,a
2149  0024 a60b          	ld	a,#11
2150  0026 42            	mul	x,a
2151  0027 d60056        	ld	a,(_st1+40,x)
2152  002a c70028        	ld	_BLE_uart+40,a
2153                     ; 268 		BLE_uart.txBuf[5] = 8;
2155  002d 35080029      	mov	_BLE_uart+41,#8
2156                     ; 269 		BLE_uart.txBuf[6] = st1.keypad[num].action;
2158  0031 7b01          	ld	a,(OFST+1,sp)
2159  0033 97            	ld	xl,a
2160  0034 a60b          	ld	a,#11
2161  0036 42            	mul	x,a
2162  0037 d60058        	ld	a,(_st1+42,x)
2163  003a c7002a        	ld	_BLE_uart+42,a
2164                     ; 270 		BLE_uart.txBuf[7] = st1.keypad[num].boardid;
2166  003d 7b01          	ld	a,(OFST+1,sp)
2167  003f 97            	ld	xl,a
2168  0040 a60b          	ld	a,#11
2169  0042 42            	mul	x,a
2170  0043 d60057        	ld	a,(_st1+41,x)
2171  0046 c7002b        	ld	_BLE_uart+43,a
2172                     ; 271 		BLE_uart.txBuf[8] = st1.keypad[num].status;
2174  0049 7b01          	ld	a,(OFST+1,sp)
2175  004b 97            	ld	xl,a
2176  004c a60b          	ld	a,#11
2177  004e 42            	mul	x,a
2178  004f d60052        	ld	a,(_st1+36,x)
2179  0052 c7002c        	ld	_BLE_uart+44,a
2180                     ; 272 		BLE_uart.txBuf[9] = st1.keypad[num].time;
2182  0055 7b01          	ld	a,(OFST+1,sp)
2183  0057 97            	ld	xl,a
2184  0058 a60b          	ld	a,#11
2185  005a 42            	mul	x,a
2186  005b d6005a        	ld	a,(_st1+44,x)
2187  005e c7002d        	ld	_BLE_uart+45,a
2188  0061               L3211:
2189                     ; 276 	if(type == GESTURE_CTRL){
2191  0061 7b02          	ld	a,(OFST+2,sp)
2192  0063 a102          	cp	a,#2
2193  0065 264c          	jrne	L5211
2194                     ; 278 		BLE_uart.txBuf[3] = st1.gesture[num].meshid_h;
2196  0067 7b01          	ld	a,(OFST+1,sp)
2197  0069 97            	ld	xl,a
2198  006a a60a          	ld	a,#10
2199  006c 42            	mul	x,a
2200  006d d60075        	ld	a,(_st1+71,x)
2201  0070 c70027        	ld	_BLE_uart+39,a
2202                     ; 279 		BLE_uart.txBuf[4] = st1.gesture[num].meshid_l;
2204  0073 7b01          	ld	a,(OFST+1,sp)
2205  0075 97            	ld	xl,a
2206  0076 a60a          	ld	a,#10
2207  0078 42            	mul	x,a
2208  0079 d60076        	ld	a,(_st1+72,x)
2209  007c c70028        	ld	_BLE_uart+40,a
2210                     ; 280 		BLE_uart.txBuf[5] = 8;
2212  007f 35080029      	mov	_BLE_uart+41,#8
2213                     ; 281 		BLE_uart.txBuf[6] = st1.gesture[num].action;
2215  0083 7b01          	ld	a,(OFST+1,sp)
2216  0085 97            	ld	xl,a
2217  0086 a60a          	ld	a,#10
2218  0088 42            	mul	x,a
2219  0089 d60078        	ld	a,(_st1+74,x)
2220  008c c7002a        	ld	_BLE_uart+42,a
2221                     ; 282 		BLE_uart.txBuf[7] = st1.gesture[num].boardid;
2223  008f 7b01          	ld	a,(OFST+1,sp)
2224  0091 97            	ld	xl,a
2225  0092 a60a          	ld	a,#10
2226  0094 42            	mul	x,a
2227  0095 d60077        	ld	a,(_st1+73,x)
2228  0098 c7002b        	ld	_BLE_uart+43,a
2229                     ; 283 		BLE_uart.txBuf[8] = st1.gesture[num].value;	
2231  009b 7b01          	ld	a,(OFST+1,sp)
2232  009d 97            	ld	xl,a
2233  009e a60a          	ld	a,#10
2234  00a0 42            	mul	x,a
2235  00a1 d60079        	ld	a,(_st1+75,x)
2236  00a4 c7002c        	ld	_BLE_uart+44,a
2237                     ; 284 		BLE_uart.txBuf[9] = st1.gesture[num].time;
2239  00a7 7b01          	ld	a,(OFST+1,sp)
2240  00a9 97            	ld	xl,a
2241  00aa a60a          	ld	a,#10
2242  00ac 42            	mul	x,a
2243  00ad d6007a        	ld	a,(_st1+76,x)
2244  00b0 c7002d        	ld	_BLE_uart+45,a
2245  00b3               L5211:
2246                     ; 288 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
2248  00b3 c60029        	ld	a,_BLE_uart+41
2249  00b6 5f            	clrw	x
2250  00b7 97            	ld	xl,a
2251  00b8 89            	pushw	x
2252  00b9 3b0029        	push	_BLE_uart+41
2253  00bc ae0026        	ldw	x,#_BLE_uart+38
2254  00bf cd0000        	call	_Check_Sum
2256  00c2 5b01          	addw	sp,#1
2257  00c4 85            	popw	x
2258  00c5 d70026        	ld	(_BLE_uart+38,x),a
2259                     ; 290 	BLE_uart_send_until_finish();
2261  00c8 cd0000        	call	_BLE_uart_send_until_finish
2263                     ; 292 }
2266  00cb 85            	popw	x
2267  00cc 81            	ret
2324                     ; 300 void send_receipt(u8 msg_id, u8 meshid_h, u8 meshid_l, u8 type)
2324                     ; 301 {
2325                     .text:	section	.text,new
2326  0000               _send_receipt:
2328  0000 89            	pushw	x
2329       00000000      OFST:	set	0
2332                     ; 302 	BLE_uart.txBuf[0] = 0xEE;
2334  0001 35ee0024      	mov	_BLE_uart+36,#238
2335                     ; 303 	BLE_uart.txBuf[1] = 0xAA;
2337  0005 35aa0025      	mov	_BLE_uart+37,#170
2338                     ; 304 	BLE_uart.txBuf[2] = msg_id;
2340  0009 9e            	ld	a,xh
2341  000a c70026        	ld	_BLE_uart+38,a
2342                     ; 305 	BLE_uart.txBuf[3] = meshid_h;
2344  000d 9f            	ld	a,xl
2345  000e c70027        	ld	_BLE_uart+39,a
2346                     ; 306 	BLE_uart.txBuf[4] = meshid_l;
2348  0011 7b05          	ld	a,(OFST+5,sp)
2349  0013 c70028        	ld	_BLE_uart+40,a
2350                     ; 307 	BLE_uart.txBuf[5] = 10;	
2352  0016 350a0029      	mov	_BLE_uart+41,#10
2353                     ; 308 	BLE_uart.txBuf[6] = 0xAA;	
2355  001a 35aa002a      	mov	_BLE_uart+42,#170
2356                     ; 309 	BLE_uart.txBuf[7] = type; 		
2358  001e 7b06          	ld	a,(OFST+6,sp)
2359  0020 c7002b        	ld	_BLE_uart+43,a
2360                     ; 311 	if(type == 0x02 || type == 0x01 || type == 0x03){
2362  0023 7b06          	ld	a,(OFST+6,sp)
2363  0025 a102          	cp	a,#2
2364  0027 270c          	jreq	L3511
2366  0029 7b06          	ld	a,(OFST+6,sp)
2367  002b a101          	cp	a,#1
2368  002d 2706          	jreq	L3511
2370  002f 7b06          	ld	a,(OFST+6,sp)
2371  0031 a103          	cp	a,#3
2372  0033 2604          	jrne	L1511
2373  0035               L3511:
2374                     ; 313 		BLE_uart.txBuf[5] = 6;	
2376  0035 35060029      	mov	_BLE_uart+41,#6
2377  0039               L1511:
2378                     ; 317 	if(type == 0x05){		//代表成功执行并返回模块状态
2380  0039 7b06          	ld	a,(OFST+6,sp)
2381  003b a105          	cp	a,#5
2382  003d 2614          	jrne	L7511
2383                     ; 319 		BLE_uart.txBuf[8] = st1.keypad[0].status;
2385  003f 550052002c    	mov	_BLE_uart+44,_st1+36
2386                     ; 320 		BLE_uart.txBuf[9] = st1.keypad[1].status;
2388  0044 55005d002d    	mov	_BLE_uart+45,_st1+47
2389                     ; 321 		BLE_uart.txBuf[10] = st1.keypad[2].status;
2391  0049 550068002e    	mov	_BLE_uart+46,_st1+58
2392                     ; 322 		BLE_uart.txBuf[11] = st1.st_led_status;
2394  004e 550099002f    	mov	_BLE_uart+47,_st1+107
2395  0053               L7511:
2396                     ; 326 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
2398  0053 c60029        	ld	a,_BLE_uart+41
2399  0056 5f            	clrw	x
2400  0057 97            	ld	xl,a
2401  0058 89            	pushw	x
2402  0059 3b0029        	push	_BLE_uart+41
2403  005c ae0026        	ldw	x,#_BLE_uart+38
2404  005f cd0000        	call	_Check_Sum
2406  0062 5b01          	addw	sp,#1
2407  0064 85            	popw	x
2408  0065 d70026        	ld	(_BLE_uart+38,x),a
2409                     ; 328 	BLE_uart_send_until_finish();
2411  0068 cd0000        	call	_BLE_uart_send_until_finish
2413                     ; 330 }
2416  006b 85            	popw	x
2417  006c 81            	ret
2474                     ; 340 void send_cmd_data(u8 msg_id, u8 meshid_h, u8 meshid_l, u8 type)
2474                     ; 341 {	
2475                     .text:	section	.text,new
2476  0000               _send_cmd_data:
2478  0000 89            	pushw	x
2479       00000000      OFST:	set	0
2482                     ; 342 	BLE_uart.txBuf[0] = 0xEE;
2484  0001 35ee0024      	mov	_BLE_uart+36,#238
2485                     ; 343 	BLE_uart.txBuf[1] = 0xAA;
2487  0005 35aa0025      	mov	_BLE_uart+37,#170
2488                     ; 344 	BLE_uart.txBuf[2] = msg_id;
2490  0009 9e            	ld	a,xh
2491  000a c70026        	ld	_BLE_uart+38,a
2492                     ; 345 	BLE_uart.txBuf[3] = meshid_h;
2494  000d 9f            	ld	a,xl
2495  000e c70027        	ld	_BLE_uart+39,a
2496                     ; 346 	BLE_uart.txBuf[4] = meshid_l;
2498  0011 7b05          	ld	a,(OFST+5,sp)
2499  0013 c70028        	ld	_BLE_uart+40,a
2500                     ; 347 	BLE_uart.txBuf[5] = 9;
2502  0016 35090029      	mov	_BLE_uart+41,#9
2503                     ; 348 	BLE_uart.txBuf[6] = type;
2505  001a 7b06          	ld	a,(OFST+6,sp)
2506  001c c7002a        	ld	_BLE_uart+42,a
2507                     ; 350 	if(type == 0x20){
2509  001f 7b06          	ld	a,(OFST+6,sp)
2510  0021 a120          	cp	a,#32
2511  0023 2614          	jrne	L3021
2512                     ; 351 		BLE_uart.txBuf[7] = st1.st_ambient_light;
2514  0025 55009a002b    	mov	_BLE_uart+43,_st1+108
2515                     ; 352 		BLE_uart.txBuf[8] = st1.st_color_sense_L;
2517  002a 55009d002c    	mov	_BLE_uart+44,_st1+111
2518                     ; 353 		BLE_uart.txBuf[9] = st1.st_color_sense_M;
2520  002f 55009c002d    	mov	_BLE_uart+45,_st1+110
2521                     ; 354 		BLE_uart.txBuf[10] = st1.st_color_sense_H;
2523  0034 55009b002e    	mov	_BLE_uart+46,_st1+109
2524  0039               L3021:
2525                     ; 358 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
2527  0039 4b09          	push	#9
2528  003b ae0026        	ldw	x,#_BLE_uart+38
2529  003e cd0000        	call	_Check_Sum
2531  0041 5b01          	addw	sp,#1
2532  0043 c7002f        	ld	_BLE_uart+47,a
2533                     ; 360 	BLE_uart_send_until_finish();
2535  0046 cd0000        	call	_BLE_uart_send_until_finish
2537                     ; 362 }
2540  0049 85            	popw	x
2541  004a 81            	ret
2588                     ; 369 void send_device_info_all(u8 type , u8 msg_id)
2588                     ; 370 {
2589                     .text:	section	.text,new
2590  0000               _send_device_info_all:
2594                     ; 371 	BLE_uart.txBuf[0] = 0xEE;
2596  0000 35ee0024      	mov	_BLE_uart+36,#238
2597                     ; 372 	BLE_uart.txBuf[1] = type;
2599  0004 9e            	ld	a,xh
2600  0005 c70025        	ld	_BLE_uart+37,a
2601                     ; 373 	BLE_uart.txBuf[2] = (type == 0xEE) ? sicp_get_message_id() : msg_id;
2603  0008 9e            	ld	a,xh
2604  0009 a1ee          	cp	a,#238
2605  000b 2605          	jrne	L45
2606  000d cd0000        	call	_sicp_get_message_id
2608  0010 2001          	jra	L65
2609  0012               L45:
2610  0012 9f            	ld	a,xl
2611  0013               L65:
2612  0013 c70026        	ld	_BLE_uart+38,a
2613                     ; 374 	BLE_uart.txBuf[3] = ns_host_meshid_H;
2615  0016 5500280027    	mov	_BLE_uart+39,_ns_host_meshid_H
2616                     ; 375 	BLE_uart.txBuf[4] = ns_host_meshid_L;
2618  001b 5500270028    	mov	_BLE_uart+40,_ns_host_meshid_L
2619                     ; 376 	BLE_uart.txBuf[5] = 12;	
2621  0020 350c0029      	mov	_BLE_uart+41,#12
2622                     ; 377 	BLE_uart.txBuf[6] = 0xB4;
2624  0024 35b4002a      	mov	_BLE_uart+42,#180
2625                     ; 379 	BLE_uart.txBuf[7] = st1.deviceID[0];
2627  0028 55002e002b    	mov	_BLE_uart+43,_st1
2628                     ; 380 	BLE_uart.txBuf[8] = st1.deviceID[1];
2630  002d 55002f002c    	mov	_BLE_uart+44,_st1+1
2631                     ; 381 	BLE_uart.txBuf[9] = st1.deviceID[2];
2633  0032 550030002d    	mov	_BLE_uart+45,_st1+2
2634                     ; 382 	BLE_uart.txBuf[10] = st1.deviceID[3];
2636  0037 550031002e    	mov	_BLE_uart+46,_st1+3
2637                     ; 383 	BLE_uart.txBuf[11] = st1.model;				//设备型号
2639  003c 550033002f    	mov	_BLE_uart+47,_st1+5
2640                     ; 384 	BLE_uart.txBuf[12] = st1.firmware_version;	
2642  0041 5500340030    	mov	_BLE_uart+48,_st1+6
2643                     ; 385 	BLE_uart.txBuf[13] = st1.HWTtest;
2645  0046 5500490031    	mov	_BLE_uart+49,_st1+27
2646                     ; 387 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
2648  004b 4b0c          	push	#12
2649  004d ae0026        	ldw	x,#_BLE_uart+38
2650  0050 cd0000        	call	_Check_Sum
2652  0053 5b01          	addw	sp,#1
2653  0055 c70032        	ld	_BLE_uart+50,a
2654                     ; 389 	BLE_uart_send_until_finish();
2656  0058 cd0000        	call	_BLE_uart_send_until_finish
2658                     ; 391 }
2661  005b 81            	ret
2664                     	switch	.data
2665  0044               L3221_counts:
2666  0044 0000          	dc.w	0
2714                     ; 399 u8 send_device_info_active(void)
2714                     ; 400 {
2715                     .text:	section	.text,new
2716  0000               _send_device_info_active:
2718  0000 89            	pushw	x
2719       00000002      OFST:	set	2
2722                     ; 402 	u8 ret = 0;
2724  0001 0f02          	clr	(OFST+0,sp)
2725                     ; 403 	u8 waits = 60 + (ns_host_meshid_L & 0x0f);
2727  0003 c60027        	ld	a,_ns_host_meshid_L
2728  0006 a40f          	and	a,#15
2729  0008 ab3c          	add	a,#60
2730  000a 6b01          	ld	(OFST-1,sp),a
2731                     ; 405 	if(ns_host_meshid_H){			/* meshid 存在 */
2733  000c 725d0028      	tnz	_ns_host_meshid_H
2734  0010 2725          	jreq	L5421
2735                     ; 407 		counts++;
2737  0012 ce0044        	ldw	x,L3221_counts
2738  0015 1c0001        	addw	x,#1
2739  0018 cf0044        	ldw	L3221_counts,x
2740                     ; 409 		if(counts >= waits){
2742  001b 7b01          	ld	a,(OFST-1,sp)
2743  001d 5f            	clrw	x
2744  001e 97            	ld	xl,a
2745  001f bf00          	ldw	c_x,x
2746  0021 ce0044        	ldw	x,L3221_counts
2747  0024 b300          	cpw	x,c_x
2748  0026 250f          	jrult	L5421
2749                     ; 410 			send_device_info_all(0xEE, 0);
2751  0028 5f            	clrw	x
2752  0029 a6ee          	ld	a,#238
2753  002b 95            	ld	xh,a
2754  002c cd0000        	call	_send_device_info_all
2756                     ; 411 			counts = 0;
2758  002f 5f            	clrw	x
2759  0030 cf0044        	ldw	L3221_counts,x
2760                     ; 412 			ret = 1;
2762  0033 a601          	ld	a,#1
2763  0035 6b02          	ld	(OFST+0,sp),a
2764  0037               L5421:
2765                     ; 415 	return ret;
2767  0037 7b02          	ld	a,(OFST+0,sp)
2770  0039 85            	popw	x
2771  003a 81            	ret
2855                     ; 423 u8 get_gesture_num(u8 ges_h, u8 ges_l, GET_GESTURE_WAY way)
2855                     ; 424 {
2856                     .text:	section	.text,new
2857  0000               _get_gesture_num:
2859  0000 89            	pushw	x
2860  0001 88            	push	a
2861       00000001      OFST:	set	1
2864                     ; 425 	u8 i, ret = GET_GESTURE_ERROR;
2866  0002 a6ff          	ld	a,#255
2867  0004 6b01          	ld	(OFST+0,sp),a
2868                     ; 428 	if(way == GET_SETTED_NUM){
2870  0006 7b06          	ld	a,(OFST+5,sp)
2871  0008 a101          	cp	a,#1
2872  000a 263f          	jrne	L7031
2873                     ; 430 		for(i = 0; i < GESTURE_NUMS; i++){
2875  000c 0f01          	clr	(OFST+0,sp)
2876  000e               L1131:
2877                     ; 432 			if(st1.gesture[i].flag.bit.setted){		//已设置
2879  000e 7b01          	ld	a,(OFST+0,sp)
2880  0010 97            	ld	xl,a
2881  0011 a60a          	ld	a,#10
2882  0013 42            	mul	x,a
2883  0014 d60071        	ld	a,(_st1+67,x)
2884  0017 a502          	bcp	a,#2
2885  0019 271a          	jreq	L7131
2886                     ; 433 				if((st1.gesture[i].ges_h == ges_h) && (st1.gesture[i].ges_l == ges_l)){		//手势相同
2888  001b 7b01          	ld	a,(OFST+0,sp)
2889  001d 97            	ld	xl,a
2890  001e a60a          	ld	a,#10
2891  0020 42            	mul	x,a
2892  0021 d60073        	ld	a,(_st1+69,x)
2893  0024 1102          	cp	a,(OFST+1,sp)
2894  0026 260d          	jrne	L7131
2896  0028 7b01          	ld	a,(OFST+0,sp)
2897  002a 97            	ld	xl,a
2898  002b a60a          	ld	a,#10
2899  002d 42            	mul	x,a
2900  002e d60074        	ld	a,(_st1+70,x)
2901  0031 1103          	cp	a,(OFST+2,sp)
2902  0033 2708          	jreq	L5131
2903                     ; 434 					break;
2905  0035               L7131:
2906                     ; 430 		for(i = 0; i < GESTURE_NUMS; i++){
2908  0035 0c01          	inc	(OFST+0,sp)
2911  0037 7b01          	ld	a,(OFST+0,sp)
2912  0039 a104          	cp	a,#4
2913  003b 25d1          	jrult	L1131
2914  003d               L5131:
2915                     ; 438 		ret = (i == GESTURE_NUMS) ? GET_GESTURE_ERROR : i;
2917  003d 7b01          	ld	a,(OFST+0,sp)
2918  003f a104          	cp	a,#4
2919  0041 2604          	jrne	L46
2920  0043 a6ff          	ld	a,#255
2921  0045 2002          	jra	L66
2922  0047               L46:
2923  0047 7b01          	ld	a,(OFST+0,sp)
2924  0049               L66:
2925  0049 6b01          	ld	(OFST+0,sp),a
2926  004b               L7031:
2927                     ; 443 	if(way == GET_SAVING_NUM){
2929  004b 7b06          	ld	a,(OFST+5,sp)
2930  004d a102          	cp	a,#2
2931  004f 2625          	jrne	L3231
2932                     ; 445 		for(i = 0; i < GESTURE_NUMS; i++){
2934  0051 0f01          	clr	(OFST+0,sp)
2935  0053               L5231:
2936                     ; 447 			if(st1.gesture[i].flag.bit.setted == 0){			//未设置
2938  0053 7b01          	ld	a,(OFST+0,sp)
2939  0055 97            	ld	xl,a
2940  0056 a60a          	ld	a,#10
2941  0058 42            	mul	x,a
2942  0059 d60071        	ld	a,(_st1+67,x)
2943  005c a502          	bcp	a,#2
2944  005e 2708          	jreq	L1331
2945                     ; 448 				break;
2947                     ; 445 		for(i = 0; i < GESTURE_NUMS; i++){
2949  0060 0c01          	inc	(OFST+0,sp)
2952  0062 7b01          	ld	a,(OFST+0,sp)
2953  0064 a104          	cp	a,#4
2954  0066 25eb          	jrult	L5231
2955  0068               L1331:
2956                     ; 451 		ret = (i == GESTURE_NUMS) ? GET_GESTURE_ERROR : i;
2958  0068 7b01          	ld	a,(OFST+0,sp)
2959  006a a104          	cp	a,#4
2960  006c 2604          	jrne	L07
2961  006e a6ff          	ld	a,#255
2962  0070 2002          	jra	L27
2963  0072               L07:
2964  0072 7b01          	ld	a,(OFST+0,sp)
2965  0074               L27:
2966  0074 6b01          	ld	(OFST+0,sp),a
2967  0076               L3231:
2968                     ; 454 	return ret;
2970  0076 7b01          	ld	a,(OFST+0,sp)
2973  0078 5b03          	addw	sp,#3
2974  007a 81            	ret
3016                     ; 462 void host_meshid_save(u8 meshid_h, u8 meshid_l)
3016                     ; 463 {
3017                     .text:	section	.text,new
3018  0000               _host_meshid_save:
3020  0000 89            	pushw	x
3021       00000000      OFST:	set	0
3024                     ; 465 	if((ns_host_meshid_H != meshid_h) || (ns_host_meshid_L != meshid_l)){
3026  0001 c60028        	ld	a,_ns_host_meshid_H
3027  0004 1101          	cp	a,(OFST+1,sp)
3028  0006 2607          	jrne	L5531
3030  0008 c60027        	ld	a,_ns_host_meshid_L
3031  000b 1102          	cp	a,(OFST+2,sp)
3032  000d 271e          	jreq	L3531
3033  000f               L5531:
3034                     ; 467 		ns_host_meshid_H = meshid_h;
3036  000f 7b01          	ld	a,(OFST+1,sp)
3037  0011 c70028        	ld	_ns_host_meshid_H,a
3038                     ; 468 		ns_host_meshid_L = meshid_l;
3040  0014 7b02          	ld	a,(OFST+2,sp)
3041  0016 c70027        	ld	_ns_host_meshid_L,a
3042                     ; 470 		MEEPROM_WriteByte(EEPROM_MESHID_H_ADDRESS, ns_host_meshid_H);
3044  0019 3b0028        	push	_ns_host_meshid_H
3045  001c ae0031        	ldw	x,#49
3046  001f cd0000        	call	_MEEPROM_WriteByte
3048  0022 84            	pop	a
3049                     ; 471 		MEEPROM_WriteByte(EEPROM_MESHID_L_ADDRESS, ns_host_meshid_L);
3051  0023 3b0027        	push	_ns_host_meshid_L
3052  0026 ae0032        	ldw	x,#50
3053  0029 cd0000        	call	_MEEPROM_WriteByte
3055  002c 84            	pop	a
3056  002d               L3531:
3057                     ; 475 }
3060  002d 85            	popw	x
3061  002e 81            	ret
3096                     ; 482 void keypad_target_status_save(void)
3096                     ; 483 {
3097                     .text:	section	.text,new
3098  0000               _keypad_target_status_save:
3100  0000 89            	pushw	x
3101       00000002      OFST:	set	2
3104                     ; 486 	for(i = 0; i < KEYPAY_NUMS; i++){
3106  0001 0f02          	clr	(OFST+0,sp)
3107  0003               L3731:
3108                     ; 488 		if(st1.keypad[i].actural_val_bak != st1.keypad[i].actural_val){
3110  0003 7b02          	ld	a,(OFST+0,sp)
3111  0005 97            	ld	xl,a
3112  0006 a60b          	ld	a,#11
3113  0008 42            	mul	x,a
3114  0009 d60053        	ld	a,(_st1+37,x)
3115  000c 6b01          	ld	(OFST-1,sp),a
3116  000e 7b02          	ld	a,(OFST+0,sp)
3117  0010 97            	ld	xl,a
3118  0011 a60b          	ld	a,#11
3119  0013 42            	mul	x,a
3120  0014 d60054        	ld	a,(_st1+38,x)
3121  0017 1101          	cp	a,(OFST-1,sp)
3122  0019 2721          	jreq	L1041
3123                     ; 490 			MEEPROM_WriteByte(EEPROM_CH1_TARGET_STATUS_ADDRESS + i, st1.keypad[i].actural_val);
3125  001b 7b02          	ld	a,(OFST+0,sp)
3126  001d 97            	ld	xl,a
3127  001e a60b          	ld	a,#11
3128  0020 42            	mul	x,a
3129  0021 d60053        	ld	a,(_st1+37,x)
3130  0024 88            	push	a
3131  0025 7b03          	ld	a,(OFST+1,sp)
3132  0027 5f            	clrw	x
3133  0028 97            	ld	xl,a
3134  0029 1c002d        	addw	x,#45
3135  002c cd0000        	call	_MEEPROM_WriteByte
3137  002f 84            	pop	a
3138                     ; 491 			st1.keypad[i].actural_val_bak = st1.keypad[i].actural_val;
3140  0030 7b02          	ld	a,(OFST+0,sp)
3141  0032 97            	ld	xl,a
3142  0033 a60b          	ld	a,#11
3143  0035 42            	mul	x,a
3144  0036 d60053        	ld	a,(_st1+37,x)
3145  0039 d70054        	ld	(_st1+38,x),a
3146  003c               L1041:
3147                     ; 486 	for(i = 0; i < KEYPAY_NUMS; i++){
3149  003c 0c02          	inc	(OFST+0,sp)
3152  003e 7b02          	ld	a,(OFST+0,sp)
3153  0040 a103          	cp	a,#3
3154  0042 25bf          	jrult	L3731
3155                     ; 495 }
3158  0044 85            	popw	x
3159  0045 81            	ret
3207                     .const:	section	.text
3208  0000               L201:
3209  0000 00004039      	dc.l	16441
3210  0004               L401:
3211  0004 0000403a      	dc.l	16442
3212  0008               L601:
3213  0008 0000403b      	dc.l	16443
3214  000c               L011:
3215  000c 0000403c      	dc.l	16444
3216  0010               L211:
3217  0010 0000403d      	dc.l	16445
3218  0014               L411:
3219  0014 0000403e      	dc.l	16446
3220  0018               L611:
3221  0018 0000402d      	dc.l	16429
3222  001c               L021:
3223  001c 00004050      	dc.l	16464
3224  0020               L221:
3225  0020 00004051      	dc.l	16465
3226  0024               L421:
3227  0024 00004052      	dc.l	16466
3228  0028               L621:
3229  0028 00004053      	dc.l	16467
3230  002c               L031:
3231  002c 00004054      	dc.l	16468
3232  0030               L231:
3233  0030 00004055      	dc.l	16469
3234  0034               L431:
3235  0034 0000404e      	dc.l	16462
3236  0038               L631:
3237  0038 0000404f      	dc.l	16463
3238                     ; 502 void keypad_or_gesture_save(u8 num, CTRL_TYPE type)
3238                     ; 503 {
3239                     .text:	section	.text,new
3240  0000               _keypad_or_gesture_save:
3242  0000 89            	pushw	x
3243       00000000      OFST:	set	0
3246                     ; 505 	FLASH_Unlock(FLASH_MEMTYPE_DATA);
3248  0001 a601          	ld	a,#1
3249  0003 cd0000        	call	_FLASH_Unlock
3252  0006               L5241:
3253                     ; 506 	while (FLASH_GetFlagStatus(FLASH_FLAG_DUL) == RESET);
3255  0006 a608          	ld	a,#8
3256  0008 cd0000        	call	_FLASH_GetFlagStatus
3258  000b 4d            	tnz	a
3259  000c 27f8          	jreq	L5241
3260                     ; 508 	if(type == KEYPAD_CTRL){
3262  000e 7b02          	ld	a,(OFST+2,sp)
3263  0010 a101          	cp	a,#1
3264  0012 2703          	jreq	L041
3265  0014 cc0149        	jp	L1341
3266  0017               L041:
3267                     ; 510 		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDH_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].meshid_h);
3269  0017 7b01          	ld	a,(OFST+1,sp)
3270  0019 97            	ld	xl,a
3271  001a a60b          	ld	a,#11
3272  001c 42            	mul	x,a
3273  001d d60055        	ld	a,(_st1+39,x)
3274  0020 88            	push	a
3275  0021 7b02          	ld	a,(OFST+2,sp)
3276  0023 97            	ld	xl,a
3277  0024 a607          	ld	a,#7
3278  0026 42            	mul	x,a
3279  0027 cd0000        	call	c_itolx
3281  002a ae0000        	ldw	x,#L201
3282  002d cd0000        	call	c_ladd
3284  0030 be02          	ldw	x,c_lreg+2
3285  0032 89            	pushw	x
3286  0033 be00          	ldw	x,c_lreg
3287  0035 89            	pushw	x
3288  0036 cd0000        	call	_FLASH_ProgramByte
3290  0039 5b05          	addw	sp,#5
3291                     ; 512 		if(st1.keypad[num].flag.bit.setted == 1){		//设置按键则继续保存，若是取消按键则只清零meshid_h即可
3293  003b 7b01          	ld	a,(OFST+1,sp)
3294  003d 97            	ld	xl,a
3295  003e a60b          	ld	a,#11
3296  0040 42            	mul	x,a
3297  0041 d60050        	ld	a,(_st1+34,x)
3298  0044 a502          	bcp	a,#2
3299  0046 2603          	jrne	L241
3300  0048 cc0149        	jp	L1341
3301  004b               L241:
3302                     ; 514 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_MESHIDL_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].meshid_l);
3304  004b 7b01          	ld	a,(OFST+1,sp)
3305  004d 97            	ld	xl,a
3306  004e a60b          	ld	a,#11
3307  0050 42            	mul	x,a
3308  0051 d60056        	ld	a,(_st1+40,x)
3309  0054 88            	push	a
3310  0055 7b02          	ld	a,(OFST+2,sp)
3311  0057 97            	ld	xl,a
3312  0058 a607          	ld	a,#7
3313  005a 42            	mul	x,a
3314  005b cd0000        	call	c_itolx
3316  005e ae0004        	ldw	x,#L401
3317  0061 cd0000        	call	c_ladd
3319  0064 be02          	ldw	x,c_lreg+2
3320  0066 89            	pushw	x
3321  0067 be00          	ldw	x,c_lreg
3322  0069 89            	pushw	x
3323  006a cd0000        	call	_FLASH_ProgramByte
3325  006d 5b05          	addw	sp,#5
3326                     ; 515 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_ACTION_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].action);
3328  006f 7b01          	ld	a,(OFST+1,sp)
3329  0071 97            	ld	xl,a
3330  0072 a60b          	ld	a,#11
3331  0074 42            	mul	x,a
3332  0075 d60058        	ld	a,(_st1+42,x)
3333  0078 88            	push	a
3334  0079 7b02          	ld	a,(OFST+2,sp)
3335  007b 97            	ld	xl,a
3336  007c a607          	ld	a,#7
3337  007e 42            	mul	x,a
3338  007f cd0000        	call	c_itolx
3340  0082 ae0008        	ldw	x,#L601
3341  0085 cd0000        	call	c_ladd
3343  0088 be02          	ldw	x,c_lreg+2
3344  008a 89            	pushw	x
3345  008b be00          	ldw	x,c_lreg
3346  008d 89            	pushw	x
3347  008e cd0000        	call	_FLASH_ProgramByte
3349  0091 5b05          	addw	sp,#5
3350                     ; 516 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_BOARDID_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].boardid);
3352  0093 7b01          	ld	a,(OFST+1,sp)
3353  0095 97            	ld	xl,a
3354  0096 a60b          	ld	a,#11
3355  0098 42            	mul	x,a
3356  0099 d60057        	ld	a,(_st1+41,x)
3357  009c 88            	push	a
3358  009d 7b02          	ld	a,(OFST+2,sp)
3359  009f 97            	ld	xl,a
3360  00a0 a607          	ld	a,#7
3361  00a2 42            	mul	x,a
3362  00a3 cd0000        	call	c_itolx
3364  00a6 ae000c        	ldw	x,#L011
3365  00a9 cd0000        	call	c_ladd
3367  00ac be02          	ldw	x,c_lreg+2
3368  00ae 89            	pushw	x
3369  00af be00          	ldw	x,c_lreg
3370  00b1 89            	pushw	x
3371  00b2 cd0000        	call	_FLASH_ProgramByte
3373  00b5 5b05          	addw	sp,#5
3374                     ; 517 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_VALUE_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].value);
3376  00b7 7b01          	ld	a,(OFST+1,sp)
3377  00b9 97            	ld	xl,a
3378  00ba a60b          	ld	a,#11
3379  00bc 42            	mul	x,a
3380  00bd d60059        	ld	a,(_st1+43,x)
3381  00c0 88            	push	a
3382  00c1 7b02          	ld	a,(OFST+2,sp)
3383  00c3 97            	ld	xl,a
3384  00c4 a607          	ld	a,#7
3385  00c6 42            	mul	x,a
3386  00c7 cd0000        	call	c_itolx
3388  00ca ae0010        	ldw	x,#L211
3389  00cd cd0000        	call	c_ladd
3391  00d0 be02          	ldw	x,c_lreg+2
3392  00d2 89            	pushw	x
3393  00d3 be00          	ldw	x,c_lreg
3394  00d5 89            	pushw	x
3395  00d6 cd0000        	call	_FLASH_ProgramByte
3397  00d9 5b05          	addw	sp,#5
3398                     ; 518 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_KEY1_TIME_ADDRESS + EEPROM_ONEKEY_BYTES_USED * num , st1.keypad[num].time);
3400  00db 7b01          	ld	a,(OFST+1,sp)
3401  00dd 97            	ld	xl,a
3402  00de a60b          	ld	a,#11
3403  00e0 42            	mul	x,a
3404  00e1 d6005a        	ld	a,(_st1+44,x)
3405  00e4 88            	push	a
3406  00e5 7b02          	ld	a,(OFST+2,sp)
3407  00e7 97            	ld	xl,a
3408  00e8 a607          	ld	a,#7
3409  00ea 42            	mul	x,a
3410  00eb cd0000        	call	c_itolx
3412  00ee ae0014        	ldw	x,#L411
3413  00f1 cd0000        	call	c_ladd
3415  00f4 be02          	ldw	x,c_lreg+2
3416  00f6 89            	pushw	x
3417  00f7 be00          	ldw	x,c_lreg
3418  00f9 89            	pushw	x
3419  00fa cd0000        	call	_FLASH_ProgramByte
3421  00fd 5b05          	addw	sp,#5
3422                     ; 520 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_STATUS_ADDRESS + num , st1.keypad[num].status);
3424  00ff 7b01          	ld	a,(OFST+1,sp)
3425  0101 97            	ld	xl,a
3426  0102 a60b          	ld	a,#11
3427  0104 42            	mul	x,a
3428  0105 d60052        	ld	a,(_st1+36,x)
3429  0108 88            	push	a
3430  0109 7b02          	ld	a,(OFST+2,sp)
3431  010b b703          	ld	c_lreg+3,a
3432  010d 3f02          	clr	c_lreg+2
3433  010f 3f01          	clr	c_lreg+1
3434  0111 3f00          	clr	c_lreg
3435  0113 ae0018        	ldw	x,#L611
3436  0116 cd0000        	call	c_ladd
3438  0119 be02          	ldw	x,c_lreg+2
3439  011b 89            	pushw	x
3440  011c be00          	ldw	x,c_lreg
3441  011e 89            	pushw	x
3442  011f cd0000        	call	_FLASH_ProgramByte
3444  0122 5b05          	addw	sp,#5
3445                     ; 521 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_CH1_TARGET_STATUS_ADDRESS + num , st1.keypad[num].actural_val);
3447  0124 7b01          	ld	a,(OFST+1,sp)
3448  0126 97            	ld	xl,a
3449  0127 a60b          	ld	a,#11
3450  0129 42            	mul	x,a
3451  012a d60053        	ld	a,(_st1+37,x)
3452  012d 88            	push	a
3453  012e 7b02          	ld	a,(OFST+2,sp)
3454  0130 b703          	ld	c_lreg+3,a
3455  0132 3f02          	clr	c_lreg+2
3456  0134 3f01          	clr	c_lreg+1
3457  0136 3f00          	clr	c_lreg
3458  0138 ae0018        	ldw	x,#L611
3459  013b cd0000        	call	c_ladd
3461  013e be02          	ldw	x,c_lreg+2
3462  0140 89            	pushw	x
3463  0141 be00          	ldw	x,c_lreg
3464  0143 89            	pushw	x
3465  0144 cd0000        	call	_FLASH_ProgramByte
3467  0147 5b05          	addw	sp,#5
3468  0149               L1341:
3469                     ; 526 	if(type == GESTURE_CTRL){
3471  0149 7b02          	ld	a,(OFST+2,sp)
3472  014b a102          	cp	a,#2
3473  014d 2703          	jreq	L441
3474  014f cc0282        	jp	L5341
3475  0152               L441:
3476                     ; 528 		FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].meshid_h);
3478  0152 7b01          	ld	a,(OFST+1,sp)
3479  0154 97            	ld	xl,a
3480  0155 a60a          	ld	a,#10
3481  0157 42            	mul	x,a
3482  0158 d60075        	ld	a,(_st1+71,x)
3483  015b 88            	push	a
3484  015c 7b02          	ld	a,(OFST+2,sp)
3485  015e 97            	ld	xl,a
3486  015f a609          	ld	a,#9
3487  0161 42            	mul	x,a
3488  0162 cd0000        	call	c_itolx
3490  0165 ae001c        	ldw	x,#L021
3491  0168 cd0000        	call	c_ladd
3493  016b be02          	ldw	x,c_lreg+2
3494  016d 89            	pushw	x
3495  016e be00          	ldw	x,c_lreg
3496  0170 89            	pushw	x
3497  0171 cd0000        	call	_FLASH_ProgramByte
3499  0174 5b05          	addw	sp,#5
3500                     ; 530 		if(st1.gesture[num].flag.bit.setted == 1){		//设置手势则继续保存，若是取消手势则只清零meshid_h即可
3502  0176 7b01          	ld	a,(OFST+1,sp)
3503  0178 97            	ld	xl,a
3504  0179 a60a          	ld	a,#10
3505  017b 42            	mul	x,a
3506  017c d60071        	ld	a,(_st1+67,x)
3507  017f a502          	bcp	a,#2
3508  0181 2603          	jrne	L641
3509  0183 cc0282        	jp	L5341
3510  0186               L641:
3511                     ; 532 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_MESHIDL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].meshid_l);
3513  0186 7b01          	ld	a,(OFST+1,sp)
3514  0188 97            	ld	xl,a
3515  0189 a60a          	ld	a,#10
3516  018b 42            	mul	x,a
3517  018c d60076        	ld	a,(_st1+72,x)
3518  018f 88            	push	a
3519  0190 7b02          	ld	a,(OFST+2,sp)
3520  0192 97            	ld	xl,a
3521  0193 a609          	ld	a,#9
3522  0195 42            	mul	x,a
3523  0196 cd0000        	call	c_itolx
3525  0199 ae0020        	ldw	x,#L221
3526  019c cd0000        	call	c_ladd
3528  019f be02          	ldw	x,c_lreg+2
3529  01a1 89            	pushw	x
3530  01a2 be00          	ldw	x,c_lreg
3531  01a4 89            	pushw	x
3532  01a5 cd0000        	call	_FLASH_ProgramByte
3534  01a8 5b05          	addw	sp,#5
3535                     ; 533 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_ACTION_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].action);
3537  01aa 7b01          	ld	a,(OFST+1,sp)
3538  01ac 97            	ld	xl,a
3539  01ad a60a          	ld	a,#10
3540  01af 42            	mul	x,a
3541  01b0 d60078        	ld	a,(_st1+74,x)
3542  01b3 88            	push	a
3543  01b4 7b02          	ld	a,(OFST+2,sp)
3544  01b6 97            	ld	xl,a
3545  01b7 a609          	ld	a,#9
3546  01b9 42            	mul	x,a
3547  01ba cd0000        	call	c_itolx
3549  01bd ae0024        	ldw	x,#L421
3550  01c0 cd0000        	call	c_ladd
3552  01c3 be02          	ldw	x,c_lreg+2
3553  01c5 89            	pushw	x
3554  01c6 be00          	ldw	x,c_lreg
3555  01c8 89            	pushw	x
3556  01c9 cd0000        	call	_FLASH_ProgramByte
3558  01cc 5b05          	addw	sp,#5
3559                     ; 534 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_BOARDID_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].boardid);
3561  01ce 7b01          	ld	a,(OFST+1,sp)
3562  01d0 97            	ld	xl,a
3563  01d1 a60a          	ld	a,#10
3564  01d3 42            	mul	x,a
3565  01d4 d60077        	ld	a,(_st1+73,x)
3566  01d7 88            	push	a
3567  01d8 7b02          	ld	a,(OFST+2,sp)
3568  01da 97            	ld	xl,a
3569  01db a609          	ld	a,#9
3570  01dd 42            	mul	x,a
3571  01de cd0000        	call	c_itolx
3573  01e1 ae0028        	ldw	x,#L621
3574  01e4 cd0000        	call	c_ladd
3576  01e7 be02          	ldw	x,c_lreg+2
3577  01e9 89            	pushw	x
3578  01ea be00          	ldw	x,c_lreg
3579  01ec 89            	pushw	x
3580  01ed cd0000        	call	_FLASH_ProgramByte
3582  01f0 5b05          	addw	sp,#5
3583                     ; 535 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_VALUE_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].value);
3585  01f2 7b01          	ld	a,(OFST+1,sp)
3586  01f4 97            	ld	xl,a
3587  01f5 a60a          	ld	a,#10
3588  01f7 42            	mul	x,a
3589  01f8 d60079        	ld	a,(_st1+75,x)
3590  01fb 88            	push	a
3591  01fc 7b02          	ld	a,(OFST+2,sp)
3592  01fe 97            	ld	xl,a
3593  01ff a609          	ld	a,#9
3594  0201 42            	mul	x,a
3595  0202 cd0000        	call	c_itolx
3597  0205 ae002c        	ldw	x,#L031
3598  0208 cd0000        	call	c_ladd
3600  020b be02          	ldw	x,c_lreg+2
3601  020d 89            	pushw	x
3602  020e be00          	ldw	x,c_lreg
3603  0210 89            	pushw	x
3604  0211 cd0000        	call	_FLASH_ProgramByte
3606  0214 5b05          	addw	sp,#5
3607                     ; 536 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TIME_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].time);
3609  0216 7b01          	ld	a,(OFST+1,sp)
3610  0218 97            	ld	xl,a
3611  0219 a60a          	ld	a,#10
3612  021b 42            	mul	x,a
3613  021c d6007a        	ld	a,(_st1+76,x)
3614  021f 88            	push	a
3615  0220 7b02          	ld	a,(OFST+2,sp)
3616  0222 97            	ld	xl,a
3617  0223 a609          	ld	a,#9
3618  0225 42            	mul	x,a
3619  0226 cd0000        	call	c_itolx
3621  0229 ae0030        	ldw	x,#L231
3622  022c cd0000        	call	c_ladd
3624  022f be02          	ldw	x,c_lreg+2
3625  0231 89            	pushw	x
3626  0232 be00          	ldw	x,c_lreg
3627  0234 89            	pushw	x
3628  0235 cd0000        	call	_FLASH_ProgramByte
3630  0238 5b05          	addw	sp,#5
3631                     ; 538 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERH_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].ges_h);
3633  023a 7b01          	ld	a,(OFST+1,sp)
3634  023c 97            	ld	xl,a
3635  023d a60a          	ld	a,#10
3636  023f 42            	mul	x,a
3637  0240 d60073        	ld	a,(_st1+69,x)
3638  0243 88            	push	a
3639  0244 7b02          	ld	a,(OFST+2,sp)
3640  0246 97            	ld	xl,a
3641  0247 a609          	ld	a,#9
3642  0249 42            	mul	x,a
3643  024a cd0000        	call	c_itolx
3645  024d ae0034        	ldw	x,#L431
3646  0250 cd0000        	call	c_ladd
3648  0253 be02          	ldw	x,c_lreg+2
3649  0255 89            	pushw	x
3650  0256 be00          	ldw	x,c_lreg
3651  0258 89            	pushw	x
3652  0259 cd0000        	call	_FLASH_ProgramByte
3654  025c 5b05          	addw	sp,#5
3655                     ; 539 			FLASH_ProgramByte(FLASH_DATA_START_PHYSICAL_ADDRESS + EEPROM_GESTURE1_TRIGERL_ADDRESS + EEPROM_ONEGESTURE_BYTES_USED * num , st1.gesture[num].ges_l);
3657  025e 7b01          	ld	a,(OFST+1,sp)
3658  0260 97            	ld	xl,a
3659  0261 a60a          	ld	a,#10
3660  0263 42            	mul	x,a
3661  0264 d60074        	ld	a,(_st1+70,x)
3662  0267 88            	push	a
3663  0268 7b02          	ld	a,(OFST+2,sp)
3664  026a 97            	ld	xl,a
3665  026b a609          	ld	a,#9
3666  026d 42            	mul	x,a
3667  026e cd0000        	call	c_itolx
3669  0271 ae0038        	ldw	x,#L631
3670  0274 cd0000        	call	c_ladd
3672  0277 be02          	ldw	x,c_lreg+2
3673  0279 89            	pushw	x
3674  027a be00          	ldw	x,c_lreg
3675  027c 89            	pushw	x
3676  027d cd0000        	call	_FLASH_ProgramByte
3678  0280 5b05          	addw	sp,#5
3679  0282               L5341:
3680                     ; 545 	FLASH_Lock(FLASH_MEMTYPE_DATA);
3682  0282 a601          	ld	a,#1
3683  0284 cd0000        	call	_FLASH_Lock
3685                     ; 547 }
3688  0287 85            	popw	x
3689  0288 81            	ret
3731                     ; 554 void keypad_slipLevel_save(u8 level1, u8 level2)
3731                     ; 555 {
3732                     .text:	section	.text,new
3733  0000               _keypad_slipLevel_save:
3735  0000 89            	pushw	x
3736       00000000      OFST:	set	0
3739                     ; 556 	mpr121_handle.slipLevel = (level1 >> 4) & 0x0f;
3741  0001 9e            	ld	a,xh
3742  0002 4e            	swap	a
3743  0003 a40f          	and	a,#15
3744  0005 a40f          	and	a,#15
3745  0007 c70013        	ld	_mpr121_handle+19,a
3746                     ; 557 	mpr121_handle.keylongTouchSlipLevel[0] = (level1 & 0x0f);
3748  000a 7b01          	ld	a,(OFST+1,sp)
3749  000c a40f          	and	a,#15
3750  000e c7000c        	ld	_mpr121_handle+12,a
3751                     ; 558 	mpr121_handle.keylongTouchSlipLevel[1] = (level2 >> 4) & 0x0f;
3753  0011 7b02          	ld	a,(OFST+2,sp)
3754  0013 4e            	swap	a
3755  0014 a40f          	and	a,#15
3756  0016 a40f          	and	a,#15
3757  0018 c7000d        	ld	_mpr121_handle+13,a
3758                     ; 559 	mpr121_handle.keylongTouchSlipLevel[2] = (level2 & 0x0f);
3760  001b 7b02          	ld	a,(OFST+2,sp)
3761  001d a40f          	and	a,#15
3762  001f c7000e        	ld	_mpr121_handle+14,a
3763                     ; 561 	if(mpr121_handle.longTouchSlipConfirm){ 	/* 启动滑动功能检测成功时 */
3765  0022 725d0016      	tnz	_mpr121_handle+22
3766  0026 270f          	jreq	L7541
3767                     ; 562 		mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchSlipConfirm -1] + 1;
3769  0028 c60016        	ld	a,_mpr121_handle+22
3770  002b 5f            	clrw	x
3771  002c 97            	ld	xl,a
3772  002d 5a            	decw	x
3773  002e d6000c        	ld	a,(_mpr121_handle+12,x)
3774  0031 4c            	inc	a
3775  0032 c70012        	ld	_mpr121_handle+18,a
3777  0035 201c          	jra	L1641
3778  0037               L7541:
3779                     ; 563 	}else if(mpr121_handle.longTouchKey){
3781  0037 725d0015      	tnz	_mpr121_handle+21
3782  003b 270f          	jreq	L3641
3783                     ; 564 		mpr121_handle.slipValue = mpr121_handle.keylongTouchSlipLevel[mpr121_handle.longTouchKey -1] + 1;
3785  003d c60015        	ld	a,_mpr121_handle+21
3786  0040 5f            	clrw	x
3787  0041 97            	ld	xl,a
3788  0042 5a            	decw	x
3789  0043 d6000c        	ld	a,(_mpr121_handle+12,x)
3790  0046 4c            	inc	a
3791  0047 c70012        	ld	_mpr121_handle+18,a
3793  004a 2007          	jra	L1641
3794  004c               L3641:
3795                     ; 566 		mpr121_handle.slipValue = mpr121_handle.slipLevel + 1;
3797  004c c60013        	ld	a,_mpr121_handle+19
3798  004f 4c            	inc	a
3799  0050 c70012        	ld	_mpr121_handle+18,a
3800  0053               L1641:
3801                     ; 569 	MPR121_slipPad_or_longTouch_value_save(0);
3803  0053 4f            	clr	a
3804  0054 cd0000        	call	_MPR121_slipPad_or_longTouch_value_save
3806                     ; 570 	MPR121_slipPad_or_longTouch_value_save(1);
3808  0057 a601          	ld	a,#1
3809  0059 cd0000        	call	_MPR121_slipPad_or_longTouch_value_save
3811                     ; 571 	MPR121_slipPad_or_longTouch_value_save(2);
3813  005c a602          	ld	a,#2
3814  005e cd0000        	call	_MPR121_slipPad_or_longTouch_value_save
3816                     ; 572 	MPR121_slipPad_or_longTouch_value_save(3);
3818  0061 a603          	ld	a,#3
3819  0063 cd0000        	call	_MPR121_slipPad_or_longTouch_value_save
3821                     ; 574 }
3824  0066 85            	popw	x
3825  0067 81            	ret
3854                     ; 582 void recv_heart_beat(void)
3854                     ; 583 {
3855                     .text:	section	.text,new
3856  0000               _recv_heart_beat:
3860                     ; 604 	BLE_uart.txBuf[0] = 0xEE;
3862  0000 35ee0024      	mov	_BLE_uart+36,#238
3863                     ; 605 	BLE_uart.txBuf[1] = 0xAA;
3865  0004 35aa0025      	mov	_BLE_uart+37,#170
3866                     ; 606 	BLE_uart.txBuf[2] = rev_message_id;
3868  0008 5500260026    	mov	_BLE_uart+38,_rev_message_id
3869                     ; 607 	BLE_uart.txBuf[3] = rev_meshid_H;
3871  000d 5500250027    	mov	_BLE_uart+39,_rev_meshid_H
3872                     ; 608 	BLE_uart.txBuf[4] = rev_meshid_L;
3874  0012 5500240028    	mov	_BLE_uart+40,_rev_meshid_L
3875                     ; 609 	BLE_uart.txBuf[5] = 5;	
3877  0017 35050029      	mov	_BLE_uart+41,#5
3878                     ; 610 	BLE_uart.txBuf[6] = 0x12;
3880  001b 3512002a      	mov	_BLE_uart+42,#18
3881                     ; 612 	BLE_uart.txBuf[BLE_uart.txBuf[5] + 2] = Check_Sum((BLE_uart.txBuf + 2), BLE_uart.txBuf[5]);
3883  001f 4b05          	push	#5
3884  0021 ae0026        	ldw	x,#_BLE_uart+38
3885  0024 cd0000        	call	_Check_Sum
3887  0027 5b01          	addw	sp,#1
3888  0029 c7002b        	ld	_BLE_uart+43,a
3889                     ; 613 	BLE_uart_send_until_finish();
3891  002c cd0000        	call	_BLE_uart_send_until_finish
3893                     ; 615 }
3896  002f 81            	ret
3925                     ; 621 void recv_ble_ctrl(void)
3925                     ; 622 {
3926                     .text:	section	.text,new
3927  0000               _recv_ble_ctrl:
3931                     ; 624 	switch(sicp_buf[4])
3933  0000 c60004        	ld	a,_sicp_buf+4
3934  0003 a101          	cp	a,#1
3935  0005 2619          	jrne	L1251
3938  0007               L7741:
3939                     ; 626 		case 0x01:	//网络状态帧
3939                     ; 627 			ns_signal = sicp_buf[5];
3941  0007 550005002d    	mov	_ns_signal,_sicp_buf+5
3942                     ; 628 			ns_status = sicp_buf[6];
3944  000c 550006002c    	mov	_ns_status,_sicp_buf+6
3945                     ; 629 			ns_phonenum = sicp_buf[7];
3947  0011 550007002b    	mov	_ns_phonenum,_sicp_buf+7
3948                     ; 630 			ns_own_meshid_H = sicp_buf[8];
3950  0016 550008002a    	mov	_ns_own_meshid_H,_sicp_buf+8
3951                     ; 631 			ns_own_meshid_L = sicp_buf[9];
3953  001b 5500090029    	mov	_ns_own_meshid_L,_sicp_buf+9
3954                     ; 632 			break;
3956  0020               L1051:
3957                     ; 634 		case 0x02:	//重置芯片，清空串口缓存，保留mesh连接
3957                     ; 635 			break;
3959  0020               L3051:
3960                     ; 637 		case 0x03:	//重置芯片和网络，退出mesh连接
3960                     ; 638 
3960                     ; 639 			break;
3962  0020               L5051:
3963                     ; 640 		default:
3963                     ; 641 			break;
3965  0020               L1251:
3966                     ; 645 }
3969  0020 81            	ret
4019                     ; 651 void recv_ble_data(void)
4019                     ; 652 {
4020                     .text:	section	.text,new
4021  0000               _recv_ble_data:
4023  0000 89            	pushw	x
4024       00000002      OFST:	set	2
4027                     ; 653 	u8 i, num, ret = 0x01, cmd = 0;
4029  0001 a601          	ld	a,#1
4030  0003 6b01          	ld	(OFST-1,sp),a
4033  0005 0f02          	clr	(OFST+0,sp)
4034                     ; 655 	switch(sicp_buf[6]){
4036  0007 c60006        	ld	a,_sicp_buf+6
4038                     ; 895 		default:
4038                     ; 896 			break;
4039  000a a010          	sub	a,#16
4040  000c 270e          	jreq	L3251
4041  000e a027          	sub	a,#39
4042  0010 271f          	jreq	L7251
4043  0012 a073          	sub	a,#115
4044  0014 2712          	jreq	L5251
4045  0016 a006          	sub	a,#6
4046  0018 2735          	jreq	L1351
4047  001a 2072          	jra	L5551
4048  001c               L3251:
4049                     ; 657 		case 0x10:		/* 心跳 */ //heartbeat获取当前设备状态信息(灯亮度，开关等)
4049                     ; 658 			if(sicp_buf[7] == 0x01){			
4051  001c c60007        	ld	a,_sicp_buf+7
4052  001f a101          	cp	a,#1
4053  0021 266b          	jrne	L5551
4054                     ; 659 				recv_heart_beat();
4056  0023 cd0000        	call	_recv_heart_beat
4058  0026 2066          	jra	L5551
4059  0028               L5251:
4060                     ; 663 		case 0xAA:		/* 回执 */
4060                     ; 664 			if(sicp_buf[7] == 0x07){		//SS/SC回复ST丢包，置位receipt_send_failed
4062  0028 c60007        	ld	a,_sicp_buf+7
4063  002b a107          	cp	a,#7
4064  002d 265f          	jrne	L5551
4065  002f 205d          	jra	L5551
4066  0031               L7251:
4067                     ; 668 		case 0x37:		/* SS刷新ST调光值  */
4067                     ; 669 			send_receipt(rev_message_id, rev_meshid_H, rev_meshid_L, 0x01); 	
4069  0031 4b01          	push	#1
4070  0033 3b0024        	push	_rev_meshid_L
4071  0036 c60025        	ld	a,_rev_meshid_H
4072  0039 97            	ld	xl,a
4073  003a c60026        	ld	a,_rev_message_id
4074  003d 95            	ld	xh,a
4075  003e cd0000        	call	_send_receipt
4077  0041 85            	popw	x
4078                     ; 671 			keypad_slipLevel_save(sicp_buf[7], sicp_buf[8]);
4080  0042 c60008        	ld	a,_sicp_buf+8
4081  0045 97            	ld	xl,a
4082  0046 c60007        	ld	a,_sicp_buf+7
4083  0049 95            	ld	xh,a
4084  004a cd0000        	call	_keypad_slipLevel_save
4086                     ; 673 			break;
4088  004d 203f          	jra	L5551
4089  004f               L1351:
4090                     ; 675 		case 0xB0:		/* 设备广播 */	
4090                     ; 676 			if(rev_message_id == 0){
4092  004f 725d0026      	tnz	_rev_message_id
4093  0053 2639          	jrne	L5551
4094                     ; 678 				if((st1.deviceID[0] == sicp_buf[7]) && (st1.deviceID[1] == sicp_buf[8]) && 
4094                     ; 679 					(st1.deviceID[2] == sicp_buf[9]) && (st1.deviceID[3] == sicp_buf[10])){
4096  0055 c6002e        	ld	a,_st1
4097  0058 c10007        	cp	a,_sicp_buf+7
4098  005b 2631          	jrne	L5551
4100  005d c6002f        	ld	a,_st1+1
4101  0060 c10008        	cp	a,_sicp_buf+8
4102  0063 2629          	jrne	L5551
4104  0065 c60030        	ld	a,_st1+2
4105  0068 c10009        	cp	a,_sicp_buf+9
4106  006b 2621          	jrne	L5551
4108  006d c60031        	ld	a,_st1+3
4109  0070 c1000a        	cp	a,_sicp_buf+10
4110  0073 2619          	jrne	L5551
4111                     ; 681 					host_meshid_save(rev_meshid_H, rev_meshid_L);
4113  0075 c60024        	ld	a,_rev_meshid_L
4114  0078 97            	ld	xl,a
4115  0079 c60025        	ld	a,_rev_meshid_H
4116  007c 95            	ld	xh,a
4117  007d cd0000        	call	_host_meshid_save
4119                     ; 682 					rev_ssbroadcast = 1;
4121  0080 721200ae      	bset	_UART1Flag4_,#1
4122                     ; 683 					send_device_info_all(0xAA, rev_message_id);
4124  0084 c60026        	ld	a,_rev_message_id
4125  0087 97            	ld	xl,a
4126  0088 a6aa          	ld	a,#170
4127  008a 95            	ld	xh,a
4128  008b cd0000        	call	_send_device_info_all
4130  008e               L3351:
4131                     ; 895 		default:
4131                     ; 896 			break;
4133  008e               L5551:
4134                     ; 903 }
4137  008e 85            	popw	x
4138  008f 81            	ret
4243                     ; 911 BLE_DATA_FRAME recv_header_anaylze(u8 *msg_id, u8 *mesh_id_H, u8 *mesh_id_L, u8 *msg_len)
4243                     ; 912 {
4244                     .text:	section	.text,new
4245  0000               _recv_header_anaylze:
4247  0000 89            	pushw	x
4248  0001 88            	push	a
4249       00000001      OFST:	set	1
4252                     ; 913 	BLE_DATA_FRAME ret = BLE_INVALID;
4254  0002 a603          	ld	a,#3
4255  0004 6b01          	ld	(OFST+0,sp),a
4256                     ; 915 	if ((sicp_buf[0] == 0xEE) && ((sicp_buf[1]== 0xEE) || (sicp_buf[1]== 0xAA)))
4258  0006 c60000        	ld	a,_sicp_buf
4259  0009 a1ee          	cp	a,#238
4260  000b 262c          	jrne	L7361
4262  000d c60001        	ld	a,_sicp_buf+1
4263  0010 a1ee          	cp	a,#238
4264  0012 2707          	jreq	L1461
4266  0014 c60001        	ld	a,_sicp_buf+1
4267  0017 a1aa          	cp	a,#170
4268  0019 261e          	jrne	L7361
4269  001b               L1461:
4270                     ; 917 		ret = BLE_DATA_EE;
4272  001b a601          	ld	a,#1
4273  001d 6b01          	ld	(OFST+0,sp),a
4274                     ; 918 		*msg_id = sicp_buf[2];
4276  001f 1e02          	ldw	x,(OFST+1,sp)
4277  0021 c60002        	ld	a,_sicp_buf+2
4278  0024 f7            	ld	(x),a
4279                     ; 919 		*mesh_id_H = sicp_buf[3];
4281  0025 1e06          	ldw	x,(OFST+5,sp)
4282  0027 c60003        	ld	a,_sicp_buf+3
4283  002a f7            	ld	(x),a
4284                     ; 920 		*mesh_id_L = sicp_buf[4];
4286  002b 1e08          	ldw	x,(OFST+7,sp)
4287  002d c60004        	ld	a,_sicp_buf+4
4288  0030 f7            	ld	(x),a
4289                     ; 921 		*msg_len = sicp_buf[5];
4291  0031 1e0a          	ldw	x,(OFST+9,sp)
4292  0033 c60005        	ld	a,_sicp_buf+5
4293  0036 f7            	ld	(x),a
4295  0037 2018          	jra	L3461
4296  0039               L7361:
4297                     ; 923 	else if ((sicp_buf[0] == 0xDD) && (sicp_buf[1]== 0xDD))	//Network	Status	Reporting
4299  0039 c60000        	ld	a,_sicp_buf
4300  003c a1dd          	cp	a,#221
4301  003e 2611          	jrne	L3461
4303  0040 c60001        	ld	a,_sicp_buf+1
4304  0043 a1dd          	cp	a,#221
4305  0045 260a          	jrne	L3461
4306                     ; 925 		ret = BLE_CTRL_DD;
4308  0047 a602          	ld	a,#2
4309  0049 6b01          	ld	(OFST+0,sp),a
4310                     ; 926 		*msg_len = sicp_buf[3];
4312  004b 1e0a          	ldw	x,(OFST+9,sp)
4313  004d c60003        	ld	a,_sicp_buf+3
4314  0050 f7            	ld	(x),a
4315  0051               L3461:
4316                     ; 929 	return ret; 
4318  0051 7b01          	ld	a,(OFST+0,sp)
4321  0053 5b03          	addw	sp,#3
4322  0055 81            	ret
4365                     ; 937 void recv_analyze_reply(void)
4365                     ; 938 {
4366                     .text:	section	.text,new
4367  0000               _recv_analyze_reply:
4369  0000 88            	push	a
4370       00000001      OFST:	set	1
4373                     ; 940 	BLE_DATA_FRAME ret = BLE_INVALID;
4375  0001 a603          	ld	a,#3
4376  0003 6b01          	ld	(OFST+0,sp),a
4377                     ; 942 	if (rev_success){
4379  0005 c600af        	ld	a,_UART1Flag1_
4380  0008 a501          	bcp	a,#1
4381  000a 272e          	jreq	L5661
4382                     ; 944 		ret = recv_header_anaylze(&rev_message_id, &rev_meshid_H, &rev_meshid_L, &BLE_uart.rxLen);
4384  000c ae0003        	ldw	x,#_BLE_uart+3
4385  000f 89            	pushw	x
4386  0010 ae0024        	ldw	x,#_rev_meshid_L
4387  0013 89            	pushw	x
4388  0014 ae0025        	ldw	x,#_rev_meshid_H
4389  0017 89            	pushw	x
4390  0018 ae0026        	ldw	x,#_rev_message_id
4391  001b cd0000        	call	_recv_header_anaylze
4393  001e 5b06          	addw	sp,#6
4394  0020 6b01          	ld	(OFST+0,sp),a
4395                     ; 946 		if(ret == BLE_DATA_EE){
4397  0022 7b01          	ld	a,(OFST+0,sp)
4398  0024 a101          	cp	a,#1
4399  0026 2605          	jrne	L7661
4400                     ; 954 			recv_ble_data();
4402  0028 cd0000        	call	_recv_ble_data
4405  002b 2009          	jra	L1761
4406  002d               L7661:
4407                     ; 956 		}else if(ret == BLE_CTRL_DD){
4409  002d 7b01          	ld	a,(OFST+0,sp)
4410  002f a102          	cp	a,#2
4411  0031 2603          	jrne	L1761
4412                     ; 958 			recv_ble_ctrl();
4414  0033 cd0000        	call	_recv_ble_ctrl
4416  0036               L1761:
4417                     ; 962 		rev_success = 0;
4419  0036 721100af      	bres	_UART1Flag1_,#0
4420  003a               L5661:
4421                     ; 966 }
4424  003a 84            	pop	a
4425  003b 81            	ret
4505                     	xdef	_recv_header_anaylze
4506                     	xdef	_recv_ble_data
4507                     	xdef	_recv_ble_ctrl
4508                     	xdef	_keypad_slipLevel_save
4509                     	xdef	_keypad_or_gesture_save
4510                     	xdef	_keypad_target_status_save
4511                     	xdef	_host_meshid_save
4512                     	xdef	_send_receipt
4513                     	xref	_MPR121_slipPad_or_longTouch_value_save
4514                     	xref	_mpr121_handle
4515                     	xref	_FLASH_GetFlagStatus
4516                     	xref	_FLASH_ProgramByte
4517                     	xref	_FLASH_Lock
4518                     	xref	_FLASH_Unlock
4519                     	xref	_UART1_ITConfig
4520                     	xref	_UART1_Cmd
4521                     	xref	_UART1_Init
4522                     	xref	_UART1_DeInit
4523                     	xdef	_send_device_info_active
4524                     	xdef	_send_device_info_all
4525                     	xdef	_send_action_sync
4526                     	xdef	_send_action_ctrl
4527                     	xdef	_send_action_without_setted
4528                     	xdef	_get_gesture_num
4529                     	xdef	_recv_heart_beat
4530                     	xdef	_send_cmd_data
4531                     	xdef	_recv_analyze_reply
4532                     	xdef	_BLE_UART_RX_ISR
4533                     	xdef	_BLE_UART_TX_ISR
4534                     	xdef	_BLE_uart_send_until_finish
4535                     	xdef	_BLE_uart_init
4536                     	xdef	_Check_Sum
4537                     	xdef	_BLE_uart
4538                     	switch	.bss
4539  0000               _sicp_buf:
4540  0000 000000000000  	ds.b	32
4541                     	xdef	_sicp_buf
4542  0020               _send_failed_count:
4543  0020 0000          	ds.b	2
4544                     	xdef	_send_failed_count
4545  0022               _send_fault_count:
4546  0022 0000          	ds.b	2
4547                     	xdef	_send_fault_count
4548  0024               _rev_meshid_L:
4549  0024 00            	ds.b	1
4550                     	xdef	_rev_meshid_L
4551  0025               _rev_meshid_H:
4552  0025 00            	ds.b	1
4553                     	xdef	_rev_meshid_H
4554  0026               _rev_message_id:
4555  0026 00            	ds.b	1
4556                     	xdef	_rev_message_id
4557  0027               _ns_host_meshid_L:
4558  0027 00            	ds.b	1
4559                     	xdef	_ns_host_meshid_L
4560  0028               _ns_host_meshid_H:
4561  0028 00            	ds.b	1
4562                     	xdef	_ns_host_meshid_H
4563  0029               _ns_own_meshid_L:
4564  0029 00            	ds.b	1
4565                     	xdef	_ns_own_meshid_L
4566  002a               _ns_own_meshid_H:
4567  002a 00            	ds.b	1
4568                     	xdef	_ns_own_meshid_H
4569  002b               _ns_phonenum:
4570  002b 00            	ds.b	1
4571                     	xdef	_ns_phonenum
4572  002c               _ns_status:
4573  002c 00            	ds.b	1
4574                     	xdef	_ns_status
4575  002d               _ns_signal:
4576  002d 00            	ds.b	1
4577                     	xdef	_ns_signal
4578  002e               _st1:
4579  002e 000000000000  	ds.b	125
4580                     	xdef	_st1
4581  00ab               _st_pad_temp:
4582  00ab 00            	ds.b	1
4583                     	xdef	_st_pad_temp
4584  00ac               _st1_st_ges_L_temp:
4585  00ac 00            	ds.b	1
4586                     	xdef	_st1_st_ges_L_temp
4587  00ad               _st1_st_ges_H_temp:
4588  00ad 00            	ds.b	1
4589                     	xdef	_st1_st_ges_H_temp
4590  00ae               _UART1Flag4_:
4591  00ae 00            	ds.b	1
4592                     	xdef	_UART1Flag4_
4593  00af               _UART1Flag1_:
4594  00af 00            	ds.b	1
4595                     	xdef	_UART1Flag1_
4596  00b0               _uart2TxSLLast:
4597  00b0 0000          	ds.b	2
4598                     	xdef	_uart2TxSLLast
4599  00b2               _uart2TxSLHead:
4600  00b2 0000          	ds.b	2
4601                     	xdef	_uart2TxSLHead
4602  00b4               _mutex2:
4603  00b4 00            	ds.b	1
4604                     	xdef	_mutex2
4605                     	xref	_MEEPROM_WriteByte
4606                     	xref	_sicp_get_message_id
4607                     	xref	_BIT
4608                     	xref.b	c_lreg
4609                     	xref.b	c_x
4610                     	xref.b	c_y
4630                     	xref	c_ladd
4631                     	xref	c_itolx
4632                     	end
