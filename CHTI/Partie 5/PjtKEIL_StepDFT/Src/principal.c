#include "DriverJeuLaser.h"


int DFT_ModuleAuCarre( short int * Signal64ech, char k) ;
int TLDR[64] ; 
short int * print[64];
short int dma_buf[64] ; 
int fnormal[6] = {17,18,19,20,22,23};
int score[6] = {0,0,0,0,0,0}; 
int k ; 


void callback_sys(void ){
	Start_DMA1(64);
	Wait_On_End_Of_DMA1();
	Stop_DMA1; 

	for (int i = 0; i < 64 ; i ++ ) 
	{
		
		// TLDR[i] = DFT_ModuleAuCarre(LeSignal, i); // pour partie simu 
		
		k = fnormal[i] ; 
		
		if (DFT_ModuleAuCarre(dma_buf, k) > 0 ) 
		{
			score[i] += 1 ; 
		}
		
	}

}


int main(void)
{


// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();
	
Systick_Period_ff( 5*72e3 ); 
Systick_Prio_IT( 10 , callback_sys );
SysTick_On ;
SysTick_Enable_IT ;
	
Init_TimingADC_ActiveADC_ff( ADC1, 72 );
Single_Channel_ADC( ADC1, 2 );
Init_Conversion_On_Trig_Timer_ff( ADC1, TIM2_CC2, 225 );
Init_ADC1_DMA1( 0, dma_buf );

		

		
	
	

//============================================================================	
	
	
while	(1)
	{	}
}
