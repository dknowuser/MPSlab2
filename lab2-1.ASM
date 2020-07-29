$MOD52                          

;x1 - P0.0
;x2 - P0.1
;x3 - P0.2
;x4 - P0.3

;f = 0 - P1 = 000h
;f = 1 - P1 = 0FFh

CSEG
ORG 00h
	;Разделяем входные булевы переменные в младшие разряды регистров R0-R3
	mov A, P0
	mov R0, A; Младший бит R0 - x1
	rr A
	mov R1, A; Младший бит R1 - x2
	rr A
	mov R2, A; Младший бит R2 - x3
	rr A
	mov R3, A; Младший бит R3 - x4
	;Вычисляем значение функции
	mov A, R2
	cpl A
	mov R2, A; Младший бит R2 - not x3
	
	mov A, R0
	xrl A, R1
	mov R0, A; Младший бит R0 - x1 xor x2
	
	mov A, R2
	orl A, R3
	mov R2, A; Младший бит R2 - not x3 or x4
	
	mov A, R0
	anl A, R2
	anl A, #01h; Оставляем только младший бит
	;mov R0, A; Младший бит R0 - (x1 xor x2)(not x3 or x4)
	
	;Выводим результат на порт P1
	clr C
	subb A, #01h
	jz one
	; Если значение функции оказалось равным 0
	mov P1, #00h
	jmp lp
one:
	; Если значение функции оказалось равным 1
	mov P1, #0FFh
lp:
	jmp lp

END
