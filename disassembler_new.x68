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
START_ADDRESS EQU $09100
* LOCATION TO STORE END_ADDRESS
END_ADDRESS EQU $7004
* LOCATION TO STORE CURRENT 16 BITS OPCODE
OPCODE_ADDRESS EQU $7006
* LOCATION TO STORE CURRENT OFFSET FROM OPCODE OF A INSTRUCTION, FOR EXAMPLE:
*       MOVE.L #$500, D3 and the instruction(MOVE.L known data register as d3 and immediate data) location at 10000.
*       THIS OFFSET WILL HANDLE BY PRINT_REGISTER. IT WILL PRINT OUT #$500 AND ADD THE NEXT OFFSET FROM THE ORIGINAL OPCODE IN THIS LOCATION, 
*       THE OFFSET SHOULD SET = 2 WHEN FETCH_OPCODE 
OFFSET_OPC_ADDRES EQU $7008 
; SIZE OF A OPCODE WORD BYTE LONG TO A JUST THE PC 
SIZE_OPCODE EQU $700A
* LOCATION TO STORE REGISTERS FOR MOVEM
STORE_REGISTER_ADDRESS EQU $700C
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
 
    CLR.B D7 ; use d7 for counter main loop
    MOVE.L #START_ADDRESS, A0 
    MOVE.L #$010000, (A0)
LOOP_START:
    MOVE.L #STACK_ADDRESS, SP
    MOVE.L (START_ADDRESS), -(SP)
    MOVE.L #OPCODE_ADDRESS, -(SP)
    JSR FETCH_OPCODES
    ADDQ.L #8, SP
    JSR PRINT_TAB
    JSR PRINT_PC
    MOVE.L #OPCODE_ADDRESS, A0
    MOVE.W (A0), -(SP)
    JSR JUMP_TABLE
FINISH_OPCODE:
    CLR.L D0
    MOVE.L #$0, (RETURN_ADDRESS) ; SET ALL THE FLAG IN RETURN ADDRESS  TO ZERO 
    MOVE.W (OFFSET_OPC_ADDRES), D0
    ADD.L D0, (START_ADDRESS)
    JSR PRINT_NEW_LINE
    ADDQ.B #1, D7 
    CMPI.B #29, D7 
    BEQ CLR_SCREEN
    BRA LOOP_START

CLR_SCREEN:
    LEA PROMT_INPUT_CONTINUE, A1 
    MOVE.B #13, D0 
    TRAP #15 
    CLR.B D7
    MOVE.B #5, D0 
    TRAP #15 
    CMPI.B #$0D, D1 
    BEQ LOOP_START
    BRA END_MAIN

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
*       00 - byte
*       01 - word
*       10 - long
* NOTE:
*   A1 USE FOR PRINT
*   d1 USES TO STORE DATA TYPE OF PARAMETER ABOVE
PRINT_DATA:
    MOVE.L #OUTPUT_ADDRESS, A1
    MOVE.B 4(SP), D1
    CMPI.B #$00, D1
    BEQ PRINT_BYTE
    CMPI.B #$01, D1
    BEQ PRINT_WORD
    CMPI.B #$02, D1 
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
* PRINT CURRENT PROGRAM COUNTER IN HEX 
* WILL GET THE CURRENT PC IN START ADDRESS AND PRINT IT OUT
* PARAMETERS:
*   NONE
* NOTES: 
* A1 USE TO PRINT 
* D0 FOR TRAP AND CONVERSION 
PRINT_PC:
    MOVE.L (START_ADDRESS), D0 
    MOVE.L D0, -(SP)
    MOVE.L #HEX_TO_ASCII_LONG, -(SP)
    JSR PRINT_HEX 
    ADDQ.L #8, SP 
    JSR PRINT_TAB
    JSR PRINT_TAB 
    JSR PRINT_TAB
    RTS 

CHECK_SUPPORT_REGISTER:
    MOVE.W 4(SP), D1 
    MOVE.W D1,D4 
   ; check to make sure we dont support the register 
