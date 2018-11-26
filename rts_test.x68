
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
    
    muls.w    #$0002,d0
    
    muls.w    d1,d7

    muls.w    $00000010,d4

    muls.w    (a0),d3

    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
