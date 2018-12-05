*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
START:                  ; first instruction of program

* Put program code here



TEST1:
    MOVE.W #$14, D0 
    MOVEM.W d0-d7/a1-a2, -(sp)
    MOVEM.W (SP)+, d0-d7/a1-a2
    BCS TEST1 
    BCS TEST2
    BCS TEST3
TEST2:
    ADD.L d0,d1 
    ADD.L #$12312,d0 
    ADDA.W #14, a1 
    adda.W #14, a2
    adda.L #12, a5
    BGE.S TEST1 
    BGE.S TEST3
    BGE.W TEST1
    BGE.W TEST3
    BGE.S TEST2
    BLT.S TEST2
    BLT.W TEST3
    BVC.W TEST2
    BVC.W TEST3
    BVC.S TEST3
    BVC.S TEST2



TEST3:
    ADDA.W #14,a0
    
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
