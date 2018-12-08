*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

* Put program code here
    MOVE.L #$12312312, D0
    MOVE.L #$12121231,D1

    BCLR.B #13, (A0)
    BCLR.B #$12312312,(A0)
    BCLR.L #$12312312, D1
    BCLR.B #$25, ($12345678)
    BCLR.B #$13, ($1234)

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
