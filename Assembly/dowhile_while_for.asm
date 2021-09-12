
.data

.code
looper proc

;************* i=0;  while (i<100) {i++;}   //while loop has an initial check
	mov eax, 100; represents i
	cmp eax, 100
	jge Finish; if eax>=100 , jump straight to Finish
	LoopHead: ; labels are always reached in the code unless theres something that prevents their access, like the line above
		inc eax
		cmp eax, 100
		jl LoopHead; when eax stops being lower than 100, the program will simply continue to the Finish label
	Finish:  ; the finished label 
		;ret

;************* i=0;  do { i++;} while (i<100);   //runs the body at least once
	mov eax, 0
	LoopHead2:
		inc eax
		cmp eax, 100
		jl LoopHead2
	Finish2:
		;ret


;************* regular assembly loop - (decrementing for loop) simplest 
	mov ecx, 3
	LoopHead3:
		;body
		dec	ecx
		jnz LoopHead3

;************* for loop c style (increasing, modifying an array)
	mov ecx, 0
	;LoopHead4:
looper endp
end