DISPLACEMENT_REGISTER EQU %00101000
ADDRESS_WITH_INDEX EQU %00110000
COUNTER_INDEX EQU %00111011 
COUNTER_DISPLACEMENT EQU %00111010
    AND.B #%00111000, D4 
    CMPI.B #DISPLACEMENT_REGISTER, D4
    BEQ UNSUPPORT_REGISTER
    CMPI.B #ADDRESS_WITH_INDEX, D4
    BEQ UNSUPPORT_REGISTER 
    MOVE D1, D4
    AND.B #%00111111,D4
    CMPI.B #COUNTER_INDEX, D4
    BEQ UNSUPPORT_REGISTER 
    CMPI.B #COUNTER_DISPLACEMENT, D4
    BEQ UNSUPPORT_REGISTER
    RTS
UNSUPPORT_REGISTER:
C_UNSUPPORT_REGISTER EQU $2
    MOVE.L #RETURN_ADDRESS, A3
    JSR PRINT_UNSUPPORTED
    JSR PRINT_TAB 
    JSR PRINT_HASH_SIGN 
    JSR PRINT_DOLLAR_SIGN 
    CLR.L D1 
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.L D1, -(SP) 
    MOVE.L #HEX_TO_ASCII_WORD, -(SP)
    JSR PRINT_HEX 
    ADDQ.L #8, SP 
    MOVE.W #C_UNSUPPORT_REGISTER, (A3)
    RTS 


*--------------------------------------------------------------------
* PRINT_REGISTER
* PARAMETERS: what register 1 byte 4 msb indicate dn(0) or an(1), 4 lsb for number of that register
* 1 - (6(sp)) 3 bits msb for mode, 3 bits lsb for which register
* 2 - (4(sp)) byte value for how many byte for immediate value
*      0 for a byte value
*      1 for word value
*      2 for long value 
* RETURN 2 IN RETURN ADDRESS IF THE MODE DOESNT SUPPORT 
* NOTE: 
*   D1 FOR STORE THE PARAMETER
*   D2 FOR STORE HOW MANY BYTE FOR IMMEDIATE VALUE, AND ABSOLUTE VALUE
PRINT_REGISTER:
   MOVE.W 6(SP), D1 
   
   MOVE.W D1,D2
   CMPI.B #%00111100, D1
   BEQ PRINT_IMMEDIATE
   CMPI.B #%00111000, D1
   BEQ PRINT_AB_SHORT
   CMPI.B #%00111001, D1
   BEQ PRINT_AB_LONG 

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00010000, D2
   BEQ PRINT_OPEN

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00011000, D2
   BEQ PRINT_OPEN

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00100000, D2
   BEQ PRINT_MINUS_OPEN

CONTINUE_PRINT_REGISTER:
   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00000000, D2
   BEQ PRINT_D

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00001000, D2
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
   AND.B #%00111000, D2
   CMPI.B #%00010000, D2
   BEQ PRINT_CLOSE

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00011000, D2
   BEQ PRINT_CLOSE_PLUS

   MOVE.B D1,D2
   AND.B #%00111000, D2
   CMPI.B #%00100000, D2
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
    CMPI #$00, D2
    BEQ PRINT_IMMEDIATE_BYTE ; THIS CASE NEVER HAPPEN BECAUSE IMMEDATE VALUE MINIMUM IS 16 bits
    CMPI #$01, D2
    BEQ PRINT_IMMEDIATE_WORD
    CMPI #$02, D2
    BEQ PRINT_IMMEDIATE_LONG
    BRA END_PRINT_REGISTER

