
.data
arr dword 4 dup(0) ;4 duplicates of signed double word filled with 0
;this is a contiguous block of memory
;arr doesn't decay to a pointer like in c meaning arr doesnt equal an address, but equals to the first element
;REMEMBER MEMORY ADDRESSES ARE ALWAYS 64 BIT (on 64 bit architecture)
.code
arrays proc
	
	mov [arr], 4  ; equivalent to *arr = 4 
	lea rdx, arr
	;*************for loop incrementing, changing array elements
	;for (int i=0; i<=4; i++) arr[i] = i;

	xor rcx, rcx ; i=0 "initialization"
	cmp rcx, 4
	jge Finish ;this equals to the initial check of the condition before entering the loop
	Loophead:
		;mov dword ptr[arr + rcx * 4], rcx ; arr[i] = i   direct array manipulation works if LARGEADDRESSAWARE:NO is set in project linker->system->enable large address
		;otherwise, we need to copy the address of arr in rdx (line 11)
		mov dword ptr[rdx + rcx * 4], ecx ; arr[i] = i ; Scale index Base , *4 to jump 4 bytes each time rcx increments
		inc rcx ; increment
		; check if i<4
		cmp rcx, 4
		jl Loophead 
	Finish:
		ret
arrays endp
end