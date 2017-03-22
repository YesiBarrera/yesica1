;libreria de retardos
    CBLOCK
	ret_Count1
	ret_Count2
	ret_Count3
    ENDC
    
RETARDO_1SEG:
    MOVLW   .10
    MOVWF   ret_Count1
    
LOOP_K1:    
    MOVLW   .127
    MOVWF   ret_Count2
LOOP_M1:
    MOVLW   .255
    MOVWF   ret_Count3
LOOP_N1:    
    DECFSZ  ret_Count3,f
    GOTO    LOOP_N1
    DECFSZ  ret_Count2,f
    GOTO    LOOP_M1
    DECFSZ  ret_Count1,f
    GOTO    LOOP_K1
    
    return