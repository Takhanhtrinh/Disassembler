*-----------------------------------------------------------
* Title      : Final Project Test Program
* Written by : Leo Le
* Date       : 11/23/2018
* Description: This is the test program for the final project
*              of team HEX DUMP. This will be used to test
*              the DISASSEMBLER we are building. This version
*              of testing is not SHUFFLED yet. We will have
*              another test program with SHUFFLED OP codes
*              to further evaluate the disassembler.
*-----------------------------------------------------------

* EQUATES SECTION
            OPT     CRE
START       EQU     $10000          * PROGRAM BEGINS
EXIT        EQU     $2000           * PROGRAM STOP
NUM1        EQU     $A31B           * TEST NUMBER 1
NUM2        EQU     $1402           * TEST NUMBER 2
LOOP_TIME   EQU     $20
TEST_ADDR   EQU     $3000           * TEST ADDRESS
DECREMENT   EQU     $1              * DECREMENT BY 1

CR          EQU     $0D             * ASCII CODE FOR CARRIAGE RETURN
LF          EQU     $0A             * ASCII CODE FOR LINE FEED

* DATA SECTION
MSG1        DC.B    'HELLO CRUEL WORLD!', CR, LF, 0
MSG2        DC.B    'THIS IS THE TEST PROGRAM FOR THE DISASSEMBLY WE ARE BUILDING', CR, LF
            DC.B    'WE ARE GROUP HEX DUMP', 0
MSG3        DC.B    'PROGRAM TERMINATED!', CR, LF, 0   
    

* ------------------------PROGRAM START HERE------------------------ *
            ORG      START           * START PROGRAM
