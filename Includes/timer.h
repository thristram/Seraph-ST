#ifndef __TIMER_H
#define __TIMER_H

#ifndef _TIMER_GLOBAL
#define TIEMR_EXT	extern
#else
#define TIEMR_EXT
#endif



TIEMR_EXT void Init_Time3(void);
TIEMR_EXT void Sys_Time_Manage(void);
@interrupt void Tim3_UPD_OVF_BRK_ISR(void);

#endif