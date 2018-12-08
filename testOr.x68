*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $010000
START:                  ; first instruction of program
; test or 
    SBCD.B d1,d2
    OR.B d1,d2
    OR.B D2, D1 
    OR.B ($2510), d3
    OR.B ($12312134), d4 
    OR.B (a1), d2 
    or.b (a2)+, d5 
    or.b -(a1), d4
    or.b 4(a1), d4 

    OR.W D1, D1 
    OR.W ($2510), d3
    OR.W ($12312134), d4 
    OR.W (a1), d2 
    or.W (a2)+, d5 
    or.W -(a1), d4
    or.W 4(a1), d4 

    OR.L D1, D1 
    OR.L ($2510), d3
    OR.L ($12312134), d4 
    OR.L (a1), d2 
    or.L (a2)+, d5 
    or.L -(a1), d4
    or.L 4(a1), d4 
    ;test eor
    
    EOR.B D1, D2 
    EOR.B  D1, ($1234)
    EOR.B D5, ($32153245)
    EOR.B D3, (A1)
    EOR.B D4, -(A3)
    EOR.B D5, (A4)+

    EOR.W D1, D2 
    EOR.W  D1, ($1234)
    EOR.W D5, ($32153245)
    EOR.W D3, (A1)
    EOR.W D4, -(A3)
    EOR.W D5, (A4)+

    EOR.L D1, D2 
    EOR.L  D1,($1234)
    EOR.L D5, ($32153245)
    EOR.L D3, (A1)
    EOR.L D4, -(A3)
    EOR.L D5, (A4)+


    
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source



*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
