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

# save the 2 LSB of t4 in t2
slli t2 t4 24
srli t2 t2 24

# hold only the 2 MSB of original t4 in t4
srli t4 t4 8


# multiply t3 by t2 and save the result in t6
mul t5 t3 t2
and t5 t5 t0
add t6 t6 t5

#assign the 2 LSB of original t4 to t2
add t2 t4 x0

# multiply t3 by t2 and save the result in t6
mul t5 t3 t2
and t5 t5 t0
# shift the second product by 8 bits
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