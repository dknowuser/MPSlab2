$MOD52                          

;x1 - P0.0
;x2 - P0.1
;x3 - P0.2
;x4 - P0.3

;f = 0 - P1 = 000h
;f = 1 - P1 = 0FFh

CSEG
ORG 00h
	mov A, P0
	rrc A; Бит переноса содержит x1
	jc x1_1
	rrc A; Бит переноса содержит x2
	jc x1_0_x2_1_or_x1_1_x2_0
	mov P1, #00h
	jmp lp

x1_0_x2_1_or_x1_1_x2_0:
	rrc A; Бит переноса содержит x3
	jc x3_1
	mov P1, 0FFh
	jmp lp
	
x1_1:
	rrc A; Бит переноса содержит x2
	jnc x1_0_x2_1_or_x1_1_x2_0
	mov P1, 00h
	jmp lp
	
x3_1:
	rrc A; Бит переноса содержит x4
	jc x4_1
	mov P1, #00h
	jmp lp
	
x4_1:
	mov P1, 0FFh
	
lp:
	jmp lp

END
