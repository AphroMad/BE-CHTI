	PRESERVE8
	THUMB
		
	include Driver/DriverJeuLaser.inc		

; ====================== zone de réservation de données,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite
		
FlagCligno dcd 0 ; Initialisation de la variable FlagCligno à 0

	export FlagCligno

; ===============================================================================================
	EXPORT callback ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.
	

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
; écrire le code 



callback proc
	push {r4-r11,lr}; valeur pile trucmuche 
	mov r0, #1; 
	ldr r1, =FlagCligno; Load de l'adresse de flagCligno dans r1 
	ldr r2, [r1];  Load la valeur de r1 dans r2 
	cmp r2, #0; on compare la variable FlagCligno avec 0 
	bne Passage1 ; si cmp raise un flag, alors on jump à Passage1
	bl GPIOB_Set ; 
	mov r2, #1; ; si le flag n'est pas raise, on attribue à r1 la valeur 1 

	b fin; on jump a fin pour éviter Passage1
	
Passage1
	bl GPIOB_Clear; On éteint la led 
	mov r2, #0; Le flag est raise donc on attribue a r1 la valeur 0 

fin 	
	ldr r1, =FlagCligno; Load de l'adresse de flagCligno dans r1 
	str r2, [r1]; on store la nouvelle valeur de r1 dans r2 
	pop {r4-r11,lr}
	bx lr
	endp
		
	END	