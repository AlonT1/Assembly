;there are 16 flgas stored in 0-15 bits, some are reserved
;each instruction changes the flags in different way. for example
;mov won't set the flags at all, inc and dec won't set the carry flag.
;read the reference manual of the cpu for further info
;ALU doesn't care whether you are doing signed or unsigned mathematics.
;ALU just does the binary math and sets the flags appropriately.

.code
rflags proc
	
	;********carry flag (CF flag, also CY - carry yes) (bit 0) - set to 1 when there is a carry outside the msb
	;for example when dealing with the first byte( or word or double word)... and a a bit is carried over to the the 9th bit
	;
	;example 1:

	mov eax, -1 ;32 bits of 1
	add eax, 1 ;
	;what happens:

	;111111___1 ;	borrow line

	;11111....1  +   (-1 decimal) 32 bits of 1 
	;00000....1      (1 decimal)  1 bit of 1
	;----------
   ;100000....0	  the last summation equals to 1 but it falls on the 33rd bit - 1 is carried outside the msb, carry flag set to 1
	;in other words, the summation, adds a 33rd bit.
	;although the register contains 64 bits, since we add with eax (32 bit) and there is no space for the 33rd bit,
	;therefore all of the register is reset to zero (unique to eax instructions) , and the extra 1 bit GOES INTO THE CARRY FLAG (CY)!


	clc ;clear carry flag
	mov rax, 50000000; reset rax

	;example 2:
	mov al, 255 ;1111 1111  255 to the first 8 bits of al
	add al, 1; 1 0000 0000 there isn't enoguh bits to represent 256! since we add with "al" the 1 is discarded, no space for it (the register is zeroed)
	add al, 1  
	;would  work if al was replaced with eax which supports 32 bits. because al can only represent 8 bits, adding 1
	;causes a carry to the 9th bit which isn't available with the al instruction, therefore, only the first byte
	;is reset to zero (as opposed to eax instruction which resets all the register) and the extra carry bit goes int the CARRY FLAG! (CY)

	stc ; set the carry (to 1)
	clc ;clear carry flag

	mov rax, 0; reset rax

	;example 3:
	mov ax, 4 ;1000 
	sub ax, 5; 1011 ; al-=11  -> whats going on here:
	;explanation in binary subtraction jpg. basically, the subtraction comes to a point where
	;there is nowhere to borrow from, so the carry flag is set and we "borrow" from it.

	;SO THE CARRY FLAG IS ACTIVATED IN THE FOLLOWING SCENARIOS:
	;1. When there is a carry outside the msb
	;2. When there is no bit to borrow from during subtraction
	;IT IS DIFFERENT Then the overflow flag which is set when there is a carry
	;into the msb, which denotes the entering to a negative /positive number range (for signed number representation)
	;(switching signs). for unsigned ints, this means going over a certain threshold, for example 0-~2b, after ~2b, OV is set


	;********parity flag (pe (parity even?)) (bit 0) - when reading 8 bits: 00110101 and only the lower 7 bits
	;represent a number, the lefftmost bit is the parity bit used for error checking:
	;0 parity means odd number of 1's, 1 parity means even number of 1's, so in 00110101
	;the data is corrupt since leftmost bit denotes odd number of 1's but there is an even number of 1's!!!
	;this means that the data we recieved (00110101) is corrupted!
	; THE PARITY FLAG CHANGES ONLY in Arithmetic or LOGIC instructions

	mov eax, 0 ;
	add eax, 1; -> 001 -> odd number of bits, parity changes to 1
	and eax, eax ; result is the same as eax


	
	;**********Auxillary Carry Flag (AC - bit 4) - similar to carry flag, only the aux 
	;carry flag denotes overflow only of the lowest (rightmost) 4 bits (lowest nibble)
	;was used in binary coded instructions (legacy... aux flag exists for backwords compatability)
	mov eax, 15 ;-> 1111 bits
	add eax, 1; -> 10000 - overflow of the nibble (1 a "carry bit" from the 3rd bit to the 4th bit, lowest 4 bits (0,1,2,3) are overflowed)
	

	;**********Zero flag (ZR - bit 6) -  if the last result (no matter the register) is zero, flag is 1, other wise set to 0 
	xor eax, eax ;result stored in eax is zero since all the numbers are equal (only 1's or only 0's) -> ZR Flag set to 1
	add eax, 5; eax equals to 5, ZR is 0
	;use case for zero flag: 

	cmp eax, ecx ;bts: performs eax-=ecx (like SUB) and set the zero flag (if both are 5 -> 5-5 = 0
	;ZR flag = 1. if both are different, the subtraction will not equal zero -> ZR flag = 0. Doesn't set the result in eax like sub
	;thats why ZR flag is also called the equals flag
	

	;**********Sign flag (PL (plus?) bit 7) - whether the last result is positive or negative according to the last (leftmost) bit (msb)
	;the msb is the last relevant bit, not necessarily the 64bit, but the last bit the represents the number (could be 8th,16th, 32nd bit ...)
	;SF = 1 if msb is 1, meaning the result is negative
	;SF = 0 if msb is 0, meaning the result is positive
	mov eax, 7
	mov ecx, 12
	sub eax, ecx ;equivalent to eax-=ecx -> eax = 7-12 -> eax=-5, negative number, 1 msb, SF=1

	;**********Direction Flag (UP - 10th bit) - determines the direction of string instructions, automatically increment or decrement
	; a pointer so we can read a string in pos or neg direction. reading the string in forwards direction (from lower to higher
	;ram address) -> UP =0 , conversly reading a string backwards (high to low ram address) - UP = 1

	std; set UP to 1 (read strings backward)
	cld; set UP to 0 (read string forwards)


	;**********Overflow flag (OV - 11th bit) - OV = 1 when there is a carry INTO the msb
	;for example: given 8 bytes:
	;0111 1111 (7F hex) (127 decimal)
	;adding 1 ->
	;1000 0000 (80 hex) (128 decimal)
	;if interpreted as a signed number, the added 1 has caused the sign of the number to change!
	;there was a carry INTO the MSB (overflow), as opposed to a OUT of the MSB (carry flag), where
	;the total number of bits isn't enough to represent a number
	;basically the overflow flag is set when we go into the positive/negative range of a nubmer (for signed representations)
	clc
	mov rax, 0
	mov al, 7Fh  ;0111 1111 (127)
	add al, 1	 ;1000 0000 (128 for unsigned) if interpreted as a signed int - the sign has changed (overflow)
	;the overflow flag is set in this case because we are only considering the first 8 bits (al register)
	; if manipulated with eax, for example, this register could easily hold 7fh, up until 7FFF FFFF (32 Bits)
	; so adding 1 to 7fh in this case would not cause an overflow.
	
	;pushfq 
	;pop rax

	;**********Trap Flag: Allows debuggers to step through code
	;**********Interrupt Flag: Allows interrupts to be called
	;**********IOPL: Shows IO port privilege level
	;**********Nested Task: Shows if this task is nested
	;**********CPUID: if you can toggle bit 21, the the cpu is capable of the CPUID
rflags endp
end