*-----------------------------------------------------------
* Title      : 
* Written by : 
* Date       :
* Description:
*-----------------------------------------------------------
    ORG    $1000
* OUTPUT_ADDRESS STORES BUFFER FOR PRINTING
OUTPUT_ADDRESS EQU $7010
* RETURN_ADDRESS USES FOR PRINTING AND RETURN VALUE FROM BRANCHES
RETURN_ADDRESS EQU $9000
* LOCATION TO STORE START_ADDRESS
START_ADDRESS EQU $010000
* LOCATION TO STORE END_ADDRESS
END_ADDRESS EQU $7004
* LOCATION TO STORE CURRENT 16 BITS OPCODE
OPCODE_ADDRESS EQU $7006
* LOCATION TO STORE CURRENT OFFSET FROM OPCODE OF A INSTRUCTION, FOR EXAMPLE:
*       MOVE.L #$500, D3 and the instruction(MOVE.L known data register as d3 and immediate data) location at 10000.
*       THIS OFFSET WILL HANDLE BY PRINT_REGISTER. IT WILL PRINT OUT #$500 AND ADD THE NEXT OFFSET FROM THE ORIGINAL OPCODE IN THIS LOCATION, 
*       THE OFFSET SHOULD SET = 2 WHEN FETCH_OPCODE 
OFFSET_OPC_ADDRES EQU $7008 
* LOCATION TO STORE REGISTERS FOR MOVEM
STORE_REGISTER_ADDRESS EQU $700A
* LOCATiON TO STORE STACK ADDRESS VALUE
STACK_ADDRESS EQU $8000
START:                  ; first instruction of program
    * MOVE.L #$10AF241B, -(SP)
    * MOVE.L #HEX_TO_ASCII_LONG, -(SP)
    * JSR PRINT_HEX
    * ADDQ.L #$08, SP

    * JSR PRINT_NEW_LINE

    * JSR PRINT_TAB
    * A0
*     MOVE.L #%0000011100000100, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
*     * A1
*     MOVE.W #%0100, D1
*     SWAP D1
*     MOVE.W #$1, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A2
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$2, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A3
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$3, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A4
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$4, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A5
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$5, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A6
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$6, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP
* * A7
*     MOVE.W #%0011, D1
*     SWAP D1
*     MOVE.W #$7, D1
*     MOVE.L D1, -(SP)
*     JSR PRINT_REGISTER
*     ADDQ.L #4, SP

    * JSR PRINT_COMMA
    * JSR PRINT_DOLLAR_SIGN
    * JSR PRINT_HASH_SIGN
    * MOVE.B #$01, -(SP)
    * JSR PRINT_DATA
    * ADDQ.L #$2,SP
    * MOVE.B #$02, -(SP)
    * JSR PRINT_DATA
    * ADDQ.L #$2, SP
    * MOVE.B #$03, -(SP)
    * JSR PRINT_DATA
    * ADDQ.L #$2,SP
    MOVE.L #START_ADDRESS, -(SP)
    MOVE.L #OPCODE_ADDRESS, -(SP)
    JSR FETCH_OPCODES
    ADDQ.L #8, SP

    MOVE.L #OPCODE_ADDRESS, A0
    MOVE.W (A0), -(SP)
    JSR JUMP_TABLE
    ADDQ.L #$2, SP
     
* Put program code here
MAIN:

END_MAIN:
    MOVE.B #9, D0
    TRAP #15
    MOVE.B #14,D0
    TRAP #15
* get user input 
GET_INPUT:
    LEA PROMT_INPUT_START, A1
    MOVE.B #13, D0
    TRAP #15
    MOVEA.L #$2000,A1
    MOVE.B #2, D0
    TRAP #15
END_GET_INPUT:
    RTS   

*--------------------------------------------------------------------
* PRINT_TAB 
PRINT_TAB: 
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.L #'    ', (A1)+
    MOVE.B #0, (A1)+
    MOVE.L #OUTPUT_ADDRESS, A1
END_PRINT_TAB:
    MOVE.B #14, D0
    TRAP #15
    RTS
*--------------------------------------------------------------------
* PRINT_COMMA
PRINT_COMMA:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #', ', (A1)+
    MOVE.B #0, (A1)
    SUBQ.L #2, A1
END_PRINT_COMMA:
    MOVE.B #14, D0
    TRAP #15
    RTS
*--------------------------------------------------------------------
* PRINT_DOLLAR_SIGN
PRINT_DOLLAR_SIGN:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #'$', (A1)
    MOVE.B #0, 1(A1) 
