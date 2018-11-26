
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

    sub.l     $40,d4

    sub.w     d5,(a1)

    sub.w     (a1),d0

    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source








*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
