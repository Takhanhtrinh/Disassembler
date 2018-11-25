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
