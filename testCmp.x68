*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
    CMP.W D1,A0
    CMP.B D0,D1 

    CMP.B (A0), D1 
    CMP.B ($1234), D2
    CMP.B ($12345678),d2
    CMP.W D0, D1 
    CMP.W (A2), d0
    CMP.W (A1), D0 
    CMP.W ($1234), D1
    CMP.W ($1234), D2
    CMP.W ($23131111), D1
    CMP.L a0, d1 
    cmp.l d0,d1
    cmp.l (a1), d2
    cmp.l ($51), d0
    cmp.l ($12345678),d2
    
    
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
