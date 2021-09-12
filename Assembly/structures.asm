
;padding is not mandatory, it simply matches the padding that cpp compiler does

;ASM doesn't care if vars are private.
;methods do not take any space!
MyStruct struct
	c db ? ;  char c - name of the variable, db (define byte), ? - uninitialized
	db 3 dup(0) ; padding -  3 duplicates of 0 which are "defined bytes"
	i dd 5 ; 5 is the default argument int i - define double word - 4 bytes 
	s dw ? ; short s - word is 16 bits (2 bytes)
	db 6 dup(0)
	d real8 ?; a double
MyStruct ends

;classes are the same as structs in cpp and assembly!
MyClass struct
 i dd ?
MyClass ends

Structoid struct
	i dd 5
Structoid ends


.code
structures proc
	structy Structoid {1}

	;mov [rcx].MyClass.i, 100 ; cpp passes first param in RCX. the passed arguemnt mussed also 
	;be defined in the assembly source fule (myClass is defined here)
	ret ; must be here, otherwise program doesn't work correctly
structures endp
end