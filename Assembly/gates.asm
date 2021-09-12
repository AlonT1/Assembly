
.code ;start of a coding segment
gates proc
	
	mov eax, 101100110001b;
	mov ecx, 101001110001b;
	mov edx, 10101010101b

	;operations:
	AND eax, ecx ;stores the result in eax
	OR eax, ecx;
	NOT eax ;1's compliment for eax (stored in eax)
	XOR edx, edx ;always 0 because a number is always equal to itself, and xor is 1 only when two compared nums are different.
	
	;XNOR operation - equivalent to "equals" - 1 when numbers are identical (both are zero or 1), opposite of XOR
	XOR edx, edx
	NOT edx

	;NOR - NOT OR, oppositve of OR, nums 2 nums are equal only when they are 0
	OR eax, edx
	NOT eax
	
	;NAND - NOT AND, opposite of AND - 0 only when two nums are 1, otherwise all 1
	AND eax, edx
	NOT eax
	;NAND is a universal gate, we can create all gates from it, for example: NANDING 2 numbers yields a NOT gate
	;its simplifies the circutry, using the same gate again and again.
	;NOR is also a universal gate

	ret; ; returns eax
gates endp
end ;end of a coding semgnet