

;The byte is the smallest addressable unit of memory in many computer architectures due 
;to the fact that it is used to encode a single character of text in computer memory;

;10000000  -> the first digit (1) is the sign bit in the 7th place (last bit), it is also the most significant bit
;as oppposed to rightmost 0 bit at the 0th place.

;INTEL cpus use Twos Complement method to encode negative numbers.
;the leftmost bit (msb) is the signed bit - 1 means positive, 0 means negative number
;in two's complement method 1 is 00000001 and -1 is 111111111.  why?

;Conversion to two's compelemnt (positive to negative): find the first 1 bit from the right and invert all the higher bits
;00000001 -> (signed bit is 0), bit 1 at location 0 is the first 1 bit from the right -> invert all the following -> 111111111

;Conversion from two's complement: find the first 1 bit from the right and invert all the higher bits
;111111111 -> bit 1 at location 0 is the first 1 bit from the right -> invert all the following -> 00000001


;in TWO'S compliment the first positive number is 1 0000 0001 (hex - represents 32 bits), and the first negative
;number is -1 represented by FFFF FFFF (hex - represents 32 bits), -2 is FFFF FFFE.
;NOTE: the decimal values these hex represent depend upon the data type through which
;the compiler interprets them. for example in an unsigned int (the msb is dedicated for represeting more positive
;numbers, and not negative numers) FFFF FFFF means 4294967295. in a signed int (default int, which uses the msb
;as a signed bit to represent negative numbers), FFFF FFFF equals to -1
;therefore, for signed ints, the largest positive number is 7FFFFFF (2147483647) and the largest negative
;is -2147483647

;shifting FFFF FFFF FFFF FFFF (-1, signed bit) right will yield 7FFF FFFF FFFF FFFF (2147483647) (not 0 (instead of 7), as expected)
;bts a 0 replaces the msb in the binary form, but 7FFF FFFF FFFF FFFF is its hex representation

;moving 14 (decimal) to al will only modify the first byte of or RAX register,
;e.g: if RAX=00007FFE43FE07A8 after mov rax, 14, it RAX will change to
;RAX = 00007FFE43FE070E  (0E replaces A8). Although  14 can be represented by 4 bits (1110, E in hex),
;becuase the smallest addressable unit of memory is 1 byte, the rest of 4 bits are padded with zero, therefore 0E (00001110)
;when returning back RAX to cpp, the compiler will read it as an int, meaning the ALL OF THE first 32 bits
;will be read -> 43FE070E  -> which of course yields different number then 0E (14)

;eax fills up the all of the 32 bits with a requested number and zeros out all of the higher 32 bits
;moving 10b (2 in decimal) fills up eax with (00000000 000000002 hex)

.code
complement proc
	;mov rax, 0
	mov eax, 7FFFFFFFh	
	ret
complement endp
end
