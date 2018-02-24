   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Generator V4.2.4 - 19 Dec 2007
  82                     ; 135 void TSL_Init(void)
  82                     ; 136 {
  84                     .text:	section	.text,new
  85  0000               _TSL_Init:
  89                     ; 139 	disableInterrupts();
  92  0000 9b            sim
  94                     ; 141 	DetectionIntegrator = DETECTION_INTEGRATOR_DEFAULT;
  97  0001 35020009      	mov	_DetectionIntegrator,#2
  98                     ; 142 	EndDetectionIntegrator = END_DETECTION_INTEGRATOR_DEFAULT;
 100  0005 35020008      	mov	_EndDetectionIntegrator,#2
 101                     ; 143 	ECSTimeStep = ECS_TIME_STEP_DEFAULT;
 103  0009 35140006      	mov	_ECSTimeStep,#20
 104                     ; 144 	ECSTemporization = ECS_TEMPO_DEFAULT;
 106  000d 35140005      	mov	_ECSTemporization,#20
 107                     ; 145 	RecalibrationIntegrator = RECALIBRATION_INTEGRATOR_DEFAULT;
 109  0011 351e0007      	mov	_RecalibrationIntegrator,#30
 110                     ; 146 	DetectionTimeout = DTO_DEFAULT;
 112  0015 725f000a      	clr	_DetectionTimeout
 113                     ; 148 	ECS_K_Fast = ECS_IIR_KFAST_DEFAULT;
 115  0019 35140004      	mov	_ECS_K_Fast,#20
 116                     ; 149 	ECS_K_Slow = ECS_IIR_KSLOW_DEFAULT;
 118  001d 350a0003      	mov	_ECS_K_Slow,#10
 119                     ; 150 	ECSTimeStepCounter = ECSTimeStep;
 121  0021 35140000      	mov	_ECSTimeStepCounter,#20
 122                     ; 151 	ECSTempoCounter = 0;
 124  0025 725f0001      	clr	_ECSTempoCounter
 125                     ; 152 	ECSTempoPrescaler = 0;
 127  0029 725f0000      	clr	_ECSTempoPrescaler
 128                     ; 154 	TSL_IO_Init();
 130  002d cd0000        	call	_TSL_IO_Init
 132                     ; 156 	TSL_Timer_Init();
 134  0030 cd0000        	call	_TSL_Timer_Init
 136                     ; 158 	TSL_SCKey_Init();
 138  0033 cd0000        	call	_TSL_SCKey_Init
 140                     ; 164 	enableInterrupts();
 143  0036 9a            rim
 145                     ; 166 	TSLState = TSL_IDLE_STATE;
 148  0037 3501000e      	mov	_TSLState,#1
 149                     ; 169 }
 152  003b 81            	ret
 188                     ; 182 void TSL_Action(void)
 188                     ; 183 {
 189                     .text:	section	.text,new
 190  0000               _TSL_Action:
 194                     ; 185   switch ( TSLState )
 196  0000 b60e          	ld	a,_TSLState
 198                     ; 295       break;
 199  0002 4a            	dec	a
 200  0003 270c          	jreq	L53
 201  0005 4a            	dec	a
 202  0006 270f          	jreq	L73
 203  0008 4a            	dec	a
 204  0009 2724          	jreq	L14
 205  000b a008          	sub	a,#8
 206  000d 2733          	jreq	L34
 207  000f               L17:
 209  000f 20fe          	jra	L17
 210  0011               L53:
 211                     ; 188     case TSL_IDLE_STATE:
 211                     ; 189       TSLState = TSL_SCKEY_P1_ACQ_STATE;
 213  0011 3502000e      	mov	_TSLState,#2
 214                     ; 190       break;
 216  0015 203e          	jra	L16
 217  0017               L73:
 218                     ; 193       disableInterrupts();
 221  0017 9b            sim
 223                     ; 194       Local_TickFlag.b.DTO_1sec = TSL_Tick_Flags.b.DTO_1sec;
 226                     	btst		_TSL_Tick_Flags,#0
 227  001d 90110001      	bccm	_Local_TickFlag,#0
 228                     ; 195       TSL_Tick_Flags.b.DTO_1sec = 0;
 230  0021 72110000      	bres	_TSL_Tick_Flags,#0
 231                     ; 196       enableInterrupts();
 234  0025 9a            rim
 236                     ; 198       TSL_SCKEY_P1_Acquisition();
 239  0026 cd0000        	call	_TSL_SCKEY_P1_Acquisition
 241                     ; 199       TSLState = TSL_SCKEY_P1_PROC_STATE;
 243  0029 3503000e      	mov	_TSLState,#3
 244                     ; 200       break;
 246  002d 2026          	jra	L16
 247  002f               L14:
 248                     ; 202     case TSL_SCKEY_P1_PROC_STATE:
 248                     ; 203       for ( KeyIndex = 0; KeyIndex < SCKEY_P1_KEY_COUNT; KeyIndex++ )
 250  002f 3f08          	clr	_KeyIndex
 251  0031               L36:
 252                     ; 205         TSL_SCKey_Process();
 254  0031 cd0000        	call	_TSL_SCKey_Process
 256                     ; 203       for ( KeyIndex = 0; KeyIndex < SCKEY_P1_KEY_COUNT; KeyIndex++ )
 258  0034 3c08          	inc	_KeyIndex
 261  0036 b608          	ld	a,_KeyIndex
 262  0038 a103          	cp	a,#3
 263  003a 25f5          	jrult	L36
 264                     ; 214       TSLState = TSL_ECS_STATE;
 266  003c 350b000e      	mov	_TSLState,#11
 267                     ; 217       break;
 269  0040 2013          	jra	L16
 270  0042               L34:
 271                     ; 288     case TSL_ECS_STATE:
 271                     ; 289       TSL_ECS();
 273  0042 cd0000        	call	_TSL_ECS
 275                     ; 290       TSL_GlobalSetting.whole = TSL_TempGlobalSetting.whole;
 277  0045 be04          	ldw	x,_TSL_TempGlobalSetting
 278  0047 bf0c          	ldw	_TSL_GlobalSetting,x
 279                     ; 291       TSL_TempGlobalSetting.whole = 0;
 281  0049 5f            	clrw	x
 282  004a bf04          	ldw	_TSL_TempGlobalSetting,x
 283                     ; 292       TSL_GlobalState.whole = TSL_TempGlobalState.whole;
 285  004c 45030b        	mov	_TSL_GlobalState,_TSL_TempGlobalState
 286                     ; 293       TSL_TempGlobalState.whole = 0;
 288  004f 3f03          	clr	_TSL_TempGlobalState
 289                     ; 294       TSLState = TSL_IDLE_STATE;
 291  0051 3501000e      	mov	_TSLState,#1
 292                     ; 295       break;
 294  0055               L16:
 295                     ; 305 }
 298  0055 81            	ret
