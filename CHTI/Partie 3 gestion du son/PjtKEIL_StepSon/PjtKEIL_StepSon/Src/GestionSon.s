	PRESERVE8
	THUMB   
	
	INCLUDE Driver/DriverJeuLaser.inc
	EXPORT SortieSon
	EXPORT CallbackSon
	EXPORT index
	IMPORT Son
	IMPORT LongueurSon

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly

;Section RAM (read write):
	area    maram,data,readwrite


SortieSon dcw 0; Initialisation de la variable globale SortieSon
index dcd 0 ; index de table 

	
; ===============================================================================================
	

;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code ici		

CallbackSon proc
	push{r4-r11,lr}
	
	ldr r10, =index ; on charge l'adresse de l'index 
	ldr r1, [r10] ; on récup la valeur 
	
	; Comparaison index et longueur tableau 
	ldr r4, =LongueurSon ; on charge l'adresse de longueur son 
	ldr r4, [r4]; on charge la valeur de longueurSon
	cmp r1, r4; on compare la variable r1 avec LongueurSon 
	beq setzero ; si cmp raise un flag, alors on jump à setzero
	
	ldr r2, =Son ; on charge l'adresse du début du tableau Son   
	ldrsh r3,[r2,r1,LSL#1] ; on charge dans r3 son[index]
	
	; traitement du son  
	mov r5,#32768
	add r3, r5 ; on met un offset / fait l'addition pour avoir un r3 >0
	mov r6, #91
	sdiv r3, r3, r6 ; on divise la nouvelle valeur pour l'avoir entre 0 et 719
	
	ldr r4, =SortieSon ; on charge dans r4 l'adresse de sortieSon  
	strh r3, [r4] ; on charge la valeur de r3 dans r4
	
	; incrémentation de l'index 
	add r1, #1 ; on incrémente l'index 
	ldr r10, =index ; on charge l'adresse de l'index 
	str r1, [r10] ; on store la nouvelle valeur de l'index 
	b Passage1;
	

setzero
	ldr r3,=0;

Passage1 
	mov r0, r3;
	bl PWM_Set_Value_TIM3_Ch3;
	pop{r4-r11,lr}
	bx lr
	endp
	
	END	