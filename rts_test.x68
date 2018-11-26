
    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program
    
    ADD.L #$39, d4
    
    or.w      d0,$00004000
    or.l      $00004000,d7
    or.w      d0,(a3)
    or.l      (a6),d7
          
    ORI.W #$39, D0
    ORI.L #$07FF,(A1)
    ORI.B #$DC,(A2)
    

    
    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source






*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
