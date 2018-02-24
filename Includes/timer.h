#ifndef __TIMER_H
#define __TIMER_H

#ifndef _TIMER_GLOBAL
#define TIEMR_EXT	extern
#else
#define TIEMR_EXT
#endif





void timer2_init(void);


@far @interrupt void timer2_ISR(void);




#endif
