	PRESERVE8
	THUMB   
		

; ====================== zone de r�servation de donn�es,  ======================================
;Section RAM (read only) :
	area    mesdata,data,readonly


;Section RAM (read write):
	area    maram,data,readwrite

	export VarTime  ; 
		
; Vartime = label (pour nommer une adresse) 
VarTime	dcd 0 ; R�serve la m�moire et d�fini le contenu initial de la variable VarTime � 0 

	
; ===============================================================================================
	
;constantes (�quivalent du #define en C)
TimeValue	equ 900000


	EXPORT Delay_100ms ; la fonction Delay_100ms est rendue publique donc utilisable par d'autres modules.

		
;Section ROM code (read only) :		
	area    moncode,code,readonly
		


; REMARQUE IMPORTANTE 
; Cette mani�re de cr�er une temporisation n'est clairement pas la bonne mani�re de proc�der :
; - elle est peu pr�cise
; - la fonction prend tout le temps CPU pour... ne rien faire...
;
; Pour autant, la fonction montre :
; - les boucles en ASM
; - l'acc�s �cr/lec de variable en RAM
; - le m�canisme d'appel / retour sous programme
;
; et donc poss�de un int�r�t pour d�buter en ASM pur

Delay_100ms proc
		; lecture en m�moire de Vartime / de l'addresse de la variable et mise de valeur dans r0 
	    ldr r0,=VarTime ; Vartime (une adresse) => r0
						 
		; lecture de TimeValue et mise de valeur dans r1 
		ldr r1,=TimeValue ; TimeValue (constante = 900000)  => r1 
		
		; on met r1 dans la variable point� par Vartime / r0
		str r1,[r0] ; r1 => Vartime.value
		
BoucleTempo	; fonction dans une fonction 
		
		ldr r1,[r0]  ; Vartime.value => r1 
		
		; on soustrait r1 de 1 et si r1 = 0, ca active le flag 		
		subs r1,#1 ; r1 = r1 - 1 ET if r1 == 0 : flag Clear Zero = True 
		
		; on met r1 dans la variable point� par Vartime / r0
		str  r1,[r0] ; r1 => Vartime.value
		
		; si le flag est pas activ�, alors on jump sur BoucleTempo
		bne	 BoucleTempo ; if flag Clear Zero == True : Go To BoucleTempo 
		
		; retour fonction, bx = branche , lr = adresse retour fonction 
		bx lr ; indirect jump to lr ~= fin fonction Delay ~= retour 
		
		endp ; procedure pour le debuggeur 
		
		
	END	