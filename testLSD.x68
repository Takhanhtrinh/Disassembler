*-----------------------------------------------------------
* Title      :
* Written by :
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $10000
START:                  ; first instruction of program

* Put program code here
    LSR 4(A1)
    LSL.B #4, d0 
    LSL.B D1,D0 
    
    ASL.B #1, d5
    ASL.B D1, D5

    ROL.B #8, D4 
    ROL.B D0,D1
  


   
    LSL.W #3, D0 
    LSL.W d1, d0
    ASL.W #8, D5
    ASL.W D1, D0 
    ROL.W #5, D3
    ROL.W D3,D1
    
    LSL.L #7, D7
    LSL.L D5,D1
    ASL.L #8, D4
    ASL.L D3, D2 
    ROL.L #1, D5
    ROL.L d3,d1

    LSR.B #4, d0 
    LSR.B D1,D0 
    ASR.B #1, d5
    ASR.B D1, D5
    ROR.B #1, D3
    ROR.B #8, D4 
    ROR.B D0,D1
    

   
    LSR.W #3, D0 
    LSR.W d1, d0
    ASR.W #8, D5
    ASR.W D1, D0 
    ROR.W #5, D3
    ROR.W D3,D1
    
    LSR.L #7, D7
    LSR.L D5,D1
    ASR.L #8, D4
    ASR.L D3, D2 
    ROR.L #1, D5
    ROR.L d3,d1
    
    

    LSL ($2134)
    LSL ($21345678)
    LSL (a0)
    LSL (A0)+
    LSL -(SP)

    ASL ($2134)
    ASL ($21345678)
    ASL (a4)
    ASL (A0)+
    ASL -(SP)

    ROL ($2134)
    ROL ($21345678)
    ROL (a5)
    ROL (a5)+
    ROL -(a3)


    LSR ($2134)
    LSR ($21345678)
    LSR (a0)
    LSR (A0)+
    LSR -(SP)
    LSR 4(A1)
  

    ASR ($2134)
    ASR ($21345678)
    ASR (a4)
    ASR (A0)+
    ASR -(SP)
    ROR ($2134)
    ROR ($21345678)
    ROR (a5)
    ROR (a5)+
    ROR -(a3)

    

    
     
    SIMHALT             ; halt simulator

* Put variables and constants here

    END    START        ; last line of source


*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
