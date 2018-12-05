*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
    CMPI.B #$09, D1 
    CMPI.B #$09, (a1)
    CMPI.B #$25, -(a1)  
    CMPI.B #$12, (A6)+ 
    CMPI.B #$23, ($1234)
    CMPI.B #$85, ($12345578)
    CMPI.W #$2313, D7 
    CMPI.W #$1244, (A3)
    CMPI.W #$3282, -(A3)
    CMPI.W #$8731, (A5)+
    CMPI.W #$1231, ($1234)
    CMPI.W #$1231, ($12345678)
    CMPI.L #$32147861, D4
    CMPI.L #$FF123131, (A0)
    CMPI.L #$12314111, (A4)+
    CMPI.L #$23123412, -(A5)
    CMPI.L #$11234123, ($1234)
    CMPI.L #$31233521, ($31348761)
* Put program code here

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
