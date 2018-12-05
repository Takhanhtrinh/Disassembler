*-----------------------------------------------------------
* Title      : Final Project Test Program
* Written by : Leo Le
* Date       : 11/23/2018
* Description: This is the test program for the final project
*              of team HEX DUMP. This will be used to test
*              the DISASSEMBLER we are building. Hope it works...
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
            ORG     START           * START PROGRAM
MAIN:       
            LEA     MSG1,           A1      * LOAD MSG1 (LEA)
            MOVE.B  #14,            D0      
            TRAP    #15
            
            LEA     MSG2,           A1      * LOAD MSG2 (LEA)
            MOVE.B  #14,            D0      
            TRAP    #15
            
            MOVE.W  #NUM1,          D2      * MOVE DATA TO D2 (MOVE)
            MOVE.L  #NUM2,          D3      * MOVE DATA TO D3 (MOVE)
            
            MOVEA.W TEST_ADDR,      A2      * MOVE ADDRESS TO A2 (MOVEA)
            MOVE.B  D2,            (A2)+    * MOVE VALUE FROM D2 TO MEMORY AT ADDRESS A2 AND INCREMENT THE OFFSET (MOVE)
            MOVEM.L D2-D3,         (A3)     * MOVE MULTI REGISER TO A3
            
            MOVE.W  #LOOP_TIME,     D5      * SET UP LOOP COUNTER (MOVE)
            JSR     ADD_LOOP                * TEST FUNCTION: INCREMENT FROM 5 TO 10 CALLING (ADD, ADDA)
            MOVE.W  #LOOP_TIME,     D5      * RESET UP LOOP COUNTER (MOVE)
            JSR     SUB_LOOP                * TEST FUNCTION: DECREMENT FROM 5 TO 0 CALLING (SUB, SUBQ)
            
            CMP.W    #$0002, D4
            CMP.B    D2, D3
            CMP.L    $00000010, D4
            CMP.W    (A2), D3

            LSL.W    #$02, D3
            LSL.L    D3, D5
            LSL.W    $9F91

            LSR.W    D3, D2
            LSR.B    #$1, D2

            ASR.W    #$04,D2
            ASR.B    #2, D4
            ASR.L    D2, D3

            ASL.W    #$04, D2
            ASL.W    $2880
            ASL.L    D2, D4

            NEG.B    D2
            NEG.B    (A4)+
            NEG.W    $2900

            ORI.B     #$EC, D3
            ORI.W     #$07FF, $00004000
            ORI.L     #$07FF, (a1)

            OR.W      D3, $00004000
            OR.L      $00004000, d7
            OR.B      D3, (a3)
            OR.W      (a6), d7

            DIVS.W    D4, D7
            DIVS.W    $0010, D7
            DIVS.W    (A5)+, D7
            DIVS.W    #$1900, D3

            MULS.W    D4, D7
            MULS.W    $0010, D7
            MULS.W    (A5)+, D7
            MULS.W    #$1900, D3
            
            EOR.W     #$07FF, -(A5)
            EOR.B     #$E2, D4
            EOR.W     D5, (A3)+
            EOR.L     #$07FF, $00004000
            EOR.W     D3, d1
            EOR.B     D6, $00004000

            JSR     TERMINATE  * PROGRAM END

ADD_LOOP:
            CMP.W  #10,D5      * CHECK COUNTER (CMP)
            BGE.S  END_LOOP    * TEST (BGE)
            ADD.B  #1, D5      * INCREMENT COUNTER (ADD)
            ADD.L  (A3)+, D5
            ADD.W  D5, $1012
            ADD.W  #$02, $2000
            ADD.B  D4, D5
            ADDA.W #$01, A4
            ADDA.W D4, A4
            ADDA.L (A5)+, A4
            BRA SUB_LOOP
            
SUB_LOOP:
            CMPI.W #1, D5      * CHECK COUNTER (CMPI)
            BLT.S  END_LOOP    * TEST (BLT)
            SUB.B  #1, D5      * DECREMENT COUNTER (SUB)
            SUB.W  A5, D4
            SUB.B  (A5)+, D3
            SUB.B  D5, (A5)+
            SUB.W  #$02, $2000
            SUBQ.B #1, D5      * DECREMENT COUNTER (SUBQ)
            SUBQ.B #$8, D3
            SUBQ.B #4, -(A4)
            SUBQ.B #7, (A4)
            BRA SUB_LOOP
 
END_LOOP:
            RTS                * HELP TO END WHATEVER LOOP CALLED IT


* ------------------------PROGRAM END HERE-------------------------- *
TERMINATE:
            LEA     MSG3,           A1      * SHOW TERMINATE MSG
            MOVE.B  #14,            D0
            TRAP    #15
            STOP    #EXIT
            
            END    START







*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