PRINT_IMMEDIATE_BYTE:
    MOVE.L (START_ADDRESS), A2
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
    MOVE.L (START_ADDRESS), A2
    MOVE.W (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_WORD, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A1
    ADDQ.W #$2, D0
    MOVE.W D0, (OFFSET_OPC_ADDRES)
    BRA END_PRINT_REGISTER
PRINT_IMMEDIATE_LONG:
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.L (START_ADDRESS), A2
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
    MOVE.L (START_ADDRESS), A2
    MOVE.W (OFFSET_OPC_ADDRES),D0
    MOVE.W (A2, D0), D2 ; 
    MOVEM.L D0-D2/A0-A1, -(SP)
    MOVE.L D2, -(SP)
    MOVE.L #HEX_TO_ASCII_WORD, -(SP) 
    JSR PRINT_HEX
    ADDQ.L #$08, SP
    MOVEM.L (SP)+, D0-D2/A0-A1
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
    MOVE.L (START_ADDRESS), A2
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
    CMPI #HEX_TO_ASCII_WORD, D4 
    BEQ HEX_TO_ASCII_SWAP
    CMPI #HEX_TO_ASCII_BYTE, D4
    BEQ HEX_TO_ASCII_BYTE
HEX2ASCII_DONE_CONVERT:
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
HEX_TO_ASCII_SWAP:
    SWAP D0
    BRA HEX2ASCII_DONE_CONVERT
   
HEX_TO_ASCII_ROR:
    ROR.L #$08, D0
    BRA HEX2ASCII_DONE_CONVERT


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
    JSR ADDA
    JSR ADD 
    JSR MOVEA 
; IF THE OPCODES DONT MATCH THE OPCODE ABOVE THAN PRINT DATA OPCODE
END_JUMP_TABLE:
    JSR UNSUPPORT_REGISTER

RTS:
    CMP.W #C_RTS, D1
    BEQ PRINT_RTS
    RTS
JSR:
JSR_OPCODE EQU %0100111010000000
    MOVE.W D1,D2 
* MASKING WITH UNIQUE OPCODE
    AND.W #%1111111111000000, D2
    CMP.W #JSR_OPCODE, D2
    BNE JSR_END 
    ; check to make sure we support this register 
    MOVE.W D1, D2 
    AND.B #%00111111, D2 
    MOVE.W D2, -(SP)
    JSR CHECK_SUPPORT_REGISTER 
    ADDQ #2, SP 
    ; check return value
    *  from print_register to see if it is unsupported register 
    MOVE.W (RETURN_ADDRESS), D2 
    CMPI.W #C_UNSUPPORT_REGISTER, D2 ; IF EQUAL RETURN TO FETCH NEXT OPCODE 
    BEQ JSR_END
    ; done checking 
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
    * 0 1 0 0 AN 1 1 1

    MOVE.W D1,D2 
    AND.W  #%1111000111000000, D2
    CMPI.W #%0100000111000000, D2
    BNE LEA_END

    ; CHECK TO MAKE SURE WE SUPPORT THE EA
    MOVE.W D1, D2 
    AND.B #%00111111, D2 
    MOVE.W D2, -(SP)
    JSR CHECK_SUPPORT_REGISTER
    ADDQ #2, SP 
    ; check return value
    *  from print_register to see if it is unsupported register 
    MOVE.W (RETURN_ADDRESS), D2 
    CMPI.W #C_UNSUPPORT_REGISTER, D2 ; IF EQUAL RETURN TO FETCH NEXT OPCODE 
    BEQ FINISH_OPCODE
    * END CHECKING
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
    AND.W #%0000111000000000, D2
    LSR.W #$08, D2
    LSR.W #$01, D2
    OR.B #%00001000, D2 ; OR TO PASS TO PRINT_REGISTER
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP) 
    JSR PRINT_REGISTER
    ADDQ.L #$04, SP
    BRA FINISH_OPCODE
LEA_END:
    RTS
ADDA:
    MOVE.W D1, D2
C_ADDA EQU       %1101000011000000
ADDA_MASKING EQU %1111000011000000
    AND.W #ADDA_MASKING, D2 ; GET PATTERN
    CMPI.W #C_ADDA, D2 ; COMPARE WITH THE PATTERN
    BNE ADDA_END 
    ; CHECK TO MAKE SURE WE SUPPORT THE EA
    MOVE.W D1, D2 
    AND.B #%00111111, D2 
    MOVE.W D2, -(SP)
    JSR CHECK_SUPPORT_REGISTER
    ADDQ #2, SP 
    ; check return value
    *  from print_register to see if it is unsupported register 
    MOVE.W (RETURN_ADDRESS), D2 
    CMPI.W #C_UNSUPPORT_REGISTER, D2 ; IF EQUAL RETURN TO FETCH NEXT OPCODE 
    BEQ FINISH_OPCODE
    JSR PRINT_ADDA
    MOVE.W D1, D2  ; START TO MASK SIZE 
ADDA_SIZE_MASKING EQU %0000000100000000
    AND.W #ADDA_SIZE_MASKING,D2 
    LSR.W #8, D2 
    MOVE.W D2 , D6 ; FOR SIZE TO PRINT REGISTER 
    ADDQ #$1, D6
    MOVE.B D6 , -(SP)
    JSR PRINT_DATA
    ADDQ.L #$2, SP 
    JSR PRINT_TAB
    ; GET MODE AND REGISTER
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.B D1, D2 
    AND.B #%00111111, D2 
    MOVE.W D2, -(SP)
    MOVE.W D6, -(SP)
    JSR PRINT_REGISTER 
    ADDQ.L #$04, SP 
    JSR PRINT_COMMA
    MOVE.W (OPCODE_ADDRESS), D1  ; get back the opcode just in case
    MOVE.W D1, D2
