;div - integer unsigned division
;idiv - integer signed division

.code
diving proc
	;75(dividend) /4 (divisor) = 18(quotient) 3(remainder) / 4 (divisor)

	;dividing by 8 bit number - result goes to AL, remainder into AH
	mov ax, 50
	mov bl, 10 
	div bl; divides 50 by 10 and stores the result in the. IMPLIED OPERAND IS AX
	;IMPORTANT NOTE: although 10 can be represented with 4 bits, we divide by bl - 8 bits - the smallest addressable memory
	
	;result rax: .........00(0 remainder in hex) 05 (5 in hex) ;memory above the 16 bits is not reset (only happens
	;with 32/64 bit instructions)



	;dividing by a number greater than 8 bits:
	;implied operand - compound register made by joining togheter rdx:rax - allows for bigger division

	;for 16 bits the implied operand is DX:AX
	;(top 16 bits are stored in DX (result) and the bottom 16 bits are stored in ax (remainder)
	;same principle applies for dividing by 32 bit (EDX:EAX) and for 64 bits (RDX: RAX)
	xor rdx, rdx ;zero out dx
	mov ax, 50
	mov cx, 3
	div cx ; dividing by cx - 16 bits
	;50 / 3 = 16 2/3
	;result DX:  ............0010 (16 in decimal) AX: ............0002 (remainder)   

	ret


	
diving endp
end