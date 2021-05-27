

#include "DriverJeuLaser.h"

int DFT_ModuleAuCarre( short int * Signal64ech, char k) ;
extern short int LeSignal[64] ; 
int TLDR[64] ; 

int main(void)
{

// ===========================================================================
// ============= INIT PERIPH (faites qu'une seule fois)  =====================
// ===========================================================================

// Après exécution : le coeur CPU est clocké à 72MHz ainsi que tous les timers
CLOCK_Configure();


for (int i = 0; i < 64 ; i ++ ) 
{
	TLDR[i] = DFT_ModuleAuCarre(LeSignal, i);
}
		
	
	

//============================================================================	
	
	
while	(1)
	{	}
}

