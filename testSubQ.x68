*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

* Put program code here
    SUBQ.B #$1, D0 
    SUBQ.W #$2, d6
    subq.l #$3,d5
    subq.b #$4, 4(a0)
    subq.w #$5, (a7)
    subq.l #$6, (a6)
    subq.b #$7, ($2120)
    subq.w #$8, ($2530)
    subq.l #$1, ($2599)
    subq.b #$2, ($21592917)
    subq.w #$5, ($22114455)
    subq.l #$2, ($32716489)
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
