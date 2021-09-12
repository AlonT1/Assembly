.code
jumping proc

	;************overflow conditional jump
	mov eax, 1 ;mov doesn't affect flags
	add eax, 5 ; only arithmetic/logic operations affect flags
	jo overflowed ;jump if overflow flag=1 (ov=1)
	jno nooverflow	;jump if overflow flag=0

overflowed:
	mov eax, 0
nooverflow:
	mov eax, 14

	;ALWAYS USES CMP 1st and CONDITIONAL MOVES /jumps immediately after!!!!!
	;NOT Only they work together, but also the latter instruction relies on the result of cmp, which may be altered
	;if any instruction exists between the Contional move/ jump which can alter the flags and override cmp.
	;**************carry conditional move ALWAYS USES CMP 1st and CONDITIONAL MOVES LATER!!!!!
	;push rbx ; we are not supposed rbx -> therefore if we do, we must push it on the stack and pop it,
	; which will cause its value to reset, also called not scratch. must pop ebx before return,
	;pop rbx
	mov ebx, 4
	mov eax, -1  ;1111...1 (32 bits) (the two's complement of 1 (000000...1)
	add eax, 1 ; will cause a carry of 1 into the 33rd bit, (1000000...0 -  33 bits).
	;in practice, since we add to an eax (32 bit part of the register) and there is no 33rd bit,
	; all of the register is zeroed out!
	;sets the carry flag to 1
	cmovc eax, ebx   ;move ebx into eax if carry flag=1 (CY=1). whether CY=0 or 1, cmovc will always clear
	;the upper 32 bits of the DEST register (eax in this case). happens always(?) when performing 32 bit
	;operations (eax) on 64 bit registers (rax)

	;************** zero flag conditional move
	mov rcx, 10 ;also called the COUNTING register, used for loops, among others
	LoopHead:
		;body of the loop
		dec rcx ; rcx-=1
		jnz LoopHead; jump to LoopHead if ZF=0, the moment rcx reaches 0 , this loop would stop


	;************** set byte instruction
	mov eax, 10
	mov ecx, 10
	cmp eax, ecx; subtracts ecx from eax -> if result is 0 (equal numbers) -> zero flag = 1, otherwise zero flag (ZR)=0 (cleared)
	;cmp effects The EFLAGS register in the same manner as a sub instruction (affects the carry flag, zero flag...).
	;the only difference is that cmp doesn't save the result into DEST, unlike SUB
	sete al  ; set equals. al (lower 8 bits of rax) is set to 0000 0001 if zero flag=1 (ZR=1), otherwise 0 
	;(in this case, it dependes on cmp, in other words, al is 0000 0001 if ecx==eax,
	;sete == setz (set zero), both have the same effect
	setne al; (set not equals) set byte (al byte in this case) if ZR=0. setne == setnz both have the same effect


	;**************jump if below / above, equivalent to testing if > or if <
	; equals to rax = 0 ? rax < rcx : 1
	mov rax, 78
	mov rcx, 90
	cmp rax, rbx ; the carry flag is set to one because 78<90 (SUB occurs between 78, 90)
	jb below ; jump to below section if carry 
	ja above

	below:
		mov rax, 0
	above:
		mov rax, 1
	; if statements are very costly because the cpu tries to predict ahead of time the path
	; it will take (Called speculative execution - optimization technique),
	;if it gets it wrong, it flushes the wrong code and loads the correct.
	;better to use conditional move (they were put into the cpu to avoid the performance issues of branching):


	;**************moving without cmp
	;since both SUB and CMP set the EFLAG register in the same way, we don't have to use cmp at all!
	mov rax, 50
	mov rcx, 90
	sub rax, rcx;
	mov rdx, 1
	cmovs rax, rdx;mov if sign flag (PL) is 1, which indeed occurs (50-90 int the sub instruction).
	;doesn't work with immediates, only registers or memroy

	ret

	;**************compound if statement
	; if (a<b && a == 10) c=1;
	mov rax, 5 ;a
	mov rbx, 3 ; b 
	mov ecx, 0 ; final result c
	mov r8d, 0 ; bool 0
	mov edx, 1 ; bool 1
	cmp rax, rbx ; 
	cmovl ecx, edx; ~equals to a<b
	cmp eax, 10
	cmove r8d, edx ; ~equals to a==10

	AND ecx, r8d; result stored in ecx
jumping endp
end