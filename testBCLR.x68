*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

* Put program code here
    move.L #$12312312, d0
    move.l #$12121231,d1

    bclr.B #13, (a0)
    BCLR.B #$12312312,(a0)
    bclr.l #$12312312, d1
    bclr.b #$25, ($12345678)
    BCLR.B #$13, ($1234)

    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
