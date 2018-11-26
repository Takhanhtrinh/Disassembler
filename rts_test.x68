    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

     
* Put program code here
    MOVEA.W #$02, A1
    MOVEA.L D0, A2 
    MOVEA.W (A1), A3 
    MOVEA.W -(A1), A1 
    MOVEA.L (A1)+, A2  

    add.w 4(a1), d2 

    ADD.L d1, d2 
    add.w d1, a1 
    ;ADD.L 4(a1), d2
    ADD.W (a1)+, d1 
    ADD.W -(a1), d1 
    
    

    add.w (a1), d1 
    adda.w #$435, a1
    ADDA.W -(sp), a2 
    adda.w (a1)+, a2  
    add.b d1, d2 
    LEA PRINT, a1 

VKL: 
    NOP
    RTS



TEMP:
    MOVE.B #$25, D0
    BRA VKL
    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
