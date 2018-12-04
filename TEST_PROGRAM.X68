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
LOOP_TIME   EQU     $5
TEST_ADDR   EQU     $3000           * TEST ADDRESS
DECREMENT   EQU     $1              * DECREMENT BY 1

CR          EQU     $0D             * ASCII CODE FOR CARRIAGE RETURN
LF          EQU     $0A             * ASCII CODE FOR LINE FEED

* DATA SECTION
MSG1        DC.B    'HELLO WORLD!', CR, LF, 0
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
            MOVEM.L D2-D3,         (A3)      * MOVE MULTI REGISER TO A3
            
            MOVE.W  #LOOP_TIME,     D5      * SET UP LOOP COUNTER (MOVE)
            JSR     ADD_LOOP                * TEST FUNCTION: INCREMENT FROM 5 TO 10 CALLING (ADD, ADDA)
            MOVE.W  #LOOP_TIME,     D5      * RESET UP LOOP COUNTER (MOVE)
            JSR     SUB_LOOP                * TEST FUNCTION: DECREMENT FROM 5 TO 0 CALLING (SUB, SUBQ)
            
            CMP.W    #$0002, D4
            CMP.B    D2, D3
            CMP.L    $00000010, D4
            CMP.W    (A2), D3
            
            
            JSR     TERMINATE               * PROGRAM END
ADD_LOOP:
            CMP.W  #10,             D5      * CHECK COUNTER (CMP)
            BGE.S  END_LOOP                 * TEST (BGE)
            ADD.B  #1,              D5      * INCREMENT COUNTER (ADD)
            ADDA.W #1,              A4      * INCREMENT COUNTER TO A4 (ADDA)
            BRA SUB_LOOP
            
SUB_LOOP:
            CMPI.W #1,              D5      * CHECK COUNTER (CMPI)
            BLT.S  END_LOOP                 * TEST (BLT)
            SUB.B  #1,              D5      * DECREMENT COUNTER (SUB)
            SUBQ.B #1,              D5      * DECREMENT COUNTER (SUBQ)
            BRA SUB_LOOP
 
END_LOOP:
            RTS                             * HELP TO END WHATEVER LOOP CALLED IT


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
