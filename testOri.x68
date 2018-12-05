*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

* Put program code here
    ORI.B #$15, (A0)
    ORI.B #$31, D2 
    ORI.B #$50, ($1234)
    ORI.B #$12, ($12312222)
    
    ORI.W #$1221, (A0)
    ORI.W #$1231, D2 
    ORI.W #$1231, ($1231)
    ORI.W #$1231, ($12311111)
    
    ORI.L #$12313333, (A0)
    ORI.L #$12312111, D2 
    ORI.L #$12312411, ($1312)
    ORI.L #$12314111, ($12311111)
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
