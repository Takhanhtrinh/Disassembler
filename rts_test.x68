
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
   
    eor.w     d0,(a3)
    eor.L     d7,$00004000
    eor.w     d3,d1
    eor.B     d2,(a3)
    eor.w     d0,$00004000
    eor.B     d1,d4

    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
