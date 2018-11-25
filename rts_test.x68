<<<<<<< HEAD
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

     
* Put program code here
     
    ADD.L d1, d2 
    add.w d1, a1 
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
=======
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:  

    NEG.B D2
    NEG.W D3
    NEG.B D4
    NEG.W D5
    NEG.B D6
    NEG.W D7
   
   
    NEG.B (A1)
    NEG.B (A2)
    NEG.L (A3)    
    

    SIMHALT  

    END    START    




*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
>>>>>>> 0ce50c0d4394f532a1250bf23f6fce6f2154e651
