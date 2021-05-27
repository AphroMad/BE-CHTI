

#include "DriverJeuLaser.h"

extern int index ; 

void CallbackSon(void);

void start_son() 
{
	index = 0 ; 
} 

int son(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


GPIO_Configure(GPIOB, 0, OUTPUT, ALT_PPULL);
PWM_Init_ff( TIM3, 3, 720);
	
Timer_1234_Init_ff( TIM4, 6552);
Active_IT_Debordement_Timer( TIM4, 2, CallbackSon );


	

//============================================================================	
	
	
while	(1)
	{	
		int i; 
		for(i=0;i<10000000;i++){}
		start_son(); 
	}
}