1188                     	xref	_TSL_ECS
1189                     	switch	.bss
1190  0000               _ECSTempoPrescaler:
1191  0000 00            	ds.b	1
1192                     	xdef	_ECSTempoPrescaler
1193  0001               _ECSTempoCounter:
1194  0001 00            	ds.b	1
1195                     	xdef	_ECSTempoCounter
1196                     	switch	.ubsct
1197  0000               _ECSTimeStepCounter:
1198  0000 00            	ds.b	1
1199                     	xdef	_ECSTimeStepCounter
1200  0001               _Local_TickFlag:
1201  0001 00            	ds.b	1
1202                     	xdef	_Local_TickFlag
1203  0002               _Local_TickECS10ms:
1204  0002 00            	ds.b	1
1205                     	xdef	_Local_TickECS10ms
1206  0003               _TSL_TempGlobalState:
1207  0003 00            	ds.b	1
1208                     	xdef	_TSL_TempGlobalState
1209  0004               _TSL_TempGlobalSetting:
1210  0004 0000          	ds.b	2
1211                     	xdef	_TSL_TempGlobalSetting
1212  0006               _Delta:
1213  0006 0000          	ds.b	2
1214                     	xdef	_Delta
1215  0008               _KeyIndex:
1216  0008 00            	ds.b	1
1217                     	xdef	_KeyIndex
1218                     	xref	_TSL_IO_Init
1219                     	xref	_TSL_SCKey_Process
1220                     	xref	_TSL_SCKEY_P1_Acquisition
1221                     	xref	_TSL_SCKey_Init
1222                     	xdef	_TSL_Action
1223                     	xdef	_TSL_Init
1224                     	switch	.bss
1225  0002               _IT_Sync_Flags:
1226  0002 00            	ds.b	1
1227                     	xdef	_IT_Sync_Flags
1228  0003               _ECS_K_Slow:
1229  0003 00            	ds.b	1
1230                     	xdef	_ECS_K_Slow
1231  0004               _ECS_K_Fast:
1232  0004 00            	ds.b	1
1233                     	xdef	_ECS_K_Fast
1234  0005               _ECSTemporization:
1235  0005 00            	ds.b	1
1236                     	xdef	_ECSTemporization
1237  0006               _ECSTimeStep:
1238  0006 00            	ds.b	1
1239                     	xdef	_ECSTimeStep
1240  0007               _RecalibrationIntegrator:
1241  0007 00            	ds.b	1
1242                     	xdef	_RecalibrationIntegrator
1243  0008               _EndDetectionIntegrator:
1244  0008 00            	ds.b	1
1245                     	xdef	_EndDetectionIntegrator
1246  0009               _DetectionIntegrator:
1247  0009 00            	ds.b	1
1248                     	xdef	_DetectionIntegrator
1249  000a               _DetectionTimeout:
1250  000a 00            	ds.b	1
1251                     	xdef	_DetectionTimeout
1252  000b               _sSCKeyInfo:
1253  000b 000000000000  	ds.b	45
1254                     	xdef	_sSCKeyInfo
1255                     	switch	.ubsct
1256  0009               _pKeyStruct:
1257  0009 0000          	ds.b	2
1258                     	xdef	_pKeyStruct
1259  000b               _TSL_GlobalState:
1260  000b 00            	ds.b	1
1261                     	xdef	_TSL_GlobalState
1262  000c               _TSL_GlobalSetting:
1263  000c 0000          	ds.b	2
1264                     	xdef	_TSL_GlobalSetting
1265  000e               _TSLState:
1266  000e 00            	ds.b	1
1267                     	xdef	_TSLState
1268                     	xref	_TSL_Timer_Init
1269                     	xref.b	_TSL_Tick_Flags
1289                     	end
