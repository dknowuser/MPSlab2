$MOD52                          

;x1 - P0.0
;x2 - P0.1
;x3 - P0.2
;x4 - P0.3

;f = 0 - P1 = 000h
;f = 1 - P1 = 0FFh

CSEG
	mov DPTR, #table
	mov A, P0	
	movc A, @A + DPTR; Считываем значение по полученному адресу
	
	rrc A
	jc one
	; Если в ячейке хранится ноль
	mov P1, #00h
	jmp lp
one:
	; Если в ячейке хранится единица
	mov P1, #0FFh
lp:
	jmp lp

table:
	DB 0, 1, 1, 0, 0, 0, 0, 0, 0, 1, 1, 0, 0, 1, 1, 0
END