END_PRINT_DOLLAR_SIGN:
    MOVE.B #14, D0
    TRAP #15
    RTS
*--------------------------------------------------------------------
* PRINT_HASH_SIGN
PRINT_HASH_SIGN:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #'#', (A1)
    MOVE.B #0, 1(A1) 
END_PRINT_HASH_SIGN:
    MOVE.B #14, D0
    TRAP #15
    RTS

*--------------------------------------------------------------------
* PRINT A NEW LINE 
PRINT_NEW_LINE: 
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #CR, (A1)+ 
    MOVE.B #LF, (A1)+
    MOVE.B #0, (A1)+
END_PRINT_NEW_LINE:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #14, D0
    TRAP #15 
    RTS
*--------------------------------------------------------------------
* PRINT DATA TYPE FOR EXAMPLE: .B .W .L
* PARAMETERS: 
 *   1- (4(sp)): WHAT DATA TYPE (1 BYTE)
*       01 - byte
*       11 - word
*       10 - long
* NOTE:
*   A1 USE FOR PRINT
*   d1 USES TO STORE DATA TYPE OF PARAMETER ABOVE
PRINT_DATA:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B 4(SP), D1
    CMPI #$01, D1
    BEQ PRINT_BYTE
    CMPI #$02, D1
    BEQ PRINT_WORD
    CMPI #$03, D1 
    BEQ PRINT_LONG
END_PRINT_DATA:
    MOVE.B #14, D0
    TRAP #15
    RTS 

PRINT_BYTE: 
    MOVE.W #'.B', (A1)
    MOVE.B #0, 2(A1)
    BRA END_PRINT_DATA
PRINT_WORD: 
    MOVE.W #'.W', (A1)
    MOVE.B #0, 2(A1)
    BRA END_PRINT_DATA
PRINT_LONG: 
    MOVE.W #'.L', (A1)
    MOVE.B #0, 2(A1)
    BRA END_PRINT_DATA


*--------------------------------------------------------------------
* PRINT_REGISTER
* PARAMETERS: what register 1 byte 4 msb indicate dn(0) or an(1), 4 lsb for number of that register
* 1 - (6(sp)) 3 bits msb for mode, 3 bits lsb for which register
* 2 - (4(sp)) byte value for how many byte for immediate value
*      0 for it is not ab value or immediate value
*      1 for a byte value
*      2 for word value
*      3 for long value 
* NOTE: 
*   D1 FOR STORE THE PARAMETER
*   D2 FOR STORE HOW MANY BYTE FOR IMMEDIATE VALUE, AND ABSOLUTE VALUE
PRINT_REGISTER:
   MOVE.W 6(SP), D1 
   ; IMMEDIATE ADDRESS
   MOVE.W D1,D2
   CMPI.B #%00111100, D1
   BEQ PRINT_IMMEDIATE
   CMPI.B #%00111000, D1
   BEQ PRINT_AB_SHORT
   CMPI.B #%00111001, D1
   BEQ PRINT_AB_LONG 

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00100000, D2
   BEQ PRINT_OPEN

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00110000, D2
   BEQ PRINT_OPEN

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%01000000, D2
   BEQ PRINT_MINUS_OPEN


CONTINUE_PRINT_REGISTER:
   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00000000, D2
   BEQ PRINT_D

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00010000, D2
   BEQ PRINT_A 

CONTINUE_PRINT_RE_NUMBER:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B D1,D2
    AND.B #%00000111, D2
    ADD.B #48, D2 
    MOVE.B D2, (A1) 
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
DONE_PRINT_NUMBER:
   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00100000, D2
   BEQ PRINT_CLOSE

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%00110000, D2
   BEQ PRINT_CLOSE_PLUS

   MOVE.B D1,D2
   AND.B #%01110000, D2
   CMPI #%01000000, D2
   BEQ PRINT_CLOSE

END_PRINT_REGISTER:
    RTS

PRINT_IMMEDIATE:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #'#', (A1)
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
    JSR PRINT_DOLLAR_SIGN
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.W 4(SP), D2 ; HOW MANY BYTE
    CMPI #$01, D2
    BEQ PRINT_IMMEDIATE_BYTE ; THIS CASE NEVER HAPPEN BECAUSE IMMEDATE VALUE MINIMUM IS 16 bits
    CMPI #$02, D2
    BEQ PRINT_IMMEDIATE_WORD
    CMPI #$04, D2
    BEQ PRINT_IMMEDIATE_LONG
    BRA END_PRINT_REGISTER

