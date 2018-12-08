*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
   ORG    $010000
    START:                  ; first instruction of program

* Put program code here
    ADDA.W d1,a2
    ADDA.W A4,A5
    ADDA.W (A4), A6
    ADDA.W -(A3), A4
    ADDA.W (A2)+, A5
    ADDA.W ($1234), A4
    ADDA.W ($22227812), A6
    
    ADDA.L D1,A2 
    ADDA.L A4,A5
    ADDA.L (A3), A5
    ADDA.L -(A3), A2
    ADDA.L (A5)+, A4 
    ADDA.L ($1211), A6
    ADDA.L ($12314124), A7
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
