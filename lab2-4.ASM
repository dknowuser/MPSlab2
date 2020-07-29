$MOD52                          

;x1 - P0.0
;x2 - P0.1
;x3 - P0.2
;x4 - P0.3

;f = 0 - P1 = 000h
;f = 1 - P1 = 0FFh

ARGS EQU 20h

CSEG
ORG 00h
	;Считываем аргументы из порта P0 в РПД
	mov A, P0
	mov R0, #ARGS
	mov @R0, A
	
	mov C, ARGS.1; Младший бит регистра A содержит x1
	mov B.0, C; Младший бит регистра B содержит x2
	xrl A, B; Младший бит регистра A содержит (x1 xor x2)
	
	mov C, ARGS.3
	orl C, /ARGS.2; Бит переноса содержит (not x3 or x4)
	
	mov @R0, A; x1 = (x1 xor x2)
	anl C, ARGS.0
	jc one
	mov P1, #00h
	jmp lp
	
one:
	mov P1, #0FFh
	
lp:
	jmp lp

END