MAIN:       
            LEA      MSG1, A1        * LOAD MSG1 (LEA)
            MOVE.B   #14, D0      
            TRAP     #15
            
            LEA      MSG2, A1        * LOAD MSG2 (LEA)
            MOVE.B   #14, D0      
            TRAP     #15
            
            MOVE.W   #NUM1, D2       
            MOVE.L   #NUM2, D3       
            MOVE.B   D2, (A2)+       
            MOVE.W   #$14, D1 
            MOVE.L   #$12312312, D5
            MOVE.L   #$91827392, D1
            
            MOVEA.W  TEST_ADDR, A2   
            MOVEA.W  D3, A2          
            MOVEA.L  #$9000, A2      

            MOVEM.W  D0-D7/A1-A2, -(sp)
            MOVEM.W  (SP)+, D0-D7/A1-A2
            MOVEM.L  D2-D3, (A3)     
            MOVEM.W  (A3)+, D2-D3    
            MOVEM.L  $0030, D2-D3    
            
            NOP *------------------------------------

            CMP.W    #$0002, D4
            CMP.B    D2, D3
            CMP.L    $00000010, D4
            CMP.W    (A2), D3
            CMP.W    D1,A0
            CMP.B    D0,D1 
            CMP.B    (A0), D1 
            CMP.B    ($1234), D2
            CMP.B    ($12345678),d2
            CMP.W    D0, D1 
            CMP.W    (A2), D0
            CMP.W    (A1), D0 
            CMP.W    ($1234), D1
            CMP.W    ($1234), D2
            CMP.W    ($23131111), D1
            CMP.L    A7, D1 
            CMP.L    D3, D1
            CMP.L    (A1), D2
            CMP.L    ($51), D1
            CMP.L    ($12345678),D2

            NOP *------------------------------------

            CMPI.W    #$0002, D4
            CMPI.B    #$8, D3
            CMPI.L    #$2010, D4
            CMPI.W    #$00000010, D3
            CMPI.B    #$09, D1 
            CMPI.B    #$09, (a1)
            CMPI.B    #$25, -(a1)  
            CMPI.B    #$12, (A6)+ 
            CMPI.B    #$23, ($1234)
            CMPI.B    #$85, ($12345578)
            CMPI.W    #$2313, D7 
            CMPI.W    #$1244, (A3)
            CMPI.W    #$3282, -(A3)
            CMPI.W    #$8731, (A5)+
            CMPI.W    #$1231, ($1234)
            CMPI.W    #$1231, ($12345678)
            CMPI.L    #$32147861, D4
            CMPI.L    #$FF123131, (A0)
            CMPI.L    #$12314111, (A4)+
            CMPI.L    #$23123412, -(A5)
            CMPI.L    #$11234123, ($1234)
            CMPI.L    #$31233521, ($31348761)

            NOP *------------------------------------

            LSL.W    #$02, D3
            LSL.B    D3, D5
            LSL.W    $9F91
            LSL.W    (A1)
            LSR      4(A1)
            LSL.B    #4, D0 
            LSL.B    D1, D0 
            LSL      ($2134)
            LSL      ($21345678)
            LSL      (A0)
            LSL      (A0)+
            LSL      -(SP)

            NOP *------------------------------------

            LSR.W    D3, D2
            LSR.B    #$1, D2
            LSR.W    (A4)
            LSR.W    ($1900)
            LSR      ($2134)
            LSR      ($21345678)
            LSR      (a0)
            LSR      (A0)+
            LSR      -(SP)
            LSR      4(A1)


            NOP *------------------------------------

            ASR.W    #$04,D2
            ASR.B    #2, D4
            ASR.W    $8000
            ASR.W    (A3)
            ASR.L    D2, D3
            ASR      ($2134)
            ASR      ($21345678)
            ASR      (a4)
            ASR      (A0)+
            ASR      -(SP)

            NOP *------------------------------------

            ASL.W    #$04, D2
            ASL.W    $8000
            ASL.W    (A4)
            ASL.W    $3000
            ASL.L    D2, D4
            ASL      ($2134)
            ASL      ($21345678)
            ASL      (A4)
            ASL      (A0)+
            ASL      -(SP)

            NOP *------------------------------------

            ROR.W    #$04,D2
            ROR.B    #2, D4
            ROR.W    $9000
            ROR.L    D2, D3
            ROR.W    (A5)
            ROR      ($2134)
            ROR      ($21345678)
            ROR      (a5)
            ROR      (a5)+
            ROR      -(a3)

            NOP *------------------------------------

            ROL.W    #$04, D2
            ROL.B    #$8, D4
            ROL.W    $1000
            ROL.L    D2, D4
            ROL.W    (A4)
            ROL.W    ($8000)
            ROL      ($2134)
            ROL      ($21345678)
            ROL      (a5)
            ROL      (a5)+
            ROL      -(a3)
            
            NOP *------------------------------------

            NEG.B    D2
            NEG.B    (A4)+
            NEG.B    $2900
            NEG.W    D2
            NEG.W    (A4)+
            NEG.L    D2
            NEG.L    (A4)+
            NEG.L    $2900
            NEG.B    ($9000)
            NEG.B    (A4)+
            NEG.B    $2900
            NEG.W    D2
            NEG.W    (A4)+
            NEG.W    $2900
            NEG.L    D2
            NEG.L    (A4)+
            NEG.L    -(A3)

            NOP *------------------------------------

            ORI.B     #$EC, D3
            ORI.W     #$07FF, $00004000
            ORI.L     #$07FF, (a1)
            ORI.B     #$15, (A0)
            ORI.B     #$31, D2 
            ORI.B     #$50, ($1234)
            ORI.B     #$12, ($12312222)
            ORI.W     #$1221, (A0)
            ORI.W     #$1231, D2 
            ORI.W     #$1231, ($1231)
            ORI.W     #$1231, ($12311111)
            ORI.L     #$12313333, (A0)
            ORI.L     #$12312111, D2 
            ORI.L     #$12312411, ($1312)
            ORI.L     #$12314111, ($12311111)

            NOP *------------------------------------

            OR.B      D3, (A3)
            OR.B      -(A3), D4
            OR.B      (A3)+, D5
            OR.W      D3, $00004000
            OR.L      $00004000, D7
            OR.L      ($9000), D4
            OR.B      D1,D2
            OR.B      D2, D1 
            OR.B      ($2510), D3
            OR.B      ($12312134), D4 
            OR.B      (A1), D2 
            OR.B      (A2)+, D5 
            OR.B      -(A1), D4
            OR.B      4(A1), D4 
            OR.W      D1, D1 
            OR.W      ($2510), D3
            OR.W      ($12312134), D4 
            OR.W      (A1), D2 
            OR.W      (A2)+, D5 
            OR.W      -(A1), D4
            OR.W      4(A1), D4 
            OR.L      D1, D1 
            OR.L      ($2510), D3
            OR.L      ($12312134), D4 
            OR.L      (A1), D2 
            OR.L      (A2)+, D5 
            OR.L      -(A1), D4
            OR.L      4(A1), D4 

            NOP *------------------------------------

            DIVS.W    D4, D7
            DIVS.W    $0010, D7
            DIVS.W    (A5)+, D7
            DIVS.W    -(A5), D7
            DIVS.W    #$1900, D3

            NOP *------------------------------------

            MULS.W    D4, D7
            MULS.W    (A5)+, D7
            MULS.W    -(A5), D7
            MULS.W    #$1900, D3
            MULS.W    $0010, D7
            
            NOP *------------------------------------

            EOR.W     #$07FF, -(A5)
            EOR.B     #$E2, D4
            EOR.W     D5, (A3)+
            EOR.L     #$07FF, $00004000
            EOR.W     D3, d1
            EOR.B     D6, $00004000
            EOR.B     D1, D2 
            EOR.B     D1, ($1234)
            EOR.B     D5, ($32153245)
            EOR.B     D3, (A1)
            EOR.B     D4, -(A3)
            EOR.B     D5, (A4)+
            EOR.W     D1, D2 
            EOR.W     D1, ($1234)
            EOR.W     D5, ($32153245)
            EOR.W     D3, (A1)
            EOR.W     D4, -(A3)
            EOR.W     D5, (A4)+
            EOR.L     D1, D2 
            EOR.L     D1,($1234)
            EOR.L     D5, ($32153245)
            EOR.L     D3, (A1)
            EOR.L     D4, -(A3)
            EOR.L     D5, (A4)+

            NOP *------------------------------------

            BCLR.B    D4, (A5)+
            BCLR.B    D4, -(A5)
            BCLR.B    D4, $5000
            BCLR.L    D4, D3
            BCLR.L    #$9000 , D4
            BCLR.B    #$9 , -(A5)
            BCLR.L    #$3000 , D4
            BCLR.L    #$5 , D6
            BCLR.L    #$1500 , D5
            BCLR.B    #13, (A0)
            BCLR.B    #$12312312,(A0)
            BCLR.L    #$12312312, D1
            BCLR.B    #$25, ($12345678)
            BCLR.B    #$13, ($1234)

            NOP *------------------------------------
            
            CMPI.W    #$20, D5
            BCS.S     LOWER
            BCS.W     LOWER
            BCS.B     LOWER
            BCS       LOWER
            BVC.W     LOWER
            BVC.B     LOWER
            BVC.S     LOWER
            BVC       LOWER

            NOP *------------------------------------
            
            BLT.S     LOWER
            BLT.W     LOWER
            BLT.B     LOWER
            BLT       LOWER

            NOP *------------------------------------

            BGE.B     LOWER
            BGE.W     LOWER
            BGE.S     LOWER
            BGE       LOWER

            NOP *------------------------------------

            BRA.B     LOWER
            BRA.W     LOWER

