# Operands to multiply
.data
a: .word 0xbad
b: .word 0xfeed

.text
main:   # Load data from memory
		la      t3, a
        lw      t3, 0(t3)
        la      t4, b
        lw      t4, 0(t4)
        
        # t6 will contain the result
        add		t6, x0, x0

        # Mask for 16x8=24 multiply
        ori		t0, x0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        slli	t0, t0, 8
        ori		t0, t0, 0xff
        
####################
# Start of your code
# set a counter to 0
slli s1 t4 24
srli s1 s1 24
srli t4 t4 8
add t1 t1 x0
addi t1 t1 0
addi t2 t2 2
addi t1 t1 1
mul t5 t3 s1
and t5 t5 t0
add t6 t6 t5
add s1 t4 x0
mul t5 t3 s1
and t5 t5 t0
slli t5 t5 8
add t6 t6 t5


# End of your code


# Use the code below for 16x8 multiplication
#   mul		<PROD>, <FACTOR1>, <FACTOR2>
#   and		<PROD>, <PROD>, t0




# End of your code
####################
		
finish: addi    a0, x0, 1
        addi    a1, t6, 0
        ecall # print integer ecall
        addi    a0, x0, 10
        ecall # terminate ecall