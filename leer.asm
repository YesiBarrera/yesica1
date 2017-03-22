
    
    list p=16f887
    #include "p16f887.inc"

; CONFIG1
; __config 0xE0F4
  ; __config 0xFCC4
   __CONFIG _CONFIG1, _FOSC_INTRC_NOCLKOUT & _WDTE_OFF & _PWRTE_ON & _MCLRE_ON & _CP_OFF & _CPD_OFF & _BOREN_ON & _IESO_OFF & _FCMEN_OFF & _LVP_OFF & _DEBUG_OFF
    ; CONFIG2
    ; __config 0xFFFF
   __CONFIG _CONFIG2, _BOR4V_BOR40V & _WRT_OFF ;memoria de datos de propositio general

    
;*********************************************************************
    CBLOCK 0X20

	NUMERO
    
    UNIDADES
	DECENAS
    CENTENAS
	
;______________________________________________________________

	INDICE		;Reguistro para	 seleccion del dato de la tabla
;______________________________________________________--
    NUMERO_AUX

    ENDC
    
    org .0

    CALL    OSCILLATOR
    CALL    configuracion
PRINCIPAL:
    CLRF    INDICE


    MOVF      PORTA,W


    MOVWF     NUMERO
    MOVWF     NUMERO_AUX
    MOVLW     .255
    XORWF     NUMERO_AUX,W
    BTFSC     STATUS,Z
    GOTO      X
    CALL      BINARIO_BCD
LOOP
    BTFSC       PORTE,0
    GOTO        PRINCIPAL

    INCF      NUMERO_AUX,F
    MOVLW     .255
    XORWF     NUMERO_AUX,W
    BTFSC     STATUS,Z
    GOTO      $+5
    MOVF      NUMERO_AUX,W
    MOVWF     NUMERO
    CALL      BINARIO_BCD
    GOTO        LOOP
X
    MOVF      NUMERO_AUX,W
    MOVWF     NUMERO
    CALL      BINARIO_BCD



SECUENCIA
    BTFSC       PORTE,0
    GOTO        PRINCIPAL
    
    MOVF        INDICE,W
    PAGESEL     TABLA
    call        TABLA
    PAGESEL     PRINCIPAL
    MOVWF       PORTB
    MOVF        INDICE,W
    PAGESEL     TABLA1
    call        TABLA1
    PAGESEL     PRINCIPAL
    MOVWF       PORTC
    CALL      RETARDO_1SEG

    
    MOVLW       .62
    xorwf       INDICE,w
    BTFSC       STATUS,Z
    GOTO        PRINCIPAL
    INCF        INDICE
    GOTO        SECUENCIA
    



#include "CONVERSION.INC"  
#include "configuracion.inc"
#include "retardos.inc"
#include "led.inc"   
    
    END