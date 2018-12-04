    *-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

     
* Put program code here
HAHA: 
    MOVE.W A1,D2 
    BRA.W HAHA
    BRA.S HAHA
    BRA.W VKL
VKL:
    MOVEM.L A0-A2/D0-D5, -(A1)

    MOVEM.L a0-a7/d0-d7, -(a1)
    movem.l a0-a7/d0-d7, (a7)
    movem.l a0/a5/a3/a1/d0/d3/d6, ($01)



    MOVEM.L A0/A1/A2/D0/D1/D2/D3/D4/D5, ($00000011)

    movem.w ($01234567), a0-a1/d0-d7


    MOVEM.L (A1)+, A0-A2/D0-D7
    ADD.L #$39, D4
    MOVE.B #50, D1 
    MOVE.W #1020, D2 
    MOVE.W #10, D2 
    MOVE.L #1230, D3
    MOVE.W (A1), D4 
    MOVE.B (A2), D1
    MOVE.L (A3), D6
    MOVE.B -(A1), D1 
    MOVE.W -(A2), D5
    MOVE.L -(A7), D6
    MOVE.B (A1)+, D1 
    MOVE.W (A1)+, D2 
    MOVE.W (A3)+ , D5
    MOVE.L (A6)+, D6 
    MOVE.B ($12345), D6
    MOVE.W ($1231), D5 
    MOVE.L  ($232), D7
    MOVE.l (A1,D2), D2 
    MOVEA.W #$02, A1
    MOVEA.L D0, A2 
    MOVEA.W (A1), A3 
    MOVEA.W -(A1), A1 
    MOVEA.L (A1)+, A2  

    add.w 4(a1), d2 

    ADD.L d1, d2 
    add.w d1, a1 
    ;ADD.L 4(a1), d2
    ADD.W (a1)+, d1 
    ADD.W -(a1), d1 
    
    CMP.w    #$0002,d0
    
    CMP.B    d1,d7

    add.w (a1), d1 
    adda.w #$435, a1
    ADDA.W -(sp), a2 
    adda.w (a1)+, a2  
    add.b d1, d2 
    LEA PRINT, a1 


TEMP:
    MOVE.B #$25, D0
    BRA VKL
    SIMHALT             ; halt simulator

* Put variables and constants here
PRINT DC.B 'VKL',0 
    END    START        ; last line of source









*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~





*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