ADDA_AN_MASKING EQU %0000111000000000
    AND.W #ADDA_AN_MASKING, D2
    LSR.W #8, D2 
    LSR.W #1, D2 
    OR.B #%00001000, D2 ; TO APPEND MODE FOR PRINT REGISTER 
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP)
    JSR PRINT_REGISTER 
    ADDQ.L #$4, SP 
    BRA FINISH_OPCODE
ADDA_END:
    RTS

ADD: 
    MOVE.W D1, D2 
C_ADD EQU %1101000000000000 ; PATTERN
C_ADD_MASKING EQU %1111000000000000 ; MASKING TO CHECK PATTERN
C_ADD_EA EQU %00111111 ; EFFECTIVE ADDRESS MASKING
C_ADD_REGISTER EQU %0000111000000000 ; WHICH REGISTER
C_ADD_SIZE EQU %0000000111000000  ; SIZE 
C_ADD_DIRECTION EQU %0000000100000000
C_ADD_TO_D EQU      %0000000000000000
C_ADD_FROM_D EQU    %0000000100000000
    ; CHECK PATTERN 
    AND.W #C_ADD_MASKING, D2 
    CMPI #C_ADD, D2 
    BNE ADD_END 
    ; CHECK SUPPORT REGISTER 
    MOVE.W D1, D2 
    AND.B #%00111111, D2 
    MOVE.W D2, -(SP)
    JSR CHECK_SUPPORT_REGISTER
    ADDQ #2, SP 
    ; check return value
    *  from print_register to see if it is unsupported register 
    MOVE.W (RETURN_ADDRESS), D2 
    CMPI.W #C_UNSUPPORT_REGISTER, D2 ; IF EQUAL RETURN TO FETCH NEXT OPCODE 
    BEQ FINISH_OPCODE
    
    JSR PRINT_ADD 
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    AND.W #C_ADD_SIZE, D2 
    LSR.W #6, D2
    MOVE.B D2, D6 ; SAVE FOR IMMEDIATE VALUE AND SIZE OF AN OPCODE  

    MOVE.B D2, -(SP)
    JSR PRINT_DATA
    ADDQ.L #$02, SP 
    JSR PRINT_TAB 
    ; CHECK DIRECTION
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2  
    AND.W #C_ADD_DIRECTION, D2 
    CMPI.W #C_ADD_TO_D, D2 
    BEQ ADD_TO_D ; DN <EA> -> DN
    ; otherwise from d 
ADD_FROM_D:
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    AND.W #C_ADD_REGISTER, D2 
    LSR.L #8, D2 
    LSR.L #1, D2 
    OR.B #%00000000, D2
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP)
    JSR PRINT_REGISTER 
    ADDQ.L #4, D2 
    JSR PRINT_COMMA 
    
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    AND.B #C_ADD_EA, D2 
    MOVE.W D2, -(SP)
    MOVE.W D6, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #4, SP 
    BRA FINISH_OPCODE
    
ADD_TO_D:
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    ; GET SOURCE REGISTER 
    AND.B #C_ADD_EA, D2 
    MOVE.W D2, -(SP)
    MOVE.W D6, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #4, SP 
    JSR PRINT_COMMA 
    ; PRINT DATA REGISTER 
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    AND.W #C_ADD_REGISTER, D2 
    LSR.W #8, D2 
    LSR.W #1, D2 
    ; APPEND MODE TO D2 FOR PRINT_REGISTER
    OR.B #%00000000, D2 
    MOVE.W D2, -(SP)
    MOVE.W #$0, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #4, SP 
    BRA FINISH_OPCODE


ADD_END:
    RTS