LOWER:
            MOVE.W    #LOOP_TIME, D5      
            JSR       ADD_LOOP                
            MOVE.B    #LOOP_TIME, D5   
            JSR       SUB_LOOP                
            
            JSR       TERMINATE  * PROGRAM END

ADD_LOOP:
            CMP.W     #$30, D5      * CHECK COUNTER (CMP)
            BGE.S     END_LOOP    * TEST (BGE)
            ADD.B     #1, D5      * INCREMENT COUNTER (ADD)
            ADD.L     (A3)+, D5
            ADD.L     D0, D1 
            ADD.L     #$12312, D7 
            ADD.W     D5, $1012
            ADD.W     #$02, $2000
            ADD.B     D4, D5

            ADDA.W    #$01, A4
            ADDA.W    D4, A4
            ADDA.L    (A5)+, A4
            ADDA.W    #14, A1 
            ADDA.W    #14, A2
            ADDA.L    #12, A5
            ADDA.W    D1,A2
            ADDA.W    A4,A5
            ADDA.W    (A4), A6
            ADDA.W    -(A3), A4
            ADDA.W    (A2)+, A5
            ADDA.W    ($1234), A4
            ADDA.W    ($22227812), A6
            ADDA.L    D1,A2 
            ADDA.L    A4,A5
            ADDA.L    (A3), A5
            ADDA.L    -(A3), A2
            ADDA.L    (A5)+, A4 
            ADDA.L    ($1211), A6
            ADDA.L    ($12314124), A7
            BRA       ADD_LOOP
            
SUB_LOOP:
            CMPI.W    #$18, D5      * CHECK COUNTER (CMPI)
            BLT.S     END_LOOP    * TEST (BLT)
            SUB.B     #1, D5      * DECREMENT COUNTER (SUB)
            SUB.W     A5, D4
            SUB.B     (A5)+, D3
            SUB.B     D4, (A5)
            SUB.W     #$02, $2000
            SUBQ.B    #$8, D3
            SUBQ.B    #4, -(A4)
            SUBQ.B    #7, (A4)
            SUBQ.B    #$1, D0 
            SUBQ.W    #$2, D6
            SUBQ.L    #$3, D5
            SUBQ.B    #$4, 4(A0)
            SUBQ.W    #$5, (A7)
            SUBQ.L    #$6, (A6)
            SUBQ.B    #$7, ($2120)
            SUBQ.W    #$8, ($2530)
            SUBQ.L    #$1, ($2599)
            SUBQ.B    #$2, ($21592917)
            SUBQ.W    #$5, ($22114455)
            SUBQ.L    #$2, ($32716489)
            BRA       SUB_LOOP
 
END_LOOP:
            RTS                * HELP TO END WHATEVER LOOP CALLED IT


* ------------------------PROGRAM END HERE-------------------------- *
TERMINATE:
            LEA        MSG3,           A1      * SHOW TERMINATE MSG
            MOVE.B     #14,            D0
            TRAP       #15
            STOP       #EXIT
            
            END    START

*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