PRINT_IMMEDIATE_BYTE:
    MOVE.L #START_ADDRESS, A2
    MOVE.B (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_BYTE, -(SP) 
    JSR PRINT_HEX
     ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A1
    ADDQ.W #$1, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES)
    BRA END_PRINT_REGISTER
PRINT_IMMEDIATE_WORD:
    MOVE.L #START_ADDRESS, A2
    MOVE.W (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_WORD, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A2
    ADDQ.W #$2, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES)
    BRA END_PRINT_REGISTER
PRINT_IMMEDIATE_LONG:
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.L #START_ADDRESS, A2
    MOVE.L (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    ; offset to get immediate value from opcode
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.L #HEX_TO_ASCII_LONG, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A1
    ADDQ.W #$4, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES)
    BRA END_PRINT_REGISTER
PRINT_AB_SHORT:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #'($', (A1)
    MOVE.B #0, 2(A1)
    MOVE.B #14, D0
    TRAP #15
    ; offset to get immediate value from opcode
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.W (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_WORD, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A2
    ADDQ.W #$2, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES)
    ; print close parathesis with W
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #').', (A1)
    MOVE.B #'W',2(A1)
    MOVE.B #0, 3(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA END_PRINT_REGISTER
PRINT_AB_LONG:
    ;print open parathesis
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #'($', (A1)
    MOVE.B #0, 2(A1)
    MOVE.B #14, D0
    TRAP #15
    ; print value in long
    MOVE.L #START_ADDRESS, A2
    ; offset to get value from opcode
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.L (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_LONG, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A1
    ADDQ.W #$4, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES) ; align offset 
    ; print close parathesis with W
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #').', (A1)
    MOVE.B #'L',2(A1)
    MOVE.B #0, 3(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA END_PRINT_REGISTER

PRINT_OPEN:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #'(', (A1)
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA PRINT_A
PRINT_MINUS_OPEN: 
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #'-(', (A1)
    MOVE.B #$0, 2(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA PRINT_A

PRINT_CLOSE:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #')', (A1)
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA END_PRINT_REGISTER
PRINT_CLOSE_PLUS:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.W #')+', (A1)
    MOVE.B #$0, 2(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA END_PRINT_REGISTER
PRINT_D:
    MOVE.L #OUTPUT_ADDRESS, A1 
    MOVE.B #'D', (A1)
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA CONTINUE_PRINT_RE_NUMBER
PRINT_A: 
    MOVE.L #OUTPUT_ADDRESS, A1 
    MOVE.B #'A', (A1)
    MOVE.B #$0, 1(A1)
    MOVE.B #14, D0
    TRAP #15
    BRA CONTINUE_PRINT_RE_NUMBER

*-----------------------------------------------------------
* PRINT HEX 
* PARAMETERS:
*   1- (8(SP)): VALUE IN HEX
*   2- (4(SP)): HOW MANY BYTES
* RETURN NULL
*-----------------------------------------------------------
PRINT_HEX:
    BRA HEX_TO_ASCII
GET_ASCII_FROM_HEX:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B #14, D0
    TRAP #15
    MOVE.L #OUTPUT_ADDRESS, A1
END_PRINT_HEX:
    RTS
*-----------------------------------------------------------
* CONVERT HEX TO ASCII 
* PARAMATERS:
*   1- (8(SP)): VALUE IN HEX
*   2- (4(SP)): HOW MANY BYTES
* RETURN:
*   8 CHARS IN ASCII, STORE IN RETURN ADDRESS (a1)
* D0 STORES HEX VALUE
* D4 HOW MAY BYTES TO DISPLAY (2-byte 4-hex 8-long)
* D1 COUNT LOOP
* D2 CONVERT TO ASCII
* D3 USE TO CALCULATE SHIFT
HEX_TO_ASCII: 
    MOVE.L 8(SP), D0 
    MOVE.L 4(SP), D4
    CLR.B D1
    MOVE.L #OUTPUT_ADDRESS, A1
HEX_MASKING EQU $0000000F
HEX_TO_ASCII_BYTE EQU $02
HEX_TO_ASCII_WORD EQU $04
HEX_TO_ASCII_LONG EQU $08
HEX_TO_ASCII_LOOP:
    CMP.B D4, D1
    BEQ END_HEX_TO_ASCII ; branch if d1 > d4

    ROL.L #4, D0 ; shift left 4 bits to get a hex value
    MOVE.L D0,D3 ; copy the value to mask
    AND.L #HEX_MASKING, D3  ; mask

    CMPI.B #10, D3 ; compare masked value with 10 if less than than convert to ascii number
    BLT HEX_TO_ASCII_NUMBER ; let convert to number ascii

    CMPI.B #72, D3 ; compare masked value with F letter in ascii
    BLT HEX_TO_ASCII_LETTER

    BRA HEX_TO_ASCII_LOOP
HEX_TO_ASCII_NUMBER:
    ADD.B #48, D3  ; convert number to letter
    MOVE.B D3, (A1)+ ; push to return memory
    ADDQ.B #$1, D1 ; add for loop count
    BRA HEX_TO_ASCII_LOOP ; loop back
HEX_TO_ASCII_LETTER:
    ADD.B #55, D3 ; convert A-F in ascii
    MOVE.B D3, (A1)+ ; push to return memory
    ADDQ.B #$1, D1 ; add to for loop count
    BRA HEX_TO_ASCII_LOOP ;loop back
END_HEX_TO_ASCII:
    MOVE.B #0, (A1)+ ; add null terminated value
    BRA GET_ASCII_FROM_HEX


*-----------------------------------------------------------
* CHECK IF THE VALUE IN HEX IS ODD 
* PARAMETER;* 1(4(SP))- HEX VALUE (LONG)
* RETURN:
*   0: IF IT IS EVEN
*   1: IF IT IS ODD
* NOTE:
*   A0 IS FOR RETURN ADDRESS
*   D0 IS FOR HEX VALUE
CHECK_VALUE_IS_ODD:
VALUE_IS_EVEN EQU $0
VALUE_IS_ODD EQU $1
    LEA RETURN_ADDRESS, A0
    MOVE.L 4(SP), D0
    AND.L #$0000FFFF, D0
    DIVU.W #2, D0
    SWAP D0      
    CMPI.W #0, D0
    BEQ CHECK_VALUE_IS_ODD_FAILED
    MOVE.W #VALUE_IS_ODD, (A0)
    BRA END_CHECK_VALUE_IS_ODD
END_CHECK_VALUE_IS_ODD:   
    RTS

CHECK_VALUE_IS_ODD_FAILED:
    MOVE.W #VALUE_IS_EVEN, (A0)
    BRA END_CHECK_VALUE_IS_ODD
*-----------------------------------------------------------
* CONVERT ASCII TO HEX
* PARAMETERS:
*   1. LOCATION OF THE ASCII
*   2. LENGTH OF THE ASCII
*   3. MAXIMUM LENGTH (hex/ byte / long)
* RETURN:
* [0=FAILED](2BYTE) (BECAUSE LENGTH > MAXIMUM_LENGTH)
* [1=OK](2BYTE)[VALUE IN HEX(4BYTES)]
* [2= FAILED](2BYTE)(BEACUSE IT IS NOT A NUMBER IN HEX)
* NOTE:
*    D0 FOR LENGTH OF ASCII
*    D1 FOR LOOPING
; CURRENT INDEX
*    D2 FOR THE VALUE IN ASCII OF THE DATA
*    D3 FOR CONVERT FINAL RESULT
*    D4 FOR CALCULATE NUMBER OF BIT TO SHIFT
*    A0 LOCATION OF THE DATA   
*    A2 CURRENT POINTER AT CONVERT_HEX_RETURN_ADDRESS
ASCII_TO_HEX:
ASCII_TO_HEX_RETURN_OK EQU $1
    LEA RETURN_ADDRESS, A2
    CLR.W (A2)
    CLR.L 2(A2)
    MOVE.L 12(SP),A0
 ; LOCATION OF THE DATA
    MOVE.L 8(SP), D0  ; LENGTH OF ASCII
    MOVE.L 4(SP), D1  ; MAX LENGTH
    CMP.L D0,D1 ; CHECK IF THE LENGTH IS GREATER THAN MAX LENGTH
    BLT ASCII_TO_HEX_FAILED_0
    CLR.L D1 ; FOR LOOPING
ASCII_TO_HEX_LOOP:
   CMP.L D1, D0 ;COMPARE FOR LOOPING
   BEQ ASCII_TO_HEX_END_LOOP
   ; D2 USE FOR STORE DATA 
    MOVE.B (A0)+, D2
    CMPI.B #47, D2
ASCII_TO_HEX_CHECK_GT_0
    BGT ASCII_TO_HEX_CHECK_LT_9 ; GREATER THAN LET COMPARE WITH LESS THAN 9
    BRA ASCII_TO_HEX_FAILED_2 ;ERROR NOT A HEX VALUE
ASCII_TO_HEX_CHECK_LT_9:
    CMPI.B #58, D2 ; CHECK IF IT IS LESS THAN NUMBER '9'
    BLT ASCII_TO_HEX_CONVERT_NUMBER ; LET CONVERT TO NUMBER
    ; IF IT IT IS NOT GREATHER THAN ZERO AND LESS THAN 9 THAN CHECK A-F
    BRA ASCII_TO_HEX_CHECK_GT_A
ASCII_TO_HEX_CHECK_GT_A:
    CMPI.B #64, D2
    BGT ASCII_TO_HEX_CHECK_LT_F ; LET CHECK IF IT IS LESS THAN F
    BRA ASCII_TO_HEX_FAILED_2  ; OTHERWISE THE VALUE IS NOT IN HEX
ASCII_TO_HEX_CHECK_LT_F
    CMPI.B #71, D2
    BLT ASCII_TO_HEX_CONVERT_LETTER
    BRA ASCII_TO_HEX_FAILED_2
* CONVERT THE NUMBER '0' - '9' IN HEX AND PUT IT IN D4
ASCII_TO_HEX_CONVERT_NUMBER:
     MOVE.L D0,D4 ; MOVE NUMBER OF LENGTH ASCII TO D4
     SUB.B #48, D2 ; MINUS THE NUMBER FROM ASCII TO GET IN HEX
     SUB.L D1,D4 ; TOTAL LENGTH - CURRENT INDEX OF VALUE IN A0
     SUBQ #1, D4 ; SUB 1 TO FOR SHIFT
     MULU #4, D4 ; MULTIPLY NUMBER OF BITS TO SHIFT
     ASL.L D4, D2 ; SHIFT DATA
     ADD.L D2, 2(A2) ; ADD THE DATA TO CURRENT VALUE IN A2 
     CLR.L D2
     ADDQ #1, D1  ; INCRASE LOOP COUNT INDEX
     BRA ASCII_TO_HEX_LOOP
ASCII_TO_HEX_CONVERT_LETTER:
    MOVE.L D0, D4
    SUB.B #55, D2
    SUB.L D1,D4
    SUBQ #1, D4
    MULU #4, D4
    ASL.L D4,D2
    ADD.L D2, 2(A2)
    CLR.L D2 
    ADDQ #1, D1
    BRA ASCII_TO_HEX_LOOP
ASCII_TO_HEX_END_LOOP:
    MOVE.W #1, (A2)
    RTS
    
ASCII_TO_HEX_FAILED_0:
    MOVE.W #2, (A2)
    RTS
ASCII_TO_HEX_FAILED_2:
    MOVE.W #2, (A2)
    RTS 
* THIS METHOD USES TO INCRASE START ADDRESS TO N VALUE 
* PARAMETERS:
*   1 (8(SP)) LONG VALUE: WHERE IS THE START ADDRESS
*   2 (4(SP)) LONG VALUE: HOW MANY OFFSET
* RETURN:
*   NULL
* NOTE:
*   A0 USE TO POINT TO THE ADDRESS
*   d1 USE TO MATH 
INCRASE_POINTER_START_ADDRESS: 
    MOVE.L 8(SP), A0
    MOVE.L 4(SP), D1
    ADD.L D1, (A0)
    RTS

* FETCH 16 BIT FROM START_ADDRESS
* PARAMTERS: 
*   1- (8(SP)): WHERE IS OPCODE LOCATION
*   2- (4(SP)): WHERE TO STORE THE RESULT
* RETURN:
*   NULL
* NOTE:
*     A0 USE TO STORE THE OPCODE LOCATION
*     A2 USES TO RETURN THE OPCODE
FETCH_OPCODES:
    MOVE.L 8(SP), A0 ; LOCATION
    MOVE.L 4(SP), A2 ; OPCODE WILL BE RETURNED
    MOVE.W (A0), A0
    MOVE.W A0,(A2)
    MOVE.W #$2, (OFFSET_OPC_ADDRES)
END_FETCH_OPCODES:
    RTS
*------------------------------------------------------------------------------------------------------------------------------------------------------
* LETS DECODE
* jump table uses to jump to decode subroutine
* PARAMATERS:
* 1-(4(Sp)) Word - opcode
* NOTE: 
*   D1 USES TO STORE OPCODE
JUMP_TABLE:
* constant for RTS 
C_RTS EQU $4E75
    MOVE.W 4(SP), D1
    JSR RTS
* CONSTANT FOR JSR
    JSR JSR
    JSR LEA

END_JUMP_TABLE:
    RTS
RTS:
    CMP.W #C_RTS, D1
    BEQ PRINT_RTS
    RTS
JSR:
JSR_OPCODE EQU %0100111010000000
    CLR.W D2
    MOVE.W D1,D2 
* MASKING WITH UNIQUE OPCODE
    AND.W #%1111111111000000, D2
    CMP.W #JSR_OPCODE, D2
    BNE JSR_END 
    JSR PRINT_JSR
* MASKING TO GET MODE AND REGISTER
    MOVE.B D1,D2
    AND.B #%00111111, D2
    MOVEM.W D1, -(SP)
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #4, D2
    MOVEM.W (SP)+, D1
JSR_END:
    RTS
LEA:
    CLR.W D2
    * 0 1 0 0 AN 1 1 1
    MOVE.W D1,D2 
    AND.W  #%1111000111000000, D2
    CMPI.W #%0100000111000000, D2
    BNE LEA_END
    JSR PRINT_LEA
    MOVE.B D1,D2 
    ; MASK TO GET MODE AND REGISTER
    AND.B #%0000000000111111, D2
    MOVEM.W D1, -(SP)
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #$4, SP
    MOVEM.W (SP)+, D1
    JSR PRINT_COMMA
    ; MASK TO GET DESTINATION REGISTER
    MOVE.W D1,D2
    AND.W #%0000111100000000, D2
    ASR.W #$08, D2
    OR.B #%00010000, D2 ; OR TO PASS TO PRINT_REGISTER
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP) 
    JSR PRINT_REGISTER
    ADDQ.L #$04, SP
LEA_END:
    RTS
PRINT_RTS:
   LEA P_RTS, A1
   MOVE.B #14, D0
   TRAP #15
   JSR PRINT_TAB
   RTS 
PRINT_JSR:
    LEA P_JSR, A1
    MOVE.B #14, D0
    TRAP #15
    JSR PRINT_TAB
    RTS 
PRINT_LEA:
   LEA P_LEA, A1
   MOVE.B #14, D0
   TRAP #15
   JSR PRINT_TAB
   RTS 
PRINT_ADD: 
    LEA P_ADD, A1 
    MOVE.B #$14. D0
    TRAP #15 
    JSR PRINT_TAB
    RTS










P_RTS DC.B 'RTS',0
P_MOVE DC.B 'MOVE',0
P_MOVEA DC.B 'MOVEA', 0
P_MOVEM DC.B 'MOVEM', 0
P_ADD DC.B 'ADD', 0
P_ADDA DC.B 'ADDA',0
P_SUB DC.B 'SUB', 0
P_SUBQ DC.B 'SUBQ',0
P_MULS DC.B 'MULS',0
P_DIVS DC.B 'DIVS',0
P_LEA DC.B 'LEA',0
P_OR DC.B 'OR',0
P_ORI DC.B 'ORI', 0
P_NEG DC.B 'NEG', 0
P_EOR DC.B 'EOR', 0
P_LSR DC.B 'LSR',0
P_LSL DC.B 'LSL', 0
P_ASR DC.B 'ASR', 0
P_ASL DC.B 'ASL',0 
P_ROL DC.B 'ROL', 0
P_ROR DC.B 'ROR', 0
P_BCLR DC.B 'BCLR',0
P_CMP DC.B 'CMP', 0
P_CMPI DC.B 'CMPI', 0
P_BCS DC.B 'BCS', 0
P_BGE DC.B 'BGE', 0
P_BLT DC.B 'BLT',0
P_BVC DC.B 'BVC', 0
P_BRA DC.B 'BRA',0
P_JSR DC.B 'JSR',0
* P_RTS DC.B 'RTS',0


WORD_LENGTH EQU $04
LONG_LENGTH EQU $08
TEST_VAL DC.B '10020009'
LF EQU $0A
CR EQU $0D
HT  EQU  $09 
NEW_LINE DC.B ' ',CR,LF,0
SIMHALT             ; halt simulator
* Put variables and constants here






PROMT_INPUT_START DC.B 'Please enter starting address(capitalized):  $',0 
PROMT_INPUT_END DC.B 'Please enter ending address(cappitalized): $',0
    END    START        ; last line of source


















*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