MOVEA: 
C_MOVEA_PATTERN1 EQU  %0001000001000000
C_MOVEA_PATTERN2 EQU  %0011000001000000
C_MOVEA_PATTERN3 EQU  %0010000001000000
C_MOVEA_P_MASKING EQU %1111000111000000
C_MOVEA_SIZE      EQU %0011000000000000
C_MOVEA_AN        EQU %0000111000000000
C_MOVEA_REGISTER  EQU %00111111
    MOVE.W D1, D2 
    ANDI.W #C_MOVEA_P_MASKING, D2 
    CMPI.W #C_MOVEA_PATTERN1, D2 
    BEQ MOVEA_REGISTER_OK
    CMPI.W #C_MOVEA_PATTERN2, D2 
    BEQ MOVEA_REGISTER_OK
    CMPI.W #C_MOVEA_PATTERN3, D2 
    BEQ MOVEA_REGISTER_OK
    RTS
MOVEA_REGISTER_OK:
    ; CHECK SUPPORT THE REGISTER 
    MOVE.W D1, D2 
    AND.B #C_MOVEA_REGISTER, D2 
    MOVE.W D2, -(SP) 
    JSR CHECK_SUPPORT_REGISTER
    ADDQ.L #2, SP 
    MOVE.W (RETURN_ADDRESS), D2 
    CMPI.W #C_UNSUPPORT_REGISTER, D2 
    BEQ FINISH_OPCODE
    ; DONE CHECKING, NOW DECODE 
    JSR PRINT_MOVEA 
    ; GET SIZE 
    MOVE.W D1, D2 
    AND.W #C_MOVEA_SIZE, D2 
    ; SHIFT TO LSB 
    LSR.W #8, D2 
    LSR.W #4, D2 
    CMPI.B #%00000001, D2
    BEQ CONVERT_OPMODE_SIZE_B
    CMPI.B #%00000011, D2 
    BEQ CONVERT_OPMODE_SIZE_W
    BRA DONE_CONVERT
CONVERT_OPMODE_SIZE_B:
    SUBQ.B #1, D2 
    BRA DONE_CONVERT
CONVERT_OPMODE_SIZE_W: 
    SUBQ.B #2, D2 
    BRA DONE_CONVERT

DONE_CONVERT:
    MOVE.W D2, D6 ; COPY THE SIZE FOR LATTER USE 
    MOVE.B D6, -(SP)
    JSR PRINT_DATA 
    ADDQ.L #2, SP 
    JSR PRINT_TAB
    ; GET SOURCE REGISTER 
    MOVE.W (OPCODE_ADDRESS), D1 
    MOVE.W D1, D2 
    AND.B #C_MOVEA_REGISTER,D2 
    MOVE.W D2, -(SP)
    MOVE.W D6, -(SP)
    JSR PRINT_REGISTER
    ADDQ.L #4, SP 
    JSR PRINT_COMMA

    MOVE.W (OPCODE_ADDRESS), D1 ; GET BACK THE OPCODE  
    MOVE.W D1, D2 ; MOVE TO D2 FOR LATER USE, NO NEED TO GET FROM MEMORY ANYMORE
    AND.W #C_MOVEA_AN, D2 
    LSR.W #8, D2 
    LSR.W #1, D2 
    ; ADD MODE FOR PRINT_REGISTER 
    ORI.B #%00001000, D2 
    MOVE.W D2, -(SP)
    MOVE.W #0, -(SP)
    JSR PRINT_REGISTER ; PRINT AN 
    ADDQ.L #4, SP 
    BRA FINISH_OPCODE   

MOVEA_END: 
    RTS 


PRINT_RTS:
   LEA P_RTS, A1
   MOVE.B #14, D0
   TRAP #15
   JSR PRINT_TAB
   BRA FINISH_OPCODE
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
PRINT_ADDA: 
    LEA P_ADDA, A1 
    MOVE.B #14, D0
    TRAP #15 
    RTS
PRINT_ADD:
    LEA P_ADD, A1 
    MOVE.B #14, D0 
    TRAP #15
    RTS
PRINT_MOVEA: 
    LEA P_MOVEA, A1 
    MOVE.B #14, D0 
    TRAP #15 
    RTS 
PRINT_UNSUPPORTED: 
    LEA P_DATA, A1 
    MOVE.B #14, D0 
    TRAP #15 
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
P_DATA DC.B 'DATA',0
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
PROMT_INPUT_CONTINUE DC.B 'Press enter to continue',CR,LF,0
    END    START        ; last line of source


























*~Font name~Courier New~
*~Font size~10~
*~Tab type~1~
*~Tab size~4~
