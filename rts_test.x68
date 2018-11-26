
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
 
    
    *or.w      d0,$00004000
    *or.W      #$4000,d7
    *or.w      #$4000,$3000
    *or.l      (a6),d7
          
    ORI.W #$39, D0
    ORI.W #$4000,d7
    *ORI.L #$07FF,$2000
    ORI.B #$DC,(A2)
    

    
    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
