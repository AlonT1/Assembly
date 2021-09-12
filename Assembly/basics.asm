
;cpu registers:
;r prefix to registers means 64 bits, e prefix means 32 bits

;AX is the primary accumulator; it is used in input/output and most arithmetic instructions. 
;For example, in multiplication operation, one operand is stored in EAX or AX or AL register according to the size of the operand.
;BX is known as the base register, as it could be used in indexed addressing. Used as a pointer to data (structures)
;CX is known as the count register, as the ECX, CX registers store the loop count in iterative operations.
;DX is known as the data register. It is also used in input/output operations. 
;It is also used with AX register along with DX for multiply and divide operations involving large values.

;a word is 16 bits (2 bytes), 32bit is double word, 64 bit - quadword

;instructions: menomnic(mov,add..) operands (immediates(constants), registers, ram memory)

.data ;stored in ram
ma dword 5; dword means that 32 bits will represent 5 (padded with 0's) out of the 64 bits that "ma" contains
string BYTE "hello", 0 ;db - define byte, declares variable, each character is a byte! 0xa equals to \n new line
	;db synoym of BYTE
	;0 is the null terminating character
	;equals to msg db 'h','e','l'......

numbers BYTE 3, 4, 5 ;array of bytes

.code
some_function proc
	;mov (move) and lea (load effective address) are DATA INSTRUCTIONS
	mov rdx, 8		;8 becomes the value of 32 segment of rdx register. equivalent to edx=8
	lea rax, ma		;move address of ma (only valid for variables in ram, not registers). equivalent to int* eax = &ma.
	;note: ram addresses are always 64 bits, therefore the addresses must be stored in full 64 bit form in registers (using eax would clip the first (left) 32 bits)
	;!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

	;Square brackets - has 2 meanings:
	; 1. dereference the value that exists in the address held by the variable in the brackets
	mov qword ptr[rax], rdx		;writes 8 to the memory address specified in the value of eax. 
	;rax is equal to a memory address and the square brackets allow to change the value at that memory address.
	;equivalent to *eax = 8 (changes ma) assuming esi stores a valid memory address to ram (not registers!) (otherwise, throws memory violation)
	;"dword ptr" isn't mandatory, but if used, it must denote the size of the register in the square brackets (dword ptr==eax == 32 bits
	;qword means 64 bit, ok for registers such as rax).
	mov rdx, [rax]  ; equivalen to rdx = *rax. DEREFERENCE OCCUR as opposed to: lea rdx, [rax]

	;2. arithmetic of address
	lea rdx, [ma+4] ;when used within lea, the square brackets allow arithmetic manipulation of the value held by the variable in the square brackets. No dereference happens here unlike meaning 1.
	; essentialy a "trick", we manipulate the value in ma as if it was an address. it can be an address,
	;but it also can be a simple variable, for example ma can represent 3 and added with 4, the result is then moved into rdx.
	;when lea no dereference is used, we simply manipulate the address / value in ma 
	;"perform a non-trivial address calculation and store the result" , relative addressing, +4 into the next byte

	;lea rdx, rax ;error! taking address of a register
	lea rdx, [rax+4] ;allowed! SQUARE BRACKETS ALLOW TO TAKE THE VALUE OF A REGISTER as if it is an address
	;and manipulate it with arithmetic, and assign the result to rdx, NO DEREFERENCE OCCURS HERE
	

	
	;add, inc, dec, sub are ARITHMETIC INSTRUCTIONS
	add rdx, 2	;equivalent to rdx+=2
	sub rdx, 1 ;equiavalent to rdx-=1
	inc rdx ;equivalent to rdx++
	dec rdx ;equivalent to rdx--  rdx is now 10

	;AND, XOR, NOT... are LOGIC INSTRUCTIONS
	AND rdx, 1011b	; AND between rdx=10 and 1011b = 11  => equals 11 (result stored in rdx)
	ret ; returns the value in rax register
some_function endp
end