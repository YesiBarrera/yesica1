BINARIO_BCD:
	 
         CLRF      CENTENAS
         CLRF      DECENAS
         CLRF      UNIDADES
         
CEN
         MOVLW     .100               ; LO QUE HAGO ES RESTARLE 100 AL NUMERO Y IR CONTANDO LAS VECES
         SUBWF     NUMERO,W           ; QUE LE RESTO Y EL RESIDUO DEJARLO INTACTO
         BTFSS     STATUS,C
         GOTO      DEC
         MOVWF     NUMERO
         INCF      CENTENAS
         GOTO      CEN

DEC
         MOVLW     .10              ; CON EL RESIDUO DE LA RESTA DE 100 AHORA LE RESTO ES 10 AL NUMERO
         SUBWF     NUMERO,W         ; E IR CONTANDO LAS VECES QUE LO HAGO Y ESTE ES MI VALOR DE LAS DECENAS
         BTFSS     STATUS,C
         GOTO      UNI
         MOVWF     NUMERO
         INCF      DECENAS
         GOTO      DEC

UNI
         MOVF      NUMERO,W         ; Y YA CUANDO TERMINO DE RESTARLE TODO EL RESIDUO FINA SERA EL CORRESPONDIENTE
         MOVWF     UNIDADES         ;A LAS UNIDADES


FIN:     SWAPF     DECENAS,W
         XORWF     UNIDADES,W     ; CON LA XOR LO QUE QUIERO ES QUE LAS DECENAS Y LAS UNIDADES ME QUEDEN EN UN
         MOVWF     PORTB         ; SOLO REGISTRO
         MOVF      CENTENAS,W
         MOVWF     PORTC
         CALL      RETARDO_1SEG

         RETURN